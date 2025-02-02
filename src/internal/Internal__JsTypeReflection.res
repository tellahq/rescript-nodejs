/*
 * Note that the *third* definition of this function is
 * strictly necessary because the second one assumes
 * the raw function is already in scope, even in other
 * modules where it is not defined.
 */
%%raw(`
function instanceOfClass(instance, _class) {
  try {
    return (instance instanceof _class);
  } catch {
    return false;
  }
}
`)

@val external instanceOfClass: ('a, 'b) => bool = "instanceOfClass"

@ocaml.doc("
 * `intanceOfClass` wraps the `instanceof` operator in a function.
 * It returns `true` whe `~instance` is an instance of `~class_`.
 *
 * Normally the operator will throw a `TypeError` exception if the
 * class constructor operand is not actually a constructor function.
 *
 * This wrapper function will catch such errors and return false if
 * they occur.
 ")
let instanceOfClass = (~instance, ~class_) => instanceOfClass(instance, class_)

@ocaml.doc("
 * `functionLength` returns the arity of a JS function.
 *
 * 'functionLength' Will not work properly on JS functions which
 * use \"default arguments\" or \"rest parameters\":
 * https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Function/length
 *
 * Therefore, this function must be used with caution.
 ")
@get
external functionLength: ('a => 'b) => int = "length"

@ocaml.doc("
 * `prototype` returns `Some` 'prototype' property of a JS
 * data type, if it is defined. If the prototype is not defined,
 * returns `None`.
 ")
@get
external prototype: 'a => option<{..}> = "prototype"

@ocaml.doc("
 * `constructor` gets the class constructor function of a given JS
 * object. This type is left polymorphic and abstract since the function
 * type signature and arity cannot be statically determined.
 ")
@get
external constructor: 'a => option<'b> = "constructor"

@ocaml.doc("
 * `constructorName` returns the name of the constructor function
 * of a given JS object. The constructor is the equivalent of a \"class\"
 * in JS, so this will (usually) identify the specific class type.
 ")
@get
@scope("constructor")
external constructorName: 'a => string = "name"

@ocaml.doc("
 * `objectToString` returns the value of the internal `[@@toStringTag]`
 * property on a given JS object (or located somewhere on its prototype
 * chain). This is commonly used to identify the base class when a class
 * has been extended by a sub-class.
 *
 * Note, this will fail for `null` and `undefined` values, which will
 * raise a exception of type `ReferenceError`, since the `[@@toStringTag]`
 * property is normally unavailable for those types.
 ")
@val
@scope(("Object", "prototype", "toString"))
external objectToString: 'a => string = "call"

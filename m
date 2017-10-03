Received: from eggs.gnu.org ([2001:4830:134:3::10]:37223)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dzUb3-0001uB-OS
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 17:19:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dzUb1-0000Ll-NS
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 17:19:21 -0400
References: <20170916185123.29255-1-mreitz@redhat.com>
	<20170916185123.29255-7-mreitz@redhat.com>
	<87h8vhk71g.fsf@dusky.pond.sub.org>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <b9fa6dec-df95-8b98-d295-0bd2315a7494@redhat.com>
Date: Tue, 3 Oct 2017 23:19:06 +0200
MIME-Version: 1.0
In-Reply-To: <87h8vhk71g.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="PNJWalsH85IPBMVd1jid7ruHIgtjqs7dP"
Subject: Re: [Qemu-devel] [PATCH v5 6/6] tests: Add check-qobject for
 equality tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PNJWalsH85IPBMVd1jid7ruHIgtjqs7dP
From: Max Reitz <mreitz@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 qemu-devel@nongnu.org
Message-ID: <b9fa6dec-df95-8b98-d295-0bd2315a7494@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 6/6] tests: Add check-qobject for equality
 tests
References: <20170916185123.29255-1-mreitz@redhat.com>
 <20170916185123.29255-7-mreitz@redhat.com>
 <87h8vhk71g.fsf@dusky.pond.sub.org>
In-Reply-To: <87h8vhk71g.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-10-02 15:34, Markus Armbruster wrote:
> Max Reitz <mreitz@redhat.com> writes:
>=20
>> Add a new test file (check-qobject.c) for unit tests that concern
>> QObjects as a whole.
>>
>> Its only purpose for now is to test the qobject_is_equal() function.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  tests/Makefile.include |   4 +-
>>  tests/check-qobject.c  | 315 ++++++++++++++++++++++++++++++++++++++++=
+++++++++
>>  2 files changed, 318 insertions(+), 1 deletion(-)
>>  create mode 100644 tests/check-qobject.c
>>
>> diff --git a/tests/Makefile.include b/tests/Makefile.include
>> index fae5715e9c..40b8b4e98f 100644
>> --- a/tests/Makefile.include
>> +++ b/tests/Makefile.include
>> @@ -41,6 +41,7 @@ check-unit-y +=3D tests/check-qlist$(EXESUF)
>>  gcov-files-check-qlist-y =3D qobject/qlist.c
>>  check-unit-y +=3D tests/check-qnull$(EXESUF)
>>  gcov-files-check-qnull-y =3D qobject/qnull.c
>> +check-unit-y +=3D tests/check-qobject$(EXESUF)
>>  check-unit-y +=3D tests/check-qjson$(EXESUF)
>>  gcov-files-check-qjson-y =3D qobject/qjson.c
>>  check-unit-y +=3D tests/check-qlit$(EXESUF)
>> @@ -542,7 +543,7 @@ GENERATED_FILES +=3D tests/test-qapi-types.h tests=
/test-qapi-visit.h \
>>  	tests/test-qmp-introspect.h
>> =20
>>  test-obj-y =3D tests/check-qnum.o tests/check-qstring.o tests/check-q=
dict.o \
>> -	tests/check-qlist.o tests/check-qnull.o \
>> +	tests/check-qlist.o tests/check-qnull.o tests/check-qobject.o \
>>  	tests/check-qjson.o tests/check-qlit.o \
>>  	tests/test-coroutine.o tests/test-string-output-visitor.o \
>>  	tests/test-string-input-visitor.o tests/test-qobject-output-visitor.=
o \
>> @@ -576,6 +577,7 @@ tests/check-qstring$(EXESUF): tests/check-qstring.=
o $(test-util-obj-y)
>>  tests/check-qdict$(EXESUF): tests/check-qdict.o $(test-util-obj-y)
>>  tests/check-qlist$(EXESUF): tests/check-qlist.o $(test-util-obj-y)
>>  tests/check-qnull$(EXESUF): tests/check-qnull.o $(test-util-obj-y)
>> +tests/check-qobject$(EXESUF): tests/check-qobject.o $(test-util-obj-y=
)
>>  tests/check-qjson$(EXESUF): tests/check-qjson.o $(test-util-obj-y)
>>  tests/check-qlit$(EXESUF): tests/check-qlit.o $(test-util-obj-y)
>>  tests/check-qom-interface$(EXESUF): tests/check-qom-interface.o $(tes=
t-qom-obj-y)
>> diff --git a/tests/check-qobject.c b/tests/check-qobject.c
>> new file mode 100644
>> index 0000000000..8f1b5550c2
>> --- /dev/null
>> +++ b/tests/check-qobject.c
>> @@ -0,0 +1,315 @@
>> +/*
>> + * Generic QObject unit-tests.
>> + *
>> + * Copyright (C) 2017 Red Hat Inc.
>> + *
>> + * This work is licensed under the terms of the GNU LGPL, version 2.1=
 or later.
>> + * See the COPYING.LIB file in the top-level directory.
>> + */
>> +#include "qemu/osdep.h"
>> +
>> +#include "qapi/qmp/types.h"
>> +#include "qemu-common.h"
>> +
>> +#include <math.h>
>> +
>> +/* Marks the end of the test_equality() argument list.
>> + * We cannot use NULL there because that is a valid argument. */
>> +static QObject _test_equality_end_of_arguments;
>=20
> Reserved identifier.  Please scratch the leading underscore.

OK.

> Also: ugh!  I would've tried arrays just to avoid this ugliness.  But
> since you've written it, and it works...

*cough*

>> +
>> +/**
>> + * Test whether all variadic QObject *arguments are equal (@expected
>> + * is true) or whether they are all not equal (@expected is false).
>> + * Every QObject is tested to be equal to itself (to test
>> + * reflexivity), all tests are done both ways (to test symmetry), and=

>> + * transitivity is not assumed but checked (each object is compared t=
o
>> + * every other one).
>> + *
>> + * Note that qobject_is_equal() is not really an equivalence relation=
,
>> + * so this function may not be used for all objects (reflexivity is
>> + * not guaranteed, e.g. in the case of a QNum containing NaN).
>> + */
>> +static void do_test_equality(bool expected, ...)
>> +{
>> +    va_list ap_count, ap_extract;
>> +    QObject **args;
>> +    int arg_count =3D 0;
>> +    int i, j;
>> +
>> +    va_start(ap_count, expected);
>> +    va_copy(ap_extract, ap_count);
>> +    while (va_arg(ap_count, QObject *) !=3D &_test_equality_end_of_ar=
guments) {
>> +        arg_count++;
>> +    }
>> +    va_end(ap_count);
>> +
>> +    args =3D g_new(QObject *, arg_count);
>> +    for (i =3D 0; i < arg_count; i++) {
>> +        args[i] =3D va_arg(ap_extract, QObject *);
>> +    }
>> +    va_end(ap_extract);
>> +
>> +    for (i =3D 0; i < arg_count; i++) {
>> +        g_assert(qobject_is_equal(args[i], args[i]) =3D=3D true);
>> +
>> +        for (j =3D i + 1; j < arg_count; j++) {
>> +            g_assert(qobject_is_equal(args[i], args[j]) =3D=3D expect=
ed);
>> +        }
>> +    }
>> +}
>> +
>> +#define test_equality(expected, ...) \
>> +    do_test_equality(expected, __VA_ARGS__, &_test_equality_end_of_ar=
guments)
>> +
>> +static void do_free_all(int _, ...)
>> +{
>> +    va_list ap;
>> +    QObject *obj;
>> +
>> +    va_start(ap, _);
>> +    while ((obj =3D va_arg(ap, QObject *)) !=3D NULL) {
>> +        qobject_decref(obj);
>> +    }
>> +    va_end(ap);
>> +}
>> +
>> +#define free_all(...) \
>> +    do_free_all(0, __VA_ARGS__, NULL)
>> +
>> +static void qobject_is_equal_null_test(void)
>> +{
>> +    test_equality(false, qnull(), NULL);
>> +}
>> +
>> +static void qobject_is_equal_num_test(void)
>> +{
>> +    QNum *u0, *i0, *d0, *dnan, *um42, *im42, *dm42;
>> +    QString *s0, *s_empty;
>> +    QBool *bfalse;
>> +
>> +    u0 =3D qnum_from_uint(0u);
>> +    i0 =3D qnum_from_int(0);
>> +    d0 =3D qnum_from_double(0.0);
>> +    dnan =3D qnum_from_double(NAN);
>> +    um42 =3D qnum_from_uint((uint64_t)-42);
>> +    im42 =3D qnum_from_int(-42);
>> +    dm42 =3D qnum_from_double(-42.0);
>> +
>> +    s0 =3D qstring_from_str("0");
>> +    s_empty =3D qstring_new();
>> +    bfalse =3D qbool_from_bool(false);
>> +
>> +    /* Integers representing a mathematically equal number should
>> +     * compare equal */
>> +    test_equality(true, u0, i0);
>> +    /* Doubles, however, are always unequal to integers */
>> +    test_equality(false, u0, d0);
>> +    test_equality(false, i0, d0);
>=20
> Would the following be more legible?
>=20
>        /* Integers representing a mathematically equal number should
>         * compare equal */
>        check_equal(u0, i0);
>        /* Doubles, however, are always unequal to integers */
>        check_unequal(u0, d0);
>        check_unequal(i0, d0);
>=20
> (with the obvious macros check_equal() and check_unequal())

Sounds good, yes.

>> +    /* No automatic type conversion */
>> +    test_equality(false, u0, s0, s_empty, bfalse, qnull(), NULL);
>> +    test_equality(false, i0, s0, s_empty, bfalse, qnull(), NULL);
>> +    test_equality(false, d0, s0, s_empty, bfalse, qnull(), NULL);
>=20
> No "num" in this part.  No big deal, but perhaps you'd like to put it
> into a qobject_is_equal_mixed_test().

Hm? u0, i0, and d0 are QNums.  Adding a mixed test for type conversion
still sounds like a good idea, though.

>> +
>> +    /* Do not assume any object is equal to itself -- note however
>> +     * that NaN cannot occur in a JSON object anyway. */
>> +    g_assert(qobject_is_equal(QOBJECT(dnan), QOBJECT(dnan)) =3D=3D fa=
lse);
>> +
>> +    /* No unsigned overflow */
>> +    test_equality(false, um42, im42);
>> +    test_equality(false, um42, dm42);
>> +    g_assert(qobject_is_equal(QOBJECT(im42), QOBJECT(dm42)) =3D=3D fa=
lse);
>> +    test_equality(false, im42, dm42);
>> +
>> +
>=20
> Scratch one blank line.

Will do.

>> +    free_all(u0, i0, d0, dnan, um42, im42, dm42, s0, s_empty, bfalse)=
;
>> +}
>> +
>> +static void qobject_is_equal_bool_test(void)
>> +{
>> +    QBool *btrue_0, *btrue_1, *bfalse_0, *bfalse_1;
>> +
>> +    /* Automatic type conversion is tested in the QNum test */
>> +
>> +    btrue_0 =3D qbool_from_bool(true);
>> +    btrue_1 =3D qbool_from_bool(true);
>> +    bfalse_0 =3D qbool_from_bool(false);
>> +    bfalse_1 =3D qbool_from_bool(false);
>> +
>> +    test_equality(true, btrue_0, btrue_1);
>> +    test_equality(true, bfalse_0, bfalse_1);
>> +    test_equality(false, btrue_0, bfalse_0);
>> +    test_equality(false, btrue_1, bfalse_1);
>=20
> The last one is kind of redundant.  Your choice.

Hmmm, yes. :-)

>> +
>> +    free_all(btrue_0, btrue_1, bfalse_0, bfalse_1);
>> +}
>> +
>> +static void qobject_is_equal_string_test(void)
>> +{
>> +    QString *str_base, *str_whitespace_0, *str_whitespace_1, *str_whi=
tespace_2;
>> +    QString *str_whitespace_3, *str_case, *str_built;
>> +
>> +    str_base =3D qstring_from_str("foo");
>> +    str_whitespace_0 =3D qstring_from_str(" foo");
>> +    str_whitespace_1 =3D qstring_from_str("foo ");
>> +    str_whitespace_2 =3D qstring_from_str("foo\b");
>> +    str_whitespace_3 =3D qstring_from_str("fooo\b");
>> +    str_case =3D qstring_from_str("Foo");
>> +
>> +    /* Should yield "foo" */
>> +    str_built =3D qstring_from_substr("form", 0, 1);
>> +    qstring_append_chr(str_built, 'o');
>> +
>> +    test_equality(false, str_base, str_whitespace_0, str_whitespace_1=
,
>> +                         str_whitespace_2, str_whitespace_3, str_case=
);
>> +
>> +    test_equality(true, str_base, str_built);
>> +
>> +    free_all(str_base, str_whitespace_0, str_whitespace_1, str_whites=
pace_2,
>> +             str_whitespace_3, str_case, str_built);
>> +}
>> +
>> +static void qobject_is_equal_list_test(void)
>> +{
>> +    QList *list_0, *list_1, *list_cloned;
>> +    QList *list_reordered, *list_longer, *list_shorter;
>> +
>> +    list_0 =3D qlist_new();
>> +    list_1 =3D qlist_new();
>> +    list_reordered =3D qlist_new();
>> +    list_longer =3D qlist_new();
>> +    list_shorter =3D qlist_new();
>> +
>> +    qlist_append_int(list_0, 1);
>> +    qlist_append_int(list_0, 2);
>> +    qlist_append_int(list_0, 3);
>> +
>> +    qlist_append_int(list_1, 1);
>> +    qlist_append_int(list_1, 2);
>> +    qlist_append_int(list_1, 3);
>> +
>> +    qlist_append_int(list_reordered, 1);
>> +    qlist_append_int(list_reordered, 3);
>> +    qlist_append_int(list_reordered, 2);
>> +
>> +    qlist_append_int(list_longer, 1);
>> +    qlist_append_int(list_longer, 2);
>> +    qlist_append_int(list_longer, 3);
>> +    qlist_append_null(list_longer);
>> +
>> +    qlist_append_int(list_shorter, 1);
>> +    qlist_append_int(list_shorter, 2);
>> +
>> +    list_cloned =3D qlist_copy(list_0);
>> +
>> +    test_equality(true, list_0, list_1, list_cloned);
>> +    test_equality(false, list_0, list_reordered, list_longer, list_sh=
orter);
>> +
>> +    /* With a NaN in it, the list should no longer compare equal to
>> +     * itself */
>> +    qlist_append(list_0, qnum_from_double(NAN));
>> +    g_assert(qobject_is_equal(QOBJECT(list_0), QOBJECT(list_0)) =3D=3D=
 false);
>> +
>> +    free_all(list_0, list_1, list_cloned, list_reordered, list_longer=
, list_shorter);
>> +}
>> +
>> +static void qobject_is_equal_dict_test(void)
>> +{
>> +    Error *local_err =3D NULL;
>> +    QDict *dict_0, *dict_1, *dict_cloned;
>> +    QDict *dict_different_key, *dict_different_value, *dict_different=
_null_key;
>> +    QDict *dict_longer, *dict_shorter, *dict_nested;
>> +    QDict *dict_crumpled;
>> +
>> +    dict_0 =3D qdict_new();
>> +    dict_1 =3D qdict_new();
>> +    dict_different_key =3D qdict_new();
>> +    dict_different_value =3D qdict_new();
>> +    dict_different_null_key =3D qdict_new();
>> +    dict_longer =3D qdict_new();
>> +    dict_shorter =3D qdict_new();
>> +    dict_nested =3D qdict_new();
>> +
>> +    qdict_put_int(dict_0, "f.o", 1);
>> +    qdict_put_int(dict_0, "bar", 2);
>> +    qdict_put_int(dict_0, "baz", 3);
>> +    qdict_put_null(dict_0, "null");
>> +
>> +    qdict_put_int(dict_1, "f.o", 1);
>> +    qdict_put_int(dict_1, "bar", 2);
>> +    qdict_put_int(dict_1, "baz", 3);
>> +    qdict_put_null(dict_1, "null");
>> +
>> +    qdict_put_int(dict_different_key, "F.o", 1);
>> +    qdict_put_int(dict_different_key, "bar", 2);
>> +    qdict_put_int(dict_different_key, "baz", 3);
>> +    qdict_put_null(dict_different_key, "null");
>> +
>> +    qdict_put_int(dict_different_value, "f.o", 42);
>> +    qdict_put_int(dict_different_value, "bar", 2);
>> +    qdict_put_int(dict_different_value, "baz", 3);
>> +    qdict_put_null(dict_different_value, "null");
>> +
>> +    qdict_put_int(dict_different_null_key, "f.o", 1);
>> +    qdict_put_int(dict_different_null_key, "bar", 2);
>> +    qdict_put_int(dict_different_null_key, "baz", 3);
>> +    qdict_put_null(dict_different_null_key, "none");
>> +
>> +    qdict_put_int(dict_longer, "f.o", 1);
>> +    qdict_put_int(dict_longer, "bar", 2);
>> +    qdict_put_int(dict_longer, "baz", 3);
>> +    qdict_put_int(dict_longer, "xyz", 4);
>> +    qdict_put_null(dict_longer, "null");
>> +
>> +    qdict_put_int(dict_shorter, "f.o", 1);
>> +    qdict_put_int(dict_shorter, "bar", 2);
>> +    qdict_put_int(dict_shorter, "baz", 3);
>> +
>> +    qdict_put(dict_nested, "f", qdict_new());
>> +    qdict_put_int(qdict_get_qdict(dict_nested, "f"), "o", 1);
>> +    qdict_put_int(dict_nested, "bar", 2);
>> +    qdict_put_int(dict_nested, "baz", 3);
>> +    qdict_put_null(dict_nested, "null");
>> +
>> +    dict_cloned =3D qdict_clone_shallow(dict_0);
>> +
>> +    test_equality(true, dict_0, dict_1, dict_cloned);
>> +    test_equality(false, dict_0, dict_different_key, dict_different_v=
alue,
>> +                         dict_different_null_key, dict_longer, dict_s=
horter,
>> +                         dict_nested);
>> +
>> +    dict_crumpled =3D qobject_to_qdict(qdict_crumple(dict_1, &local_e=
rr));
>> +    g_assert(!local_err);
>> +    test_equality(true, dict_crumpled, dict_nested);
>> +
>> +    qdict_flatten(dict_nested);
>> +    test_equality(true, dict_0, dict_nested);
>> +
>> +    /* Containing an NaN value will make this dict compare unequal to=

>> +     * itself */
>> +    qdict_put(dict_0, "NaN", qnum_from_double(NAN));
>> +    g_assert(qobject_is_equal(QOBJECT(dict_0), QOBJECT(dict_0)) =3D=3D=
 false);
>> +
>> +    free_all(dict_0, dict_1, dict_cloned, dict_different_key,
>> +             dict_different_value, dict_different_null_key, dict_long=
er,
>> +             dict_shorter, dict_nested, dict_crumpled);
>> +}
>> +
>> +int main(int argc, char **argv)
>> +{
>> +    g_test_init(&argc, &argv, NULL);
>> +
>> +    g_test_add_func("/public/qobject_is_equal_null",
>> +                    qobject_is_equal_null_test);
>> +    g_test_add_func("/public/qobject_is_equal_num", qobject_is_equal_=
num_test);
>> +    g_test_add_func("/public/qobject_is_equal_bool",
>> +                    qobject_is_equal_bool_test);
>> +    g_test_add_func("/public/qobject_is_equal_string",
>> +                    qobject_is_equal_string_test);
>> +    g_test_add_func("/public/qobject_is_equal_list",
>> +                    qobject_is_equal_list_test);
>> +    g_test_add_func("/public/qobject_is_equal_dict",
>> +                    qobject_is_equal_dict_test);
>> +
>> +    return g_test_run();
>> +}
>=20
> Quite thorough :)
>=20
> With at least the reserved identifier renamed and the extra blank line
> scratched:
> Reviewed-by: Markus Armbruster <armbru@redhat.com>

Thanks for your reviews!

Max


--PNJWalsH85IPBMVd1jid7ruHIgtjqs7dP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlnT/soSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A6ygH/0lsvbIMUKvgA0tLGS8F/JAmm1TeOuyg
UMg7kqOmMbt/ywM6xBAuP0iKOubhneh8RG6FwGeeBOqeD93posuDnTTaarx/GzAv
ghtP6B+qQFzgwXN9yOZLOxGjcZmlXuddhiew/ebiUOZsVmL1fqPZDZvIf5SmOCIZ
YtEWR4MvfF2YqRHi1d3xH/Z8Kjc+L8STKmzHRrmfCMWW6o3QH5a1R9GK6Ujiz19f
OQ7B80wjbQM3B0F38NXl0hEyi1fP9m138bj0toNLj5YcPF/E5TyA4r5K1AYdTuVM
eSczznKKKF7o0cF3MMETlLwO6fPj9GjRXUT4O8JVDXFhk6I4yhrob+g=
=4Ps6
-----END PGP SIGNATURE-----

--PNJWalsH85IPBMVd1jid7ruHIgtjqs7dP--

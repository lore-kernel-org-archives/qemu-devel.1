Received: from eggs.gnu.org ([2001:4830:134:3::10]:59626)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gVabS-00049s-4Q
	for qemu-devel@nongnu.org; Sat, 08 Dec 2018 06:16:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gVabO-0003sD-Vj
	for qemu-devel@nongnu.org; Sat, 08 Dec 2018 06:16:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35910)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gVabO-0003s5-Nc
	for qemu-devel@nongnu.org; Sat, 08 Dec 2018 06:16:54 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Sat,  8 Dec 2018 15:15:44 +0400
Message-Id: <20181208111606.8505-6-marcandre.lureau@redhat.com>
In-Reply-To: <20181208111606.8505-1-marcandre.lureau@redhat.com>
References: <20181208111606.8505-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-4.0 v7 05/27] tests: print enum type
 members more like object type members
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

Commit 93bda4dd461 changed the internal representation of enum type
members from str to QAPISchemaMember, but we still print only a
string.  Has been good enough, as the name is the member's only
attribute of interest, but that's about to change.  To prepare, print
them more like object type members.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 tests/qapi-schema/comments.out           | 14 ++++++-
 tests/qapi-schema/doc-bad-section.out    | 13 +++++-
 tests/qapi-schema/doc-good.out           | 17 ++++++--
 tests/qapi-schema/empty.out              |  9 ++++-
 tests/qapi-schema/event-case.out         |  9 ++++-
 tests/qapi-schema/ident-with-escape.out  |  9 ++++-
 tests/qapi-schema/include-relpath.out    | 14 ++++++-
 tests/qapi-schema/include-repetition.out | 14 ++++++-
 tests/qapi-schema/include-simple.out     | 14 ++++++-
 tests/qapi-schema/indented-expr.out      |  9 ++++-
 tests/qapi-schema/qapi-schema-test.out   | 50 +++++++++++++++++++-----
 tests/qapi-schema/test-qapi.py           |  4 +-
 12 files changed, 149 insertions(+), 27 deletions(-)

diff --git a/tests/qapi-schema/comments.out b/tests/qapi-schema/comments.=
out
index 8d2f1ce8a2..d1abc4b5a1 100644
--- a/tests/qapi-schema/comments.out
+++ b/tests/qapi-schema/comments.out
@@ -1,5 +1,15 @@
 object q_empty
-enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbool=
']
+enum QType
     prefix QTYPE
+    member none
+    member qnull
+    member qnum
+    member qstring
+    member qdict
+    member qlist
+    member qbool
 module comments.json
-enum Status ['good', 'bad', 'ugly']
+enum Status
+    member good
+    member bad
+    member ugly
diff --git a/tests/qapi-schema/doc-bad-section.out b/tests/qapi-schema/do=
c-bad-section.out
index cd28721568..db8014eed0 100644
--- a/tests/qapi-schema/doc-bad-section.out
+++ b/tests/qapi-schema/doc-bad-section.out
@@ -1,8 +1,17 @@
 object q_empty
-enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbool=
']
+enum QType
     prefix QTYPE
+    member none
+    member qnull
+    member qnum
+    member qstring
+    member qdict
+    member qlist
+    member qbool
 module doc-bad-section.json
-enum Enum ['one', 'two']
+enum Enum
+    member one
+    member two
 doc symbol=3DEnum
     body=3D
 =3D=3D Produces *invalid* texinfo
diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-good.=
out
index 35f3f1164c..c2fc5c774a 100644
--- a/tests/qapi-schema/doc-good.out
+++ b/tests/qapi-schema/doc-good.out
@@ -1,8 +1,17 @@
 object q_empty
-enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbool=
']
+enum QType
     prefix QTYPE
+    member none
+    member qnull
+    member qnum
+    member qstring
+    member qdict
+    member qlist
+    member qbool
 module doc-good.json
-enum Enum ['one', 'two']
+enum Enum
+    member one
+    member two
     if ['defined(IFCOND)']
 object Base
     member base1: Enum optional=3DFalse
@@ -18,7 +27,9 @@ object q_obj_Variant1-wrapper
     member data: Variant1 optional=3DFalse
 object q_obj_Variant2-wrapper
     member data: Variant2 optional=3DFalse
-enum SugaredUnionKind ['one', 'two']
+enum SugaredUnionKind
+    member one
+    member two
 object SugaredUnion
     member type: SugaredUnionKind optional=3DFalse
     tag type
diff --git a/tests/qapi-schema/empty.out b/tests/qapi-schema/empty.out
index 0ec234eec4..5483cb7bc6 100644
--- a/tests/qapi-schema/empty.out
+++ b/tests/qapi-schema/empty.out
@@ -1,3 +1,10 @@
 object q_empty
-enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbool=
']
+enum QType
     prefix QTYPE
+    member none
+    member qnull
+    member qnum
+    member qstring
+    member qdict
+    member qlist
+    member qbool
diff --git a/tests/qapi-schema/event-case.out b/tests/qapi-schema/event-c=
ase.out
index 88c0964917..f69d4ffe4e 100644
--- a/tests/qapi-schema/event-case.out
+++ b/tests/qapi-schema/event-case.out
@@ -1,6 +1,13 @@
 object q_empty
-enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbool=
']
+enum QType
     prefix QTYPE
+    member none
+    member qnull
+    member qnum
+    member qstring
+    member qdict
+    member qlist
+    member qbool
 module event-case.json
 event oops None
    boxed=3DFalse
diff --git a/tests/qapi-schema/ident-with-escape.out b/tests/qapi-schema/=
ident-with-escape.out
index 24c976f473..7f891f7e90 100644
--- a/tests/qapi-schema/ident-with-escape.out
+++ b/tests/qapi-schema/ident-with-escape.out
@@ -1,6 +1,13 @@
 object q_empty
-enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbool=
']
+enum QType
     prefix QTYPE
+    member none
+    member qnull
+    member qnum
+    member qstring
+    member qdict
+    member qlist
+    member qbool
 module ident-with-escape.json
 object q_obj_fooA-arg
     member bar1: str optional=3DFalse
diff --git a/tests/qapi-schema/include-relpath.out b/tests/qapi-schema/in=
clude-relpath.out
index ebbabd7a18..783ccfc855 100644
--- a/tests/qapi-schema/include-relpath.out
+++ b/tests/qapi-schema/include-relpath.out
@@ -1,9 +1,19 @@
 object q_empty
-enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbool=
']
+enum QType
     prefix QTYPE
+    member none
+    member qnull
+    member qnum
+    member qstring
+    member qdict
+    member qlist
+    member qbool
 module include-relpath.json
 include include/relpath.json
 module include/relpath.json
 include include-relpath-sub.json
 module include-relpath-sub.json
-enum Status ['good', 'bad', 'ugly']
+enum Status
+    member good
+    member bad
+    member ugly
diff --git a/tests/qapi-schema/include-repetition.out b/tests/qapi-schema=
/include-repetition.out
index 7235e055bc..d45977ee56 100644
--- a/tests/qapi-schema/include-repetition.out
+++ b/tests/qapi-schema/include-repetition.out
@@ -1,10 +1,20 @@
 object q_empty
-enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbool=
']
+enum QType
     prefix QTYPE
+    member none
+    member qnull
+    member qnum
+    member qstring
+    member qdict
+    member qlist
+    member qbool
 module include-repetition.json
 include comments.json
 module comments.json
-enum Status ['good', 'bad', 'ugly']
+enum Status
+    member good
+    member bad
+    member ugly
 module include-repetition.json
 include include-repetition-sub.json
 module include-repetition-sub.json
diff --git a/tests/qapi-schema/include-simple.out b/tests/qapi-schema/inc=
lude-simple.out
index 006f723eeb..1afe20802a 100644
--- a/tests/qapi-schema/include-simple.out
+++ b/tests/qapi-schema/include-simple.out
@@ -1,7 +1,17 @@
 object q_empty
-enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbool=
']
+enum QType
     prefix QTYPE
+    member none
+    member qnull
+    member qnum
+    member qstring
+    member qdict
+    member qlist
+    member qbool
 module include-simple.json
 include include-simple-sub.json
 module include-simple-sub.json
-enum Status ['good', 'bad', 'ugly']
+enum Status
+    member good
+    member bad
+    member ugly
diff --git a/tests/qapi-schema/indented-expr.out b/tests/qapi-schema/inde=
nted-expr.out
index bd8a48630e..c0cf3243f3 100644
--- a/tests/qapi-schema/indented-expr.out
+++ b/tests/qapi-schema/indented-expr.out
@@ -1,6 +1,13 @@
 object q_empty
-enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbool=
']
+enum QType
     prefix QTYPE
+    member none
+    member qnull
+    member qnum
+    member qstring
+    member qdict
+    member qlist
+    member qbool
 module indented-expr.json
 command eins None -> None
    gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse preconfi=
g=3DFalse
diff --git a/tests/qapi-schema/qapi-schema-test.out b/tests/qapi-schema/q=
api-schema-test.out
index 218ac7d556..39cd2b0fc3 100644
--- a/tests/qapi-schema/qapi-schema-test.out
+++ b/tests/qapi-schema/qapi-schema-test.out
@@ -1,6 +1,13 @@
 object q_empty
-enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbool=
']
+enum QType
     prefix QTYPE
+    member none
+    member qnull
+    member qnum
+    member qstring
+    member qdict
+    member qlist
+    member qbool
 module qapi-schema-test.json
 object TestStruct
     member integer: int optional=3DFalse
@@ -11,19 +18,25 @@ object NestedEnumsOne
     member enum2: EnumOne optional=3DTrue
     member enum3: EnumOne optional=3DFalse
     member enum4: EnumOne optional=3DTrue
-enum MyEnum []
+enum MyEnum
 object Empty1
 object Empty2
     base Empty1
 command user_def_cmd0 Empty2 -> Empty2
    gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse preconfi=
g=3DFalse
-enum QEnumTwo ['value1', 'value2']
+enum QEnumTwo
     prefix QENUM_TWO
+    member value1
+    member value2
 object UserDefOne
     base UserDefZero
     member string: str optional=3DFalse
     member enum1: EnumOne optional=3DTrue
-enum EnumOne ['value1', 'value2', 'value3', 'value4']
+enum EnumOne
+    member value1
+    member value2
+    member value3
+    member value4
 object UserDefZero
     member integer: int optional=3DFalse
 object UserDefTwoDictDict
@@ -127,7 +140,21 @@ object q_obj_sizeList-wrapper
     member data: sizeList optional=3DFalse
 object q_obj_anyList-wrapper
     member data: anyList optional=3DFalse
-enum UserDefNativeListUnionKind ['integer', 's8', 's16', 's32', 's64', '=
u8', 'u16', 'u32', 'u64', 'number', 'boolean', 'string', 'sizes', 'any']
+enum UserDefNativeListUnionKind
+    member integer
+    member s8
+    member s16
+    member s32
+    member s64
+    member u8
+    member u16
+    member u32
+    member u64
+    member number
+    member boolean
+    member string
+    member sizes
+    member any
 object UserDefNativeListUnion
     member type: UserDefNativeListUnionKind optional=3DFalse
     tag type
@@ -204,7 +231,8 @@ event EVENT_E UserDefZero
    boxed=3DTrue
 event EVENT_F UserDefAlternate
    boxed=3DTrue
-enum __org.qemu_x-Enum ['__org.qemu_x-value']
+enum __org.qemu_x-Enum
+    member __org.qemu_x-value
 object __org.qemu_x-Base
     member __org.qemu_x-member1: __org.qemu_x-Enum optional=3DFalse
 object __org.qemu_x-Struct
@@ -213,7 +241,8 @@ object __org.qemu_x-Struct
     member wchar-t: int optional=3DTrue
 object q_obj_str-wrapper
     member data: str optional=3DFalse
-enum __org.qemu_x-Union1Kind ['__org.qemu_x-branch']
+enum __org.qemu_x-Union1Kind
+    member __org.qemu_x-branch
 object __org.qemu_x-Union1
     member type: __org.qemu_x-Union1Kind optional=3DFalse
     tag type
@@ -240,11 +269,14 @@ command __org.qemu_x-command q_obj___org.qemu_x-com=
mand-arg -> __org.qemu_x-Unio
 object TestIfStruct
     member foo: int optional=3DFalse
     if ['defined(TEST_IF_STRUCT)']
-enum TestIfEnum ['foo', 'bar']
+enum TestIfEnum
+    member foo
+    member bar
     if ['defined(TEST_IF_ENUM)']
 object q_obj_TestStruct-wrapper
     member data: TestStruct optional=3DFalse
-enum TestIfUnionKind ['foo']
+enum TestIfUnionKind
+    member foo
     if ['defined(TEST_IF_UNION) && defined(TEST_IF_STRUCT)']
 object TestIfUnion
     member type: TestIfUnionKind optional=3DFalse
diff --git a/tests/qapi-schema/test-qapi.py b/tests/qapi-schema/test-qapi=
.py
index 27f776693e..641a18f06d 100644
--- a/tests/qapi-schema/test-qapi.py
+++ b/tests/qapi-schema/test-qapi.py
@@ -24,9 +24,11 @@ class QAPISchemaTestVisitor(QAPISchemaVisitor):
         print('include %s' % name)
=20
     def visit_enum_type(self, name, info, ifcond, members, prefix):
-        print('enum %s %s' % (name, [m.name for m in members]))
+        print('enum %s' % name)
         if prefix:
             print('    prefix %s' % prefix)
+        for m in members:
+            print('    member %s' % m.name)
         self._print_if(ifcond)
=20
     def visit_object_type(self, name, info, ifcond, base, members, varia=
nts):
--=20
2.20.0.rc1

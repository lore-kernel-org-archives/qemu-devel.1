Received: from eggs.gnu.org ([2001:4830:134:3::10]:48529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eycIi-0005JY-Bo
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 07:53:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eycIg-0007yf-PS
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 07:53:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42064 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1eycIg-0007yT-KP
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 07:53:02 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2D53F406DE12
	for <qemu-devel@nongnu.org>; Wed, 21 Mar 2018 11:53:02 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 21 Mar 2018 12:51:40 +0100
Message-Id: <20180321115211.17937-19-marcandre.lureau@redhat.com>
In-Reply-To: <20180321115211.17937-1-marcandre.lureau@redhat.com>
References: <20180321115211.17937-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 18/49] tests: modify visit_enum_type() in
 test-qapi to print members
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Use a common self._print_members() to print enum members details.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 tests/qapi-schema/comments.out           | 14 ++++++-
 tests/qapi-schema/doc-bad-section.out    | 13 ++++++-
 tests/qapi-schema/doc-good.out           | 17 ++++++--
 tests/qapi-schema/empty.out              |  9 ++++-
 tests/qapi-schema/event-case.out         |  9 ++++-
 tests/qapi-schema/ident-with-escape.out  |  9 ++++-
 tests/qapi-schema/include-relpath.out    | 14 ++++++-
 tests/qapi-schema/include-repetition.out | 14 ++++++-
 tests/qapi-schema/include-simple.out     | 14 ++++++-
 tests/qapi-schema/indented-expr.out      |  9 ++++-
 tests/qapi-schema/qapi-schema-test.out   | 49 +++++++++++++++++++-----
 tests/qapi-schema/test-qapi.py           | 18 ++++++---
 12 files changed, 158 insertions(+), 31 deletions(-)

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
index 430b5a87db..3cd5c094aa 100644
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
 object Base
     member base1: Enum optional=3DFalse
 object Variant1
@@ -17,7 +26,9 @@ object q_obj_Variant1-wrapper
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
index ee3b34e623..41b90fb944 100644
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
index a79935e8c3..e2ede80310 100644
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
    gen=3DTrue success_response=3DTrue boxed=3DFalse
diff --git a/tests/qapi-schema/qapi-schema-test.out b/tests/qapi-schema/q=
api-schema-test.out
index 8fe9d7a3a8..fb89a798dd 100644
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
@@ -11,19 +18,24 @@ object NestedEnumsOne
     member enum2: EnumOne optional=3DTrue
     member enum3: EnumOne optional=3DFalse
     member enum4: EnumOne optional=3DTrue
-enum MyEnum []
+enum MyEnum
 object Empty1
 object Empty2
     base Empty1
 command user_def_cmd0 Empty2 -> Empty2
    gen=3DTrue success_response=3DTrue boxed=3DFalse
-enum QEnumTwo ['value1', 'value2']
+enum QEnumTwo
     prefix QENUM_TWO
+    member value1
+    member value2
 object UserDefOne
     base UserDefZero
     member string: str optional=3DFalse
     member enum1: EnumOne optional=3DTrue
-enum EnumOne ['value1', 'value2', 'value3']
+enum EnumOne
+    member value1
+    member value2
+    member value3
 object UserDefZero
     member integer: int optional=3DFalse
 object UserDefTwoDictDict
@@ -124,7 +136,21 @@ object q_obj_sizeList-wrapper
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
@@ -197,7 +223,8 @@ event EVENT_E UserDefZero
    boxed=3DTrue
 event EVENT_F UserDefAlternate
    boxed=3DTrue
-enum __org.qemu_x-Enum ['__org.qemu_x-value']
+enum __org.qemu_x-Enum
+    member __org.qemu_x-value
 object __org.qemu_x-Base
     member __org.qemu_x-member1: __org.qemu_x-Enum optional=3DFalse
 object __org.qemu_x-Struct
@@ -206,7 +233,8 @@ object __org.qemu_x-Struct
     member wchar-t: int optional=3DTrue
 object q_obj_str-wrapper
     member data: str optional=3DFalse
-enum __org.qemu_x-Union1Kind ['__org.qemu_x-branch']
+enum __org.qemu_x-Union1Kind
+    member __org.qemu_x-branch
 object __org.qemu_x-Union1
     member type: __org.qemu_x-Union1Kind optional=3DFalse
     tag type
@@ -233,11 +261,14 @@ command __org.qemu_x-command q_obj___org.qemu_x-com=
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
index 3623deae62..7e7b8f9f0f 100644
--- a/tests/qapi-schema/test-qapi.py
+++ b/tests/qapi-schema/test-qapi.py
@@ -12,7 +12,8 @@
=20
 from __future__ import print_function
 import sys
-from qapi.common import QAPIError, QAPISchema, QAPISchemaVisitor
+from qapi.common import QAPIError, QAPISchema, QAPISchemaVisitor, \
+    QAPISchemaObjectTypeMember
=20
=20
 class QAPISchemaTestVisitor(QAPISchemaVisitor):
@@ -24,18 +25,17 @@ class QAPISchemaTestVisitor(QAPISchemaVisitor):
         print('include %s' % name)
=20
     def visit_enum_type(self, name, info, ifcond, members, prefix):
-        print('enum %s %s' % (name, [m.name for m in members]))
+        print('enum %s' % name)
         if prefix:
             print('    prefix %s' % prefix)
+        self._print_members(members)
         self._print_if(ifcond)
=20
     def visit_object_type(self, name, info, ifcond, base, members, varia=
nts):
         print('object %s' % name)
         if base:
             print('    base %s' % base.name)
-        for m in members:
-            print('    member %s: %s optional=3D%s' % \
-                  (m.name, m.type.name, m.optional))
+        self._print_members(members)
         self._print_variants(variants)
         self._print_if(ifcond)
=20
@@ -57,6 +57,14 @@ class QAPISchemaTestVisitor(QAPISchemaVisitor):
         print('   boxed=3D%s' % boxed)
         self._print_if(ifcond)
=20
+    @staticmethod
+    def _print_members(members):
+        for m in members:
+            print('    member %s%s' % (
+                m.name,
+                ': %s optional=3D%s' % (m.type.name, m.optional)
+                if isinstance(m, QAPISchemaObjectTypeMember) else ''))
+
     @staticmethod
     def _print_variants(variants):
         if variants:
--=20
2.16.2.521.g9aa15f885a

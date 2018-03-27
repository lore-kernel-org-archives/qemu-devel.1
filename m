Received: from eggs.gnu.org ([2001:4830:134:3::10]:49316)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f0pcS-0007YO-AB
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 10:30:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f0pcL-0004yf-VR
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 10:30:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59404 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1f0pcL-0004yU-Ia
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 10:30:29 -0400
From: Eric Blake <eblake@redhat.com>
Date: Tue, 27 Mar 2018 09:30:08 -0500
Message-Id: <20180327143014.1767669-9-eblake@redhat.com>
In-Reply-To: <20180327143014.1767669-1-eblake@redhat.com>
References: <20180327143014.1767669-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 08/14] tests: let qapi-schema tests detect oob
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

From: Peter Xu <peterx@redhat.com>

The allow_oob parameter was passed in but not used in tests.  Now
reflect that in the tests, so we need to touch up other command testers
with that new change.

Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20180326063901.27425-6-peterx@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/qapi-schema/doc-good.out          |  4 ++--
 tests/qapi-schema/ident-with-escape.out |  2 +-
 tests/qapi-schema/indented-expr.out     |  4 ++--
 tests/qapi-schema/qapi-schema-test.out  | 18 +++++++++---------
 tests/qapi-schema/test-qapi.py          |  4 ++--
 5 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-good.=
out
index 430b5a87db3..63058b1590a 100644
--- a/tests/qapi-schema/doc-good.out
+++ b/tests/qapi-schema/doc-good.out
@@ -28,9 +28,9 @@ object q_obj_cmd-arg
     member arg2: str optional=3DTrue
     member arg3: bool optional=3DFalse
 command cmd q_obj_cmd-arg -> Object
-   gen=3DTrue success_response=3DTrue boxed=3DFalse
+   gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse
 command cmd-boxed Object -> None
-   gen=3DTrue success_response=3DTrue boxed=3DTrue
+   gen=3DTrue success_response=3DTrue boxed=3DTrue oob=3DFalse
 doc freeform
     body=3D
 =3D Section
diff --git a/tests/qapi-schema/ident-with-escape.out b/tests/qapi-schema/=
ident-with-escape.out
index ee3b34e623e..82213aa51dd 100644
--- a/tests/qapi-schema/ident-with-escape.out
+++ b/tests/qapi-schema/ident-with-escape.out
@@ -5,4 +5,4 @@ module ident-with-escape.json
 object q_obj_fooA-arg
     member bar1: str optional=3DFalse
 command fooA q_obj_fooA-arg -> None
-   gen=3DTrue success_response=3DTrue boxed=3DFalse
+   gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse
diff --git a/tests/qapi-schema/indented-expr.out b/tests/qapi-schema/inde=
nted-expr.out
index a79935e8c32..862678f8f4c 100644
--- a/tests/qapi-schema/indented-expr.out
+++ b/tests/qapi-schema/indented-expr.out
@@ -3,6 +3,6 @@ enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', =
'qlist', 'qbool']
     prefix QTYPE
 module indented-expr.json
 command eins None -> None
-   gen=3DTrue success_response=3DTrue boxed=3DFalse
+   gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse
 command zwei None -> None
-   gen=3DTrue success_response=3DTrue boxed=3DFalse
+   gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse
diff --git a/tests/qapi-schema/qapi-schema-test.out b/tests/qapi-schema/q=
api-schema-test.out
index 012e7fc06a5..4f43370017c 100644
--- a/tests/qapi-schema/qapi-schema-test.out
+++ b/tests/qapi-schema/qapi-schema-test.out
@@ -16,7 +16,7 @@ object Empty1
 object Empty2
     base Empty1
 command user_def_cmd0 Empty2 -> Empty2
-   gen=3DTrue success_response=3DTrue boxed=3DFalse
+   gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse
 enum QEnumTwo ['value1', 'value2']
     prefix QENUM_TWO
 object UserDefOne
@@ -143,29 +143,29 @@ object UserDefNativeListUnion
     case sizes: q_obj_sizeList-wrapper
     case any: q_obj_anyList-wrapper
 command user_def_cmd None -> None
-   gen=3DTrue success_response=3DTrue boxed=3DFalse
+   gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse
 object q_obj_user_def_cmd1-arg
     member ud1a: UserDefOne optional=3DFalse
 command user_def_cmd1 q_obj_user_def_cmd1-arg -> None
-   gen=3DTrue success_response=3DTrue boxed=3DFalse
+   gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse
 object q_obj_user_def_cmd2-arg
     member ud1a: UserDefOne optional=3DFalse
     member ud1b: UserDefOne optional=3DTrue
 command user_def_cmd2 q_obj_user_def_cmd2-arg -> UserDefTwo
-   gen=3DTrue success_response=3DTrue boxed=3DFalse
+   gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse
 object q_obj_guest-get-time-arg
     member a: int optional=3DFalse
     member b: int optional=3DTrue
 command guest-get-time q_obj_guest-get-time-arg -> int
-   gen=3DTrue success_response=3DTrue boxed=3DFalse
+   gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse
 object q_obj_guest-sync-arg
     member arg: any optional=3DFalse
 command guest-sync q_obj_guest-sync-arg -> any
-   gen=3DTrue success_response=3DTrue boxed=3DFalse
+   gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse
 command boxed-struct UserDefZero -> None
-   gen=3DTrue success_response=3DTrue boxed=3DTrue
+   gen=3DTrue success_response=3DTrue boxed=3DTrue oob=3DFalse
 command boxed-union UserDefNativeListUnion -> None
-   gen=3DTrue success_response=3DTrue boxed=3DTrue
+   gen=3DTrue success_response=3DTrue boxed=3DTrue oob=3DFalse
 object UserDefOptions
     member i64: intList optional=3DTrue
     member u64: uint64List optional=3DTrue
@@ -229,4 +229,4 @@ object q_obj___org.qemu_x-command-arg
     member c: __org.qemu_x-Union2 optional=3DFalse
     member d: __org.qemu_x-Alt optional=3DFalse
 command __org.qemu_x-command q_obj___org.qemu_x-command-arg -> __org.qem=
u_x-Union1
-   gen=3DTrue success_response=3DTrue boxed=3DFalse
+   gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse
diff --git a/tests/qapi-schema/test-qapi.py b/tests/qapi-schema/test-qapi=
.py
index 10e68b01d98..c1a144ba29a 100644
--- a/tests/qapi-schema/test-qapi.py
+++ b/tests/qapi-schema/test-qapi.py
@@ -45,8 +45,8 @@ class QAPISchemaTestVisitor(QAPISchemaVisitor):
                       gen, success_response, boxed, allow_oob):
         print('command %s %s -> %s' % \
               (name, arg_type and arg_type.name, ret_type and ret_type.n=
ame))
-        print('   gen=3D%s success_response=3D%s boxed=3D%s' % \
-              (gen, success_response, boxed))
+        print('   gen=3D%s success_response=3D%s boxed=3D%s oob=3D%s' % =
\
+              (gen, success_response, boxed, allow_oob))

     def visit_event(self, name, info, arg_type, boxed):
         print('event %s %s' % (name, arg_type and arg_type.name))
--=20
2.14.3

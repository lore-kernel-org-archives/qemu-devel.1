Received: from eggs.gnu.org ([2001:4830:134:3::10]:38226)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1f0Lmv-0002HV-Ue
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 02:39:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1f0Lmu-0006kV-Bc
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 02:39:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48530 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1f0Lmu-0006kR-5w
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 02:39:24 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BEF04EC001
	for <qemu-devel@nongnu.org>; Mon, 26 Mar 2018 06:39:23 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Mon, 26 Mar 2018 14:38:58 +0800
Message-Id: <20180326063901.27425-6-peterx@redhat.com>
In-Reply-To: <20180326063901.27425-1-peterx@redhat.com>
References: <20180326063901.27425-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.12 5/8] tests: let qapi-schema tests
 detect oob
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

The allow_oob parameter was passed in but not used in tests.  Now
reflect that in the tests, so we need to touch up other command testers
with that new change.

Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tests/qapi-schema/doc-good.out          |  4 ++--
 tests/qapi-schema/ident-with-escape.out |  2 +-
 tests/qapi-schema/indented-expr.out     |  4 ++--
 tests/qapi-schema/qapi-schema-test.out  | 18 +++++++++---------
 tests/qapi-schema/test-qapi.py          |  4 ++--
 5 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-good.out
index 430b5a87db..63058b1590 100644
--- a/tests/qapi-schema/doc-good.out
+++ b/tests/qapi-schema/doc-good.out
@@ -28,9 +28,9 @@ object q_obj_cmd-arg
     member arg2: str optional=True
     member arg3: bool optional=False
 command cmd q_obj_cmd-arg -> Object
-   gen=True success_response=True boxed=False
+   gen=True success_response=True boxed=False oob=False
 command cmd-boxed Object -> None
-   gen=True success_response=True boxed=True
+   gen=True success_response=True boxed=True oob=False
 doc freeform
     body=
 = Section
diff --git a/tests/qapi-schema/ident-with-escape.out b/tests/qapi-schema/ident-with-escape.out
index ee3b34e623..82213aa51d 100644
--- a/tests/qapi-schema/ident-with-escape.out
+++ b/tests/qapi-schema/ident-with-escape.out
@@ -5,4 +5,4 @@ module ident-with-escape.json
 object q_obj_fooA-arg
     member bar1: str optional=False
 command fooA q_obj_fooA-arg -> None
-   gen=True success_response=True boxed=False
+   gen=True success_response=True boxed=False oob=False
diff --git a/tests/qapi-schema/indented-expr.out b/tests/qapi-schema/indented-expr.out
index a79935e8c3..862678f8f4 100644
--- a/tests/qapi-schema/indented-expr.out
+++ b/tests/qapi-schema/indented-expr.out
@@ -3,6 +3,6 @@ enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbool']
     prefix QTYPE
 module indented-expr.json
 command eins None -> None
-   gen=True success_response=True boxed=False
+   gen=True success_response=True boxed=False oob=False
 command zwei None -> None
-   gen=True success_response=True boxed=False
+   gen=True success_response=True boxed=False oob=False
diff --git a/tests/qapi-schema/qapi-schema-test.out b/tests/qapi-schema/qapi-schema-test.out
index 012e7fc06a..4f43370017 100644
--- a/tests/qapi-schema/qapi-schema-test.out
+++ b/tests/qapi-schema/qapi-schema-test.out
@@ -16,7 +16,7 @@ object Empty1
 object Empty2
     base Empty1
 command user_def_cmd0 Empty2 -> Empty2
-   gen=True success_response=True boxed=False
+   gen=True success_response=True boxed=False oob=False
 enum QEnumTwo ['value1', 'value2']
     prefix QENUM_TWO
 object UserDefOne
@@ -143,29 +143,29 @@ object UserDefNativeListUnion
     case sizes: q_obj_sizeList-wrapper
     case any: q_obj_anyList-wrapper
 command user_def_cmd None -> None
-   gen=True success_response=True boxed=False
+   gen=True success_response=True boxed=False oob=False
 object q_obj_user_def_cmd1-arg
     member ud1a: UserDefOne optional=False
 command user_def_cmd1 q_obj_user_def_cmd1-arg -> None
-   gen=True success_response=True boxed=False
+   gen=True success_response=True boxed=False oob=False
 object q_obj_user_def_cmd2-arg
     member ud1a: UserDefOne optional=False
     member ud1b: UserDefOne optional=True
 command user_def_cmd2 q_obj_user_def_cmd2-arg -> UserDefTwo
-   gen=True success_response=True boxed=False
+   gen=True success_response=True boxed=False oob=False
 object q_obj_guest-get-time-arg
     member a: int optional=False
     member b: int optional=True
 command guest-get-time q_obj_guest-get-time-arg -> int
-   gen=True success_response=True boxed=False
+   gen=True success_response=True boxed=False oob=False
 object q_obj_guest-sync-arg
     member arg: any optional=False
 command guest-sync q_obj_guest-sync-arg -> any
-   gen=True success_response=True boxed=False
+   gen=True success_response=True boxed=False oob=False
 command boxed-struct UserDefZero -> None
-   gen=True success_response=True boxed=True
+   gen=True success_response=True boxed=True oob=False
 command boxed-union UserDefNativeListUnion -> None
-   gen=True success_response=True boxed=True
+   gen=True success_response=True boxed=True oob=False
 object UserDefOptions
     member i64: intList optional=True
     member u64: uint64List optional=True
@@ -229,4 +229,4 @@ object q_obj___org.qemu_x-command-arg
     member c: __org.qemu_x-Union2 optional=False
     member d: __org.qemu_x-Alt optional=False
 command __org.qemu_x-command q_obj___org.qemu_x-command-arg -> __org.qemu_x-Union1
-   gen=True success_response=True boxed=False
+   gen=True success_response=True boxed=False oob=False
diff --git a/tests/qapi-schema/test-qapi.py b/tests/qapi-schema/test-qapi.py
index 10e68b01d9..c1a144ba29 100644
--- a/tests/qapi-schema/test-qapi.py
+++ b/tests/qapi-schema/test-qapi.py
@@ -45,8 +45,8 @@ class QAPISchemaTestVisitor(QAPISchemaVisitor):
                       gen, success_response, boxed, allow_oob):
         print('command %s %s -> %s' % \
               (name, arg_type and arg_type.name, ret_type and ret_type.name))
-        print('   gen=%s success_response=%s boxed=%s' % \
-              (gen, success_response, boxed))
+        print('   gen=%s success_response=%s boxed=%s oob=%s' % \
+              (gen, success_response, boxed, allow_oob))
 
     def visit_event(self, name, info, arg_type, boxed):
         print('event %s %s' % (name, arg_type and arg_type.name))
-- 
2.14.3

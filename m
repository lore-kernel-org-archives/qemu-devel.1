Received: from eggs.gnu.org ([2001:4830:134:3::10]:50189)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fC4xF-0002Lo-86
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 11:06:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fC4xB-0003Pt-MV
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 11:06:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40406 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1fC4xB-0003Pb-Gz
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 11:06:29 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 10BDE401F9AF
	for <qemu-devel@nongnu.org>; Fri, 27 Apr 2018 15:06:29 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
Date: Fri, 27 Apr 2018 17:05:18 +0200
Message-Id: <1524841523-95513-7-git-send-email-imammedo@redhat.com>
In-Reply-To: <1524841523-95513-1-git-send-email-imammedo@redhat.com>
References: <1524841523-95513-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH v6 06/11] tests: let qapi-schema tests detect
 allowed-in-preconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, ehabkost@redhat.com, pkrempa@redhat.com, armbru@redhat.com

use new allowed-in-preconfig parameter in tests.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 tests/qapi-schema/doc-good.out          |  4 ++--
 tests/qapi-schema/ident-with-escape.out |  2 +-
 tests/qapi-schema/indented-expr.out     |  4 ++--
 tests/qapi-schema/qapi-schema-test.out  | 20 ++++++++++----------
 tests/qapi-schema/test-qapi.py          |  4 ++--
 5 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-good.out
index 63058b1..9c8a483 100644
--- a/tests/qapi-schema/doc-good.out
+++ b/tests/qapi-schema/doc-good.out
@@ -28,9 +28,9 @@ object q_obj_cmd-arg
     member arg2: str optional=True
     member arg3: bool optional=False
 command cmd q_obj_cmd-arg -> Object
-   gen=True success_response=True boxed=False oob=False
+   gen=True success_response=True boxed=False oob=False preconfig=False
 command cmd-boxed Object -> None
-   gen=True success_response=True boxed=True oob=False
+   gen=True success_response=True boxed=True oob=False preconfig=False
 doc freeform
     body=
 = Section
diff --git a/tests/qapi-schema/ident-with-escape.out b/tests/qapi-schema/ident-with-escape.out
index 82213aa..24c976f 100644
--- a/tests/qapi-schema/ident-with-escape.out
+++ b/tests/qapi-schema/ident-with-escape.out
@@ -5,4 +5,4 @@ module ident-with-escape.json
 object q_obj_fooA-arg
     member bar1: str optional=False
 command fooA q_obj_fooA-arg -> None
-   gen=True success_response=True boxed=False oob=False
+   gen=True success_response=True boxed=False oob=False preconfig=False
diff --git a/tests/qapi-schema/indented-expr.out b/tests/qapi-schema/indented-expr.out
index 862678f..bd8a486 100644
--- a/tests/qapi-schema/indented-expr.out
+++ b/tests/qapi-schema/indented-expr.out
@@ -3,6 +3,6 @@ enum QType ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist', 'qbool']
     prefix QTYPE
 module indented-expr.json
 command eins None -> None
-   gen=True success_response=True boxed=False oob=False
+   gen=True success_response=True boxed=False oob=False preconfig=False
 command zwei None -> None
-   gen=True success_response=True boxed=False oob=False
+   gen=True success_response=True boxed=False oob=False preconfig=False
diff --git a/tests/qapi-schema/qapi-schema-test.out b/tests/qapi-schema/qapi-schema-test.out
index 467577d..1f5038f 100644
--- a/tests/qapi-schema/qapi-schema-test.out
+++ b/tests/qapi-schema/qapi-schema-test.out
@@ -16,7 +16,7 @@ object Empty1
 object Empty2
     base Empty1
 command user_def_cmd0 Empty2 -> Empty2
-   gen=True success_response=True boxed=False oob=False
+   gen=True success_response=True boxed=False oob=False preconfig=False
 enum QEnumTwo ['value1', 'value2']
     prefix QENUM_TWO
 object UserDefOne
@@ -143,31 +143,31 @@ object UserDefNativeListUnion
     case sizes: q_obj_sizeList-wrapper
     case any: q_obj_anyList-wrapper
 command user_def_cmd None -> None
-   gen=True success_response=True boxed=False oob=False
+   gen=True success_response=True boxed=False oob=False preconfig=False
 object q_obj_user_def_cmd1-arg
     member ud1a: UserDefOne optional=False
 command user_def_cmd1 q_obj_user_def_cmd1-arg -> None
-   gen=True success_response=True boxed=False oob=False
+   gen=True success_response=True boxed=False oob=False preconfig=False
 object q_obj_user_def_cmd2-arg
     member ud1a: UserDefOne optional=False
     member ud1b: UserDefOne optional=True
 command user_def_cmd2 q_obj_user_def_cmd2-arg -> UserDefTwo
-   gen=True success_response=True boxed=False oob=False
+   gen=True success_response=True boxed=False oob=False preconfig=False
 object q_obj_guest-get-time-arg
     member a: int optional=False
     member b: int optional=True
 command guest-get-time q_obj_guest-get-time-arg -> int
-   gen=True success_response=True boxed=False oob=False
+   gen=True success_response=True boxed=False oob=False preconfig=False
 object q_obj_guest-sync-arg
     member arg: any optional=False
 command guest-sync q_obj_guest-sync-arg -> any
-   gen=True success_response=True boxed=False oob=False
+   gen=True success_response=True boxed=False oob=False preconfig=False
 command boxed-struct UserDefZero -> None
-   gen=True success_response=True boxed=True oob=False
+   gen=True success_response=True boxed=True oob=False preconfig=False
 command boxed-union UserDefNativeListUnion -> None
-   gen=True success_response=True boxed=True oob=False
+   gen=True success_response=True boxed=True oob=False preconfig=False
 command an-oob-command None -> None
-   gen=True success_response=True boxed=False oob=True
+   gen=True success_response=True boxed=False oob=True preconfig=False
 object UserDefOptions
     member i64: intList optional=True
     member u64: uint64List optional=True
@@ -231,4 +231,4 @@ object q_obj___org.qemu_x-command-arg
     member c: __org.qemu_x-Union2 optional=False
     member d: __org.qemu_x-Alt optional=False
 command __org.qemu_x-command q_obj___org.qemu_x-command-arg -> __org.qemu_x-Union1
-   gen=True success_response=True boxed=False oob=False
+   gen=True success_response=True boxed=False oob=False preconfig=False
diff --git a/tests/qapi-schema/test-qapi.py b/tests/qapi-schema/test-qapi.py
index 73d2c77..f0ff701 100644
--- a/tests/qapi-schema/test-qapi.py
+++ b/tests/qapi-schema/test-qapi.py
@@ -45,8 +45,8 @@ class QAPISchemaTestVisitor(QAPISchemaVisitor):
                       success_response, boxed, allow_oob, allowed_in_preconfig):
         print('command %s %s -> %s' % \
               (name, arg_type and arg_type.name, ret_type and ret_type.name))
-        print('   gen=%s success_response=%s boxed=%s oob=%s' % \
-              (gen, success_response, boxed, allow_oob))
+        print('   gen=%s success_response=%s boxed=%s oob=%s preconfig=%s' % \
+              (gen, success_response, boxed, allow_oob, allowed_in_preconfig))
 
     def visit_event(self, name, info, arg_type, boxed):
         print('event %s %s' % (name, arg_type and arg_type.name))
-- 
2.7.4

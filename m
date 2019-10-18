Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB32ECA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 08:19:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A33CC21925
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 08:19:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A33CC21925
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLNTp-0002Ab-6m
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 04:19:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37033)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iLNPX-0005N6-S4
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 04:15:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iLNPV-0007MZ-Jc
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 04:14:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38598)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iLNPV-0007Lq-9w
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 04:14:57 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4414B3082B02;
 Fri, 18 Oct 2019 08:14:56 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C23EF5D71C;
 Fri, 18 Oct 2019 08:14:55 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3CE1511384A8; Fri, 18 Oct 2019 10:14:54 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 1/5] tests/qapi-schema: Tidy up test output indentation
Date: Fri, 18 Oct 2019 10:14:50 +0200
Message-Id: <20191018081454.21369-2-armbru@redhat.com>
In-Reply-To: <20191018081454.21369-1-armbru@redhat.com>
References: <20191018081454.21369-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Fri, 18 Oct 2019 08:14:56 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kwolf@redhat.com, Peter Krempa <pkrempa@redhat.com>,
 mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Command and event details are indented three spaces, everything else
four.  Messed up in commit 156402e5042.  Use four spaces consistently.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Peter Krempa <pkrempa@redhat.com>
---
 tests/qapi-schema/doc-good.out         |  4 +-
 tests/qapi-schema/event-case.out       |  2 +-
 tests/qapi-schema/indented-expr.out    |  4 +-
 tests/qapi-schema/qapi-schema-test.out | 52 +++++++++++++-------------
 tests/qapi-schema/test-qapi.py         |  4 +-
 5 files changed, 33 insertions(+), 33 deletions(-)

diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-good.=
out
index d3bca343eb..6562e1f412 100644
--- a/tests/qapi-schema/doc-good.out
+++ b/tests/qapi-schema/doc-good.out
@@ -46,9 +46,9 @@ object q_obj_cmd-arg
     member arg2: str optional=3DTrue
     member arg3: bool optional=3DFalse
 command cmd q_obj_cmd-arg -> Object
-   gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse preconfi=
g=3DFalse
+    gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse preconf=
ig=3DFalse
 command cmd-boxed Object -> None
-   gen=3DTrue success_response=3DTrue boxed=3DTrue oob=3DFalse preconfig=
=3DFalse
+    gen=3DTrue success_response=3DTrue boxed=3DTrue oob=3DFalse preconfi=
g=3DFalse
 doc freeform
     body=3D
 =3D Section
diff --git a/tests/qapi-schema/event-case.out b/tests/qapi-schema/event-c=
ase.out
index ec8a1406e4..42ae519656 100644
--- a/tests/qapi-schema/event-case.out
+++ b/tests/qapi-schema/event-case.out
@@ -11,4 +11,4 @@ enum QType
     member qbool
 module event-case.json
 event oops None
-   boxed=3DFalse
+    boxed=3DFalse
diff --git a/tests/qapi-schema/indented-expr.out b/tests/qapi-schema/inde=
nted-expr.out
index bffdf6756d..04356775cd 100644
--- a/tests/qapi-schema/indented-expr.out
+++ b/tests/qapi-schema/indented-expr.out
@@ -11,6 +11,6 @@ enum QType
     member qbool
 module indented-expr.json
 command eins None -> None
-   gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse preconfi=
g=3DFalse
+    gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse preconf=
ig=3DFalse
 command zwei None -> None
-   gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse preconfi=
g=3DFalse
+    gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse preconf=
ig=3DFalse
diff --git a/tests/qapi-schema/qapi-schema-test.out b/tests/qapi-schema/q=
api-schema-test.out
index 98031da96f..aca43186a9 100644
--- a/tests/qapi-schema/qapi-schema-test.out
+++ b/tests/qapi-schema/qapi-schema-test.out
@@ -33,7 +33,7 @@ object Union
     case value3: q_empty
     case value4: q_empty
 command user_def_cmd0 Empty2 -> Empty2
-   gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse preconfi=
g=3DFalse
+    gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse preconf=
ig=3DFalse
 enum QEnumTwo
     prefix QENUM_TWO
     member value1
@@ -205,35 +205,35 @@ object SecondArrayRef
     member s: StatusList optional=3DFalse
 module qapi-schema-test.json
 command user_def_cmd None -> None
-   gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse preconfi=
g=3DFalse
+    gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse preconf=
ig=3DFalse
 object q_obj_user_def_cmd1-arg
     member ud1a: UserDefOne optional=3DFalse
 command user_def_cmd1 q_obj_user_def_cmd1-arg -> None
-   gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse preconfi=
g=3DFalse
+    gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse preconf=
ig=3DFalse
 object q_obj_user_def_cmd2-arg
     member ud1a: UserDefOne optional=3DFalse
     member ud1b: UserDefOne optional=3DTrue
 command user_def_cmd2 q_obj_user_def_cmd2-arg -> UserDefTwo
-   gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse preconfi=
g=3DFalse
+    gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse preconf=
ig=3DFalse
 command cmd-success-response None -> None
-   gen=3DTrue success_response=3DFalse boxed=3DFalse oob=3DFalse preconf=
ig=3DFalse
+    gen=3DTrue success_response=3DFalse boxed=3DFalse oob=3DFalse precon=
fig=3DFalse
 object q_obj_guest-get-time-arg
     member a: int optional=3DFalse
     member b: int optional=3DTrue
 command guest-get-time q_obj_guest-get-time-arg -> int
-   gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse preconfi=
g=3DFalse
+    gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse preconf=
ig=3DFalse
 object q_obj_guest-sync-arg
     member arg: any optional=3DFalse
 command guest-sync q_obj_guest-sync-arg -> any
-   gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse preconfi=
g=3DFalse
+    gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse preconf=
ig=3DFalse
 command boxed-struct UserDefZero -> None
-   gen=3DTrue success_response=3DTrue boxed=3DTrue oob=3DFalse preconfig=
=3DFalse
+    gen=3DTrue success_response=3DTrue boxed=3DTrue oob=3DFalse preconfi=
g=3DFalse
 command boxed-union UserDefListUnion -> None
-   gen=3DTrue success_response=3DTrue boxed=3DTrue oob=3DFalse preconfig=
=3DFalse
+    gen=3DTrue success_response=3DTrue boxed=3DTrue oob=3DFalse preconfi=
g=3DFalse
 command boxed-empty Empty1 -> None
-   gen=3DTrue success_response=3DTrue boxed=3DTrue oob=3DFalse preconfig=
=3DFalse
+    gen=3DTrue success_response=3DTrue boxed=3DTrue oob=3DFalse preconfi=
g=3DFalse
 command test-flags-command None -> None
-   gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DTrue preconfig=
=3DTrue
+    gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DTrue preconfi=
g=3DTrue
 object UserDefOptions
     member i64: intList optional=3DTrue
     member u64: uint64List optional=3DTrue
@@ -245,28 +245,28 @@ object EventStructOne
     member string: str optional=3DFalse
     member enum2: EnumOne optional=3DTrue
 event EVENT_A None
-   boxed=3DFalse
+    boxed=3DFalse
 event EVENT_B None
-   boxed=3DFalse
+    boxed=3DFalse
 object q_obj_EVENT_C-arg
     member a: int optional=3DTrue
     member b: UserDefOne optional=3DTrue
     member c: str optional=3DFalse
 event EVENT_C q_obj_EVENT_C-arg
-   boxed=3DFalse
+    boxed=3DFalse
 object q_obj_EVENT_D-arg
     member a: EventStructOne optional=3DFalse
     member b: str optional=3DFalse
     member c: str optional=3DTrue
     member enum3: EnumOne optional=3DTrue
 event EVENT_D q_obj_EVENT_D-arg
-   boxed=3DFalse
+    boxed=3DFalse
 event EVENT_E UserDefZero
-   boxed=3DTrue
+    boxed=3DTrue
 event EVENT_F UserDefFlatUnion
-   boxed=3DTrue
+    boxed=3DTrue
 event EVENT_G Empty1
-   boxed=3DTrue
+    boxed=3DTrue
 enum __org.qemu_x-Enum
     member __org.qemu_x-value
 object __org.qemu_x-Base
@@ -297,7 +297,7 @@ alternate __org.qemu_x-Alt
     tag type
     case __org.qemu_x-branch: __org.qemu_x-Base
 event __ORG.QEMU_X-EVENT __org.qemu_x-Struct
-   boxed=3DFalse
+    boxed=3DFalse
 array __org.qemu_x-EnumList __org.qemu_x-Enum
 array __org.qemu_x-StructList __org.qemu_x-Struct
 object q_obj___org.qemu_x-command-arg
@@ -306,7 +306,7 @@ object q_obj___org.qemu_x-command-arg
     member c: __org.qemu_x-Union2 optional=3DFalse
     member d: __org.qemu_x-Alt optional=3DFalse
 command __org.qemu_x-command q_obj___org.qemu_x-command-arg -> __org.qem=
u_x-Union1
-   gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse preconfi=
g=3DFalse
+    gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse preconf=
ig=3DFalse
 object TestIfStruct
     member foo: int optional=3DFalse
     member bar: int optional=3DFalse
@@ -335,7 +335,7 @@ object q_obj_TestIfUnionCmd-arg
     member union_cmd_arg: TestIfUnion optional=3DFalse
     if ['defined(TEST_IF_UNION)']
 command TestIfUnionCmd q_obj_TestIfUnionCmd-arg -> None
-   gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse preconfi=
g=3DFalse
+    gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse preconf=
ig=3DFalse
     if ['defined(TEST_IF_UNION)']
 alternate TestIfAlternate
     tag type
@@ -347,7 +347,7 @@ object q_obj_TestIfAlternateCmd-arg
     member alt_cmd_arg: TestIfAlternate optional=3DFalse
     if ['defined(TEST_IF_ALT)']
 command TestIfAlternateCmd q_obj_TestIfAlternateCmd-arg -> None
-   gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse preconfi=
g=3DFalse
+    gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse preconf=
ig=3DFalse
     if ['defined(TEST_IF_ALT)']
 object q_obj_TestIfCmd-arg
     member foo: TestIfStruct optional=3DFalse
@@ -355,10 +355,10 @@ object q_obj_TestIfCmd-arg
         if ['defined(TEST_IF_CMD_BAR)']
     if ['defined(TEST_IF_CMD)', 'defined(TEST_IF_STRUCT)']
 command TestIfCmd q_obj_TestIfCmd-arg -> UserDefThree
-   gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse preconfi=
g=3DFalse
+    gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse preconf=
ig=3DFalse
     if ['defined(TEST_IF_CMD)', 'defined(TEST_IF_STRUCT)']
 command TestCmdReturnDefThree None -> UserDefThree
-   gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse preconfi=
g=3DFalse
+    gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse preconf=
ig=3DFalse
 array TestIfEnumList TestIfEnum
     if ['defined(TEST_IF_ENUM)']
 object q_obj_TestIfEvent-arg
@@ -367,7 +367,7 @@ object q_obj_TestIfEvent-arg
         if ['defined(TEST_IF_EVT_BAR)']
     if ['defined(TEST_IF_EVT) && defined(TEST_IF_STRUCT)']
 event TestIfEvent q_obj_TestIfEvent-arg
-   boxed=3DFalse
+    boxed=3DFalse
     if ['defined(TEST_IF_EVT) && defined(TEST_IF_STRUCT)']
 object FeatureStruct0
     member foo: int optional=3DFalse
@@ -411,4 +411,4 @@ object q_obj_test-features-arg
     member cfs2: CondFeatureStruct2 optional=3DFalse
     member cfs3: CondFeatureStruct3 optional=3DFalse
 command test-features q_obj_test-features-arg -> None
-   gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse preconfi=
g=3DFalse
+    gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse preconf=
ig=3DFalse
diff --git a/tests/qapi-schema/test-qapi.py b/tests/qapi-schema/test-qapi=
.py
index 664254618a..29d9435bf7 100755
--- a/tests/qapi-schema/test-qapi.py
+++ b/tests/qapi-schema/test-qapi.py
@@ -76,13 +76,13 @@ class QAPISchemaTestVisitor(QAPISchemaVisitor):
         print('command %s %s -> %s'
               % (name, arg_type and arg_type.name,
                  ret_type and ret_type.name))
-        print('   gen=3D%s success_response=3D%s boxed=3D%s oob=3D%s pre=
config=3D%s'
+        print('    gen=3D%s success_response=3D%s boxed=3D%s oob=3D%s pr=
econfig=3D%s'
               % (gen, success_response, boxed, allow_oob, allow_preconfi=
g))
         self._print_if(ifcond)
=20
     def visit_event(self, name, info, ifcond, arg_type, boxed):
         print('event %s %s' % (name, arg_type and arg_type.name))
-        print('   boxed=3D%s' % boxed)
+        print('    boxed=3D%s' % boxed)
         self._print_if(ifcond)
=20
     @staticmethod
--=20
2.21.0



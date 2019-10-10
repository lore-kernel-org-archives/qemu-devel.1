Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8103DC10F14
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 11:08:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57BF2206A1
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 11:08:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57BF2206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIWJ0-0007wV-Ii
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 07:08:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47095)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pkrempa@redhat.com>) id 1iIWGB-00059G-0J
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 07:05:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pkrempa@redhat.com>) id 1iIWG9-0000sp-KE
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 07:05:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54518)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pkrempa@redhat.com>) id 1iIWG9-0000sO-CC
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 07:05:29 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8D45F3090FDB
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2019 11:05:28 +0000 (UTC)
Received: from angien.brq.redhat.com (unknown [10.43.2.229])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B792460BE1;
 Thu, 10 Oct 2019 11:05:27 +0000 (UTC)
From: Peter Krempa <pkrempa@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 2/3] tests: qapi: Test 'features' of commands
Date: Thu, 10 Oct 2019 13:05:23 +0200
Message-Id: <7a97c6dbe0747f604a4da81ff055fbf3ac97afb3.1570705279.git.pkrempa@redhat.com>
In-Reply-To: <cover.1570705279.git.pkrempa@redhat.com>
References: <cover.1570705279.git.pkrempa@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Thu, 10 Oct 2019 11:05:28 +0000 (UTC)
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
Cc: Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Peter Krempa <pkrempa@redhat.com>
---
 tests/qapi-schema/qapi-schema-test.json | 26 ++++++++++++++++++++++
 tests/qapi-schema/qapi-schema-test.out  | 29 +++++++++++++++++++++++++
 tests/qapi-schema/test-qapi.py          |  4 ++++
 tests/test-qmp-cmds.c                   | 28 ++++++++++++++++++++++++
 4 files changed, 87 insertions(+)

diff --git a/tests/qapi-schema/qapi-schema-test.json b/tests/qapi-schema/=
qapi-schema-test.json
index 75c42eb0e3..220859d4c9 100644
--- a/tests/qapi-schema/qapi-schema-test.json
+++ b/tests/qapi-schema/qapi-schema-test.json
@@ -290,3 +290,29 @@
             'cfs1': 'CondFeatureStruct1',
             'cfs2': 'CondFeatureStruct2',
             'cfs3': 'CondFeatureStruct3' } }
+
+# test 'features' for command
+
+{ 'command': 'test-command-features1',
+  'features': [] }
+
+{ 'command': 'test-command-features2',
+  'features': [ 'feature1' ] }
+
+{ 'command': 'test-command-features3',
+  'features': [ 'feature1', 'feature2' ] }
+
+{ 'command': 'test-command-features4',
+  'features': [ { 'name': 'feature1', 'if': 'defined(TEST_IF_FEATURE_1)'=
} ] }
+
+{ 'command': 'test-command-features5',
+  'features': [ { 'name': 'feature1', 'if': 'defined(TEST_IF_FEATURE_1)'=
},
+                { 'name': 'feature2', 'if': 'defined(TEST_IF_FEATURE_2)'=
} ] }
+
+{ 'command': 'test-command-features6',
+  'features': [ { 'name': 'feature1', 'if': 'defined(TEST_IF_FEATURE_1)'=
},
+                { 'name': 'feature2', 'if': 'defined(TEST_IF_FEATURE_2)'=
} ] }
+
+{ 'command': 'test-command-features7',
+  'features': [ { 'name': 'feature1', 'if': [ 'defined(TEST_IF_COND_1)',
+                                              'defined(TEST_IF_COND_2)']=
 } ] }
diff --git a/tests/qapi-schema/qapi-schema-test.out b/tests/qapi-schema/q=
api-schema-test.out
index 98031da96f..a38e348d54 100644
--- a/tests/qapi-schema/qapi-schema-test.out
+++ b/tests/qapi-schema/qapi-schema-test.out
@@ -412,3 +412,32 @@ object q_obj_test-features-arg
     member cfs3: CondFeatureStruct3 optional=3DFalse
 command test-features q_obj_test-features-arg -> None
    gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse preconfi=
g=3DFalse
+command test-command-features1 None -> None
+   gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse preconfi=
g=3DFalse
+command test-command-features2 None -> None
+   gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse preconfi=
g=3DFalse
+   feature feature1
+command test-command-features3 None -> None
+   gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse preconfi=
g=3DFalse
+   feature feature1
+   feature feature2
+command test-command-features4 None -> None
+   gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse preconfi=
g=3DFalse
+   feature feature1
+        if ['defined(TEST_IF_FEATURE_1)']
+command test-command-features5 None -> None
+   gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse preconfi=
g=3DFalse
+   feature feature1
+        if ['defined(TEST_IF_FEATURE_1)']
+   feature feature2
+        if ['defined(TEST_IF_FEATURE_2)']
+command test-command-features6 None -> None
+   gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse preconfi=
g=3DFalse
+   feature feature1
+        if ['defined(TEST_IF_FEATURE_1)']
+   feature feature2
+        if ['defined(TEST_IF_FEATURE_2)']
+command test-command-features7 None -> None
+   gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse preconfi=
g=3DFalse
+   feature feature1
+        if ['defined(TEST_IF_COND_1)', 'defined(TEST_IF_COND_2)']
diff --git a/tests/qapi-schema/test-qapi.py b/tests/qapi-schema/test-qapi=
.py
index e13c2e8671..62e65b6a7d 100755
--- a/tests/qapi-schema/test-qapi.py
+++ b/tests/qapi-schema/test-qapi.py
@@ -80,6 +80,10 @@ class QAPISchemaTestVisitor(QAPISchemaVisitor):
         print('   gen=3D%s success_response=3D%s boxed=3D%s oob=3D%s pre=
config=3D%s'
               % (gen, success_response, boxed, allow_oob, allow_preconfi=
g))
         self._print_if(ifcond)
+        if features:
+            for f in features:
+                print('   feature %s' % f.name)
+                self._print_if(f.ifcond, 8)

     def visit_event(self, name, info, ifcond, arg_type, boxed):
         print('event %s %s' % (name, arg_type and arg_type.name))
diff --git a/tests/test-qmp-cmds.c b/tests/test-qmp-cmds.c
index 36fdf5b115..19f6e06ba7 100644
--- a/tests/test-qmp-cmds.c
+++ b/tests/test-qmp-cmds.c
@@ -51,6 +51,34 @@ void qmp_test_features(FeatureStruct0 *fs0, FeatureStr=
uct1 *fs1,
 {
 }

+void qmp_test_command_features1(Error **errp)
+{
+}
+
+void qmp_test_command_features2(Error **errp)
+{
+}
+
+void qmp_test_command_features3(Error **errp)
+{
+}
+
+void qmp_test_command_features4(Error **errp)
+{
+}
+
+void qmp_test_command_features5(Error **errp)
+{
+}
+
+void qmp_test_command_features6(Error **errp)
+{
+}
+
+void qmp_test_command_features7(Error **errp)
+{
+}
+
 UserDefTwo *qmp_user_def_cmd2(UserDefOne *ud1a,
                               bool has_udb1, UserDefOne *ud1b,
                               Error **errp)
--=20
2.21.0



Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0BA7ECE58C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 08:51:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C367F2190F
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 08:51:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C367F2190F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIqeM-0004iM-AA
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 04:51:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46485)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iIqd6-0003Mn-Hg
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 04:50:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iIqd4-0005iA-KG
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 04:50:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38480)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iIqd4-0005hb-CK
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 04:50:30 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 150F618CB8E0
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2019 08:50:29 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AE1251001B2D;
 Fri, 11 Oct 2019 08:50:28 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 22B081132D6D; Fri, 11 Oct 2019 10:50:27 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 3/4] tests: qapi: Test 'features' of commands
Date: Fri, 11 Oct 2019 10:50:26 +0200
Message-Id: <20191011085027.28606-4-armbru@redhat.com>
In-Reply-To: <20191011085027.28606-1-armbru@redhat.com>
References: <20191011085027.28606-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.63]); Fri, 11 Oct 2019 08:50:29 +0000 (UTC)
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
Cc: kwolf@redhat.com, pkrempa@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Peter Krempa <pkrempa@redhat.com>

Signed-off-by: Peter Krempa <pkrempa@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tests/test-qmp-cmds.c                   | 24 ++++++++++++++++++++++++
 tests/qapi-schema/qapi-schema-test.json | 22 ++++++++++++++++++++++
 tests/qapi-schema/qapi-schema-test.out  | 23 +++++++++++++++++++++++
 tests/qapi-schema/test-qapi.py          | 12 ++++++++----
 4 files changed, 77 insertions(+), 4 deletions(-)

diff --git a/tests/test-qmp-cmds.c b/tests/test-qmp-cmds.c
index 36fdf5b115..ba623fda29 100644
--- a/tests/test-qmp-cmds.c
+++ b/tests/test-qmp-cmds.c
@@ -51,6 +51,30 @@ void qmp_test_features(FeatureStruct0 *fs0, FeatureStr=
uct1 *fs1,
 {
 }
=20
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
 UserDefTwo *qmp_user_def_cmd2(UserDefOne *ud1a,
                               bool has_udb1, UserDefOne *ud1b,
                               Error **errp)
diff --git a/tests/qapi-schema/qapi-schema-test.json b/tests/qapi-schema/=
qapi-schema-test.json
index 75c42eb0e3..80811dc8f0 100644
--- a/tests/qapi-schema/qapi-schema-test.json
+++ b/tests/qapi-schema/qapi-schema-test.json
@@ -290,3 +290,25 @@
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
+  'features': [ { 'name': 'feature1', 'if': [ 'defined(TEST_IF_COND_1)',
+                                              'defined(TEST_IF_COND_2)']=
 } ] }
diff --git a/tests/qapi-schema/qapi-schema-test.out b/tests/qapi-schema/q=
api-schema-test.out
index aca43186a9..4061152cae 100644
--- a/tests/qapi-schema/qapi-schema-test.out
+++ b/tests/qapi-schema/qapi-schema-test.out
@@ -412,3 +412,26 @@ object q_obj_test-features-arg
     member cfs3: CondFeatureStruct3 optional=3DFalse
 command test-features q_obj_test-features-arg -> None
     gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse preconf=
ig=3DFalse
+command test-command-features1 None -> None
+    gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse preconf=
ig=3DFalse
+command test-command-features2 None -> None
+    gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse preconf=
ig=3DFalse
+    feature feature1
+command test-command-features3 None -> None
+    gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse preconf=
ig=3DFalse
+    feature feature1
+    feature feature2
+command test-command-features4 None -> None
+    gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse preconf=
ig=3DFalse
+    feature feature1
+        if ['defined(TEST_IF_FEATURE_1)']
+command test-command-features5 None -> None
+    gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse preconf=
ig=3DFalse
+    feature feature1
+        if ['defined(TEST_IF_FEATURE_1)']
+    feature feature2
+        if ['defined(TEST_IF_FEATURE_2)']
+command test-command-features6 None -> None
+    gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse preconf=
ig=3DFalse
+    feature feature1
+        if ['defined(TEST_IF_COND_1)', 'defined(TEST_IF_COND_2)']
diff --git a/tests/qapi-schema/test-qapi.py b/tests/qapi-schema/test-qapi=
.py
index d31ac4bbb7..32333d3bf9 100755
--- a/tests/qapi-schema/test-qapi.py
+++ b/tests/qapi-schema/test-qapi.py
@@ -61,10 +61,7 @@ class QAPISchemaTestVisitor(QAPISchemaVisitor):
             self._print_if(m.ifcond, 8)
         self._print_variants(variants)
         self._print_if(ifcond)
-        if features:
-            for f in features:
-                print('    feature %s' % f.name)
-                self._print_if(f.ifcond, 8)
+        self._print_features(features)
=20
     def visit_alternate_type(self, name, info, ifcond, variants):
         print('alternate %s' % name)
@@ -80,6 +77,7 @@ class QAPISchemaTestVisitor(QAPISchemaVisitor):
         print('    gen=3D%s success_response=3D%s boxed=3D%s oob=3D%s pr=
econfig=3D%s'
               % (gen, success_response, boxed, allow_oob, allow_preconfi=
g))
         self._print_if(ifcond)
+        self._print_features(features)
=20
     def visit_event(self, name, info, ifcond, arg_type, boxed):
         print('event %s %s' % (name, arg_type and arg_type.name))
@@ -99,6 +97,12 @@ class QAPISchemaTestVisitor(QAPISchemaVisitor):
         if ifcond:
             print('%sif %s' % (' ' * indent, ifcond))
=20
+    @classmethod
+    def _print_features(cls, features):
+        if features:
+            for f in features:
+                print('    feature %s' % f.name)
+                cls._print_if(f.ifcond, 8)
=20
 def test_frontend(fname):
     schema =3D QAPISchema(fname)
--=20
2.21.0



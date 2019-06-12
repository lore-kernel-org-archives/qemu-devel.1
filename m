Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A02ECC31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 17:09:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C02B21019
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 17:09:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C02B21019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33952 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hb6k9-0002oO-QR
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 13:09:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57863)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hb6UM-0007Qs-AV
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 12:52:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hb6UI-0006FS-QU
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 12:52:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57976)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hb6UG-0006Ab-6J
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 12:52:36 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D52A330001DA
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2019 16:52:32 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-148.ams2.redhat.com
 [10.36.116.148])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7E90851C60;
 Wed, 12 Jun 2019 16:52:32 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id AA6BE11384AA; Wed, 12 Jun 2019 18:52:29 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 12 Jun 2019 18:52:24 +0200
Message-Id: <20190612165229.26976-7-armbru@redhat.com>
In-Reply-To: <20190612165229.26976-1-armbru@redhat.com>
References: <20190612165229.26976-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Wed, 12 Jun 2019 16:52:32 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 06/11] tests/qapi-schema: Test for good feature
 lists in structs
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
Cc: Kevin Wolf <kwolf@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Kevin Wolf <kwolf@redhat.com>

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-Id: <20190606153803.5278-3-armbru@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tests/qapi-schema/qapi-schema-test.json | 39 ++++++++++++++++++++++
 tests/qapi-schema/qapi-schema-test.out  | 43 +++++++++++++++++++++++++
 tests/qapi-schema/test-qapi.py          |  4 +++
 tests/test-qmp-cmds.c                   |  8 +++++
 4 files changed, 94 insertions(+)

diff --git a/tests/qapi-schema/qapi-schema-test.json b/tests/qapi-schema/=
qapi-schema-test.json
index 0952c68734..c6d59acc3e 100644
--- a/tests/qapi-schema/qapi-schema-test.json
+++ b/tests/qapi-schema/qapi-schema-test.json
@@ -242,3 +242,42 @@
   { 'foo': 'TestIfStruct',
     'bar': { 'type': ['TestIfEnum'], 'if': 'defined(TEST_IF_EVT_BAR)' } =
},
   'if': 'defined(TEST_IF_EVT) && defined(TEST_IF_STRUCT)' }
+
+# test 'features' for structs
+
+{ 'struct': 'FeatureStruct0',
+  'data': { 'foo': 'int' },
+  'features': [] }
+{ 'struct': 'FeatureStruct1',
+  'data': { 'foo': 'int' },
+  'features': [ 'feature1' ] }
+{ 'struct': 'FeatureStruct2',
+  'data': { 'foo': 'int' },
+  'features': [ { 'name': 'feature1' } ] }
+{ 'struct': 'FeatureStruct3',
+  'data': { 'foo': 'int' },
+  'features': [ 'feature1', 'feature2' ] }
+{ 'struct': 'FeatureStruct4',
+  'data': { 'namespace-test': 'int' },
+  'features': [ 'namespace-test', 'int', 'name', 'if' ] }
+
+{ 'struct': 'CondFeatureStruct1',
+  'data': { 'foo': 'int' },
+  'features': [ { 'name': 'feature1', 'if': 'defined(TEST_IF_FEATURE_1)'=
} ] }
+{ 'struct': 'CondFeatureStruct2',
+  'data': { 'foo': 'int' },
+  'features': [ { 'name': 'feature1', 'if': 'defined(TEST_IF_FEATURE_1)'=
},
+                { 'name': 'feature2', 'if': 'defined(TEST_IF_FEATURE_2)'=
} ] }
+{ 'struct': 'CondFeatureStruct3',
+  'data': { 'foo': 'int' },
+  'features': [ { 'name': 'feature1', 'if': [ 'defined(TEST_IF_COND_1)',
+                                              'defined(TEST_IF_COND_2)']=
 } ] }
+{ 'command': 'test-features',
+  'data': { 'fs0': 'FeatureStruct0',
+            'fs1': 'FeatureStruct1',
+            'fs2': 'FeatureStruct2',
+            'fs3': 'FeatureStruct3',
+            'fs4': 'FeatureStruct4',
+            'cfs1': 'CondFeatureStruct1',
+            'cfs2': 'CondFeatureStruct2',
+            'cfs3': 'CondFeatureStruct3' } }
diff --git a/tests/qapi-schema/qapi-schema-test.out b/tests/qapi-schema/q=
api-schema-test.out
index 77fb1e1aa9..85d510bc00 100644
--- a/tests/qapi-schema/qapi-schema-test.out
+++ b/tests/qapi-schema/qapi-schema-test.out
@@ -354,3 +354,46 @@ object q_obj_TestIfEvent-arg
 event TestIfEvent q_obj_TestIfEvent-arg
    boxed=3DFalse
     if ['defined(TEST_IF_EVT) && defined(TEST_IF_STRUCT)']
+object FeatureStruct0
+    member foo: int optional=3DFalse
+object FeatureStruct1
+    member foo: int optional=3DFalse
+    feature feature1
+object FeatureStruct2
+    member foo: int optional=3DFalse
+    feature feature1
+object FeatureStruct3
+    member foo: int optional=3DFalse
+    feature feature1
+    feature feature2
+object FeatureStruct4
+    member namespace-test: int optional=3DFalse
+    feature namespace-test
+    feature int
+    feature name
+    feature if
+object CondFeatureStruct1
+    member foo: int optional=3DFalse
+    feature feature1
+        if ['defined(TEST_IF_FEATURE_1)']
+object CondFeatureStruct2
+    member foo: int optional=3DFalse
+    feature feature1
+        if ['defined(TEST_IF_FEATURE_1)']
+    feature feature2
+        if ['defined(TEST_IF_FEATURE_2)']
+object CondFeatureStruct3
+    member foo: int optional=3DFalse
+    feature feature1
+        if ['defined(TEST_IF_COND_1)', 'defined(TEST_IF_COND_2)']
+object q_obj_test-features-arg
+    member fs0: FeatureStruct0 optional=3DFalse
+    member fs1: FeatureStruct1 optional=3DFalse
+    member fs2: FeatureStruct2 optional=3DFalse
+    member fs3: FeatureStruct3 optional=3DFalse
+    member fs4: FeatureStruct4 optional=3DFalse
+    member cfs1: CondFeatureStruct1 optional=3DFalse
+    member cfs2: CondFeatureStruct2 optional=3DFalse
+    member cfs3: CondFeatureStruct3 optional=3DFalse
+command test-features q_obj_test-features-arg -> None
+   gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse preconfi=
g=3DFalse
diff --git a/tests/qapi-schema/test-qapi.py b/tests/qapi-schema/test-qapi=
.py
index f2d6815c86..b0f770b9bd 100644
--- a/tests/qapi-schema/test-qapi.py
+++ b/tests/qapi-schema/test-qapi.py
@@ -49,6 +49,10 @@ class QAPISchemaTestVisitor(QAPISchemaVisitor):
             self._print_if(m.ifcond, 8)
         self._print_variants(variants)
         self._print_if(ifcond)
+        if features:
+            for f in features:
+                print('    feature %s' % f.name)
+                self._print_if(f.ifcond, 8)
=20
     def visit_alternate_type(self, name, info, ifcond, variants):
         print('alternate %s' % name)
diff --git a/tests/test-qmp-cmds.c b/tests/test-qmp-cmds.c
index f0b95dcbc3..ab389f42da 100644
--- a/tests/test-qmp-cmds.c
+++ b/tests/test-qmp-cmds.c
@@ -43,6 +43,14 @@ void qmp_user_def_cmd1(UserDefOne * ud1, Error **errp)
 {
 }
=20
+void qmp_test_features(FeatureStruct0 *fs0, FeatureStruct1 *fs1,
+                       FeatureStruct2 *fs2, FeatureStruct3 *fs3,
+                       FeatureStruct4 *fs4, CondFeatureStruct1 *cfs1,
+                       CondFeatureStruct2 *cfs2, CondFeatureStruct3 *cfs=
3,
+                       Error **errp)
+{
+}
+
 UserDefTwo *qmp_user_def_cmd2(UserDefOne *ud1a,
                               bool has_udb1, UserDefOne *ud1b,
                               Error **errp)
--=20
2.21.0



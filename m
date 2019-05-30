Return-Path: <SRS0=r6E1=T6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E09CC28CC0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 07:34:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE40724600
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 07:34:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE40724600
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48525 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWFa4-00041O-Im
	for qemu-devel@archiver.kernel.org; Thu, 30 May 2019 03:34:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51952)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hWFY9-0002fh-NW
	for qemu-devel@nongnu.org; Thu, 30 May 2019 03:32:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hWFY8-0001Pi-EP
	for qemu-devel@nongnu.org; Thu, 30 May 2019 03:32:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50670)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hWFY5-0001Ky-CA; Thu, 30 May 2019 03:32:29 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9AD2B30821AE;
	Thu, 30 May 2019 07:32:28 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-116-119.ams2.redhat.com
	[10.36.116.119])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 38A08983A;
	Thu, 30 May 2019 07:32:27 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Thu, 30 May 2019 09:32:01 +0200
Message-Id: <20190530073205.5293-3-kwolf@redhat.com>
In-Reply-To: <20190530073205.5293-1-kwolf@redhat.com>
References: <20190530073205.5293-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.47]);
	Thu, 30 May 2019 07:32:28 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 2/6] tests/qapi-schema: Test for good
 feature lists in structs
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kwolf@redhat.com, pkrempa@redhat.com, armbru@redhat.com,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qapi-schema/qapi-schema-test.json | 39 ++++++++++++++++++++++
 tests/qapi-schema/qapi-schema-test.out  | 43 +++++++++++++++++++++++++
 tests/qapi-schema/test-qapi.py          |  4 +++
 3 files changed, 86 insertions(+)

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
--=20
2.20.1



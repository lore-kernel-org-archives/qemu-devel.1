Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B58C10F14
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 14:38:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 279CC20818
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 14:38:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 279CC20818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54026 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDVPa-0008Hg-9W
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 10:38:14 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55421)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hDVO1-0007Kp-1B
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 10:36:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hDVNy-0000To-N7
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 10:36:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52776)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hDVNq-0000N0-IB; Mon, 08 Apr 2019 10:36:28 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AA48EC057F4F;
	Mon,  8 Apr 2019 14:36:25 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-117-165.ams2.redhat.com
	[10.36.117.165])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4670417ADF;
	Mon,  8 Apr 2019 14:36:24 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Mon,  8 Apr 2019 16:35:41 +0200
Message-Id: <20190408143543.3982-3-kwolf@redhat.com>
In-Reply-To: <20190408143543.3982-1-kwolf@redhat.com>
References: <20190408143543.3982-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.32]);
	Mon, 08 Apr 2019 14:36:25 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 2/4] tests/qapi-schema: Test for good feature
 lists in structs
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
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190408143541.PS9liCcGOIqJ0O_kUdU2jG60vshfaE6tB2DvgfeRRhA@z>

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qapi-schema/qapi-schema-test.json | 27 +++++++++++++++++++++++++
 tests/qapi-schema/qapi-schema-test.out  | 26 ++++++++++++++++++++++++
 tests/qapi-schema/test-qapi.py          |  4 ++++
 3 files changed, 57 insertions(+)

diff --git a/tests/qapi-schema/qapi-schema-test.json b/tests/qapi-schema/=
qapi-schema-test.json
index 0952c68734..263514b448 100644
--- a/tests/qapi-schema/qapi-schema-test.json
+++ b/tests/qapi-schema/qapi-schema-test.json
@@ -242,3 +242,30 @@
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
diff --git a/tests/qapi-schema/qapi-schema-test.out b/tests/qapi-schema/q=
api-schema-test.out
index 77fb1e1aa9..490e202f65 100644
--- a/tests/qapi-schema/qapi-schema-test.out
+++ b/tests/qapi-schema/qapi-schema-test.out
@@ -354,3 +354,29 @@ object q_obj_TestIfEvent-arg
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
diff --git a/tests/qapi-schema/test-qapi.py b/tests/qapi-schema/test-qapi=
.py
index f2d6815c86..08e29c23a6 100644
--- a/tests/qapi-schema/test-qapi.py
+++ b/tests/qapi-schema/test-qapi.py
@@ -49,6 +49,10 @@ class QAPISchemaTestVisitor(QAPISchemaVisitor):
             self._print_if(m.ifcond, 8)
         self._print_variants(variants)
         self._print_if(ifcond)
+        if features:
+            for f in features:
+                print('    feature %s' % f['name'])
+                self._print_if(f.get('if'), 8)
=20
     def visit_alternate_type(self, name, info, ifcond, variants):
         print('alternate %s' % name)
--=20
2.20.1



Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70EEDC48BD7
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 21:28:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47E222086D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 21:28:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47E222086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35370 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfszn-0004dW-F0
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 17:28:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41974)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hfsrn-00007h-S8
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 17:20:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hfsrm-0004jp-AV
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 17:20:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57368)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hfsrf-0004Bm-Ue; Tue, 25 Jun 2019 17:20:32 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7A052882FF;
 Tue, 25 Jun 2019 21:20:16 +0000 (UTC)
Received: from localhost (ovpn-204-63.brq.redhat.com [10.40.204.63])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 128381972D;
 Tue, 25 Jun 2019 21:20:15 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Tue, 25 Jun 2019 23:19:54 +0200
Message-Id: <20190625211955.15664-5-mreitz@redhat.com>
In-Reply-To: <20190625211955.15664-1-mreitz@redhat.com>
References: <20190625211955.15664-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Tue, 25 Jun 2019 21:20:17 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 4/5] iotests: Test driver whitelisting in 093
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

null-aio may not be whitelisted.  Skip all test cases that require it.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/093 | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/tests/qemu-iotests/093 b/tests/qemu-iotests/093
index bd56c94708..806bdcaa24 100755
--- a/tests/qemu-iotests/093
+++ b/tests/qemu-iotests/093
@@ -22,9 +22,11 @@
 import iotests
=20
 nsec_per_sec =3D 1000000000
+supported_null_drivers =3D [ f for f in iotests.supported_formats()
+                           if f.startswith('null-') ]
=20
 class ThrottleTestCase(iotests.QMPTestCase):
-    test_img =3D "null-aio://"
+    test_driver =3D "null-aio"
     max_drives =3D 3
=20
     def blockstats(self, device):
@@ -36,9 +38,13 @@ class ThrottleTestCase(iotests.QMPTestCase):
         raise Exception("Device not found for blockstats: %s" % device)
=20
     def setUp(self):
+        global supported_null_drivers
+        if self.test_driver not in supported_null_drivers:
+            self.case_skip('%s support missing' % self.test_driver)
+
         self.vm =3D iotests.VM()
         for i in range(0, self.max_drives):
-            self.vm.add_drive(self.test_img)
+            self.vm.add_drive(self.test_driver + "://")
         self.vm.launch()
=20
     def tearDown(self):
@@ -264,7 +270,7 @@ class ThrottleTestCase(iotests.QMPTestCase):
         self.assertEqual(self.blockstats('drive1')[0], 4096)
=20
 class ThrottleTestCoroutine(ThrottleTestCase):
-    test_img =3D "null-co://"
+    test_driver =3D "null-co"
=20
 class ThrottleTestGroupNames(iotests.QMPTestCase):
     max_drives =3D 3
@@ -426,4 +432,6 @@ class ThrottleTestRemovableMedia(iotests.QMPTestCase)=
:
=20
=20
 if __name__ =3D=3D '__main__':
+    if 'null-co' not in supported_null_drivers:
+        iotests.notrun('null-co driver support missing')
     iotests.main(supported_fmts=3D["raw"])
--=20
2.21.0



Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5249FECE587
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 20:46:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22519215EA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 20:46:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22519215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFP2U-0004g7-7E
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 16:46:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54626)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iFO8J-00051B-1F
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 15:48:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iFO8H-00089t-SL
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 15:48:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37918)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iFO8D-00086y-M3; Tue, 01 Oct 2019 15:48:21 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DA3CF10CC1E6;
 Tue,  1 Oct 2019 19:48:20 +0000 (UTC)
Received: from localhost (unknown [10.40.205.251])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 74BE75C1D4;
 Tue,  1 Oct 2019 19:48:20 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 27/67] iotests/129: Honor $IMGOPTS
Date: Tue,  1 Oct 2019 21:46:35 +0200
Message-Id: <20191001194715.2796-28-mreitz@redhat.com>
In-Reply-To: <20191001194715.2796-1-mreitz@redhat.com>
References: <20191001194715.2796-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.65]); Tue, 01 Oct 2019 19:48:20 +0000 (UTC)
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/129 | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/129 b/tests/qemu-iotests/129
index cd6b9e9ce7..379719d85b 100755
--- a/tests/qemu-iotests/129
+++ b/tests/qemu-iotests/129
@@ -20,6 +20,7 @@
=20
 import os
 import iotests
+from iotests import create_test_image, remove_test_image
 import time
=20
 class TestStopWithBlockJob(iotests.QMPTestCase):
@@ -28,8 +29,8 @@ class TestStopWithBlockJob(iotests.QMPTestCase):
     base_img =3D os.path.join(iotests.test_dir, 'base.img')
=20
     def setUp(self):
-        iotests.qemu_img('create', '-f', iotests.imgfmt, self.base_img, =
"1G")
-        iotests.qemu_img('create', '-f', iotests.imgfmt, self.test_img, =
"-b", self.base_img)
+        create_test_image(self.base_img, '1G')
+        create_test_image(self.test_img, backing_file=3Dself.base_img)
         iotests.qemu_io('-f', iotests.imgfmt, '-c', 'write -P0x5d 1M 128=
M', self.test_img)
         self.vm =3D iotests.VM().add_drive(self.test_img)
         self.vm.launch()
@@ -46,6 +47,12 @@ class TestStopWithBlockJob(iotests.QMPTestCase):
         result =3D self.vm.qmp("block_set_io_throttle", conv_keys=3DFals=
e,
                              **params)
         self.vm.shutdown()
+        remove_test_image(self.test_img)
+        remove_test_image(self.base_img)
+        try:
+            os.remove(self.target_img)
+        except OSError:
+            pass
=20
     def do_test_stop(self, cmd, **args):
         """Test 'stop' while block job is running on a throttled drive.
--=20
2.21.0



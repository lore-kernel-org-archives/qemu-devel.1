Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAF1FECE587
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 20:22:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A028C2133F
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 20:22:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A028C2133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFOfN-0000iy-77
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 16:22:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54295)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iFO7t-0004gk-RC
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 15:48:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iFO7r-0007vh-DU
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 15:48:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52196)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iFO7o-0007tB-6i; Tue, 01 Oct 2019 15:47:56 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6EB3BC04AC69;
 Tue,  1 Oct 2019 19:47:55 +0000 (UTC)
Received: from localhost (unknown [10.40.205.251])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 070025D6D0;
 Tue,  1 Oct 2019 19:47:54 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 16/67] iotests/040: Honor $IMGOPTS
Date: Tue,  1 Oct 2019 21:46:24 +0200
Message-Id: <20191001194715.2796-17-mreitz@redhat.com>
In-Reply-To: <20191001194715.2796-1-mreitz@redhat.com>
References: <20191001194715.2796-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Tue, 01 Oct 2019 19:47:55 +0000 (UTC)
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
 tests/qemu-iotests/040 | 42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/tests/qemu-iotests/040 b/tests/qemu-iotests/040
index 762ad1ebcb..9584eeeb1f 100755
--- a/tests/qemu-iotests/040
+++ b/tests/qemu-iotests/040
@@ -24,7 +24,7 @@
 import time
 import os
 import iotests
-from iotests import qemu_img, qemu_io
+from iotests import create_test_image, remove_test_image, qemu_img, qemu=
_io
 import struct
 import errno
=20
@@ -80,8 +80,8 @@ class TestSingleDrive(ImageCommitTestCase):
=20
     def setUp(self):
         iotests.create_image(backing_img, self.image_len)
-        qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=3D%=
s' % backing_img, mid_img)
-        qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=3D%=
s' % mid_img, test_img)
+        create_test_image(mid_img, backing_file=3Dbacking_img)
+        create_test_image(test_img, backing_file=3Dmid_img)
         qemu_io('-f', 'raw', '-c', 'write -P 0xab 0 524288', backing_img=
)
         qemu_io('-f', iotests.imgfmt, '-c', 'write -P 0xef 524288 524288=
', mid_img)
         self.vm =3D iotests.VM().add_drive(test_img, "node-name=3Dtop,ba=
cking.node-name=3Dmid,backing.backing.node-name=3Dbase", interface=3D"non=
e")
@@ -92,8 +92,8 @@ class TestSingleDrive(ImageCommitTestCase):
=20
     def tearDown(self):
         self.vm.shutdown(has_quit=3Dself.has_quit)
-        os.remove(test_img)
-        os.remove(mid_img)
+        remove_test_image(test_img)
+        remove_test_image(mid_img)
         os.remove(backing_img)
=20
     def test_commit(self):
@@ -303,8 +303,8 @@ class TestRelativePaths(ImageCommitTestCase):
             if exception.errno !=3D errno.EEXIST:
                 raise
         iotests.create_image(self.backing_img_abs, TestRelativePaths.ima=
ge_len)
-        qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=3D%=
s' % self.backing_img_abs, self.mid_img_abs)
-        qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=3D%=
s' % self.mid_img_abs, self.test_img)
+        create_test_image(self.mid_img_abs, backing_file=3Dself.backing_=
img_abs)
+        create_test_image(self.test_img, backing_file=3Dself.mid_img_abs=
)
         qemu_img('rebase', '-u', '-b', self.backing_img, self.mid_img_ab=
s)
         qemu_img('rebase', '-u', '-b', self.mid_img, self.test_img)
         qemu_io('-f', 'raw', '-c', 'write -P 0xab 0 524288', self.backin=
g_img_abs)
@@ -314,8 +314,8 @@ class TestRelativePaths(ImageCommitTestCase):
=20
     def tearDown(self):
         self.vm.shutdown()
-        os.remove(self.test_img)
-        os.remove(self.mid_img_abs)
+        remove_test_image(self.test_img)
+        remove_test_image(self.mid_img_abs)
         os.remove(self.backing_img_abs)
         try:
             os.rmdir(os.path.join(iotests.test_dir, self.dir1))
@@ -368,9 +368,9 @@ class TestSetSpeed(ImageCommitTestCase):
     image_len =3D 80 * 1024 * 1024 # MB
=20
     def setUp(self):
-        qemu_img('create', backing_img, str(TestSetSpeed.image_len))
-        qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=3D%=
s' % backing_img, mid_img)
-        qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=3D%=
s' % mid_img, test_img)
+        create_test_image(backing_img, TestSetSpeed.image_len)
+        create_test_image(mid_img, backing_file=3Dbacking_img)
+        create_test_image(test_img, backing_file=3Dmid_img)
         qemu_io('-f', iotests.imgfmt, '-c', 'write -P 0x1 0 512', test_i=
mg)
         qemu_io('-f', iotests.imgfmt, '-c', 'write -P 0xef 524288 524288=
', mid_img)
         self.vm =3D iotests.VM().add_drive('blkdebug::' + test_img)
@@ -378,9 +378,9 @@ class TestSetSpeed(ImageCommitTestCase):
=20
     def tearDown(self):
         self.vm.shutdown()
-        os.remove(test_img)
-        os.remove(mid_img)
-        os.remove(backing_img)
+        remove_test_image(test_img)
+        remove_test_image(mid_img)
+        remove_test_image(backing_img)
=20
     def test_set_speed(self):
         self.assert_no_active_block_jobs()
@@ -408,9 +408,9 @@ class TestReopenOverlay(ImageCommitTestCase):
=20
     def setUp(self):
         iotests.create_image(self.img0, self.image_len)
-        qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=3D%=
s' % self.img0, self.img1)
-        qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=3D%=
s' % self.img1, self.img2)
-        qemu_img('create', '-f', iotests.imgfmt, '-o', 'backing_file=3D%=
s' % self.img2, self.img3)
+        create_test_image(self.img1, backing_file=3Dself.img0)
+        create_test_image(self.img2, backing_file=3Dself.img1)
+        create_test_image(self.img3, backing_file=3Dself.img2)
         qemu_io('-f', iotests.imgfmt, '-c', 'write -P 0xab 0 128K', self=
.img1)
         self.vm =3D iotests.VM().add_drive(self.img3)
         self.vm.launch()
@@ -418,9 +418,9 @@ class TestReopenOverlay(ImageCommitTestCase):
     def tearDown(self):
         self.vm.shutdown()
         os.remove(self.img0)
-        os.remove(self.img1)
-        os.remove(self.img2)
-        os.remove(self.img3)
+        remove_test_image(self.img1)
+        remove_test_image(self.img2)
+        remove_test_image(self.img3)
=20
     # This tests what happens when the overlay image of the 'top' node
     # needs to be reopened in read-write mode in order to update the
--=20
2.21.0



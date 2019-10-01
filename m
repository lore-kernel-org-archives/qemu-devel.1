Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0BFBC352AA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 20:29:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98FD92133F
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 20:29:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98FD92133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFOlr-00077M-Fq
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 16:29:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54641)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iFO8K-00052g-B3
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 15:48:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iFO8I-0008A4-3M
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 15:48:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57304)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iFO8D-00086R-Ku; Tue, 01 Oct 2019 15:48:23 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 90E9C3082131;
 Tue,  1 Oct 2019 19:48:18 +0000 (UTC)
Received: from localhost (unknown [10.40.205.251])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2DC8E5C1D4;
 Tue,  1 Oct 2019 19:48:17 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 26/67] iotests/124: Honor $IMGOPTS
Date: Tue,  1 Oct 2019 21:46:34 +0200
Message-Id: <20191001194715.2796-27-mreitz@redhat.com>
In-Reply-To: <20191001194715.2796-1-mreitz@redhat.com>
References: <20191001194715.2796-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Tue, 01 Oct 2019 19:48:18 +0000 (UTC)
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
 tests/qemu-iotests/124 | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/tests/qemu-iotests/124 b/tests/qemu-iotests/124
index d3e851e1ae..145dccb2b0 100755
--- a/tests/qemu-iotests/124
+++ b/tests/qemu-iotests/124
@@ -22,6 +22,7 @@
=20
 import os
 import iotests
+from iotests import create_test_image, remove_test_image
=20
=20
 def io_write_patterns(img, patterns):
@@ -29,13 +30,6 @@ def io_write_patterns(img, patterns):
         iotests.qemu_io('-c', 'write -P%s %s %s' % pattern, img)
=20
=20
-def try_remove(img):
-    try:
-        os.remove(img)
-    except OSError:
-        pass
-
-
 def transaction_action(action, **kwargs):
     return {
         'type': action,
@@ -82,13 +76,13 @@ class Bitmap:
=20
     def del_target(self):
         for image in self.backups.pop():
-            try_remove(image)
+            remove_test_image(image)
         self.num -=3D 1
=20
     def cleanup(self):
         for backup in self.backups:
             for image in backup:
-                try_remove(image)
+                remove_test_image(image)
=20
=20
 class TestIncrementalBackupBase(iotests.QMPTestCase):
@@ -133,15 +127,14 @@ class TestIncrementalBackupBase(iotests.QMPTestCase=
):
=20
     def img_create(self, img, fmt=3Diotests.imgfmt, size=3D'64M',
                    parent=3DNone, parentFormat=3DNone, **kwargs):
-        optargs =3D []
-        for k,v in kwargs.items():
-            optargs =3D optargs + ['-o', '%s=3D%s' % (k,v)]
-        args =3D ['create', '-f', fmt] + optargs + [img, size]
+        opts =3D []
+        for k, v in kwargs.items():
+            opts.append('%s=3D%s' % (k, v))
         if parent:
             if parentFormat is None:
                 parentFormat =3D fmt
-            args =3D args + ['-b', parent, '-F', parentFormat]
-        iotests.qemu_img(*args)
+        create_test_image(img, size, fmt=3Dfmt, backing_file=3Dparent,
+                          backing_fmt=3DparentFormat, opts=3Dopts)
         self.files.append(img)
=20
=20
@@ -287,7 +280,7 @@ class TestIncrementalBackupBase(iotests.QMPTestCase):
         for bitmap in self.bitmaps:
             bitmap.cleanup()
         for filename in self.files:
-            try_remove(filename)
+            remove_test_image(filename)
=20
=20
=20
@@ -414,6 +407,8 @@ class TestIncrementalBackup(TestIncrementalBackupBase=
):
         self.check_backups()
=20
=20
+    # blkdebug does not work with an external data file
+    @iotests.skip_for_imgopts(['data_file'])
     def do_transaction_failure_test(self, race=3DFalse):
         # Create a second drive, with pattern:
         drive1 =3D self.add_node('drive1')
@@ -608,6 +603,8 @@ class TestIncrementalBackup(TestIncrementalBackupBase=
):
 class TestIncrementalBackupBlkdebug(TestIncrementalBackupBase):
     '''Incremental backup tests that utilize a BlkDebug filter on drive0=
.'''
=20
+    # blkdebug does not work with an external data file
+    @iotests.skip_for_imgopts(['data_file'])
     def setUp(self):
         drive0 =3D self.add_node('drive0')
         self.img_create(drive0['file'], drive0['fmt'])
--=20
2.21.0



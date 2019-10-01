Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0877ECE587
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 20:11:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B862F2133F
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 20:11:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B862F2133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFOUg-0000Aq-6V
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 16:11:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54613)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iFO8I-00050Q-OY
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 15:48:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iFO8H-00089W-4G
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 15:48:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60188)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iFO89-00085M-Kv; Tue, 01 Oct 2019 15:48:21 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 493DA10DCC92;
 Tue,  1 Oct 2019 19:48:16 +0000 (UTC)
Received: from localhost (unknown [10.40.205.251])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D7C4519C6A;
 Tue,  1 Oct 2019 19:48:15 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 25/67] iotests/118: Honor $IMGOPTS
Date: Tue,  1 Oct 2019 21:46:33 +0200
Message-Id: <20191001194715.2796-26-mreitz@redhat.com>
In-Reply-To: <20191001194715.2796-1-mreitz@redhat.com>
References: <20191001194715.2796-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.64]); Tue, 01 Oct 2019 19:48:16 +0000 (UTC)
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
 tests/qemu-iotests/118 | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/tests/qemu-iotests/118 b/tests/qemu-iotests/118
index ea0b326ae0..634a0b6445 100755
--- a/tests/qemu-iotests/118
+++ b/tests/qemu-iotests/118
@@ -23,7 +23,7 @@ import os
 import stat
 import time
 import iotests
-from iotests import qemu_img
+from iotests import create_test_image, remove_test_image
=20
 old_img =3D os.path.join(iotests.test_dir, 'test0.img')
 new_img =3D os.path.join(iotests.test_dir, 'test1.img')
@@ -301,8 +301,8 @@ class TestInitiallyFilled(GeneralChangeTestsBaseClass=
):
     was_empty =3D False
=20
     def setUp(self):
-        qemu_img('create', '-f', iotests.imgfmt, old_img, '1440k')
-        qemu_img('create', '-f', iotests.imgfmt, new_img, '1440k')
+        create_test_image(old_img, '1440k')
+        create_test_image(new_img, '1440k')
         self.vm =3D iotests.VM()
         if self.use_drive:
             self.vm.add_drive(old_img, 'media=3D%s' % self.media, 'none'=
)
@@ -320,8 +320,8 @@ class TestInitiallyFilled(GeneralChangeTestsBaseClass=
):
=20
     def tearDown(self):
         self.vm.shutdown()
-        os.remove(old_img)
-        os.remove(new_img)
+        remove_test_image(old_img)
+        remove_test_image(new_img)
=20
     def test_insert_on_filled(self):
         result =3D self.vm.qmp('blockdev-add',
@@ -344,7 +344,7 @@ class TestInitiallyEmpty(GeneralChangeTestsBaseClass)=
:
     was_empty =3D True
=20
     def setUp(self):
-        qemu_img('create', '-f', iotests.imgfmt, new_img, '1440k')
+        create_test_image(new_img, '1440k')
         self.vm =3D iotests.VM()
         if self.use_drive:
             self.vm.add_drive(None, 'media=3D%s' % self.media, 'none')
@@ -358,7 +358,7 @@ class TestInitiallyEmpty(GeneralChangeTestsBaseClass)=
:
=20
     def tearDown(self):
         self.vm.shutdown()
-        os.remove(new_img)
+        remove_test_image(new_img)
=20
     def test_remove_on_empty(self):
         result =3D self.vm.qmp('blockdev-open-tray', id=3Dself.device_na=
me)
@@ -394,16 +394,16 @@ class TestChangeReadOnly(ChangeBaseClass):
     device_name =3D 'qdev0'
=20
     def setUp(self):
-        qemu_img('create', '-f', iotests.imgfmt, old_img, '1440k')
-        qemu_img('create', '-f', iotests.imgfmt, new_img, '1440k')
+        create_test_image(old_img, '1440k')
+        create_test_image(new_img, '1440k')
         self.vm =3D iotests.VM()
=20
     def tearDown(self):
         self.vm.shutdown()
         os.chmod(old_img, 0o666)
         os.chmod(new_img, 0o666)
-        os.remove(old_img)
-        os.remove(new_img)
+        remove_test_image(old_img)
+        remove_test_image(new_img)
=20
     def test_ro_ro_retain(self):
         os.chmod(old_img, 0o444)
@@ -640,7 +640,7 @@ class TestBlockJobsAfterCycle(ChangeBaseClass):
     device_name =3D 'qdev0'
=20
     def setUp(self):
-        qemu_img('create', '-f', iotests.imgfmt, old_img, '1440K')
+        create_test_image(old_img, '1440k')
=20
         self.vm =3D iotests.VM()
         self.vm.add_drive_raw("id=3Ddrive0,driver=3Dnull-co,if=3Dnone")
@@ -674,7 +674,7 @@ class TestBlockJobsAfterCycle(ChangeBaseClass):
=20
     def tearDown(self):
         self.vm.shutdown()
-        os.remove(old_img)
+        remove_test_image(old_img)
         try:
             os.remove(new_img)
         except OSError:
--=20
2.21.0



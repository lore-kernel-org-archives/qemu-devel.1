Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AB86C352AA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 20:28:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 080042133F
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 20:28:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 080042133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFOlD-0005zg-7t
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 16:28:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54375)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iFO7y-0004nl-RA
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 15:48:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iFO7x-0007yj-L0
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 15:48:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53596)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iFO7v-0007xH-7H; Tue, 01 Oct 2019 15:48:03 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7AAB12BF7B;
 Tue,  1 Oct 2019 19:48:02 +0000 (UTC)
Received: from localhost (unknown [10.40.205.251])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 14D513D8F;
 Tue,  1 Oct 2019 19:48:01 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 19/67] iotests/045: Honor $IMGOPTS
Date: Tue,  1 Oct 2019 21:46:27 +0200
Message-Id: <20191001194715.2796-20-mreitz@redhat.com>
In-Reply-To: <20191001194715.2796-1-mreitz@redhat.com>
References: <20191001194715.2796-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Tue, 01 Oct 2019 19:48:02 +0000 (UTC)
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
 tests/qemu-iotests/045 | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/tests/qemu-iotests/045 b/tests/qemu-iotests/045
index 01cc038884..781ceb8d19 100755
--- a/tests/qemu-iotests/045
+++ b/tests/qemu-iotests/045
@@ -20,7 +20,7 @@
=20
 import os
 import iotests
-from iotests import qemu_img
+from iotests import create_test_image, remove_test_image
=20
 image0 =3D os.path.join(iotests.test_dir, 'image0')
 image1 =3D os.path.join(iotests.test_dir, 'image1')
@@ -32,11 +32,11 @@ class TestFdSets(iotests.QMPTestCase):
=20
     def setUp(self):
         self.vm =3D iotests.VM()
-        qemu_img('create', '-f', iotests.imgfmt, image0, '128K')
-        qemu_img('create', '-f', iotests.imgfmt, image1, '128K')
-        qemu_img('create', '-f', iotests.imgfmt, image2, '128K')
-        qemu_img('create', '-f', iotests.imgfmt, image3, '128K')
-        qemu_img('create', '-f', iotests.imgfmt, image4, '128K')
+        create_test_image(image0, '128K')
+        create_test_image(image1, '128K')
+        create_test_image(image2, '128K')
+        create_test_image(image3, '128K')
+        create_test_image(image4, '128K')
         self.file0 =3D open(image0, 'r')
         self.file1 =3D open(image1, 'w+')
         self.file2 =3D open(image2, 'r')
@@ -57,11 +57,11 @@ class TestFdSets(iotests.QMPTestCase):
         self.file2.close()
         self.file3.close()
         self.file4.close()
-        os.remove(image0)
-        os.remove(image1)
-        os.remove(image2)
-        os.remove(image3)
-        os.remove(image4)
+        remove_test_image(image0)
+        remove_test_image(image1)
+        remove_test_image(image2)
+        remove_test_image(image3)
+        remove_test_image(image4)
=20
     def test_query_fdset(self):
         result =3D self.vm.qmp('query-fdsets')
@@ -129,7 +129,7 @@ class TestFdSets(iotests.QMPTestCase):
 class TestSCMFd(iotests.QMPTestCase):
     def setUp(self):
         self.vm =3D iotests.VM()
-        qemu_img('create', '-f', iotests.imgfmt, image0, '128K')
+        create_test_image(image0, '128K')
         # Add an unused monitor, to verify it works fine when two monito=
r
         # instances present
         self.vm.add_monitor_null()
@@ -137,7 +137,7 @@ class TestSCMFd(iotests.QMPTestCase):
=20
     def tearDown(self):
         self.vm.shutdown()
-        os.remove(image0)
+        remove_test_image(image0)
=20
     def _send_fd_by_SCM(self):
         ret =3D self.vm.send_fd_scm(file_path=3Dimage0)
--=20
2.21.0



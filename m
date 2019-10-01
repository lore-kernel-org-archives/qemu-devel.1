Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C7DC352AA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 20:56:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDC17215EA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 20:56:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDC17215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFPCM-00048U-HT
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 16:56:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54678)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iFO8M-00055n-VG
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 15:48:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iFO8L-0008C5-RE
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 15:48:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57342)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iFO8I-00089p-7u; Tue, 01 Oct 2019 15:48:26 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 774F33082149;
 Tue,  1 Oct 2019 19:48:25 +0000 (UTC)
Received: from localhost (unknown [10.40.205.251])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 11F245C224;
 Tue,  1 Oct 2019 19:48:24 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 29/67] iotests/139: Honor $IMGOPTS
Date: Tue,  1 Oct 2019 21:46:37 +0200
Message-Id: <20191001194715.2796-30-mreitz@redhat.com>
In-Reply-To: <20191001194715.2796-1-mreitz@redhat.com>
References: <20191001194715.2796-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Tue, 01 Oct 2019 19:48:25 +0000 (UTC)
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
 tests/qemu-iotests/139 | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/tests/qemu-iotests/139 b/tests/qemu-iotests/139
index cbb5a76530..f4cb553116 100755
--- a/tests/qemu-iotests/139
+++ b/tests/qemu-iotests/139
@@ -21,6 +21,7 @@
=20
 import os
 import iotests
+from iotests import create_test_image, remove_test_image
 import time
=20
 base_img =3D os.path.join(iotests.test_dir, 'base.img')
@@ -33,7 +34,7 @@ else:
 class TestBlockdevDel(iotests.QMPTestCase):
=20
     def setUp(self):
-        iotests.qemu_img('create', '-f', iotests.imgfmt, base_img, '1M')
+        create_test_image(base_img, '1M')
         self.vm =3D iotests.VM()
         self.vm.add_device("{},id=3Dvirtio-scsi".format(
             iotests.get_virtio_scsi_device()))
@@ -41,9 +42,8 @@ class TestBlockdevDel(iotests.QMPTestCase):
=20
     def tearDown(self):
         self.vm.shutdown()
-        os.remove(base_img)
-        if os.path.isfile(new_img):
-            os.remove(new_img)
+        remove_test_image(base_img)
+        remove_test_image(new_img)
=20
     # Check whether a BlockDriverState exists
     def checkBlockDriverState(self, node, must_exist =3D True):
@@ -70,8 +70,7 @@ class TestBlockdevDel(iotests.QMPTestCase):
     # Add a BlockDriverState that will be used as overlay for the base_i=
mg BDS
     def addBlockDriverStateOverlay(self, node):
         self.checkBlockDriverState(node, False)
-        iotests.qemu_img('create', '-u', '-f', iotests.imgfmt,
-                         '-b', base_img, new_img, '1M')
+        create_test_image(new_img, '1M', backing_file=3Dbase_img, unsafe=
=3DTrue)
         opts =3D {'driver': iotests.imgfmt,
                 'node-name': node,
                 'backing': None,
@@ -202,7 +201,7 @@ class TestBlockdevDel(iotests.QMPTestCase):
         self.checkBlockDriverState(test, False)
         self.checkBlockDriverState(raw, False)
         self.checkBlockDriverState(blkverify, False)
-        iotests.qemu_img('create', '-f', iotests.imgfmt, new_img, '1M')
+        create_test_image(new_img, '1M')
         node_0 =3D {'driver': iotests.imgfmt,
                   'node-name': test,
                   'file': {'driver': 'file',
@@ -226,7 +225,7 @@ class TestBlockdevDel(iotests.QMPTestCase):
         self.checkBlockDriverState(child0, False)
         self.checkBlockDriverState(child1, False)
         self.checkBlockDriverState(quorum, False)
-        iotests.qemu_img('create', '-f', iotests.imgfmt, new_img, '1M')
+        create_test_image(new_img, '1M')
         child_0 =3D {'driver': iotests.imgfmt,
                    'node-name': child0,
                    'file': {'driver': 'file',
--=20
2.21.0



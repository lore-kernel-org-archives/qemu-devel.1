Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F112EC352AA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 20:37:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3E0620842
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 20:37:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3E0620842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFOtb-0003uQ-Me
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 16:37:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54832)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iFO8a-0005LR-Jv
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 15:48:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iFO8Y-0008Id-J1
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 15:48:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59876)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iFO8W-0008HE-0Z; Tue, 01 Oct 2019 15:48:40 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4370A18C4279;
 Tue,  1 Oct 2019 19:48:39 +0000 (UTC)
Received: from localhost (unknown [10.40.205.251])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D0E835C1D4;
 Tue,  1 Oct 2019 19:48:38 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 35/67] iotests/163: Honor $IMGOPTS
Date: Tue,  1 Oct 2019 21:46:43 +0200
Message-Id: <20191001194715.2796-36-mreitz@redhat.com>
In-Reply-To: <20191001194715.2796-1-mreitz@redhat.com>
References: <20191001194715.2796-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.62]); Tue, 01 Oct 2019 19:48:39 +0000 (UTC)
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
 tests/qemu-iotests/163 | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/tests/qemu-iotests/163 b/tests/qemu-iotests/163
index 92633f1b21..5c5e23f9fc 100755
--- a/tests/qemu-iotests/163
+++ b/tests/qemu-iotests/163
@@ -19,7 +19,8 @@
 #
=20
 import os, random, iotests, struct, qcow2, sys
-from iotests import qemu_img, qemu_io, image_size
+from iotests import create_test_image, remove_test_image, qemu_img, qemu=
_io, \
+        image_size
=20
 test_img =3D os.path.join(iotests.test_dir, 'test.img')
 check_img =3D os.path.join(iotests.test_dir, 'check.img')
@@ -82,22 +83,19 @@ class ShrinkBaseClass(iotests.QMPTestCase):
=20
     def setUp(self):
         if iotests.imgfmt =3D=3D 'raw':
-            qemu_img('create', '-f', iotests.imgfmt, test_img, self.imag=
e_len)
-            qemu_img('create', '-f', iotests.imgfmt, check_img,
-                     self.shrink_size)
+            create_test_image(test_img, self.image_len)
+            create_test_image(check_img, self.shrink_size)
         else:
-            qemu_img('create', '-f', iotests.imgfmt,
-                     '-o', 'cluster_size=3D' + self.cluster_size +
-                     ',refcount_bits=3D' + self.refcount_bits,
-                     test_img, self.image_len)
-            qemu_img('create', '-f', iotests.imgfmt,
-                     '-o', 'cluster_size=3D%s'% self.cluster_size,
-                     check_img, self.shrink_size)
+            create_test_image(test_img, self.image_len,
+                              opts=3D['cluster_size=3D' + self.cluster_s=
ize,
+                                    'refcount_bits=3D' + self.refcount_b=
its])
+            create_test_image(check_img, self.shrink_size,
+                              opts=3D['cluster_size=3D' + self.cluster_s=
ize])
         qemu_io('-c', 'write -P 0xff 0 ' + self.shrink_size, check_img)
=20
     def tearDown(self):
-        os.remove(test_img)
-        os.remove(check_img)
+        remove_test_image(test_img)
+        remove_test_image(check_img)
=20
     def image_verify(self):
         self.assertEqual(image_size(test_img), image_size(check_img),
--=20
2.21.0



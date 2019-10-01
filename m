Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04FB2ECE587
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 21:16:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB4DC20842
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 21:16:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB4DC20842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFPVP-0005Zh-QD
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 17:16:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55012)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iFO8k-0005XI-Ud
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 15:48:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iFO8j-0008PP-Tc
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 15:48:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52072)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iFO8h-0008NW-F9; Tue, 01 Oct 2019 15:48:51 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B4A6AA44AE3;
 Tue,  1 Oct 2019 19:48:50 +0000 (UTC)
Received: from localhost (unknown [10.40.205.251])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4F9F560C5D;
 Tue,  1 Oct 2019 19:48:50 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 40/67] iotests/199: Honor $IMGOPTS
Date: Tue,  1 Oct 2019 21:46:48 +0200
Message-Id: <20191001194715.2796-41-mreitz@redhat.com>
In-Reply-To: <20191001194715.2796-1-mreitz@redhat.com>
References: <20191001194715.2796-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.68]); Tue, 01 Oct 2019 19:48:50 +0000 (UTC)
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
 tests/qemu-iotests/199 | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tests/qemu-iotests/199 b/tests/qemu-iotests/199
index a2c8ecab5a..ec028e1149 100755
--- a/tests/qemu-iotests/199
+++ b/tests/qemu-iotests/199
@@ -21,7 +21,7 @@
 import os
 import iotests
 import time
-from iotests import qemu_img
+from iotests import create_test_image, remove_test_image
=20
 disk_a =3D os.path.join(iotests.test_dir, 'disk_a')
 disk_b =3D os.path.join(iotests.test_dir, 'disk_b')
@@ -33,14 +33,14 @@ class TestDirtyBitmapPostcopyMigration(iotests.QMPTes=
tCase):
     def tearDown(self):
         self.vm_a.shutdown()
         self.vm_b.shutdown()
-        os.remove(disk_a)
-        os.remove(disk_b)
+        remove_test_image(disk_a)
+        remove_test_image(disk_b)
         os.remove(fifo)
=20
     def setUp(self):
         os.mkfifo(fifo)
-        qemu_img('create', '-f', iotests.imgfmt, disk_a, size)
-        qemu_img('create', '-f', iotests.imgfmt, disk_b, size)
+        create_test_image(disk_a, size)
+        create_test_image(disk_b, size)
         self.vm_a =3D iotests.VM(path_suffix=3D'a').add_drive(disk_a)
         self.vm_b =3D iotests.VM(path_suffix=3D'b').add_drive(disk_b)
         self.vm_b.add_incoming("exec: cat '" + fifo + "'")
--=20
2.21.0



Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97925C352AA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 21:13:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25CE82133F
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 21:13:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25CE82133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFPSu-0003Rr-IS
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 17:13:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55624)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iFO9f-0006fr-6o
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 15:49:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iFO9d-0000Se-Rj
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 15:49:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33540)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iFO9Z-0000Pd-Ag; Tue, 01 Oct 2019 15:49:45 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3EBED307D931;
 Tue,  1 Oct 2019 19:49:43 +0000 (UTC)
Received: from localhost (unknown [10.40.205.251])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CC9A160C5D;
 Tue,  1 Oct 2019 19:49:42 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 62/67] iotests/256: Honor $IMGOPTS
Date: Tue,  1 Oct 2019 21:47:10 +0200
Message-Id: <20191001194715.2796-63-mreitz@redhat.com>
In-Reply-To: <20191001194715.2796-1-mreitz@redhat.com>
References: <20191001194715.2796-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Tue, 01 Oct 2019 19:49:43 +0000 (UTC)
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
 tests/qemu-iotests/256 | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tests/qemu-iotests/256 b/tests/qemu-iotests/256
index d2f9212e5a..7c78a123ad 100755
--- a/tests/qemu-iotests/256
+++ b/tests/qemu-iotests/256
@@ -21,13 +21,13 @@
=20
 import os
 import iotests
-from iotests import log
+from iotests import log, create_test_image
=20
 iotests.script_initialize(supported_fmts=3D['qcow2'])
 size =3D 64 * 1024 * 1024
=20
-with iotests.FilePath('img0') as img0_path, \
-     iotests.FilePath('img1') as img1_path, \
+with iotests.ImagePath('img0') as img0_path, \
+     iotests.ImagePath('img1') as img1_path, \
      iotests.FilePath('img0-full') as img0_full_path, \
      iotests.FilePath('img1-full') as img1_full_path, \
      iotests.FilePath('img0-incr') as img0_incr_path, \
@@ -62,8 +62,8 @@ with iotests.FilePath('img0') as img0_path, \
     vm.add_object('iothread,id=3Diothread1')
     vm.add_device('virtio-scsi-pci,id=3Dscsi0,iothread=3Diothread0')
     vm.add_device('virtio-scsi-pci,id=3Dscsi1,iothread=3Diothread1')
-    iotests.qemu_img_create('-f', iotests.imgfmt, img0_path, str(size))
-    iotests.qemu_img_create('-f', iotests.imgfmt, img1_path, str(size))
+    create_test_image(img0_path, size)
+    create_test_image(img1_path, size)
     vm.add_drive(img0_path, interface=3D'none')
     vm.add_device('scsi-hd,id=3Ddevice0,drive=3Ddrive0,bus=3Dscsi0.0')
     vm.add_drive(img1_path, interface=3D'none')
--=20
2.21.0



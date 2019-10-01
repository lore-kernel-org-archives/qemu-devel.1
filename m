Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B96C352AA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 20:34:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9B0620842
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 20:34:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9B0620842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFOqt-0001rX-Dj
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 16:34:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55137)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iFO8r-0005fb-PV
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 15:49:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iFO8q-0008Tm-LX
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 15:49:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44668)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iFO8o-0008Rv-CQ; Tue, 01 Oct 2019 15:48:58 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9891E2A09B2;
 Tue,  1 Oct 2019 19:48:57 +0000 (UTC)
Received: from localhost (unknown [10.40.205.251])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 314665C1D4;
 Tue,  1 Oct 2019 19:48:57 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 43/67] iotests/205: Honor $IMGOPTS
Date: Tue,  1 Oct 2019 21:46:51 +0200
Message-Id: <20191001194715.2796-44-mreitz@redhat.com>
In-Reply-To: <20191001194715.2796-1-mreitz@redhat.com>
References: <20191001194715.2796-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Tue, 01 Oct 2019 19:48:57 +0000 (UTC)
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
 tests/qemu-iotests/205 | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tests/qemu-iotests/205 b/tests/qemu-iotests/205
index 76f6c5fa2b..343fbc296e 100755
--- a/tests/qemu-iotests/205
+++ b/tests/qemu-iotests/205
@@ -22,7 +22,8 @@ import os
 import sys
 import iotests
 import time
-from iotests import qemu_img_create, qemu_io, filter_qemu_io, QemuIoInte=
ractive
+from iotests import create_test_image, remove_test_image, \
+        qemu_io, filter_qemu_io, QemuIoInteractive
=20
 nbd_sock =3D os.path.join(iotests.test_dir, 'nbd_sock')
 nbd_uri =3D 'nbd+unix:///exp?socket=3D' + nbd_sock
@@ -31,7 +32,7 @@ disk =3D os.path.join(iotests.test_dir, 'disk')
=20
 class TestNbdServerRemove(iotests.QMPTestCase):
     def setUp(self):
-        qemu_img_create('-f', iotests.imgfmt, disk, '1M')
+        create_test_image(disk, '1M')
=20
         self.vm =3D iotests.VM().add_drive(disk)
         self.vm.launch()
@@ -51,7 +52,7 @@ class TestNbdServerRemove(iotests.QMPTestCase):
     def tearDown(self):
         self.vm.shutdown()
         os.remove(nbd_sock)
-        os.remove(disk)
+        remove_test_image(disk)
=20
     def remove_export(self, name, mode=3DNone):
         if mode is None:
--=20
2.21.0



Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B511ECE587
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 21:00:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73525215EA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 21:00:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73525215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFPFZ-0008QO-UD
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 17:00:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54695)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iFO8O-00056n-4H
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 15:48:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iFO8M-0008CX-SI
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 15:48:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37702)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iFO8K-0008B0-HN; Tue, 01 Oct 2019 15:48:28 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C0B3F2541;
 Tue,  1 Oct 2019 19:48:27 +0000 (UTC)
Received: from localhost (unknown [10.40.205.251])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5ABE360C63;
 Tue,  1 Oct 2019 19:48:27 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 30/67] iotests/147: Honor $IMGOPTS
Date: Tue,  1 Oct 2019 21:46:38 +0200
Message-Id: <20191001194715.2796-31-mreitz@redhat.com>
In-Reply-To: <20191001194715.2796-1-mreitz@redhat.com>
References: <20191001194715.2796-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.71]); Tue, 01 Oct 2019 19:48:27 +0000 (UTC)
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
 tests/qemu-iotests/147 | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/tests/qemu-iotests/147 b/tests/qemu-iotests/147
index ab8480b9a4..920e44a65c 100755
--- a/tests/qemu-iotests/147
+++ b/tests/qemu-iotests/147
@@ -24,7 +24,8 @@ import socket
 import stat
 import time
 import iotests
-from iotests import cachemode, imgfmt, qemu_img, qemu_nbd, qemu_nbd_earl=
y_pipe
+from iotests import cachemode, imgfmt, create_test_image, remove_test_im=
age, \
+        qemu_nbd, qemu_nbd_early_pipe
=20
 NBD_PORT_START      =3D 32768
 NBD_PORT_END        =3D NBD_PORT_START + 1024
@@ -80,13 +81,13 @@ class NBDBlockdevAddBase(iotests.QMPTestCase):
=20
 class QemuNBD(NBDBlockdevAddBase):
     def setUp(self):
-        qemu_img('create', '-f', iotests.imgfmt, test_img, '64k')
+        create_test_image(test_img, '64k')
         self.vm =3D iotests.VM()
         self.vm.launch()
=20
     def tearDown(self):
         self.vm.shutdown()
-        os.remove(test_img)
+        remove_test_image(test_img)
         try:
             os.remove(unix_socket)
         except OSError:
@@ -127,7 +128,7 @@ class QemuNBD(NBDBlockdevAddBase):
=20
 class BuiltinNBD(NBDBlockdevAddBase):
     def setUp(self):
-        qemu_img('create', '-f', iotests.imgfmt, test_img, '64k')
+        create_test_image(test_img, '64k')
         self.vm =3D iotests.VM()
         self.vm.launch()
         self.server =3D iotests.VM('.server')
@@ -140,7 +141,7 @@ class BuiltinNBD(NBDBlockdevAddBase):
     def tearDown(self):
         self.vm.shutdown()
         self.server.shutdown()
-        os.remove(test_img)
+        remove_test_image(test_img)
         try:
             os.remove(unix_socket)
         except OSError:
--=20
2.21.0



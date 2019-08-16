Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D01C3A59C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 09:39:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1D462086C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 09:39:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1D462086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyYi9-0005ag-MK
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 05:39:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59382)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1hyYdI-0008Gp-L7
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 05:34:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hyYdH-0003Yn-F6
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 05:34:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40722)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hyYdD-0003QP-9S; Fri, 16 Aug 2019 05:34:48 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3570B7FDE5;
 Fri, 16 Aug 2019 09:34:45 +0000 (UTC)
Received: from localhost.localdomain.com (dhcp-200-226.str.redhat.com
 [10.33.200.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 700595C1D6;
 Fri, 16 Aug 2019 09:34:44 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Fri, 16 Aug 2019 11:34:24 +0200
Message-Id: <20190816093439.14262-2-kwolf@redhat.com>
In-Reply-To: <20190816093439.14262-1-kwolf@redhat.com>
References: <20190816093439.14262-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Fri, 16 Aug 2019 09:34:45 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 01/16] iotests/118: Test media change for scsi-cd
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The test covered only floppy and ide-cd. Add scsi-cd as well.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/118     | 20 ++++++++++++++++++++
 tests/qemu-iotests/118.out |  4 ++--
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/118 b/tests/qemu-iotests/118
index 499c5f0901..3c20d2d61f 100755
--- a/tests/qemu-iotests/118
+++ b/tests/qemu-iotests/118
@@ -33,6 +33,8 @@ def interface_to_device_name(interface):
         return 'ide-cd'
     elif interface =3D=3D 'floppy':
         return 'floppy'
+    elif interface =3D=3D 'scsi':
+        return 'scsi-cd'
     else:
         return None
=20
@@ -297,6 +299,8 @@ class TestInitiallyFilled(GeneralChangeTestsBaseClass=
):
         qemu_img('create', '-f', iotests.imgfmt, new_img, '1440k')
         self.vm =3D iotests.VM()
         self.vm.add_drive(old_img, 'media=3D%s' % media, 'none')
+        if interface =3D=3D 'scsi':
+            self.vm.add_device('virtio-scsi-pci')
         self.vm.add_device('%s,drive=3Ddrive0,id=3D%s' %
                            (interface_to_device_name(interface),
                             self.device_name))
@@ -330,6 +334,8 @@ class TestInitiallyEmpty(GeneralChangeTestsBaseClass)=
:
     def setUp(self, media, interface):
         qemu_img('create', '-f', iotests.imgfmt, new_img, '1440k')
         self.vm =3D iotests.VM().add_drive(None, 'media=3D%s' % media, '=
none')
+        if interface =3D=3D 'scsi':
+            self.vm.add_device('virtio-scsi-pci')
         self.vm.add_device('%s,drive=3Ddrive0,id=3D%s' %
                            (interface_to_device_name(interface),
                             self.device_name))
@@ -363,6 +369,20 @@ class TestCDInitiallyEmpty(TestInitiallyEmpty):
     def setUp(self):
         self.TestInitiallyEmpty.setUp(self, 'cdrom', 'ide')
=20
+class TestSCSICDInitiallyFilled(TestInitiallyFilled):
+    TestInitiallyFilled =3D TestInitiallyFilled
+    has_real_tray =3D True
+
+    def setUp(self):
+        self.TestInitiallyFilled.setUp(self, 'cdrom', 'scsi')
+
+class TestSCSICDInitiallyEmpty(TestInitiallyEmpty):
+    TestInitiallyEmpty =3D TestInitiallyEmpty
+    has_real_tray =3D True
+
+    def setUp(self):
+        self.TestInitiallyEmpty.setUp(self, 'cdrom', 'scsi')
+
 class TestFloppyInitiallyFilled(TestInitiallyFilled):
     TestInitiallyFilled =3D TestInitiallyFilled
     has_real_tray =3D False
diff --git a/tests/qemu-iotests/118.out b/tests/qemu-iotests/118.out
index 4823c113d5..b4ff997a8c 100644
--- a/tests/qemu-iotests/118.out
+++ b/tests/qemu-iotests/118.out
@@ -1,5 +1,5 @@
-...............................................................
+........................................................................=
.................
 ----------------------------------------------------------------------
-Ran 63 tests
+Ran 89 tests
=20
 OK
--=20
2.20.1



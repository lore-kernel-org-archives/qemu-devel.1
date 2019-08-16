Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0E1DC3A59D
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 23:30:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 750B32077C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 23:30:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 750B32077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hylg7-0003db-06
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 19:30:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46497)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1hylPk-0006V5-4N
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 19:13:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1hylPi-0005w6-B3
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 19:13:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51230)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1hylPc-0005ps-Ur; Fri, 16 Aug 2019 19:13:37 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 28926308427C;
 Fri, 16 Aug 2019 23:13:36 +0000 (UTC)
Received: from probe.bos.redhat.com (dhcp-17-187.bos.redhat.com [10.18.17.187])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 74B65165D8;
 Fri, 16 Aug 2019 23:13:35 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 16 Aug 2019 19:12:58 -0400
Message-Id: <20190816231318.8650-17-jsnow@redhat.com>
In-Reply-To: <20190816231318.8650-1-jsnow@redhat.com>
References: <20190816231318.8650-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Fri, 16 Aug 2019 23:13:36 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 16/36] iotests: Add virtio-scsi device helper
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
Cc: peter.maydell@linaro.org, jsnow@redhat.com, qemu-stable@nongnu.org,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Seems that it comes up enough.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-id: 20190709232550.10724-17-jsnow@redhat.com
Signed-off-by: John Snow <jsnow@redhat.com>
---
 tests/qemu-iotests/040        | 6 +-----
 tests/qemu-iotests/093        | 6 ++----
 tests/qemu-iotests/139        | 7 ++-----
 tests/qemu-iotests/238        | 5 +----
 tests/qemu-iotests/iotests.py | 4 ++++
 5 files changed, 10 insertions(+), 18 deletions(-)

diff --git a/tests/qemu-iotests/040 b/tests/qemu-iotests/040
index aa0b1847e30..6db9abf8e6e 100755
--- a/tests/qemu-iotests/040
+++ b/tests/qemu-iotests/040
@@ -85,11 +85,7 @@ class TestSingleDrive(ImageCommitTestCase):
         qemu_io('-f', 'raw', '-c', 'write -P 0xab 0 524288', backing_img=
)
         qemu_io('-f', iotests.imgfmt, '-c', 'write -P 0xef 524288 524288=
', mid_img)
         self.vm =3D iotests.VM().add_drive(test_img, "node-name=3Dtop,ba=
cking.node-name=3Dmid,backing.backing.node-name=3Dbase", interface=3D"non=
e")
-        if iotests.qemu_default_machine =3D=3D 's390-ccw-virtio':
-            self.vm.add_device("virtio-scsi-ccw")
-        else:
-            self.vm.add_device("virtio-scsi-pci")
-
+        self.vm.add_device(iotests.get_virtio_scsi_device())
         self.vm.add_device("scsi-hd,id=3Dscsi0,drive=3Ddrive0")
         self.vm.launch()
         self.has_quit =3D False
diff --git a/tests/qemu-iotests/093 b/tests/qemu-iotests/093
index 4b2cac1d0c6..3c4f5173cea 100755
--- a/tests/qemu-iotests/093
+++ b/tests/qemu-iotests/093
@@ -367,10 +367,8 @@ class ThrottleTestGroupNames(iotests.QMPTestCase):
 class ThrottleTestRemovableMedia(iotests.QMPTestCase):
     def setUp(self):
         self.vm =3D iotests.VM()
-        if iotests.qemu_default_machine =3D=3D 's390-ccw-virtio':
-            self.vm.add_device("virtio-scsi-ccw,id=3Dvirtio-scsi")
-        else:
-            self.vm.add_device("virtio-scsi-pci,id=3Dvirtio-scsi")
+        self.vm.add_device("{},id=3Dvirtio-scsi".format(
+            iotests.get_virtio_scsi_device()))
         self.vm.launch()
=20
     def tearDown(self):
diff --git a/tests/qemu-iotests/139 b/tests/qemu-iotests/139
index 933b45121a9..2176ea51ba8 100755
--- a/tests/qemu-iotests/139
+++ b/tests/qemu-iotests/139
@@ -35,11 +35,8 @@ class TestBlockdevDel(iotests.QMPTestCase):
     def setUp(self):
         iotests.qemu_img('create', '-f', iotests.imgfmt, base_img, '1M')
         self.vm =3D iotests.VM()
-        if iotests.qemu_default_machine =3D=3D 's390-ccw-virtio':
-            self.vm.add_device("virtio-scsi-ccw,id=3Dvirtio-scsi")
-        else:
-            self.vm.add_device("virtio-scsi-pci,id=3Dvirtio-scsi")
-
+        self.vm.add_device("{},id=3Dvirtio-scsi".format(
+            iotests.get_virtio_scsi_device()))
         self.vm.launch()
=20
     def tearDown(self):
diff --git a/tests/qemu-iotests/238 b/tests/qemu-iotests/238
index 08bc7e6b4be..e5ac2b2ff84 100755
--- a/tests/qemu-iotests/238
+++ b/tests/qemu-iotests/238
@@ -23,10 +23,7 @@ import os
 import iotests
 from iotests import log
=20
-if iotests.qemu_default_machine =3D=3D 's390-ccw-virtio':
-    virtio_scsi_device =3D 'virtio-scsi-ccw'
-else:
-    virtio_scsi_device =3D 'virtio-scsi-pci'
+virtio_scsi_device =3D iotests.get_virtio_scsi_device()
=20
 vm =3D iotests.VM()
 vm.launch()
diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.p=
y
index 385dbad16ac..84438e837cb 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -164,6 +164,10 @@ def qemu_io_silent(*args):
                          (-exitcode, ' '.join(args)))
     return exitcode
=20
+def get_virtio_scsi_device():
+    if qemu_default_machine =3D=3D 's390-ccw-virtio':
+        return 'virtio-scsi-ccw'
+    return 'virtio-scsi-pci'
=20
 class QemuIoInteractive:
     def __init__(self, *args):
--=20
2.21.0



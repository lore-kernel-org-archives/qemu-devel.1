Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CA52C04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 21:32:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A33B20657
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 21:32:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A33B20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42552 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYzzR-00011o-Au
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 17:32:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51595)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <crosa@redhat.com>) id 1hYzu9-0005bg-9v
 for qemu-devel@nongnu.org; Thu, 06 Jun 2019 17:26:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1hYziZ-000875-EJ
 for qemu-devel@nongnu.org; Thu, 06 Jun 2019 17:14:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38718)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1hYziZ-00086N-8b
 for qemu-devel@nongnu.org; Thu, 06 Jun 2019 17:14:39 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id CB4A431628F9;
 Thu,  6 Jun 2019 21:14:30 +0000 (UTC)
Received: from dhcp-17-47.bos.redhat.com (dhcp-17-47.bos.redhat.com
 [10.18.17.47])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D892C10A1832;
 Thu,  6 Jun 2019 21:14:29 +0000 (UTC)
From: Cleber Rosa <crosa@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu,  6 Jun 2019 17:14:13 -0400
Message-Id: <20190606211414.8681-7-crosa@redhat.com>
In-Reply-To: <20190606211414.8681-1-crosa@redhat.com>
References: <20190606211414.8681-1-crosa@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Thu, 06 Jun 2019 21:14:30 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v6 6/7] Add "boot_linux" test for aarch64 and
 virt machine type
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Samuel Ortiz <sameo@linux.intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This boots a Fedora 30 guest using edk2.

During the first Fedora 30 boot on aarch64, there's a filesystem
resize operation.  The typical output is similar to:

   [  203.798938] EXT4-fs (sda2): resizing filesystem from 999168 to 9996=
75 blocks
   [  203.823032] EXT4-fs (sda2): resized filesystem to 999675

It was observed that, when using virtio-blk, it seems that random
numbers are exhausted, unless an RNG device is given.  Interestingly
the same was *not* observed with virtio-scsi.  In accordance with the
other similar tests, this uses the default devices on the machine
model used (virtio-blk here) and adds the necessary options to make
it operation.

In the future, other combinations (such as virtio-scsi) can, should
and will be tested.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 tests/acceptance/boot_linux.py | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/tests/acceptance/boot_linux.py b/tests/acceptance/boot_linux=
.py
index 2180f69a12..9b54a0241f 100644
--- a/tests/acceptance/boot_linux.py
+++ b/tests/acceptance/boot_linux.py
@@ -10,7 +10,7 @@
=20
 import os
=20
-from avocado_qemu import Test
+from avocado_qemu import Test, SRC_ROOT_DIR
=20
 from avocado.utils import cloudinit
 from avocado.utils import network
@@ -81,3 +81,23 @@ class BootLinuxX8664(BootLinux):
         self.vm.set_machine('q35')
         self.vm.launch()
         self.wait_for_boot_confirmation()
+
+
+class BootLinuxAarch64(BootLinux):
+
+    chksum =3D '528f2659a410e3a8bd47d32a6ac4e6c5729f1d28dbad0763b4282a75=
3ddcab1f'
+
+    def test_virt(self):
+        """
+        :avocado: tags=3Darch:aarch64
+        :avocado: tags=3Dmachine:virt
+        """
+        self.vm.set_machine('virt')
+        self.vm.add_args('-cpu', 'cortex-a53')
+        self.vm.add_args('-bios',
+                         os.path.join(SRC_ROOT_DIR, 'pc-bios',
+                                      'edk2-aarch64-code.fd'))
+        self.vm.add_args('-device', 'virtio-rng-pci,rng=3Drng0')
+        self.vm.add_args('-object', 'rng-random,id=3Drng0,filename=3D/de=
v/urandom')
+        self.vm.launch()
+        self.wait_for_boot_confirmation()
--=20
2.21.0



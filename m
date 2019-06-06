Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE88BC28EB9
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 23:07:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B86ED20684
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 23:07:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B86ED20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44750 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZ1U6-0000dT-05
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 19:07:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40066)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hZ1RX-0007N1-4Q
 for qemu-devel@nongnu.org; Thu, 06 Jun 2019 19:05:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hZ1Pf-0001if-1b
 for qemu-devel@nongnu.org; Thu, 06 Jun 2019 19:03:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49744)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hZ1Pd-0001c8-3p
 for qemu-devel@nongnu.org; Thu, 06 Jun 2019 19:03:14 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D139280F91;
 Thu,  6 Jun 2019 23:02:48 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-32.brq.redhat.com [10.40.204.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C8C995D9C6;
 Thu,  6 Jun 2019 23:02:42 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>,
	qemu-devel@nongnu.org
Date: Fri,  7 Jun 2019 01:02:31 +0200
Message-Id: <20190606230232.9888-2-philmd@redhat.com>
In-Reply-To: <20190606230232.9888-1-philmd@redhat.com>
References: <20190606230232.9888-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Thu, 06 Jun 2019 23:03:00 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 1/2] BootLinuxConsoleTest: Test nanoMIPS
 kernels on the I7200 CPU
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
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Similar to the x86_64/pc test, it boots a Linux kernel on a Malta
machine and verify the serial is working.

Use the documentation added in commit f7d257cb4a17 to test
nanoMIPS kernels and the I7200 CPU.

This test can be run using:

  $ avocado --show=3Dconsole run -t arch:mipsel tests/acceptance/boot_lin=
ux_console.py
  console: [    0.000000] Linux version 4.15.18-00432-gb2eb9a8b (emubuild=
@mipscs563) (gcc version 6.3.0 (Codescape GNU Tools 2018.04-02 for nanoMI=
PS Linux)) #1 SMP Wed Jun 27 11:10:08 PDT 2018
  console: [    0.000000] GCRs appear to have been moved (expected them a=
t 0x1fbf8000)!
  console: [    0.000000] GCRs appear to have been moved (expected them a=
t 0x1fbf8000)!
  console: [    0.000000] CPU0 revision is: 00010000 (MIPS GENERIC QEMU)
  console: [    0.000000] MIPS: machine is mti,malta
  console: [    0.000000] Determined physical RAM map:
  console: [    0.000000]  memory: 08000000 @ 00000000 (usable)
  console: [    0.000000] earlycon: ns16550a0 at I/O port 0x3f8 (options =
'38400n8')
  console: [    0.000000] bootconsole [ns16550a0] enabled
  console: [    0.000000] User-defined physical RAM map:
  console: [    0.000000]  memory: 10000000 @ 00000000 (usable)
  console: [    0.000000] Initrd not found or empty - disabling initrd
  console: [    0.000000] MIPS CPS SMP unable to proceed without a CM
  console: [    0.000000] Primary instruction cache 32kB, VIPT, 4-way, li=
nesize 32 bytes.
  console: [    0.000000] Primary data cache 32kB, 4-way, VIPT, cache ali=
ases, linesize 32 bytes
  console: [    0.000000] This processor doesn't support highmem. -262144=
k highmem ignored
  console: [    0.000000] Zone ranges:
  console: [    0.000000]   Normal   [mem 0x0000000000000000-0x000000000f=
ffffff]
  console: [    0.000000]   HighMem  empty
  console: [    0.000000] Movable zone start for each node
  console: [    0.000000] Early memory node ranges
  console: [    0.000000]   node   0: [mem 0x0000000000000000-0x000000000=
fffffff]
  console: [    0.000000] Initmem setup node 0 [mem 0x0000000000000000-0x=
000000000fffffff]
  console: [    0.000000] random: get_random_bytes called from start_kern=
el+0x60/0x2f0 with crng_init=3D0
  console: [    0.000000] percpu: Embedded 16 pages/cpu @(ptrval) s36620 =
r8192 d20724 u65536
  console: [    0.000000] Built 1 zonelists, mobility grouping on.  Total=
 pages: 64960
  console: [    0.000000] Kernel command line: printk.time=3D0 mem=3D256m=
@@0x0 console=3DttyS0 earlycon

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Acked-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
v3: No change
---
 tests/acceptance/boot_linux_console.py | 58 ++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/bo=
ot_linux_console.py
index 89a2179efc..a7a735c90d 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -10,6 +10,8 @@
=20
 import os
 import logging
+import lzma
+import shutil
=20
 from avocado_qemu import Test
 from avocado.utils import process
@@ -138,6 +140,62 @@ class BootLinuxConsole(Test):
         console_pattern =3D 'Kernel command line: %s' % kernel_command_l=
ine
         self.wait_for_console_pattern(console_pattern)
=20
+    def do_test_mips_malta32el_nanomips(self, kernel_url, kernel_hash):
+        kernel_path_xz =3D self.fetch_asset(kernel_url, asset_hash=3Dker=
nel_hash)
+        kernel_path =3D self.workdir + "kernel"
+        with lzma.open(kernel_path_xz, 'rb') as f_in:
+            with open(kernel_path, 'wb') as f_out:
+                shutil.copyfileobj(f_in, f_out)
+
+        self.vm.set_machine('malta')
+        self.vm.set_console()
+        kernel_command_line =3D (self.KERNEL_COMMON_COMMAND_LINE
+                               + 'mem=3D256m@@0x0 '
+                               + 'console=3DttyS0')
+        self.vm.add_args('-no-reboot',
+                         '-cpu', 'I7200',
+                         '-kernel', kernel_path,
+                         '-append', kernel_command_line)
+        self.vm.launch()
+        console_pattern =3D 'Kernel command line: %s' % kernel_command_l=
ine
+        self.wait_for_console_pattern(console_pattern)
+
+    def test_mips_malta32el_nanomips_4k(self):
+        """
+        :avocado: tags=3Darch:mipsel
+        :avocado: tags=3Dmachine:malta
+        :avocado: tags=3Dendian:little
+        """
+        kernel_url =3D ('https://mipsdistros.mips.com/LinuxDistro/nanomi=
ps/'
+                      'kernels/v4.15.18-432-gb2eb9a8b07a1-20180627102142=
/'
+                      'generic_nano32r6el_page4k.xz')
+        kernel_hash =3D '477456aafd2a0f1ddc9482727f20fe9575565dd6'
+        self.do_test_mips_malta32el_nanomips(kernel_url, kernel_hash)
+
+    def test_mips_malta32el_nanomips_16k_up(self):
+        """
+        :avocado: tags=3Darch:mipsel
+        :avocado: tags=3Dmachine:malta
+        :avocado: tags=3Dendian:little
+        """
+        kernel_url =3D ('https://mipsdistros.mips.com/LinuxDistro/nanomi=
ps/'
+                      'kernels/v4.15.18-432-gb2eb9a8b07a1-20180627102142=
/'
+                      'generic_nano32r6el_page16k_up.xz')
+        kernel_hash =3D 'e882868f944c71c816e832e2303b7874d044a7bc'
+        self.do_test_mips_malta32el_nanomips(kernel_url, kernel_hash)
+
+    def test_mips_malta32el_nanomips_64k_dbg(self):
+        """
+        :avocado: tags=3Darch:mipsel
+        :avocado: tags=3Dmachine:malta
+        :avocado: tags=3Dendian:little
+        """
+        kernel_url =3D ('https://mipsdistros.mips.com/LinuxDistro/nanomi=
ps/'
+                      'kernels/v4.15.18-432-gb2eb9a8b07a1-20180627102142=
/'
+                      'generic_nano32r6el_page64k_dbg.xz')
+        kernel_hash =3D '18d1c68f2e23429e266ca39ba5349ccd0aeb7180'
+        self.do_test_mips_malta32el_nanomips(kernel_url, kernel_hash)
+
     def test_aarch64_virt(self):
         """
         :avocado: tags=3Darch:aarch64
--=20
2.20.1



Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3D29C282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 16:22:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B05D020879
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 16:22:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tm4obKTu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B05D020879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40274 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTqUb-0005Eh-Tb
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 12:22:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37535)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1hTqQR-0002P5-RC
	for qemu-devel@nongnu.org; Thu, 23 May 2019 12:18:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1hTqQQ-0006U3-9H
	for qemu-devel@nongnu.org; Thu, 23 May 2019 12:18:39 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:36179)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1hTqQQ-0006TS-1g
	for qemu-devel@nongnu.org; Thu, 23 May 2019 12:18:38 -0400
Received: by mail-wr1-x442.google.com with SMTP id s17so6969202wru.3
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 09:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=nFvZpg8Irc5ptGUvIODQuDLuD3XEDRd8WNB3Ec4ZO0M=;
	b=Tm4obKTuCLSPdNEWoKtut3FIVhnCINvxs9fvJH8YD/mloZUl6bO8T4QTVViN92uw6h
	zb0kBnXJ2G72+/83WnRqTpgCCxDcT7/1KbAbnStiAjXVx4k+9DaCxsXP01sMtaIcFLGd
	KyNrydutQ98jfwKh0V0QNymGFDnQrKdM0eB7PYFMNZV44sWzb871M4BztJd8Ganlq0ag
	sjaEegbvWia9lwuptoppMoXx3RECdBfT9D4aoFbAbsd0dlwd7XJWbxmiNqHwOO+T7Xd7
	WruiSHbFAd9e5HKwIb5MoEYR4FsysITwayoePbX+CmD+oA0ZIZDhTwEVQUWm//d8ULaG
	7bcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	bh=nFvZpg8Irc5ptGUvIODQuDLuD3XEDRd8WNB3Ec4ZO0M=;
	b=fYLc+ogcmrdkjP/WEFgkXsgrUe5rXfikCioopuh+Ou0Z3UDM9WYJOmI/TEpnMBenoQ
	29gta3PCY9mLp/lNgojLOBG+B2MbLxA0Im86GJyfHnmM7STjBR9+138fJaowk7Ni1NX+
	8SAY1nTChdRfa3ZGHJ3p/1LT/ken43Z8PIbZ/pS4R5W861nLG2K9C37Au96U3KPLNpvC
	RB28gNofJ3bUEOLSTixkOYDUaB9GAbTmwd8jZSA3RFU6oc87RZDFn7xVjF8QzZIArKS+
	hh2869G7solyBVRaY6MhEEpRrFSTffJxN/RhUvDMAJtGAnpC2fbH7zK48rJq6m9Z7btG
	FqmQ==
X-Gm-Message-State: APjAAAUgQvCSgldFfRMgBlylEaXH6oON1nDu5lFevHsHWx2/IUciSyPa
	Sq3TEQ6vN8LJvwEDy9Loh8U08dICaqg=
X-Google-Smtp-Source: APXvYqwbzthDgszMhapSbt5T6578H3PxDMnFPadeqc0G6s2T8Q6Yl1TW9CKFG0i4GBZMtTRVvhjmdg==
X-Received: by 2002:adf:fc46:: with SMTP id e6mr31017852wrs.298.1558628317175; 
	Thu, 23 May 2019 09:18:37 -0700 (PDT)
Received: from x1.local (228.red-83-52-173.dynamicip.rima-tde.net.
	[83.52.173.228]) by smtp.gmail.com with ESMTPSA id
	q16sm10273222wmj.17.2019.05.23.09.18.36
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 23 May 2019 09:18:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
	Cleber Rosa <crosa@redhat.com>
Date: Thu, 23 May 2019 18:18:30 +0200
Message-Id: <20190523161832.22490-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190523161832.22490-1-f4bug@amsat.org>
References: <20190523161832.22490-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PATCH v2 2/4] BootLinuxConsoleTest: Test nanoMIPS
 kernels on the I7200 CPU
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>,
	Aurelien Jarno <aurelien@aurel32.net>,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Similar to the x86_64/pc test, it boots a Linux kernel on a Malta
machine and verify the serial is working.

Use the documentation added in commit f7d257cb4a17 to test
nanoMIPS kernels and the I7200 CPU.

This test can be run using:

  $ avocado --show=console run -t arch:mipsel tests/acceptance/boot_linux_console.py
  console: [    0.000000] Linux version 4.15.18-00432-gb2eb9a8b (emubuild@mipscs563) (gcc version 6.3.0 (Codescape GNU Tools 2018.04-02 for nanoMIPS Linux)) #1 SMP Wed Jun 27 11:10:08 PDT 2018
  console: [    0.000000] GCRs appear to have been moved (expected them at 0x1fbf8000)!
  console: [    0.000000] GCRs appear to have been moved (expected them at 0x1fbf8000)!
  console: [    0.000000] CPU0 revision is: 00010000 (MIPS GENERIC QEMU)
  console: [    0.000000] MIPS: machine is mti,malta
  console: [    0.000000] Determined physical RAM map:
  console: [    0.000000]  memory: 08000000 @ 00000000 (usable)
  console: [    0.000000] earlycon: ns16550a0 at I/O port 0x3f8 (options '38400n8')
  console: [    0.000000] bootconsole [ns16550a0] enabled
  console: [    0.000000] User-defined physical RAM map:
  console: [    0.000000]  memory: 10000000 @ 00000000 (usable)
  console: [    0.000000] Initrd not found or empty - disabling initrd
  console: [    0.000000] MIPS CPS SMP unable to proceed without a CM
  console: [    0.000000] Primary instruction cache 32kB, VIPT, 4-way, linesize 32 bytes.
  console: [    0.000000] Primary data cache 32kB, 4-way, VIPT, cache aliases, linesize 32 bytes
  console: [    0.000000] This processor doesn't support highmem. -262144k highmem ignored
  console: [    0.000000] Zone ranges:
  console: [    0.000000]   Normal   [mem 0x0000000000000000-0x000000000fffffff]
  console: [    0.000000]   HighMem  empty
  console: [    0.000000] Movable zone start for each node
  console: [    0.000000] Early memory node ranges
  console: [    0.000000]   node   0: [mem 0x0000000000000000-0x000000000fffffff]
  console: [    0.000000] Initmem setup node 0 [mem 0x0000000000000000-0x000000000fffffff]
  console: [    0.000000] random: get_random_bytes called from start_kernel+0x60/0x2f0 with crng_init=0
  console: [    0.000000] percpu: Embedded 16 pages/cpu @(ptrval) s36620 r8192 d20724 u65536
  console: [    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 64960
  console: [    0.000000] Kernel command line: printk.time=0 mem=256m@@0x0 console=ttyS0 earlycon

Acked-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/acceptance/boot_linux_console.py | 59 ++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
index 6aa084e049..9d1aea7708 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -4,12 +4,15 @@
 #
 # Author:
 #  Cleber Rosa <crosa@redhat.com>
+#  Philippe Mathieu-Daudé <f4bug@amsat.org>
 #
 # This work is licensed under the terms of the GNU GPL, version 2 or
 # later.  See the COPYING file in the top-level directory.
 
 import os
 import logging
+import lzma
+import shutil
 
 from avocado_qemu import Test
 from avocado.utils import process
@@ -136,6 +139,62 @@ class BootLinuxConsole(Test):
         console_pattern = 'Kernel command line: %s' % kernel_command_line
         self.wait_for_console_pattern(console_pattern)
 
+    def do_test_mips_malta32el_nanomips(self, kernel_url, kernel_hash):
+        kernel_path_xz = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
+        kernel_path = self.workdir + "kernel"
+        with lzma.open(kernel_path_xz, 'rb') as f_in:
+            with open(kernel_path, 'wb') as f_out:
+                shutil.copyfileobj(f_in, f_out)
+
+        self.vm.set_machine('malta')
+        self.vm.set_console()
+        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE
+                               + 'mem=256m@@0x0 '
+                               + 'console=ttyS0')
+        self.vm.add_args('-no-reboot',
+                         '-cpu', 'I7200',
+                         '-kernel', kernel_path,
+                         '-append', kernel_command_line)
+        self.vm.launch()
+        console_pattern = 'Kernel command line: %s' % kernel_command_line
+        self.wait_for_console_pattern(console_pattern)
+
+    def test_mips_malta32el_nanomips_4k(self):
+        """
+        :avocado: tags=arch:mipsel
+        :avocado: tags=machine:malta
+        :avocado: tags=endian:little
+        """
+        kernel_url = ('https://mipsdistros.mips.com/LinuxDistro/nanomips/'
+                      'kernels/v4.15.18-432-gb2eb9a8b07a1-20180627102142/'
+                      'generic_nano32r6el_page4k.xz')
+        kernel_hash = '477456aafd2a0f1ddc9482727f20fe9575565dd6'
+        self.do_test_mips_malta32el_nanomips(kernel_url, kernel_hash)
+
+    def test_mips_malta32el_nanomips_16k_up(self):
+        """
+        :avocado: tags=arch:mipsel
+        :avocado: tags=machine:malta
+        :avocado: tags=endian:little
+        """
+        kernel_url = ('https://mipsdistros.mips.com/LinuxDistro/nanomips/'
+                      'kernels/v4.15.18-432-gb2eb9a8b07a1-20180627102142/'
+                      'generic_nano32r6el_page16k_up.xz')
+        kernel_hash = 'e882868f944c71c816e832e2303b7874d044a7bc'
+        self.do_test_mips_malta32el_nanomips(kernel_url, kernel_hash)
+
+    def test_mips_malta32el_nanomips_64k_dbg(self):
+        """
+        :avocado: tags=arch:mipsel
+        :avocado: tags=machine:malta
+        :avocado: tags=endian:little
+        """
+        kernel_url = ('https://mipsdistros.mips.com/LinuxDistro/nanomips/'
+                      'kernels/v4.15.18-432-gb2eb9a8b07a1-20180627102142/'
+                      'generic_nano32r6el_page64k_dbg.xz')
+        kernel_hash = '18d1c68f2e23429e266ca39ba5349ccd0aeb7180'
+        self.do_test_mips_malta32el_nanomips(kernel_url, kernel_hash)
+
     def test_aarch64_virt(self):
         """
         :avocado: tags=arch:aarch64
-- 
2.19.1



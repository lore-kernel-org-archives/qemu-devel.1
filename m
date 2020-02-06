Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE809C35247
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 01:38:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88B3D20658
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 01:38:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XGEGvDsk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88B3D20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izW7p-0003Ey-NF
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 20:38:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54630)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1izVos-0001Vo-Dv
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 20:19:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1izVon-0004wB-W9
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 20:19:02 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:33624)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1izVon-0004qS-O3; Wed, 05 Feb 2020 20:18:57 -0500
Received: by mail-wm1-x341.google.com with SMTP id m10so5693957wmc.0;
 Wed, 05 Feb 2020 17:18:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8gSk/HX2AdgIZvykLb4KtPojBa3jZM1avH6O2vAh72A=;
 b=XGEGvDskFUrx/HYh4AyvduBZcy8cDpjIN1SPITFYSUscQAibtLFiDSe7y2OanqbV2m
 sZCboCt+09eVHwIJq4VhY4kmJIk/NS2nfMliLlSTu7m3AF7TvSD1FRRROWKzBAekPOoP
 qEfxTDCeknqLW1MiUrCzayELqzoKKwPT2Erp4DkwQUhorWsT1cvkcZty+nsS/ZMLrsS/
 eID4jYhRwZwmi5Z/XhS7Xa+ULr4rX6ok9W48M0rkd++jcor+Q03ab4f9GrGMHAj0HF8/
 UBc2ArZP1mnLePMLafR5+IjXwics80Aff9tkzsv/JHY3TUe6hmxfshgy2Ljt9OrTDioB
 EMRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=8gSk/HX2AdgIZvykLb4KtPojBa3jZM1avH6O2vAh72A=;
 b=SKogVlyTyy4Y9MaMKBNVHf2/3pnr8wHE3LE/fwC7I7ged0FoDCH2jXcbArB55eU48D
 KHimTy/KlPxAaJy+hmw/CFDFsKdk9mHRlaCJusVcMmKUS2a9XPlDJt+iyjNCHf2IHrlw
 /bggRQPfZgiTd96Gm1QKXcVeJ3ay5tBvC2D8gDC4+E3RMaeHDHqsfNzqk0uIQzh16dtS
 HMN9D4AWtUJwZubWGSlJSZ3v038W26cuA0iZvNEE2HdhgHAROz8dBHxSNCNmgijmiNrU
 BCQCgUGww+W179B2w1bEIViLtYUTMsJPAOLZstxdgp7V+1Ko5Ednw5nUcKJCyAUlLUKB
 yTCA==
X-Gm-Message-State: APjAAAVbNy1uuA2BonRk5FarxRi0A5dWXlKh9csXA/A7fp6h1bhISaFp
 KMv9M4j7FX4vNQY1C7X9i0MpNsSQ
X-Google-Smtp-Source: APXvYqy8ORakeweCaezBp+XyQfV1y0ubQIWvhLiNIznIFWEU7/sItLAW9prkTlUldWsL6G0fX7oRAQ==
X-Received: by 2002:a7b:c318:: with SMTP id k24mr689639wmj.54.1580951936299;
 Wed, 05 Feb 2020 17:18:56 -0800 (PST)
Received: from localhost.localdomain (2.red-95-127-156.staticip.rima-tde.net.
 [95.127.156.2])
 by smtp.gmail.com with ESMTPSA id w13sm2053526wru.38.2020.02.05.17.18.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2020 17:18:55 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 27/30] tests/acceptance/boot_linux_console: Test the raspi1
 AUX console
Date: Thu,  6 Feb 2020 02:17:53 +0100
Message-Id: <20200206011756.2413-28-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200206011756.2413-1-f4bug@amsat.org>
References: <20200206011756.2413-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Joaquin de Andres <me@xcancerberox.com.ar>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Esteban Bosse <estebanbosse@gmail.com>, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  $ avocado --show=app,console run -t device:bcm2835_aux tests/acceptance/
  JOB ID     : a8846d69d52da701681b1d17f80ef299009fd078
  JOB LOG    : avocado/job-results/job-2020-02-05T23.44-a8846d6/job.log
   (1/3) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_raspi0_uart1:
  console: [    0.000000] Booting Linux on physical CPU 0x0
  console: [    0.000000] Linux version 4.14.98+ (dom@dom-XPS-13-9370) (gcc version 4.9.3 (crosstool-NG crosstool-ng-1.22.0-88-g8460611)) #1200 Tue Feb 12 20:11:02 GMT 2019
  console: [    0.000000] CPU: ARMv6-compatible processor [410fb767] revision 7 (ARMv7), cr=00c5387d
  console: [    0.000000] CPU: VIPT aliasing data cache, unknown instruction cache
  console: [    0.000000] OF: fdt: Machine model: Raspberry Pi Zero W
  console: [    0.000000] earlycon: uart8250 at MMIO32 0x20215040 (options '')
  console: [    0.000000] bootconsole [uart8250] enabled
  console: [    0.000000] Memory policy: Data cache writeback
  console: [    0.000000] cma: Reserved 8 MiB at 0x1b800000
  console: [    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 113680
  console: [    0.000000] Kernel command line: printk.time=0 earlycon=uart8250,mmio32,0x20215040 console=ttyS1,115200
  PASS (13.31 s)
   (2/3) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_raspi1_uart1:
  console: [    0.000000] Booting Linux on physical CPU 0x0
  console: [    0.000000] Linux version 4.14.98+ (dom@dom-XPS-13-9370) (gcc version 4.9.3 (crosstool-NG crosstool-ng-1.22.0-88-g8460611)) #1200 Tue Feb 12 20:11:02 GMT 2019
  console: [    0.000000] CPU: ARMv6-compatible processor [410fb767] revision 7 (ARMv7), cr=00c5387d
  console: [    0.000000] CPU: VIPT aliasing data cache, unknown instruction cache
  console: [    0.000000] OF: fdt: Machine model: Raspberry Pi Model B
  console: [    0.000000] earlycon: uart8250 at MMIO32 0x20215040 (options '')
  console: [    0.000000] bootconsole [uart8250] enabled
  console: [    0.000000] Memory policy: Data cache writeback
  console: [    0.000000] cma: Reserved 8 MiB at 0x1b800000
  console: [    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 113680
  console: [    0.000000] Kernel command line: printk.time=0 earlycon=uart8250,mmio32,0x20215040 console=ttyS1,115200
  PASS (13.39 s)
   (3/3) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_raspi2_uart1:
  console: [    0.000000] Booting Linux on physical CPU 0xf00
  console: [    0.000000] Linux version 4.14.98-v7+ (dom@dom-XPS-13-9370) (gcc version 4.9.3 (crosstool-NG crosstool-ng-1.22.0-88-g8460611)) #1200 SMP Tue Feb 12 20:27:48 GMT 2019
  console: [    0.000000] CPU: ARMv7 Processor [410fc075] revision 5 (ARMv7), cr=10c5387d
  console: [    0.000000] CPU: div instructions available: patching division code
  console: [    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
  console: [    0.000000] OF: fdt: Machine model: Raspberry Pi 2 Model B
  console: [    0.000000] earlycon: uart8250 at MMIO32 0x3f215040 (options '')
  console: [    0.000000] bootconsole [uart8250] enabled
  console: [    0.000000] Memory policy: Data cache writealloc
  console: [    0.000000] cma: Reserved 8 MiB at 0x3b800000
  console: [    0.000000] percpu: Embedded 17 pages/cpu @baf2e000 s38720 r8192 d22720 u69632
  console: [    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 243600
  console: [    0.000000] Kernel command line: printk.time=0 earlycon=uart8250,mmio32,0x3f215040 console=ttyS1,115200
  PASS (12.46 s)
  RESULTS    : PASS 3 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0 | CANCEL 0
  JOB TIME   : 39.60 s

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/acceptance/boot_linux_console.py | 37 +++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
index df6600ab2f..7210acd977 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -337,6 +337,14 @@ class BootLinuxConsole(Test):
                 1: 'earlycon=pl011,0x20201000 console=ttyAMA0',
                 2: 'earlycon=pl011,0x3f201000 console=ttyAMA0',
             },
+            'bcm2835_aux': {
+                0: 'earlycon=uart8250,mmio32,0x20215040 console=ttyS1,115200',
+                1: 'earlycon=uart8250,mmio32,0x20215040 console=ttyS1,115200',
+                2: 'earlycon=uart8250,mmio32,0x3f215040 console=ttyS1,115200',
+            },
+        }
+        uart_id = {
+            'pl011': 0, 'bcm2835_aux': 1,
         }
         kernel = {
             0: '/boot/kernel.img',
@@ -356,7 +364,7 @@ class BootLinuxConsole(Test):
         kernel_path = self.extract_from_deb(deb_path, kernel[version])
         dtb_path = self.extract_from_deb(deb_path, dtb[version])
 
-        self.vm.set_console()
+        self.vm.set_console(console_index=uart_id[uart_model])
         kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
                                serial_kernel_cmdline[uart_model][version])
         self.vm.add_args('-kernel', kernel_path,
@@ -375,6 +383,15 @@ class BootLinuxConsole(Test):
         """
         self.do_test_arm_raspi(0, 'pl011')
 
+    def test_arm_raspi0_uart1(self):
+        """
+        :avocado: tags=arch:arm
+        :avocado: tags=machine:raspi0
+        :avocado: tags=cpu:arm1176
+        :avocado: tags=device:bcm2835_aux
+        """
+        self.do_test_arm_raspi(0, 'bcm2835_aux')
+
     def test_arm_raspi1_uart0(self):
         """
         :avocado: tags=arch:arm
@@ -384,6 +401,15 @@ class BootLinuxConsole(Test):
         """
         self.do_test_arm_raspi(1, 'pl011')
 
+    def test_arm_raspi1_uart1(self):
+        """
+        :avocado: tags=arch:arm
+        :avocado: tags=machine:raspi1
+        :avocado: tags=cpu:arm1176
+        :avocado: tags=device:bcm2835_aux
+        """
+        self.do_test_arm_raspi(1, 'bcm2835_aux')
+
     def test_arm_raspi2_uart0(self):
         """
         :avocado: tags=arch:arm
@@ -393,6 +419,15 @@ class BootLinuxConsole(Test):
         """
         self.do_test_arm_raspi(2, 'pl011')
 
+    def test_arm_raspi2_uart1(self):
+        """
+        :avocado: tags=arch:arm
+        :avocado: tags=machine:raspi2
+        :avocado: tags=cpu:cortex-a7
+        :avocado: tags=device:bcm2835_aux
+        """
+        self.do_test_arm_raspi(2, 'bcm2835_aux')
+
     def test_arm_exynos4210_initrd(self):
         """
         :avocado: tags=arch:arm
-- 
2.21.1



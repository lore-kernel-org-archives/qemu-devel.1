Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02FEEC35247
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 01:39:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2F0520658
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 01:39:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PMOg8rHn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2F0520658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izW8X-0004Li-Vf
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 20:39:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54540)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1izVom-0001Nj-CX
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 20:18:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1izVok-0004a5-4M
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 20:18:56 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:39007)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1izVoj-0004UP-TD; Wed, 05 Feb 2020 20:18:54 -0500
Received: by mail-wm1-x32f.google.com with SMTP id c84so5046868wme.4;
 Wed, 05 Feb 2020 17:18:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QGRmYJ7L9YDtOUA7ryXiSMK9rx2JaMJd+CVAQCLIvks=;
 b=PMOg8rHnQB/j/VuMexCkZorSUToLiuCmrsy1V6sIgEtC8pzofMAvtEugUOX4o876aB
 lVJdm9+P+ka7/y1RnBr8c175VpBZSnNt4zCSC+6MyZMRTADPD/ybJ5KGj6AJX4gDLB0a
 qq2rnPmYCasmAMaCCDj+ODsyTL/l+vSTSck3UEKs5AdCip7wlW6uQLT2YXOcOol0EYkr
 DhqHd0OZ9WYN6iSy2xnuTR9sdFXzCwxT9DfSNnw8xQGmAv78Yh0NpBs8IxqcK2rZXvwz
 ay22rzQjuAwoWx86S9Z/JflJ8hlThUUrJRyivuBkv4uc4lp7UYOeA0meGkWJVy3j9nlO
 SNVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=QGRmYJ7L9YDtOUA7ryXiSMK9rx2JaMJd+CVAQCLIvks=;
 b=YCiFsvR90HrzxNqmxMedaQdI49UKhqPaLCW5tC710+K3wc6p5Ya0IaATKcMUL3cv1J
 k4Q7PSwHRfgi5tRs8MigRQsLcBCinntCxzurLAPbZtlxpjwZfofVtiVqjDJ6IMaRub0u
 tnS+MjlhQwGr5ag4TOERCou2Ak+E5qaFbNlGRaiRj5Er4rFsyyc7o1ZHL0Nw9Ni9DYxN
 8aoD7N0ARr34dpMgjdTCLGAe5l58LNPZNucCbDW1lpRVblb+vESQ3plxUDh/jGyO4d7A
 TMh0kyedv5i3wdQVFG1z6KbXkNpMczLTh4L04QtuWtBkkcSAkkGCx6DwWu8VQsOaeoBT
 KAxA==
X-Gm-Message-State: APjAAAU8obgjEc1yq52WY/cpmDQPIDpF90MOytrgFvblDzjhxQGh+2Ll
 eGbdDdJDeoHlWz82JyC34EIrcW2N
X-Google-Smtp-Source: APXvYqye/wQYwnrcgZcrArguvRbSI4az43d5rwoDw6rBWm6nW1ai0ATYCxNg1/U64diJCzrxZ1/E8A==
X-Received: by 2002:a05:600c:214a:: with SMTP id
 v10mr654711wml.182.1580951931642; 
 Wed, 05 Feb 2020 17:18:51 -0800 (PST)
Received: from localhost.localdomain (2.red-95-127-156.staticip.rima-tde.net.
 [95.127.156.2])
 by smtp.gmail.com with ESMTPSA id w13sm2053526wru.38.2020.02.05.17.18.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2020 17:18:51 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 25/30] tests/acceptance/boot_linux_console: Test the raspi0
 console
Date: Thu,  6 Feb 2020 02:17:51 +0100
Message-Id: <20200206011756.2413-26-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200206011756.2413-1-f4bug@amsat.org>
References: <20200206011756.2413-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32f
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

  $ avocado --show=app,console run -t machine:raspi0 tests/acceptance/
  JOB ID     : af8e017486290758bff39c986934134199af3556
  JOB LOG    : avocado/job-results/job-2020-02-05T23.53-af8e017/job.log
   (1/1) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_raspi0_uart0:
  console: [    0.000000] Booting Linux on physical CPU 0x0
  console: [    0.000000] Linux version 4.14.98+ (dom@dom-XPS-13-9370) (gcc version 4.9.3 (crosstool-NG crosstool-ng-1.22.0-88-g8460611)) #1200 Tue Feb 12 20:11:02 GMT 2019
  console: [    0.000000] CPU: ARMv6-compatible processor [410fb767] revision 7 (ARMv7), cr=00c5387d
  console: [    0.000000] CPU: VIPT aliasing data cache, unknown instruction cache
  console: [    0.000000] OF: fdt: Machine model: Raspberry Pi Zero W
  console: [    0.000000] earlycon: pl11 at MMIO 0x20201000 (options '')
  console: [    0.000000] bootconsole [pl11] enabled
  console: [    0.000000] Memory policy: Data cache writeback
  console: [    0.000000] cma: Reserved 8 MiB at 0x1b800000
  console: [    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 113680
  console: [    0.000000] Kernel command line: printk.time=0 earlycon=pl011,0x20201000 console=ttyAMA0
  PASS (12.59 s)
  RESULTS    : PASS 1 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0 | CANCEL 0
  JOB TIME   : 12.88 s

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/acceptance/boot_linux_console.py | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
index 0371828326..df6600ab2f 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -333,15 +333,18 @@ class BootLinuxConsole(Test):
         """
         serial_kernel_cmdline = {
             'pl011': {
+                0: 'earlycon=pl011,0x20201000 console=ttyAMA0',
                 1: 'earlycon=pl011,0x20201000 console=ttyAMA0',
                 2: 'earlycon=pl011,0x3f201000 console=ttyAMA0',
             },
         }
         kernel = {
+            0: '/boot/kernel.img',
             1: '/boot/kernel.img',
             2: '/boot/kernel7.img',
         }
         dtb = {
+            0: '/boot/bcm2708-rpi-0-w.dtb',
             1: '/boot/bcm2708-rpi-b.dtb',
             2: '/boot/bcm2709-rpi-2-b.dtb',
         }
@@ -363,6 +366,15 @@ class BootLinuxConsole(Test):
         console_pattern = 'Kernel command line: %s' % kernel_command_line
         self.wait_for_console_pattern(console_pattern)
 
+    def test_arm_raspi0_uart0(self):
+        """
+        :avocado: tags=arch:arm
+        :avocado: tags=machine:raspi0
+        :avocado: tags=cpu:arm1176
+        :avocado: tags=device:pl011
+        """
+        self.do_test_arm_raspi(0, 'pl011')
+
     def test_arm_raspi1_uart0(self):
         """
         :avocado: tags=arch:arm
-- 
2.21.1



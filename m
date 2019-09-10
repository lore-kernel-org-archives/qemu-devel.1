Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39611C49ED7
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 16:40:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04B8F2067D
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 16:40:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MVjVp8Or"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04B8F2067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7jCG-0000bE-1w
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 12:40:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50947)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1i7j6D-0002b2-AI
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 12:34:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1i7j6B-0000Bg-51
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 12:34:36 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:44697)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1i7j6A-00006n-Bg
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 12:34:34 -0400
Received: by mail-wr1-x442.google.com with SMTP id k6so9191620wrn.11
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 09:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=PuYQXXa8eH65VFX6y4yqzMNFSFws0dtOs5XP+jiIGuo=;
 b=MVjVp8OrHETo7rDsV8fku008L3U+6q8Gp8FvAQAKoB2uAGMA68ciuVB2QAxUH41R3L
 4WENX7mzRcjuZZk6peFmGPrrBu1l+5Xwpkldet789jcfICONXg7F0cJ7uM0uQcwDtDwe
 jeQ/h20KRTxDO4RJ0wQXndWu1cOj8mtVz864cgrF5CoMGZDamFaCn/WO2E6pPbAkLmsN
 s1bSArgEC8AVjGZ1gFm0PmKFL4I0Qktjz0JP5r4KCLWjl0A9UPOznaWX+QEw2aDZet2j
 B2JcjGDLEXXriJEnP1W3fu/4glKV7TFV2tcXKldXARPtCsA5qLAseVtRsUc/LZfZaGTJ
 7REg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=PuYQXXa8eH65VFX6y4yqzMNFSFws0dtOs5XP+jiIGuo=;
 b=cBRG6iuC7LRl4fEQ+Wuog5A4UJSjkdEtVbcBBLWlwXknbnvgiV6kdA4hsDkafoFjmg
 SiyiDFV0d4cAXPgeE8XvT7J6dMuVwQxOXSFVRHTieNNkKheBAXEC+rll0r8tFDPDwlc1
 xgr6BhLL3NhJjb41lUHeqQiwQUV10vJy4yIEdcVWQ1WeZ0XUvi06jx0lZSKgeqQnPp/O
 cUtj0CtFcWA403kQCPyZFcH2Eb4Gny/RlMW1VzYpxhCxSK1I+D4NCyiHUhxbYCMT/0l6
 jVE3MCqOXtGe0SCc5S6w64aiXbeWQfAEcfspAOKgsLaIY90Kw0rw6lyeM88yR2h0S99X
 Hp0g==
X-Gm-Message-State: APjAAAWY6lCqLoz1D96pTtr3fIjbBsvInDcla9J/RU5FKESkvv5eRUF7
 fd4jRT10SXDBsMNOsVidfdM=
X-Google-Smtp-Source: APXvYqyC9x9ycuvv7bEabETuPUzZmuXEjMFl2zVNw3PpdebKaLG8LFUrn7DsN+pjEIqfhs8vY4gtOg==
X-Received: by 2002:a5d:628f:: with SMTP id k15mr12417104wru.124.1568133272645; 
 Tue, 10 Sep 2019 09:34:32 -0700 (PDT)
Received: from localhost.localdomain
 (251.red-88-10-102.dynamicip.rima-tde.net. [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id w12sm27606354wrg.47.2019.09.10.09.34.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2019 09:34:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: Laurent Vivier <laurent@vivier.eu>,
	qemu-devel@nongnu.org
Date: Tue, 10 Sep 2019 18:34:30 +0200
Message-Id: <20190910163430.11326-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PATCH] BootLinuxConsoleTest: Test the Quadra 800
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
Cc: Thomas Huth <huth@tuxfamily.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This test boots a Linux kernel on a Quadra 800 board
and verify the serial is working.

Example:

  $ avocado --show=app,console run -t machine:q800 tests/acceptance/boot_linux_console.py
  console: ABCFGHIJK
  console: Linux version 5.2.0-2-m68k (debian-kernel@lists.debian.org) (gcc version 8.3.0 (Debian 8.3.0-21)) #1 Debian 5.2.9-2 (2019-08-21)
  console: Detected Macintosh model: 35
  console: Apple Macintosh Quadra 800
  console: Built 1 zonelists, mobility grouping on.  Total pages: 32448
  console: Kernel command line: printk.time=0 console=ttyS0 vga=off
  [...]
  console: Calibrating delay loop... 1236.99 BogoMIPS (lpj=6184960)
  [...]
  console: NuBus: Scanning NuBus slots.
  console: Slot 9: Board resource not found!
  console: SCSI subsystem initialized
  console: clocksource: Switched to clocksource via1
  [...]
  console: macfb: framebuffer at 0xf9001000, mapped to 0x(ptrval), size 468k
  console: macfb: mode is 800x600x8, linelength=800
  console: Console: switching to colour frame buffer device 100x37
  console: fb0: DAFB frame buffer device
  console: pmac_zilog: 0.6 (Benjamin Herrenschmidt <benh@kernel.crashing.org>)
  console: scc.0: ttyS0 at MMIO 0x50f0c022 (irq = 4, base_baud = 230400) is a Z85c30 ESCC - Serial port
  console: scc.1: ttyS1 at MMIO 0x50f0c020 (irq = 4, base_baud = 230400) is a Z85c30 ESCC - Serial port
  console: Non-volatile memory driver v1.3
  console: adb: Mac II ADB Driver v1.0 for Unified ADB
  console: mousedev: PS/2 mouse device common for all mice
  console: random: fast init done
  console: Detected ADB keyboard, type <unknown>.
  console: input: ADB keyboard as /devices/virtual/input/input0
  console: input: ADB mouse as /devices/virtual/input/input1
  console: rtc-generic rtc-generic: registered as rtc0
  console: ledtrig-cpu: registered to indicate activity on CPUs
  [...]
  console: rtc-generic rtc-generic: setting system clock to 2019-09-10T16:20:25 UTC (1568132425)
  console: List of all partitions:
  console: No filesystem could mount root, tried:
  JOB TIME   : 2.91 s

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
Based-on: <20190910113323.17324-1-laurent@vivier.eu>
"hw/m68k: add Apple Machintosh Quadra 800 machine"
https://lists.gnu.org/archive/html/qemu-devel/2019-09/msg01775.html
---
 tests/acceptance/boot_linux_console.py | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
index 2504ef0150..8e346bb0f4 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -373,3 +373,27 @@ class BootLinuxConsole(Test):
         self.vm.launch()
         console_pattern = 'Kernel command line: %s' % kernel_command_line
         self.wait_for_console_pattern(console_pattern)
+
+    def test_m68k_q800(self):
+        """
+        :avocado: tags=arch:m68k
+        :avocado: tags=machine:q800
+        """
+        deb_url = ('http://ftp.ports.debian.org/debian-ports/pool-m68k/main'
+                   '/l/linux/kernel-image-5.2.0-2-m68k-di_5.2.9-2_m68k.udeb')
+        deb_hash = '0797e05129595f22f3c0142db5e199769a723bf9'
+        deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
+        kernel_path = self.extract_from_deb(deb_path,
+                                            '/boot/vmlinux-5.2.0-2-m68k')
+
+        self.vm.set_machine('q800')
+        self.vm.set_console()
+        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
+                               'console=ttyS0 vga=off')
+        self.vm.add_args('-kernel', kernel_path,
+                         '-append', kernel_command_line)
+        self.vm.launch()
+        console_pattern = 'Kernel command line: %s' % kernel_command_line
+        self.wait_for_console_pattern(console_pattern)
+        console_pattern = 'No filesystem could mount root'
+        self.wait_for_console_pattern(console_pattern)
-- 
2.20.1



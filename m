Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA180CA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 11:36:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFE412075A
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 11:36:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFE412075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMsSI-0000aO-0p
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 07:36:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44302)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iMsBc-0004rc-K5
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 07:18:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iMsBX-0007vP-4V
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 07:18:48 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:59733)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1iMsBQ-0007r4-L7; Tue, 22 Oct 2019 07:18:40 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1Mz9d7-1i9D933aQF-00wB1Z; Tue, 22 Oct 2019 13:18:07 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PATCH v14 9/9] BootLinuxConsoleTest: Test the Quadra 800
Date: Tue, 22 Oct 2019 13:17:38 +0200
Message-Id: <20191022111738.20803-10-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191022111738.20803-1-laurent@vivier.eu>
References: <20191022111738.20803-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:9InZqcPGFiYyRVjpN2mym7hXMy5iHRSo8MiUcp+JUkBBBIm6REU
 ewvDy0BH2jp/XoOtm1dtNyKGhMO8OrdowTxZGG+Uf4ruMQVlX0jLVYSSqTQS39MOiP9aB1z
 evGo933A0Ak4Z0Rg2X3EOIlVoP4rY4kqlUVGQfBqviyjLpC7wX5o3r0OnjK4Rw62TdTwEdZ
 mjzJMCNpzDkE7dciktgew==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pYvGcDIAHBY=:kvbAJg43v5Xyd9vHjkDfML
 RDZ2GqG5amd03vg20jq9K0BJFYH8Uvj0/ErjGQHlcM02iomlCUz8jxoh2rY4aI8g64sNSIq4b
 CCw+ygN3IRXWqrSWeGKOu/ZntCdIiKjGS08H9oqMrRc9NjvfJj8UNHeMNxW9+wCrzGLyQ7jvu
 gMDh+lxdn58Paq9EpsHxbSAT3bNfokOVxA69J9YhljmZDoaqf/3rkDMJpc/8NkzzwnBd4hLZs
 CGVjOA3M4WvhdFnZaw76qCABJAGu2ehPgmuHq2bH3CKZTV/b8H7iApK3syH/qC2vXNz4LC3p3
 cVLj//ZilpjdFJ82h/O2xTDAZOCNYKH6NNyGmibLaMNYyf9jo1oTel5PR+DsKu+BeQKnsHMKg
 QTCEGBYgKNFcLfD9IXo/L6DQU2/+3F5k/TmFfaUzXgVmRR0kaegeD9f+hgp0sWDY7tqfILvWs
 RRKyO/fE/UY1NjJfngsaIfl8y+mGutKd34kdEFgOhg+MaDyH21uHNLWsuA7icyFI73i8eA9dn
 hzsZS3k5QYf7Lo6vGw6MYyc5g2XTLVIJ+CrsENkAwreNZIzWa0XemEEFKwSYulptYDUBAUcLW
 Nk5T8zKS4F34lQMVHugeaZONazMYxcHE3Cc6In/GEqMbMmNNzgaeAN/NoN7ZsFdhjxkUqqm1Y
 DZCvKQq0HFPUII9KCacVu8jZQLvMILVeqTi+bxqZ2l1tEgRaWM6Gl9rKdF/dj3jzn3Rf8CeJf
 O9dST6Z2Q4oWWHanT9iTEoo/K9stPs4eNafN3uy6IvW+ApT3g+gSmLBIdtuKrzE4kouFX4XIb
 Ah1B2szvjNo38CIPjqHso1H5nQqGMYPR8oOQQQYWsWTjmoNXfeGjQJZlmuknpGwtbkJ7obJt7
 HPudymBuYZlG+L0GaVjXfDuDsuaTjca72Rxsn6q38=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.17.13
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Thomas Huth <huth@tuxfamily.org>,
 Jason Wang <jasowang@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

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
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Tested-by: Cleber Rosa <crosa@redhat.com>
Reviewed-by: Cleber Rosa <crosa@redhat.com>
Message-Id: <20190910163430.11326-1-f4bug@amsat.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 tests/acceptance/boot_linux_console.py | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
index 8a9a314ab4..df27813c78 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -378,3 +378,27 @@ class BootLinuxConsole(Test):
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
2.21.0



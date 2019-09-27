Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA2E4C4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 09:15:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81A28217D7
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 09:15:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81A28217D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDmL6-0003x9-Lu
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 05:15:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53750)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iDmCF-0002Uv-IT
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 05:05:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iDmCC-0003M3-4o
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 05:05:51 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:44851)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1iDmC4-00031P-8y; Fri, 27 Sep 2019 05:05:40 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MQ5nK-1iZglA0iNE-00M0nX; Fri, 27 Sep 2019 11:05:16 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PATCH v13 9/9] BootLinuxConsoleTest: Test the Quadra 800
Date: Fri, 27 Sep 2019 11:04:53 +0200
Message-Id: <20190927090453.24712-10-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190927090453.24712-1-laurent@vivier.eu>
References: <20190927090453.24712-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:e5nEJxwQ9Cds5QCaDr495C31IjVbQqDnbEyhmTISCy1xdAbyHAc
 nK4xQNdIw0NwK25mojzZ9kf8R4eXFJPSAWZMhrKAvEkZtcijPhBmOb+hWIwyYWeqBGGazjz
 6OUdSgBafe6ZKQXtW7v4Ee1u86MNNLHQTZHZx2EUbZfUzL8LQzTFXW/pJiHCKwGmNcfofII
 f05EWGb2B/4L7Nr0C12CQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ixyYcs/hzzA=:envtKbftv8YOaXMA1IYn6Q
 5dp3JWh/H+pMuNNG3+/NqOByv8eTgtjLtbfmAv8RYZKfA20iRrvUxrPbu40ZB13HkGw5hA5MC
 UlFlxd++m4WwZRBc2KHVoR+/PsqN/YLM/Mf536rm4QliaRwEVtS8u8jgwF6QiqNQKuBJjH0R0
 hcYkVLp/xgOtv3BXHzXpG2VvG0jrF/ggC8a7vroqjazuaU62Xwg+zz4wK5XVWU4hRdOMdU799
 5bgOW+DX9yq1AXtgj3EKATdlP+iBfgP36gTFIAsQpoa4tzMScE59woJDX5SgkaImwxwhZ2qlO
 MWwYQlN1fqt0Syqj3W0uVtBi/DzmjR1iRrdA+MKULvJaAzjB98rchat5koQfQrIbPcwtiD4Jv
 UW676YxlEyJqUq7/6ZHqvbYUuIy6HWsZNbx1bHPK2T9bQur3oFT9VsHu3Oba5r8xC8PlLiqdL
 x737prE95dd+ZA8o4n4IFy/HgOWAHU97c/Hz0qm5dKSC+FtmTdPivxmjUNgVjEZXHSB6rGnFR
 Vrk59cVBKrRDXEfulnAs4IdKL8Rc1zAP6lPt1l3NofT51StTP0uAWxCySKrPUrBSLqR1HcAP3
 zUaeQazcDkLgdN5egl+4MKboNM9Ewua/CrWsLCkNJae6zdbFC9G0h07kbSCNtaQ3JEZwayv6z
 ux3G6IyF/qXal9YttDC8R/x7BiAOpeMIHiyWtMNXx/7nrRB76H/pagqzVKnA3xXaY01DeR9iJ
 sZZFLzZ+pny1iSPs/vKKnji7vP+1FITBYQo4m9nQVOx6S1yoDQp38QPGkaBkEgTxDPqP8uCfQ
 vYmLFiWJYha+XYv+MBwijOC65AQ4mAvGt98BlWL710vrRmPcdAjbv7U60/kvnCI+OgCki7VD1
 SqF+Ka2sbBOZA9QoilV8x4B0rkKoHq5D0eQkrg6i8=
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-block@nongnu.org, Thomas Huth <huth@tuxfamily.org>,
 Jason Wang <jasowang@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Laurent Vivier <laurent@vivier.eu>
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



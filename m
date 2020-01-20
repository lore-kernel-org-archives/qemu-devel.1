Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A7CCC32771
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 23:58:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D063206A5
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 23:58:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mlUzk62W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D063206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itgwK-00015j-IL
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 18:58:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35804)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1itgq4-0000tX-Js
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 18:52:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1itgq3-0007Yt-8J
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 18:52:12 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:52653)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1itgq3-0007YW-2G; Mon, 20 Jan 2020 18:52:11 -0500
Received: by mail-wm1-x341.google.com with SMTP id p9so1122398wmc.2;
 Mon, 20 Jan 2020 15:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=HmU95xX8aiHgv582n9n1gFgP0RnyUSIOGgAammjQwq4=;
 b=mlUzk62WQoMQEbBYRE/ABkDc5CQXIEkYrOaWG4g8743z0u/9C6YQGlQEcHBvIBLvGa
 ctWfebxGlSn2s1qs+SQrzxhyLWMP/yyGUc3nxO28IWc1TQCU/ypHEs6WZlZ91Q/SVIIk
 BLmOsCOuF5HuIg+YiB9PH3JtILgKNabEltxaYKJZfF9DB3TMImb0dQ6HJwtKh0EnKQu2
 9hHK3J86JMPenrtJ2269jwERK28sE3ay7UB35Kvtp0sJ5spQM66A1ITuCV8KQ/CJOc0y
 cdv/qeyfrxO4VG+bIc5WbVRNfCNrPm01+MK2+kBP1/ujyUswgJ7wClfATCvjb3Flw22w
 K0SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=HmU95xX8aiHgv582n9n1gFgP0RnyUSIOGgAammjQwq4=;
 b=Z6ej/JuB6KjlnlGC/valabA1HgGz732pkWnZozwF49kroAZ9WfnUibxsSi8TaRg6hH
 YSeTS6DyzN6+3gS0O+WkrrIpnEse6eaijWBSW3ozkjvo88cwEI8tT4yB7FxkNaagXSLk
 Eoj11VJ4hbuKeDgZ79RdqttoICK3cDmfzGWVlW6rf2CP7ecEvoz4gSJXTBmTWuk/L+B3
 dJ3nLkFRBPZbXycFaooQw5NLEilTnETtYN7dIOq/XoXOwx/wzN2767cWsOhr1zkVAuOQ
 ESXcd6Zb681SEYKxnU6AoJjazD2qksOyHxeliLsraYz11Xvg1NK/nweF/Qmw+GIgM0Sg
 Ts/w==
X-Gm-Message-State: APjAAAX7Ieh912coLqYmArVKBZQrsUwQHv1UKnx3i3mfNVifr+skvYBx
 dNLhdUgRbcDVFOU7BmlF+vhpsKV+
X-Google-Smtp-Source: APXvYqwnFzclMaLm13lPJ3Aaimid5Vi0wZtLRoWaO9ia65KfWufKz6fm7/JH+4tbW23v1tK9pO3Vfg==
X-Received: by 2002:a7b:c74c:: with SMTP id w12mr1155175wmk.1.1579564329908;
 Mon, 20 Jan 2020 15:52:09 -0800 (PST)
Received: from x1w.redhat.com (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id d8sm48655269wrx.71.2020.01.20.15.52.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2020 15:52:09 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 5/7] tests/boot_linux_console: Test booting U-Boot on the
 Raspberry Pi 2
Date: Tue, 21 Jan 2020 00:51:57 +0100
Message-Id: <20200120235159.18510-6-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200120235159.18510-1-f4bug@amsat.org>
References: <20200120235159.18510-1-f4bug@amsat.org>
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
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, qemu-arm@nongnu.org,
 Cleber Rosa <crosa@redhat.com>, Laurent Bonnans <laurent.bonnans@here.com>,
 Cheng Xiang <ext-cheng.xiang@here.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This test runs U-Boot on the Raspberry Pi 2.
It is very simple and fast:

  $ avocado --show=app,console run -t raspi2 -t u-boot tests/acceptance/
  JOB LOG    : avocado/job-results/job-2020-01-20T23.40-2424777/job.log
   (1/1) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_raspi2_uboot:
  console: MMC:   sdhci@7e300000: 0
  console: Loading Environment from FAT... Card did not respond to voltage select!
  console: In:    serial
  console: Out:   vidconsole
  console: Err:   vidconsole
  console: Net:   No ethernet found.
  console: starting USB...
  console: USB0:   Port not available.
  console: Hit any key to stop autoboot:  0
  console: U-Boot>
  console: U-Boot> bdinfo
  console: arch_number = 0x00000000
  console: boot_params = 0x00000100
  console: DRAM bank   = 0x00000000
  console: -> start    = 0x00000000
  console: -> size     = 0x3c000000
  console: baudrate    = 115200 bps
  console: TLB addr    = 0x3bff0000
  console: relocaddr   = 0x3bf64000
  console: reloc off   = 0x3bf5c000
  console: irq_sp      = 0x3bb5fec0
  console: sp start    = 0x3bb5feb0
  console: Early malloc usage: 2a4 / 400
  console: fdt_blob    = 0x3bfbdfb0
  console: U-Boot> version
  console: U-Boot 2019.01+dfsg-7 (May 14 2019 - 02:07:44 +0000)
  console: gcc (Debian 8.3.0-7) 8.3.0
  console: GNU ld (GNU Binutils for Debian) 2.31.1
  console: U-Boot> reset
  console: resetting ...
  PASS (0.46 s)

U-Boot is built by the Debian project, see:
https://wiki.debian.org/InstallingDebianOn/Allwinner#Creating_a_bootable_SD_Card_with_u-boot

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/acceptance/boot_linux_console.py | 28 ++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
index e40b84651b..682b801b4f 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -16,6 +16,7 @@ import shutil
 from avocado import skipUnless
 from avocado_qemu import Test
 from avocado_qemu import exec_command_and_wait_for_pattern
+from avocado_qemu import interrupt_interactive_console_until_pattern
 from avocado_qemu import wait_for_console_pattern
 from avocado.utils import process
 from avocado.utils import archive
@@ -485,6 +486,33 @@ class BootLinuxConsole(Test):
         exec_command_and_wait_for_pattern(self, 'reboot',
                                                 'reboot: Restarting system')
 
+    def test_arm_raspi2_uboot(self):
+        """
+        :avocado: tags=arch:arm
+        :avocado: tags=machine:raspi2
+        :avocado: tags=u-boot
+        """
+        deb_url = ('https://snapshot.debian.org/archive/debian/'
+                   '20190514T084354Z/pool/main/u/u-boot/'
+                   'u-boot-rpi_2019.01%2Bdfsg-7_armhf.deb')
+        deb_hash = 'ad858cf3afe623b6c3fa2e20dcdd1768fcb9ae83'
+        deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
+        uboot_path = '/usr/lib/u-boot/rpi_2/uboot.elf'
+        uboot_path = self.extract_from_deb(deb_path, uboot_path)
+
+        self.vm.set_console()
+        self.vm.add_args('-kernel', uboot_path,
+                         # VideoCore starts CPU with only 1 core enabled
+                         '-global', 'bcm2836.enabled-cpus=1',
+                         '-no-reboot')
+        self.vm.launch()
+        interrupt_interactive_console_until_pattern(self,
+                                       'Hit any key to stop autoboot:',
+                                       'Config file not found')
+        exec_command_and_wait_for_pattern(self, 'bdinfo', 'U-Boot')
+        exec_command_and_wait_for_pattern(self, 'version', 'U-Boot')
+        exec_command_and_wait_for_pattern(self, 'reset', 'resetting ...')
+
     def test_s390x_s390_ccw_virtio(self):
         """
         :avocado: tags=arch:s390x
-- 
2.21.1



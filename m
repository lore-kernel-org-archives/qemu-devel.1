Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C133C10DCE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 16:58:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0592D206F1
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 16:58:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jdoM0IYa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0592D206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45849 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCRAc-0008Q6-7U
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 12:58:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35860)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jCQxn-0000cQ-2P
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:45:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jCQxk-0005H2-QL
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:45:38 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:38398)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jCQxk-0005GA-JD
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:45:36 -0400
Received: by mail-wr1-x431.google.com with SMTP id x11so3602597wrv.5
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 09:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=YSG3HtCrNVfcOl0dKH+LvpqkhidIbVYkjI8m3z3mpH0=;
 b=jdoM0IYamBrADL7yk6pYcacN9od4zlXUl3kBNlgK0njm6G4hm6bmFk9te9y1hfMH32
 j2EltBO1HYtGuGe0jT44Seq6spRKLmXo76FcfTbbxIR8ly7xPSBe+9A/FkgYF7IOQJoV
 3HEjZ0Kkp/FbYzWePglMSgE+nGmUxkEqm1punErdl+gutRWWYc+bwPvM2ypbIgUn0tzc
 qOME4jILPYyM+mzgWJ9r5AT6Xgvxy5uZ3/IbgK+h7khOd144W44bBZpJXQ4ZC437TmNc
 hpTM1HtDanXrNJooAlWWNJegrGsVk1KmH8A5/suVC/IjyYzhKZzemrr6gUUVzwl0YE1+
 suoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=YSG3HtCrNVfcOl0dKH+LvpqkhidIbVYkjI8m3z3mpH0=;
 b=h9fTYltCNHOajTIuork0V899pDHcy8xPSuhIOPgDWt7FoJDlbKnygpSVpjOu982YnC
 GfaQ4ElUEVV0j9w8PcenHpnENtTxoWp3f1hTU8ZAkWfB5tJZ/cN/BSv5WDyX9Z3Xem8o
 ZhwwdnOnechuICrT2DzNN8fQ1/+U5AXsnMkfiUpKZDBKIGBnq5RXyYy16qDELECHaatd
 BlFjE615yKlzCz9rShQnvcAA+2CfB4hLFRpoqrVrDl1en/t9cKj7KPf/ckcAIfbwErT/
 5jVjiHJY7UrTEiu7lMMQMQlpAZfHwVgs7rUP6hTD9x7zUm4iZE1TlqQLqFrdL7pIXnWm
 eH5w==
X-Gm-Message-State: ANhLgQ1sjN6KXcwIBIWKEttQFSetqJy6AkLD8HIAHpmebpz+gjMyu23T
 ucwMRljszcx8yh1bnNc0e7vbyRT/nT/qSw==
X-Google-Smtp-Source: ADFU+vttiI6jvPs3/ChFhgZnb9xijqnmANaDKwoQgYHU1bItWGyw5WAwczLzP+FyFI21f9rQthtmWw==
X-Received: by 2002:adf:ff83:: with SMTP id j3mr3344116wrr.131.1584031535129; 
 Thu, 12 Mar 2020 09:45:35 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id j15sm36838640wrp.85.2020.03.12.09.45.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2020 09:45:34 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 27/36] tests/boot_linux_console: Add a SLOW test booting Ubuntu
 on OrangePi PC
Date: Thu, 12 Mar 2020 16:44:50 +0000
Message-Id: <20200312164459.25924-28-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200312164459.25924-1-peter.maydell@linaro.org>
References: <20200312164459.25924-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::431
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

This test boots Ubuntu Bionic on a OrangePi PC board.

As it requires 1GB of storage, and is slow, this test is disabled
on automatic CI testing.

It is useful for workstation testing. Currently Avocado timeouts too
quickly, so we can't run userland commands.

The kernel image and DeviceTree blob are built by the Armbian
project (based on Debian):
https://www.armbian.com/orange-pi-pc/

The Ubuntu image is downloaded from:
https://dl.armbian.com/orangepipc/Bionic_current

This test can be run using:

  $ AVOCADO_ALLOW_LARGE_STORAGE=yes \
    avocado --show=app,console run -t machine:orangepi-pc \
      tests/acceptance/boot_linux_console.py
  console: U-Boot SPL 2019.04-armbian (Nov 18 2019 - 23:08:35 +0100)
  console: DRAM: 1024 MiB
  console: Failed to set core voltage! Can't set CPU frequency
  console: Trying to boot from MMC1
  console: U-Boot 2019.04-armbian (Nov 18 2019 - 23:08:35 +0100) Allwinner Technology
  console: CPU:   Allwinner H3 (SUN8I 0000)
  console: Model: Xunlong Orange Pi PC
  console: DRAM:  1 GiB
  console: MMC:   mmc@1c0f000: 0
  [...]
  console: Uncompressing Linux... done, booting the kernel.
  console: Booting Linux on physical CPU 0x0
  console: Linux version 5.3.9-sunxi (root@builder) (gcc version 8.3.0 (GNU Toolchain for the A-profile Architecture 8.3-2019.03 (arm-rel-8.36))) #19.11.3 SMP Mon Nov 18 18:49:43 CET 2019
  console: CPU: ARMv7 Processor [410fc075] revision 5 (ARMv7), cr=50c5387d
  console: CPU: div instructions available: patching division code
  console: CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
  console: OF: fdt: Machine model: Xunlong Orange Pi PC
  [...]
  console: EXT4-fs (mmcblk0p1): mounted filesystem with writeback data mode. Opts: (null)
  console: done.
  console: Begin: Running /scripts/local-bottom ... done.
  console: Begin: Running /scripts/init-bottom ... done.
  console: systemd[1]: systemd 237 running in system mode. (...)
  console: systemd[1]: Detected architecture arm.
  console: Welcome to Ubuntu 18.04.3 LTS!
  console: systemd[1]: Set hostname to <orangepipc>.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20200311221854.30370-17-nieklinnenbank@gmail.com
[NL: rename in commit message Raspbian to Armbian, remove vm.set_machine()]
[NL: changed test to boot from SD card via BootROM, added check for 7z]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/acceptance/boot_linux_console.py | 48 ++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
index 0762dbe83a5..e035c88b078 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -19,7 +19,13 @@ from avocado_qemu import exec_command_and_wait_for_pattern
 from avocado_qemu import wait_for_console_pattern
 from avocado.utils import process
 from avocado.utils import archive
+from avocado.utils.path import find_command, CmdNotFoundError
 
+P7ZIP_AVAILABLE = True
+try:
+    find_command('7z')
+except CmdNotFoundError:
+    P7ZIP_AVAILABLE = False
 
 class BootLinuxConsole(Test):
     """
@@ -619,6 +625,48 @@ class BootLinuxConsole(Test):
         exec_command_and_wait_for_pattern(self, 'reboot',
                                                 'reboot: Restarting system')
 
+    @skipUnless(os.getenv('AVOCADO_ALLOW_LARGE_STORAGE'), 'storage limited')
+    @skipUnless(P7ZIP_AVAILABLE, '7z not installed')
+    def test_arm_orangepi_bionic(self):
+        """
+        :avocado: tags=arch:arm
+        :avocado: tags=machine:orangepi-pc
+        """
+
+        # This test download a 196MB compressed image and expand it to 932MB...
+        image_url = ('https://dl.armbian.com/orangepipc/archive/'
+                     'Armbian_19.11.3_Orangepipc_bionic_current_5.3.9.7z')
+        image_hash = '196a8ffb72b0123d92cea4a070894813d305c71e'
+        image_path_7z = self.fetch_asset(image_url, asset_hash=image_hash)
+        image_name = 'Armbian_19.11.3_Orangepipc_bionic_current_5.3.9.img'
+        image_path = os.path.join(self.workdir, image_name)
+        process.run("7z e -o%s %s" % (self.workdir, image_path_7z))
+
+        self.vm.set_console()
+        self.vm.add_args('-drive', 'file=' + image_path + ',if=sd,format=raw',
+                         '-nic', 'user',
+                         '-no-reboot')
+        self.vm.launch()
+
+        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
+                               'console=ttyS0,115200 '
+                               'loglevel=7 '
+                               'nosmp '
+                               'systemd.default_timeout_start_sec=9000 '
+                               'systemd.mask=armbian-zram-config.service '
+                               'systemd.mask=armbian-ramlog.service')
+
+        self.wait_for_console_pattern('U-Boot SPL')
+        self.wait_for_console_pattern('Autoboot in ')
+        exec_command_and_wait_for_pattern(self, ' ', '=>')
+        exec_command_and_wait_for_pattern(self, "setenv extraargs '" +
+                                                kernel_command_line + "'", '=>')
+        exec_command_and_wait_for_pattern(self, 'boot', 'Starting kernel ...');
+
+        self.wait_for_console_pattern('systemd[1]: Set hostname ' +
+                                      'to <orangepipc>')
+        self.wait_for_console_pattern('Starting Load Kernel Modules...')
+
     def test_s390x_s390_ccw_virtio(self):
         """
         :avocado: tags=arch:s390x
-- 
2.20.1



Return-Path: <SRS0=UCRd=3I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_RHS_DOB,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AD3AC32771
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2020 01:01:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5ED2D2467C
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2020 01:01:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="StXOEcSE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ED2D2467C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isyxk-0003S7-1v
	for qemu-devel@archiver.kernel.org; Sat, 18 Jan 2020 20:01:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47059)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1isyoN-00078r-1n
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 19:51:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1isyoL-0008Qj-Aq
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 19:51:30 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:40814)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1isyoL-0008Q0-3L; Sat, 18 Jan 2020 19:51:29 -0500
Received: by mail-wm1-x341.google.com with SMTP id t14so11161261wmi.5;
 Sat, 18 Jan 2020 16:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=VULQN3UBgBd5VnhIE53vuqYwbx1WLZtkqFzjaxFSeRE=;
 b=StXOEcSES18w36R+ZzRULyl+z4z4/+RCMuWBHFt2C2Y/Bhpdf9czWSVMio/fBdfEFG
 6INYZR9oErpKqg6MZHwHXRCAaLpiXdUdTArAHT663xvSwnwS7zSPntslkUCOrtRCp1o0
 rUeDxg/fekhUhwSU9YS5eAXb+ilmM1rkuXcL/y+KLZ5XLz4KACB8KsSEMqLS/fxAc6AZ
 c3rYHyBUQOSM3/bJImEo5QzA7rTSHuEHawq5DNDtBDNAftidsIT/SFP1F8Ps+nnKteS5
 SgrT2gwPw1L6E1olx3jVLw5Mhdq5OMHwOxBRieHxTbEBwCE7QAjYGe1vnIeIP/xUzEv7
 mFXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=VULQN3UBgBd5VnhIE53vuqYwbx1WLZtkqFzjaxFSeRE=;
 b=rZyoNsgqAkSiAbVyFCUT/13/KQSMk4LTNUD534tmArq0kKporrzA25kTG6jZVvrEo5
 aT1u//kt0fTUaL6uP8v3A2sRWL2CphjtnNtI+r+RYK2DbiFmSDGvh2Fk66ChL5wkC3uM
 hzSwPADaoun/7pWDNr8UpTvFGWq96oWHs7zt8XWWbidfljyxwskZwTNbCzgsLBXice4H
 RVzQkNNcuyFzKUp5zFBkhoJC2iwwN7vttngeEkgvcWYwWWCQ93JS9OCRSuYZw//RSYq1
 iBvHYLScV4EGULz14nQAWmKMMxZRBqKFtYVOK0imdKk8wZOg1ELzAXRHzMdYrrlse4Cj
 zUTA==
X-Gm-Message-State: APjAAAXPwJMY2WZHOJXhPfCHTawPEJQtjPwEjWP1UCyRyQQ6bSOEJBoB
 lJmkN7L70QrJQww365Fk/8nDSSF5Gw4=
X-Google-Smtp-Source: APXvYqx46TSmu3IwAwsguD4nQYPEF39FQ1Ilh2Vd4+mgSM+2U9C7EOG7b8DAZFl83Owc7MzEs/Qkmg==
X-Received: by 2002:a1c:1fd0:: with SMTP id
 f199mr11575244wmf.113.1579395087949; 
 Sat, 18 Jan 2020 16:51:27 -0800 (PST)
Received: from pavilion.home ([2a02:a456:6be8:1:8edc:d4ff:fe8b:18b7])
 by smtp.gmail.com with ESMTPSA id h2sm41763568wrv.66.2020.01.18.16.51.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Jan 2020 16:51:27 -0800 (PST)
From: Niek Linnenbank <nieklinnenbank@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 16/20] tests/boot_linux_console: Add a SLOW test booting
 Ubuntu on OrangePi PC
Date: Sun, 19 Jan 2020 01:50:58 +0100
Message-Id: <20200119005102.3847-17-nieklinnenbank@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200119005102.3847-1-nieklinnenbank@gmail.com>
References: <20200119005102.3847-1-nieklinnenbank@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org, jasowang@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 b.galvani@gmail.com, Niek Linnenbank <nieklinnenbank@gmail.com>,
 qemu-arm@nongnu.org, imammedo@redhat.com, philmd@redhat.com
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
[NL: rename in commit message Raspbian to Armbian, remove vm.set_machine()]
[NL: changed test to boot from SD card via BootROM]
Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>
---
 tests/acceptance/boot_linux_console.py | 41 ++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
index 50294e1675..399d5062db 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -591,6 +591,47 @@ class BootLinuxConsole(Test):
         exec_command_and_wait_for_pattern(self, 'reboot',
                                                 'reboot: Restarting system')
 
+    @skipUnless(os.getenv('AVOCADO_ALLOW_LARGE_STORAGE'), 'storage limited')
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
2.17.1



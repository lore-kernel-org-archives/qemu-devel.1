Return-Path: <SRS0=F+Q9=YM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA877CA9EAC
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 23:59:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4CAC20872
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 23:59:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uYKglG0a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4CAC20872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLydE-0007rt-RC
	for qemu-devel@archiver.kernel.org; Sat, 19 Oct 2019 19:59:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34770)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iLyRp-0000ff-BF
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 19:47:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iLyRn-0005jM-G4
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 19:47:49 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:50798)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iLyRn-0005io-8n; Sat, 19 Oct 2019 19:47:47 -0400
Received: by mail-wm1-x342.google.com with SMTP id 5so9584411wmg.0;
 Sat, 19 Oct 2019 16:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=EI6K9oT3hpsstwewvOzbn77tHuEsYIJbCS9Y33MFZ8I=;
 b=uYKglG0azp0uuhalHTR45gcFS9OtazFhm6G8J4rvdBAX7vWwjF11vPjFt4QNea71Uz
 ErrEgb0cMCmvdvWxQKDCFEK8v1GzHo+fd0tWmGj86bDxN+lr911Je6rycTQ5CJ1a+okV
 t0c4EjtrKO7Mc1Kb/XcwkLLfTxmtRizaRliciFPtGECW8DxXdmy5besrOY0EEJzt/E/R
 mIGN6+stFQy+HAw0pLoq0wFwX96XDgrfSWvPfdxYOxpZtCSLN5hFoahBsCvF3Sg8fw93
 Not97ZgsOj/4JAGPJp0I2WbXG1+F+S6VpyixRsLO2nAffmTXxejMx3YjnGsu76JKtWjb
 CkGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=EI6K9oT3hpsstwewvOzbn77tHuEsYIJbCS9Y33MFZ8I=;
 b=sQKCssmrUUUQ0xfMQiARQfT6+S8Kqqx3Pp5ZS2KBpL94MxSKhIqnuPG3fEbYeqxYZq
 vUoOU0hdRkhn5gFUJhFPaYBtcUtKgWhSw3FUflD0HPJuYVOev4jY6eCJ87ieZhCSowIg
 IxsYUExSpQVbPy0B87EMklQBxvVRgJter5mMkyRVsG7mpZ4xilDHWj+CuhozM+c1NVwI
 ccgpQ1d8kl6NDSWM7RRBXTBNWcX0/HkbBQw716qrclPaifiZJg6dbfI2+A5txBsP0fXe
 5pbAlVdNm6U6szYtUXnNfEijdqk0GLoB5SGJ/t9/Ut/8jp04YbW0wszRAKnGWfq04hHP
 /snQ==
X-Gm-Message-State: APjAAAXLTeS8DSeKdzbxvZKQ3p4vr/pp1sGjWvd9RqK0vldqFltedGBG
 A99WusYKgxOQupW9FVHdeFBYQqUt
X-Google-Smtp-Source: APXvYqyL4i8/2Q9SdmsFzZIk/GxlEhm1iUgsHc0GC9DKli3QCvpIc9k+La8QENTEu3nHC+4GtNMCYQ==
X-Received: by 2002:a1c:99cd:: with SMTP id
 b196mr13213429wme.105.1571528865976; 
 Sat, 19 Oct 2019 16:47:45 -0700 (PDT)
Received: from x1w.redhat.com (14.red-88-21-201.staticip.rima-tde.net.
 [88.21.201.14])
 by smtp.gmail.com with ESMTPSA id u1sm10433763wrp.56.2019.10.19.16.47.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Oct 2019 16:47:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH NOTFORMERGE v3 16/16] tests/acceptance: Test U-boot on the
 Raspberry Pi 3
Date: Sun, 20 Oct 2019 01:47:15 +0200
Message-Id: <20191019234715.25750-17-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191019234715.25750-1-f4bug@amsat.org>
References: <20191019234715.25750-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
 Matthias Brugger <mbrugger@suse.com>, Rob Herring <robh@kernel.org>,
 Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Esteban Bosse <estebanbosse@gmail.com>, "Emilio G . Cota" <cota@braap.org>,
 Clement Deschamps <clement.deschamps@antfield.fr>, qemu-arm@nongnu.org,
 Cleber Rosa <crosa@redhat.com>, Laurent Bonnans <laurent.bonnans@here.com>,
 Cheng Xiang <ext-cheng.xiang@here.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Pekka Enberg <penberg@iki.fi>, Pete Batard <pete@akeo.ie>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a proof-of-concept for the '-smp cores=1' feature which
restricts the cores brought online on reset.

The u-boot binary is old and from an untrusted source, but I
don't want to add the build machinery in QEMU, so it is enough
to demonstrate the feature works reliably.

By default this test is not run:

  $ avocado run -t machine:raspi3 tests/acceptance/
   (1/1) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_raspi3_uboot: SKIP: untrusted code
  RESULTS    : PASS 0 | ERROR 0 | FAIL 0 | SKIP 1 | WARN 0 | INTERRUPT 0 | CANCEL 0
  JOB TIME   : 0.23 s

We can run it setting the AVOCADO_ALLOW_UNTRUSTED_CODE variable:

  $ AVOCADO_ALLOW_UNTRUSTED_CODE=1 ./tests/venv/bin/avocado --show=app,console run -t machine:raspi3 tests/acceptance/
   (1/1) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_raspi3_uboot:  console: U-Boot 2016.05-rc1-gd36dcaf (Apr 28 2016 - 23:29:29 +0200)
  console: DRAM:  960 MiB
  console: RPI 3 Model B (0xa02082)
  console: boot regs: 0x00000000 0x00000000 0x00000000 0x00000000
  console: MMC:   bcm2835_sdhci: 0
  console: Card did not respond to voltage select!
  console: ** Bad device mmc 0 **
  console: Using default environment
  console: In:    serial
  console: Out:   lcd
  console: Err:   lcd
  console: Net:   Net Initialization Skipped
  console: No ethernet found.
  PASS (0.30 s)

Then test QEMU:

  $ qemu-system-aarch64 \
      -M raspi3 -smp 4,cores=1 \
      -kernel u-boot.bin \
      -serial null -serial stdio

  U-Boot 2016.05-rc1-gd36dcaf (Apr 28 2016 - 23:29:29 +0200)

  DRAM:  960 MiB
  RPI 3 Model B (0xa02082)
  boot regs: 0x00000000 0x00000000 0x00000000 0x00000000
  MMC:   bcm2835_sdhci: 0
  Card did not respond to voltage select!
  ** Bad device mmc 0 **
  Using default environment

  In:    serial
  Out:   lcd
  Err:   lcd
  Net:   Net Initialization Skipped
  No ethernet found.
  starting USB...
  USB0:   Core Release: 0.000
  SNPSID invalid (not DWC2 OTG device): 00000000
  Port not available.
  Autoboot in 2 seconds
  Card did not respond to voltage select!
  starting USB...
  USB0:   Core Release: 0.000
  SNPSID invalid (not DWC2 OTG device): 00000000
  Port not available.
  USB is stopped. Please issue 'usb start' first.
  starting USB...
  USB0:   Core Release: 0.000
  SNPSID invalid (not DWC2 OTG device): 00000000
  Port not available.
  No ethernet found.
  missing environment variable: pxeuuid
  missing environment variable: bootfile
  Retrieving file: pxelinux.cfg/00000000
  No ethernet found.
  missing environment variable: bootfile
  Retrieving file: pxelinux.cfg/0000000
  No ethernet found.
  missing environment variable: bootfile
  Retrieving file: pxelinux.cfg/000000
  No ethernet found.
  missing environment variable: bootfile
  Retrieving file: pxelinux.cfg/00000
  No ethernet found.
  missing environment variable: bootfile
  Retrieving file: pxelinux.cfg/0000
  No ethernet found.
  missing environment variable: bootfile
  Retrieving file: pxelinux.cfg/000
  No ethernet found.
  missing environment variable: bootfile
  Retrieving file: pxelinux.cfg/00
  No ethernet found.
  missing environment variable: bootfile
  Retrieving file: pxelinux.cfg/0
  No ethernet found.
  missing environment variable: bootfile
  Retrieving file: pxelinux.cfg/default-arm-bcm283x
  No ethernet found.
  missing environment variable: bootfile
  Retrieving file: pxelinux.cfg/default-arm
  No ethernet found.
  missing environment variable: bootfile
  Retrieving file: pxelinux.cfg/default
  No ethernet found.
  Config file not found
  starting USB...
  USB0:   Core Release: 0.000
  SNPSID invalid (not DWC2 OTG device): 00000000
  Port not available.
  No ethernet found.
  U-Boot> version

  U-Boot 2016.05-rc1-gd36dcaf (Apr 28 2016 - 23:29:29 +0200)
  aarch64-unknown-linux-gnu-gcc (Gentoo 5.3.0 p1.0, pie-0.6.5) 5.3.0
  GNU ld (Gentoo 2.25.1 p1.1) 2.25.1
  U-Boot> ^C
  qemu-system-aarch64: terminating on signal 2

We can also build a recent U-boot with:

  u-boot$ export CROSS_COMPILE=aarch64-linux-gnu-
  u-boot$ make rpi_3_defconfig
  u-boot$ make -j8

And test it:

  $ qemu-system-aarch64 \
      -M raspi3 -smp 4,cores=1 \
      -kernel u-boot.bin \
      -serial null -serial stdio

  MMC:   mmc@7e202000: 0, sdhci@7e300000: 1
  Loading Environment from FAT... WARNING at drivers/mmc/bcm2835_sdhost.c:410/bcm2835_send_command()!
  WARNING at drivers/mmc/bcm2835_sdhost.c:410/bcm2835_send_command()!
  Card did not respond to voltage select!
  In:    serial
  Out:   vidconsole
  Err:   vidconsole
  Net:   No ethernet found.
  starting USB...
  Bus usb@7e980000: Port not available.
  Hit any key to stop autoboot:  0
  WARNING at drivers/mmc/bcm2835_sdhost.c:410/bcm2835_send_command()!
  WARNING at drivers/mmc/bcm2835_sdhost.c:410/bcm2835_send_command()!
  WARNING at drivers/mmc/bcm2835_sdhost.c:410/bcm2835_send_command()!
  Card did not respond to voltage select!
  MMC: no card present
  starting USB...
  Bus usb@7e980000: Port not available.
  USB is stopped. Please issue 'usb start' first.
  starting USB...
  Bus usb@7e980000: Port not available.
  No ethernet found.
  missing environment variable: pxeuuid
  missing environment variable: bootfile
  Retrieving file: pxelinux.cfg/00000000
  No ethernet found.
  missing environment variable: bootfile
  Retrieving file: pxelinux.cfg/0000000
  No ethernet found.
  missing environment variable: bootfile
  Retrieving file: pxelinux.cfg/000000
  No ethernet found.
  missing environment variable: bootfile
  Retrieving file: pxelinux.cfg/00000
  No ethernet found.
  missing environment variable: bootfile
  Retrieving file: pxelinux.cfg/0000
  No ethernet found.
  missing environment variable: bootfile
  Retrieving file: pxelinux.cfg/000
  No ethernet found.
  missing environment variable: bootfile
  Retrieving file: pxelinux.cfg/00
  No ethernet found.
  missing environment variable: bootfile
  Retrieving file: pxelinux.cfg/0
  No ethernet found.
  missing environment variable: bootfile
  Retrieving file: pxelinux.cfg/default-arm-bcm283x-rpi
  No ethernet found.
  missing environment variable: bootfile
  Retrieving file: pxelinux.cfg/default-arm-bcm283x
  No ethernet found.
  missing environment variable: bootfile
  Retrieving file: pxelinux.cfg/default-arm
  No ethernet found.
  missing environment variable: bootfile
  Retrieving file: pxelinux.cfg/default
  No ethernet found.
  Config file not found
  starting USB...
  Bus usb@7e980000: Port not available.
  No ethernet found.
  No ethernet found.
  U-Boot> version
  U-Boot 2019.10-rc4-dirty (Oct 19 2019 - 22:02:10 +0000)

  aarch64-linux-gnu-gcc (Debian 8.3.0-2) 8.3.0
  GNU ld (GNU Binutils for Debian) 2.31.1
  U-Boot> reset
  resetting ...
  U-Boot> ^C
  qemu-system-aarch64: terminating on signal 2

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/acceptance/boot_linux_console.py | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
index 8a9a314ab4..7c73051a9a 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -14,6 +14,7 @@ import lzma
 import gzip
 import shutil
 
+from avocado import skipUnless
 from avocado_qemu import Test
 from avocado.utils import process
 from avocado.utils import archive
@@ -316,6 +317,28 @@ class BootLinuxConsole(Test):
         self.vm.launch()
         self.wait_for_console_pattern('init started: BusyBox')
 
+    @skipUnless(os.getenv('AVOCADO_ALLOW_UNTRUSTED_CODE'), 'untrusted code')
+    def test_arm_raspi3_uboot(self):
+        """
+        :avocado: tags=arch:aarch64
+        :avocado: tags=machine:raspi3
+        :avocado: tags=endian:little
+        """
+        uboot_url = ('https://github.com/poinck/piii64/raw/bf3e070d/'
+                     'boot/u-boot.bin')
+        uboot_hash = 'cd2ab2a24589a5b9d177af172af8b39998e5f93f'
+        uboot_path = self.fetch_asset(uboot_url, asset_hash=uboot_hash)
+
+        self.vm.set_machine('raspi3')
+        self.vm.set_console(console_index=1)
+        kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE
+        self.vm.add_args('-kernel', uboot_path,
+                         '-smp', '4,cores=1', # start 3 cores disabled
+                         '-no-reboot')
+        self.vm.launch()
+        self.wait_for_console_pattern('RPI 3 Model B')
+        self.wait_for_console_pattern('No ethernet found.')
+
     def test_s390x_s390_ccw_virtio(self):
         """
         :avocado: tags=arch:s390x
-- 
2.21.0



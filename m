Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C84EC35254
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 10:35:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06EB520725
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 10:35:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VXnJ8G08"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06EB520725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3dkR-000888-80
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 05:35:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60797)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j3djj-0007aK-2i
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 05:34:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j3djh-0001EJ-Tf
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 05:34:47 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:35145)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j3djh-0001Cr-Nt; Mon, 17 Feb 2020 05:34:45 -0500
Received: by mail-wr1-x443.google.com with SMTP id w12so19043402wrt.2;
 Mon, 17 Feb 2020 02:34:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=CDbZ1qZqIrZZED5v+v2YWLCFpUZ7Y0spa/mGSHQL/yg=;
 b=VXnJ8G08dOg4JCTe4e5F9Vx6/czLA9rQiof6hNGEC3XJ3g7kUup5m27TmnoS00UDhz
 7O41foLU4IaV1ECYpggZ9WzdBP19Y0HcJXE/lM3VWnnf6ZEU86L/2U3piaUyFVWuMyLB
 NthsYnf7zczHWi8djBho0IUYLHR5NP74caIVREOCwHREJ7zvAxLIXc5Kztg7DgAxDrOD
 ZoAndw8i9TNB7Xj4YSr3++wndlVT84XI1YeebEGRbH8pBtG7b2IfZl5pVcvtCVCq5KzQ
 u4Th+eNgZVqVyEzGdbR+iEnu8b8saUyhthCq8BTT30CjXqNOaRxMDGBcrPnFfpQxn+vI
 EuOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=CDbZ1qZqIrZZED5v+v2YWLCFpUZ7Y0spa/mGSHQL/yg=;
 b=jetAyS44pFeP89rrBf9T3b2AFHDhUJjsh9R3Rn/hBzFxeKKcJ5m+dcBLqlQU3jFeVZ
 ZuNkFE04w+X8EvdF7vFoo2aUFiiex5BZ4Nrvqs1VBT3bdvOZkn3TuVQJ2hLZsIc8N9Dy
 J5up6p33iT0tfSTIz+v7j5s9GRJ72H1ehovQs1f6DelLmbCApbQ3oRqyM3a8BCkttpHC
 htEr0zY7fxsDgZxzr7+Tt210aIMKpKJOAyAb1dEcQ3bVv3aZMZwvE+TjIZKbBZqmCPBc
 +uqqU+9twIrx85TmGpwJB+z7W3ixbkNZNs/Tn7rf7auuY5CgqY8+geXPXFrKm9wCF4Gi
 8Cpg==
X-Gm-Message-State: APjAAAWmu97tDr1/RAisGNr8eXSJ5R8Ne7a+xw/KM8+6Tb1gsoz7lZBd
 ZRCrb6dCm8gJOtm7VfL7/vyy+UUfuBU=
X-Google-Smtp-Source: APXvYqxCb8LhtQv7+VoSJMgH6bh4lhrDtieRmb5cmD6NKoBVpIcKIxdkhQg36KTqq4JkGSx6iBbu8Q==
X-Received: by 2002:adf:ec4c:: with SMTP id w12mr22493091wrn.124.1581935684521; 
 Mon, 17 Feb 2020 02:34:44 -0800 (PST)
Received: from x1w.redhat.com (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id y17sm302238wrs.82.2020.02.17.02.34.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2020 02:34:43 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] tests/boot_linux_console: Boot Trusted Firmware-A on the
 Raspberry Pi 3
Date: Mon, 17 Feb 2020 11:34:42 +0100
Message-Id: <20200217103442.30318-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, qemu-arm@nongnu.org,
 pete@akeo.ie, Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This test runs Trusted Firmware-A on the Raspberry Pi 3.
We deliberately stop the boot process when the EDK2 UEFI version
is displayed.

The binary is build on AppVeyor CI using Pete Batard repository [1].
ATF v2.1 binary are used (see [2]). Extra documentation in [3].

It is very simple and fast:

  $ avocado --show=app,console run -t atf tests/acceptance
  JOB ID     : 1e748d7c9e9011cf0af3250ddc8ebf2389d6204e
  JOB LOG    : avocado/job-results/job-2020-02-16T18.08-1e748d7/job.log
   (1/1) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_aarch64_raspi3_atf:
  console: NOTICE:  Booting Trusted Firmware
  console: NOTICE:  BL1: v2.1(release):v2.1
  console: NOTICE:  BL1: Built : 15:26:06, May 13 2019
  console: NOTICE:  rpi3: Detected: Raspberry Pi 3 Model B (1GB, Sony, UK) [0x00a02082]
  console: NOTICE:  BL1: Booting BL2
  console: ERROR:   rpi3_sdhost: timeout status 0x40
  console: NOTICE:  BL2: v2.1(release):v2.1
  console: NOTICE:  BL2: Built : 15:26:01, May 13 2019
  console: NOTICE:  BL1: Booting BL31
  console: NOTICE:  BL31: v2.1(release):v2.1
  console: NOTICE:  BL31: Built : 15:26:04, May 13 2019
  console: =UEFI firmware (version UEFI Firmware v1.15 built at 11:58:44 on Feb 14 2020)
  PASS (1.54 s)
  RESULTS    : PASS 1 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0 | CANCEL 0
  JOB TIME   : 1.88 s

[1] https://github.com/pbatard/RPi3#summary
[2] https://github.com/ARM-software/arm-trusted-firmware/blob/v2.1/docs/plat/rpi3.rst
[3] http://www.skylyrac.net/2018-02-01-port-arm-tf-to-rpi3.html

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
v2: Start with a single core powered-on
---
 tests/acceptance/boot_linux_console.py | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
index 34d37eba3b..d1288fb59c 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -507,6 +507,30 @@ def test_arm_cubieboard_sata(self):
         exec_command_and_wait_for_pattern(self, 'reboot',
                                                 'reboot: Restarting system')
 
+    def test_aarch64_raspi3_atf(self):
+        """
+        :avocado: tags=arch:aarch64
+        :avocado: tags=machine:raspi3
+        :avocado: tags=cpu:cortex-a53
+        :avocado: tags=device:pl011
+        :avocado: tags=atf
+        """
+        zip_url = ('https://github.com/pbatard/RPi3/releases/download/'
+                   'v1.15/RPi3_UEFI_Firmware_v1.15.zip')
+        zip_hash = '74b3bd0de92683cadb14e008a7575e1d0c3cafb9'
+        zip_path = self.fetch_asset(zip_url, asset_hash=zip_hash)
+
+        archive.extract(zip_path, self.workdir)
+        efi_fd = os.path.join(self.workdir, 'RPI_EFI.fd')
+
+        self.vm.set_console(console_index=1)
+        self.vm.add_args('-nodefaults',
+                         # VideoCore starts CPU with only 1 core enabled
+                         '-global', 'bcm2836.enabled-cpus=1',
+                         '-device', 'loader,file=%s,force-raw=true' % efi_fd)
+        self.vm.launch()
+        self.wait_for_console_pattern('version UEFI Firmware v1.15')
+
     def test_s390x_s390_ccw_virtio(self):
         """
         :avocado: tags=arch:s390x
-- 
2.21.1



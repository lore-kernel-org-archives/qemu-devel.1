Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0354C4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 18:13:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B2E921A4A
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 18:13:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rmchfyel"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B2E921A4A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDYGj-0004Zs-1L
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 14:13:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59200)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iDXgb-0004u5-6Q
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 13:36:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iDXgZ-0003Bx-Ff
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 13:36:12 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43456)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iDXgZ-0003Au-8l; Thu, 26 Sep 2019 13:36:11 -0400
Received: by mail-wr1-f68.google.com with SMTP id q17so3427826wrx.10;
 Thu, 26 Sep 2019 10:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9Z2jS7j2Q+UZz1eGlkTvwz28s1PK4ipN7g47nz7DXm4=;
 b=rmchfyellb1V8WNuVkKdIvfHSf/UUoCi2kMuM6NQrmsHqEHMjBcNdfjTt+S1aIb15h
 tjCbrcWk+sTTfsFX/F5kS3TLqDrBE4NSGCJvgs1VYnSSWIuTCibg4LWPQywFWIpjqYzz
 mV0TN4rqhQsa4csXVmYE5NpkpLOGGOWciDoKW8ZsJNvGKlZZL0glkiHXME9i/sPL+Ccw
 0yAyu7HTMyUcFMbTWFOiS8OvCgrAFcjJ2aer+tnfcfe1nmLZBVwg3PwBnJBxmv4nXd1b
 Lu98O2L1vSq9fxQG7jBOzi3bRMMRrqd1lYnIb8IGSydXFektTD2vra1I+pAQe6Iqlv34
 C5QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=9Z2jS7j2Q+UZz1eGlkTvwz28s1PK4ipN7g47nz7DXm4=;
 b=slBX12eHxVSAA6ZArtxv61ouBD1EiIZy8hu2/4duK+ioqAvHIDSEZu0diPQ5CzbFVx
 nle0zLQGWvr41k1x71ovS8amrRGt+OFVDBi+rE4/767V6kpskqBTs++xrwLB+x920+eY
 DmyyPaC/LExGHIrY50E2sjnhzR2p+XzeloqA+4YOSFEA5pq6rOQzilj3DwEht0qgFpVC
 MyYOF7ZpGsGuh/XLPBiX/tAdmEnMIzwX6iDAwFDdya74DxYflTlEesYyEJwz8gtrSnJa
 OQ+o4ANulSuOVfnA+bDT/jdOYdxKD4orCTG+py6VPCrI/pf73ZIAk1kFW3JgG8CR040a
 xSOA==
X-Gm-Message-State: APjAAAWtmPds7JYGnpBWUq+D69haS/N+rg25Z+uFwmPkUcrUBpAVc5DK
 6zF3+cbzAY/R59rjZCYHqn5wqfjiGDw=
X-Google-Smtp-Source: APXvYqyGwPO0hdhmCWqnJ/ZUf20VFsl/PotcP315LfahabILnQBejdS7DBfRSotbZIYlDocbSayY2g==
X-Received: by 2002:adf:e48a:: with SMTP id i10mr3831085wrm.311.1569519309986; 
 Thu, 26 Sep 2019 10:35:09 -0700 (PDT)
Received: from x1w.redhat.com (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id b186sm9918980wmd.16.2019.09.26.10.35.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2019 10:35:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 18/19] tests/boot_linux_console: Boot Linux and run few
 commands on raspi3
Date: Thu, 26 Sep 2019 19:34:26 +0200
Message-Id: <20190926173428.10713-19-f4bug@amsat.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190926173428.10713-1-f4bug@amsat.org>
References: <20190926173428.10713-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.68
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
 =?UTF-8?q?Zolt=C3=A1n=20Baldaszti?= <bztemail@gmail.com>,
 Laurent Bonnans <laurent.bonnans@here.com>,
 Esteban Bosse <estebanbosse@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org, Clement Deschamps <clement.deschamps@antfield.fr>,
 Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Cheng Xiang <ext-cheng.xiang@here.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Pekka Enberg <penberg@iki.fi>, Guenter Roeck <linux@roeck-us.net>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add a test which boots Linux and run basic commands using the serial
port console.

The kernel image is built by the Debian project:
https://wiki.debian.org/RaspberryPi

The DeviceTree blob comes from the official Raspberry Pi project:
https://www.raspberrypi.org/

The cpio image used comes from the linux-build-test project:
https://github.com/groeck/linux-build-test

This test can be run using:

  $ avocado run --show=console,app run -t machine:raspi3 tests/acceptance
  console: [    0.000000] Linux version 4.14.0-3-arm64 (debian-kernel@lists.debian.org) (gcc version 7.2.0 (Debian 7.2.0-18)) #1 SMP Debian 4.14.12-2 (2018-01-06)
  console: [    0.000000] Boot CPU: AArch64 Processor [410fd034]
  console: [    0.000000] Machine model: Raspberry Pi 3 Model B
  console: [    0.000000] earlycon: pl11 at MMIO 0x000000003f201000 (options '')
  console: [    0.000000] bootconsole [pl11] enabled
  [...]
  console: Starting network: OK
  console: Found console ttyAMA0
  console: Boot successful.
  console: / # cat /proc/cpuinfo
  console: processor      : 0
  console: BogoMIPS       : 125.00
  console: r      : 0x41
  console: CPU architecture: 8
  console: CPU variant
  console: : 0x0
  console: CPU part       : 0xd03
  console: CPU revision   : 4
  console: / # uname -a
  console: Linux buildroot 4.14.0-3-arm64 #1 SMP Debian 4.14.12-2 (2018-01-06) aarch64 GNU/Linux
  console: reboot
  console: / # reboot
  console: / # Found console ttyAMA0
  console: Stopping network: OK
  console: Saving random seed... done.
  console: Stopping logging: OK
  console: umount: devtmpfs busy - remounted read-only
  console: umount: can't unmount /: Invalid argument
  console: The system is going down NOW!
  console: Sent SIGTERM to all processes
  console: Sent SIGKILL to all processes
  console: Requesting system reboot
  console: kvm: exiting hardware virtualization
  console: reboot: Restarting system
  PASS (11.08 s)

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
some chars are scrambled on the console...
---
 tests/acceptance/boot_linux_console.py | 47 ++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
index 33e8f6c635..2a1a23763e 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -363,6 +363,53 @@ class BootLinuxConsole(Test):
         """
         self.do_test_arm_raspi2(1)
 
+    def test_arm_raspi3_initrd_uart0(self):
+        """
+        :avocado: tags=arch:aarch64
+        :avocado: tags=machine:raspi3
+        """
+        deb_url = ('https://snapshot.debian.org/archive/debian/'
+                   '20180106T174014Z/pool/main/l/linux/'
+                   'linux-image-4.14.0-3-arm64_4.14.12-2_arm64.deb')
+        deb_hash = 'e71c995de57921921895c1162baea5df527d1c6b'
+        deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
+        kernel_path = self.extract_from_deb(deb_path,
+                                            '/boot/vmlinuz-4.14.0-3-arm64')
+
+        dtb_url = ('https://github.com/raspberrypi/firmware/raw/'
+                   '1.20180313/boot/bcm2710-rpi-3-b.dtb')
+        dtb_hash = 'eb14d67133401ef2f93523be7341456d38bfc077'
+        dtb_path = self.fetch_asset(dtb_url, asset_hash=dtb_hash)
+
+        initrd_url = ('https://github.com/groeck/linux-build-test/raw/'
+                      '9b6b392ea7bc15f0d6632328d429d31c9c6273da/rootfs/'
+                      'arm64/rootfs.cpio.gz')
+        initrd_hash = '6fd05324f17bb950196b5ad9d3a0fa996339f4cd'
+        initrd_path_gz = self.fetch_asset(initrd_url, asset_hash=initrd_hash)
+        initrd_path = self.workdir + "rootfs.cpio"
+        gunzip(initrd_path_gz, initrd_path)
+
+        self.vm.set_machine('raspi3')
+        self.vm.set_console()
+        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
+                               'earlycon=pl011,0x3f201000 console=ttyAMA0 ' +
+                               'panic=-1 noreboot')
+        self.vm.add_args('-kernel', kernel_path,
+                         '-dtb', dtb_path,
+                         '-initrd', initrd_path,
+                         '-append', kernel_command_line,
+                         '-no-reboot')
+        self.vm.launch()
+
+        self.wait_for_console_pattern('Boot successful.')
+
+        self.exec_command_and_wait_for_pattern('cat /proc/cpuinfo',
+                                               'BogoMIPS')
+        self.exec_command_and_wait_for_pattern('uname -a',
+                                               'Debian')
+        self.exec_command_and_wait_for_pattern('reboot',
+                                               'reboot: Restarting system')
+
     def test_s390x_s390_ccw_virtio(self):
         """
         :avocado: tags=arch:s390x
-- 
2.20.1



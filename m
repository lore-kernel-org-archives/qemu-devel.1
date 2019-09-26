Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 907F1C4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 18:19:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FF81222BF
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 18:19:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WE4MPnAZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FF81222BF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDYM5-0000X9-4p
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 14:19:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59228)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iDXgc-0004wF-Jz
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 13:36:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iDXgb-0003E1-57
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 13:36:14 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55831)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iDXga-0003DB-V2; Thu, 26 Sep 2019 13:36:13 -0400
Received: by mail-wm1-f66.google.com with SMTP id a6so3700229wma.5;
 Thu, 26 Sep 2019 10:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=sYC4TW3JApn0s9JBnDkHTfcWp0aEvoNVAyyWC/Q/bqI=;
 b=WE4MPnAZC7pmWGO5woLanDbPrXW7oAn4hiFqMS0iZVmJPo+pa6CIOecZE2SzVNfvzv
 ybPCqVpsMWsnJee4ozT8sXhVNLNUD9Ep29Yw0aujY3fLaCXPvYayK0OIa6ks4R3Duwy7
 CZhB/3AKHlDIvJzcm7Yp3O8k354dlblDx6iO6t0Kkc2GAUJgYeWP2/6JwC+U6uxdZFFS
 zmTP8mTI9QGqYJF4KBfK/564ioEHagd3kaSF8qG5gbZ2fQQyM4KVJDeJ5fHNDa20ecuX
 jjZbE2lqKswnl7TDYkVvkityb00qPbLS3DKsSIcO88sFuJ2+YzuHH+/vZ2cRvgAqI4hf
 8h1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=sYC4TW3JApn0s9JBnDkHTfcWp0aEvoNVAyyWC/Q/bqI=;
 b=a1DdTZStVcm9Fa1V1YsUbn1CU0HbLmVk/P1SnSw1993rqaAlddJE2VzZFDsQjT98CU
 D4YWo2csh2gqNgBhy0ng4L3FMNOm5rydniRGvKVB7e9/BWsTTjVj70J5XVXIyaGSF/6z
 SwXRxQABUz0hePf/8qsf9nsUBj/ZHdqtfm14PkPos8g0gDfCB2+trRbDLuABzVNOxXGC
 HapYGA9+ppzPLaadE9vZWUBO+4fykApj3oIatpNl1YsqGf+M/LO2pb0FxdYzjjxvBVZE
 FtMHJzspEKh/KXVsEYQD4vqA+sa2Sm6G0xQbWUl9LOS5FhRMum9nEQu5pxLFjl+6GHso
 ZPYw==
X-Gm-Message-State: APjAAAXNr5trY0YWfd8gcK4gybzRDvK99L5fpRuy5SYonagTA6cUoc77
 dq8CORwoBFL5N8d8ineV7otr166MKsk=
X-Google-Smtp-Source: APXvYqxvweep787viEF53zeHu55W5GMaomo/pqtQaf42DA7CRB5COaIyaq+MfSW7O1dwV0Te/Rbu9w==
X-Received: by 2002:a05:600c:2151:: with SMTP id
 v17mr3777780wml.56.1569519311717; 
 Thu, 26 Sep 2019 10:35:11 -0700 (PDT)
Received: from x1w.redhat.com (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id b186sm9918980wmd.16.2019.09.26.10.35.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2019 10:35:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 19/19] tests/boot_linux_console: Test SDHCI and termal sensor
 on raspi3
Date: Thu, 26 Sep 2019 19:34:27 +0200
Message-Id: <20190926173428.10713-20-f4bug@amsat.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190926173428.10713-1-f4bug@amsat.org>
References: <20190926173428.10713-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.66
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

Add a test which loads the root filesystem on a SD card.
Use a kernel recent enough to also test the thermal sensor.

The kernel image comes from:
https://github.com/sakaki-/bcmrpi3-kernel#description

The cpio image used comes from the linux-build-test project:
https://github.com/groeck/linux-build-test

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/acceptance/boot_linux_console.py | 45 ++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
index 2a1a23763e..5c48cacba8 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -410,6 +410,51 @@ class BootLinuxConsole(Test):
         self.exec_command_and_wait_for_pattern('reboot',
                                                'reboot: Restarting system')
 
+    def test_arm_raspi3_initrd_sd_temp(self):
+        """
+        :avocado: tags=arch:aarch64
+        :avocado: tags=machine:raspi3
+        """
+        tarball_url = ('https://github.com/sakaki-/bcmrpi3-kernel/releases/'
+                       'download/4.19.71.20190910/'
+                       'bcmrpi3-kernel-4.19.71.20190910.tar.xz')
+        tarball_hash = '844f117a1a6de0532ba92d2a7bceb5b2acfbb298'
+        tarball_path = self.fetch_asset(tarball_url, asset_hash=tarball_hash)
+        archive.extract(tarball_path, self.workdir)
+        dtb_path    = self.workdir + "/boot/bcm2837-rpi-3-b.dtb"
+        kernel_path = self.workdir + "/boot/kernel8.img"
+
+        rootfs_url = ('https://github.com/groeck/linux-build-test/raw/'
+                      '9b6b392ea7bc15f0d6632328d429d31c9c6273da/rootfs/'
+                      'arm64/rootfs.ext2.gz')
+        rootfs_hash = 'dbe4136f0b4a0d2180b93fd2a3b9a784f9951d10'
+        rootfs_path_gz = self.fetch_asset(rootfs_url, asset_hash=rootfs_hash)
+        rootfs_path = self.workdir + "rootfs.ext2"
+        gunzip(rootfs_path_gz, rootfs_path)
+
+        self.vm.set_machine('raspi3')
+        self.vm.set_console()
+        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
+                               'earlycon=pl011,0x3f201000 console=ttyAMA0 ' +
+                               'root=/dev/mmcblk0 rootwait rw ' +
+                               'panic=-1 noreboot')
+        self.vm.add_args('-kernel', kernel_path,
+                         '-dtb', dtb_path,
+                         '-append', kernel_command_line,
+                         '-drive', 'file=' + rootfs_path + ',if=sd,format=raw',
+                         '-no-reboot')
+        self.vm.launch()
+
+        self.wait_for_console_pattern('Boot successful.')
+
+        self.exec_command_and_wait_for_pattern('cat /proc/cpuinfo',
+                                               'Raspberry Pi 3 Model B')
+        self.exec_command_and_wait_for_pattern('cat /sys/devices/virtual/' +
+                                               'thermal/thermal_zone0/temp',
+                                               '25178')
+        self.exec_command_and_wait_for_pattern('reboot',
+                                               'reboot: Restarting system')
+
     def test_s390x_s390_ccw_virtio(self):
         """
         :avocado: tags=arch:s390x
-- 
2.20.1



Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6AEAC32771
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 23:56:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F32A206A5
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 23:56:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FNIcu8P9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F32A206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itguM-00071n-9V
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 18:56:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35824)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1itgq6-0000wO-0W
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 18:52:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1itgq4-0007ZV-Kl
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 18:52:13 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:54522)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1itgq4-0007ZD-Em; Mon, 20 Jan 2020 18:52:12 -0500
Received: by mail-wm1-x343.google.com with SMTP id b19so1111185wmj.4;
 Mon, 20 Jan 2020 15:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=cHS3FjXLbTLzmIwcw2Unra+V5Z15Z+SL0w/UZTVUHm8=;
 b=FNIcu8P9iBjUhFWj29G0rbmPu/hCc1pIPoxFZtaVmyv9fp5QVMXcKeBxwCHHJLniWL
 IH4fT/ysmcIwg8Un3JyijcT7GsW05ACRvAdhTPL2EHezewsybgxsbXAgTnHgEvgZY8Hv
 qQWQT3K8bmwuAkxxjRmQv8+AhC0+cS///qWB+x9mPcb5WuUSgNhlGK7qInC0RaiSThiI
 u0WB8VdGa8kfO7mixea6Ty3DY5EtxuOzjXkXRhvd0MnlPAIuq7GY7O5slqqWkwz8nkbC
 CerL0+6KeykQmHupV1EPLvsf+/BAD6w/CELRkJhcDcgcfRWkNzx33PLlWfTYsuDBh0fM
 Ljig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=cHS3FjXLbTLzmIwcw2Unra+V5Z15Z+SL0w/UZTVUHm8=;
 b=te2O9Z6FLkZPpa1nN0Um0bzTxNRKYjcIQPNqsBBoYPS4kMcSctlksPuoocEFrYSgKW
 ZbbBvT+66QIAUnB4+pPbONPIlsRUBmEh07sEN6Yy+wPY8pJl3BQhIMlu/yj5ZglbAHsF
 KA5rMJpJKYXV19HW555xdGEmD5mURYL00EaTh6hK+GSX7DSeQXrf7vKEUd21ieJiJXqC
 GxMQDx9ubaU+lPQhy2MrlIQVYvoOqIaGgCMi3ezoy1ZPBZEEVxPUU6W6UQXSGzK9dn1v
 lny/lLtByH7vIyw/JF7Am1jHCs0SDK1wDZjFgeFLuT9GfrL6uKcrwdoH5hwbWY9RQieA
 y0AA==
X-Gm-Message-State: APjAAAUz6VgnhFXWdXRHrCOXhJexsF9GyiN1YmKcamaDtH0uwzVp76Gp
 MndkV+nYRl0L2sMuYZk++C0EkRhm
X-Google-Smtp-Source: APXvYqyjPaUtMXUHy+zIWqESIdWFZZAXZFOJ/uotc5qrK1/gUZLBDebTYbthC2MnqA+dQVLRg9thVQ==
X-Received: by 2002:a05:600c:118a:: with SMTP id
 i10mr1240269wmf.142.1579564331275; 
 Mon, 20 Jan 2020 15:52:11 -0800 (PST)
Received: from x1w.redhat.com (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id d8sm48655269wrx.71.2020.01.20.15.52.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2020 15:52:10 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 6/7] tests/boot_linux_console: Test booting U-Boot on the
 Raspberry Pi 3
Date: Tue, 21 Jan 2020 00:51:58 +0100
Message-Id: <20200120235159.18510-7-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200120235159.18510-1-f4bug@amsat.org>
References: <20200120235159.18510-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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

This test runs U-Boot on the Raspberry Pi 3.
It is very simple and fast:

  $ avocado --show=app,console run -t raspi3 -t u-boot tests/acceptance/
  JOB LOG    : avocado/job-results/job-2020-01-20T23.40-2424777/job.log
   (1/1) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_aarch64_raspi3_uboot:
  console: MMC:   mmc@7e202000: 0, sdhci@7e300000: 1
  console: Loading Environment from FAT... WARNING at drivers/mmc/bcm2835_sdhost.c:410/bcm2835_send_command()!
  console: WARNING at drivers/mmc/bcm2835_sdhost.c:410/bcm2835_send_command()!
  console: Card did not respond to voltage select!
  console: In:    serial
  console: Out:   vidconsole
  console: Err:   vidconsole
  console: Net:   No ethernet found.
  console: starting USB...
  console: Bus usb@7e980000: Port not available.
  console: Hit any key to stop autoboot:  0
  console: U-Boot>
  console: U-Boot>
  console: U-Boot> bdinfo
  console: arch_number = 0x0000000000000000
  console: boot_params = 0x0000000000000100
  console: DRAM bank   = 0x0000000000000000
  console: -> start    = 0x0000000000000000
  console: -> size     = 0x000000003c000000
  console: baudrate    = 115200 bps
  console: TLB addr    = 0x000000003bff0000
  console: relocaddr   = 0x000000003bf57000
  console: reloc off   = 0x000000003bed7000
  console: irq_sp      = 0x000000003bb52dd0
  console: sp start    = 0x000000003bb52dd0
  console: FB base     = 0x0000000000000000
  console: Early malloc usage: 7b0 / 2000
  console: fdt_blob    = 0x000000003bfbf200
  console: U-Boot> version
  console: U-Boot 2020.01+dfsg-1 (Jan 08 2020 - 08:19:44 +0000)
  console: gcc (Debian 9.2.1-22) 9.2.1 20200104
  console: GNU ld (GNU Binutils for Debian) 2.33.1
  console: U-Boot> reset
  console: resetting ...
  PASS (1.79 s)

U-Boot is built by the Debian project, see:
https://wiki.debian.org/InstallingDebianOn/Allwinner#Creating_a_bootable_SD_Card_with_u-boot

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/acceptance/boot_linux_console.py | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
index 682b801b4f..22b360118d 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -513,6 +513,31 @@ class BootLinuxConsole(Test):
         exec_command_and_wait_for_pattern(self, 'version', 'U-Boot')
         exec_command_and_wait_for_pattern(self, 'reset', 'resetting ...')
 
+    def test_aarch64_raspi3_uboot(self):
+        """
+        :avocado: tags=arch:aarch64
+        :avocado: tags=machine:raspi3
+        :avocado: tags=u-boot
+        """
+        deb_url = ('https://snapshot.debian.org/archive/debian/'
+                   '20200108T145233Z/pool/main/u/u-boot/'
+                   'u-boot-rpi_2020.01%2Bdfsg-1_arm64.deb')
+        deb_hash = 'f394386e02469d52f2eb3c07a2325b1c95aeb00b'
+        deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
+        uboot_path = '/usr/lib/u-boot/rpi_3/u-boot.bin'
+        uboot_path = self.extract_from_deb(deb_path, uboot_path)
+
+        self.vm.set_console(console_index=1)
+        self.vm.add_args('-kernel', uboot_path,
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



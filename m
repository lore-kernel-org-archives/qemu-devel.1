Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB05EC10DCE
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 21:36:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D531208E4
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 21:36:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JveSkupl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D531208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBmXj-0007QO-R3
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 17:36:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53440)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1jBmUF-0000rH-5m
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 17:32:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1jBmUC-0008Mt-UJ
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 17:32:27 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:37376)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1jBmUC-0008Km-La; Tue, 10 Mar 2020 17:32:24 -0400
Received: by mail-wr1-x432.google.com with SMTP id 6so17787644wre.4;
 Tue, 10 Mar 2020 14:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=zay2CMCI6rS/TelvVAzMjELUkYNv61sz+75/jzgsL7Q=;
 b=JveSkupl+5eNSDTOIvs1Vko1i3mKsOZ6amDPx6oe1HbWU/7C32h4JyGO3WkCRvv/16
 TqV+9cpI9cl19++g1ze+4IYAga+O2FL95t2OOFZpKOQnfA/TUQ/NLxAiopref4mezztb
 qHdvwR7hrhayqIqut899vwlhxNXqLG1XOFaWjeE4dy10Yxh0ULnDk82sWJHsaQEdTTyP
 TovZpRlKq33BNDFvJpkLk5tpCmuT8xmobIkMidLgsVaGKK0onCQJGaqT+kEWZ6hvmJ/2
 dkGcJFDewSjY+e9nlGuxxOhd+qZTkHNmRJTM5S+ETsCtbtFlYVijkb1v3vScpBUfjAh6
 Y3gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zay2CMCI6rS/TelvVAzMjELUkYNv61sz+75/jzgsL7Q=;
 b=POa1o6cUAcCSht+8isBIqVISalRzme7gKvrZQ7f2AKRvUL7qfPuNyHfWweKgnbo8ew
 YJbVAnlno5JLh8J4TqMdu1LZWvvGLlo3YXcCwR7aUS5tXDwzHfH8NpK5WOAkJ/h7AHtM
 mV08k9r9rR2LFS2AsQgZU4qAuI4o61D7raDCopCiXP6cujI/v1S5ruOJ3E0fI+rvK0zd
 gbreSVVPc9NP7v1GGhCxknQM97byn8gzbA8auI03ulkm26dmNzDaWwuZIW1YgrrMg7F7
 IxVDGaS7byOg/0SXdlFTXlwLRxwZsBsbZIIxcGc/bl5qCDr6POXOSW7HyDAyBNPydM8N
 n7MQ==
X-Gm-Message-State: ANhLgQ32J90UozHuK6rYUG0DBn2MzDlkskMZVK1/gHGhKnIAAnQW3cxM
 SArFHdoBiXglCxyxssakmCSwpr/Ozh8=
X-Google-Smtp-Source: ADFU+vvxwgH/KqZoiCrOIPjsRFVHRV6Tl6Ase3IamBRNx31BvNdPPDo/qXWFsBVt4S8Ch6hOHSDiSQ==
X-Received: by 2002:adf:c648:: with SMTP id u8mr21346509wrg.185.1583875943160; 
 Tue, 10 Mar 2020 14:32:23 -0700 (PDT)
Received: from pavilion.home ([2a02:a456:6be8:1:8edc:d4ff:fe8b:18b7])
 by smtp.gmail.com with ESMTPSA id 2sm32803580wrf.79.2020.03.10.14.32.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2020 14:32:22 -0700 (PDT)
From: Niek Linnenbank <nieklinnenbank@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 13/18] tests/boot_linux_console: Add a quick test for the
 OrangePi PC board
Date: Tue, 10 Mar 2020 22:31:58 +0100
Message-Id: <20200310213203.18730-14-nieklinnenbank@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200310213203.18730-1-nieklinnenbank@gmail.com>
References: <20200310213203.18730-1-nieklinnenbank@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::432
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

This test boots a Linux kernel on a OrangePi PC board and verify
the serial output is working.

The kernel image and DeviceTree blob are built by the Armbian
project (based on Debian):
https://www.armbian.com/orange-pi-pc/

If ARM is a target being built, "make check-acceptance" will
automatically include this test by the use of the "arch:arm" tags.

Alternatively, this test can be run using:

  $ make check-venv
  $ ./tests/venv/bin/avocado --show=console,app run -t machine:orangepi-pc tests/acceptance/boot_linux_console.py
  JOB ID     : 2e4d15eceb13c33672af406f08171e6e9de1414a
  JOB LOG    : ~/job-results/job-2019-12-17T05.46-2e4d15e/job.log
  (1/1) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_orangepi:
  console: Uncompressing Linux... done, booting the kernel.
  console: Booting Linux on physical CPU 0x0
  console: Linux version 4.20.7-sunxi (root@armbian.com) (gcc version 7.2.1 20171011 (Linaro GCC 7.2-2017.11)) #5.75 SMP Fri Feb 8 09:02:10 CET 2019
  console: CPU: ARMv7 Processor [410fc075] revision 5 (ARMv7), cr=50c5387d
  console: CPU: div instructions available: patching division code
  console: CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
  console: OF: fdt: Machine model: Xunlong Orange Pi PC
  console: Memory policy: Data cache writealloc
  console: OF: reserved mem: failed to allocate memory for node 'cma@4a000000'
  console: cma: Failed to reserve 128 MiB
  console: psci: probing for conduit method from DT.
  console: psci: PSCIv0.2 detected in firmware.
  console: psci: Using standard PSCI v0.2 function IDs
  console: psci: Trusted OS migration not required
  console: random: get_random_bytes called from start_kernel+0x8d/0x3c2 with crng_init=0
  console: percpu: Embedded 18 pages/cpu @(ptrval) s41228 r8192 d24308 u73728
  console: Built 1 zonelists, mobility grouping on.  Total pages: 32480
  console: Kernel command line: printk.time=0 console=ttyS0,115200
  PASS (8.59 s)
  JOB TIME   : 8.81 s

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
[NL: rename in commit message Raspbian to Armbian, remove vm.set_machine()]
Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>
---
 tests/acceptance/boot_linux_console.py | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
index 34d37eba3b..6f5af582f3 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -507,6 +507,31 @@ class BootLinuxConsole(Test):
         exec_command_and_wait_for_pattern(self, 'reboot',
                                                 'reboot: Restarting system')
 
+    def test_arm_orangepi(self):
+        """
+        :avocado: tags=arch:arm
+        :avocado: tags=machine:orangepi-pc
+        """
+        deb_url = ('https://apt.armbian.com/pool/main/l/'
+                   'linux-4.20.7-sunxi/linux-image-dev-sunxi_5.75_armhf.deb')
+        deb_hash = '1334c29c44d984ffa05ed10de8c3361f33d78315'
+        deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
+        kernel_path = self.extract_from_deb(deb_path,
+                                            '/boot/vmlinuz-4.20.7-sunxi')
+        dtb_path = '/usr/lib/linux-image-dev-sunxi/sun8i-h3-orangepi-pc.dtb'
+        dtb_path = self.extract_from_deb(deb_path, dtb_path)
+
+        self.vm.set_console()
+        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
+                               'console=ttyS0,115200n8 '
+                               'earlycon=uart,mmio32,0x1c28000')
+        self.vm.add_args('-kernel', kernel_path,
+                         '-dtb', dtb_path,
+                         '-append', kernel_command_line)
+        self.vm.launch()
+        console_pattern = 'Kernel command line: %s' % kernel_command_line
+        self.wait_for_console_pattern(console_pattern)
+
     def test_s390x_s390_ccw_virtio(self):
         """
         :avocado: tags=arch:s390x
-- 
2.17.1



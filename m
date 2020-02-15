Return-Path: <SRS0=Sgwn=4D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43893C2BA83
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 19:26:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00B312082F
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2020 19:26:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u9jdQOCQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00B312082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j335E-0002lM-7n
	for qemu-devel@archiver.kernel.org; Sat, 15 Feb 2020 14:26:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36430)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j331F-000460-Rw
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 14:22:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j331E-0000w3-Kw
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 14:22:25 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535]:42369)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j331E-0000vf-EY
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 14:22:24 -0500
Received: by mail-ed1-x535.google.com with SMTP id e10so15432852edv.9
 for <qemu-devel@nongnu.org>; Sat, 15 Feb 2020 11:22:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=DOWa9iVNzRi2wiFe8WeDuCCmr7A3b0qlB/RcGKV1zU8=;
 b=u9jdQOCQCDTsHykfv+mbPzD6som3lvh7Ho8BfDHndIat6IjNIQYZF1EEhXNunSLlfb
 jF4el2DtmHhJQ/FBGwlqGjZt/xa24oxSwdX7NbFfbwnqKDUnM2H6HXwmS4dt3QVAF+wz
 bXWyHkmet5LJGkzmL7rLdL9LpLZxLwZ6VPS9XMa7y/ZBDLN/1gChELL5C4nM9PK7WDsN
 SfGkhnCHf+BHzBJNaEiy31e49dp+JIXNPIpLRHRB5P1wmdMNUNNovdGoXyJLVTVg3DHx
 iscpOBceN77ehGG52tqrKyQhv82mw9JDLyJNoiuoACrp/LGcHJo0cudSdgBlTlPE9Nm6
 Tpbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=DOWa9iVNzRi2wiFe8WeDuCCmr7A3b0qlB/RcGKV1zU8=;
 b=QWc7XuAjJKPmXUeFwL3qqzbvNnr60mCgK+lycaGO2YQW/U0L7R09CoUnz6GA32vEy/
 NBICFv4xjBZrhU1U5ftP0teWlG7qgeq0WinROb0RNsQOViUkDPw3RP294VBZnr+daSR/
 MFHqQ6Of0SF3fMlfiOKJuVaN9WOlFJyRv8PYpB1mYUsw5YshXsgqYmyeMSOIT7bB+/+s
 EAI1f7g7bueKFgBLgZO/TVudRfJlHDqpydXtO7a++KHTRJNMdd/GNy3fEcVR6xN0vfj5
 QAwOegnJkt/pDp0QH8S0VYzQ5BYc9mjfQKJ6F2XIes8OS4xS/Fikeg72Sm944Q15EE8F
 tiKA==
X-Gm-Message-State: APjAAAXBtuWj34ZIrv7p6jl1kFHst9HqJCJykEALXQPIJTOA1Ii6HSV6
 S3G8/Q/T3FelF+xElKRdFSgutLgvG/8=
X-Google-Smtp-Source: APXvYqyQPyrJ7r+k1ws+AOJSyiSLQI5tjekRbvxe1QKTs+lZ6yx3GnJXKgrvtw+mzqrD0mtirMso8Q==
X-Received: by 2002:a17:906:f105:: with SMTP id
 gv5mr8308011ejb.135.1581794543219; 
 Sat, 15 Feb 2020 11:22:23 -0800 (PST)
Received: from localhost.localdomain (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id a24sm657128ejt.40.2020.02.15.11.22.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Feb 2020 11:22:22 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/8] tests/acceptance/boot_linux_console: Test the raspi1
 console
Date: Sat, 15 Feb 2020 20:22:11 +0100
Message-Id: <20200215192216.4899-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200215192216.4899-1-f4bug@amsat.org>
References: <20200215192216.4899-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::535
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  $ avocado --show=app,console run -t machine:raspi1 tests/acceptance/
  JOB ID     : c49310d4a21444f03789cd2c443d8c54a29ffd0a
  JOB LOG    : avocado/job-results/job-2020-02-05T23.52-c49310d/job.log
   (1/1) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_raspi1_uart0:
  console: [    0.000000] Booting Linux on physical CPU 0x0
  console: [    0.000000] Linux version 4.14.98+ (dom@dom-XPS-13-9370) (gcc version 4.9.3 (crosstool-NG crosstool-ng-1.22.0-88-g8460611)) #1200 Tue Feb 12 20:11:02 GMT 2019
  console: [    0.000000] CPU: ARMv6-compatible processor [410fb767] revision 7 (ARMv7), cr=00c5387d
  console: [    0.000000] CPU: VIPT aliasing data cache, unknown instruction cache
  console: [    0.000000] OF: fdt: Machine model: Raspberry Pi Model B
  console: [    0.000000] earlycon: pl11 at MMIO 0x20201000 (options '')
  console: [    0.000000] bootconsole [pl11] enabled
  console: [    0.000000] Memory policy: Data cache writeback
  console: [    0.000000] cma: Reserved 8 MiB at 0x1b800000
  console: [    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 113680
  console: [    0.000000] Kernel command line: printk.time=0 earlycon=pl011,0x20201000 console=ttyAMA0
  PASS (12.93 s)
  RESULTS    : PASS 1 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0 | CANCEL 0
  JOB TIME   : 13.18 s

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/acceptance/boot_linux_console.py | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
index a1b6e70d3f..c8eabae695 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -355,13 +355,16 @@ def do_test_arm_raspi(self, version, uart_model):
         """
         serial_kernel_cmdline = {
             'pl011': {
+                1: 'earlycon=pl011,0x20201000 console=ttyAMA0',
                 2: 'earlycon=pl011,0x3f201000 console=ttyAMA0',
             },
         }
         kernel = {
+            1: '/boot/kernel.img',
             2: '/boot/kernel7.img',
         }
         dtb = {
+            1: '/boot/bcm2708-rpi-b.dtb',
             2: '/boot/bcm2709-rpi-2-b.dtb',
         }
         deb_url = ('http://archive.raspberrypi.org/debian/'
@@ -382,6 +385,15 @@ def do_test_arm_raspi(self, version, uart_model):
         console_pattern = 'Kernel command line: %s' % kernel_command_line
         self.wait_for_console_pattern(console_pattern)
 
+    def test_arm_raspi1_uart0(self):
+        """
+        :avocado: tags=arch:arm
+        :avocado: tags=machine:raspi1
+        :avocado: tags=cpu:arm1176
+        :avocado: tags=device:pl011
+        """
+        self.do_test_arm_raspi(1, 'pl011')
+
     def test_arm_raspi2_uart0(self):
         """
         :avocado: tags=arch:arm
-- 
2.21.1



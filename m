Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C15B0C35247
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 01:37:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B2C920658
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 01:37:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g2E12OKa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B2C920658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izW6q-0001oM-QI
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 20:37:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54414)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1izVof-0001Ea-I1
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 20:18:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1izVod-0004Dp-7L
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 20:18:49 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:38252)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1izVod-00049t-0b; Wed, 05 Feb 2020 20:18:47 -0500
Received: by mail-wr1-x42f.google.com with SMTP id y17so5137540wrh.5;
 Wed, 05 Feb 2020 17:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=yUSBUp9gdan6yP5vOjp1HSLcVgTCg5pBVo6PRPW8Pj0=;
 b=g2E12OKam7A8Mb9Y1AW9/62RhZ4sGt2ctKZdAyLuBT8yU+eB4qDZ++cb5UrtYprsrd
 HTKDsTuEa98f72e1fonm6ybRdVYg2tjWjwsSC0WKDyP9eZ4WWJeNf3AlktPVCOlP8Qyv
 uL0o2vDIJZP6G+ywreBoM0eyk6NeSsO2w12lKBzMqvwB3as50OSc9Ik+G8m/ptNj6qb7
 hVkluHGGcOv+6DJqAC5UpLmoJlqmEvD9Co7OJJY4oLYBrpNJUCPOuB7Zu148Mja9ov3+
 WlQZPagvGHPgmWO6iI+XhQWw7jW+PLQrPWcf52yjvgJlcvYG6Ou7s+XWBIUdxNpUT24j
 N6Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=yUSBUp9gdan6yP5vOjp1HSLcVgTCg5pBVo6PRPW8Pj0=;
 b=MlQqq0pxVGmdhnduSbZ4BVBsvq3guIxgm8N1XqB3Sf6tapz2m7xNUCrOwy5e2W+a/K
 QKeyuRtYpKRItQ3DXgFEJOeRKOKcqoRzS2IFGHmkMaifNyaUlO32oSN4KscipGvhgLWW
 rkgdnQP/Bpw6/OzMuVSCXjqk5b6TuDNP4ZaXhQJSqYvBahtFQiuxgqrasL6N5oCMKkG7
 ClqaX6zMnODO8/2oCFvSQvCAs8W4+aLdyOHLK1CrKIvl4gKoJk831nfl/QrEw1CNZI7W
 WQfe1GqBfwRWjo1yHfN58OKI+lSmSCkBZeTDdMKkWg3ExHBe7X0+TDF+TYXIPXOoyyfT
 PW/g==
X-Gm-Message-State: APjAAAWVfiGMlxgi+cXfSuzgbJ4gMrIFu+26ap8lBO3glEeRkCAqz4+Y
 ZBJeqYEdF+CY67ZpCQ5e+dLCQQ6Y
X-Google-Smtp-Source: APXvYqxcITg750MynsqOgs/tnRGTTfCDpKkxeVtlxREL6XUis75GIsjiCX8CRrSGTtA7HL8VpEovuA==
X-Received: by 2002:a5d:6191:: with SMTP id j17mr296382wru.427.1580951925784; 
 Wed, 05 Feb 2020 17:18:45 -0800 (PST)
Received: from localhost.localdomain (2.red-95-127-156.staticip.rima-tde.net.
 [95.127.156.2])
 by smtp.gmail.com with ESMTPSA id w13sm2053526wru.38.2020.02.05.17.18.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2020 17:18:45 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 22/30] tests/acceptance/boot_linux_console: Use raspi
 console model as key
Date: Thu,  6 Feb 2020 02:17:48 +0100
Message-Id: <20200206011756.2413-23-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200206011756.2413-1-f4bug@amsat.org>
References: <20200206011756.2413-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42f
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
 Joaquin de Andres <me@xcancerberox.com.ar>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Esteban Bosse <estebanbosse@gmail.com>, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Python dictionary are not that expensive. Use a key makes the
code easier to review.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/acceptance/boot_linux_console.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
index e40b84651b..5fba46a9d1 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -325,14 +325,14 @@ class BootLinuxConsole(Test):
         self.vm.launch()
         self.wait_for_console_pattern('init started: BusyBox')
 
-    def do_test_arm_raspi2(self, uart_id):
+    def do_test_arm_raspi2(self, uart_model):
         """
         The kernel can be rebuilt using the kernel source referenced
         and following the instructions on the on:
         https://www.raspberrypi.org/documentation/linux/kernel/building.md
         """
         serial_kernel_cmdline = {
-            0: 'earlycon=pl011,0x3f201000 console=ttyAMA0',
+            'pl011': 'earlycon=pl011,0x3f201000 console=ttyAMA0',
         }
         deb_url = ('http://archive.raspberrypi.org/debian/'
                    'pool/main/r/raspberrypi-firmware/'
@@ -344,7 +344,7 @@ class BootLinuxConsole(Test):
 
         self.vm.set_console()
         kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
-                               serial_kernel_cmdline[uart_id])
+                               serial_kernel_cmdline[uart_model])
         self.vm.add_args('-kernel', kernel_path,
                          '-dtb', dtb_path,
                          '-append', kernel_command_line)
@@ -358,7 +358,7 @@ class BootLinuxConsole(Test):
         :avocado: tags=machine:raspi2
         :avocado: tags=device:pl011
         """
-        self.do_test_arm_raspi2(0)
+        self.do_test_arm_raspi2('pl011')
 
     def test_arm_exynos4210_initrd(self):
         """
-- 
2.21.1



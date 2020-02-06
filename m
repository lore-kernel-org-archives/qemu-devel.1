Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAFA0C35247
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 01:37:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7723D20838
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 01:37:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ik1SwQvx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7723D20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izW6U-0000tq-MV
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 20:37:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54447)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1izVoh-0001Hf-Cc
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 20:18:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1izVog-0004Q6-34
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 20:18:51 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:38856)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1izVof-0004Kf-Ss; Wed, 05 Feb 2020 20:18:50 -0500
Received: by mail-wm1-x343.google.com with SMTP id a9so5040167wmj.3;
 Wed, 05 Feb 2020 17:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=O6bajScUJ4xgmQhfXtPoiQXddmANh1kvtsMps+VVVb4=;
 b=Ik1SwQvxolLdkQ37I3pqyoWqpzyZcVfBezc8UkfEDLG/Qkdrpauwd8GJj0u/XP/O6X
 heIlusf3u2YPKKKRu4vw8rVQNPMvE0KHOcjDVwNw4L1Q7tIW6Auv2zmZFbzy4DWn/aZX
 W9yekDYMRsJ2tU6q+nqHlMAF9zsGTzhjDSXjsdrpzGoOHcDdGKjy8OE/PsSL8Ar/9J5o
 uR83ShF3a4gmVeqrpNDzVybpbzT1TjwCEeAAkfR0x7VVm52eRhMuJpfevgpSHP0KRZE7
 5Tdwdmy/zxF0M3iZdpGw2lW05zrsR5tn9omT5qKgfiX6hUACfhM3fC/0u+WVivZzuhCQ
 ZauQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=O6bajScUJ4xgmQhfXtPoiQXddmANh1kvtsMps+VVVb4=;
 b=Q/SfRuLLNS6iDYAg8A6hUU2/xlNn4S4gHhH3SR9hkXm7/DvhqRwrIgpxuC7elFu2Sh
 OPtHtpz+KBwf+CB0zWOL4mPforzi82GVsLZhDzsO63ecMmw1eZstYhmBkBZw7T+JZ7R3
 fwy3bM85lq4LbpEuW5HoL9VU5WgBExh+7HWwhGnudC1Eq87y41XfXylO82vgi7PzNM88
 oQxPdB/10Ai1PYm1z5kRuBM9wjK4QsIasJ/33zvgg1kRpAwU3xZoXLrqahCUWerg3DDn
 Ek7xRFHC/EqH/7bjRMqrTLDr1axyFL5PXugcVyn5CTzd9c1yKehe//GVG9TXdR1Iq7Pe
 VRiw==
X-Gm-Message-State: APjAAAVAHcFmLyDjgxDlNx0ZrQaDQ5cfIFhRBYvCJ5hupXy4EqkE78xd
 eOw/BkJPa9NLmkqq9xU9EpGgBLeT
X-Google-Smtp-Source: APXvYqxq+/+fPNnLL1CF27cEFxTwSHUB0i6eFDqGe9IAGgmK0pTf6GU4HHH/eRUt6mSL1Ll5T5Lp/g==
X-Received: by 2002:a7b:cd8e:: with SMTP id y14mr629858wmj.150.1580951927679; 
 Wed, 05 Feb 2020 17:18:47 -0800 (PST)
Received: from localhost.localdomain (2.red-95-127-156.staticip.rima-tde.net.
 [95.127.156.2])
 by smtp.gmail.com with ESMTPSA id w13sm2053526wru.38.2020.02.05.17.18.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2020 17:18:47 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 23/30] tests/acceptance/boot_linux_console: Add raspi
 version=2 parameter
Date: Thu,  6 Feb 2020 02:17:49 +0100
Message-Id: <20200206011756.2413-24-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200206011756.2413-1-f4bug@amsat.org>
References: <20200206011756.2413-1-f4bug@amsat.org>
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
 Joaquin de Andres <me@xcancerberox.com.ar>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Esteban Bosse <estebanbosse@gmail.com>, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We want to tests different Raspberry Pi machines. Refactor to
take the board version as argument.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/acceptance/boot_linux_console.py | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
index 5fba46a9d1..56c8d54ca6 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -325,26 +325,34 @@ class BootLinuxConsole(Test):
         self.vm.launch()
         self.wait_for_console_pattern('init started: BusyBox')
 
-    def do_test_arm_raspi2(self, uart_model):
+    def do_test_arm_raspi(self, version, uart_model):
         """
         The kernel can be rebuilt using the kernel source referenced
         and following the instructions on the on:
         https://www.raspberrypi.org/documentation/linux/kernel/building.md
         """
         serial_kernel_cmdline = {
-            'pl011': 'earlycon=pl011,0x3f201000 console=ttyAMA0',
+            'pl011': {
+                2: 'earlycon=pl011,0x3f201000 console=ttyAMA0',
+            },
+        }
+        kernel = {
+            2: '/boot/kernel7.img',
+        }
+        dtb = {
+            2: '/boot/bcm2709-rpi-2-b.dtb',
         }
         deb_url = ('http://archive.raspberrypi.org/debian/'
                    'pool/main/r/raspberrypi-firmware/'
                    'raspberrypi-kernel_1.20190215-1_armhf.deb')
         deb_hash = 'cd284220b32128c5084037553db3c482426f3972'
         deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
-        kernel_path = self.extract_from_deb(deb_path, '/boot/kernel7.img')
-        dtb_path = self.extract_from_deb(deb_path, '/boot/bcm2709-rpi-2-b.dtb')
+        kernel_path = self.extract_from_deb(deb_path, kernel[version])
+        dtb_path = self.extract_from_deb(deb_path, dtb[version])
 
         self.vm.set_console()
         kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
-                               serial_kernel_cmdline[uart_model])
+                               serial_kernel_cmdline[uart_model][version])
         self.vm.add_args('-kernel', kernel_path,
                          '-dtb', dtb_path,
                          '-append', kernel_command_line)
@@ -356,9 +364,10 @@ class BootLinuxConsole(Test):
         """
         :avocado: tags=arch:arm
         :avocado: tags=machine:raspi2
+        :avocado: tags=cpu:cortex-a7
         :avocado: tags=device:pl011
         """
-        self.do_test_arm_raspi2('pl011')
+        self.do_test_arm_raspi(2, 'pl011')
 
     def test_arm_exynos4210_initrd(self):
         """
-- 
2.21.1



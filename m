Return-Path: <SRS0=FIxb=52=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58865C2BA2B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2020 14:47:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2282B20A8B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2020 14:47:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q3UjFZIz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2282B20A8B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMuwH-0000h5-AD
	for qemu-devel@archiver.kernel.org; Fri, 10 Apr 2020 10:47:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53322)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sundeep.lkml@gmail.com>) id 1jMuun-0006i0-F7
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 10:45:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sundeep.lkml@gmail.com>) id 1jMuum-0007WA-DZ
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 10:45:53 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:42850)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <sundeep.lkml@gmail.com>)
 id 1jMuum-0007Uu-7d; Fri, 10 Apr 2020 10:45:52 -0400
Received: by mail-pg1-x542.google.com with SMTP id g6so1055441pgs.9;
 Fri, 10 Apr 2020 07:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=oC4LI+rsC3AfaHKWa06ELH+UcID+dQ6LdmleZ0eZwSQ=;
 b=q3UjFZIzspKy6uVSbDGTBSYT6H/6K2BvXfAxw5pLG1xZTpsO3L3qy4dffeV/Jsh7Oi
 GrZmL8EqUzxWm1HMtBZ05bwRrXOroxTkdtjR2+ddmF25ZU2Zapmaecz+WlinOBbMNeSd
 zxgW6DGyBwYRffDLE1VCKPqzPgqjJyxj2A4BDVbJorSyGV6byv60subaDzEzq8GSPrG5
 yjA9qQXy2TUGRUGQeUakuR/0aVB9olpt/G1yUH4tzXIyxC3HgzOgov0gsTbPM1Vkvif8
 v6vghspncvKCjuTnEhDB2PKW2p+fpiyQxFRrAhxJ1mXYIYLXgoC2Y11fRpS1bkgnUjwI
 K3vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=oC4LI+rsC3AfaHKWa06ELH+UcID+dQ6LdmleZ0eZwSQ=;
 b=F6vmziBSigas4+WMo1SDzO4cynGjqXjlYjrYDHcYdtZZQ5f0+AFhPN0pp8ORYD6BKi
 kbQfCKqcnaQdHHIdiAXikSofLQyKGkUrqIp5C7Y/lH5kbgQRPZmIyBZv2nGzEfLQRtCL
 cS7AYLmFlFueu86pE+WTEr+nsxkZ2wtBWQFA3715+/VwK5U1FETadIkBdA2y8qi7V6Je
 /Z0S0xTNPAN/u89NTemS2w+rBF/FaqBd+S7w6hFYq4tWV6HfWvto+SbnFInentXN8rGA
 TjVVu0Yd8Hf5NnUcPV04wicKTUF5QblsqFgch7uYpHa/leCPgdsd+/ciFe7TKFVn4f5Q
 RN7w==
X-Gm-Message-State: AGi0PubegdWrWKUPXbEEGK5CMJK80QoUXEPWbev8myUnTp40WPkumgH5
 BtvyziOclzdkgMXoh7flz/g=
X-Google-Smtp-Source: APiQypLLMFmnDKLcfRgiIlg54ujUZ46ln0bq/MAi8wZtcqxAlzD1eanW2tS8Ax/bb4/4zQEu4gWmOg==
X-Received: by 2002:a63:721a:: with SMTP id n26mr4995899pgc.386.1586529951237; 
 Fri, 10 Apr 2020 07:45:51 -0700 (PDT)
Received: from hyd1358.marvell.com ([115.113.156.2])
 by smtp.googlemail.com with ESMTPSA id p12sm1984667pfq.153.2020.04.10.07.45.48
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 10 Apr 2020 07:45:50 -0700 (PDT)
From: sundeep.lkml@gmail.com
To: jasowang@redhat.com, peter.maydell@linaro.org, philmd@redhat.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
Subject: [Qemu devel PATCH v4 3/3] tests/boot_linux_console: Add ethernet test
 to SmartFusion2
Date: Fri, 10 Apr 2020 20:15:26 +0530
Message-Id: <1586529926-11441-4-git-send-email-sundeep.lkml@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1586529926-11441-1-git-send-email-sundeep.lkml@gmail.com>
References: <1586529926-11441-1-git-send-email-sundeep.lkml@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
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
Cc: Subbaraya Sundeep <sundeep.lkml@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Subbaraya Sundeep <sundeep.lkml@gmail.com>

In addition to simple serial test this patch uses ping
to test the ethernet block modelled in SmartFusion2 SoC.

Signed-off-by: Subbaraya Sundeep <sundeep.lkml@gmail.com>
---
 tests/acceptance/boot_linux_console.py | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
index f825cd9..c6b06a1 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -336,13 +336,13 @@ class BootLinuxConsole(Test):
         """
         uboot_url = ('https://raw.githubusercontent.com/'
                      'Subbaraya-Sundeep/qemu-test-binaries/'
-                     'fa030bd77a014a0b8e360d3b7011df89283a2f0b/u-boot')
-        uboot_hash = 'abba5d9c24cdd2d49cdc2a8aa92976cf20737eff'
+                     'fe371d32e50ca682391e1e70ab98c2942aeffb01/u-boot')
+        uboot_hash = 'cbb8cbab970f594bf6523b9855be209c08374ae2'
         uboot_path = self.fetch_asset(uboot_url, asset_hash=uboot_hash)
         spi_url = ('https://raw.githubusercontent.com/'
                    'Subbaraya-Sundeep/qemu-test-binaries/'
-                   'fa030bd77a014a0b8e360d3b7011df89283a2f0b/spi.bin')
-        spi_hash = '85f698329d38de63aea6e884a86fbde70890a78a'
+                   'fe371d32e50ca682391e1e70ab98c2942aeffb01/spi.bin')
+        spi_hash = '65523a1835949b6f4553be96dec1b6a38fb05501'
         spi_path = self.fetch_asset(spi_url, asset_hash=spi_hash)
 
         self.vm.set_console()
@@ -352,7 +352,12 @@ class BootLinuxConsole(Test):
                          '-drive', 'file=' + spi_path + ',if=mtd,format=raw',
                          '-no-reboot')
         self.vm.launch()
-        self.wait_for_console_pattern('init started: BusyBox')
+        self.wait_for_console_pattern('Enter \'help\' for a list')
+
+        exec_command_and_wait_for_pattern(self, 'ifconfig eth0 10.0.2.15',
+                                                 'eth0: link becomes ready')
+        exec_command_and_wait_for_pattern(self, 'ping -c 3 10.0.2.2',
+            '3 packets transmitted, 3 packets received, 0% packet loss')
 
     def do_test_arm_raspi2(self, uart_id):
         """
-- 
2.7.4



Return-Path: <SRS0=3HrQ=6A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFBEEC2BB55
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 14:56:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF0D62051A
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 14:56:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GxS235H1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF0D62051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jP5we-0004Pt-LG
	for qemu-devel@archiver.kernel.org; Thu, 16 Apr 2020 10:56:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46248)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sundeep.lkml@gmail.com>) id 1jP5v9-0002WS-KW
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 10:55:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sundeep.lkml@gmail.com>) id 1jP5v8-0005Yx-G9
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 10:55:15 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:45307)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <sundeep.lkml@gmail.com>)
 id 1jP5v8-0005Ym-AN; Thu, 16 Apr 2020 10:55:14 -0400
Received: by mail-pl1-x642.google.com with SMTP id t4so1429833plq.12;
 Thu, 16 Apr 2020 07:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=gXNblUO4SiKtKIE29/5D+Fmm4HZBRwhfz9A4bbnSMB4=;
 b=GxS235H1iUMxWW4h9nKIN9JA12k1F2bLXo/mfe0qriugoyPBVvwAsQn23g/RYfMRgH
 1Ar+DzwGMPWipFUXB/wD60Wj114A1jc2ODSCHVOFaDf8s9s2pQbMiAangsaVDeDnydf6
 gEmEoGjbjNKmL9uyN0CYNX6bKBUM58OUZq1Qng65yB+5BFKQ+ujW4uzWSRUwuH8GENBz
 FEY/TkYWQRp2zrmxbeRLy5ySjeJDg7JQFq6PWyKURvqo+m50a+oHhtbcBZeisRht+PJf
 eN2IPyTkvSd2CIs2biGYRIavbRVfgdjv/CpdWwu563h+FHKkolfz3DeNhPCzJZQW/I0+
 wI2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=gXNblUO4SiKtKIE29/5D+Fmm4HZBRwhfz9A4bbnSMB4=;
 b=hMVkAPgNWpaDKOWWautXw9LeXVTDcVoVZXoGopDyHxHVxFndBo204XxTa6TdzacI1J
 CCX/iuAVCX98atyTaAo0TzERUIzIUS/kr4EEn0Da73Zpa/RJ7QtPC09vlCPgXkN6PveR
 xS8DQyUILq98FmsjNyKqWyIDgIJK1tTqCcGizIqgyf2XEUVIDshbYvFmk1MO6medxmTg
 MBw8fuKnnjj29pSnENCdJeLwybfLh+Xs0oxcE3j681Dbb4VOA7IeuetIphzq8hK7TwZx
 nvRzXUwfJrWfCixx5Zz0xHi/PePOGp5d/iZcGemcRv8vVh0TeVq7YuIw7tjYr/kyAUL+
 EJRg==
X-Gm-Message-State: AGi0PuZmxS9xmGf7kx1Esp7PEEpWv7sllgw0f41l8t6YdVAgwZyd29Bz
 fx1LjWBlDGEl7Ojgqp3pgd//mpJ6Ug0=
X-Google-Smtp-Source: APiQypIU+gex4tMx6+52c1OjML0h8kzlrOlaD3kZwUgSmwusNSA5j3rAAkhElEgIGP7BYdUkhUonNg==
X-Received: by 2002:a17:90b:97:: with SMTP id
 bb23mr5427950pjb.59.1587048913432; 
 Thu, 16 Apr 2020 07:55:13 -0700 (PDT)
Received: from hyd1358.marvell.com ([115.113.156.2])
 by smtp.googlemail.com with ESMTPSA id s63sm3671973pfb.44.2020.04.16.07.55.11
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 16 Apr 2020 07:55:13 -0700 (PDT)
From: sundeep.lkml@gmail.com
To: jasowang@redhat.com, peter.maydell@linaro.org, philmd@redhat.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
Subject: [Qemu devel PATCH v6 3/3] tests/boot_linux_console: Add ethernet test
 to SmartFusion2
Date: Thu, 16 Apr 2020 20:24:51 +0530
Message-Id: <1587048891-30493-4-git-send-email-sundeep.lkml@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1587048891-30493-1-git-send-email-sundeep.lkml@gmail.com>
References: <1587048891-30493-1-git-send-email-sundeep.lkml@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
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
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
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



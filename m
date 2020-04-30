Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31DF5C8300A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 11:58:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F15AD20757
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 11:58:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GW855yhi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F15AD20757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU7pW-0006zf-3f
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 07:58:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33720)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jU7jQ-0002ir-Ku
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:51:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jU7jP-0000L2-61
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:51:56 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:35182)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jU7jO-0000KR-MW
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 07:51:54 -0400
Received: by mail-wm1-x32b.google.com with SMTP id r26so1551548wmh.0
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 04:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=ZY3oMjv55jr/fCB1Ius33wty91gBP4lyCC8NXchsQCk=;
 b=GW855yhiQ/G+Tgqu1ge2CJ73AllYTqSh1GYGxr993CJUpbw0FWIeqD/MfTNbB3OF5l
 JQyTYIf0MlRxGTc1X0exRDrHusKswylZap2YGlgUgEUto1NBxjXNRlZCotwuaeXLeoi3
 wU5TRdsjqx7AOm6VN3WL6vQoLi58QrurOQapHAyv7KdE86F7jTGDBTuE2zh0qD6WIDlD
 3ZrhhgdClmKZDr+jBgd/YSTA3Smy7wMLBaK72ZXNmVtM+sU5Jw2MVzzgC/2zn5FCXkzh
 00Rsj/ELGFHTC3/Bjs2asADnOHFCPcFWFAKbsArht7nGoOTP+Icfw+k1Pg5VDsj6XoSi
 tEEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZY3oMjv55jr/fCB1Ius33wty91gBP4lyCC8NXchsQCk=;
 b=RBonOXnktXZik9+lysyStykfrIvQaLQ0mQJsLLWJzhKpEzquDzw7YtEJhDgEftK6jm
 GtdE3SsUxZimVhcCnuhQSz/tGWh2Qz8PEy+R9FXnaF9uGkEV+mDryfPKsDNeLsnlF1w6
 MKoycj1sbHPr6oc7UuqsKBKWVcB0A/cRyHvpDHQsWuMKkzUmmFQsT+QDvW7Gvqljnk+5
 lKYwhtM2P7xEyd1BJwZQT85DfpJL9ge3UOKiSuq03zuXu1m4GuiNWNpIUrK7y4EgWUGZ
 LR93J6sj3DsOACO2zIaG4k77Iac9EYsrO85SFBiTPZ3lzqqu+DID6Y5NZAJCmH/tsqRo
 HXZA==
X-Gm-Message-State: AGi0Publdqm1LB7ihoeY0J6rS4mj1LhxUpbxM12lslt1gwZtCLYaWuY2
 0MCboYYkp3aWcgbg/3R1m6fBJLu5Tf8/pQ==
X-Google-Smtp-Source: APiQypIeF+WPRpvp5YyzXH2HwHUR2z6tjjiOoxFbD4x8xGODbW8YakA9zLroOpJNey5C5/tRE1VgCA==
X-Received: by 2002:a05:600c:21ca:: with SMTP id
 x10mr2459382wmj.113.1588247513016; 
 Thu, 30 Apr 2020 04:51:53 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id j22sm491518wre.84.2020.04.30.04.51.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2020 04:51:52 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/31] tests/boot_linux_console: Add ethernet test to
 SmartFusion2
Date: Thu, 30 Apr 2020 12:51:19 +0100
Message-Id: <20200430115142.13430-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430115142.13430-1-peter.maydell@linaro.org>
References: <20200430115142.13430-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::32b
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Subbaraya Sundeep <sundeep.lkml@gmail.com>

In addition to simple serial test this patch uses ping
to test the ethernet block modelled in SmartFusion2 SoC.

Signed-off-by: Subbaraya Sundeep <sundeep.lkml@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 1587048891-30493-4-git-send-email-sundeep.lkml@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/acceptance/boot_linux_console.py | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
index f825cd9ef55..c6b06a1a138 100644
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
2.20.1



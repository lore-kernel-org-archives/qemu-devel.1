Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D9AECE587
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 16:50:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E301620854
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 16:50:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vaWazH5S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E301620854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK3Xt-0002MI-Jc
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 12:50:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37346)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iK2qe-00056x-Qk
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:05:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iK2qd-00086E-IX
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:05:28 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:52246)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iK2qd-00085r-Bv
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:05:27 -0400
Received: by mail-wm1-x334.google.com with SMTP id r19so17863769wmh.2
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 09:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=IqGNIGYeYxIliLJN1uLbXaji79hnCldokJEYbv+GISM=;
 b=vaWazH5SfNaUJ2rINfgkFwL08o/qYqifZdpyvMrJ0L9Ltr4wHMArMp8P++PoXXUngL
 0Tcr6RETzbcSMWtFkgzMD8EyiwxGBwMIXEm6tywOYwB0nDocXf2f0r2otqYDG9vXIXE9
 3ldYmGyR6y3t2KOh6jiwlv+JaC7tj/31bte8g6XwRfyEXQO3jDi2jKzNaZtCJ1yjLVEV
 QDbBYVQgQBODQSknHfUvRjKcunkJaZmXZYtoUMkA6Oiiq7YF0lBA1qQCCNmfGcJqxKpa
 GiA7OKe76b7BTvRZwXxbGzDVE7B824cX3pS4qolYk4kLxoauBaEeitCb3iGP39G1y68w
 X28w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=IqGNIGYeYxIliLJN1uLbXaji79hnCldokJEYbv+GISM=;
 b=kALYPgsWzFa0CPP5OqJc1PJOLIDuoIKhKSqod3eunTWC/oinlVSIX5CCqlyWM5MUKc
 iV4SDpBNmjJYRjL2YLFWOLksxypFc6rKp6Zq/Cj4PePihKKRa0vv/HHOcUvyL3Cxwcag
 TL5xbPk+z1QxFGC7i+R2PtU+gfNzEFK3yKMWYyPA2j3yjuzdfAk+osbaQwJGxOLYTdDx
 V1TfPOYan3vnV5LPvZFnArAkFcfI0RKrE6jZE/8ODVe9d23KrTo/PH943Y25X1DT/pKs
 5GBCDKu5WIBCxdjci9zqRJbb5raP/6deXx9CP5c39Nm4J7VKf6EFKDF8VFfhZPr3hy1K
 LN5w==
X-Gm-Message-State: APjAAAWXw2+554vtB34Uy+Phi7I7cf23gE2joaGnV/+EH6lkIE9bb9tP
 5q+pV4dOZsW+YJY+HMvTqokOo777QJ09zA==
X-Google-Smtp-Source: APXvYqy/hm2G3nu9vo9rp21IWDgnB3HmSKPJdEzTrZnBfJcVn+cL9kWruJxQZyQkpe7rGOyyz70tUQ==
X-Received: by 2002:a1c:f00a:: with SMTP id a10mr16480746wmb.89.1571069126074; 
 Mon, 14 Oct 2019 09:05:26 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 5sm18029779wrk.86.2019.10.14.09.05.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 09:05:25 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 50/68] hw: wdt_aspeed: Add AST2600 support
Date: Mon, 14 Oct 2019 17:03:46 +0100
Message-Id: <20191014160404.19553-51-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191014160404.19553-1-peter.maydell@linaro.org>
References: <20191014160404.19553-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::334
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

From: Joel Stanley <joel@jms.id.au>

The AST2600 has four watchdogs, and they each have a 0x40 of registers.

When running as part of an ast2600 system we must check a different
offset for the system reset control register in the SCU.

Signed-off-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
Message-id: 20190925143248.10000-12-clg@kaod.org
[clg: - reworked model integration into new object class ]
Signed-off-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/aspeed_soc.h      |  2 +-
 include/hw/watchdog/wdt_aspeed.h |  1 +
 hw/watchdog/wdt_aspeed.c         | 29 +++++++++++++++++++++++++++++
 3 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index ba5bbb53e1a..b427f2668a8 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -27,7 +27,7 @@
 #include "hw/sd/aspeed_sdhci.h"
 
 #define ASPEED_SPIS_NUM  2
-#define ASPEED_WDTS_NUM  3
+#define ASPEED_WDTS_NUM  4
 #define ASPEED_CPUS_NUM  2
 #define ASPEED_MACS_NUM  2
 
diff --git a/include/hw/watchdog/wdt_aspeed.h b/include/hw/watchdog/wdt_aspeed.h
index 796342764e2..dfedd7662dd 100644
--- a/include/hw/watchdog/wdt_aspeed.h
+++ b/include/hw/watchdog/wdt_aspeed.h
@@ -18,6 +18,7 @@
     OBJECT_CHECK(AspeedWDTState, (obj), TYPE_ASPEED_WDT)
 #define TYPE_ASPEED_2400_WDT TYPE_ASPEED_WDT "-ast2400"
 #define TYPE_ASPEED_2500_WDT TYPE_ASPEED_WDT "-ast2500"
+#define TYPE_ASPEED_2600_WDT TYPE_ASPEED_WDT "-ast2600"
 
 #define ASPEED_WDT_REGS_MAX        (0x20 / 4)
 
diff --git a/hw/watchdog/wdt_aspeed.c b/hw/watchdog/wdt_aspeed.c
index fc0e6c486a7..145be6f99ce 100644
--- a/hw/watchdog/wdt_aspeed.c
+++ b/hw/watchdog/wdt_aspeed.c
@@ -40,12 +40,14 @@
 #define     WDT_DRIVE_TYPE_MASK         (0xFF << 24)
 #define     WDT_PUSH_PULL_MAGIC         (0xA8 << 24)
 #define     WDT_OPEN_DRAIN_MAGIC        (0x8A << 24)
+#define WDT_RESET_MASK1                 (0x1c / 4)
 
 #define WDT_TIMEOUT_STATUS              (0x10 / 4)
 #define WDT_TIMEOUT_CLEAR               (0x14 / 4)
 
 #define WDT_RESTART_MAGIC               0x4755
 
+#define AST2600_SCU_RESET_CONTROL1      (0x40 / 4)
 #define SCU_RESET_CONTROL1              (0x04 / 4)
 #define    SCU_RESET_SDRAM              BIT(0)
 
@@ -74,6 +76,8 @@ static uint64_t aspeed_wdt_read(void *opaque, hwaddr offset, unsigned size)
         return s->regs[WDT_CTRL];
     case WDT_RESET_WIDTH:
         return s->regs[WDT_RESET_WIDTH];
+    case WDT_RESET_MASK1:
+        return s->regs[WDT_RESET_MASK1];
     case WDT_TIMEOUT_STATUS:
     case WDT_TIMEOUT_CLEAR:
         qemu_log_mask(LOG_UNIMP,
@@ -146,6 +150,11 @@ static void aspeed_wdt_write(void *opaque, hwaddr offset, uint64_t data,
         s->regs[WDT_RESET_WIDTH] |= data & awc->ext_pulse_width_mask;
         break;
 
+    case WDT_RESET_MASK1:
+        /* TODO: implement */
+        s->regs[WDT_RESET_MASK1] = data;
+        break;
+
     case WDT_TIMEOUT_STATUS:
     case WDT_TIMEOUT_CLEAR:
         qemu_log_mask(LOG_UNIMP,
@@ -316,12 +325,32 @@ static const TypeInfo aspeed_2500_wdt_info = {
     .class_init = aspeed_2500_wdt_class_init,
 };
 
+static void aspeed_2600_wdt_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    AspeedWDTClass *awc = ASPEED_WDT_CLASS(klass);
+
+    dc->desc = "ASPEED 2600 Watchdog Controller";
+    awc->offset = 0x40;
+    awc->ext_pulse_width_mask = 0xfffff; /* TODO */
+    awc->reset_ctrl_reg = AST2600_SCU_RESET_CONTROL1;
+    awc->reset_pulse = aspeed_2500_wdt_reset_pulse;
+}
+
+static const TypeInfo aspeed_2600_wdt_info = {
+    .name = TYPE_ASPEED_2600_WDT,
+    .parent = TYPE_ASPEED_WDT,
+    .instance_size = sizeof(AspeedWDTState),
+    .class_init = aspeed_2600_wdt_class_init,
+};
+
 static void wdt_aspeed_register_types(void)
 {
     watchdog_add_model(&model);
     type_register_static(&aspeed_wdt_info);
     type_register_static(&aspeed_2400_wdt_info);
     type_register_static(&aspeed_2500_wdt_info);
+    type_register_static(&aspeed_2600_wdt_info);
 }
 
 type_init(wdt_aspeed_register_types)
-- 
2.20.1



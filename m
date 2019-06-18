Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10B95C31E51
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 08:53:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7F5F2133F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 08:53:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RBGzZ3Gd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7F5F2133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54900 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hd9sK-0008N6-W4
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 04:53:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45097)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <rashmica.g@gmail.com>) id 1hd9qs-0007AA-14
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 04:52:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <rashmica.g@gmail.com>) id 1hd9qq-0000na-2K
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 04:52:25 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:46295)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <rashmica.g@gmail.com>)
 id 1hd9qk-0000i6-1n; Tue, 18 Jun 2019 04:52:18 -0400
Received: by mail-pl1-x641.google.com with SMTP id e5so5402511pls.13;
 Tue, 18 Jun 2019 01:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=E7RZnL+vY/V37+EcuN6Eh+i0O5QdDnRjk1ExQ99addY=;
 b=RBGzZ3GdDUpBtU0cP3Re8FcE19uFVuCcxCCSjkmTpqFVPvIG2c44I8hr1CiZK7Z+t4
 rlJqVdIng79LzSfk/FLaqHCqVWtqhBVdZpHEE8PhKuPb2sOAQ5pe5PBc5VFwJS2BwVg0
 Hr8hHsUKxDsgKhTCDd3teNMTr2CgVSKvDm6cZqXdhisVkXnkpM3Bq3PWyE+OlqoBZWUJ
 2lbwEoHjGkv1osFI+MFcUG2/mHYu8B7px0VfEHJQu9ffhC1DUKHGHP8xDiOhHhz7YjBm
 fLenypUbKslqXP/PLZ5jp6DHUO5OKjYdp06m284DP2RrQrtSAtRr7gvz/kjggpZgnPgb
 EnpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=E7RZnL+vY/V37+EcuN6Eh+i0O5QdDnRjk1ExQ99addY=;
 b=Oo6T3bM9UGTqH3Fo22acVdDgd1hOgQSmybU/4MBfM11XzBqmSd1nPZhymQ3lpu7jeY
 /33Zoc0/z4XEAa4LUHrLJ0so8p0MQEd/E1hrNYaPMNU0rSMSp3PGUCIlFeLZ4mu5nd6z
 5tUxLVz89BZ/pSbp7V8IYatsTOSpLeeVMB8ABe8JhJxzvXt41OcwZIoF2A0RwEpDOBIi
 kYz0N+nj+DzKcbW4vFjjj5Gg4pIuucCLSWhvNza0d31tnhHBEFxkgTWOp0jpsyLHl+vx
 0dmmmXGJFfwZmjCG7XoPfX7x1VVKAg8zwGJdNnOjx9GN7HNMdLfSzTCKz6f+QCh9INfZ
 sA2w==
X-Gm-Message-State: APjAAAWYAbq606BM3jQkkxv56ZRvani77Ph79031wE5nJifr6dKFpNdG
 bn/daKYQAlebyi4gCIvzOIph9zI0
X-Google-Smtp-Source: APXvYqw4AQNRM5U29WZAuL7vBWpIdWDzvv16a8wPsx/Mfr+cd+CU2cxHATmIoOPne8xELVoxUC70Pw==
X-Received: by 2002:a17:902:7d8d:: with SMTP id
 a13mr222978plm.98.1560847935802; 
 Tue, 18 Jun 2019 01:52:15 -0700 (PDT)
Received: from rashmica.home.majoof.com ([43.245.162.131])
 by smtp.gmail.com with ESMTPSA id p7sm27032616pfp.131.2019.06.18.01.52.12
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 18 Jun 2019 01:52:15 -0700 (PDT)
From: Rashmica Gupta <rashmica.g@gmail.com>
To: qemu-arm@nongnu.org
Date: Tue, 18 Jun 2019 18:51:54 +1000
Message-Id: <20190618085154.21498-3-rashmica.g@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190618085154.21498-1-rashmica.g@gmail.com>
References: <20190618085154.21498-1-rashmica.g@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
Subject: [Qemu-devel] [PATCH 2/2] aspeed: add a GPIO controller to the SoC
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
Cc: andrew@aj.id.au, clg@kaod.org, qemu-devel@nongnu.org,
 Rashmica Gupta <rashmica.g@gmail.com>, joel@jms.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Rashmica Gupta <rashmica.g@gmail.com>
---
 hw/arm/aspeed_soc.c         | 17 +++++++++++++++++
 include/hw/arm/aspeed_soc.h |  3 +++
 2 files changed, 20 insertions(+)

diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
index 1cc98b9f40..8583869acf 100644
--- a/hw/arm/aspeed_soc.c
+++ b/hw/arm/aspeed_soc.c
@@ -23,6 +23,7 @@
 #include "net/net.h"
 
 #define ASPEED_SOC_IOMEM_SIZE       0x00200000
+#define ASPEED_SOC_GPIO_BASE        0x1E780000
 
 static const hwaddr aspeed_soc_ast2400_memmap[] = {
     [ASPEED_IOMEM]  = 0x1E600000,
@@ -120,6 +121,7 @@ static const AspeedSoCInfo aspeed_socs[] = {
         .spis_num     = 1,
         .fmc_typename = "aspeed.smc.fmc",
         .spi_typename = aspeed_soc_ast2400_typenames,
+        .gpio_typename = "aspeed.gpio-ast2400",
         .wdts_num     = 2,
         .irqmap       = aspeed_soc_ast2400_irqmap,
         .memmap       = aspeed_soc_ast2400_memmap,
@@ -131,6 +133,7 @@ static const AspeedSoCInfo aspeed_socs[] = {
         .spis_num     = 1,
         .fmc_typename = "aspeed.smc.fmc",
         .spi_typename = aspeed_soc_ast2400_typenames,
+        .gpio_typename = "aspeed.gpio-ast2400",
         .wdts_num     = 2,
         .irqmap       = aspeed_soc_ast2400_irqmap,
         .memmap       = aspeed_soc_ast2400_memmap,
@@ -142,6 +145,7 @@ static const AspeedSoCInfo aspeed_socs[] = {
         .spis_num     = 1,
         .fmc_typename = "aspeed.smc.fmc",
         .spi_typename = aspeed_soc_ast2400_typenames,
+        .gpio_typename = "aspeed.gpio-ast2400",
         .wdts_num     = 2,
         .irqmap       = aspeed_soc_ast2400_irqmap,
         .memmap       = aspeed_soc_ast2400_memmap,
@@ -153,6 +157,7 @@ static const AspeedSoCInfo aspeed_socs[] = {
         .spis_num     = 2,
         .fmc_typename = "aspeed.smc.ast2500-fmc",
         .spi_typename = aspeed_soc_ast2500_typenames,
+        .gpio_typename = "aspeed.gpio-ast2500",
         .wdts_num     = 3,
         .irqmap       = aspeed_soc_ast2500_irqmap,
         .memmap       = aspeed_soc_ast2500_memmap,
@@ -225,6 +230,8 @@ static void aspeed_soc_init(Object *obj)
 
     sysbus_init_child_obj(obj, "ftgmac100", OBJECT(&s->ftgmac100),
                           sizeof(s->ftgmac100), TYPE_FTGMAC100);
+    sysbus_init_child_obj(obj, "gpio", OBJECT(&s->gpio), sizeof(s->gpio),
+                          sc->info->gpio_typename);
 }
 
 static void aspeed_soc_realize(DeviceState *dev, Error **errp)
@@ -366,6 +373,16 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
                     sc->info->memmap[ASPEED_ETH1]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->ftgmac100), 0,
                        aspeed_soc_get_irq(s, ASPEED_ETH1));
+
+    /* GPIO */
+    object_property_set_bool(OBJECT(&s->gpio), true, "realized", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->gpio), 0, ASPEED_SOC_GPIO_BASE);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpio), 0,
+            qdev_get_gpio_in(DEVICE(&s->vic), 20));
 }
 
 static void aspeed_soc_class_init(ObjectClass *oc, void *data)
diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index 88b901d5df..28ff2bedb4 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -20,6 +20,7 @@
 #include "hw/ssi/aspeed_smc.h"
 #include "hw/watchdog/wdt_aspeed.h"
 #include "hw/net/ftgmac100.h"
+#include "hw/gpio/aspeed_gpio.h"
 
 #define ASPEED_SPIS_NUM  2
 #define ASPEED_WDTS_NUM  3
@@ -40,6 +41,7 @@ typedef struct AspeedSoCState {
     AspeedSDMCState sdmc;
     AspeedWDTState wdt[ASPEED_WDTS_NUM];
     FTGMAC100State ftgmac100;
+    AspeedGPIOState gpio;
 } AspeedSoCState;
 
 #define TYPE_ASPEED_SOC "aspeed-soc"
@@ -53,6 +55,7 @@ typedef struct AspeedSoCInfo {
     int spis_num;
     const char *fmc_typename;
     const char **spi_typename;
+    const char *gpio_typename;
     int wdts_num;
     const int *irqmap;
     const hwaddr *memmap;
-- 
2.17.2



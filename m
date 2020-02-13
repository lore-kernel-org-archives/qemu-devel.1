Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74279C2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 15:14:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F26272168B
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 15:14:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rTsIpSY8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F26272168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2GBp-0003dI-UO
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 10:14:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60445)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j2FhC-0004h0-1c
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:42:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j2Fh9-0002E2-IC
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:42:25 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:45635)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j2Fh9-0002Ch-Ak
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 09:42:23 -0500
Received: by mail-wr1-x432.google.com with SMTP id g3so6966051wrs.12
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 06:42:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=0V9qaj2G2nmmxYotWQnlHB27wnLxZhF+76Y+FiGCx/w=;
 b=rTsIpSY8J60vHPgMSsgls0LVjtAbOncOPwLOgdXHg0i/K62RxM8RTpbBEwvIOgAamM
 oqjHa4cwkPt7yjAstcn45jNJY9+uCeykwKVjibnrosihNSyRtFYxY3zQSAkGvHHUKSoP
 ATLXrJt1lG2JSTQ0WaTlMvUhPbTVUzP93lK/l59xHVXQbQTU4HA8uc3jTq+D3iZIEd25
 pPrb2dDntVAt6FIq6Kgit4E1R64agOakFreMRTwWx/b/RByK72GCPRvn9Kxv02nmeKlt
 Cd3z2WbvHK+2AR91YApyv4qT2qpohhyHQm+JaYmorgWeZNlxwp2LiVOQv6IWnRhyVDdX
 5aHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=0V9qaj2G2nmmxYotWQnlHB27wnLxZhF+76Y+FiGCx/w=;
 b=Ohah7Xa4IXwfMJhgd+pGKrfjX1e4sarKdLNZ9A2I4hC6dyI74Sk3eexi9fqs31pwYc
 Zl5X2CsUOCfXLODOOH/LQfpcdlPpsAZ7fwuSW1sxCHENS7uyw7OS8hiLJKwd0ePoZtBy
 FPvH77LS1tz3bQsd7c3+M1LFQRWIf+bsD0uHZajc2QrARmCoGsTeo+qQPj0qxEv9UTuN
 CzdLhewt+1sory60aTzfSSRhuinZfE1a8AVUgYXRjqhX27vNx3Yx7CrfCyXi2E2ANjMl
 Y3jT0Mzu/E9D992ffLGmTMOJ1kYDpbfTSM/sZ0ulteeFAC2e0GV1CgPOP6NL8GvQeqhz
 aVkw==
X-Gm-Message-State: APjAAAVuCljxFiRL9ksgUjl1Nl2R54N64ojTEFNeYQQxLvxWMJs9k0ce
 RC2bjga5hhX/B9M4vNB5h0wLZHE8Z3U=
X-Google-Smtp-Source: APXvYqyMVaERweryGGfOLiSU31R8QyKF1cO1hs1XWsnMXH3PIYDv2GYyi9eyEWpUHLWXZo81ffJfKQ==
X-Received: by 2002:adf:e610:: with SMTP id p16mr23567702wrm.81.1581604941961; 
 Thu, 13 Feb 2020 06:42:21 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id e22sm3362454wme.45.2020.02.13.06.42.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2020 06:42:21 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 30/46] hw/arm: ast2400/ast2500: Wire up EHCI controllers
Date: Thu, 13 Feb 2020 14:41:29 +0000
Message-Id: <20200213144145.818-31-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200213144145.818-1-peter.maydell@linaro.org>
References: <20200213144145.818-1-peter.maydell@linaro.org>
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Guenter Roeck <linux@roeck-us.net>

Initialize EHCI controllers on AST2400 and AST2500 using the existing
TYPE_PLATFORM_EHCI. After this change, booting ast2500-evb into Linux
successfully instantiates a USB interface.

ehci-platform 1e6a3000.usb: EHCI Host Controller
ehci-platform 1e6a3000.usb: new USB bus registered, assigned bus number 1
ehci-platform 1e6a3000.usb: irq 21, io mem 0x1e6a3000
ehci-platform 1e6a3000.usb: USB 2.0 started, EHCI 1.00
usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.05
usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: EHCI Host Controller

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Joel Stanley <joel@jms.id.au>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20200206183437.3979-1-linux@roeck-us.net
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/aspeed_soc.h |  6 ++++++
 hw/arm/aspeed_soc.c         | 25 +++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index 90ac7f7ffa3..78b9f6ae532 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -26,8 +26,10 @@
 #include "target/arm/cpu.h"
 #include "hw/gpio/aspeed_gpio.h"
 #include "hw/sd/aspeed_sdhci.h"
+#include "hw/usb/hcd-ehci.h"
 
 #define ASPEED_SPIS_NUM  2
+#define ASPEED_EHCIS_NUM 2
 #define ASPEED_WDTS_NUM  4
 #define ASPEED_CPUS_NUM  2
 #define ASPEED_MACS_NUM  4
@@ -50,6 +52,7 @@ typedef struct AspeedSoCState {
     AspeedXDMAState xdma;
     AspeedSMCState fmc;
     AspeedSMCState spi[ASPEED_SPIS_NUM];
+    EHCISysBusState ehci[ASPEED_EHCIS_NUM];
     AspeedSDMCState sdmc;
     AspeedWDTState wdt[ASPEED_WDTS_NUM];
     FTGMAC100State ftgmac100[ASPEED_MACS_NUM];
@@ -71,6 +74,7 @@ typedef struct AspeedSoCClass {
     uint32_t silicon_rev;
     uint64_t sram_size;
     int spis_num;
+    int ehcis_num;
     int wdts_num;
     int macs_num;
     const int *irqmap;
@@ -94,6 +98,8 @@ enum {
     ASPEED_FMC,
     ASPEED_SPI1,
     ASPEED_SPI2,
+    ASPEED_EHCI1,
+    ASPEED_EHCI2,
     ASPEED_VIC,
     ASPEED_SDMC,
     ASPEED_SCU,
diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
index b5e809a1d3f..696c7fda14b 100644
--- a/hw/arm/aspeed_soc.c
+++ b/hw/arm/aspeed_soc.c
@@ -30,6 +30,7 @@ static const hwaddr aspeed_soc_ast2400_memmap[] = {
     [ASPEED_IOMEM]  = 0x1E600000,
     [ASPEED_FMC]    = 0x1E620000,
     [ASPEED_SPI1]   = 0x1E630000,
+    [ASPEED_EHCI1]  = 0x1E6A1000,
     [ASPEED_VIC]    = 0x1E6C0000,
     [ASPEED_SDMC]   = 0x1E6E0000,
     [ASPEED_SCU]    = 0x1E6E2000,
@@ -59,6 +60,8 @@ static const hwaddr aspeed_soc_ast2500_memmap[] = {
     [ASPEED_FMC]    = 0x1E620000,
     [ASPEED_SPI1]   = 0x1E630000,
     [ASPEED_SPI2]   = 0x1E631000,
+    [ASPEED_EHCI1]  = 0x1E6A1000,
+    [ASPEED_EHCI2]  = 0x1E6A3000,
     [ASPEED_VIC]    = 0x1E6C0000,
     [ASPEED_SDMC]   = 0x1E6E0000,
     [ASPEED_SCU]    = 0x1E6E2000,
@@ -91,6 +94,8 @@ static const int aspeed_soc_ast2400_irqmap[] = {
     [ASPEED_UART5]  = 10,
     [ASPEED_VUART]  = 8,
     [ASPEED_FMC]    = 19,
+    [ASPEED_EHCI1]  = 5,
+    [ASPEED_EHCI2]  = 13,
     [ASPEED_SDMC]   = 0,
     [ASPEED_SCU]    = 21,
     [ASPEED_ADC]    = 31,
@@ -180,6 +185,11 @@ static void aspeed_soc_init(Object *obj)
                               sizeof(s->spi[i]), typename);
     }
 
+    for (i = 0; i < sc->ehcis_num; i++) {
+        sysbus_init_child_obj(obj, "ehci[*]", OBJECT(&s->ehci[i]),
+                              sizeof(s->ehci[i]), TYPE_PLATFORM_EHCI);
+    }
+
     snprintf(typename, sizeof(typename), "aspeed.sdmc-%s", socname);
     sysbus_init_child_obj(obj, "sdmc", OBJECT(&s->sdmc), sizeof(s->sdmc),
                           typename);
@@ -364,6 +374,19 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
                         s->spi[i].ctrl->flash_window_base);
     }
 
+    /* EHCI */
+    for (i = 0; i < sc->ehcis_num; i++) {
+        object_property_set_bool(OBJECT(&s->ehci[i]), true, "realized", &err);
+        if (err) {
+            error_propagate(errp, err);
+            return;
+        }
+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->ehci[i]), 0,
+                        sc->memmap[ASPEED_EHCI1 + i]);
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->ehci[i]), 0,
+                           aspeed_soc_get_irq(s, ASPEED_EHCI1 + i));
+    }
+
     /* SDMC - SDRAM Memory Controller */
     object_property_set_bool(OBJECT(&s->sdmc), true, "realized", &err);
     if (err) {
@@ -472,6 +495,7 @@ static void aspeed_soc_ast2400_class_init(ObjectClass *oc, void *data)
     sc->silicon_rev  = AST2400_A1_SILICON_REV;
     sc->sram_size    = 0x8000;
     sc->spis_num     = 1;
+    sc->ehcis_num    = 1;
     sc->wdts_num     = 2;
     sc->macs_num     = 2;
     sc->irqmap       = aspeed_soc_ast2400_irqmap;
@@ -496,6 +520,7 @@ static void aspeed_soc_ast2500_class_init(ObjectClass *oc, void *data)
     sc->silicon_rev  = AST2500_A1_SILICON_REV;
     sc->sram_size    = 0x9000;
     sc->spis_num     = 2;
+    sc->ehcis_num    = 2;
     sc->wdts_num     = 3;
     sc->macs_num     = 2;
     sc->irqmap       = aspeed_soc_ast2500_irqmap;
-- 
2.20.1



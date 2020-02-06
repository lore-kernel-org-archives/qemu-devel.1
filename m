Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 101E5C33CAC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 18:36:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D18E820659
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 18:36:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sonqdz87"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D18E820659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izm0X-0004z8-2K
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 13:36:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34570)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groeck7@gmail.com>) id 1izlzA-00033r-PJ
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 13:34:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groeck7@gmail.com>) id 1izlz9-00087S-Fb
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 13:34:44 -0500
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c]:40769)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <groeck7@gmail.com>)
 id 1izlz6-00080p-RL; Thu, 06 Feb 2020 13:34:40 -0500
Received: by mail-pj1-x102c.google.com with SMTP id 12so339836pjb.5;
 Thu, 06 Feb 2020 10:34:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id;
 bh=Nkcefj1Fwv1Np2JofQMp3Esk5UbF7VCowWclZhK7UQI=;
 b=Sonqdz87mBW9ULDhvc3ws0KWVUpve9cgrgpKMjUJVIYV/YoHrB3X+CHRXNUf7NrJYI
 t8/YiJq/j9qpbnkCqLGQvwMBSlm6yFhFpDEo2G+/2d701B2AuD1EZ+MJY3J6TCqO3Tf4
 eOG6VaIURMBFzP2K87pCr/znoT6TiSMSj6boTeF62kxpXKs3Jf8xpnqXluqyfM5fc9i6
 tTTDSvp8+r6nsup9wL80G8FJU6RFLJNWFokkBkhzcVXa1kcXLx+LMg16RzqiiqzmCqtJ
 bomXdZGp16udZ5U7dyE5iWVkeLsDgEPclSYYgsNoFZNXqTMmp+j1eyS3QaNLAPKL+zus
 ipkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
 bh=Nkcefj1Fwv1Np2JofQMp3Esk5UbF7VCowWclZhK7UQI=;
 b=jKhANf9EcYGSbAOLQI6hyOGSx0EX/JGE5xwDf3EqiBBOrIaYMJ9AmWkd9TBOzhSaPt
 /kW5ah3JL70b0ARjxAIlg4hOWDqCdfRY1yPSM5ukGkr4VsAxlK3+7hKhIk9EYqqyshWL
 kT/NsDbibiYUIyWnaO3PrYYAwqb16DCL5TlT1fQUZgszOL14XF/psp2dyDxcoLHxwsoL
 mnpShHJJIwG+IGPRcKa/WdaLdCAio3IE6b9AFy/8Gc+XJCJPxmCz4ggLm6hWWUlCq0m1
 MkwxMHsuVZYB5HT1v4+jMZNYp/ovCiIHiRTHrmo+5hE5wiQAQRdU9HKs3u7ev8HIZfD6
 0ItA==
X-Gm-Message-State: APjAAAX/WIo2vIT+A5cYolaLQzGBSa2A5nYdpHUkeL54vv7w2QhrDLUQ
 0QtVFgXaO1bjwD9EMPVj8z4=
X-Google-Smtp-Source: APXvYqwMR81LjFtA7wPsI3TiPN7tC3JztSWUiUNN57LQ/HNXjvw91X8T+WLgcMoXfXbIMDlonIkxiA==
X-Received: by 2002:a17:90a:9b88:: with SMTP id
 g8mr6122016pjp.72.1581014079761; 
 Thu, 06 Feb 2020 10:34:39 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id u7sm97190pfh.128.2020.02.06.10.34.38
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 06 Feb 2020 10:34:39 -0800 (PST)
From: Guenter Roeck <linux@roeck-us.net>
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH] hw/arm: ast2400/ast2500: Wire up EHCI controllers
Date: Thu,  6 Feb 2020 10:34:37 -0800
Message-Id: <20200206183437.3979-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::102c
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>,
 Guenter Roeck <linux@roeck-us.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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
---
 hw/arm/aspeed_soc.c         | 25 +++++++++++++++++++++++++
 include/hw/arm/aspeed_soc.h |  6 ++++++
 2 files changed, 31 insertions(+)

diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
index b5e809a1d3..696c7fda14 100644
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
diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index 90ac7f7ffa..78b9f6ae53 100644
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
-- 
2.17.1



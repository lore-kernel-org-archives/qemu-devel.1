Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C1E0C2BA83
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 17:47:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BDCC21741
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 17:47:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CSuzvFXR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BDCC21741
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j07in-0000Ma-Hl
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 12:47:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44471)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groeck7@gmail.com>) id 1j07hU-0007ko-Mt
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 12:45:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groeck7@gmail.com>) id 1j07hT-0006gT-6M
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 12:45:56 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:44717)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <groeck7@gmail.com>)
 id 1j07hQ-0006fV-JJ; Fri, 07 Feb 2020 12:45:52 -0500
Received: by mail-pg1-x544.google.com with SMTP id g3so115420pgs.11;
 Fri, 07 Feb 2020 09:45:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=t5xnOGmmDATC7VvfltIWmLOyLl/k0lGPYddVZzdKuyE=;
 b=CSuzvFXR9FgzXoC/Fa1/iy5S2g5umJw+FrAf8KWFOfXCDuTftdlG5QbXjn2TmGmGpx
 Ag+shmwSsZf+n3Mvv1WEWpHXwxKKQ1UDSLPNl+FUlTCtT4LINX182GpaJpnLK2Zqk7kb
 +CHvCVs048ugJANGGAnkZXIltME8N3XQxw5jvNPPdNL7Me7RVSmn4sdF3a8C5ZGg9t8r
 PA95bRPOY5VJxtmnpFewSmVeI8FqtU+0U5nYZFu9hQSllwbWGneeOyMeulvv546D7Ipf
 zRPEieFsZ34PvrguKIpRQ1Uc4OoDM72Ks8rHU2jCCRZ789Ix5cop7WNHFT9AbG1t7T1x
 c4MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=t5xnOGmmDATC7VvfltIWmLOyLl/k0lGPYddVZzdKuyE=;
 b=FQkNMmZoJE9d2TVDe6sMy4eIDQcuJAC5w9mlWsEqu5C9sopTXCpsdjbBC/acS5MnZd
 pcOR8so915lt89Yz/Efa+rU5Su2ZmUyfx/f534HZ09dQWmPCn7xaltyi4WhI50po4WHY
 bYDYMinSpKO0ARHE+7nOLo7oFmC8HZfezQTo+MfELhT/LMy0JQd+vtqoXTuuNw1j2usa
 3NSSgkwTz4NQfslqbIvJKUz/788oPB3fu0IIdYsgSdqwUhUeNyKeHT6bT4vasLlUWg6B
 JHgsZZVKWU4b5UbBljayh8NIvbsuECawmbbKvhtUQaU2Qf1u3DGiWNA+JMCrjX5w2SEW
 MoeA==
X-Gm-Message-State: APjAAAVzBFXke8LsS8LErhaAF65bIXcITRZAEv0X+dY5Qm0kmYrdPOr3
 FfonPPCEUrtAdkg5UP7V7Ak=
X-Google-Smtp-Source: APXvYqwtkMW+SZAnvDS8QbAPUyMj8K8piICK7STntb0rXT224/6DR+D2KtkhhP7zqZWtYr8O8WyOrQ==
X-Received: by 2002:aa7:9a01:: with SMTP id w1mr30034pfj.231.1581097551308;
 Fri, 07 Feb 2020 09:45:51 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id r62sm3770534pfc.89.2020.02.07.09.45.50
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 07 Feb 2020 09:45:50 -0800 (PST)
From: Guenter Roeck <linux@roeck-us.net>
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v2] hw/arm: ast2600: Wire up EHCI controllers
Date: Fri,  7 Feb 2020 09:45:48 -0800
Message-Id: <20200207174548.9087-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
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

Initialize EHCI controllers on AST2600 using the existing
TYPE_PLATFORM_EHCI. After this change, booting ast2600-evb
into Linux successfully instantiates a USB interface after
the necessary changes are made to its devicetree files.

ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
ehci-platform: EHCI generic platform driver
ehci-platform 1e6a3000.usb: EHCI Host Controller
ehci-platform 1e6a3000.usb: new USB bus registered, assigned bus number 1
ehci-platform 1e6a3000.usb: irq 25, io mem 0x1e6a3000
ehci-platform 1e6a3000.usb: USB 2.0 started, EHCI 1.00
usb usb1: Manufacturer: Linux 5.5.0-09825-ga0802f2d0ef5-dirty ehci_hcd
usb 1-1: new high-speed USB device number 2 using ehci-platform

Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Rebased to master (to fix context conflict)
    Added Reviewed-by: tag

 hw/arm/aspeed_ast2600.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
index 90cf1c755d..446b44d31c 100644
--- a/hw/arm/aspeed_ast2600.c
+++ b/hw/arm/aspeed_ast2600.c
@@ -31,6 +31,8 @@ static const hwaddr aspeed_soc_ast2600_memmap[] = {
     [ASPEED_FMC]       = 0x1E620000,
     [ASPEED_SPI1]      = 0x1E630000,
     [ASPEED_SPI2]      = 0x1E641000,
+    [ASPEED_EHCI1]     = 0x1E6A1000,
+    [ASPEED_EHCI2]     = 0x1E6A3000,
     [ASPEED_MII1]      = 0x1E650000,
     [ASPEED_MII2]      = 0x1E650008,
     [ASPEED_MII3]      = 0x1E650010,
@@ -79,6 +81,8 @@ static const int aspeed_soc_ast2600_irqmap[] = {
     [ASPEED_ADC]       = 78,
     [ASPEED_XDMA]      = 6,
     [ASPEED_SDHCI]     = 43,
+    [ASPEED_EHCI1]     = 5,
+    [ASPEED_EHCI2]     = 9,
     [ASPEED_EMMC]      = 15,
     [ASPEED_GPIO]      = 40,
     [ASPEED_GPIO_1_8V] = 11,
@@ -166,6 +170,11 @@ static void aspeed_soc_ast2600_init(Object *obj)
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
@@ -416,6 +425,19 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
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
@@ -534,6 +556,7 @@ static void aspeed_soc_ast2600_class_init(ObjectClass *oc, void *data)
     sc->silicon_rev  = AST2600_A0_SILICON_REV;
     sc->sram_size    = 0x10000;
     sc->spis_num     = 2;
+    sc->ehcis_num    = 2;
     sc->wdts_num     = 4;
     sc->macs_num     = 4;
     sc->irqmap       = aspeed_soc_ast2600_irqmap;
-- 
2.17.1



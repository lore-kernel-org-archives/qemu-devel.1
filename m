Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CF5CC2BA83
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 15:10:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E6AD20838
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 15:10:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lPJc74pq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E6AD20838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j05H2-00008X-Ge
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 10:10:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56028)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groeck7@gmail.com>) id 1j04xK-000119-Un
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:50:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groeck7@gmail.com>) id 1j04xG-00058h-Kx
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:50:05 -0500
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:36000)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <groeck7@gmail.com>)
 id 1j04xD-0004wM-OG; Fri, 07 Feb 2020 09:49:59 -0500
Received: by mail-pj1-x1044.google.com with SMTP id gv17so1026002pjb.1;
 Fri, 07 Feb 2020 06:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id;
 bh=oCAEZ4YZo0aISc3BRa7rvbjrbum3bZV93gOfR1uaB/M=;
 b=lPJc74pqxRHioEWnnulDBlxdpgIW+B0OPBGEms7a4ZLF0CE3UaNN4EYOa8bstVZifn
 CHoZFSW/uitmY5WsUHsigEtjiBoPlmT0uM4C/av/peWb8USR+nOdg0XXaGneKY7nibA9
 eEBJzyCAVdsAcByTYroFmCGnv30xXgRZV/I7GwoBjW1pNvExfpzkRRL7olJqa7x/ccvP
 bkWQBGW2d0qj58RmExkhSMoQHjUpdaWUl/Y7a7nzTIpiTcWhrlMS3kDq3UyfBv72em9b
 qZoLhrdmKGlgczYqA0ZH112B3VIVDE8up4epYPEzovJEPsjV/U26bVGluX5q4iQC36c7
 4q+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
 bh=oCAEZ4YZo0aISc3BRa7rvbjrbum3bZV93gOfR1uaB/M=;
 b=L7beLgp4BncTaT5vqI4N75OUpjE43M/SuGIeHaWfyKaq9LeolALa1Zte7JZPpuZULM
 ufvewTqBau7ER9rFQq1QzTQG+t8rH+M2GMeDPS+0QAz24jsV2GUHNzKeRWeAShhMlZN7
 9wqsBjOabdkSPIlmaJNwkPBL3imJ6es1yuwzi45tTzbx7KLSMkGZ+sIcR0KQ6/sCBIQ/
 wki8emQhtHup9U4seRbMa45n3Vvrsd3HYD1D4ZgEXEwbtfR4W4zphCrGxtnGMuvO7gjd
 jRqs3lidG1AGF+kYWfQFHsuAQket0f2LxdJFytXqgH4uEqnnBdj1KfJrNUoRACu5Z187
 dEuA==
X-Gm-Message-State: APjAAAXRN+hWrqpShdykPjYcRzOjoYrvpZPXeNNeS207LIt/ROYwq9x5
 M3IiU/z/mXi36TsBtqtMy+7aQqaO
X-Google-Smtp-Source: APXvYqz2tZc18ve/VWMx11toeLu7iXwfRWKRtv5xLCWxNhIeazH6HDh9TBLvxpcP+KzrI7nRqrCnng==
X-Received: by 2002:a17:90a:8806:: with SMTP id
 s6mr4027592pjn.141.1581086998301; 
 Fri, 07 Feb 2020 06:49:58 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id 144sm3660623pfc.45.2020.02.07.06.49.56
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 07 Feb 2020 06:49:57 -0800 (PST)
From: Guenter Roeck <linux@roeck-us.net>
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH] hw/arm: ast2600: Wire up EHCI controllers
Date: Fri,  7 Feb 2020 06:49:54 -0800
Message-Id: <20200207144954.13634-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1044
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

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 hw/arm/aspeed_ast2600.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
index 931887ac68..a528251c8d 100644
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
@@ -77,6 +79,8 @@ static const int aspeed_soc_ast2600_irqmap[] = {
     [ASPEED_ADC]       = 78,
     [ASPEED_XDMA]      = 6,
     [ASPEED_SDHCI]     = 43,
+    [ASPEED_EHCI1]     = 5,
+    [ASPEED_EHCI2]     = 9,
     [ASPEED_GPIO]      = 40,
     [ASPEED_GPIO_1_8V] = 11,
     [ASPEED_RTC]       = 13,
@@ -167,6 +171,11 @@ static void aspeed_soc_ast2600_init(Object *obj)
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
@@ -395,6 +404,19 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
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
@@ -499,6 +521,7 @@ static void aspeed_soc_ast2600_class_init(ObjectClass *oc, void *data)
     sc->silicon_rev  = AST2600_A0_SILICON_REV;
     sc->sram_size    = 0x10000;
     sc->spis_num     = 2;
+    sc->ehcis_num    = 2;
     sc->wdts_num     = 4;
     sc->macs_num     = 4;
     sc->irqmap       = aspeed_soc_ast2600_irqmap;
-- 
2.17.1



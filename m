Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F89C3A59C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 07:39:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D086C20644
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 07:39:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iSIXGw/G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D086C20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyWq0-0004vc-KI
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 03:39:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39183)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <rashmica.g@gmail.com>) id 1hyWk7-00079Q-7c
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 03:33:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <rashmica.g@gmail.com>) id 1hyWk5-0000W8-W1
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 03:33:47 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:43961)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <rashmica.g@gmail.com>)
 id 1hyWk3-0000UP-90; Fri, 16 Aug 2019 03:33:43 -0400
Received: by mail-pf1-x441.google.com with SMTP id v12so2691419pfn.10;
 Fri, 16 Aug 2019 00:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ljyF81NU6v4HO2LcgP50Xe8zeu9wLdfrnocnlpiypN4=;
 b=iSIXGw/GzXvi4uZPSjFDpJ1pYAQNOR/21h8SL8KG/Qcmj/2gYbJVL6dscnDOBlY3wA
 cE4y39LwPhdSvAktqq2ZPtkKV9cI6kXYDK2s+NofQL2zRekL+hgCnZVmdNUQwlIAMwjP
 CWtKuC3QBHFK/BhOMZePY0reaO9JJ9YhnNHQQ7OsDkdz1XcsLLDlNKn9Y0filHEb3vcv
 fmsX9q+xeF5vDPdtm5GtETqW8VwuUkXMQJycbQn3gur3GflipuKn00xqUilUR6ZYSBLP
 KHivZhRRN6v4szwpIQynPdjFneBFOnjrrtqdFqbOJilB6cRnN/ueCAoFGgL1dkRcqPqb
 BkmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ljyF81NU6v4HO2LcgP50Xe8zeu9wLdfrnocnlpiypN4=;
 b=V4UsrfNKpDLKXwqCnigveiOWKmF9IwY3GAyfsN7qWaVlf6N/hDPAvA1Yl0YcLIeU4j
 2Zu1iPpIZjFDjabYD0pXVrRe41QHQO+kVHXmIpcQ3CGcoagIJkV0LjypetmPjmjrf+40
 XgreJc2jwaU3bywaByQzhI370AibDdrJ7VO4+cbjtk81wV7098Psyw6UiJ5pBpa0qAT7
 FRM365sJBvBjpjjSic2fBAgAYpFfhYITiQuA9Dk2DvHidoHO+CzM7xoJ1F62FX+fan9C
 J23AhcFbKoe8BSsSYmwlieg8cBKZBYDm9OAr2GtySmUJwXoaYPGUzw6K/dQyVDt7YC0+
 ZwIA==
X-Gm-Message-State: APjAAAX2m2eQTnpe0Mi00D0J+kHd70FRW7iBu7ZoXYa5J4qX5e3AOM/K
 diu7HKFQQpd/yJ1GqZUazTg=
X-Google-Smtp-Source: APXvYqwc9Z/f1eoVGsGsLTnGvxTq4rbgg7xC/NgvICiHbjdSVwGsM9JXrkQ16bsXgxbfDBnKepHCMA==
X-Received: by 2002:a65:6284:: with SMTP id f4mr6785723pgv.416.1565940822057; 
 Fri, 16 Aug 2019 00:33:42 -0700 (PDT)
Received: from rashmica.ozlabs.ibm.com ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id w129sm5638589pfd.89.2019.08.16.00.33.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2019 00:33:41 -0700 (PDT)
From: Rashmica Gupta <rashmica.g@gmail.com>
To: peter.maydell@linaro.org,
	qemu-arm@nongnu.org
Date: Fri, 16 Aug 2019 17:32:28 +1000
Message-Id: <20190816073229.22787-3-rashmica.g@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190816073229.22787-1-rashmica.g@gmail.com>
References: <20190816073229.22787-1-rashmica.g@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: [Qemu-devel] [PATCH v5 2/3] aspeed: add a GPIO controller to the SoC
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
Cc: andrew@aj.id.au, qemu-devel@nongnu.org, aik@ozlabs.ru, joel@jms.id.au,
 Rashmica Gupta <rashmica.g@gmail.com>, clg@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Rashmica Gupta <rashmica.g@gmail.com>
---
 include/hw/arm/aspeed_soc.h |  3 +++
 hw/arm/aspeed_soc.c         | 17 +++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index cef605ad6b..fa04abddd8 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -22,6 +22,7 @@
 #include "hw/ssi/aspeed_smc.h"
 #include "hw/watchdog/wdt_aspeed.h"
 #include "hw/net/ftgmac100.h"
+#include "hw/gpio/aspeed_gpio.h"
 
 #define ASPEED_SPIS_NUM  2
 #define ASPEED_WDTS_NUM  3
@@ -47,6 +48,7 @@ typedef struct AspeedSoCState {
     AspeedSDMCState sdmc;
     AspeedWDTState wdt[ASPEED_WDTS_NUM];
     FTGMAC100State ftgmac100[ASPEED_MACS_NUM];
+    AspeedGPIOState gpio;
 } AspeedSoCState;
 
 #define TYPE_ASPEED_SOC "aspeed-soc"
@@ -60,6 +62,7 @@ typedef struct AspeedSoCInfo {
     int spis_num;
     const char *fmc_typename;
     const char **spi_typename;
+    const char *gpio_typename;
     int wdts_num;
     const int *irqmap;
     const hwaddr *memmap;
diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
index c6fb3700f2..ff422c8ad1 100644
--- a/hw/arm/aspeed_soc.c
+++ b/hw/arm/aspeed_soc.c
@@ -124,6 +124,7 @@ static const AspeedSoCInfo aspeed_socs[] = {
         .spis_num     = 1,
         .fmc_typename = "aspeed.smc.fmc",
         .spi_typename = aspeed_soc_ast2400_typenames,
+        .gpio_typename = "aspeed.gpio-ast2400",
         .wdts_num     = 2,
         .irqmap       = aspeed_soc_ast2400_irqmap,
         .memmap       = aspeed_soc_ast2400_memmap,
@@ -136,6 +137,7 @@ static const AspeedSoCInfo aspeed_socs[] = {
         .spis_num     = 1,
         .fmc_typename = "aspeed.smc.fmc",
         .spi_typename = aspeed_soc_ast2400_typenames,
+        .gpio_typename = "aspeed.gpio-ast2400",
         .wdts_num     = 2,
         .irqmap       = aspeed_soc_ast2400_irqmap,
         .memmap       = aspeed_soc_ast2400_memmap,
@@ -148,6 +150,7 @@ static const AspeedSoCInfo aspeed_socs[] = {
         .spis_num     = 1,
         .fmc_typename = "aspeed.smc.fmc",
         .spi_typename = aspeed_soc_ast2400_typenames,
+        .gpio_typename = "aspeed.gpio-ast2400",
         .wdts_num     = 2,
         .irqmap       = aspeed_soc_ast2400_irqmap,
         .memmap       = aspeed_soc_ast2400_memmap,
@@ -160,6 +163,7 @@ static const AspeedSoCInfo aspeed_socs[] = {
         .spis_num     = 2,
         .fmc_typename = "aspeed.smc.ast2500-fmc",
         .spi_typename = aspeed_soc_ast2500_typenames,
+        .gpio_typename = "aspeed.gpio-ast2500",
         .wdts_num     = 3,
         .irqmap       = aspeed_soc_ast2500_irqmap,
         .memmap       = aspeed_soc_ast2500_memmap,
@@ -246,6 +250,9 @@ static void aspeed_soc_init(Object *obj)
 
     sysbus_init_child_obj(obj, "xdma", OBJECT(&s->xdma), sizeof(s->xdma),
                           TYPE_ASPEED_XDMA);
+
+    sysbus_init_child_obj(obj, "gpio", OBJECT(&s->gpio), sizeof(s->gpio),
+                          sc->info->gpio_typename);
 }
 
 static void aspeed_soc_realize(DeviceState *dev, Error **errp)
@@ -425,6 +432,16 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
                     sc->info->memmap[ASPEED_XDMA]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->xdma), 0,
                        aspeed_soc_get_irq(s, ASPEED_XDMA));
+
+    /* GPIO */
+    object_property_set_bool(OBJECT(&s->gpio), true, "realized", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->gpio), 0, sc->info->memmap[ASPEED_GPIO]);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpio), 0,
+                       aspeed_soc_get_irq(s, ASPEED_GPIO));
 }
 static Property aspeed_soc_properties[] = {
     DEFINE_PROP_UINT32("num-cpus", AspeedSoCState, num_cpus, 0),
-- 
2.20.1



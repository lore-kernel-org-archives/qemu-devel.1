Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 664EBC7618B
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 06:20:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3436020644
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 06:20:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vQ4s/thr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3436020644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hmuLG-0002AR-0K
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 02:20:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42016)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <rashmica.g@gmail.com>) id 1hmuKv-000142-Uf
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 02:19:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <rashmica.g@gmail.com>) id 1hmuKu-00026N-Q6
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 02:19:45 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:33063)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <rashmica.g@gmail.com>)
 id 1hmuKs-00025D-9m; Mon, 15 Jul 2019 02:19:42 -0400
Received: by mail-pg1-x541.google.com with SMTP id m4so7200947pgk.0;
 Sun, 14 Jul 2019 23:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=lBGGTqXH/nhd6kXXGRtBAmp2V+9X81H4xeVXysgM8vc=;
 b=vQ4s/throNEE+NOHhKSbLCa1ZmLiqj6ajqSYL8zMkEHg+jzuNmgdbiitlZ48Na9loJ
 pRytoSlhu+D0UM9ZRypDB7UOwoBYt3OuDuemogDIJkZii/tGsozrT0WX8/2f2VS2Qw2L
 RkeWmDPvk+LDm/j/nLdAVEbBUTaNSPNvhiV0HaX10+Crq01PTmjM6OmRYMM83E2rs6vT
 v7VpWpLy/IdGL3NzI9LsX/y4xmGvViUGa1vHwKbOv44cI55padV8DNS41lZ8hG0A/0cC
 RKRG7BaOG4z/G4nVccGtGTPnns72WRBwfH+R4SYfdaPsBSH9iOJW3HwZEnxgL3v6bf8k
 qhPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lBGGTqXH/nhd6kXXGRtBAmp2V+9X81H4xeVXysgM8vc=;
 b=jkvV2XXGDjiQd8TKlkAXfmSzVajBVmqtefuVFJzprY45pco+zyxpdWfAcOxp8kdz9G
 DghSAFNGsbA59hYSx1WVkkKCx1Ffsw/qn8wRUwGV/NwNxLegPIN5ytLmhY0GQ5Ahu5Sv
 9Jl7G9EoBdAKHpYFGQm0JKbUNXODOkvCacFsDhUo6GLPn2tN+8VElRWirY9vRX5kjIpG
 aM43VGwvsjtVtAhAfKEQ1kGpUG5xJVV7B3nou1zUJqetiLZpNNS4Yhpjirr7YObuXLQa
 2iq1bc0ss7LbEqfO+tGPp9599ITPeUIaLjkJ0O+yxfmK+FhOg2ey/x4UqUEnvL+tGG9E
 jvfw==
X-Gm-Message-State: APjAAAX0YGV4E5oGyL3xHNXWai64NGdyJSJLw1oerSSVOEHW8AYl6xuI
 sSwzG17yxIzsyBMAECBHgDfjarcL
X-Google-Smtp-Source: APXvYqx+QZkN91tsqCZu6jF+CcDn22y+4SeRjI/dH8Z77mfZHgG0rGql+SC6KNVfqZUyjRUODAqmmA==
X-Received: by 2002:a65:458d:: with SMTP id o13mr24881801pgq.34.1563171581229; 
 Sun, 14 Jul 2019 23:19:41 -0700 (PDT)
Received: from rashmica.ozlabs.ibm.com ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id 4sm20020018pfc.92.2019.07.14.23.19.38
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Sun, 14 Jul 2019 23:19:40 -0700 (PDT)
From: Rashmica Gupta <rashmica.g@gmail.com>
To: qemu-arm@nongnu.org
Date: Mon, 15 Jul 2019 16:19:25 +1000
Message-Id: <20190715061925.28030-3-rashmica.g@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190715061925.28030-1-rashmica.g@gmail.com>
References: <20190715061925.28030-1-rashmica.g@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
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
Cc: peter.maydell@linaro.org, andrew@aj.id.au, qemu-devel@nongnu.org,
 clg@kaod.org, Rashmica Gupta <rashmica.g@gmail.com>, joel@jms.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Rashmica Gupta <rashmica.g@gmail.com>
---
 hw/arm/aspeed_soc.c         | 17 +++++++++++++++++
 include/hw/arm/aspeed_soc.h |  3 +++
 2 files changed, 20 insertions(+)

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
-- 
2.20.1



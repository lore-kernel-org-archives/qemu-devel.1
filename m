Return-Path: <SRS0=SLMP=AQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AA9FC433E0
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 21:35:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 570DE20724
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 21:35:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZHND3ZTZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 570DE20724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsCHt-00047y-Jz
	for qemu-devel@archiver.kernel.org; Sun, 05 Jul 2020 17:35:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58764)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jsCGr-0002wu-6p; Sun, 05 Jul 2020 17:33:57 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:42438)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jsCGp-0000IR-Kh; Sun, 05 Jul 2020 17:33:56 -0400
Received: by mail-wr1-x443.google.com with SMTP id o11so38850812wrv.9;
 Sun, 05 Jul 2020 14:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=33+iFZ9fPs6Q3uN1BW9Chm6r7ISJ9rcYdgFFqbQNnug=;
 b=ZHND3ZTZ1LkxtGBkzApka9SpHJNQHioEHb/F4GNcn5mIBiWfoEVdbwaK6+9jbspWoc
 mcOy2XIQTKdFW1H0vixuQdzxDpF+8atJf0RSWGcHwRnuSObmHZ86mhlmBrkzA9AQNSKn
 HdchZPFFwL2GeOmPcjO/fyW1EzHx8vFU9+WEcVS1zy8hFwYJXQTmMZs/4Q2Xy5L2DQv+
 2MDt8WUac01km2ByKATJX7icdtDfCJr47oVi/qjS2bCJ6qegYPLJhw1uOFsBwNlJWqjo
 yL4cBrFWtxXBuldLrYVbstLtxeJ2ZWSgpboP9fDimPUq0nBXrfmGJcdD/KGxyQ2biCiw
 ES9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=33+iFZ9fPs6Q3uN1BW9Chm6r7ISJ9rcYdgFFqbQNnug=;
 b=ei6Sw6GDUKxassgzUevMUMFFv8b6/rXpusk7YoYp8oUyGaC2mQBO0jgTRwkO36DH4Y
 glTXc9ge3v+ue5zQVn4lkJG0Us4kQ4jaG5ETcyG+D77PjzUEiYsXUuZ4s1JcdsGRVAVe
 YN2DnBvw5I++vwDrcTOCmpQGal2U3MG4HvsXaGSYyoaRZr7vIRxY446Oz6ap9hX/JhNn
 d7ltrsM9FipUaxnR9pvKWXR7KMEt/Wke8p5QzgtAvp1RBN0+wkl/J4HrNvGmbArri57o
 sAZ8iPE15IxI4jBoE2dBCDoVEh138E2Ks66K6FdG8sucWalYpxs9DrKraIinNrIlH7SJ
 e+iA==
X-Gm-Message-State: AOAM532bKcnEMRCBpOTAOn4HOx9avNWBmNJf1xFM78rI691pMS7yn4AF
 K7WtGrApjYSPqIWsMCPFkmxQYAgOtfw=
X-Google-Smtp-Source: ABdhPJyxSpBHjrhEj0a0fSKpGCPso3Wnfnw/n4a+1BQfix2yBeOh/EAfhquhj/wvWT1kSyC3NOcHOw==
X-Received: by 2002:a5d:4c8a:: with SMTP id z10mr45072555wrs.384.1593984833606; 
 Sun, 05 Jul 2020 14:33:53 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id y77sm11244453wmd.36.2020.07.05.14.33.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2020 14:33:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] hw/sd/pxa2xx_mmci: Do not create SD card within the SDHCI
 controller
Date: Sun,  5 Jul 2020 23:33:49 +0200
Message-Id: <20200705213350.24725-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200705213350.24725-1-f4bug@amsat.org>
References: <20200705213350.24725-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SDHCI controllers provide a SD Bus to plug SD cards, but don't
come with SD card plugged in :) Let the machine/board object
create and plug the SD cards when required.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/arm/pxa.h |  3 +--
 hw/arm/pxa2xx.c      | 39 +++++++++++++++++++++++++++++----------
 hw/sd/pxa2xx_mmci.c  | 11 ++---------
 3 files changed, 32 insertions(+), 21 deletions(-)

diff --git a/include/hw/arm/pxa.h b/include/hw/arm/pxa.h
index 8843e5f910..d99b6192da 100644
--- a/include/hw/arm/pxa.h
+++ b/include/hw/arm/pxa.h
@@ -89,8 +89,7 @@ void pxa2xx_lcd_vsync_notifier(PXA2xxLCDState *s, qemu_irq handler);
 typedef struct PXA2xxMMCIState PXA2xxMMCIState;
 PXA2xxMMCIState *pxa2xx_mmci_init(MemoryRegion *sysmem,
                 hwaddr base,
-                BlockBackend *blk, qemu_irq irq,
-                qemu_irq rx_dma, qemu_irq tx_dma);
+                qemu_irq irq, qemu_irq rx_dma, qemu_irq tx_dma);
 void pxa2xx_mmci_handlers(PXA2xxMMCIState *s, qemu_irq readonly,
                 qemu_irq coverswitch);
 
diff --git a/hw/arm/pxa2xx.c b/hw/arm/pxa2xx.c
index f104a33463..78f6e69f63 100644
--- a/hw/arm/pxa2xx.c
+++ b/hw/arm/pxa2xx.c
@@ -22,6 +22,7 @@
 #include "hw/irq.h"
 #include "hw/qdev-properties.h"
 #include "hw/ssi/ssi.h"
+#include "hw/sd/sd.h"
 #include "chardev/char-fe.h"
 #include "sysemu/blockdev.h"
 #include "sysemu/qtest.h"
@@ -2135,15 +2136,24 @@ PXA2xxState *pxa270_init(MemoryRegion *address_space,
 
     s->gpio = pxa2xx_gpio_init(0x40e00000, s->cpu, s->pic, 121);
 
-    dinfo = drive_get(IF_SD, 0, 0);
-    if (!dinfo && !qtest_enabled()) {
-        warn_report("missing SecureDigital device");
-    }
     s->mmc = pxa2xx_mmci_init(address_space, 0x41100000,
-                    dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
                     qdev_get_gpio_in(s->pic, PXA2XX_PIC_MMC),
                     qdev_get_gpio_in(s->dma, PXA2XX_RX_RQ_MMCI),
                     qdev_get_gpio_in(s->dma, PXA2XX_TX_RQ_MMCI));
+    dinfo = drive_get(IF_SD, 0, 0);
+    if (dinfo) {
+        DeviceState *carddev;
+
+        /* Create and plug in the sd card */
+        carddev = qdev_new(TYPE_SD_CARD);
+        qdev_prop_set_drive_err(carddev, "drive",
+                                blk_by_legacy_dinfo(dinfo), &error_fatal);
+        qdev_realize_and_unref(carddev, qdev_get_child_bus(DEVICE(s->mmc),
+                                                           "sd-bus"),
+                               &error_fatal);
+    } else if (!qtest_enabled()) {
+        warn_report("missing SecureDigital device");
+    }
 
     for (i = 0; pxa270_serial[i].io_base; i++) {
         if (serial_hd(i)) {
@@ -2259,15 +2269,24 @@ PXA2xxState *pxa255_init(MemoryRegion *address_space, unsigned int sdram_size)
 
     s->gpio = pxa2xx_gpio_init(0x40e00000, s->cpu, s->pic, 85);
 
-    dinfo = drive_get(IF_SD, 0, 0);
-    if (!dinfo && !qtest_enabled()) {
-        warn_report("missing SecureDigital device");
-    }
     s->mmc = pxa2xx_mmci_init(address_space, 0x41100000,
-                    dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
                     qdev_get_gpio_in(s->pic, PXA2XX_PIC_MMC),
                     qdev_get_gpio_in(s->dma, PXA2XX_RX_RQ_MMCI),
                     qdev_get_gpio_in(s->dma, PXA2XX_TX_RQ_MMCI));
+    dinfo = drive_get(IF_SD, 0, 0);
+    if (dinfo) {
+        DeviceState *carddev;
+
+        /* Create and plug in the sd card */
+        carddev = qdev_new(TYPE_SD_CARD);
+        qdev_prop_set_drive_err(carddev, "drive",
+                                blk_by_legacy_dinfo(dinfo), &error_fatal);
+        qdev_realize_and_unref(carddev, qdev_get_child_bus(DEVICE(s->mmc),
+                                                           "sd-bus"),
+                               &error_fatal);
+    } else if (!qtest_enabled()) {
+        warn_report("missing SecureDigital device");
+    }
 
     for (i = 0; pxa255_serial[i].io_base; i++) {
         if (serial_hd(i)) {
diff --git a/hw/sd/pxa2xx_mmci.c b/hw/sd/pxa2xx_mmci.c
index 68bed24480..9482b9212d 100644
--- a/hw/sd/pxa2xx_mmci.c
+++ b/hw/sd/pxa2xx_mmci.c
@@ -476,10 +476,9 @@ static const MemoryRegionOps pxa2xx_mmci_ops = {
 
 PXA2xxMMCIState *pxa2xx_mmci_init(MemoryRegion *sysmem,
                 hwaddr base,
-                BlockBackend *blk, qemu_irq irq,
-                qemu_irq rx_dma, qemu_irq tx_dma)
+                qemu_irq irq, qemu_irq rx_dma, qemu_irq tx_dma)
 {
-    DeviceState *dev, *carddev;
+    DeviceState *dev;
     SysBusDevice *sbd;
     PXA2xxMMCIState *s;
 
@@ -492,12 +491,6 @@ PXA2xxMMCIState *pxa2xx_mmci_init(MemoryRegion *sysmem,
     qdev_connect_gpio_out_named(dev, "tx-dma", 0, tx_dma);
     sysbus_realize_and_unref(sbd, &error_fatal);
 
-    /* Create and plug in the sd card */
-    carddev = qdev_new(TYPE_SD_CARD);
-    qdev_prop_set_drive_err(carddev, "drive", blk, &error_fatal);
-    qdev_realize_and_unref(carddev, qdev_get_child_bus(dev, "sd-bus"),
-                           &error_fatal);
-
     return s;
 }
 
-- 
2.21.3



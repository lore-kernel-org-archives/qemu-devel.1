Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EABE0C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 17:31:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B80AC20FC3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 17:31:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nLfuPzOV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B80AC20FC3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9Asd-0003TD-VE
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 13:31:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57166)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k9Aqz-0000xL-8i; Fri, 21 Aug 2020 13:29:25 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:35410)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k9Aqw-00018v-V6; Fri, 21 Aug 2020 13:29:24 -0400
Received: by mail-wm1-x344.google.com with SMTP id o21so2580076wmc.0;
 Fri, 21 Aug 2020 10:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2+ejMCV40ttJWX503UL/cUbXCRo7C8BOcBLGhpyL8vw=;
 b=nLfuPzOVTS6MAnqX5dE/nlZUfw+0gk4QiabS3aL3+XIVtbPiTXsA1+scnZg8e/A1Fm
 xAyHkZ8q0MPqSA10D/KEU5Fb7WyNIVMN2Panw7mHuyyx7MRTreLXT5xLELPr7eWyLZ5M
 KLMME7JQuv0agJrQJoup8N5y4bxYxRcZ7aczJ/ek6RXe+Ph6dsxIL5W/5UFS/gMJRq4e
 Rxw6HaVwI/OnWQAq/U2SJ8QemdNXt1miwm8TEJbFitNVTdnCaH1S/VAedBtt2A6QDMvl
 SVx7RRxNAu7LqSQfoJ4LlyUCUMehYrFY0Oi0oaiT8cqbogaxioI1cc6HB9OgCQ4c5iy2
 WHzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=2+ejMCV40ttJWX503UL/cUbXCRo7C8BOcBLGhpyL8vw=;
 b=klpxa/Ygdn6zvV62Jl3YXlEBPHk7aqThAk9sU+bljdi8LWNFbKx6GBe3DHTmYmPVdY
 BXLCc/TUBbO46+UK8iQddpv+/rQ/8ba26hcersMVFoCjLmUdRjOk4tL73jwB8QQ79dQH
 2z/npXZkLbY/eCm4LlT2u1mw7eHVUaSoZktsAdOSlCSG1t5P95s0sTrqvxS+U40upBmS
 ikBYw6OtUQUrB+0amqnvLNGtDZZg74Zq8d7g87LnXwMunbsOInkG4OqAtBx+KL02Y9Zs
 HK6zdD6EpSvBZ3iLlXp1nBAFbbmetq/if+LAcvuyLISt85fPWWoDg/nj84hZnDEr+RxY
 +KUg==
X-Gm-Message-State: AOAM533llraQ75q7YrCrcaEMkEtvwXwrRZ2LaqKqhYTizHWJVpYPai6/
 ZTNQLjnUrLUvZG28uLLhyUpjhZzzNWQ=
X-Google-Smtp-Source: ABdhPJxWQpb614HdVOWBL3s5kTfTOepSi/m2iLbGx1N49gpmUt32rXPQO4cV6IxM1x6fT3F4KjeCjA==
X-Received: by 2002:a1c:6243:: with SMTP id w64mr4077941wmb.3.1598030960506;
 Fri, 21 Aug 2020 10:29:20 -0700 (PDT)
Received: from localhost.localdomain (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id 32sm5315471wrn.86.2020.08.21.10.29.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2020 10:29:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/23] hw/sd/pxa2xx_mmci: Do not create SD card within the SD
 host controller
Date: Fri, 21 Aug 2020 19:28:54 +0200
Message-Id: <20200821172916.1260954-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200821172916.1260954-1-f4bug@amsat.org>
References: <20200821172916.1260954-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Beniamino Galvani <b.galvani@gmail.com>, Michael Walle <michael@walle.cc>,
 qemu-arm@nongnu.org, Alistair Francis <alistair.francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SD/MMC host controllers provide a SD Bus to plug SD cards,
but don't come with SD card plugged in :)

The machine/board object is where the SD cards are created.
Since the PXA2xx is not qdevified, for now create the cards
in pxa270_init() which is the SoC model.
In the future we will move this to the board model.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Acked-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20200705213350.24725-2-f4bug@amsat.org>
---
 include/hw/arm/pxa.h |  3 +--
 hw/arm/pxa2xx.c      | 39 +++++++++++++++++++++++++++++----------
 hw/sd/pxa2xx_mmci.c  | 11 ++---------
 3 files changed, 32 insertions(+), 21 deletions(-)

diff --git a/include/hw/arm/pxa.h b/include/hw/arm/pxa.h
index 8843e5f9107..d99b6192daf 100644
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
index 6203c4cfe0b..20fa201dd57 100644
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
@@ -2136,15 +2137,24 @@ PXA2xxState *pxa270_init(MemoryRegion *address_space,
 
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
@@ -2260,15 +2270,24 @@ PXA2xxState *pxa255_init(MemoryRegion *address_space, unsigned int sdram_size)
 
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
index 68bed24480e..9482b9212dd 100644
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
2.26.2



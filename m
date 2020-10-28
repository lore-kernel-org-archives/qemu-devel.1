Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9829C4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 08:25:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 368BD22267
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 08:25:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 368BD22267
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXgm8-00042z-U1
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 04:25:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37416)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kXgkz-0002m5-Ut
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 04:24:33 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167]:51656
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kXgkx-00044s-2b
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 04:24:33 -0400
Received: from host81-158-111-11.range81-158.btcentralplus.com
 ([81.158.111.11] helo=kentang.home)
 by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kXgl0-0006Q8-Oh; Wed, 28 Oct 2020 08:24:39 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Date: Wed, 28 Oct 2020 08:23:49 +0000
Message-Id: <20201028082358.23761-2-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201028082358.23761-1-mark.cave-ayland@ilande.co.uk>
References: <20201028082358.23761-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 81.158.111.11
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 01/10] sparc32-dma: use object_initialize_child() for espdma
 and ledma child objects
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.default.ilande.uk0.bigv.io)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk;
 helo=mail.default.ilande.uk0.bigv.io
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Store the child objects directly within the sparc32-dma object rather than using
link properties.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20200926140216.7368-2-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/dma/sparc32_dma.c           | 15 +++++++++------
 include/hw/sparc/sparc32_dma.h |  4 ++--
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/hw/dma/sparc32_dma.c b/hw/dma/sparc32_dma.c
index d20a5bc065..b25a212f7a 100644
--- a/hw/dma/sparc32_dma.c
+++ b/hw/dma/sparc32_dma.c
@@ -379,10 +379,9 @@ static void sparc32_dma_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    espdma = qdev_new(TYPE_SPARC32_ESPDMA_DEVICE);
+    espdma = DEVICE(&s->espdma);
     object_property_set_link(OBJECT(espdma), "iommu", iommu, &error_abort);
-    object_property_add_child(OBJECT(s), "espdma", OBJECT(espdma));
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(espdma), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(espdma), &error_fatal);
 
     esp = DEVICE(object_resolve_path_component(OBJECT(espdma), "esp"));
     sbd = SYS_BUS_DEVICE(esp);
@@ -394,10 +393,9 @@ static void sparc32_dma_realize(DeviceState *dev, Error **errp)
     memory_region_add_subregion(&s->dmamem, 0x0,
                                 sysbus_mmio_get_region(sbd, 0));
 
-    ledma = qdev_new(TYPE_SPARC32_LEDMA_DEVICE);
+    ledma = DEVICE(&s->ledma);
     object_property_set_link(OBJECT(ledma), "iommu", iommu, &error_abort);
-    object_property_add_child(OBJECT(s), "ledma", OBJECT(ledma));
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(ledma), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(ledma), &error_fatal);
 
     lance = DEVICE(object_resolve_path_component(OBJECT(ledma), "lance"));
     sbd = SYS_BUS_DEVICE(lance);
@@ -421,6 +419,11 @@ static void sparc32_dma_init(Object *obj)
 
     memory_region_init(&s->dmamem, OBJECT(s), "dma", DMA_SIZE + DMA_ETH_SIZE);
     sysbus_init_mmio(sbd, &s->dmamem);
+
+    object_initialize_child(obj, "espdma", &s->espdma,
+                            TYPE_SPARC32_ESPDMA_DEVICE);
+    object_initialize_child(obj, "ledma", &s->ledma,
+                            TYPE_SPARC32_LEDMA_DEVICE);
 }
 
 static void sparc32_dma_class_init(ObjectClass *klass, void *data)
diff --git a/include/hw/sparc/sparc32_dma.h b/include/hw/sparc/sparc32_dma.h
index e650489414..3348a725f0 100644
--- a/include/hw/sparc/sparc32_dma.h
+++ b/include/hw/sparc/sparc32_dma.h
@@ -48,8 +48,8 @@ struct SPARC32DMAState {
 
     MemoryRegion dmamem;
     MemoryRegion ledma_alias;
-    ESPDMADeviceState *espdma;
-    LEDMADeviceState *ledma;
+    ESPDMADeviceState espdma;
+    LEDMADeviceState ledma;
 };
 
 /* sparc32_dma.c */
-- 
2.20.1



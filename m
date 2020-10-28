Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02949C4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 08:29:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C8DE241A5
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 08:29:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C8DE241A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXgq9-0001aI-77
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 04:29:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37476)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kXglC-0003CW-IO
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 04:24:46 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167]:51678
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kXglA-0004BA-QA
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 04:24:46 -0400
Received: from host81-158-111-11.range81-158.btcentralplus.com
 ([81.158.111.11] helo=kentang.home)
 by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kXglF-0006Q8-18; Wed, 28 Oct 2020 08:24:53 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Date: Wed, 28 Oct 2020 08:23:52 +0000
Message-Id: <20201028082358.23761-5-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201028082358.23761-1-mark.cave-ayland@ilande.co.uk>
References: <20201028082358.23761-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 81.158.111.11
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 04/10] sparc32-ledma: don't reference nd_table directly within
 the device
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

Instead use qdev_set_nic_properties() to configure the on-board NIC at the
sun4m machine level.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20200926140216.7368-5-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/dma/sparc32_dma.c |  5 -----
 hw/sparc/sun4m.c     | 21 +++++++++++++--------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/hw/dma/sparc32_dma.c b/hw/dma/sparc32_dma.c
index 2cbe331959..b643b413c5 100644
--- a/hw/dma/sparc32_dma.c
+++ b/hw/dma/sparc32_dma.c
@@ -342,12 +342,7 @@ static void sparc32_ledma_device_realize(DeviceState *dev, Error **errp)
 {
     LEDMADeviceState *s = SPARC32_LEDMA_DEVICE(dev);
     SysBusPCNetState *lance = SYSBUS_PCNET(&s->lance);
-    NICInfo *nd = &nd_table[0];
 
-    /* FIXME use qdev NIC properties instead of nd_table[] */
-    qemu_check_nic_model(nd, TYPE_LANCE);
-
-    qdev_set_nic_properties(DEVICE(lance), nd);
     object_property_set_link(OBJECT(lance), "dma", OBJECT(dev), &error_abort);
     sysbus_realize(SYS_BUS_DEVICE(lance), &error_fatal);
 }
diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index 38d1e0fd12..66fecb152a 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -319,7 +319,7 @@ static void *iommu_init(hwaddr addr, uint32_t version, qemu_irq irq)
 
 static void *sparc32_dma_init(hwaddr dma_base,
                               hwaddr esp_base, qemu_irq espdma_irq,
-                              hwaddr le_base, qemu_irq ledma_irq)
+                              hwaddr le_base, qemu_irq ledma_irq, NICInfo *nd)
 {
     DeviceState *dma;
     ESPDMADeviceState *espdma;
@@ -328,16 +328,11 @@ static void *sparc32_dma_init(hwaddr dma_base,
     SysBusPCNetState *lance;
 
     dma = qdev_new(TYPE_SPARC32_DMA);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dma), &error_fatal);
-    sysbus_mmio_map(SYS_BUS_DEVICE(dma), 0, dma_base);
-
     espdma = SPARC32_ESPDMA_DEVICE(object_resolve_path_component(
                                    OBJECT(dma), "espdma"));
     sysbus_connect_irq(SYS_BUS_DEVICE(espdma), 0, espdma_irq);
 
     esp = ESP(object_resolve_path_component(OBJECT(espdma), "esp"));
-    sysbus_mmio_map(SYS_BUS_DEVICE(esp), 0, esp_base);
-    scsi_bus_legacy_handle_cmdline(&esp->esp.bus);
 
     ledma = SPARC32_LEDMA_DEVICE(object_resolve_path_component(
                                  OBJECT(dma), "ledma"));
@@ -345,6 +340,14 @@ static void *sparc32_dma_init(hwaddr dma_base,
 
     lance = SYSBUS_PCNET(object_resolve_path_component(
                          OBJECT(ledma), "lance"));
+    qdev_set_nic_properties(DEVICE(lance), nd);
+
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dma), &error_fatal);
+    sysbus_mmio_map(SYS_BUS_DEVICE(dma), 0, dma_base);
+
+    sysbus_mmio_map(SYS_BUS_DEVICE(esp), 0, esp_base);
+    scsi_bus_legacy_handle_cmdline(&esp->esp.bus);
+
     sysbus_mmio_map(SYS_BUS_DEVICE(lance), 0, le_base);
 
     return dma;
@@ -850,6 +853,7 @@ static void sun4m_hw_init(const struct sun4m_hwdef *hwdef,
     unsigned int max_cpus = machine->smp.max_cpus;
     Object *ram_memdev = object_resolve_path_type(machine->ram_memdev_id,
                                                   TYPE_MEMORY_BACKEND, NULL);
+    NICInfo *nd = &nd_table[0];
 
     if (machine->ram_size > hwdef->max_mem) {
         error_report("Too much memory for this machine: %" PRId64 ","
@@ -910,9 +914,10 @@ static void sun4m_hw_init(const struct sun4m_hwdef *hwdef,
                         hwdef->iommu_pad_base, hwdef->iommu_pad_len);
     }
 
+    qemu_check_nic_model(nd, TYPE_LANCE);
     sparc32_dma_init(hwdef->dma_base,
                      hwdef->esp_base, slavio_irq[18],
-                     hwdef->le_base, slavio_irq[16]);
+                     hwdef->le_base, slavio_irq[16], nd);
 
     if (graphic_depth != 8 && graphic_depth != 24) {
         error_report("Unsupported depth: %d", graphic_depth);
@@ -1049,7 +1054,7 @@ static void sun4m_hw_init(const struct sun4m_hwdef *hwdef,
                                     machine->initrd_filename,
                                     machine->ram_size, &initrd_size);
 
-    nvram_init(nvram, (uint8_t *)&nd_table[0].macaddr, machine->kernel_cmdline,
+    nvram_init(nvram, (uint8_t *)&nd->macaddr, machine->kernel_cmdline,
                machine->boot_order, machine->ram_size, kernel_size,
                graphic_width, graphic_height, graphic_depth,
                hwdef->nvram_machine_id, "Sun4m");
-- 
2.20.1



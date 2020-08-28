Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93659C433E7
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 09:27:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E25C208CA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 09:27:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZLOUJ1FH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E25C208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBaf8-0000VV-LR
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 05:27:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45848)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBacW-00043w-FO
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 05:24:28 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:36094)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBacU-0004Eo-Eu
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 05:24:28 -0400
Received: by mail-wm1-x333.google.com with SMTP id z9so287152wmk.1
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 02:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=PNlpFAnkNi+iSBT/J3PRzcvZzeHSz8/BRVgPxWnbCC4=;
 b=ZLOUJ1FHaFof3VUj/D3t3svG2GuPDvub7i7F5n9qfJwI6E5RldgJNS7ctMwnwe8773
 Nnfo/1U9wzKmnxmF4eNj+BIysd0Y8ZpDvVOJdUdCLUgVzg2auPxOuW3Q7G1ksbDRTUtn
 4b+0ms972QfEJ/ah97urFaLBJaYxlBO9Pi7N66M9Rj5Swte8XNJ8qnDR+TC+F6yq9ASG
 VBSINx6avduu5pYSeORrDtEE0+oKBXRiJ86/IClD8B0mRlyzXlgEe6AO1NtGPdfftXpM
 dj4jthQzgL6yOQGdKMoNKzhN+W4oZDrVdepmOkOrpJmA8THtlkoOzLwsx/or+o5MfhlZ
 AoHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=PNlpFAnkNi+iSBT/J3PRzcvZzeHSz8/BRVgPxWnbCC4=;
 b=LBbHQ+MeJO1mtxDg6EEWc607Gwo3lsntBZDaoizLt2ju5L1i9SnAhijnyD9zUFoeUO
 7/5aByjW12Dj8OSNJUN3XsknBJN0/aF4bZlW90WHxW0sWp82CODrWdHqihtRF689OBXn
 WGH8Z6Arpnx1k0fNRgz/sJqJe0dH0nyPoTnjJqcUmI+Fio9ksAq6a6GWHdMjSakpvnam
 5ab77wtIfciB4OeJ5V4f6AlCjQzkKeMlJcdXptBJXwJbh1omR64EblZy4C/BxRTDXSF1
 LNrZgYfwxnLMm3Dq7puZB6s68lDKQAZKgAhxtcVczEvI23Ev7GPNMUALWd1IUc9XA+zF
 OSIA==
X-Gm-Message-State: AOAM530tId0fZhyAGNSJXqj5TeDdo+5eIeOhp33W2Ibz7hTIIPUtK/RZ
 vZPhatFWeoNoSeeND05zCwomzLY3e9NEU3Gy
X-Google-Smtp-Source: ABdhPJxoZRFahtIDKNsGxL8dV/+9v63lgbFBcnv0a5bo23FgvZdiCLGHXStqc9NHChw9h6kz46/h6g==
X-Received: by 2002:a7b:c056:: with SMTP id u22mr711818wmc.188.1598606664795; 
 Fri, 28 Aug 2020 02:24:24 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id t13sm912304wru.65.2020.08.28.02.24.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 02:24:24 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/35] hw/sd/allwinner-sdhost: Use AddressSpace for DMA
 transfers
Date: Fri, 28 Aug 2020 10:23:47 +0100
Message-Id: <20200828092413.22206-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200828092413.22206-1-peter.maydell@linaro.org>
References: <20200828092413.22206-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Allow the device to execute the DMA transfers in a different
AddressSpace.

The A10 and H3 SoC keep using the system_memory address space,
but via the proper dma_memory_access() API.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Niek Linnenbank <nieklinnenbank@gmail.com>
Reviewed-by: Niek Linnenbank <nieklinnenbank@gmail.com>
Message-id: 20200814110057.307-1-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/sd/allwinner-sdhost.h |  6 ++++++
 hw/arm/allwinner-a10.c           |  2 ++
 hw/arm/allwinner-h3.c            |  2 ++
 hw/sd/allwinner-sdhost.c         | 37 ++++++++++++++++++++++++++------
 4 files changed, 41 insertions(+), 6 deletions(-)

diff --git a/include/hw/sd/allwinner-sdhost.h b/include/hw/sd/allwinner-sdhost.h
index d94606a8531..839732ebf3b 100644
--- a/include/hw/sd/allwinner-sdhost.h
+++ b/include/hw/sd/allwinner-sdhost.h
@@ -71,6 +71,12 @@ typedef struct AwSdHostState {
     /** Interrupt output signal to notify CPU */
     qemu_irq irq;
 
+    /** Memory region where DMA transfers are done */
+    MemoryRegion *dma_mr;
+
+    /** Address space used internally for DMA transfers */
+    AddressSpace dma_as;
+
     /** Number of bytes left in current DMA transfer */
     uint32_t transfer_cnt;
 
diff --git a/hw/arm/allwinner-a10.c b/hw/arm/allwinner-a10.c
index e2584637478..d404f31e02f 100644
--- a/hw/arm/allwinner-a10.c
+++ b/hw/arm/allwinner-a10.c
@@ -155,6 +155,8 @@ static void aw_a10_realize(DeviceState *dev, Error **errp)
     }
 
     /* SD/MMC */
+    object_property_set_link(OBJECT(&s->mmc0), "dma-memory",
+                             OBJECT(get_system_memory()), &error_fatal);
     sysbus_realize(SYS_BUS_DEVICE(&s->mmc0), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->mmc0), 0, AW_A10_MMC0_BASE);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->mmc0), 0, qdev_get_gpio_in(dev, 32));
diff --git a/hw/arm/allwinner-h3.c b/hw/arm/allwinner-h3.c
index ff92ded82c9..43a8d3dc480 100644
--- a/hw/arm/allwinner-h3.c
+++ b/hw/arm/allwinner-h3.c
@@ -349,6 +349,8 @@ static void allwinner_h3_realize(DeviceState *dev, Error **errp)
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->sid), 0, s->memmap[AW_H3_SID]);
 
     /* SD/MMC */
+    object_property_set_link(OBJECT(&s->mmc0), "dma-memory",
+                             OBJECT(get_system_memory()), &error_fatal);
     sysbus_realize(SYS_BUS_DEVICE(&s->mmc0), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->mmc0), 0, s->memmap[AW_H3_MMC0]);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->mmc0), 0,
diff --git a/hw/sd/allwinner-sdhost.c b/hw/sd/allwinner-sdhost.c
index f9eb92c09ed..e82afb75eb6 100644
--- a/hw/sd/allwinner-sdhost.c
+++ b/hw/sd/allwinner-sdhost.c
@@ -21,7 +21,10 @@
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "qemu/units.h"
+#include "qapi/error.h"
 #include "sysemu/blockdev.h"
+#include "sysemu/dma.h"
+#include "hw/qdev-properties.h"
 #include "hw/irq.h"
 #include "hw/sd/allwinner-sdhost.h"
 #include "migration/vmstate.h"
@@ -306,7 +309,7 @@ static uint32_t allwinner_sdhost_process_desc(AwSdHostState *s,
     uint8_t buf[1024];
 
     /* Read descriptor */
-    cpu_physical_memory_read(desc_addr, desc, sizeof(*desc));
+    dma_memory_read(&s->dma_as, desc_addr, desc, sizeof(*desc));
     if (desc->size == 0) {
         desc->size = klass->max_desc_size;
     } else if (desc->size > klass->max_desc_size) {
@@ -331,22 +334,24 @@ static uint32_t allwinner_sdhost_process_desc(AwSdHostState *s,
 
         /* Write to SD bus */
         if (is_write) {
-            cpu_physical_memory_read((desc->addr & DESC_SIZE_MASK) + num_done,
-                                      buf, buf_bytes);
+            dma_memory_read(&s->dma_as,
+                            (desc->addr & DESC_SIZE_MASK) + num_done,
+                            buf, buf_bytes);
             sdbus_write_data(&s->sdbus, buf, buf_bytes);
 
         /* Read from SD bus */
         } else {
             sdbus_read_data(&s->sdbus, buf, buf_bytes);
-            cpu_physical_memory_write((desc->addr & DESC_SIZE_MASK) + num_done,
-                                       buf, buf_bytes);
+            dma_memory_write(&s->dma_as,
+                             (desc->addr & DESC_SIZE_MASK) + num_done,
+                             buf, buf_bytes);
         }
         num_done += buf_bytes;
     }
 
     /* Clear hold flag and flush descriptor */
     desc->status &= ~DESC_STATUS_HOLD;
-    cpu_physical_memory_write(desc_addr, desc, sizeof(*desc));
+    dma_memory_write(&s->dma_as, desc_addr, desc, sizeof(*desc));
 
     return num_done;
 }
@@ -721,6 +726,12 @@ static const VMStateDescription vmstate_allwinner_sdhost = {
     }
 };
 
+static Property allwinner_sdhost_properties[] = {
+    DEFINE_PROP_LINK("dma-memory", AwSdHostState, dma_mr,
+                     TYPE_MEMORY_REGION, MemoryRegion *),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 static void allwinner_sdhost_init(Object *obj)
 {
     AwSdHostState *s = AW_SDHOST(obj);
@@ -734,6 +745,18 @@ static void allwinner_sdhost_init(Object *obj)
     sysbus_init_irq(SYS_BUS_DEVICE(s), &s->irq);
 }
 
+static void allwinner_sdhost_realize(DeviceState *dev, Error **errp)
+{
+    AwSdHostState *s = AW_SDHOST(dev);
+
+    if (!s->dma_mr) {
+        error_setg(errp, TYPE_AW_SDHOST " 'dma-memory' link not set");
+        return;
+    }
+
+    address_space_init(&s->dma_as, s->dma_mr, "sdhost-dma");
+}
+
 static void allwinner_sdhost_reset(DeviceState *dev)
 {
     AwSdHostState *s = AW_SDHOST(dev);
@@ -792,6 +815,8 @@ static void allwinner_sdhost_class_init(ObjectClass *klass, void *data)
 
     dc->reset = allwinner_sdhost_reset;
     dc->vmsd = &vmstate_allwinner_sdhost;
+    dc->realize = allwinner_sdhost_realize;
+    device_class_set_props(dc, allwinner_sdhost_properties);
 }
 
 static void allwinner_sdhost_sun4i_class_init(ObjectClass *klass, void *data)
-- 
2.20.1



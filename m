Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14516C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 11:03:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8C66206DA
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 11:03:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tn2+V+ND"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8C66206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6XV2-00058Q-T5
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 07:03:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43382)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k6XSK-0003FU-Kd; Fri, 14 Aug 2020 07:01:04 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:46081)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k6XSI-0000Jl-On; Fri, 14 Aug 2020 07:01:04 -0400
Received: by mail-wr1-x441.google.com with SMTP id f12so7946451wru.13;
 Fri, 14 Aug 2020 04:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=82YNUrJPpt+U6i+zsZg8jmPLYqtlltwueOh8XQCPKmQ=;
 b=tn2+V+NDZXCdbxZd3abu7KYFmH185KGG64CmAOqicWcSP9nMEp1Kr/TFIWuFXI2bNt
 hBV7pzS6tppiq+DopWSVbhOFkqT8m71DiscJ57l1OTvaxj7vM7IB3v76CF9pCyA2yFZo
 lxNPA76U3q2q1kOqP5Vy5P2jIM6cqL8pHKkzZ+TYGLI7iizfWltI9okePXw2tfG4bPHu
 gbhFA7VIIhMUlghHiiYd1k7BcDKeHK0tSMBM/SyCR7MB1JnwKqhobOrp0X21r9WhlNN7
 WmKIUi+RyqvDVRhheCQCmT2nkgtsW1FoJIaR/51qT6Ae4L0HrnwqnEDGn4oZtFnaqi4E
 +8mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=82YNUrJPpt+U6i+zsZg8jmPLYqtlltwueOh8XQCPKmQ=;
 b=Au6F5u3sLEmUPAIBU9Om3KVPETeZAKPyVteZ1T+8BdVD3xuadw6hplhrFYT6HW0mpm
 eXK3vk3UcinT549kvytOqtRGhNXYyCEpRj2U1sZCjU4NSAO42SdNSBLyZZJ2ONJDUmFm
 7xof3TXQpQ5XO3J9grPxaU38xP1soaco9N+vmUPsd3Vi5/eiwwXwrhQEg5sAInQu9lbs
 lgNv+jKyDAy8GgloXIubuqnoG1yVpYpkBxwtWItaSVL/X8FdXUnoZGvxW+NSpPKHXM0r
 UqwCw+d+UXiokDc4kwiUuermLC3g0x7cnr9v3CZKnLhBc1f8YbMb7Q0+5FqJlLST6sR3
 /dlw==
X-Gm-Message-State: AOAM533OHPefskSkn8VW3tWUS5LvaRloWdUqzHCqCo40Hvql4HIpRajh
 Iy0ZVUKkygmDSKDghnRpfb6LHBMWmK4=
X-Google-Smtp-Source: ABdhPJxfpFcuQ60gfxGquCy/VJIbQhooomzFHUveCUuTlDTVfaI9KICbzfLCYeRmsboDtnW3p1+i5g==
X-Received: by 2002:adf:df08:: with SMTP id y8mr2406269wrl.152.1597402859848; 
 Fri, 14 Aug 2020 04:00:59 -0700 (PDT)
Received: from localhost.localdomain (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id 128sm14154986wmz.43.2020.08.14.04.00.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2020 04:00:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] hw/sd/allwinner-sdhost: Use AddressSpace for DMA transfers
Date: Fri, 14 Aug 2020 13:00:57 +0200
Message-Id: <20200814110057.307-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Beniamino Galvani <b.galvani@gmail.com>, Michael Walle <michael@walle.cc>,
 qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Allow the device to execute the DMA transfers in a different
AddressSpace.

The A10 and H3 SoC keep using the system_memory address space,
but via the proper dma_memory_access() API.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
Based-on: <20200814092346.21825-1-f4bug@amsat.org>
"hw/sd: Use sdbus_read_data/sdbus_write_data for multiple bytes access"

Tested with:
  AVOCADO_ALLOW_LARGE_STORAGE=1 avocado run -t machine:orangepi-pc -t machine:cubieboard tests/acceptance/
---
 include/hw/sd/allwinner-sdhost.h |  6 ++++++
 hw/arm/allwinner-a10.c           |  2 ++
 hw/arm/allwinner-h3.c            |  2 ++
 hw/sd/allwinner-sdhost.c         | 37 ++++++++++++++++++++++++++------
 4 files changed, 41 insertions(+), 6 deletions(-)

diff --git a/include/hw/sd/allwinner-sdhost.h b/include/hw/sd/allwinner-sdhost.h
index d94606a853..839732ebf3 100644
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
index e258463747..d404f31e02 100644
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
index ff92ded82c..43a8d3dc48 100644
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
index f9eb92c09e..e82afb75eb 100644
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
2.21.3



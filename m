Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15576CA9EB3
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 23:07:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1CC12089C
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 23:07:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BplDj5SS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1CC12089C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLErD-0001pC-Pq
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 19:06:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41130)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iLEiu-0000kl-Qm
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 18:58:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iLEis-0002RI-MW
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 18:58:24 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:36669)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iLEis-0002Qh-Eo; Thu, 17 Oct 2019 18:58:22 -0400
Received: by mail-wr1-x442.google.com with SMTP id w18so3573721wrt.3;
 Thu, 17 Oct 2019 15:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qV4TP2j98+fYZFc2JMpmFae2oOSeawDZWNXGLNyTYjo=;
 b=BplDj5SSrP2fBJXD05CrW1W6kinP7ywFSeP/c5DEh/Kke0uOK/v8iUsSx4X3jlJnM+
 wqy1c7doGeKgsmU0o5HPpJeCqA7DDqw1Lik+dm6nOuHL7mFPAE3HQ0eqIfigdbt0LXRH
 YAH/xVHmCUzU/+BHG1148XwjqpmKDoigbO+lEjWkHAa48G6CME1/B76oX5FxhBLLzFXg
 GaiZGqFSBeB07MhnJB99MKNSjLhyRUuXY1G1BJzr/JupzppEt5zd1JhO91EGbFMU8vyr
 vzaByrCHwNZgqmvkuJ6c+u0Vp2S1HOf8h9ifsHhPrEx862maT6S9lu73L24r/eOXCsMA
 eydQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=qV4TP2j98+fYZFc2JMpmFae2oOSeawDZWNXGLNyTYjo=;
 b=bFH/w+aoj2UnQolkFhYW7bO/l0Oo8ZyP0VuWljrQORe1oIjrrFxbM3EaM4Da0GjEXV
 Rjhb3DaizobzkE/tGYV/ogKP52SZftJ0X/CoJ4lWf/XEftwdNbZPszDtHH1Y+AqGFeBo
 YUlq8jNqSQOFG2OSlFcDzdQ1Svt+m//FOsx7rhOUDauPyn2oBamXt++MixpZohQAbjZ3
 p+SAYUwQ8c9wNDjDyzWbqanL3n84wf/YPIuJq5QPmQTfhF8p6J5S/5oCf28YybgQlSd5
 zStXHvPRtY1WwGhcIF9IxLchZ7jBtyvBrW/TJyqGAq/b0uKR4vrP8aSa4YzOcDpONzKn
 9R5w==
X-Gm-Message-State: APjAAAWyPOTTdAOIxtIC7EYaltBx7G5mPCjXhTtDNq4Kgq5OGwsd8bpg
 jIWFbFvdwxUMPuaNhOAabvcTZxZE
X-Google-Smtp-Source: APXvYqzzj9+NRnLd8RJdWJZkN6YCuofgEN5bsM1XWAIxMMv3v/VQ9HMmcAQnP1bAGN32130y7rFMXg==
X-Received: by 2002:adf:f1d1:: with SMTP id z17mr4776449wro.198.1571353100901; 
 Thu, 17 Oct 2019 15:58:20 -0700 (PDT)
Received: from localhost.localdomain (14.red-88-21-201.staticip.rima-tde.net.
 [88.21.201.14])
 by smtp.gmail.com with ESMTPSA id m18sm3993873wrg.97.2019.10.17.15.58.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2019 15:58:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 06/10] hw/arm/bcm2836: Create VideoCore address space in
 the SoC
Date: Fri, 18 Oct 2019 00:57:56 +0200
Message-Id: <20191017225800.6946-7-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191017225800.6946-1-f4bug@amsat.org>
References: <20191017225800.6946-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: Rob Herring <robh@kernel.org>, Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, Pekka Enberg <penberg@iki.fi>,
 Esteban Bosse <estebanbosse@gmail.com>, qemu-arm@nongnu.org,
 Pete Batard <pete@akeo.ie>, Cleber Rosa <crosa@redhat.com>,
 Laurent Bonnans <laurent.bonnans@here.com>,
 Cheng Xiang <ext-cheng.xiang@here.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Clement Deschamps <clement.deschamps@antfield.fr>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently the VideoCore is created in the Peripheral container
as the 'GPU bus'. It is created there because the peripherals
using DMA use physical addresses from the VideoCore bus.
However the VideoCore is a GPU core placed at the same
hierarchical level than the ARM cores.

To match the datasheet design, create the VideoCore container
in the SoC, and link it to the peripheral container.

The VideoCore bus is 1GiB wide, accessible at 4 regions in
different cache configurations. Add the full mapping.

Before this commit the memory tree is:

  (qemu) info mtree
  address-space: bcm2835-dma-memory
    0000000000000000-00000000ffffffff (prio 0, i/o): bcm2835-gpu
      0000000000000000-000000003fffffff (prio 0, i/o): alias bcm2835-gpu-ram-alias[*] @ram 0000000000000000-000000003fffffff
      0000000040000000-000000007fffffff (prio 0, i/o): alias bcm2835-gpu-ram-alias[*] @ram 0000000000000000-000000003fffffff
      000000007e000000-000000007effffff (prio 1, i/o): alias bcm2835-peripherals @bcm2835-peripherals 0000000000000000-0000000000ffffff
      0000000080000000-00000000bfffffff (prio 0, i/o): alias bcm2835-gpu-ram-alias[*] @ram 0000000000000000-000000003fffffff
      00000000c0000000-00000000ffffffff (prio 0, i/o): alias bcm2835-gpu-ram-alias[*] @ram 0000000000000000-000000003fffffff

After:

  address-space: bcm2835-dma-memory
    0000000000000000-000000003fffffff (prio 0, i/o): videocore-bus
      0000000000000000-000000003fffffff (prio 1, i/o): alias vc-ram-alias @ram 0000000000000000-000000003fffffff
      000000003e000000-000000003effffff (prio 2, i/o): alias vc-peripherals-alias @bcm2835-peripherals 0000000000000000-0000000000ffffff
      0000000040000000-000000007fffffff (prio 0, i/o): alias cached-coherent @videocore-bus 0000000000000000-000000003fffffff
      0000000080000000-00000000bfffffff (prio 0, i/o): alias cached @videocore-bus 0000000000000000-000000003fffffff
      00000000c0000000-00000000ffffffff (prio 0, i/o): alias uncached @videocore-bus 0000000000000000-000000003fffffff

Now the periferals are accessible from the uncached region too.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/bcm2835_peripherals.c         | 45 +++++++++-------------------
 hw/arm/bcm2836.c                     | 43 ++++++++++++++++++++++++--
 include/hw/arm/bcm2835_peripherals.h |  4 +--
 include/hw/arm/bcm2836.h             |  5 ++++
 4 files changed, 62 insertions(+), 35 deletions(-)

diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
index 17207ae07e..059e44a620 100644
--- a/hw/arm/bcm2835_peripherals.c
+++ b/hw/arm/bcm2835_peripherals.c
@@ -9,6 +9,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
 #include "hw/arm/bcm2835_peripherals.h"
@@ -16,9 +17,6 @@
 #include "hw/arm/raspi_platform.h"
 #include "sysemu/sysemu.h"
 
-/* Peripheral base address on the VC (GPU) system bus */
-#define BCM2835_VC_PERI_BASE 0x7e000000
-
 /* Capabilities for SD controller: no DMA, high-speed, default clocks etc. */
 #define BCM2835_SDHC_CAPAREG 0x52134b4
 
@@ -45,10 +43,6 @@ static void bcm2835_peripherals_init(Object *obj)
     object_property_add_child(obj, "peripheral-io", OBJECT(&s->peri_mr), NULL);
     sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->peri_mr);
 
-    /* Internal memory region for peripheral bus addresses (not exported) */
-    memory_region_init(&s->gpu_bus_mr, obj, "bcm2835-gpu", (uint64_t)1 << 32);
-    object_property_add_child(obj, "gpu-bus", OBJECT(&s->gpu_bus_mr), NULL);
-
     /* Internal memory region for request/response communication with
      * mailbox-addressable peripherals (not exported)
      */
@@ -82,9 +76,6 @@ static void bcm2835_peripherals_init(Object *obj)
     object_property_add_alias(obj, "vcram-size", OBJECT(&s->fb), "vcram-size",
                               &error_abort);
 
-    object_property_add_const_link(OBJECT(&s->fb), "dma-mr",
-                                   OBJECT(&s->gpu_bus_mr), &error_abort);
-
     /* Property channel */
     sysbus_init_child_obj(obj, "property", &s->property, sizeof(s->property),
                           TYPE_BCM2835_PROPERTY);
@@ -93,8 +84,6 @@ static void bcm2835_peripherals_init(Object *obj)
 
     object_property_add_const_link(OBJECT(&s->property), "fb",
                                    OBJECT(&s->fb), &error_abort);
-    object_property_add_const_link(OBJECT(&s->property), "dma-mr",
-                                   OBJECT(&s->gpu_bus_mr), &error_abort);
 
     /* Random Number Generator */
     sysbus_init_child_obj(obj, "rng", &s->rng, sizeof(s->rng),
@@ -112,9 +101,6 @@ static void bcm2835_peripherals_init(Object *obj)
     sysbus_init_child_obj(obj, "dma", &s->dma, sizeof(s->dma),
                           TYPE_BCM2835_DMA);
 
-    object_property_add_const_link(OBJECT(&s->dma), "dma-mr",
-                                   OBJECT(&s->gpu_bus_mr), &error_abort);
-
     /* Thermal */
     sysbus_init_child_obj(obj, "thermal", &s->thermal, sizeof(s->thermal),
                           TYPE_BCM2835_THERMAL);
@@ -133,7 +119,7 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
 {
     BCM2835PeripheralState *s = BCM2835_PERIPHERALS(dev);
     Object *obj;
-    MemoryRegion *ram;
+    MemoryRegion *ram, *vc;
     Error *err = NULL;
     uint64_t ram_size, vcram_size;
     int n;
@@ -144,25 +130,16 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
                    __func__, error_get_pretty(err));
         return;
     }
-
     ram = MEMORY_REGION(obj);
     ram_size = memory_region_size(ram);
 
-    /* Map peripherals and RAM into the GPU address space. */
-    memory_region_init_alias(&s->peri_mr_alias, OBJECT(s),
-                             "bcm2835-peripherals", &s->peri_mr, 0,
-                             memory_region_size(&s->peri_mr));
-
-    memory_region_add_subregion_overlap(&s->gpu_bus_mr, BCM2835_VC_PERI_BASE,
-                                        &s->peri_mr_alias, 1);
-
-    /* RAM is aliased four times (different cache configurations) on the GPU */
-    for (n = 0; n < 4; n++) {
-        memory_region_init_alias(&s->ram_alias[n], OBJECT(s),
-                                 "bcm2835-gpu-ram-alias[*]", ram, 0, ram_size);
-        memory_region_add_subregion_overlap(&s->gpu_bus_mr, (hwaddr)n << 30,
-                                            &s->ram_alias[n], 0);
+    obj = object_property_get_link(OBJECT(dev), "videocore", &err);
+    if (obj == NULL) {
+        error_setg(errp, "%s: required videocore link not found: %s",
+                   __func__, error_get_pretty(err));
+        return;
     }
+    vc = MEMORY_REGION(obj);
 
     /* Interrupt Controller */
     object_property_set_bool(OBJECT(&s->ic), true, "realized", &err);
@@ -243,6 +220,8 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    object_property_add_const_link(OBJECT(&s->fb), "dma-mr",
+                                   OBJECT(vc), &error_abort);
     object_property_set_bool(OBJECT(&s->fb), true, "realized", &err);
     if (err) {
         error_propagate(errp, err);
@@ -255,6 +234,8 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
                        qdev_get_gpio_in(DEVICE(&s->mboxes), MBOX_CHAN_FB));
 
     /* Property channel */
+    object_property_add_const_link(OBJECT(&s->property), "dma-mr",
+                                   OBJECT(vc), &error_abort);
     object_property_set_bool(OBJECT(&s->property), true, "realized", &err);
     if (err) {
         error_propagate(errp, err);
@@ -323,6 +304,8 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
                                INTERRUPT_SDIO));
 
     /* DMA Channels */
+    object_property_add_const_link(OBJECT(&s->dma), "dma-mr",
+                                   OBJECT(vc), &error_abort);
     object_property_set_bool(OBJECT(&s->dma), true, "realized", &err);
     if (err) {
         error_propagate(errp, err);
diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
index 019e67b906..d712f36052 100644
--- a/hw/arm/bcm2836.c
+++ b/hw/arm/bcm2836.c
@@ -9,6 +9,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
 #include "cpu.h"
@@ -16,6 +17,9 @@
 #include "hw/arm/raspi_platform.h"
 #include "hw/sysbus.h"
 
+/* Peripheral base address on the VC (GPU) system bus */
+#define BCM2835_VC_PERI_BASE    0x3e000000
+
 struct BCM283XInfo {
     const char *name;
     const char *cpu_type;
@@ -50,6 +54,21 @@ static void bcm2836_init(Object *obj)
     const BCM283XInfo *info = bc->info;
     int n;
 
+    /* VideoCore memory region */
+    memory_region_init(&s->videocore.mr[0], obj, "videocore-bus", 1 * GiB);
+    object_property_add_child(obj, "videocore",
+                              OBJECT(&s->videocore.mr[0]), NULL);
+    for (n = 1; n < BCM283X_NCPUS; n++) {
+        static const char *alias_name[] = {
+            NULL, "cached-coherent", "cached", "uncached"
+        };
+        memory_region_init_alias(&s->videocore.mr[n], obj,
+                                 alias_name[n], &s->videocore.mr[0],
+                                 0, 1 * GiB);
+        memory_region_add_subregion_overlap(&s->videocore.mr[0], n * GiB,
+                                            &s->videocore.mr[n], 0);
+    }
+
     for (n = 0; n < BCM283X_NCPUS; n++) {
         object_initialize_child(obj, "cpu[*]", &s->cpus[n], sizeof(s->cpus[n]),
                                 info->cpu_type, &error_abort, NULL);
@@ -71,6 +90,7 @@ static void bcm2836_realize(DeviceState *dev, Error **errp)
     BCM283XState *s = BCM283X(dev);
     BCM283XClass *bc = BCM283X_GET_CLASS(dev);
     const BCM283XInfo *info = bc->info;
+    MemoryRegion *ram_mr, *peri_mr;
     Object *obj;
     Error *err = NULL;
     int n;
@@ -83,26 +103,45 @@ static void bcm2836_realize(DeviceState *dev, Error **errp)
                    __func__, error_get_pretty(err));
         return;
     }
-
+    ram_mr = MEMORY_REGION(obj);
     object_property_add_const_link(OBJECT(&s->peripherals), "ram", obj, &err);
     if (err) {
         error_propagate(errp, err);
         return;
     }
 
+    object_property_add_const_link(OBJECT(&s->peripherals), "videocore",
+                                   OBJECT(&s->videocore), &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
     object_property_set_bool(OBJECT(&s->peripherals), true, "realized", &err);
     if (err) {
         error_propagate(errp, err);
         return;
     }
 
+    /* Map peripherals and RAM into the GPU address space. */
+    memory_region_init_alias(&s->videocore.ram_mr_alias, OBJECT(s),
+                             "vc-ram-alias", ram_mr, 0,
+                             memory_region_size(ram_mr));
+    memory_region_add_subregion_overlap(&s->videocore.mr[0], 0,
+                                        &s->videocore.ram_mr_alias, 1);
+    peri_mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->peripherals), 0);
+    memory_region_init_alias(&s->videocore.peri_mr_alias, OBJECT(s),
+                             "vc-peripherals-alias",
+                             peri_mr, 0, 16 * MiB);
+    memory_region_add_subregion_overlap(&s->videocore.mr[0],
+                                        BCM2835_VC_PERI_BASE,
+                                        &s->videocore.peri_mr_alias, 2);
+
     object_property_add_alias(OBJECT(s), "sd-bus", OBJECT(&s->peripherals),
                               "sd-bus", &err);
     if (err) {
         error_propagate(errp, err);
         return;
     }
-
     sysbus_mmio_map_overlap(SYS_BUS_DEVICE(&s->peripherals), 0,
                             info->peri_base, 1);
 
diff --git a/include/hw/arm/bcm2835_peripherals.h b/include/hw/arm/bcm2835_peripherals.h
index 7859281e11..f485f20aae 100644
--- a/include/hw/arm/bcm2835_peripherals.h
+++ b/include/hw/arm/bcm2835_peripherals.h
@@ -36,8 +36,8 @@ typedef struct BCM2835PeripheralState {
     SysBusDevice parent_obj;
     /*< public >*/
 
-    MemoryRegion peri_mr, peri_mr_alias, gpu_bus_mr, mbox_mr;
-    MemoryRegion ram_alias[4];
+    MemoryRegion peri_mr;
+    MemoryRegion mbox_mr;
     qemu_irq irq, fiq;
 
     BCM2835SystemTimerState systmr;
diff --git a/include/hw/arm/bcm2836.h b/include/hw/arm/bcm2836.h
index 97187f72be..a26bf895a4 100644
--- a/include/hw/arm/bcm2836.h
+++ b/include/hw/arm/bcm2836.h
@@ -35,6 +35,11 @@ typedef struct BCM283XState {
     char *cpu_type;
     uint32_t enabled_cpus;
 
+    struct {
+        MemoryRegion mr[4];
+        MemoryRegion peri_mr_alias;
+        MemoryRegion ram_mr_alias;
+    } videocore;
     ARMCPU cpus[BCM283X_NCPUS];
     BCM2836ControlState control;
     BCM2835PeripheralState peripherals;
-- 
2.21.0



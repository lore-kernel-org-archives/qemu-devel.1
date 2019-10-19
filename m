Return-Path: <SRS0=F+Q9=YM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCEDCCA9EAC
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 23:55:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74FC020678
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 23:55:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y/ucdF6+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74FC020678
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLyZD-0002HB-35
	for qemu-devel@archiver.kernel.org; Sat, 19 Oct 2019 19:55:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34603)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iLyRc-0000L9-Um
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 19:47:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iLyRb-0005bu-9P
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 19:47:36 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:54735)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iLyRb-0005bT-2s; Sat, 19 Oct 2019 19:47:35 -0400
Received: by mail-wm1-x344.google.com with SMTP id p7so9571458wmp.4;
 Sat, 19 Oct 2019 16:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=hzx2Z74qGFZSNpjuH9vOZR/ojrt91Hb2qK0YE066IUA=;
 b=Y/ucdF6+qGousf4AIhsskoRpKkJYMA27c3fnwTLNX7M6LpBoWOMvMakyouDmgiVd96
 DAJuC4OY5Y0YQlyO7AxRLtF/3/lGO5FHQFTz78oSeqq2XnSMMMY9hL+kG2jWKUxITpPE
 39IRbchR2vMbsvlLv0v2nO9mXFxFcHMfunjT9MZ1SaGBaLUpH8ch+kYnoUSxfxuFRAcL
 hgJVZrrbazlZdt+tK64BhnYyh9Fwuqil1JzCbZA1/FXBhFzdmtkSaznPzzLU58kHUmeK
 DsQdFIcLWS0eCwc5/qXsAS0Hm+dMAJUosG+Hw03dqa71W78MOcKoY7xcrTEsGVjmT11S
 O3Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=hzx2Z74qGFZSNpjuH9vOZR/ojrt91Hb2qK0YE066IUA=;
 b=DO01LkkBPbGuJKdUbKqWA2fWTCotXEPhNyjYTR4r3JRGP2pqOJvkxf8Z1R2gp05p8V
 1yzdwSVBNsDrNohhfH3PC7FRVvCQdr7LYmSObYc92W7ezXklcmFDDEL1GF7nLSNWk3PD
 1vS5UaubC4DZOa/O6I0IneSus4/7M8inh1RnU3mUF56y96PMFEMh31TL44zIcm7NUk/2
 qMOd8dVWsCL50LURDhAyHg2PFVUn6B7Pv47fgk0wlJfUQR7KaklfeUW86pyYoSpj1pOR
 rQfhmfmMv0f+RxINbnWq4Fc6kp3bMvF6f97whAriwRVPsJrA5zdRk+23+bOx/mczXrWS
 E/fg==
X-Gm-Message-State: APjAAAWPJPOqXVL5o/g09AbI2QM2gT9LHYPeZwCNHZH6XgRFFBicxYpY
 RrXMZqgrv36ypl/04qMkxQWv5xZF
X-Google-Smtp-Source: APXvYqwh90RX58ttTpJRcyt40w6Qt8HzyUzCbLKwZ4kTfmxPneV9ScNXcdjxrx30GOTfPhiws2C0ZQ==
X-Received: by 2002:a1c:1d48:: with SMTP id d69mr1046207wmd.160.1571528853837; 
 Sat, 19 Oct 2019 16:47:33 -0700 (PDT)
Received: from x1w.redhat.com (14.red-88-21-201.staticip.rima-tde.net.
 [88.21.201.14])
 by smtp.gmail.com with ESMTPSA id u1sm10433763wrp.56.2019.10.19.16.47.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Oct 2019 16:47:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 09/16] hw/arm/bcm2836: Create VideoCore address space in
 the SoC
Date: Sun, 20 Oct 2019 01:47:08 +0200
Message-Id: <20191019234715.25750-10-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191019234715.25750-1-f4bug@amsat.org>
References: <20191019234715.25750-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
 Matthias Brugger <mbrugger@suse.com>, Rob Herring <robh@kernel.org>,
 Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Esteban Bosse <estebanbosse@gmail.com>, "Emilio G . Cota" <cota@braap.org>,
 Clement Deschamps <clement.deschamps@antfield.fr>, qemu-arm@nongnu.org,
 Cleber Rosa <crosa@redhat.com>, Laurent Bonnans <laurent.bonnans@here.com>,
 Cheng Xiang <ext-cheng.xiang@here.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Pekka Enberg <penberg@iki.fi>, Pete Batard <pete@akeo.ie>
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
    0000000000000000-00000000ffffffff (prio 0, i/o): gpu-bus
      0000000000000000-000000003fffffff (prio 0, i/o): alias l1-l2-cached @videocore 0000000000000000-000000003fffffff
      0000000040000000-000000007fffffff (prio 0, i/o): alias l2-cached-coherent @videocore 0000000000000000-000000003fffffff
      0000000080000000-00000000bfffffff (prio 0, i/o): alias l2-cached @videocore 0000000000000000-000000003fffffff
      00000000c0000000-00000000ffffffff (prio 0, i/o): alias direct-uncached @videocore 0000000000000000-000000003fffffff

  memory-region: videocore
    0000000000000000-000000003fffffff (prio 0, i/o): videocore
      0000000000000000-000000003fffffff (prio 0, i/o): alias vc-ram @ram 0000000000000000-000000003fffffff
      000000003e000000-000000003effffff (prio 1, i/o): alias vc-peripherals @bcm2835-peripherals 0000000000000000-0000000000ffffff

Now the periferals are accessible from the uncached region too.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/bcm2835_peripherals.c         | 25 +++++-------------
 hw/arm/bcm2836.c                     | 38 ++++++++++++++++++++++++++++
 include/hw/arm/bcm2835_peripherals.h |  4 +--
 include/hw/arm/bcm2836.h             |  7 +++++
 4 files changed, 53 insertions(+), 21 deletions(-)

diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
index d51e9c8def..5da310efb1 100644
--- a/hw/arm/bcm2835_peripherals.c
+++ b/hw/arm/bcm2835_peripherals.c
@@ -9,6 +9,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
 #include "hw/arm/bcm2835_peripherals.h"
@@ -45,10 +46,6 @@ static void bcm2835_peripherals_init(Object *obj)
     object_property_add_child(obj, "peripheral-io", OBJECT(&s->peri_mr), NULL);
     sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->peri_mr);
 
-    /* Internal memory region for peripheral bus addresses (not exported) */
-    memory_region_init(&s->gpu_bus_mr, obj, "bcm2835-gpu", (uint64_t)1 << 32);
-    object_property_add_child(obj, "gpu-bus", OBJECT(&s->gpu_bus_mr), NULL);
-
     /* Internal memory region for request/response communication with
      * mailbox-addressable peripherals (not exported)
      */
@@ -140,21 +137,11 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
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
-    obj = OBJECT(&s->gpu_bus_mr);
-    /* RAM is aliased four times (different cache configurations) on the GPU */
-    for (n = 0; n < 4; n++) {
-        memory_region_init_alias(&s->ram_alias[n], OBJECT(s),
-                                 "bcm2835-gpu-ram-alias[*]", ram, 0, ram_size);
-        memory_region_add_subregion_overlap(&s->gpu_bus_mr, (hwaddr)n << 30,
-                                            &s->ram_alias[n], 0);
+    obj = object_property_get_link(OBJECT(dev), "videocore-bus", &err);
+    if (obj == NULL) {
+        error_setg(errp, "%s: required videocore-bus link not found: %s",
+                   __func__, error_get_pretty(err));
+        return;
     }
 
     /* Interrupt Controller */
diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
index 374a44b38c..ada35e5620 100644
--- a/hw/arm/bcm2836.c
+++ b/hw/arm/bcm2836.c
@@ -51,6 +51,14 @@ static void bcm2836_init(Object *obj)
     const BCM283XInfo *info = bc->info;
     int n;
 
+    /* VideoCore memory region */
+    memory_region_init(&s->vc.gpu, obj, "videocore", 1 * GiB);
+    object_property_add_child(obj, "videocore", OBJECT(&s->vc.gpu), NULL);
+
+    /* Internal memory region for peripheral bus addresses (not exported) */
+    memory_region_init(&s->vc.bus, obj, "gpu-bus", 4 * GiB);
+    object_property_add_child(obj, "gpu-bus", OBJECT(&s->vc.bus), NULL);
+
     for (n = 0; n < BCM283X_NCPUS; n++) {
         memory_region_init(&s->cpu[n].container, obj, "cpu-bus", 4 * GiB);
 
@@ -97,6 +105,12 @@ static void bcm2836_realize(DeviceState *dev, Error **errp)
         error_propagate(errp, err);
         return;
     }
+    object_property_add_const_link(OBJECT(&s->peripherals), "videocore-bus",
+                                   OBJECT(&s->vc.bus), &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
     object_property_set_bool(OBJECT(&s->peripherals), true, "realized", &err);
     if (err) {
         error_propagate(errp, err);
@@ -112,6 +126,30 @@ static void bcm2836_realize(DeviceState *dev, Error **errp)
 
     peri_mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->peripherals), 0);
 
+    /* Map peripherals and RAM into the GPU address space. */
+    memory_region_init_alias(&s->vc.peri_alias, OBJECT(s),
+                             "vc-peripherals", peri_mr, 0,
+                             memory_region_size(peri_mr));
+    memory_region_add_subregion_overlap(&s->vc.gpu, 0x3e000000,
+                                        &s->vc.peri_alias, 1);
+    memory_region_init_alias(&s->vc.ram_alias, OBJECT(s),
+                             "vc-ram", ram_mr, 0, ram_size);
+    memory_region_add_subregion(&s->vc.gpu, 0,
+                                &s->vc.ram_alias);
+    static const char * const bus_alias_name[] = {
+        "l1-l2-cached",
+        "l2-cached-coherent",
+        "l2-cached",
+        "direct-uncached"
+    };
+    /* Alias different cache configurations on the GPU */
+    for (n = 0; n < ARRAY_SIZE(bus_alias_name); n++) {
+        memory_region_init_alias(&s->vc.gpu_alias[n], OBJECT(s),
+                                 bus_alias_name[n], &s->vc.gpu, 0, 1 * GiB);
+        memory_region_add_subregion(&s->vc.bus, n * GiB,
+                                    &s->vc.gpu_alias[n]);
+    }
+
     /* bcm2836 interrupt controller (and mailboxes, etc.) */
     object_property_set_bool(OBJECT(&s->control), true, "realized", &err);
     if (err) {
diff --git a/include/hw/arm/bcm2835_peripherals.h b/include/hw/arm/bcm2835_peripherals.h
index 7859281e11..fb6d84ec50 100644
--- a/include/hw/arm/bcm2835_peripherals.h
+++ b/include/hw/arm/bcm2835_peripherals.h
@@ -36,8 +36,8 @@ typedef struct BCM2835PeripheralState {
     SysBusDevice parent_obj;
     /*< public >*/
 
-    MemoryRegion peri_mr, peri_mr_alias, gpu_bus_mr, mbox_mr;
-    MemoryRegion ram_alias[4];
+    MemoryRegion peri_mr, mbox_mr;
+
     qemu_irq irq, fiq;
 
     BCM2835SystemTimerState systmr;
diff --git a/include/hw/arm/bcm2836.h b/include/hw/arm/bcm2836.h
index e3498cb861..787ab76738 100644
--- a/include/hw/arm/bcm2836.h
+++ b/include/hw/arm/bcm2836.h
@@ -35,6 +35,13 @@ typedef struct BCM283XState {
     char *cpu_type;
     uint32_t enabled_cpus;
 
+    struct {
+        MemoryRegion bus;
+        MemoryRegion gpu;
+        MemoryRegion peri_alias;
+        MemoryRegion ram_alias;
+        MemoryRegion gpu_alias[4];
+    } vc;
     struct {
         ARMCPU core;
         MemoryRegion container;
-- 
2.21.0



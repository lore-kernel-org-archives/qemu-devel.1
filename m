Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F44EC433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 15:27:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 374C2207C3
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 15:27:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 374C2207C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=efs-auto.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jig9t-000343-Dr
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 11:27:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36276)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david.brenken@efs-auto.org>)
 id 1jig8u-0002Bc-Cx
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 11:26:24 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:42507)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david.brenken@efs-auto.org>)
 id 1jig8s-0004sH-Hc
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 11:26:24 -0400
Received: from localhost.localdomain ([178.239.76.114]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1M4sD3-1jgkzq0583-001y50; Tue, 09 Jun 2020 17:26:13 +0200
From: David Brenken <david.brenken@efs-auto.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/1] tricore: added triboard with tc27x_soc
Date: Tue,  9 Jun 2020 17:25:53 +0200
Message-Id: <20200609152553.4376-2-david.brenken@efs-auto.org>
X-Mailer: git-send-email 2.16.1.windows.4
In-Reply-To: <20200609152553.4376-1-david.brenken@efs-auto.org>
References: <20200609152553.4376-1-david.brenken@efs-auto.org>
X-Provags-ID: V03:K1:MNDeGczYYLc5wX50/6ZM7eruj+S2EXURS1r+iLYAuhhLUUeCL7U
 1lZ2M087l3NwHA+54JBKjo5ldPYBmCxfRse3te0sPHJrRH3HmnYorAB6ztYdYV/iM9YwVk1
 9/RnZ0t8T4rWPBn1iGknI8yY9Z8VXH0jO+ATImiYC9BJBRVfijNCiAreVD7RmGlrQnOcE6n
 YSg9WnUW4Wxz80fC++lNg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4zQDbLwxjUw=:125kRE98fpuQEFFxuuGXfX
 LGQhqfPcfv7ZN7GapRnJUEr6+iOCRPGEAQ51QGqR/lucwrMVGqH/Qrddz/Tk2E8vUkruuHWv1
 J5A0dN2yR1ypwWTJEojySQ2FhgCKAYL0YQhehliXiPSEVQGRLNKPkqpG9b41gtg1mgZqp0P30
 CPTTpovSySC7uyES8ScoOSSnnGzNa6kp/wxhQIyRgsrFqzzYbZQ02TBZzuzu/gIJqItUOcL0m
 b0yiMca4fjx8zvkbMZk4dNunVv/x7ojuvCpBYlz7UgqvBqMVsUFe3D4FYCj+ApGfjsBkcMsZO
 Em1ssE1ZeDW+OJVHjyPV+04LruZDADTM2kPHp/EKJrDzncmXAfVvJEAxZNn+Hyib5nZMsoCLA
 sAB0FIarV98/K0WtECtL9BHvo/yrhBedcLHGHY00NNJbpsLvT2kPlpcTrmWXMA1K9KGolFkdO
 txiqkkIzEi+XNnL+tD2vnOAUCiSguU5BXt8UKSvw0y3n91lwNz9WU5PvDQeQLVpqDeNH52s/m
 QGVIM8QF82UkbKJQocNS+ljjlGOFh0WH3o2jtJ0k3QCx54nKCTuQHqRAPHFJ6UKgmiSmGRoZ3
 cHRxv/0E8MHSGnFdMrLm4eqQ0VCpupe+IvPvXb5iti16ND3YpQma4h5uy9IqLqregwiOEJcs7
 yDAU3AFNqYa+xQr5/2Vth6rQaLXzWp9vQWX816hW9vfzIecLKsHXtruQ1+o/T0rNz58gaMluM
 MT8JjJVdHOVa8SQwh9ryyVZkSDEteDEQDmshZ+BVkRaJrzaGJjLe/BMQ9c5qhKZDVGJy6aoHh
 Cw53LVrwiwaBE7HBYzadHNzf9VndsJCRr52Nzn4I1pxeyc4WldtPU0Fls2DI5PauiBZHK/E
Received-SPF: none client-ip=212.227.17.10;
 envelope-from=david.brenken@efs-auto.org; helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 11:26:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: kbastian@mail.uni-paderborn.de,
 Lars Biermanski <lars.biermanski@efs-auto.de>,
 Georg Hofstetter <georg.hofstetter@efs-auto.de>,
 David Brenken <david.brenken@efs-auto.de>,
 Robert Rasche <robert.rasche@efs-auto.de>,
 Andreas Konopik <andreas.konopik@efs-auto.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Andreas Konopik <andreas.konopik@efs-auto.de>

Signed-off-by: Andreas Konopik <andreas.konopik@efs-auto.de>
Signed-off-by: David Brenken <david.brenken@efs-auto.de>
Signed-off-by: Georg Hofstetter <georg.hofstetter@efs-auto.de>
Signed-off-by: Robert Rasche <robert.rasche@efs-auto.de>
Signed-off-by: Lars Biermanski <lars.biermanski@efs-auto.de>
---
 hw/tricore/Kconfig             |   8 ++
 hw/tricore/Makefile.objs       |   2 +
 hw/tricore/tc27x_soc.c         | 252 +++++++++++++++++++++++++++++++++
 hw/tricore/triboard.c          | 104 ++++++++++++++
 include/hw/tricore/tc27x_soc.h | 135 ++++++++++++++++++
 include/hw/tricore/triboard.h  |  53 +++++++
 6 files changed, 554 insertions(+)
 create mode 100644 hw/tricore/tc27x_soc.c
 create mode 100644 hw/tricore/triboard.c
 create mode 100644 include/hw/tricore/tc27x_soc.h
 create mode 100644 include/hw/tricore/triboard.h

diff --git a/hw/tricore/Kconfig b/hw/tricore/Kconfig
index 9313409309..44d3e906a1 100644
--- a/hw/tricore/Kconfig
+++ b/hw/tricore/Kconfig
@@ -1,2 +1,10 @@
 config TRICORE
     bool
+    select TRIBOARD
+
+config TRIBOARD
+    bool
+    select TC27X_SOC
+
+config TC27X_SOC
+    bool
diff --git a/hw/tricore/Makefile.objs b/hw/tricore/Makefile.objs
index 5501f6c1a8..91bcef4402 100644
--- a/hw/tricore/Makefile.objs
+++ b/hw/tricore/Makefile.objs
@@ -1 +1,3 @@
 obj-$(CONFIG_TRICORE) += tricore_testboard.o
+obj-$(CONFIG_TRIBOARD) += triboard.o
+obj-$(CONFIG_TC27X_SOC) += tc27x_soc.o
diff --git a/hw/tricore/tc27x_soc.c b/hw/tricore/tc27x_soc.c
new file mode 100644
index 0000000000..8ec38b26f2
--- /dev/null
+++ b/hw/tricore/tc27x_soc.c
@@ -0,0 +1,252 @@
+/*
+ * Infineon tc27x SoC System emulation.
+ *
+ * Copyright (c) 2020 Andreas Konopik <andreas.konopik@efs-auto.de>
+ * Copyright (c) 2020 David Brenken <david.brenken@efs-auto.de>
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qemu/units.h"
+#include "hw/sysbus.h"
+#include "hw/boards.h"
+#include "hw/loader.h"
+#include "hw/misc/unimp.h"
+#include "exec/address-spaces.h"
+#include "qemu/log.h"
+#include "cpu.h"
+
+#include "hw/tricore/tc27x_soc.h"
+#include "hw/tricore/triboard.h"
+
+static const int tc27x_soc_irqmap[] = {
+};
+
+static const hwaddr tc27x_soc_memmap[] = {
+    [TC27XD_DSPR2]     = 0x50000000,
+    [TC27XD_DCACHE2]   = 0x5001E000,
+    [TC27XD_DTAG2]     = 0x500C0000,
+    [TC27XD_PSPR2]     = 0x50100000,
+    [TC27XD_PCACHE2]   = 0x50108000,
+    [TC27XD_PTAG2]     = 0x501C0000,
+    [TC27XD_DSPR1]     = 0x60000000,
+    [TC27XD_DCACHE1]   = 0x6001E000,
+    [TC27XD_DTAG1]     = 0x600C0000,
+    [TC27XD_PSPR1]     = 0x60100000,
+    [TC27XD_PCACHE1]   = 0x60108000,
+    [TC27XD_PTAG1]     = 0x601C0000,
+    [TC27XD_DSPR0]     = 0x70000000,
+    [TC27XD_PSPR0]     = 0x70100000,
+    [TC27XD_PCACHE0]   = 0x70106000,
+    [TC27XD_PTAG0]     = 0x701C0000,
+    [TC27XD_PFLASH0_C] = 0x80000000,
+    [TC27XD_PFLASH1_C] = 0x80200000,
+    [TC27XD_OLDA_C]    = 0x8FE70000,
+    [TC27XD_BROM_C]    = 0x8FFF8000,
+    [TC27XD_LMURAM_C]  = 0x90000000,
+    [TC27XD_EMEM_C]    = 0x9F000000,
+    [TC27XD_PFLASH0_U] = 0xA0000000,
+    [TC27XD_PFLASH1_U] = 0xA0200000,
+    [TC27XD_DFLASH0]   = 0xAF000000,
+    [TC27XD_DFLASH1]   = 0xAF110000,
+    [TC27XD_OLDA_U]    = 0xAFE70000,
+    [TC27XD_BROM_U]    = 0xAFFF8000,
+    [TC27XD_LMURAM_U]  = 0xB0000000,
+    [TC27XD_EMEM_U]    = 0xBF000000,
+    [TC27XD_PSPRX]     = 0xC0000000,
+    [TC27XD_DSPRX]     = 0xD0000000,
+};
+
+/*
+ * Initialize the auxiliary ROM region @mr and map it into
+ * the memory map at @base.
+ */
+static void make_rom(MemoryRegion *mr, const char *name,
+                     hwaddr base, hwaddr size)
+{
+    memory_region_init_rom(mr, NULL, name, size, &error_fatal);
+    memory_region_add_subregion(get_system_memory(), base, mr);
+}
+
+/*
+ * Initialize the auxiliary RAM region @mr and map it into
+ * the memory map at @base.
+ */
+static void make_ram(MemoryRegion *mr, const char *name,
+                     hwaddr base, hwaddr size)
+{
+    memory_region_init_ram(mr, NULL, name, size, &error_fatal);
+    memory_region_add_subregion(get_system_memory(), base, mr);
+}
+
+/*
+ * Create an alias of an entire original MemoryRegion @orig
+ * located at @base in the memory map.
+ */
+static void make_alias(MemoryRegion *mr, const char *name,
+                           MemoryRegion *orig, hwaddr base)
+{
+    memory_region_init_alias(mr, NULL, name, orig, 0,
+                             memory_region_size(orig));
+    memory_region_add_subregion(get_system_memory(), base, mr);
+}
+
+static void tc27x_soc_init_memory_mapping(Object *obj)
+{
+    TC27XSoCState *s = TC27X_SOC(obj);
+    TC27XSoCClass *sc = TC27X_SOC_GET_CLASS(s);
+
+    make_ram(&s->cpu0mem.dspr, "CPU0.DSPR",
+            sc->memmap[TC27XD_DSPR0], 112 * KiB);
+    make_ram(&s->cpu0mem.pspr, "CPU0.PSPR",
+            sc->memmap[TC27XD_PSPR0], 24 * KiB);
+    make_ram(&s->cpu1mem.dspr, "CPU1.DSPR",
+            sc->memmap[TC27XD_DSPR1], 120 * KiB);
+    make_ram(&s->cpu1mem.pspr, "CPU1.PSPR",
+            sc->memmap[TC27XD_PSPR1], 32 * KiB);
+    make_ram(&s->cpu2mem.dspr, "CPU2.DSPR",
+            sc->memmap[TC27XD_DSPR2], 120 * KiB);
+    make_ram(&s->cpu2mem.pspr, "CPU2.PSPR",
+            sc->memmap[TC27XD_PSPR2], 32 * KiB);
+
+    /* TODO: Control Cache mapping with Memory Test Unit (MTU) */
+    make_ram(&s->cpu2mem.dcache, "CPU2.DCACHE",
+            sc->memmap[TC27XD_DCACHE2], 8 * KiB);
+    make_ram(&s->cpu2mem.dtag,   "CPU2.DTAG",
+            sc->memmap[TC27XD_DTAG2],  2560);
+    make_ram(&s->cpu2mem.pcache, "CPU2.PCACHE",
+            sc->memmap[TC27XD_PCACHE2], 16 * KiB);
+    make_ram(&s->cpu2mem.ptag,   "CPU2.PTAG",
+            sc->memmap[TC27XD_PTAG2],  6144);
+
+    make_ram(&s->cpu1mem.dcache, "CPU1.DCACHE",
+            sc->memmap[TC27XD_DCACHE1], 8 * KiB);
+    make_ram(&s->cpu1mem.dtag,   "CPU1.DTAG",
+            sc->memmap[TC27XD_DTAG1],  2560);
+    make_ram(&s->cpu1mem.pcache, "CPU1.PCACHE",
+            sc->memmap[TC27XD_PCACHE1], 16 * KiB);
+    make_ram(&s->cpu1mem.ptag,   "CPU1.PTAG",
+            sc->memmap[TC27XD_PTAG1],  6144);
+
+    make_ram(&s->cpu0mem.pcache, "CPU0.PCACHE",
+            sc->memmap[TC27XD_PCACHE0], 8 * KiB);
+    make_ram(&s->cpu0mem.ptag,   "CPU0.PTAG",
+            sc->memmap[TC27XD_PTAG0],  2560);
+
+    /*
+     * TriCore QEMU executes CPU0 only, thus it is sufficient to map
+     * LOCAL.PSPR/LOCAL.DSPR exclusively onto PSPR0/DSPR0.
+     */
+    make_alias(&s->psprX, "LOCAL.PSPR", &s->cpu0mem.pspr,
+            sc->memmap[TC27XD_PSPRX]);
+    make_alias(&s->dsprX, "LOCAL.DSPR", &s->cpu0mem.dspr,
+            sc->memmap[TC27XD_DSPRX]);
+
+    make_ram(&s->flashmem.pflash0_c, "PF0",
+            sc->memmap[TC27XD_PFLASH0_C], 2 * MiB);
+    make_ram(&s->flashmem.pflash1_c, "PF1",
+            sc->memmap[TC27XD_PFLASH1_C], 2 * MiB);
+    make_ram(&s->flashmem.dflash0,   "DF0",
+            sc->memmap[TC27XD_DFLASH0],  1 * MiB + 16 * KiB);
+    make_ram(&s->flashmem.dflash1,   "DF1",
+            sc->memmap[TC27XD_DFLASH1],  64 * KiB);
+    make_ram(&s->flashmem.olda_c,    "OLDA",
+            sc->memmap[TC27XD_OLDA_C],   32 * KiB);
+    make_rom(&s->flashmem.brom_c,    "BROM",
+            sc->memmap[TC27XD_BROM_C],   32 * KiB);
+    make_ram(&s->flashmem.lmuram_c,  "LMURAM",
+            sc->memmap[TC27XD_LMURAM_C], 32 * KiB);
+    make_ram(&s->flashmem.emem_c,    "EMEM",
+            sc->memmap[TC27XD_EMEM_C],   1 * MiB);
+
+    make_alias(&s->flashmem.pflash0_u, "PF0.U",    &s->flashmem.pflash0_c,
+            sc->memmap[TC27XD_PFLASH0_U]);
+    make_alias(&s->flashmem.pflash1_u, "PF1.U",    &s->flashmem.pflash1_c,
+            sc->memmap[TC27XD_PFLASH1_U]);
+    make_alias(&s->flashmem.olda_u,    "OLDA.U",   &s->flashmem.olda_c,
+            sc->memmap[TC27XD_OLDA_U]);
+    make_alias(&s->flashmem.brom_u,    "BROM.U",   &s->flashmem.brom_c,
+            sc->memmap[TC27XD_BROM_U]);
+    make_alias(&s->flashmem.lmuram_u,  "LMURAM.U", &s->flashmem.lmuram_c,
+            sc->memmap[TC27XD_LMURAM_U]);
+    make_alias(&s->flashmem.emem_u,    "EMEM.U",   &s->flashmem.emem_c,
+            sc->memmap[TC27XD_EMEM_U]);
+}
+
+static void tc27x_soc_realize(DeviceState *dev_soc, Error **errp)
+{
+    TC27XSoCState *s = TC27X_SOC(dev_soc);
+    Error *err = NULL;
+
+    object_property_set_bool(OBJECT(&s->cpu), true, "realized", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+}
+
+static void tc27x_soc_init(Object *obj)
+{
+    TC27XSoCState *s = TC27X_SOC(obj);
+    TC27XSoCClass *sc = TC27X_SOC_GET_CLASS(s);
+
+    sysbus_init_child_obj(OBJECT(s), "tc27x", OBJECT(&s->cpu), sizeof(s->cpu),
+                        sc->cpu_type);
+
+    tc27x_soc_init_memory_mapping(obj);
+}
+
+static Property tc27x_soc_properties[] = {
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void tc27x_soc_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = tc27x_soc_realize;
+    device_class_set_props(dc, tc27x_soc_properties);
+}
+
+static void tc277d_soc_class_init(ObjectClass *oc, void *data)
+{
+    TC27XSoCClass *sc = TC27X_SOC_CLASS(oc);
+
+    sc->name         = TYPE_TC277D_SOC;
+    sc->cpu_type     = TRICORE_CPU_TYPE_NAME("tc27x");
+    sc->irqmap       = tc27x_soc_irqmap;
+    sc->memmap       = tc27x_soc_memmap;
+    sc->num_cpus     = 1;
+}
+
+static const TypeInfo tc27x_soc_types[] = {
+    {
+        .name           = TYPE_TC277D_SOC,
+        .parent         = TYPE_TC27X_SOC,
+        .instance_init  = tc27x_soc_init,
+        .instance_size  = sizeof(TC27XSoCState),
+        .class_init     = tc277d_soc_class_init,
+    }, {
+        .name          = TYPE_TC27X_SOC,
+        .parent        = TYPE_DEVICE,
+        .instance_size = sizeof(TC27XSoCState),
+        .class_size    = sizeof(TC27XSoCClass),
+        .class_init    = tc27x_soc_class_init,
+        .abstract      = true,
+    },
+};
+
+DEFINE_TYPES(tc27x_soc_types)
diff --git a/hw/tricore/triboard.c b/hw/tricore/triboard.c
new file mode 100644
index 0000000000..37bbf0a12e
--- /dev/null
+++ b/hw/tricore/triboard.c
@@ -0,0 +1,104 @@
+/*
+ * Infineon TriBoard System emulation.
+ *
+ * Copyright (c) 2020 Andreas Konopik <andreas.konopik@efs-auto.de>
+ * Copyright (c) 2020 David Brenken <david.brenken@efs-auto.de>
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/units.h"
+#include "qapi/error.h"
+#include "hw/qdev-properties.h"
+#include "cpu.h"
+#include "net/net.h"
+#include "hw/boards.h"
+#include "hw/loader.h"
+#include "exec/address-spaces.h"
+#include "elf.h"
+#include "hw/tricore/tricore.h"
+#include "qemu/error-report.h"
+
+#include "hw/tricore/triboard.h"
+#include "hw/tricore/tc27x_soc.h"
+
+static void tricore_load_kernel(const char *kernel_filename)
+{
+    uint64_t entry;
+    long kernel_size;
+    TriCoreCPU *cpu;
+    CPUTriCoreState *env;
+
+    kernel_size = load_elf(kernel_filename, NULL,
+                           NULL, NULL, &entry, NULL,
+                           NULL, NULL, 0,
+                           EM_TRICORE, 1, 0);
+    if (kernel_size <= 0) {
+        error_report("no kernel file '%s'", kernel_filename);
+        exit(1);
+    }
+    cpu = TRICORE_CPU(first_cpu);
+    env = &cpu->env;
+    env->PC = entry;
+}
+
+
+static void triboard_machine_init(MachineState *machine)
+{
+    TriBoardMachineState *ms = TRIBOARD_MACHINE(machine);
+    TriBoardMachineClass *amc = TRIBOARD_MACHINE_GET_CLASS(machine);
+
+    Object *soc = OBJECT(&ms->tc27x_soc);
+
+    object_initialize_child(OBJECT(machine), "soc", &ms->tc27x_soc,
+            sizeof(ms->tc27x_soc), amc->soc_name, &error_abort, NULL);
+    object_property_set_bool(soc, true, "realized", &error_fatal);
+
+    tricore_load_kernel(machine->kernel_filename);
+}
+
+static void triboard_machine_class_init(ObjectClass *oc, void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+
+    mc->init = triboard_machine_init;
+    mc->max_cpus = 1;
+}
+
+static void triboard_machine_tc277d_class_init(ObjectClass *oc,
+        void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+    TriBoardMachineClass *amc = TRIBOARD_MACHINE_CLASS(oc);
+
+    mc->desc        = "Infineon AURIX TriBoard TC277 (D-Step)";
+    amc->soc_name   = TYPE_TC277D_SOC;
+};
+
+static const TypeInfo triboard_machine_types[] = {
+    {
+        .name           = MACHINE_TYPE_NAME("KIT_AURIX_TC277_TRB"),
+        .parent         = TYPE_TRIBOARD_MACHINE,
+        .class_init     = triboard_machine_tc277d_class_init,
+    }, {
+        .name           = TYPE_TRIBOARD_MACHINE,
+        .parent         = TYPE_MACHINE,
+        .instance_size  = sizeof(TriBoardMachineState),
+        .class_init     = triboard_machine_class_init,
+        .abstract        = true,
+    },
+};
+
+DEFINE_TYPES(triboard_machine_types)
diff --git a/include/hw/tricore/tc27x_soc.h b/include/hw/tricore/tc27x_soc.h
new file mode 100644
index 0000000000..937f7fad19
--- /dev/null
+++ b/include/hw/tricore/tc27x_soc.h
@@ -0,0 +1,135 @@
+/*
+ * Infineon tc27x SoC System emulation.
+ *
+ * Copyright (c) 2020 Andreas Konopik <andreas.konopik@efs-auto.de>
+ * Copyright (c) 2020 David Brenken <david.brenken@efs-auto.de>
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef TC27X_SoC_H
+#define TC27X_SoC_H
+
+#include "hw/sysbus.h"
+#include "cpu.h"
+
+#define TYPE_TC27X_SOC "tc27x-soc"
+#define TC27X_SOC(obj) \
+    OBJECT_CHECK(TC27XSoCState, (obj), TYPE_TC27X_SOC)
+
+
+#define TYPE_TC277D_SOC "tc277d-soc"
+#define TC277D_SOC(obj) \
+    OBJECT_CHECK(TC27XSoCState, (obj), TYPE_TC277D_SOC)
+
+typedef struct TC27XSoCCPUMemState {
+
+    MemoryRegion dspr;
+    MemoryRegion pspr;
+
+    MemoryRegion dcache;
+    MemoryRegion dtag;
+    MemoryRegion pcache;
+    MemoryRegion ptag;
+
+} TC27XSoCCPUMemState;
+
+typedef struct TC27XSoCFlashMemState {
+
+    MemoryRegion pflash0_c;
+    MemoryRegion pflash1_c;
+    MemoryRegion pflash0_u;
+    MemoryRegion pflash1_u;
+    MemoryRegion dflash0;
+    MemoryRegion dflash1;
+    MemoryRegion olda_c;
+    MemoryRegion olda_u;
+    MemoryRegion brom_c;
+    MemoryRegion brom_u;
+    MemoryRegion lmuram_c;
+    MemoryRegion lmuram_u;
+    MemoryRegion emem_c;
+    MemoryRegion emem_u;
+
+} TC27XSoCFlashMemState;
+
+typedef struct TC27XSoCState {
+    /*< private >*/
+    SysBusDevice parent_obj;
+
+    /*< public >*/
+    TriCoreCPU cpu;
+
+    MemoryRegion dsprX;
+    MemoryRegion psprX;
+
+    TC27XSoCCPUMemState cpu0mem;
+    TC27XSoCCPUMemState cpu1mem;
+    TC27XSoCCPUMemState cpu2mem;
+
+    TC27XSoCFlashMemState flashmem;
+
+} TC27XSoCState;
+
+typedef struct TC27XSoCClass {
+    DeviceClass parent_class;
+
+    const char *name;
+    const char *cpu_type;
+    const int *irqmap;
+    const hwaddr *memmap;
+    uint32_t num_cpus;
+} TC27XSoCClass;
+
+#define TC27X_SOC_CLASS(klass)                                         \
+    OBJECT_CLASS_CHECK(TC27XSoCClass, (klass), TYPE_TC27X_SOC)
+#define TC27X_SOC_GET_CLASS(obj)                               \
+    OBJECT_GET_CLASS(TC27XSoCClass, (obj), TYPE_TC27X_SOC)
+
+enum {
+    TC27XD_DSPR2,
+    TC27XD_DCACHE2,
+    TC27XD_DTAG2,
+    TC27XD_PSPR2,
+    TC27XD_PCACHE2,
+    TC27XD_PTAG2,
+    TC27XD_DSPR1,
+    TC27XD_DCACHE1,
+    TC27XD_DTAG1,
+    TC27XD_PSPR1,
+    TC27XD_PCACHE1,
+    TC27XD_PTAG1,
+    TC27XD_DSPR0,
+    TC27XD_PSPR0,
+    TC27XD_PCACHE0,
+    TC27XD_PTAG0,
+    TC27XD_PFLASH0_C,
+    TC27XD_PFLASH1_C,
+    TC27XD_OLDA_C,
+    TC27XD_BROM_C,
+    TC27XD_LMURAM_C,
+    TC27XD_EMEM_C,
+    TC27XD_PFLASH0_U,
+    TC27XD_PFLASH1_U,
+    TC27XD_DFLASH0,
+    TC27XD_DFLASH1,
+    TC27XD_OLDA_U,
+    TC27XD_BROM_U,
+    TC27XD_LMURAM_U,
+    TC27XD_EMEM_U,
+    TC27XD_PSPRX,
+    TC27XD_DSPRX,
+};
+
+#endif
diff --git a/include/hw/tricore/triboard.h b/include/hw/tricore/triboard.h
new file mode 100644
index 0000000000..b6d2cc2bd6
--- /dev/null
+++ b/include/hw/tricore/triboard.h
@@ -0,0 +1,53 @@
+/*
+ * Infineon TriBoard System emulation.
+ *
+ * Copyright (c) 2020 Andreas Konopik <andreas.konopik@efs-auto.de>
+ * Copyright (c) 2020 David Brenken <david.brenken@efs-auto.de>
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "hw/boards.h"
+#include "hw/arm/boot.h"
+#include "sysemu/sysemu.h"
+#include "exec/address-spaces.h"
+
+#include "hw/tricore/tc27x_soc.h"
+
+#define TYPE_TRIBOARD_MACHINE MACHINE_TYPE_NAME("triboard")
+#define TRIBOARD_MACHINE(obj) \
+    OBJECT_CHECK(TriBoardMachineState, obj, TYPE_TRIBOARD_MACHINE)
+
+typedef struct {
+    MachineState parent;
+
+    TC27XSoCState tc27x_soc;
+} TriBoardMachineState;
+
+#define TRIBOARD_MACHINE_CLASS(klass) \
+     OBJECT_CLASS_CHECK(TriBoardMachineClass, (klass), \
+             TYPE_TRIBOARD_MACHINE)
+#define TRIBOARD_MACHINE_GET_CLASS(obj) \
+     OBJECT_GET_CLASS(TriBoardMachineClass, (obj), \
+             TYPE_TRIBOARD_MACHINE)
+
+typedef struct {
+    MachineClass parent_obj;
+
+    const char *name;
+    const char *desc;
+    const char *soc_name;
+} TriBoardMachineClass;
-- 
2.27.0



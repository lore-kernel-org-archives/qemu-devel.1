Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 047FAC31E5B
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 17:37:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6A5C20863
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 17:37:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6A5C20863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60600 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdI38-0002nk-03
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 13:37:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33019)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <clg@kaod.org>) id 1hdHOu-0001ci-D3
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 12:56:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1hdHOl-0006X6-SV
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 12:55:59 -0400
Received: from 16.mo6.mail-out.ovh.net ([87.98.139.208]:49080)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1hdHOf-0006KL-AP
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 12:55:51 -0400
Received: from player157.ha.ovh.net (unknown [10.109.160.5])
 by mo6.mail-out.ovh.net (Postfix) with ESMTP id 3E3871D0D00
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2019 18:55:46 +0200 (CEST)
Received: from kaod.org (lfbn-1-10649-41.w90-89.abo.wanadoo.fr [90.89.235.41])
 (Authenticated sender: clg@kaod.org)
 by player157.ha.ovh.net (Postfix) with ESMTPSA id A95386EB556F;
 Tue, 18 Jun 2019 16:55:37 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 18 Jun 2019 18:53:10 +0200
Message-Id: <20190618165311.27066-21-clg@kaod.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190618165311.27066-1-clg@kaod.org>
References: <20190618165311.27066-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 1698420012239129361
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrtddtgdejkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 87.98.139.208
Subject: [Qemu-devel] [PATCH v2 20/21] hw/misc/aspeed_xdma: New device
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
Cc: Andrew Jeffery <andrew@aj.id.au>, Eddie James <eajames@linux.ibm.com>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Eddie James <eajames@linux.ibm.com>

The XDMA engine embedded in the Aspeed SOCs performs PCI DMA operations
between the SOC (acting as a BMC) and a host processor in a server.

The XDMA engine exists on the AST2400, AST2500, and AST2600 SOCs, so
enable it for all of those. Add trace events on the important register
writes in the XDMA engine.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
[clg: - changed title ]
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/arm/aspeed_soc.h   |   3 +
 include/hw/misc/aspeed_xdma.h |  30 +++++++
 hw/arm/aspeed_soc.c           |  17 ++++
 hw/misc/aspeed_xdma.c         | 165 ++++++++++++++++++++++++++++++++++
 hw/misc/Makefile.objs         |   1 +
 hw/misc/trace-events          |   3 +
 6 files changed, 219 insertions(+)
 create mode 100644 include/hw/misc/aspeed_xdma.h
 create mode 100644 hw/misc/aspeed_xdma.c

diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index 75b557060b9b..cef605ad6bde 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -15,6 +15,7 @@
 #include "hw/intc/aspeed_vic.h"
 #include "hw/misc/aspeed_scu.h"
 #include "hw/misc/aspeed_sdmc.h"
+#include "hw/misc/aspeed_xdma.h"
 #include "hw/timer/aspeed_timer.h"
 #include "hw/timer/aspeed_rtc.h"
 #include "hw/i2c/aspeed_i2c.h"
@@ -40,6 +41,7 @@ typedef struct AspeedSoCState {
     AspeedTimerCtrlState timerctrl;
     AspeedI2CState i2c;
     AspeedSCUState scu;
+    AspeedXDMAState xdma;
     AspeedSMCState fmc;
     AspeedSMCState spi[ASPEED_SPIS_NUM];
     AspeedSDMCState sdmc;
@@ -108,6 +110,7 @@ enum {
     ASPEED_ETH1,
     ASPEED_ETH2,
     ASPEED_SDRAM,
+    ASPEED_XDMA,
 };
=20
 #endif /* ASPEED_SOC_H */
diff --git a/include/hw/misc/aspeed_xdma.h b/include/hw/misc/aspeed_xdma.=
h
new file mode 100644
index 000000000000..00b45d931f87
--- /dev/null
+++ b/include/hw/misc/aspeed_xdma.h
@@ -0,0 +1,30 @@
+/*
+ * ASPEED XDMA Controller
+ * Eddie James <eajames@linux.ibm.com>
+ *
+ * Copyright (C) 2019 IBM Corp.
+ * SPDX-License-Identifer: GPL-2.0-or-later
+ */
+
+#ifndef ASPEED_XDMA_H
+#define ASPEED_XDMA_H
+
+#include "hw/sysbus.h"
+
+#define TYPE_ASPEED_XDMA "aspeed.xdma"
+#define ASPEED_XDMA(obj) OBJECT_CHECK(AspeedXDMAState, (obj), TYPE_ASPEE=
D_XDMA)
+
+#define ASPEED_XDMA_NUM_REGS (ASPEED_XDMA_REG_SIZE / sizeof(uint32_t))
+#define ASPEED_XDMA_REG_SIZE 0x7C
+
+typedef struct AspeedXDMAState {
+    SysBusDevice parent;
+
+    MemoryRegion iomem;
+    qemu_irq irq;
+
+    char bmc_cmdq_readp_set;
+    uint32_t regs[ASPEED_XDMA_NUM_REGS];
+} AspeedXDMAState;
+
+#endif /* ASPEED_XDMA_H */
diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
index 8a1545545faf..146eeee8d320 100644
--- a/hw/arm/aspeed_soc.c
+++ b/hw/arm/aspeed_soc.c
@@ -32,6 +32,7 @@ static const hwaddr aspeed_soc_ast2400_memmap[] =3D {
     [ASPEED_VIC]    =3D 0x1E6C0000,
     [ASPEED_SDMC]   =3D 0x1E6E0000,
     [ASPEED_SCU]    =3D 0x1E6E2000,
+    [ASPEED_XDMA]   =3D 0x1E6E7000,
     [ASPEED_ADC]    =3D 0x1E6E9000,
     [ASPEED_SRAM]   =3D 0x1E720000,
     [ASPEED_GPIO]   =3D 0x1E780000,
@@ -58,6 +59,7 @@ static const hwaddr aspeed_soc_ast2500_memmap[] =3D {
     [ASPEED_VIC]    =3D 0x1E6C0000,
     [ASPEED_SDMC]   =3D 0x1E6E0000,
     [ASPEED_SCU]    =3D 0x1E6E2000,
+    [ASPEED_XDMA]   =3D 0x1E6E7000,
     [ASPEED_ADC]    =3D 0x1E6E9000,
     [ASPEED_SRAM]   =3D 0x1E720000,
     [ASPEED_GPIO]   =3D 0x1E780000,
@@ -104,6 +106,7 @@ static const int aspeed_soc_ast2400_irqmap[] =3D {
     [ASPEED_I2C]    =3D 12,
     [ASPEED_ETH1]   =3D 2,
     [ASPEED_ETH2]   =3D 3,
+    [ASPEED_XDMA]   =3D 6,
 };
=20
 #define aspeed_soc_ast2500_irqmap aspeed_soc_ast2400_irqmap
@@ -240,6 +243,9 @@ static void aspeed_soc_init(Object *obj)
         sysbus_init_child_obj(obj, "ftgmac100[*]", OBJECT(&s->ftgmac100[=
i]),
                               sizeof(s->ftgmac100[i]), TYPE_FTGMAC100);
     }
+
+    sysbus_init_child_obj(obj, "xdma", OBJECT(&s->xdma), sizeof(s->xdma)=
,
+                          TYPE_ASPEED_XDMA);
 }
=20
 static void aspeed_soc_realize(DeviceState *dev, Error **errp)
@@ -408,6 +414,17 @@ static void aspeed_soc_realize(DeviceState *dev, Err=
or **errp)
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->ftgmac100[i]), 0,
                            aspeed_soc_get_irq(s, ASPEED_ETH1 + i));
     }
+
+    /* XDMA */
+    object_property_set_bool(OBJECT(&s->xdma), true, "realized", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->xdma), 0,
+                    sc->info->memmap[ASPEED_XDMA]);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->xdma), 0,
+                       aspeed_soc_get_irq(s, ASPEED_XDMA));
 }
 static Property aspeed_soc_properties[] =3D {
     DEFINE_PROP_UINT32("num-cpus", AspeedSoCState, num_cpus, 0),
diff --git a/hw/misc/aspeed_xdma.c b/hw/misc/aspeed_xdma.c
new file mode 100644
index 000000000000..eebd4ad540aa
--- /dev/null
+++ b/hw/misc/aspeed_xdma.c
@@ -0,0 +1,165 @@
+/*
+ * ASPEED XDMA Controller
+ * Eddie James <eajames@linux.ibm.com>
+ *
+ * Copyright (C) 2019 IBM Corp
+ * SPDX-License-Identifer: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qemu/error-report.h"
+#include "hw/misc/aspeed_xdma.h"
+#include "qapi/error.h"
+
+#include "trace.h"
+
+#define XDMA_BMC_CMDQ_ADDR         0x10
+#define XDMA_BMC_CMDQ_ENDP         0x14
+#define XDMA_BMC_CMDQ_WRP          0x18
+#define  XDMA_BMC_CMDQ_W_MASK      0x0003FFFF
+#define XDMA_BMC_CMDQ_RDP          0x1C
+#define  XDMA_BMC_CMDQ_RDP_MAGIC   0xEE882266
+#define XDMA_IRQ_ENG_CTRL          0x20
+#define  XDMA_IRQ_ENG_CTRL_US_COMP BIT(4)
+#define  XDMA_IRQ_ENG_CTRL_DS_COMP BIT(5)
+#define  XDMA_IRQ_ENG_CTRL_W_MASK  0xBFEFF07F
+#define XDMA_IRQ_ENG_STAT          0x24
+#define  XDMA_IRQ_ENG_STAT_US_COMP BIT(4)
+#define  XDMA_IRQ_ENG_STAT_DS_COMP BIT(5)
+#define  XDMA_IRQ_ENG_STAT_RESET   0xF8000000
+#define XDMA_MEM_SIZE              0x1000
+
+#define TO_REG(addr) ((addr) / sizeof(uint32_t))
+
+static uint64_t aspeed_xdma_read(void *opaque, hwaddr addr, unsigned int=
 size)
+{
+    uint32_t val =3D 0;
+    AspeedXDMAState *xdma =3D opaque;
+
+    if (addr < ASPEED_XDMA_REG_SIZE) {
+        val =3D xdma->regs[TO_REG(addr)];
+    }
+
+    return (uint64_t)val;
+}
+
+static void aspeed_xdma_write(void *opaque, hwaddr addr, uint64_t val,
+                              unsigned int size)
+{
+    unsigned int idx;
+    uint32_t val32 =3D (uint32_t)val;
+    AspeedXDMAState *xdma =3D opaque;
+
+    if (addr >=3D ASPEED_XDMA_REG_SIZE) {
+        return;
+    }
+
+    switch (addr) {
+    case XDMA_BMC_CMDQ_ENDP:
+        xdma->regs[TO_REG(addr)] =3D val32 & XDMA_BMC_CMDQ_W_MASK;
+        break;
+    case XDMA_BMC_CMDQ_WRP:
+        idx =3D TO_REG(addr);
+        xdma->regs[idx] =3D val32 & XDMA_BMC_CMDQ_W_MASK;
+        xdma->regs[TO_REG(XDMA_BMC_CMDQ_RDP)] =3D xdma->regs[idx];
+
+        trace_aspeed_xdma_write(addr, val);
+
+        if (xdma->bmc_cmdq_readp_set) {
+            xdma->bmc_cmdq_readp_set =3D 0;
+        } else {
+            xdma->regs[TO_REG(XDMA_IRQ_ENG_STAT)] |=3D
+                XDMA_IRQ_ENG_STAT_US_COMP | XDMA_IRQ_ENG_STAT_DS_COMP;
+
+            if (xdma->regs[TO_REG(XDMA_IRQ_ENG_CTRL)] &
+                (XDMA_IRQ_ENG_CTRL_US_COMP | XDMA_IRQ_ENG_CTRL_DS_COMP))
+                qemu_irq_raise(xdma->irq);
+        }
+        break;
+    case XDMA_BMC_CMDQ_RDP:
+        trace_aspeed_xdma_write(addr, val);
+
+        if (val32 =3D=3D XDMA_BMC_CMDQ_RDP_MAGIC) {
+            xdma->bmc_cmdq_readp_set =3D 1;
+        }
+        break;
+    case XDMA_IRQ_ENG_CTRL:
+        xdma->regs[TO_REG(addr)] =3D val32 & XDMA_IRQ_ENG_CTRL_W_MASK;
+        break;
+    case XDMA_IRQ_ENG_STAT:
+        trace_aspeed_xdma_write(addr, val);
+
+        idx =3D TO_REG(addr);
+        if (val32 & (XDMA_IRQ_ENG_STAT_US_COMP | XDMA_IRQ_ENG_STAT_DS_CO=
MP)) {
+            xdma->regs[idx] &=3D
+                ~(XDMA_IRQ_ENG_STAT_US_COMP | XDMA_IRQ_ENG_STAT_DS_COMP)=
;
+            qemu_irq_lower(xdma->irq);
+        }
+        break;
+    default:
+        xdma->regs[TO_REG(addr)] =3D val32;
+        break;
+    }
+}
+
+static const MemoryRegionOps aspeed_xdma_ops =3D {
+    .read =3D aspeed_xdma_read,
+    .write =3D aspeed_xdma_write,
+    .endianness =3D DEVICE_NATIVE_ENDIAN,
+    .valid.min_access_size =3D 4,
+    .valid.max_access_size =3D 4,
+};
+
+static void aspeed_xdma_realize(DeviceState *dev, Error **errp)
+{
+    SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);
+    AspeedXDMAState *xdma =3D ASPEED_XDMA(dev);
+
+    sysbus_init_irq(sbd, &xdma->irq);
+    memory_region_init_io(&xdma->iomem, OBJECT(xdma), &aspeed_xdma_ops, =
xdma,
+                          TYPE_ASPEED_XDMA, XDMA_MEM_SIZE);
+    sysbus_init_mmio(sbd, &xdma->iomem);
+}
+
+static void aspeed_xdma_reset(DeviceState *dev)
+{
+    AspeedXDMAState *xdma =3D ASPEED_XDMA(dev);
+
+    xdma->bmc_cmdq_readp_set =3D 0;
+    memset(xdma->regs, 0, ASPEED_XDMA_REG_SIZE);
+    xdma->regs[TO_REG(XDMA_IRQ_ENG_STAT)] =3D XDMA_IRQ_ENG_STAT_RESET;
+
+    qemu_irq_lower(xdma->irq);
+}
+
+static const VMStateDescription aspeed_xdma_vmstate =3D {
+    .name =3D TYPE_ASPEED_XDMA,
+    .version_id =3D 1,
+    .fields =3D (VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(regs, AspeedXDMAState, ASPEED_XDMA_NUM_REGS=
),
+        VMSTATE_END_OF_LIST(),
+    },
+};
+
+static void aspeed_xdma_class_init(ObjectClass *classp, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(classp);
+
+    dc->realize =3D aspeed_xdma_realize;
+    dc->reset =3D aspeed_xdma_reset;
+    dc->vmsd =3D &aspeed_xdma_vmstate;
+}
+
+static const TypeInfo aspeed_xdma_info =3D {
+    .name          =3D TYPE_ASPEED_XDMA,
+    .parent        =3D TYPE_SYS_BUS_DEVICE,
+    .instance_size =3D sizeof(AspeedXDMAState),
+    .class_init    =3D aspeed_xdma_class_init,
+};
+
+static void aspeed_xdma_register_type(void)
+{
+    type_register_static(&aspeed_xdma_info);
+}
+type_init(aspeed_xdma_register_type);
diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
index 77b9df9796e3..e9aab519a1a4 100644
--- a/hw/misc/Makefile.objs
+++ b/hw/misc/Makefile.objs
@@ -74,6 +74,7 @@ obj-$(CONFIG_ARMSSE_MHU) +=3D armsse-mhu.o
=20
 obj-$(CONFIG_PVPANIC) +=3D pvpanic.o
 obj-$(CONFIG_AUX) +=3D auxbus.o
+obj-$(CONFIG_ASPEED_SOC) +=3D aspeed_xdma.o
 obj-$(CONFIG_ASPEED_SOC) +=3D aspeed_scu.o aspeed_sdmc.o
 obj-$(CONFIG_MSF2) +=3D msf2-sysreg.o
 obj-$(CONFIG_NRF51_SOC) +=3D nrf51_rng.o
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index 47e1bccf71d5..c1ea1aa4376d 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -140,3 +140,6 @@ armsse_cpuid_write(uint64_t offset, uint64_t data, un=
signed size) "SSE-200 CPU_I
 # armsse-mhu.c
 armsse_mhu_read(uint64_t offset, uint64_t data, unsigned size) "SSE-200 =
MHU read: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u"
 armsse_mhu_write(uint64_t offset, uint64_t data, unsigned size) "SSE-200=
 MHU write: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u"
+
+# aspeed_xdma.c
+aspeed_xdma_write(uint64_t offset, uint64_t data) "XDMA write: offset 0x=
%" PRIx64 " data 0x%" PRIx64
--=20
2.21.0



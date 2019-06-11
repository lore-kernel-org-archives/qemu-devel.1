Return-Path: <SRS0=mXWu=UK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F7F1C31E44
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 21:11:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52CC32080A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 21:11:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52CC32080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55446 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hao3Z-0001W0-Jr
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 17:11:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58072)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eajames@linux.ibm.com>) id 1hanwc-0004OR-8s
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 17:04:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eajames@linux.ibm.com>) id 1hannE-000130-Un
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 16:54:59 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50180)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eajames@linux.ibm.com>)
 id 1hannC-0000xr-LW
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 16:54:55 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x5BKppWa061143
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2019 16:54:45 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2t2htnn1f8-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2019 16:54:45 -0400
Received: from localhost
 by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <eajames@linux.ibm.com>;
 Tue, 11 Jun 2019 21:54:44 +0100
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
 by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 11 Jun 2019 21:54:40 +0100
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com
 [9.57.199.110])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x5BKsdpB41419040
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 11 Jun 2019 20:54:39 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 53513AE060;
 Tue, 11 Jun 2019 20:54:39 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BBC03AE05C;
 Tue, 11 Jun 2019 20:54:38 +0000 (GMT)
Received: from talon7.ibm.com (unknown [9.41.179.222])
 by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue, 11 Jun 2019 20:54:38 +0000 (GMT)
From: Eddie James <eajames@linux.ibm.com>
To: qemu-arm@nongnu.org
Date: Tue, 11 Jun 2019 15:54:36 -0500
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
x-cbid: 19061120-2213-0000-0000-0000039E0167
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011247; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01216590; UDB=6.00639681; IPR=6.00997690; 
 MB=3.00027270; MTD=3.00000008; XFM=3.00000015; UTC=2019-06-11 20:54:42
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19061120-2214-0000-0000-00005ED30C1A
Message-Id: <1560286476-23494-1-git-send-email-eajames@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-06-11_10:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906110135
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
Subject: [Qemu-devel] [PATCH v2] hw: misc: Add Aspeed XDMA device
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
Cc: peter.maydell@linaro.org, andrew@aj.id.au,
 Eddie James <eajames@linux.ibm.com>, qemu-devel@nongnu.org, clg@kaod.org,
 joel@jms.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The XDMA engine embedded in the Aspeed SOCs performs PCI DMA operations
between the SOC (acting as a BMC) and a host processor in a server.

The XDMA engine exists on the AST2400, AST2500, and AST2600 SOCs, so
enable it for all of those. Add trace events on the important register
writes in the XDMA engine.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
Changes since v1:
 - add trace events
 - minor cleanup

This patch is based on Cedric's big Aspeed update:
    http://patchwork.ozlabs.org/cover/1105343/

 hw/arm/aspeed_soc.c           |  19 +++++
 hw/misc/Makefile.objs         |   1 +
 hw/misc/aspeed_xdma.c         | 165 ++++++++++++++++++++++++++++++++++++++++++
 hw/misc/trace-events          |   3 +
 include/hw/arm/aspeed_soc.h   |   3 +
 include/hw/misc/aspeed_xdma.h |  30 ++++++++
 6 files changed, 221 insertions(+)
 create mode 100644 hw/misc/aspeed_xdma.c
 create mode 100644 include/hw/misc/aspeed_xdma.h

diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
index 0a0ab87..6901697 100644
--- a/hw/arm/aspeed_soc.c
+++ b/hw/arm/aspeed_soc.c
@@ -31,6 +31,7 @@ static const hwaddr aspeed_soc_ast2400_memmap[] = {
     [ASPEED_VIC]    = 0x1E6C0000,
     [ASPEED_SDMC]   = 0x1E6E0000,
     [ASPEED_SCU]    = 0x1E6E2000,
+    [ASPEED_XDMA]   = 0x1E6E7000,
     [ASPEED_ADC]    = 0x1E6E9000,
     [ASPEED_SRAM]   = 0x1E720000,
     [ASPEED_GPIO]   = 0x1E780000,
@@ -57,6 +58,7 @@ static const hwaddr aspeed_soc_ast2500_memmap[] = {
     [ASPEED_VIC]    = 0x1E6C0000,
     [ASPEED_SDMC]   = 0x1E6E0000,
     [ASPEED_SCU]    = 0x1E6E2000,
+    [ASPEED_XDMA]   = 0x1E6E7000,
     [ASPEED_ADC]    = 0x1E6E9000,
     [ASPEED_SRAM]   = 0x1E720000,
     [ASPEED_GPIO]   = 0x1E780000,
@@ -90,6 +92,7 @@ static const hwaddr aspeed_soc_ast2600_memmap[] = {
     [ASPEED_VIC]    = 0x1E6C0000,
     [ASPEED_SDMC]   = 0x1E6E0000,
     [ASPEED_SCU]    = 0x1E6E2000,
+    [ASPEED_XDMA]   = 0x1E6E7000,
     [ASPEED_ADC]    = 0x1E6E9000,
     [ASPEED_SRAM]   = 0x1E720000,
     [ASPEED_GPIO]   = 0x1E780000,
@@ -137,6 +140,7 @@ static const int aspeed_soc_ast2400_irqmap[] = {
     [ASPEED_I2C]    = 12,
     [ASPEED_ETH1]   = 2,
     [ASPEED_ETH2]   = 3,
+    [ASPEED_XDMA]   = 6,
 };
 
 #define aspeed_soc_ast2500_irqmap aspeed_soc_ast2400_irqmap
@@ -174,6 +178,7 @@ static const int aspeed_soc_ast2600_irqmap[] = {
     [ASPEED_ETH2]   = 3,
     [ASPEED_FSI1]   = 100,
     [ASPEED_FSI2]   = 101,
+    [ASPEED_XDMA]   = 6,
 };
 
 static const char *aspeed_soc_ast2400_typenames[] = { "aspeed.smc.spi" };
@@ -359,6 +364,9 @@ static void aspeed_soc_init(Object *obj)
         sysbus_init_child_obj(obj, "fsi[*]", OBJECT(&s->fsi[0]),
                               sizeof(s->fsi[0]), TYPE_ASPEED_FSI);
     }
+
+    sysbus_init_child_obj(obj, "xdma", OBJECT(&s->xdma), sizeof(s->xdma),
+                          TYPE_ASPEED_XDMA);
 }
 
 static void aspeed_soc_realize(DeviceState *dev, Error **errp)
@@ -662,6 +670,17 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->fsi[0]), 0,
                            aspeed_soc_get_irq(s, ASPEED_FSI1));
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
 
 static void aspeed_soc_class_init(ObjectClass *oc, void *data)
diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
index d33c1c6..dc2b9c3 100644
--- a/hw/misc/Makefile.objs
+++ b/hw/misc/Makefile.objs
@@ -78,6 +78,7 @@ obj-$(CONFIG_PVPANIC) += pvpanic.o
 obj-$(CONFIG_AUX) += auxbus.o
 obj-$(CONFIG_ASPEED_SOC) += aspeed_scu.o aspeed_sdmc.o aspeed_ibt.o
 obj-$(CONFIG_ASPEED_SOC) += aspeed_pwm.o aspeed_lpc.o aspeed_fsi.o
+obj-$(CONFIG_ASPEED_SOC) += aspeed_xdma.o
 obj-$(CONFIG_MSF2) += msf2-sysreg.o
 obj-$(CONFIG_NRF51_SOC) += nrf51_rng.o
 
diff --git a/hw/misc/aspeed_xdma.c b/hw/misc/aspeed_xdma.c
new file mode 100644
index 0000000..eebd4ad
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
+static uint64_t aspeed_xdma_read(void *opaque, hwaddr addr, unsigned int size)
+{
+    uint32_t val = 0;
+    AspeedXDMAState *xdma = opaque;
+
+    if (addr < ASPEED_XDMA_REG_SIZE) {
+        val = xdma->regs[TO_REG(addr)];
+    }
+
+    return (uint64_t)val;
+}
+
+static void aspeed_xdma_write(void *opaque, hwaddr addr, uint64_t val,
+                              unsigned int size)
+{
+    unsigned int idx;
+    uint32_t val32 = (uint32_t)val;
+    AspeedXDMAState *xdma = opaque;
+
+    if (addr >= ASPEED_XDMA_REG_SIZE) {
+        return;
+    }
+
+    switch (addr) {
+    case XDMA_BMC_CMDQ_ENDP:
+        xdma->regs[TO_REG(addr)] = val32 & XDMA_BMC_CMDQ_W_MASK;
+        break;
+    case XDMA_BMC_CMDQ_WRP:
+        idx = TO_REG(addr);
+        xdma->regs[idx] = val32 & XDMA_BMC_CMDQ_W_MASK;
+        xdma->regs[TO_REG(XDMA_BMC_CMDQ_RDP)] = xdma->regs[idx];
+
+        trace_aspeed_xdma_write(addr, val);
+
+        if (xdma->bmc_cmdq_readp_set) {
+            xdma->bmc_cmdq_readp_set = 0;
+        } else {
+            xdma->regs[TO_REG(XDMA_IRQ_ENG_STAT)] |=
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
+        if (val32 == XDMA_BMC_CMDQ_RDP_MAGIC) {
+            xdma->bmc_cmdq_readp_set = 1;
+        }
+        break;
+    case XDMA_IRQ_ENG_CTRL:
+        xdma->regs[TO_REG(addr)] = val32 & XDMA_IRQ_ENG_CTRL_W_MASK;
+        break;
+    case XDMA_IRQ_ENG_STAT:
+        trace_aspeed_xdma_write(addr, val);
+
+        idx = TO_REG(addr);
+        if (val32 & (XDMA_IRQ_ENG_STAT_US_COMP | XDMA_IRQ_ENG_STAT_DS_COMP)) {
+            xdma->regs[idx] &=
+                ~(XDMA_IRQ_ENG_STAT_US_COMP | XDMA_IRQ_ENG_STAT_DS_COMP);
+            qemu_irq_lower(xdma->irq);
+        }
+        break;
+    default:
+        xdma->regs[TO_REG(addr)] = val32;
+        break;
+    }
+}
+
+static const MemoryRegionOps aspeed_xdma_ops = {
+    .read = aspeed_xdma_read,
+    .write = aspeed_xdma_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+    .valid.min_access_size = 4,
+    .valid.max_access_size = 4,
+};
+
+static void aspeed_xdma_realize(DeviceState *dev, Error **errp)
+{
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+    AspeedXDMAState *xdma = ASPEED_XDMA(dev);
+
+    sysbus_init_irq(sbd, &xdma->irq);
+    memory_region_init_io(&xdma->iomem, OBJECT(xdma), &aspeed_xdma_ops, xdma,
+                          TYPE_ASPEED_XDMA, XDMA_MEM_SIZE);
+    sysbus_init_mmio(sbd, &xdma->iomem);
+}
+
+static void aspeed_xdma_reset(DeviceState *dev)
+{
+    AspeedXDMAState *xdma = ASPEED_XDMA(dev);
+
+    xdma->bmc_cmdq_readp_set = 0;
+    memset(xdma->regs, 0, ASPEED_XDMA_REG_SIZE);
+    xdma->regs[TO_REG(XDMA_IRQ_ENG_STAT)] = XDMA_IRQ_ENG_STAT_RESET;
+
+    qemu_irq_lower(xdma->irq);
+}
+
+static const VMStateDescription aspeed_xdma_vmstate = {
+    .name = TYPE_ASPEED_XDMA,
+    .version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(regs, AspeedXDMAState, ASPEED_XDMA_NUM_REGS),
+        VMSTATE_END_OF_LIST(),
+    },
+};
+
+static void aspeed_xdma_class_init(ObjectClass *classp, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(classp);
+
+    dc->realize = aspeed_xdma_realize;
+    dc->reset = aspeed_xdma_reset;
+    dc->vmsd = &aspeed_xdma_vmstate;
+}
+
+static const TypeInfo aspeed_xdma_info = {
+    .name          = TYPE_ASPEED_XDMA,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(AspeedXDMAState),
+    .class_init    = aspeed_xdma_class_init,
+};
+
+static void aspeed_xdma_register_type(void)
+{
+    type_register_static(&aspeed_xdma_info);
+}
+type_init(aspeed_xdma_register_type);
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index 47e1bcc..c1ea1aa 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -140,3 +140,6 @@ armsse_cpuid_write(uint64_t offset, uint64_t data, unsigned size) "SSE-200 CPU_I
 # armsse-mhu.c
 armsse_mhu_read(uint64_t offset, uint64_t data, unsigned size) "SSE-200 MHU read: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u"
 armsse_mhu_write(uint64_t offset, uint64_t data, unsigned size) "SSE-200 MHU write: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u"
+
+# aspeed_xdma.c
+aspeed_xdma_write(uint64_t offset, uint64_t data) "XDMA write: offset 0x%" PRIx64 " data 0x%" PRIx64
diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index 00ee260..0aaf510 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -28,6 +28,7 @@
 #include "hw/misc/aspeed_pwm.h"
 #include "hw/misc/aspeed_lpc.h"
 #include "hw/misc/aspeed_fsi.h"
+#include "hw/misc/aspeed_xdma.h"
 
 #define ASPEED_SPIS_NUM  2
 #define ASPEED_WDTS_NUM  3
@@ -59,6 +60,7 @@ typedef struct AspeedSoCState {
     AspeedPWMState pwm;
     AspeedLPCState lpc;
     AspeedFsiState fsi[2];
+    AspeedXDMAState xdma;
 } AspeedSoCState;
 
 #define TYPE_ASPEED_SOC "aspeed-soc"
@@ -126,6 +128,7 @@ enum {
     ASPEED_SDRAM,
     ASPEED_FSI1,
     ASPEED_FSI2,
+    ASPEED_XDMA,
 };
 
 #endif /* ASPEED_SOC_H */
diff --git a/include/hw/misc/aspeed_xdma.h b/include/hw/misc/aspeed_xdma.h
new file mode 100644
index 0000000..00b45d9
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
+#define ASPEED_XDMA(obj) OBJECT_CHECK(AspeedXDMAState, (obj), TYPE_ASPEED_XDMA)
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
-- 
1.8.3.1



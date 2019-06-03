Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 196BBC04AB5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 23:04:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5CAF26A4C
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 23:04:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5CAF26A4C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42107 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXw0b-0000Np-0c
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 19:04:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eajames@linux.ibm.com>) id 1hXv9U-000768-Lk
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 18:10:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eajames@linux.ibm.com>) id 1hXv9S-0006yZ-Qf
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 18:10:00 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54410
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eajames@linux.ibm.com>)
	id 1hXv9P-0005vL-D3
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 18:09:56 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x53M79tt020988
	for <qemu-devel@nongnu.org>; Mon, 3 Jun 2019 18:09:38 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2swa11506y-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 03 Jun 2019 18:09:37 -0400
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <eajames@linux.ibm.com>;
	Mon, 3 Jun 2019 23:09:37 +0100
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
	by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway:
	Authorized Use Only! Violators will be prosecuted; 
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Mon, 3 Jun 2019 23:09:33 +0100
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com
	[9.57.199.111])
	by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	x53M9WXR25625082
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK); Mon, 3 Jun 2019 22:09:33 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E11DEAC0BC;
	Mon,  3 Jun 2019 22:09:32 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 48130AC0B3;
	Mon,  3 Jun 2019 22:09:32 +0000 (GMT)
Received: from talon7.ibm.com (unknown [9.41.179.222])
	by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
	Mon,  3 Jun 2019 22:09:32 +0000 (GMT)
From: Eddie James <eajames@linux.ibm.com>
To: qemu-arm@nongnu.org
Date: Mon,  3 Jun 2019 17:09:28 -0500
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
x-cbid: 19060322-0040-0000-0000-000004F8251A
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011210; HX=3.00000242; KW=3.00000007;
	PH=3.00000004; SC=3.00000286; SDB=6.01212822; UDB=6.00637394;
	IPR=6.00993882; 
	MB=3.00027171; MTD=3.00000008; XFM=3.00000015; UTC=2019-06-03 22:09:35
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19060322-0041-0000-0000-0000090442BE
Message-Id: <1559599768-9176-1-git-send-email-eajames@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-06-03_17:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
	priorityscore=1501
	malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
	clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
	mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
	scancount=1 engine=8.0.1-1810050000 definitions=main-1906030148
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
X-Mailman-Approved-At: Mon, 03 Jun 2019 19:04:01 -0400
Subject: [Qemu-devel] [PATCH] hw: misc: Add Aspeed XDMA device
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: peter.maydell@linaro.org, andrew@aj.id.au,
	Eddie James <eajames@linux.ibm.com>, qemu-devel@nongnu.org,
	clg@kaod.org, joel@jms.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The XDMA engine embedded in the Aspeed SOCs performs PCI DMA operations
between the SOC (acting as a BMC) and a host processor in a server.

The XDMA engine exists on the AST2400, AST2500, and AST2600 SOCs, so
enable it for all of those.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 hw/arm/aspeed_soc.c           |  14 ++++
 hw/misc/Makefile.objs         |   2 +-
 hw/misc/aspeed_xdma.c         | 156 ++++++++++++++++++++++++++++++++++++++++++
 include/hw/arm/aspeed_soc.h   |   2 +
 include/hw/misc/aspeed_xdma.h |  31 +++++++++
 5 files changed, 204 insertions(+), 1 deletion(-)
 create mode 100644 hw/misc/aspeed_xdma.c
 create mode 100644 include/hw/misc/aspeed_xdma.h

diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
index faff42b..b25bb18 100644
--- a/hw/arm/aspeed_soc.c
+++ b/hw/arm/aspeed_soc.c
@@ -31,6 +31,7 @@
 #define ASPEED_SOC_VIC_BASE         0x1E6C0000
 #define ASPEED_SOC_SDMC_BASE        0x1E6E0000
 #define ASPEED_SOC_SCU_BASE         0x1E6E2000
+#define ASPEED_SOC_XDMA_BASE        0x1E6E7000
 #define ASPEED_SOC_SRAM_BASE        0x1E720000
 #define ASPEED_SOC_TIMER_BASE       0x1E782000
 #define ASPEED_SOC_WDT_BASE         0x1E785000
@@ -159,6 +160,9 @@ static void aspeed_soc_init(Object *obj)
 
     sysbus_init_child_obj(obj, "ftgmac100", OBJECT(&s->ftgmac100),
                           sizeof(s->ftgmac100), TYPE_FTGMAC100);
+
+    sysbus_init_child_obj(obj, "xdma", OBJECT(&s->xdma), sizeof(s->xdma),
+                          TYPE_ASPEED_XDMA);
 }
 
 static void aspeed_soc_realize(DeviceState *dev, Error **errp)
@@ -298,6 +302,16 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->ftgmac100), 0, ASPEED_SOC_ETH1_BASE);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->ftgmac100), 0,
                        qdev_get_gpio_in(DEVICE(&s->vic), 2));
+
+    /* XDMA */
+    object_property_set_bool(OBJECT(&s->xdma), true, "realized", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->xdma), 0, ASPEED_SOC_XDMA_BASE);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->xdma), 0,
+                       qdev_get_gpio_in(DEVICE(&s->vic), 6));
 }
 
 static void aspeed_soc_class_init(ObjectClass *oc, void *data)
diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
index 77b9df9..a4483af 100644
--- a/hw/misc/Makefile.objs
+++ b/hw/misc/Makefile.objs
@@ -74,7 +74,7 @@ obj-$(CONFIG_ARMSSE_MHU) += armsse-mhu.o
 
 obj-$(CONFIG_PVPANIC) += pvpanic.o
 obj-$(CONFIG_AUX) += auxbus.o
-obj-$(CONFIG_ASPEED_SOC) += aspeed_scu.o aspeed_sdmc.o
+obj-$(CONFIG_ASPEED_SOC) += aspeed_scu.o aspeed_sdmc.o aspeed_xdma.o
 obj-$(CONFIG_MSF2) += msf2-sysreg.o
 obj-$(CONFIG_NRF51_SOC) += nrf51_rng.o
 
diff --git a/hw/misc/aspeed_xdma.c b/hw/misc/aspeed_xdma.c
new file mode 100644
index 0000000..fe3a32e
--- /dev/null
+++ b/hw/misc/aspeed_xdma.c
@@ -0,0 +1,156 @@
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
+        if (val32 == XDMA_BMC_CMDQ_RDP_MAGIC) {
+            xdma->bmc_cmdq_readp_set = 1;
+        }
+        break;
+    case XDMA_IRQ_ENG_CTRL:
+        xdma->regs[TO_REG(addr)] = val32 & XDMA_IRQ_ENG_CTRL_W_MASK;
+        break;
+    case XDMA_IRQ_ENG_STAT:
+        idx = TO_REG(addr);
+        if (val32 & (XDMA_IRQ_ENG_STAT_US_COMP | XDMA_IRQ_ENG_STAT_DS_COMP)) {
+            xdma->regs[TO_REG(addr)] &=
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
+                          TYPE_ASPEED_XDMA, ASPEED_XDMA_MEM_SIZE);
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
diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index 836b2ba..0329247 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -20,6 +20,7 @@
 #include "hw/ssi/aspeed_smc.h"
 #include "hw/watchdog/wdt_aspeed.h"
 #include "hw/net/ftgmac100.h"
+#include "hw/misc/aspeed_xdma.h"
 
 #define ASPEED_SPIS_NUM  2
 #define ASPEED_WDTS_NUM  3
@@ -40,6 +41,7 @@ typedef struct AspeedSoCState {
     AspeedSDMCState sdmc;
     AspeedWDTState wdt[ASPEED_WDTS_NUM];
     FTGMAC100State ftgmac100;
+    AspeedXDMAState xdma;
 } AspeedSoCState;
 
 #define TYPE_ASPEED_SOC "aspeed-soc"
diff --git a/include/hw/misc/aspeed_xdma.h b/include/hw/misc/aspeed_xdma.h
new file mode 100644
index 0000000..d19e9a7
--- /dev/null
+++ b/include/hw/misc/aspeed_xdma.h
@@ -0,0 +1,31 @@
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
+#define ASPEED_XDMA_MEM_SIZE 0x1000
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



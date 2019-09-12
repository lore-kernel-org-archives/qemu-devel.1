Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE7F3C5ACAE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 09:48:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A379D20856
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 09:48:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A379D20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8Li8-0000RC-QV
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 05:48:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45119)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bala24@linux.ibm.com>) id 1i8LRt-0000O2-0i
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 05:31:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bala24@linux.ibm.com>) id 1i8LRq-0006qr-MJ
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 05:31:32 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:17890)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <bala24@linux.ibm.com>)
 id 1i8LRq-0006qN-FQ
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 05:31:30 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x8C9IKSs032480
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2019 05:31:29 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2uyk7mrk7s-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2019 05:31:29 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <bala24@linux.ibm.com>;
 Thu, 12 Sep 2019 10:31:27 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 12 Sep 2019 10:31:23 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x8C9VMUY50659568
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Sep 2019 09:31:22 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A6B03AE055;
 Thu, 12 Sep 2019 09:31:22 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 17B1AAE051;
 Thu, 12 Sep 2019 09:31:21 +0000 (GMT)
Received: from localhost.in.ibm.com (unknown [9.124.35.221])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu, 12 Sep 2019 09:31:20 +0000 (GMT)
From: Balamuruhan S <bala24@linux.ibm.com>
To: qemu-devel@nongnu.org
Date: Thu, 12 Sep 2019 15:00:54 +0530
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20190912093056.4516-1-bala24@linux.ibm.com>
References: <20190912093056.4516-1-bala24@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19091209-4275-0000-0000-00000364D070
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19091209-4276-0000-0000-000038772A8F
Message-Id: <20190912093056.4516-4-bala24@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-09-12_04:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1909120099
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
Subject: [Qemu-devel] [PATCH v3 3/4] hw/ppc/pnv_homer: add PowerNV homer
 device model
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
Cc: maddy@linux.vnet.ibm.com, groug@kaod.org,
 Balamuruhan S <bala24@linux.ibm.com>, anju@linux.vnet.ibm.com,
 qemu-ppc@nongnu.org, clg@kaod.org, hari@linux.vnet.ibm.com,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

add PnvHomer device model to emulate homer memory access
for pstate table, occ-sensors, slw, occ static and dynamic
values for Power8 and Power9 chips.

Signed-off-by: Balamuruhan S <bala24@linux.ibm.com>
---
 hw/ppc/Makefile.objs       |   1 +
 hw/ppc/pnv.c               |  30 +++++
 hw/ppc/pnv_homer.c         | 272 +++++++++++++++++++++++++++++++++++++++++++++
 include/hw/ppc/pnv.h       |   3 +
 include/hw/ppc/pnv_homer.h |  53 +++++++++
 5 files changed, 359 insertions(+)
 create mode 100644 hw/ppc/pnv_homer.c
 create mode 100644 include/hw/ppc/pnv_homer.h

diff --git a/hw/ppc/Makefile.objs b/hw/ppc/Makefile.objs
index 2c4e1c8de0..580bb4f0dd 100644
--- a/hw/ppc/Makefile.objs
+++ b/hw/ppc/Makefile.objs
@@ -9,6 +9,7 @@ obj-$(CONFIG_PSERIES) += spapr_tpm_proxy.o
 obj-$(CONFIG_SPAPR_RNG) +=  spapr_rng.o
 # IBM PowerNV
 obj-$(CONFIG_POWERNV) += pnv.o pnv_xscom.o pnv_core.o pnv_lpc.o pnv_psi.o pnv_occ.o pnv_bmc.o
+obj-$(CONFIG_POWERNV) += pnv_homer.o
 ifeq ($(CONFIG_PCI)$(CONFIG_PSERIES)$(CONFIG_LINUX), yyy)
 obj-y += spapr_pci_vfio.o spapr_pci_nvlink2.o
 endif
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 80338ffe87..f249e72356 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -847,6 +847,11 @@ static void pnv_chip_power8_instance_init(Object *obj)
                             TYPE_PNV8_OCC, &error_abort, NULL);
     object_property_add_const_link(OBJECT(&chip8->occ), "psi",
                                    OBJECT(&chip8->psi), &error_abort);
+
+    object_initialize_child(obj, "homer",  &chip8->homer, sizeof(chip8->homer),
+                            TYPE_PNV8_HOMER, &error_abort, NULL);
+    object_property_add_const_link(OBJECT(&chip8->homer), "chip", obj,
+                                   &error_abort);
 }
 
 static void pnv_chip_icp_realize(Pnv8Chip *chip8, Error **errp)
@@ -942,6 +947,16 @@ static void pnv_chip_power8_realize(DeviceState *dev, Error **errp)
     /* OCC SRAM model */
     memory_region_add_subregion(get_system_memory(), PNV_OCC_COMMON_AREA(chip),
                                 &chip8->occ.sram_regs);
+
+    /* HOMER */
+    object_property_set_bool(OBJECT(&chip8->homer), true, "realized",
+                             &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+    memory_region_add_subregion(get_system_memory(), PNV_HOMER_BASE(chip),
+                                &chip8->homer.regs);
 }
 
 static void pnv_chip_power8e_class_init(ObjectClass *klass, void *data)
@@ -1024,6 +1039,11 @@ static void pnv_chip_power9_instance_init(Object *obj)
                             TYPE_PNV9_OCC, &error_abort, NULL);
     object_property_add_const_link(OBJECT(&chip9->occ), "psi",
                                    OBJECT(&chip9->psi), &error_abort);
+
+    object_initialize_child(obj, "homer",  &chip9->homer, sizeof(chip9->homer),
+                            TYPE_PNV9_HOMER, &error_abort, NULL);
+    object_property_add_const_link(OBJECT(&chip9->homer), "chip", obj,
+                                   &error_abort);
 }
 
 static void pnv_chip_quad_realize(Pnv9Chip *chip9, Error **errp)
@@ -1134,6 +1154,16 @@ static void pnv_chip_power9_realize(DeviceState *dev, Error **errp)
     /* OCC SRAM model */
     memory_region_add_subregion(get_system_memory(), PNV9_OCC_COMMON_AREA(chip),
                                 &chip9->occ.sram_regs);
+
+    /* HOMER */
+    object_property_set_bool(OBJECT(&chip9->homer), true, "realized",
+                             &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+    memory_region_add_subregion(get_system_memory(), PNV9_HOMER_BASE(chip),
+                                &chip9->homer.regs);
 }
 
 static void pnv_chip_power9_class_init(ObjectClass *klass, void *data)
diff --git a/hw/ppc/pnv_homer.c b/hw/ppc/pnv_homer.c
new file mode 100644
index 0000000000..cc881a3b32
--- /dev/null
+++ b/hw/ppc/pnv_homer.c
@@ -0,0 +1,272 @@
+/*
+ * QEMU PowerPC PowerNV Emulation of a few HOMER related registers
+ *
+ * Copyright (c) 2019, IBM Corporation.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "exec/hwaddr.h"
+#include "exec/memory.h"
+#include "sysemu/cpus.h"
+#include "hw/qdev-core.h"
+#include "hw/ppc/pnv.h"
+#include "hw/ppc/pnv_homer.h"
+
+
+static bool core_max_array(PnvHomer *homer, hwaddr addr)
+{
+    int i;
+    PnvHomerClass *hmrc = PNV_HOMER_GET_CLASS(homer);
+
+    for (i = 0; i <= homer->chip->nr_cores; i++) {
+        if (addr == (hmrc->core_max_base + i)) {
+            return true;
+       }
+    }
+    return false;
+}
+
+/* P8 Pstate table */
+
+#define PNV8_OCC_PSTATE_VERSION          0x1f8001
+#define PNV8_OCC_PSTATE_MIN              0x1f8003
+#define PNV8_OCC_PSTATE_VALID            0x1f8000
+#define PNV8_OCC_PSTATE_THROTTLE         0x1f8002
+#define PNV8_OCC_PSTATE_NOM              0x1f8004
+#define PNV8_OCC_PSTATE_TURBO            0x1f8005
+#define PNV8_OCC_PSTATE_ULTRA_TURBO      0x1f8006
+#define PNV8_OCC_PSTATE_DATA             0x1f8008
+#define PNV8_OCC_PSTATE_ID_ZERO          0x1f8010
+#define PNV8_OCC_PSTATE_ID_ONE           0x1f8018
+#define PNV8_OCC_PSTATE_ID_TWO           0x1f8020
+#define PNV8_OCC_VDD_VOLTAGE_IDENTIFIER  0x1f8012
+#define PNV8_OCC_VCS_VOLTAGE_IDENTIFIER  0x1f8013
+#define PNV8_OCC_PSTATE_ZERO_FREQUENCY   0x1f8014
+#define PNV8_OCC_PSTATE_ONE_FREQUENCY    0x1f801c
+#define PNV8_OCC_PSTATE_TWO_FREQUENCY    0x1f8024
+#define PNV8_CORE_MAX_BASE               0x1f8810
+
+
+static uint64_t pnv_power8_homer_read(void *opaque, hwaddr addr,
+                                      unsigned size)
+{
+    PnvHomer *homer = PNV_HOMER(opaque);
+
+    switch (addr) {
+    case PNV8_OCC_PSTATE_VERSION:
+    case PNV8_OCC_PSTATE_MIN:
+    case PNV8_OCC_PSTATE_ID_ZERO:
+        return 0;
+    case PNV8_OCC_PSTATE_VALID:
+    case PNV8_OCC_PSTATE_THROTTLE:
+    case PNV8_OCC_PSTATE_NOM:
+    case PNV8_OCC_PSTATE_TURBO:
+    case PNV8_OCC_PSTATE_ID_ONE:
+    case PNV8_OCC_VDD_VOLTAGE_IDENTIFIER:
+    case PNV8_OCC_VCS_VOLTAGE_IDENTIFIER:
+        return 1;
+    case PNV8_OCC_PSTATE_ULTRA_TURBO:
+    case PNV8_OCC_PSTATE_ID_TWO:
+        return 2;
+    case PNV8_OCC_PSTATE_DATA:
+        return 0x1000000000000000;
+    /* P8 frequency for 0, 1, and 2 pstates */
+    case PNV8_OCC_PSTATE_ZERO_FREQUENCY:
+    case PNV8_OCC_PSTATE_ONE_FREQUENCY:
+    case PNV8_OCC_PSTATE_TWO_FREQUENCY:
+        return 3000;
+    }
+    /* pstate table core max array */
+    if (core_max_array(homer, addr)) {
+        return 1;
+    }
+    return 0;
+}
+
+static void pnv_power8_homer_write(void *opaque, hwaddr addr,
+                                   uint64_t val, unsigned size)
+{
+    /* callback function defined to homer write */
+    return;
+}
+
+static const MemoryRegionOps pnv_power8_homer_ops = {
+    .read = pnv_power8_homer_read,
+    .write = pnv_power8_homer_write,
+    .valid.min_access_size = 1,
+    .valid.max_access_size = 8,
+    .impl.min_access_size = 1,
+    .impl.max_access_size = 8,
+    .endianness = DEVICE_BIG_ENDIAN,
+};
+
+static void pnv_homer_power8_class_init(ObjectClass *klass, void *data)
+{
+    PnvHomerClass *homer = PNV_HOMER_CLASS(klass);
+
+    homer->homer_size = PNV_HOMER_SIZE;
+    homer->homer_ops = &pnv_power8_homer_ops;
+    homer->core_max_base = PNV8_CORE_MAX_BASE;
+}
+
+static const TypeInfo pnv_homer_power8_type_info = {
+    .name          = TYPE_PNV8_HOMER,
+    .parent        = TYPE_PNV_HOMER,
+    .instance_size = sizeof(PnvHomer),
+    .class_init    = pnv_homer_power8_class_init,
+};
+
+/* P9 Pstate table */
+
+#define PNV9_OCC_PSTATE_ID_ZERO          0xe2018
+#define PNV9_OCC_PSTATE_ID_ONE           0xe2020
+#define PNV9_OCC_PSTATE_ID_TWO           0xe2028
+#define PNV9_OCC_PSTATE_DATA             0xe2000
+#define PNV9_OCC_PSTATE_DATA_AREA        0xe2008
+#define PNV9_OCC_PSTATE_MIN              0xe2003
+#define PNV9_OCC_PSTATE_NOM              0xe2004
+#define PNV9_OCC_PSTATE_TURBO            0xe2005
+#define PNV9_OCC_PSTATE_ULTRA_TURBO      0xe2818
+#define PNV9_OCC_MAX_PSTATE_ULTRA_TURBO  0xe2006
+#define PNV9_OCC_PSTATE_MAJOR_VERSION    0xe2001
+#define PNV9_OCC_OPAL_RUNTIME_DATA       0xe2b85
+#define PNV9_CHIP_HOMER_IMAGE_POINTER    0x200008
+#define PNV9_CHIP_HOMER_BASE             0x0
+#define PNV9_OCC_PSTATE_ZERO_FREQUENCY   0xe201c
+#define PNV9_OCC_PSTATE_ONE_FREQUENCY    0xe2024
+#define PNV9_OCC_PSTATE_TWO_FREQUENCY    0xe202c
+#define PNV9_OCC_ROLE_MASTER_OR_SLAVE    0xe2002
+#define PNV9_CORE_MAX_BASE               0xe2819
+
+
+static uint64_t pnv_power9_homer_read(void *opaque, hwaddr addr,
+                                      unsigned size)
+{
+    PnvHomer *homer = PNV_HOMER(opaque);
+
+    switch (addr) {
+    case PNV9_OCC_MAX_PSTATE_ULTRA_TURBO:
+    case PNV9_OCC_PSTATE_ID_ZERO:
+        return 0;
+    case PNV9_OCC_PSTATE_DATA:
+    case PNV9_OCC_ROLE_MASTER_OR_SLAVE:
+    case PNV9_OCC_PSTATE_NOM:
+    case PNV9_OCC_PSTATE_TURBO:
+    case PNV9_OCC_PSTATE_ID_ONE:
+    case PNV9_OCC_PSTATE_ULTRA_TURBO:
+    case PNV9_OCC_OPAL_RUNTIME_DATA:
+        return 1;
+    case PNV9_OCC_PSTATE_MIN:
+    case PNV9_OCC_PSTATE_ID_TWO:
+        return 2;
+
+    /* 3000 khz frequency for 0, 1, and 2 pstates */
+    case PNV9_OCC_PSTATE_ZERO_FREQUENCY:
+    case PNV9_OCC_PSTATE_ONE_FREQUENCY:
+    case PNV9_OCC_PSTATE_TWO_FREQUENCY:
+        return 3000;
+    case PNV9_OCC_PSTATE_MAJOR_VERSION:
+        return 0x90;
+    case PNV9_CHIP_HOMER_BASE:
+    case PNV9_OCC_PSTATE_DATA_AREA:
+    case PNV9_CHIP_HOMER_IMAGE_POINTER:
+        return 0x1000000000000000;
+    }
+    /* pstate table core max array */
+    if (core_max_array(homer, addr)) {
+        return 1;
+    }
+    return 0;
+}
+
+static void pnv_power9_homer_write(void *opaque, hwaddr addr,
+                                   uint64_t val, unsigned size)
+{
+    /* callback function defined to homer write */
+    return;
+}
+
+static const MemoryRegionOps pnv_power9_homer_ops = {
+    .read = pnv_power9_homer_read,
+    .write = pnv_power9_homer_write,
+    .valid.min_access_size = 1,
+    .valid.max_access_size = 8,
+    .impl.min_access_size = 1,
+    .impl.max_access_size = 8,
+    .endianness = DEVICE_BIG_ENDIAN,
+};
+
+static void pnv_homer_power9_class_init(ObjectClass *klass, void *data)
+{
+    PnvHomerClass *homer = PNV_HOMER_CLASS(klass);
+
+    homer->homer_size = PNV9_HOMER_SIZE;
+    homer->homer_ops = &pnv_power9_homer_ops;
+    homer->core_max_base = PNV9_CORE_MAX_BASE;
+}
+
+static const TypeInfo pnv_homer_power9_type_info = {
+    .name          = TYPE_PNV9_HOMER,
+    .parent        = TYPE_PNV_HOMER,
+    .instance_size = sizeof(PnvHomer),
+    .class_init    = pnv_homer_power9_class_init,
+};
+
+static void pnv_homer_realize(DeviceState *dev, Error **errp)
+{
+    PnvHomer *homer = PNV_HOMER(dev);
+    PnvHomerClass *hmrc = PNV_HOMER_GET_CLASS(homer);
+    Object *obj;
+    Error *local_err = NULL;
+
+    obj = object_property_get_link(OBJECT(dev), "chip", &local_err);
+    if (!obj) {
+        error_propagate(errp, local_err);
+        error_prepend(errp, "required link 'chip' not found: ");
+        return;
+    }
+    homer->chip = PNV_CHIP(obj);
+    /* homer region */
+    memory_region_init_io(&homer->regs, OBJECT(dev),
+                          hmrc->homer_ops, homer, "homer-main-memory",
+                          hmrc->homer_size);
+}
+
+static void pnv_homer_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = pnv_homer_realize;
+    dc->desc = "PowerNV HOMER Memory";
+}
+
+static const TypeInfo pnv_homer_type_info = {
+    .name          = TYPE_PNV_HOMER,
+    .parent        = TYPE_DEVICE,
+    .instance_size = sizeof(PnvHomer),
+    .class_init    = pnv_homer_class_init,
+    .class_size    = sizeof(PnvHomerClass),
+    .abstract      = true,
+};
+
+static void pnv_homer_register_types(void)
+{
+    type_register_static(&pnv_homer_type_info);
+    type_register_static(&pnv_homer_power8_type_info);
+    type_register_static(&pnv_homer_power9_type_info);
+}
+
+type_init(pnv_homer_register_types);
diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index 63a4b7b6a7..1cdbe55bf8 100644
--- a/include/hw/ppc/pnv.h
+++ b/include/hw/ppc/pnv.h
@@ -26,6 +26,7 @@
 #include "hw/ppc/pnv_lpc.h"
 #include "hw/ppc/pnv_psi.h"
 #include "hw/ppc/pnv_occ.h"
+#include "hw/ppc/pnv_homer.h"
 #include "hw/ppc/pnv_xive.h"
 #include "hw/ppc/pnv_core.h"
 
@@ -76,6 +77,7 @@ typedef struct Pnv8Chip {
     PnvLpcController lpc;
     Pnv8Psi      psi;
     PnvOCC       occ;
+    PnvHomer     homer;
 } Pnv8Chip;
 
 #define TYPE_PNV9_CHIP "pnv9-chip"
@@ -90,6 +92,7 @@ typedef struct Pnv9Chip {
     Pnv9Psi      psi;
     PnvLpcController lpc;
     PnvOCC       occ;
+    PnvHomer     homer;
 
     uint32_t     nr_quads;
     PnvQuad      *quads;
diff --git a/include/hw/ppc/pnv_homer.h b/include/hw/ppc/pnv_homer.h
new file mode 100644
index 0000000000..abaec43c2d
--- /dev/null
+++ b/include/hw/ppc/pnv_homer.h
@@ -0,0 +1,53 @@
+/*
+ * QEMU PowerPC PowerNV Emulation of a few HOMER related registers
+ *
+ * Copyright (c) 2019, IBM Corporation.
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
+#ifndef PPC_PNV_HOMER_H
+#define PPC_PNV_HOMER_H
+
+#include "hw/ppc/pnv.h"
+
+#define TYPE_PNV_HOMER "pnv-homer"
+#define PNV_HOMER(obj) OBJECT_CHECK(PnvHomer, (obj), TYPE_PNV_HOMER)
+#define TYPE_PNV8_HOMER TYPE_PNV_HOMER "-POWER8"
+#define PNV8_HOMER(obj) OBJECT_CHECK(PnvHomer, (obj), TYPE_PNV8_HOMER)
+#define TYPE_PNV9_HOMER TYPE_PNV_HOMER "-POWER9"
+#define PNV9_HOMER(obj) OBJECT_CHECK(PnvHomer, (obj), TYPE_PNV9_HOMER)
+
+typedef struct PnvHomer {
+    DeviceState parent;
+
+    struct PnvChip *chip;
+    MemoryRegion regs;
+} PnvHomer;
+
+#define PNV_HOMER_CLASS(klass)   \
+     OBJECT_CLASS_CHECK(PnvHomerClass, (klass), TYPE_PNV_HOMER)
+#define PNV_HOMER_GET_CLASS(obj) \
+     OBJECT_GET_CLASS(PnvHomerClass, (obj), TYPE_PNV_HOMER)
+
+typedef struct PnvHomerClass {
+    DeviceClass parent_class;
+
+    int homer_size;
+    const MemoryRegionOps *homer_ops;
+
+    hwaddr core_max_base;
+} PnvHomerClass;
+
+#endif /* PPC_PNV_HOMER_H */
-- 
2.14.5



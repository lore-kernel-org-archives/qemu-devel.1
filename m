Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15362C49ED6
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 07:12:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E27932084D
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 07:12:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E27932084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7aKQ-0004ZC-0j
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 03:12:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45963)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bala24@linux.ibm.com>) id 1i7aJ7-00038g-5Q
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 03:11:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bala24@linux.ibm.com>) id 1i7aJ5-0005Nz-OH
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 03:11:21 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36278
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <bala24@linux.ibm.com>)
 id 1i7aJ5-0005Nk-K5
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 03:11:19 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x8A77Wj9069328
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 03:11:19 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2ux6hu9bq2-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 03:11:18 -0400
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <bala24@linux.ibm.com>;
 Tue, 10 Sep 2019 08:11:17 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 10 Sep 2019 08:11:14 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x8A7BD9l57540628
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Sep 2019 07:11:13 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 46E364C05E;
 Tue, 10 Sep 2019 07:11:13 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A44F04C063;
 Tue, 10 Sep 2019 07:11:11 +0000 (GMT)
Received: from localhost.in.ibm.com (unknown [9.124.35.221])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Tue, 10 Sep 2019 07:11:11 +0000 (GMT)
From: Balamuruhan S <bala24@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Date: Tue, 10 Sep 2019 12:40:18 +0530
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20190910071019.16689-1-bala24@linux.ibm.com>
References: <20190910071019.16689-1-bala24@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19091007-0028-0000-0000-0000039A5D57
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19091007-0029-0000-0000-0000245CBF4E
Message-Id: <20190910071019.16689-3-bala24@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-09-10_06:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1909100071
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: [Qemu-devel] [PATCH v1 2/3] hw/ppc/pnv_occ: add sram device model
 for occ common area
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
 Balamuruhan S <bala24@linux.ibm.com>, anju@linux.vnet.ibm.com, clg@kaod.org,
 hari@linux.vnet.ibm.com, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

emulate occ common area region with occ sram device model which
occ and skiboot uses it to communicate regarding sensors, slw
and HWMON in PowerNV emulated host.

Signed-off-by: Balamuruhan S <bala24@linux.ibm.com>
---
 hw/ppc/pnv.c             |  8 +++++
 hw/ppc/pnv_occ.c         | 78 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/hw/ppc/pnv_occ.h |  3 ++
 3 files changed, 89 insertions(+)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 3f08db7b9e..80338ffe87 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -938,6 +938,10 @@ static void pnv_chip_power8_realize(DeviceState *dev, Error **errp)
         return;
     }
     pnv_xscom_add_subregion(chip, PNV_XSCOM_OCC_BASE, &chip8->occ.xscom_regs);
+
+    /* OCC SRAM model */
+    memory_region_add_subregion(get_system_memory(), PNV_OCC_COMMON_AREA(chip),
+                                &chip8->occ.sram_regs);
 }
 
 static void pnv_chip_power8e_class_init(ObjectClass *klass, void *data)
@@ -1126,6 +1130,10 @@ static void pnv_chip_power9_realize(DeviceState *dev, Error **errp)
         return;
     }
     pnv_xscom_add_subregion(chip, PNV9_XSCOM_OCC_BASE, &chip9->occ.xscom_regs);
+
+    /* OCC SRAM model */
+    memory_region_add_subregion(get_system_memory(), PNV9_OCC_COMMON_AREA(chip),
+                                &chip9->occ.sram_regs);
 }
 
 static void pnv_chip_power9_class_init(ObjectClass *klass, void *data)
diff --git a/hw/ppc/pnv_occ.c b/hw/ppc/pnv_occ.c
index 8bead2c930..785653bb67 100644
--- a/hw/ppc/pnv_occ.c
+++ b/hw/ppc/pnv_occ.c
@@ -30,6 +30,24 @@
 #define OCB_OCI_OCCMISC_AND     0x4021
 #define OCB_OCI_OCCMISC_OR      0x4022
 
+/* OCC sensors */
+#define OCC_SENSOR_DATA_BLOCK_OFFSET          0x580000
+#define OCC_SENSOR_DATA_VALID                 0x580001
+#define OCC_SENSOR_DATA_VERSION               0x580002
+#define OCC_SENSOR_DATA_READING_VERSION       0x580004
+#define OCC_SENSOR_DATA_NR_SENSORS            0x580008
+#define OCC_SENSOR_DATA_NAMES_OFFSET          0x580010
+#define OCC_SENSOR_DATA_READING_PING_OFFSET   0x580014
+#define OCC_SENSOR_DATA_READING_PONG_OFFSET   0x58000c
+#define OCC_SENSOR_DATA_NAME_LENGTH           0x58000d
+#define OCC_SENSOR_NAME_STRUCTURE_TYPE        0x580023
+#define OCC_SENSOR_LOC_CORE                   0x580022
+#define OCC_SENSOR_LOC_GPU                    0x580020
+#define OCC_SENSOR_TYPE_POWER                 0x580003
+#define OCC_SENSOR_NAME                       0x580005
+#define HWMON_SENSORS_MASK                    0x58001e
+#define SLW_IMAGE_BASE                        0x0
+
 static void pnv_occ_set_misc(PnvOCC *occ, uint64_t val)
 {
     bool irq_state;
@@ -82,6 +100,48 @@ static void pnv_occ_power8_xscom_write(void *opaque, hwaddr addr,
     }
 }
 
+static uint64_t pnv_occ_common_area_read(void *opaque, hwaddr addr,
+                                         unsigned width)
+{
+    switch (addr) {
+    /*
+     * occ-sensor sanity check that asserts the sensor
+     * header block
+     */
+    case OCC_SENSOR_DATA_BLOCK_OFFSET:
+    case OCC_SENSOR_DATA_VALID:
+    case OCC_SENSOR_DATA_VERSION:
+    case OCC_SENSOR_DATA_READING_VERSION:
+    case OCC_SENSOR_DATA_NR_SENSORS:
+    case OCC_SENSOR_DATA_NAMES_OFFSET:
+    case OCC_SENSOR_DATA_READING_PING_OFFSET:
+    case OCC_SENSOR_DATA_READING_PONG_OFFSET:
+    case OCC_SENSOR_NAME_STRUCTURE_TYPE:
+        return 1;
+    case OCC_SENSOR_DATA_NAME_LENGTH:
+        return 0x30;
+    case OCC_SENSOR_LOC_CORE:
+        return 0x0040;
+    case OCC_SENSOR_TYPE_POWER:
+        return 0x0080;
+    case OCC_SENSOR_NAME:
+        return 0x1000;
+    case HWMON_SENSORS_MASK:
+    case OCC_SENSOR_LOC_GPU:
+        return 0x8e00;
+    case SLW_IMAGE_BASE:
+        return 0x1000000000000000;
+    }
+    return 0;
+}
+
+static void pnv_occ_common_area_write(void *opaque, hwaddr addr,
+                                             uint64_t val, unsigned width)
+{
+    /* callback function defined to occ common area write */
+    return;
+}
+
 static const MemoryRegionOps pnv_occ_power8_xscom_ops = {
     .read = pnv_occ_power8_xscom_read,
     .write = pnv_occ_power8_xscom_write,
@@ -92,12 +152,24 @@ static const MemoryRegionOps pnv_occ_power8_xscom_ops = {
     .endianness = DEVICE_BIG_ENDIAN,
 };
 
+const MemoryRegionOps pnv_occ_sram_ops = {
+    .read = pnv_occ_common_area_read,
+    .write = pnv_occ_common_area_write,
+    .valid.min_access_size = 1,
+    .valid.max_access_size = 8,
+    .impl.min_access_size = 1,
+    .impl.max_access_size = 8,
+    .endianness = DEVICE_BIG_ENDIAN,
+};
+
 static void pnv_occ_power8_class_init(ObjectClass *klass, void *data)
 {
     PnvOCCClass *poc = PNV_OCC_CLASS(klass);
 
     poc->xscom_size = PNV_XSCOM_OCC_SIZE;
+    poc->sram_size = PNV_OCC_COMMON_AREA_SIZE;
     poc->xscom_ops = &pnv_occ_power8_xscom_ops;
+    poc->sram_ops = &pnv_occ_sram_ops;
     poc->psi_irq = PSIHB_IRQ_OCC;
 }
 
@@ -168,7 +240,9 @@ static void pnv_occ_power9_class_init(ObjectClass *klass, void *data)
     PnvOCCClass *poc = PNV_OCC_CLASS(klass);
 
     poc->xscom_size = PNV9_XSCOM_OCC_SIZE;
+    poc->sram_size = PNV9_OCC_COMMON_AREA_SIZE;
     poc->xscom_ops = &pnv_occ_power9_xscom_ops;
+    poc->sram_ops = &pnv_occ_sram_ops;
     poc->psi_irq = PSIHB9_IRQ_OCC;
 }
 
@@ -199,6 +273,10 @@ static void pnv_occ_realize(DeviceState *dev, Error **errp)
     /* XScom region for OCC registers */
     pnv_xscom_region_init(&occ->xscom_regs, OBJECT(dev), poc->xscom_ops,
                           occ, "xscom-occ", poc->xscom_size);
+
+    /* XScom region for OCC SRAM registers */
+    pnv_xscom_region_init(&occ->sram_regs, OBJECT(dev), poc->sram_ops,
+                          occ, "occ-common-area", poc->sram_size);
 }
 
 static void pnv_occ_class_init(ObjectClass *klass, void *data)
diff --git a/include/hw/ppc/pnv_occ.h b/include/hw/ppc/pnv_occ.h
index ed0709bfc0..66b0989be6 100644
--- a/include/hw/ppc/pnv_occ.h
+++ b/include/hw/ppc/pnv_occ.h
@@ -38,6 +38,7 @@ typedef struct PnvOCC {
     PnvPsi *psi;
 
     MemoryRegion xscom_regs;
+    MemoryRegion sram_regs;
 } PnvOCC;
 
 #define PNV_OCC_CLASS(klass) \
@@ -49,7 +50,9 @@ typedef struct PnvOCCClass {
     DeviceClass parent_class;
 
     int xscom_size;
+    int sram_size;
     const MemoryRegionOps *xscom_ops;
+    const MemoryRegionOps *sram_ops;
     int psi_irq;
 } PnvOCCClass;
 
-- 
2.14.5



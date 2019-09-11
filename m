Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01543C49ED6
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 14:35:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEF65207FC
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 14:35:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEF65207FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i83i1-0006RT-6O
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 10:35:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42430)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bala24@linux.ibm.com>) id 1i83dh-0002Ge-Oj
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 10:30:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bala24@linux.ibm.com>) id 1i83dg-0006wF-CI
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 10:30:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:5728
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <bala24@linux.ibm.com>)
 id 1i83dg-0006vq-6J
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 10:30:32 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x8BENpIK045132
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2019 10:30:31 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2uy1y022cc-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2019 10:30:31 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <bala24@linux.ibm.com>;
 Wed, 11 Sep 2019 15:30:29 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 11 Sep 2019 15:30:27 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x8BEUQH852690990
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 11 Sep 2019 14:30:26 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3F716A406B;
 Wed, 11 Sep 2019 14:30:26 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 41F76A4069;
 Wed, 11 Sep 2019 14:30:24 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.85.70.190])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed, 11 Sep 2019 14:30:24 +0000 (GMT)
From: Balamuruhan S <bala24@linux.ibm.com>
To: qemu-devel@nongnu.org
Date: Wed, 11 Sep 2019 19:59:23 +0530
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20190911142925.19197-1-bala24@linux.ibm.com>
References: <20190911142925.19197-1-bala24@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
x-cbid: 19091114-4275-0000-0000-000003648005
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19091114-4276-0000-0000-00003876D7F1
Message-Id: <20190911142925.19197-3-bala24@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-09-11_08:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1909110135
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
 mx0a-001b2d01.pphosted.com id x8BENpIK045132
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: [Qemu-devel] [PATCH v2 2/4] hw/ppc/pnv_occ: add sram device model
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
 Balamuruhan S <bala24@linux.ibm.com>, anju@linux.vnet.ibm.com,
 qemu-ppc@nongnu.org, clg@kaod.org, hari@linux.vnet.ibm.com,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

emulate occ common area region with occ sram device model which
occ and skiboot uses it to communicate regarding sensors, slw
and HWMON in PowerNV emulated host.

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: Balamuruhan S <bala24@linux.ibm.com>
---
 hw/ppc/pnv.c             |  8 +++++
 hw/ppc/pnv_occ.c         | 78 ++++++++++++++++++++++++++++++++++++++++++=
++++++
 include/hw/ppc/pnv_occ.h |  3 ++
 3 files changed, 89 insertions(+)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 3f08db7b9e..80338ffe87 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -938,6 +938,10 @@ static void pnv_chip_power8_realize(DeviceState *dev=
, Error **errp)
         return;
     }
     pnv_xscom_add_subregion(chip, PNV_XSCOM_OCC_BASE, &chip8->occ.xscom_=
regs);
+
+    /* OCC SRAM model */
+    memory_region_add_subregion(get_system_memory(), PNV_OCC_COMMON_AREA=
(chip),
+                                &chip8->occ.sram_regs);
 }
=20
 static void pnv_chip_power8e_class_init(ObjectClass *klass, void *data)
@@ -1126,6 +1130,10 @@ static void pnv_chip_power9_realize(DeviceState *d=
ev, Error **errp)
         return;
     }
     pnv_xscom_add_subregion(chip, PNV9_XSCOM_OCC_BASE, &chip9->occ.xscom=
_regs);
+
+    /* OCC SRAM model */
+    memory_region_add_subregion(get_system_memory(), PNV9_OCC_COMMON_ARE=
A(chip),
+                                &chip9->occ.sram_regs);
 }
=20
 static void pnv_chip_power9_class_init(ObjectClass *klass, void *data)
diff --git a/hw/ppc/pnv_occ.c b/hw/ppc/pnv_occ.c
index 8bead2c930..785653bb67 100644
--- a/hw/ppc/pnv_occ.c
+++ b/hw/ppc/pnv_occ.c
@@ -30,6 +30,24 @@
 #define OCB_OCI_OCCMISC_AND     0x4021
 #define OCB_OCI_OCCMISC_OR      0x4022
=20
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
@@ -82,6 +100,48 @@ static void pnv_occ_power8_xscom_write(void *opaque, =
hwaddr addr,
     }
 }
=20
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
+                                             uint64_t val, unsigned widt=
h)
+{
+    /* callback function defined to occ common area write */
+    return;
+}
+
 static const MemoryRegionOps pnv_occ_power8_xscom_ops =3D {
     .read =3D pnv_occ_power8_xscom_read,
     .write =3D pnv_occ_power8_xscom_write,
@@ -92,12 +152,24 @@ static const MemoryRegionOps pnv_occ_power8_xscom_op=
s =3D {
     .endianness =3D DEVICE_BIG_ENDIAN,
 };
=20
+const MemoryRegionOps pnv_occ_sram_ops =3D {
+    .read =3D pnv_occ_common_area_read,
+    .write =3D pnv_occ_common_area_write,
+    .valid.min_access_size =3D 1,
+    .valid.max_access_size =3D 8,
+    .impl.min_access_size =3D 1,
+    .impl.max_access_size =3D 8,
+    .endianness =3D DEVICE_BIG_ENDIAN,
+};
+
 static void pnv_occ_power8_class_init(ObjectClass *klass, void *data)
 {
     PnvOCCClass *poc =3D PNV_OCC_CLASS(klass);
=20
     poc->xscom_size =3D PNV_XSCOM_OCC_SIZE;
+    poc->sram_size =3D PNV_OCC_COMMON_AREA_SIZE;
     poc->xscom_ops =3D &pnv_occ_power8_xscom_ops;
+    poc->sram_ops =3D &pnv_occ_sram_ops;
     poc->psi_irq =3D PSIHB_IRQ_OCC;
 }
=20
@@ -168,7 +240,9 @@ static void pnv_occ_power9_class_init(ObjectClass *kl=
ass, void *data)
     PnvOCCClass *poc =3D PNV_OCC_CLASS(klass);
=20
     poc->xscom_size =3D PNV9_XSCOM_OCC_SIZE;
+    poc->sram_size =3D PNV9_OCC_COMMON_AREA_SIZE;
     poc->xscom_ops =3D &pnv_occ_power9_xscom_ops;
+    poc->sram_ops =3D &pnv_occ_sram_ops;
     poc->psi_irq =3D PSIHB9_IRQ_OCC;
 }
=20
@@ -199,6 +273,10 @@ static void pnv_occ_realize(DeviceState *dev, Error =
**errp)
     /* XScom region for OCC registers */
     pnv_xscom_region_init(&occ->xscom_regs, OBJECT(dev), poc->xscom_ops,
                           occ, "xscom-occ", poc->xscom_size);
+
+    /* XScom region for OCC SRAM registers */
+    pnv_xscom_region_init(&occ->sram_regs, OBJECT(dev), poc->sram_ops,
+                          occ, "occ-common-area", poc->sram_size);
 }
=20
 static void pnv_occ_class_init(ObjectClass *klass, void *data)
diff --git a/include/hw/ppc/pnv_occ.h b/include/hw/ppc/pnv_occ.h
index ed0709bfc0..66b0989be6 100644
--- a/include/hw/ppc/pnv_occ.h
+++ b/include/hw/ppc/pnv_occ.h
@@ -38,6 +38,7 @@ typedef struct PnvOCC {
     PnvPsi *psi;
=20
     MemoryRegion xscom_regs;
+    MemoryRegion sram_regs;
 } PnvOCC;
=20
 #define PNV_OCC_CLASS(klass) \
@@ -49,7 +50,9 @@ typedef struct PnvOCCClass {
     DeviceClass parent_class;
=20
     int xscom_size;
+    int sram_size;
     const MemoryRegionOps *xscom_ops;
+    const MemoryRegionOps *sram_ops;
     int psi_irq;
 } PnvOCCClass;
=20
--=20
2.14.5



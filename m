Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA3ACA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 13:14:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E99B2089C
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 13:14:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E99B2089C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMXVy-0006jq-RD
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 09:14:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34490)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iMXUC-0005O1-FI
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 09:12:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iMXUA-0003pF-FG
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 09:12:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:23900)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iMXU8-0003oC-Op
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 09:12:34 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x9LD99ch104354
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 09:12:31 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2vsbftwbje-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 09:12:31 -0400
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <clg@kaod.org>;
 Mon, 21 Oct 2019 14:12:28 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
 by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 21 Oct 2019 14:12:24 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id x9LDCNGt17105246
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 21 Oct 2019 13:12:23 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B4662A405C;
 Mon, 21 Oct 2019 13:12:23 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 95690A405F;
 Mon, 21 Oct 2019 13:12:23 +0000 (GMT)
Received: from smtp.tls.ibm.com (unknown [9.101.4.1])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon, 21 Oct 2019 13:12:23 +0000 (GMT)
Received: from yukon.kaod.org.ibmuc.com (sig-9-145-86-58.uk.ibm.com
 [9.145.86.58])
 by smtp.tls.ibm.com (Postfix) with ESMTP id DA40F2201BC;
 Mon, 21 Oct 2019 15:12:22 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH 1/5] ppc/pnv: Add a PNOR model
Date: Mon, 21 Oct 2019 15:12:11 +0200
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191021131215.3693-1-clg@kaod.org>
References: <20191021131215.3693-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
x-cbid: 19102113-0012-0000-0000-0000035AF16B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19102113-0013-0000-0000-0000219618A8
Message-Id: <20191021131215.3693-2-clg@kaod.org>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-10-21_04:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910210128
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
 mx0a-001b2d01.pphosted.com id x9LD99ch104354
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.156.1
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
Cc: qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@fr.ibm.com>, qemu-ppc@nongnu.org,
 Joel Stanley <joel@jms.id.au>, "Marty E . Plummer" <hanetzer@startmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: C=C3=A9dric Le Goater <clg@fr.ibm.com>

On a POWERPC PowerNV system, the host firmware is stored in a PNOR
flash chip which contents is mapped on the LPC bus. This model adds a
simple dummy device to map the contents of a block device in the host
address space.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/ppc/pnv.h      |   3 +
 include/hw/ppc/pnv_pnor.h |  25 +++++++
 hw/ppc/pnv.c              |  14 ++++
 hw/ppc/pnv_pnor.c         | 135 ++++++++++++++++++++++++++++++++++++++
 hw/ppc/Makefile.objs      |   4 +-
 5 files changed, 180 insertions(+), 1 deletion(-)
 create mode 100644 include/hw/ppc/pnv_pnor.h
 create mode 100644 hw/ppc/pnv_pnor.c

diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index 5e01a9f3df95..e2f20f2b0bc4 100644
--- a/include/hw/ppc/pnv.h
+++ b/include/hw/ppc/pnv.h
@@ -24,6 +24,7 @@
 #include "hw/sysbus.h"
 #include "hw/ipmi/ipmi.h"
 #include "hw/ppc/pnv_lpc.h"
+#include "hw/ppc/pnv_pnor.h"
 #include "hw/ppc/pnv_psi.h"
 #include "hw/ppc/pnv_occ.h"
 #include "hw/ppc/pnv_homer.h"
@@ -173,6 +174,8 @@ typedef struct PnvMachineState {
=20
     IPMIBmc      *bmc;
     Notifier     powerdown_notifier;
+
+    PnvPnor      *pnor;
 } PnvMachineState;
=20
 static inline bool pnv_chip_is_power9(const PnvChip *chip)
diff --git a/include/hw/ppc/pnv_pnor.h b/include/hw/ppc/pnv_pnor.h
new file mode 100644
index 000000000000..dec811695c8d
--- /dev/null
+++ b/include/hw/ppc/pnv_pnor.h
@@ -0,0 +1,25 @@
+/*
+ * QEMU PowerNV PNOR simple model
+ *
+ * Copyright (c) 2019, IBM Corporation.
+ *
+ * This code is licensed under the GPL version 2 or later. See the
+ * COPYING file in the top-level directory.
+ */
+#ifndef _PPC_PNV_PNOR_H
+#define _PPC_PNV_PNOR_H
+
+#define TYPE_PNV_PNOR  "pnv-pnor"
+#define PNV_PNOR(obj)  OBJECT_CHECK(PnvPnor, (obj), TYPE_PNV_PNOR)
+
+typedef struct PnvPnor {
+    SysBusDevice   parent_obj;
+
+    BlockBackend   *blk;
+
+    uint8_t        *storage;
+    uint32_t       size;
+    MemoryRegion   mmio;
+} PnvPnor;
+
+#endif /* _PPC_PNV_PNOR_H */
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 1a22dfd46031..b74528eba42a 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -44,6 +44,7 @@
 #include "hw/ppc/xics.h"
 #include "hw/qdev-properties.h"
 #include "hw/ppc/pnv_xscom.h"
+#include "hw/ppc/pnv_pnor.h"
=20
 #include "hw/isa/isa.h"
 #include "hw/boards.h"
@@ -633,6 +634,8 @@ static void pnv_init(MachineState *machine)
     long fw_size;
     int i;
     char *chip_typename;
+    DriveInfo *pnor =3D drive_get(IF_MTD, 0, 0);
+    DeviceState *dev;
=20
     /* allocate RAM */
     if (machine->ram_size < (1 * GiB)) {
@@ -644,6 +647,17 @@ static void pnv_init(MachineState *machine)
                                          machine->ram_size);
     memory_region_add_subregion(get_system_memory(), 0, ram);
=20
+    /*
+     * Create our simple PNOR device
+     */
+    dev =3D qdev_create(NULL, TYPE_PNV_PNOR);
+    if (pnor) {
+        qdev_prop_set_drive(dev, "drive", blk_by_legacy_dinfo(pnor),
+                            &error_abort);
+    }
+    qdev_init_nofail(dev);
+    pnv->pnor =3D PNV_PNOR(dev);
+
     /* load skiboot firmware  */
     if (bios_name =3D=3D NULL) {
         bios_name =3D FW_FILE_NAME;
diff --git a/hw/ppc/pnv_pnor.c b/hw/ppc/pnv_pnor.c
new file mode 100644
index 000000000000..bfb1e92b0392
--- /dev/null
+++ b/hw/ppc/pnv_pnor.c
@@ -0,0 +1,135 @@
+/*
+ * QEMU PowerNV PNOR simple model
+ *
+ * Copyright (c) 2015-2019, IBM Corporation.
+ *
+ * This code is licensed under the GPL version 2 or later. See the
+ * COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qemu/error-report.h"
+#include "qemu/log.h"
+#include "sysemu/block-backend.h"
+#include "sysemu/blockdev.h"
+#include "hw/loader.h"
+#include "hw/ppc/pnv_pnor.h"
+#include "hw/qdev-properties.h"
+
+static uint64_t pnv_pnor_read(void *opaque, hwaddr addr, unsigned size)
+{
+    PnvPnor *s =3D PNV_PNOR(opaque);
+    uint64_t ret =3D 0;
+    int i;
+
+    for (i =3D 0; i < size; i++) {
+        ret |=3D (uint64_t) s->storage[addr + i] << (8 * (size - i - 1))=
;
+    }
+
+    return ret;
+}
+
+static void pnv_pnor_update(PnvPnor *s, int offset, int size)
+{
+    int offset_end;
+
+    if (s->blk) {
+        return;
+    }
+
+    offset_end =3D offset + size;
+    offset =3D QEMU_ALIGN_DOWN(offset, BDRV_SECTOR_SIZE);
+    offset_end =3D QEMU_ALIGN_UP(offset_end, BDRV_SECTOR_SIZE);
+
+    blk_pwrite(s->blk, offset, s->storage + offset,
+               offset_end - offset, 0);
+}
+
+static void pnv_pnor_write(void *opaque, hwaddr addr, uint64_t data,
+                           unsigned size)
+{
+    PnvPnor *s =3D PNV_PNOR(opaque);
+    int i;
+
+    for (i =3D 0; i < size; i++) {
+        s->storage[addr + i] =3D (data >> (8 * (size - i - 1))) & 0xFF;
+    }
+    pnv_pnor_update(s, addr, size);
+}
+
+/*
+ * TODO: Check endianness: skiboot is BIG, Aspeed AHB is LITTLE, flash
+ * is BIG.
+ */
+static const MemoryRegionOps pnv_pnor_ops =3D {
+    .read =3D pnv_pnor_read,
+    .write =3D pnv_pnor_write,
+    .endianness =3D DEVICE_BIG_ENDIAN,
+    .valid =3D {
+        .min_access_size =3D 1,
+        .max_access_size =3D 4,
+    },
+};
+
+static void pnv_pnor_realize(DeviceState *dev, Error **errp)
+{
+    PnvPnor *s =3D PNV_PNOR(dev);
+    int ret;
+
+    if (s->blk) {
+        uint64_t perm =3D BLK_PERM_CONSISTENT_READ |
+                        (blk_is_read_only(s->blk) ? 0 : BLK_PERM_WRITE);
+        ret =3D blk_set_perm(s->blk, perm, BLK_PERM_ALL, errp);
+        if (ret < 0) {
+            return;
+        }
+
+        s->size =3D blk_getlength(s->blk);
+        if (s->size <=3D 0) {
+            error_setg(errp, "failed to get flash size");
+            return;
+        }
+
+        s->storage =3D blk_blockalign(s->blk, s->size);
+
+        if (blk_pread(s->blk, 0, s->storage, s->size) !=3D s->size) {
+            error_setg(errp, "failed to read the initial flash content")=
;
+            return;
+        }
+    } else {
+        s->storage =3D blk_blockalign(NULL, s->size);
+        memset(s->storage, 0xFF, s->size);
+    }
+
+    memory_region_init_io(&s->mmio, OBJECT(s), &pnv_pnor_ops, s,
+                          TYPE_PNV_PNOR, s->size);
+}
+
+static Property pnv_pnor_properties[] =3D {
+    DEFINE_PROP_UINT32("size", PnvPnor, size, 128 << 20),
+    DEFINE_PROP_DRIVE("drive", PnvPnor, blk),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void pnv_pnor_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+
+    dc->realize =3D pnv_pnor_realize;
+    dc->props =3D pnv_pnor_properties;
+}
+
+static const TypeInfo pnv_pnor_info =3D {
+    .name          =3D TYPE_PNV_PNOR,
+    .parent        =3D TYPE_SYS_BUS_DEVICE,
+    .instance_size =3D sizeof(PnvPnor),
+    .class_init    =3D pnv_pnor_class_init,
+};
+
+static void pnv_pnor_register_types(void)
+{
+    type_register_static(&pnv_pnor_info);
+}
+
+type_init(pnv_pnor_register_types)
diff --git a/hw/ppc/Makefile.objs b/hw/ppc/Makefile.objs
index 580bb4f0dd4c..101e9fc59185 100644
--- a/hw/ppc/Makefile.objs
+++ b/hw/ppc/Makefile.objs
@@ -9,7 +9,9 @@ obj-$(CONFIG_PSERIES) +=3D spapr_tpm_proxy.o
 obj-$(CONFIG_SPAPR_RNG) +=3D  spapr_rng.o
 # IBM PowerNV
 obj-$(CONFIG_POWERNV) +=3D pnv.o pnv_xscom.o pnv_core.o pnv_lpc.o pnv_ps=
i.o pnv_occ.o pnv_bmc.o
-obj-$(CONFIG_POWERNV) +=3D pnv_homer.o
+obj-$(CONFIG_POWERNV) +=3D pnv_homer.o pnv_pnor.o
+
+
 ifeq ($(CONFIG_PCI)$(CONFIG_PSERIES)$(CONFIG_LINUX), yyy)
 obj-y +=3D spapr_pci_vfio.o spapr_pci_nvlink2.o
 endif
--=20
2.21.0



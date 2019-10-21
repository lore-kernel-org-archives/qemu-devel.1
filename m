Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFFA8CA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 13:14:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7228A214AE
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 13:14:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7228A214AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMXW0-0006kN-OE
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 09:14:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34546)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iMXUF-0005RI-9R
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 09:12:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iMXUC-0003qn-ON
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 09:12:39 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48620)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iMXUC-0003pN-Ek
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 09:12:36 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x9LD8WXW105059
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 09:12:34 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2vsd2qgw16-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 09:12:33 -0400
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <clg@kaod.org>;
 Mon, 21 Oct 2019 14:12:31 +0100
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 21 Oct 2019 14:12:27 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id x9LDBsMf13697520
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 21 Oct 2019 13:11:54 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 744D711C05C;
 Mon, 21 Oct 2019 13:12:26 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5DE7011C050;
 Mon, 21 Oct 2019 13:12:26 +0000 (GMT)
Received: from smtp.tls.ibm.com (unknown [9.101.4.1])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon, 21 Oct 2019 13:12:26 +0000 (GMT)
Received: from yukon.kaod.org.ibmuc.com (sig-9-145-86-58.uk.ibm.com
 [9.145.86.58])
 by smtp.tls.ibm.com (Postfix) with ESMTP id A40C92201BC;
 Mon, 21 Oct 2019 15:12:25 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH 5/5] ppc/pnv: Read the PNOR partition table
Date: Mon, 21 Oct 2019 15:12:15 +0200
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191021131215.3693-1-clg@kaod.org>
References: <20191021131215.3693-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
x-cbid: 19102113-0008-0000-0000-00000324ECD6
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19102113-0009-0000-0000-00004A4414D0
Message-Id: <20191021131215.3693-6-clg@kaod.org>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-10-21_04:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=9 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910210128
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
 mx0a-001b2d01.pphosted.com id x9LD8WXW105059
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

This patch adds the logic to read the partition table of a PNOR file
and a routine to load the PAYLOAD (skiboot) partition in the machine
memory.

Code based on the libflash of skiboot:

    https://github.com/open-power/skiboot/blob/master/libflash/

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/ppc/ffs.h      | 150 ++++++++++++++++++++++++++++++++++++
 include/hw/ppc/pnv_pnor.h |   6 ++
 hw/ppc/pnv.c              |  33 +++++---
 hw/ppc/pnv_pnor.c         | 156 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 334 insertions(+), 11 deletions(-)
 create mode 100644 include/hw/ppc/ffs.h

diff --git a/include/hw/ppc/ffs.h b/include/hw/ppc/ffs.h
new file mode 100644
index 000000000000..15216cf2389b
--- /dev/null
+++ b/include/hw/ppc/ffs.h
@@ -0,0 +1,150 @@
+/*
+ * Copyright 2013-2014 IBM Corp.
+ *
+ * Licensed under the Apache License, Version 2.0 (the "License");
+ * you may not use this file except in compliance with the License.
+ * You may obtain a copy of the License at
+ *
+ *      http://www.apache.org/licenses/LICENSE-2.0
+ *
+ * Unless required by applicable law or agreed to in writing, software
+ * distributed under the License is distributed on an "AS IS" BASIS,
+ * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
+ * implied.
+ * See the License for the specific language governing permissions and
+ * limitations under the License.
+ */
+/*
+ * Copyright (c) International Business Machines Corp., 2012
+ *
+ * FSP Flash Structure
+ *
+ * This header defines the layout for the FSP Flash Structure.
+ */
+
+#ifndef FFS_H
+#define FFS_H
+
+#include <stdint.h>
+
+/* The version of this partition implementation */
+#define FFS_VERSION_1   1
+
+/* Magic number for the partition header (ASCII 'PART') */
+#define FFS_MAGIC       0x50415254
+
+/* The maximum length of the partition name */
+#define PART_NAME_MAX   15
+
+/*
+ * Sizes of the data structures
+ */
+#define FFS_HDR_SIZE   sizeof(struct ffs_hdr)
+#define FFS_ENTRY_SIZE sizeof(struct ffs_entry)
+
+/*
+ * Sizes of the data structures w/o checksum
+ */
+#define FFS_HDR_SIZE_CSUM   (FFS_HDR_SIZE - sizeof(uint32_t))
+#define FFS_ENTRY_SIZE_CSUM (FFS_ENTRY_SIZE - sizeof(uint32_t))
+
+/* pid of logical partitions/containers */
+#define FFS_PID_TOPLEVEL   0xFFFFFFFF
+
+/*
+ * Type of image contained w/in partition
+ */
+enum type {
+        FFS_TYPE_DATA      =3D 1,
+        FFS_TYPE_LOGICAL   =3D 2,
+        FFS_TYPE_PARTITION =3D 3,
+};
+
+/*
+ * Flag bit definitions
+ */
+#define FFS_FLAGS_PROTECTED     0x0001
+#define FFS_FLAGS_U_BOOT_ENV    0x0002
+
+/* Data integrity flags */
+#define FFS_ENRY_INTEG_ECC 0x8000
+
+/**
+ * struct ffs_entry_user - User data enties
+ *
+ *  @chip:              Chip Select (0,1)
+ *  @compressType:      Compression Indication/alg (0=3Dnot compressed)
+ *  @dataInteg:         Indicates Data Integrity mechanism
+ *  @verCheck:          Indicates Version check type
+ *  @miscFlags:         Misc Partition related Flags
+ *  @freeMisc[2]:       Unused Miscellaneious Info
+ *  @freeUser[14]:      Unused User Data
+ */
+struct ffs_entry_user {
+        uint8_t  chip;
+        uint8_t  compresstype;
+        uint16_t datainteg;
+        uint8_t  vercheck;
+        uint8_t  miscflags;
+        uint8_t  freemisc[2];
+        uint32_t reserved[14];
+};
+
+/**
+ * struct ffs_entry - Partition entry
+ *
+ * @name:       Opaque null terminated string
+ * @base:       Starting offset of partition in flash (in hdr.block_size=
)
+ * @size:       Partition size (in hdr.block_size)
+ * @pid:        Parent partition entry (FFS_PID_TOPLEVEL for toplevel)
+ * @id:         Partition entry ID [1..65536]
+ * @type:       Describe type of partition
+ * @flags:      Partition attributes (optional)
+ * @actual:     Actual partition size (in bytes)
+ * @resvd:      Reserved words for future use
+ * @user:       User data (optional)
+ * @checksum:   Partition entry checksum (includes all above)
+ */
+struct ffs_entry {
+        char     name[PART_NAME_MAX + 1];
+        uint32_t base;
+        uint32_t size;
+        uint32_t pid;
+        uint32_t id;
+        uint32_t type;
+        uint32_t flags;
+        uint32_t actual;
+        uint32_t resvd[4];
+        struct ffs_entry_user user;
+        uint32_t checksum;
+} __attribute__ ((packed));
+
+/**
+ * struct ffs_hdr - FSP Flash Structure header
+ *
+ * @magic:              Eye catcher/corruption detector
+ * @version:            Version of the structure
+ * @size:               Size of partition table (in block_size)
+ * @entry_size:         Size of struct ffs_entry element (in bytes)
+ * @entry_count:        Number of struct ffs_entry elements in @entries =
array
+ * @block_size:         Size of block on device (in bytes)
+ * @block_count:        Number of blocks on device
+ * @resvd:              Reserved words for future use
+ * @checksum:           Header checksum
+ * @entries:            Pointer to array of partition entries
+ */
+struct ffs_hdr {
+        uint32_t         magic;
+        uint32_t         version;
+        uint32_t         size;
+        uint32_t         entry_size;
+        uint32_t         entry_count;
+        uint32_t         block_size;
+        uint32_t         block_count;
+        uint32_t         resvd[4];
+        uint32_t         checksum;
+        struct ffs_entry entries[];
+} __attribute__ ((packed));
+
+
+#endif /* FFS_H */
diff --git a/include/hw/ppc/pnv_pnor.h b/include/hw/ppc/pnv_pnor.h
index c3dd28643cae..14ec06038f3e 100644
--- a/include/hw/ppc/pnv_pnor.h
+++ b/include/hw/ppc/pnv_pnor.h
@@ -25,6 +25,12 @@ typedef struct PnvPnor {
     uint8_t        *storage;
     uint32_t       size;
     MemoryRegion   mmio;
+
+    uint32_t       skiboot_addr;
+    uint32_t       skiboot_size;
 } PnvPnor;
=20
+extern int pnv_pnor_load_skiboot(PnvPnor *pnor, hwaddr addr, size_t max_=
size,
+                                 Error **errp);
+
 #endif /* _PPC_PNV_PNOR_H */
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 7019273f1cdd..8cc792dee25d 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -637,6 +637,7 @@ static void pnv_init(MachineState *machine)
     char *chip_typename;
     DriveInfo *pnor =3D drive_get(IF_MTD, 0, 0);
     DeviceState *dev;
+    bool load_skiboot_from_pnor =3D false;
=20
     /* allocate RAM */
     if (machine->ram_size < (1 * GiB)) {
@@ -659,23 +660,33 @@ static void pnv_init(MachineState *machine)
     qdev_init_nofail(dev);
     pnv->pnor =3D PNV_PNOR(dev);
=20
-    /* load skiboot firmware  */
+    /*
+     * Try to load skiboot from pnor if no 'bios' was provided on the
+     * command line. skiboot will load the kernel and initramfs from
+     * the PNOR.
+     */
     if (bios_name =3D=3D NULL) {
         bios_name =3D FW_FILE_NAME;
+        load_skiboot_from_pnor =3D !!pnor;
     }
=20
-    fw_filename =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
-    if (!fw_filename) {
-        error_report("Could not find OPAL firmware '%s'", bios_name);
-        exit(1);
-    }
+    if (load_skiboot_from_pnor) {
+        pnv_pnor_load_skiboot(pnv->pnor, FW_LOAD_ADDR, FW_MAX_SIZE,
+                              &error_fatal);
+    } else {
+        fw_filename =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
+        if (!fw_filename) {
+            error_report("Could not find OPAL firmware '%s'", bios_name)=
;
+            exit(1);
+        }
=20
-    fw_size =3D load_image_targphys(fw_filename, FW_LOAD_ADDR, FW_MAX_SI=
ZE);
-    if (fw_size < 0) {
-        error_report("Could not load OPAL firmware '%s'", fw_filename);
-        exit(1);
+        fw_size =3D load_image_targphys(fw_filename, FW_LOAD_ADDR, FW_MA=
X_SIZE);
+        if (fw_size < 0) {
+            error_report("Could not load OPAL firmware '%s'", fw_filenam=
e);
+            exit(1);
+        }
+        g_free(fw_filename);
     }
-    g_free(fw_filename);
=20
     /* load kernel */
     if (machine->kernel_filename) {
diff --git a/hw/ppc/pnv_pnor.c b/hw/ppc/pnv_pnor.c
index bfb1e92b0392..c29bf7eea197 100644
--- a/hw/ppc/pnv_pnor.c
+++ b/hw/ppc/pnv_pnor.c
@@ -14,8 +14,161 @@
 #include "sysemu/block-backend.h"
 #include "sysemu/blockdev.h"
 #include "hw/loader.h"
+#include "hw/ppc/ffs.h"
 #include "hw/ppc/pnv_pnor.h"
 #include "hw/qdev-properties.h"
+#include "libxz/xz.h"
+
+static uint32_t ffs_checksum(void *data, size_t size)
+{
+    uint32_t i, csum =3D 0;
+
+    for (i =3D csum =3D 0; i < (size / 4); i++) {
+        csum ^=3D ((uint32_t *)data)[i];
+    }
+    return csum;
+}
+
+static int ffs_check_convert_header(struct ffs_hdr *dst, struct ffs_hdr =
*src)
+{
+    dst->magic =3D be32_to_cpu(src->magic);
+    if (dst->magic !=3D FFS_MAGIC) {
+        return -1;
+    }
+    dst->version =3D be32_to_cpu(src->version);
+    if (dst->version !=3D FFS_VERSION_1) {
+        return -1;
+    }
+    if (ffs_checksum(src, FFS_HDR_SIZE) !=3D 0) {
+        return -1;
+    }
+    dst->size =3D be32_to_cpu(src->size);
+    dst->entry_size =3D be32_to_cpu(src->entry_size);
+    dst->entry_count =3D be32_to_cpu(src->entry_count);
+    dst->block_size =3D be32_to_cpu(src->block_size);
+    dst->block_count =3D be32_to_cpu(src->block_count);
+
+    return 0;
+}
+
+static int ffs_check_convert_entry(struct ffs_entry *dst, struct ffs_ent=
ry *src)
+{
+    if (ffs_checksum(src, FFS_ENTRY_SIZE) !=3D 0) {
+        return -1;
+    }
+
+    memcpy(dst->name, src->name, sizeof(dst->name));
+    dst->base =3D be32_to_cpu(src->base);
+    dst->size =3D be32_to_cpu(src->size);
+    dst->pid =3D be32_to_cpu(src->pid);
+    dst->id =3D be32_to_cpu(src->id);
+    dst->type =3D be32_to_cpu(src->type);
+    dst->flags =3D be32_to_cpu(src->flags);
+    dst->actual =3D be32_to_cpu(src->actual);
+    dst->user.datainteg =3D be16_to_cpu(src->user.datainteg);
+
+    return 0;
+}
+
+static int decompress(void *dst, size_t dst_size, void *src, size_t src_=
size,
+                      Error **errp)
+{
+    struct xz_dec *s;
+    struct xz_buf b;
+    int ret =3D 0;
+
+    /* Initialize the xz library first */
+    xz_crc32_init();
+    s =3D xz_dec_init(XZ_SINGLE, 0);
+    if (!s) {
+        error_report("failed to initialize xz");
+        return -1;
+    }
+
+    b.in =3D src;
+    b.in_pos =3D 0;
+    b.in_size =3D src_size;
+    b.out =3D dst;
+    b.out_pos =3D 0;
+    b.out_size =3D dst_size;
+
+    /* Start decompressing */
+    ret =3D xz_dec_run(s, &b);
+    if (ret !=3D XZ_STREAM_END) {
+        error_setg(errp, "failed to decompress : %d", ret);
+        ret =3D -1;
+    } else {
+        ret =3D 0;
+    }
+
+    /* Clean up memory */
+    xz_dec_end(s);
+    return ret;
+}
+
+int pnv_pnor_load_skiboot(PnvPnor *s, hwaddr addr, size_t max_size,
+                          Error **errp)
+{
+    int rc;
+    void *buffer =3D g_malloc0(max_size);
+
+    rc =3D decompress(buffer, max_size, &s->storage[s->skiboot_addr],
+                    s->skiboot_size, errp);
+    if (rc =3D=3D 0) {
+        rom_add_blob_fixed("pnor.skiboot", buffer, max_size, addr);
+    }
+    g_free(buffer);
+    return rc;
+}
+
+#define SECUREBOOT_HEADER_MAGIC    0x17082011
+#define SECUREBOOT_HEADER_SIZE     4096
+
+static void pnv_pnor_find_skiboot(PnvPnor *s, Error **errp)
+{
+    uint8_t *storage =3D s->storage;
+    struct ffs_hdr hdr;
+    struct ffs_entry ent;
+    uint32_t magic;
+    uint32_t i;
+    int rc;
+
+    rc =3D ffs_check_convert_header(&hdr, (struct ffs_hdr *) storage);
+    if (rc) {
+        error_setg(errp, "bad header");
+        return;
+    }
+
+    for (i =3D 0; i < hdr.entry_count; i++) {
+        uint32_t esize =3D hdr.entry_size;
+        uint32_t offset =3D FFS_HDR_SIZE + i * esize;
+        struct ffs_entry *src_ent =3D (struct ffs_entry *)(storage + off=
set);
+
+        rc =3D ffs_check_convert_entry(&ent, src_ent);
+        if (rc) {
+            error_report("bad partition entry %d", i);
+            continue;
+        }
+
+        if (strcmp("PAYLOAD", ent.name)) {
+            continue;
+        }
+
+        s->skiboot_addr =3D ent.base * 0x1000,
+        s->skiboot_size =3D ent.size * 0x1000;
+
+        /* Check for secure boot header */
+        magic =3D be32_to_cpu(*(uint32_t *)&s->storage[s->skiboot_addr])=
;
+        if (magic =3D=3D SECUREBOOT_HEADER_MAGIC) {
+            s->skiboot_addr +=3D SECUREBOOT_HEADER_SIZE;
+            s->skiboot_size -=3D SECUREBOOT_HEADER_SIZE;
+        }
+
+        return;
+    }
+
+    error_setg(errp, "pnv_pnor: no skiboot partition !?");
+}
=20
 static uint64_t pnv_pnor_read(void *opaque, hwaddr addr, unsigned size)
 {
@@ -97,6 +250,9 @@ static void pnv_pnor_realize(DeviceState *dev, Error *=
*errp)
             error_setg(errp, "failed to read the initial flash content")=
;
             return;
         }
+
+        /* Read partitions to validate contents */
+        pnv_pnor_find_skiboot(s, errp);
     } else {
         s->storage =3D blk_blockalign(NULL, s->size);
         memset(s->storage, 0xFF, s->size);
--=20
2.21.0



Return-Path: <SRS0=eB96=XC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C7E5C43331
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Sep 2019 00:23:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 510A120854
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Sep 2019 00:23:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 510A120854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6OVd-000466-GA
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 20:23:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42546)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mjrosato@linux.ibm.com>) id 1i6OPH-0006sR-Th
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 20:16:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mjrosato@linux.ibm.com>) id 1i6OPE-0002p4-BE
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 20:16:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:20298)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mjrosato@linux.ibm.com>)
 id 1i6OPB-0002mp-Ob; Fri, 06 Sep 2019 20:16:42 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x8707CIv017557; Fri, 6 Sep 2019 20:16:35 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2uunksyuae-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 06 Sep 2019 20:16:34 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x8707D1m017601;
 Fri, 6 Sep 2019 20:16:34 -0400
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com
 [169.63.121.186])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2uunksyua6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 06 Sep 2019 20:16:34 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
 by ppma03wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x8709OwY017723;
 Sat, 7 Sep 2019 00:16:33 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28]) by ppma03wdc.us.ibm.com with ESMTP id 2uqgh7errb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 07 Sep 2019 00:16:33 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com
 [9.57.199.108])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x870GW1P7602538
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 7 Sep 2019 00:16:32 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D32F6B2065;
 Sat,  7 Sep 2019 00:16:32 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5614DB205F;
 Sat,  7 Sep 2019 00:16:32 +0000 (GMT)
Received: from oc4221205838.ibm.com (unknown [9.85.134.207])
 by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
 Sat,  7 Sep 2019 00:16:32 +0000 (GMT)
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: cohuck@redhat.com
Date: Fri,  6 Sep 2019 20:16:26 -0400
Message-Id: <1567815389-18229-3-git-send-email-mjrosato@linux.ibm.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1567815389-18229-1-git-send-email-mjrosato@linux.ibm.com>
References: <1567815389-18229-1-git-send-email-mjrosato@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-09-06_11:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1909070000
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: [Qemu-devel] [PATCH v3 2/5] s390: PCI: Creation a header dedicated
 to PCI CLP
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
Cc: walling@linux.ibm.com, alex.williamson@redhat.com, pmorel@linux.ibm.com,
 david@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, pasic@linux.ibm.com,
 borntraeger@de.ibm.com, qemu-s390x@nongnu.org, pbonzini@redhat.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Pierre Morel <pmorel@linux.ibm.com>

To have a clean separation between s390-pci-bus.h
and s390-pci-inst.h headers we export the PCI CLP
instructions in a dedicated header.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
Reviewed-by: Collin Walling <walling@linux.ibm.com>
---
 hw/s390x/s390-pci-bus.h  |   1 +
 hw/s390x/s390-pci-clp.h  | 211 +++++++++++++++++++++++++++++++++++++++++++++++
 hw/s390x/s390-pci-inst.h | 196 -------------------------------------------
 3 files changed, 212 insertions(+), 196 deletions(-)
 create mode 100644 hw/s390x/s390-pci-clp.h

diff --git a/hw/s390x/s390-pci-bus.h b/hw/s390x/s390-pci-bus.h
index 550f3cc..a5d2049 100644
--- a/hw/s390x/s390-pci-bus.h
+++ b/hw/s390x/s390-pci-bus.h
@@ -19,6 +19,7 @@
 #include "hw/s390x/sclp.h"
 #include "hw/s390x/s390_flic.h"
 #include "hw/s390x/css.h"
+#include "s390-pci-clp.h"
 
 #define TYPE_S390_PCI_HOST_BRIDGE "s390-pcihost"
 #define TYPE_S390_PCI_BUS "s390-pcibus"
diff --git a/hw/s390x/s390-pci-clp.h b/hw/s390x/s390-pci-clp.h
new file mode 100644
index 0000000..e442307
--- /dev/null
+++ b/hw/s390x/s390-pci-clp.h
@@ -0,0 +1,211 @@
+/*
+ * s390 CLPinstruction definitions
+ *
+ * Copyright 2019 IBM Corp.
+ * Author(s): Pierre Morel <pmorel@de.ibm.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or (at
+ * your option) any later version. See the COPYING file in the top-level
+ * directory.
+ */
+
+#ifndef HW_S390_PCI_CLP
+#define HW_S390_PCI_CLP
+
+/* CLP common request & response block size */
+#define CLP_BLK_SIZE 4096
+#define PCI_BAR_COUNT 6
+#define PCI_MAX_FUNCTIONS 4096
+
+typedef struct ClpReqHdr {
+    uint16_t len;
+    uint16_t cmd;
+} QEMU_PACKED ClpReqHdr;
+
+typedef struct ClpRspHdr {
+    uint16_t len;
+    uint16_t rsp;
+} QEMU_PACKED ClpRspHdr;
+
+/* CLP Response Codes */
+#define CLP_RC_OK         0x0010  /* Command request successfully */
+#define CLP_RC_CMD        0x0020  /* Command code not recognized */
+#define CLP_RC_PERM       0x0030  /* Command not authorized */
+#define CLP_RC_FMT        0x0040  /* Invalid command request format */
+#define CLP_RC_LEN        0x0050  /* Invalid command request length */
+#define CLP_RC_8K         0x0060  /* Command requires 8K LPCB */
+#define CLP_RC_RESNOT0    0x0070  /* Reserved field not zero */
+#define CLP_RC_NODATA     0x0080  /* No data available */
+#define CLP_RC_FC_UNKNOWN 0x0100  /* Function code not recognized */
+
+/*
+ * Call Logical Processor - Command Codes
+ */
+#define CLP_LIST_PCI            0x0002
+#define CLP_QUERY_PCI_FN        0x0003
+#define CLP_QUERY_PCI_FNGRP     0x0004
+#define CLP_SET_PCI_FN          0x0005
+
+/* PCI function handle list entry */
+typedef struct ClpFhListEntry {
+    uint16_t device_id;
+    uint16_t vendor_id;
+#define CLP_FHLIST_MASK_CONFIG 0x80000000
+    uint32_t config;
+    uint32_t fid;
+    uint32_t fh;
+} QEMU_PACKED ClpFhListEntry;
+
+#define CLP_RC_SETPCIFN_FH      0x0101 /* Invalid PCI fn handle */
+#define CLP_RC_SETPCIFN_FHOP    0x0102 /* Fn handle not valid for op */
+#define CLP_RC_SETPCIFN_DMAAS   0x0103 /* Invalid DMA addr space */
+#define CLP_RC_SETPCIFN_RES     0x0104 /* Insufficient resources */
+#define CLP_RC_SETPCIFN_ALRDY   0x0105 /* Fn already in requested state */
+#define CLP_RC_SETPCIFN_ERR     0x0106 /* Fn in permanent error state */
+#define CLP_RC_SETPCIFN_RECPND  0x0107 /* Error recovery pending */
+#define CLP_RC_SETPCIFN_BUSY    0x0108 /* Fn busy */
+#define CLP_RC_LISTPCI_BADRT    0x010a /* Resume token not recognized */
+#define CLP_RC_QUERYPCIFG_PFGID 0x010b /* Unrecognized PFGID */
+
+/* request or response block header length */
+#define LIST_PCI_HDR_LEN 32
+
+/* Number of function handles fitting in response block */
+#define CLP_FH_LIST_NR_ENTRIES \
+    ((CLP_BLK_SIZE - 2 * LIST_PCI_HDR_LEN) \
+        / sizeof(ClpFhListEntry))
+
+#define CLP_SET_ENABLE_PCI_FN  0 /* Yes, 0 enables it */
+#define CLP_SET_DISABLE_PCI_FN 1 /* Yes, 1 disables it */
+
+#define CLP_UTIL_STR_LEN 64
+
+#define CLP_MASK_FMT 0xf0000000
+
+/* List PCI functions request */
+typedef struct ClpReqListPci {
+    ClpReqHdr hdr;
+    uint32_t fmt;
+    uint64_t reserved1;
+    uint64_t resume_token;
+    uint64_t reserved2;
+} QEMU_PACKED ClpReqListPci;
+
+/* List PCI functions response */
+typedef struct ClpRspListPci {
+    ClpRspHdr hdr;
+    uint32_t fmt;
+    uint64_t reserved1;
+    uint64_t resume_token;
+    uint32_t mdd;
+    uint16_t max_fn;
+    uint8_t flags;
+    uint8_t entry_size;
+    ClpFhListEntry fh_list[CLP_FH_LIST_NR_ENTRIES];
+} QEMU_PACKED ClpRspListPci;
+
+/* Query PCI function request */
+typedef struct ClpReqQueryPci {
+    ClpReqHdr hdr;
+    uint32_t fmt;
+    uint64_t reserved1;
+    uint32_t fh; /* function handle */
+    uint32_t reserved2;
+    uint64_t reserved3;
+} QEMU_PACKED ClpReqQueryPci;
+
+/* Query PCI function response */
+typedef struct ClpRspQueryPci {
+    ClpRspHdr hdr;
+    uint32_t fmt;
+    uint64_t reserved1;
+    uint16_t vfn; /* virtual fn number */
+#define CLP_RSP_QPCI_MASK_UTIL  0x100
+#define CLP_RSP_QPCI_MASK_PFGID 0xff
+    uint16_t ug;
+    uint32_t fid; /* pci function id */
+    uint8_t bar_size[PCI_BAR_COUNT];
+    uint16_t pchid;
+    uint32_t bar[PCI_BAR_COUNT];
+    uint64_t reserved2;
+    uint64_t sdma; /* start dma as */
+    uint64_t edma; /* end dma as */
+    uint32_t reserved3[11];
+    uint32_t uid;
+    uint8_t util_str[CLP_UTIL_STR_LEN]; /* utility string */
+} QEMU_PACKED ClpRspQueryPci;
+
+/* Query PCI function group request */
+typedef struct ClpReqQueryPciGrp {
+    ClpReqHdr hdr;
+    uint32_t fmt;
+    uint64_t reserved1;
+#define CLP_REQ_QPCIG_MASK_PFGID 0xff
+    uint32_t g;
+    uint32_t reserved2;
+    uint64_t reserved3;
+} QEMU_PACKED ClpReqQueryPciGrp;
+
+/* Query PCI function group response */
+typedef struct ClpRspQueryPciGrp {
+    ClpRspHdr hdr;
+    uint32_t fmt;
+    uint64_t reserved1;
+#define CLP_RSP_QPCIG_MASK_NOI 0xfff
+    uint16_t i;
+    uint8_t version;
+#define CLP_RSP_QPCIG_MASK_FRAME   0x2
+#define CLP_RSP_QPCIG_MASK_REFRESH 0x1
+    uint8_t fr;
+    uint16_t maxstbl;
+    uint16_t mui;
+    uint64_t reserved3;
+    uint64_t dasm; /* dma address space mask */
+    uint64_t msia; /* MSI address */
+    uint64_t reserved4;
+    uint64_t reserved5;
+} QEMU_PACKED ClpRspQueryPciGrp;
+
+/* Set PCI function request */
+typedef struct ClpReqSetPci {
+    ClpReqHdr hdr;
+    uint32_t fmt;
+    uint64_t reserved1;
+    uint32_t fh; /* function handle */
+    uint16_t reserved2;
+    uint8_t oc; /* operation controls */
+    uint8_t ndas; /* number of dma spaces */
+    uint64_t reserved3;
+} QEMU_PACKED ClpReqSetPci;
+
+/* Set PCI function response */
+typedef struct ClpRspSetPci {
+    ClpRspHdr hdr;
+    uint32_t fmt;
+    uint64_t reserved1;
+    uint32_t fh; /* function handle */
+    uint32_t reserved3;
+    uint64_t reserved4;
+} QEMU_PACKED ClpRspSetPci;
+
+typedef struct ClpReqRspListPci {
+    ClpReqListPci request;
+    ClpRspListPci response;
+} QEMU_PACKED ClpReqRspListPci;
+
+typedef struct ClpReqRspSetPci {
+    ClpReqSetPci request;
+    ClpRspSetPci response;
+} QEMU_PACKED ClpReqRspSetPci;
+
+typedef struct ClpReqRspQueryPci {
+    ClpReqQueryPci request;
+    ClpRspQueryPci response;
+} QEMU_PACKED ClpReqRspQueryPci;
+
+typedef struct ClpReqRspQueryPciGrp {
+    ClpReqQueryPciGrp request;
+    ClpRspQueryPciGrp response;
+} QEMU_PACKED ClpReqRspQueryPciGrp;
+
+#endif
diff --git a/hw/s390x/s390-pci-inst.h b/hw/s390x/s390-pci-inst.h
index fa3bf8b..6c4273a 100644
--- a/hw/s390x/s390-pci-inst.h
+++ b/hw/s390x/s390-pci-inst.h
@@ -17,202 +17,6 @@
 #include "s390-pci-bus.h"
 #include "sysemu/dma.h"
 
-/* CLP common request & response block size */
-#define CLP_BLK_SIZE 4096
-#define PCI_BAR_COUNT 6
-#define PCI_MAX_FUNCTIONS 4096
-
-typedef struct ClpReqHdr {
-    uint16_t len;
-    uint16_t cmd;
-} QEMU_PACKED ClpReqHdr;
-
-typedef struct ClpRspHdr {
-    uint16_t len;
-    uint16_t rsp;
-} QEMU_PACKED ClpRspHdr;
-
-/* CLP Response Codes */
-#define CLP_RC_OK         0x0010  /* Command request successfully */
-#define CLP_RC_CMD        0x0020  /* Command code not recognized */
-#define CLP_RC_PERM       0x0030  /* Command not authorized */
-#define CLP_RC_FMT        0x0040  /* Invalid command request format */
-#define CLP_RC_LEN        0x0050  /* Invalid command request length */
-#define CLP_RC_8K         0x0060  /* Command requires 8K LPCB */
-#define CLP_RC_RESNOT0    0x0070  /* Reserved field not zero */
-#define CLP_RC_NODATA     0x0080  /* No data available */
-#define CLP_RC_FC_UNKNOWN 0x0100  /* Function code not recognized */
-
-/*
- * Call Logical Processor - Command Codes
- */
-#define CLP_LIST_PCI            0x0002
-#define CLP_QUERY_PCI_FN        0x0003
-#define CLP_QUERY_PCI_FNGRP     0x0004
-#define CLP_SET_PCI_FN          0x0005
-
-/* PCI function handle list entry */
-typedef struct ClpFhListEntry {
-    uint16_t device_id;
-    uint16_t vendor_id;
-#define CLP_FHLIST_MASK_CONFIG 0x80000000
-    uint32_t config;
-    uint32_t fid;
-    uint32_t fh;
-} QEMU_PACKED ClpFhListEntry;
-
-#define CLP_RC_SETPCIFN_FH      0x0101 /* Invalid PCI fn handle */
-#define CLP_RC_SETPCIFN_FHOP    0x0102 /* Fn handle not valid for op */
-#define CLP_RC_SETPCIFN_DMAAS   0x0103 /* Invalid DMA addr space */
-#define CLP_RC_SETPCIFN_RES     0x0104 /* Insufficient resources */
-#define CLP_RC_SETPCIFN_ALRDY   0x0105 /* Fn already in requested state */
-#define CLP_RC_SETPCIFN_ERR     0x0106 /* Fn in permanent error state */
-#define CLP_RC_SETPCIFN_RECPND  0x0107 /* Error recovery pending */
-#define CLP_RC_SETPCIFN_BUSY    0x0108 /* Fn busy */
-#define CLP_RC_LISTPCI_BADRT    0x010a /* Resume token not recognized */
-#define CLP_RC_QUERYPCIFG_PFGID 0x010b /* Unrecognized PFGID */
-
-/* request or response block header length */
-#define LIST_PCI_HDR_LEN 32
-
-/* Number of function handles fitting in response block */
-#define CLP_FH_LIST_NR_ENTRIES \
-    ((CLP_BLK_SIZE - 2 * LIST_PCI_HDR_LEN) \
-        / sizeof(ClpFhListEntry))
-
-#define CLP_SET_ENABLE_PCI_FN  0 /* Yes, 0 enables it */
-#define CLP_SET_DISABLE_PCI_FN 1 /* Yes, 1 disables it */
-
-#define CLP_UTIL_STR_LEN 64
-
-#define CLP_MASK_FMT 0xf0000000
-
-/* List PCI functions request */
-typedef struct ClpReqListPci {
-    ClpReqHdr hdr;
-    uint32_t fmt;
-    uint64_t reserved1;
-    uint64_t resume_token;
-    uint64_t reserved2;
-} QEMU_PACKED ClpReqListPci;
-
-/* List PCI functions response */
-typedef struct ClpRspListPci {
-    ClpRspHdr hdr;
-    uint32_t fmt;
-    uint64_t reserved1;
-    uint64_t resume_token;
-    uint32_t mdd;
-    uint16_t max_fn;
-    uint8_t flags;
-    uint8_t entry_size;
-    ClpFhListEntry fh_list[CLP_FH_LIST_NR_ENTRIES];
-} QEMU_PACKED ClpRspListPci;
-
-/* Query PCI function request */
-typedef struct ClpReqQueryPci {
-    ClpReqHdr hdr;
-    uint32_t fmt;
-    uint64_t reserved1;
-    uint32_t fh; /* function handle */
-    uint32_t reserved2;
-    uint64_t reserved3;
-} QEMU_PACKED ClpReqQueryPci;
-
-/* Query PCI function response */
-typedef struct ClpRspQueryPci {
-    ClpRspHdr hdr;
-    uint32_t fmt;
-    uint64_t reserved1;
-    uint16_t vfn; /* virtual fn number */
-#define CLP_RSP_QPCI_MASK_UTIL  0x100
-#define CLP_RSP_QPCI_MASK_PFGID 0xff
-    uint16_t ug;
-    uint32_t fid; /* pci function id */
-    uint8_t bar_size[PCI_BAR_COUNT];
-    uint16_t pchid;
-    uint32_t bar[PCI_BAR_COUNT];
-    uint64_t reserved2;
-    uint64_t sdma; /* start dma as */
-    uint64_t edma; /* end dma as */
-    uint32_t reserved3[11];
-    uint32_t uid;
-    uint8_t util_str[CLP_UTIL_STR_LEN]; /* utility string */
-} QEMU_PACKED ClpRspQueryPci;
-
-/* Query PCI function group request */
-typedef struct ClpReqQueryPciGrp {
-    ClpReqHdr hdr;
-    uint32_t fmt;
-    uint64_t reserved1;
-#define CLP_REQ_QPCIG_MASK_PFGID 0xff
-    uint32_t g;
-    uint32_t reserved2;
-    uint64_t reserved3;
-} QEMU_PACKED ClpReqQueryPciGrp;
-
-/* Query PCI function group response */
-typedef struct ClpRspQueryPciGrp {
-    ClpRspHdr hdr;
-    uint32_t fmt;
-    uint64_t reserved1;
-#define CLP_RSP_QPCIG_MASK_NOI 0xfff
-    uint16_t i;
-    uint8_t version;
-#define CLP_RSP_QPCIG_MASK_FRAME   0x2
-#define CLP_RSP_QPCIG_MASK_REFRESH 0x1
-    uint8_t fr;
-    uint16_t maxstbl;
-    uint16_t mui;
-    uint64_t reserved3;
-    uint64_t dasm; /* dma address space mask */
-    uint64_t msia; /* MSI address */
-    uint64_t reserved4;
-    uint64_t reserved5;
-} QEMU_PACKED ClpRspQueryPciGrp;
-
-/* Set PCI function request */
-typedef struct ClpReqSetPci {
-    ClpReqHdr hdr;
-    uint32_t fmt;
-    uint64_t reserved1;
-    uint32_t fh; /* function handle */
-    uint16_t reserved2;
-    uint8_t oc; /* operation controls */
-    uint8_t ndas; /* number of dma spaces */
-    uint64_t reserved3;
-} QEMU_PACKED ClpReqSetPci;
-
-/* Set PCI function response */
-typedef struct ClpRspSetPci {
-    ClpRspHdr hdr;
-    uint32_t fmt;
-    uint64_t reserved1;
-    uint32_t fh; /* function handle */
-    uint32_t reserved3;
-    uint64_t reserved4;
-} QEMU_PACKED ClpRspSetPci;
-
-typedef struct ClpReqRspListPci {
-    ClpReqListPci request;
-    ClpRspListPci response;
-} QEMU_PACKED ClpReqRspListPci;
-
-typedef struct ClpReqRspSetPci {
-    ClpReqSetPci request;
-    ClpRspSetPci response;
-} QEMU_PACKED ClpReqRspSetPci;
-
-typedef struct ClpReqRspQueryPci {
-    ClpReqQueryPci request;
-    ClpRspQueryPci response;
-} QEMU_PACKED ClpReqRspQueryPci;
-
-typedef struct ClpReqRspQueryPciGrp {
-    ClpReqQueryPciGrp request;
-    ClpRspQueryPciGrp response;
-} QEMU_PACKED ClpReqRspQueryPciGrp;
-
 /* Load/Store status codes */
 #define ZPCI_PCI_ST_FUNC_NOT_ENABLED        4
 #define ZPCI_PCI_ST_FUNC_IN_ERR             8
-- 
1.8.3.1



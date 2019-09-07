Return-Path: <SRS0=eB96=XC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74BC2C43331
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Sep 2019 00:18:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C35A20854
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Sep 2019 00:18:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C35A20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6ORL-000076-9p
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 20:18:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42516)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mjrosato@linux.ibm.com>) id 1i6OPF-0006rm-Sy
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 20:16:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mjrosato@linux.ibm.com>) id 1i6OPE-0002pG-Ad
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 20:16:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:11276)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mjrosato@linux.ibm.com>)
 id 1i6OPB-0002mw-Op; Fri, 06 Sep 2019 20:16:42 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x8707HgL071272; Fri, 6 Sep 2019 20:16:35 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2uuvjq1vjh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 06 Sep 2019 20:16:35 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x870AWtn076892;
 Fri, 6 Sep 2019 20:16:34 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com
 [169.47.144.27])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2uuvjq1vj9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 06 Sep 2019 20:16:34 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
 by ppma05wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x8709NpO013240;
 Sat, 7 Sep 2019 00:16:33 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28]) by ppma05wdc.us.ibm.com with ESMTP id 2uu32uw9u2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 07 Sep 2019 00:16:33 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com
 [9.57.199.108])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x870GWf950921828
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 7 Sep 2019 00:16:32 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 45A00B2064;
 Sat,  7 Sep 2019 00:16:32 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C6FFFB205F;
 Sat,  7 Sep 2019 00:16:31 +0000 (GMT)
Received: from oc4221205838.ibm.com (unknown [9.85.134.207])
 by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
 Sat,  7 Sep 2019 00:16:31 +0000 (GMT)
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: cohuck@redhat.com
Date: Fri,  6 Sep 2019 20:16:25 -0400
Message-Id: <1567815389-18229-2-git-send-email-mjrosato@linux.ibm.com>
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
 mlxlogscore=856 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1909070000
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
Subject: [Qemu-devel] [PATCH v3 1/5] vfio: vfio_iommu_type1: linux header
 place holder
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

This should be copied from Linux kernel UAPI includes.
The version used here is Linux 5.3.0

We define a new device region in vfio.h to be able to
get the ZPCI CLP information by reading this region from
userland.

We create a new file, vfio_zdev.h to define the structure
of the new region we defined in vfio.h

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 linux-headers/linux/vfio.h      |  7 ++++---
 linux-headers/linux/vfio_zdev.h | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+), 3 deletions(-)
 create mode 100644 linux-headers/linux/vfio_zdev.h

diff --git a/linux-headers/linux/vfio.h b/linux-headers/linux/vfio.h
index 24f5051..8328c87 100644
--- a/linux-headers/linux/vfio.h
+++ b/linux-headers/linux/vfio.h
@@ -9,8 +9,8 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
-#ifndef VFIO_H
-#define VFIO_H
+#ifndef _UAPIVFIO_H
+#define _UAPIVFIO_H
 
 #include <linux/types.h>
 #include <linux/ioctl.h>
@@ -371,6 +371,7 @@ struct vfio_region_gfx_edid {
  * to do TLB invalidation on a GPU.
  */
 #define VFIO_REGION_SUBTYPE_IBM_NVLINK2_ATSD	(1)
+#define VFIO_REGION_SUBTYPE_ZDEV_CLP		(2)
 
 /*
  * The MSIX mappable capability informs that MSIX data of a BAR can be mmapped
@@ -914,4 +915,4 @@ struct vfio_iommu_spapr_tce_remove {
 
 /* ***************************************************************** */
 
-#endif /* VFIO_H */
+#endif /* _UAPIVFIO_H */
diff --git a/linux-headers/linux/vfio_zdev.h b/linux-headers/linux/vfio_zdev.h
new file mode 100644
index 0000000..2b912a5
--- /dev/null
+++ b/linux-headers/linux/vfio_zdev.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Region definition for ZPCI devices
+ *
+ * Copyright IBM Corp. 2019
+ *
+ * Author(s): Pierre Morel <pmorel@linux.ibm.com>
+ */
+
+#ifndef _VFIO_ZDEV_H_
+#define _VFIO_ZDEV_H_
+
+#include <linux/types.h>
+
+/**
+ * struct vfio_region_zpci_info - ZPCI information.
+ *
+ */
+struct vfio_region_zpci_info {
+	__u64 dasm;
+	__u64 start_dma;
+	__u64 end_dma;
+	__u64 msi_addr;
+	__u64 flags;
+	__u16 pchid;
+	__u16 mui;
+	__u16 noi;
+	__u16 maxstbl;
+	__u8 version;
+	__u8 gid;
+#define VFIO_PCI_ZDEV_FLAGS_REFRESH 1
+	__u8 util_str[];
+} __attribute__ ((__packed__));
+
+#endif
-- 
1.8.3.1



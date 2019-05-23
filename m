Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EFF8C282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 12:27:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 103C720851
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 12:27:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 103C720851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35235 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTmoN-0001TC-AR
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 08:27:07 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45724)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1hTmmV-00087L-0c
	for qemu-devel@nongnu.org; Thu, 23 May 2019 08:25:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1hTmmT-0002Qa-T4
	for qemu-devel@nongnu.org; Thu, 23 May 2019 08:25:10 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59034
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.ibm.com>)
	id 1hTmmT-0002Pt-P9
	for qemu-devel@nongnu.org; Thu, 23 May 2019 08:25:09 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x4NC8vXm091383
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 08:25:08 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2sntaw3h0k-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 08:25:07 -0400
Received: from localhost
	by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.ibm.com>;
	Thu, 23 May 2019 13:25:05 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
	by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
	Authorized Use Only! Violators will be prosecuted; 
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Thu, 23 May 2019 13:25:02 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
	(b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
	by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id x4NCP1KI45875242
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK); Thu, 23 May 2019 12:25:01 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 28757A405F;
	Thu, 23 May 2019 12:25:01 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C0EBFA4054;
	Thu, 23 May 2019 12:25:00 +0000 (GMT)
Received: from morel-ThinkPad-W530.boeblingen.de.ibm.com (unknown
	[9.152.222.40])
	by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Thu, 23 May 2019 12:25:00 +0000 (GMT)
From: Pierre Morel <pmorel@linux.ibm.com>
To: cohuck@redhat.com
Date: Thu, 23 May 2019 14:24:56 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1558614300-24574-1-git-send-email-pmorel@linux.ibm.com>
References: <1558614300-24574-1-git-send-email-pmorel@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19052312-0016-0000-0000-0000027EB35A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19052312-0017-0000-0000-000032DBAA2D
Message-Id: <1558614300-24574-2-git-send-email-pmorel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-05-23_10:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
	priorityscore=1501
	malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
	clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
	mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
	scancount=1 engine=8.0.1-1810050000 definitions=main-1905230087
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: [Qemu-devel] [PATCH v2 1/5] vfio: vfio_iommu_type1: linux header
 place holder
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
Cc: pasic@linux.vnet.ibm.com, mst@redhat.com, qemu-s390x@nongnu.org,
	david@redhat.com, walling@linux.ibm.com, qemu-devel@nongnu.org,
	borntraeger@de.ibm.com, alex.williamson@redhat.com,
	pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This should be copied from Linux kernel UAPI includes.
The version used here is Linux 5.1.0

We define a new device region in vfio.h to be able to
get the ZPCI CLP information by reading this region from
userland.

We create a new file, vfio_zdev.h to define the structure
of the new region we defined in vfio.h

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
---
 linux-headers/linux/vfio.h      | 14 +++++++++++---
 linux-headers/linux/vfio_zdev.h | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+), 3 deletions(-)
 create mode 100644 linux-headers/linux/vfio_zdev.h

diff --git a/linux-headers/linux/vfio.h b/linux-headers/linux/vfio.h
index 12a7b1d..56595b8 100644
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
@@ -306,6 +306,10 @@ struct vfio_region_info_cap_type {
 #define VFIO_REGION_TYPE_GFX                    (1)
 #define VFIO_REGION_SUBTYPE_GFX_EDID            (1)
 
+/* IBM Subtypes */
+#define VFIO_REGION_TYPE_IBM_ZDEV		(1)
+#define VFIO_REGION_SUBTYPE_ZDEV_CLP		(1)
+
 /**
  * struct vfio_region_gfx_edid - EDID region layout.
  *
@@ -353,6 +357,10 @@ struct vfio_region_gfx_edid {
 #define VFIO_DEVICE_GFX_LINK_STATE_DOWN  2
 };
 
+#define VFIO_REGION_TYPE_CCW			(2)
+/* ccw sub-types */
+#define VFIO_REGION_SUBTYPE_CCW_ASYNC_CMD	(1)
+
 /*
  * 10de vendor sub-type
  *
@@ -910,4 +918,4 @@ struct vfio_iommu_spapr_tce_remove {
 
 /* ***************************************************************** */
 
-#endif /* VFIO_H */
+#endif /* _UAPIVFIO_H */
diff --git a/linux-headers/linux/vfio_zdev.h b/linux-headers/linux/vfio_zdev.h
new file mode 100644
index 0000000..84b1a82
--- /dev/null
+++ b/linux-headers/linux/vfio_zdev.h
@@ -0,0 +1,34 @@
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
+	__u8 gid;
+	__u8 version;
+#define VFIO_PCI_ZDEV_FLAGS_REFRESH 1
+	__u8 util_str[CLP_UTIL_STR_LEN];
+} __packed;
+
+#endif
-- 
2.7.4



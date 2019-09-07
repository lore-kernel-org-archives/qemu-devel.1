Return-Path: <SRS0=eB96=XC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE9BC43331
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Sep 2019 00:22:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7FCC20854
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Sep 2019 00:22:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7FCC20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6OUY-0003DZ-UK
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 20:22:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42522)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mjrosato@linux.ibm.com>) id 1i6OPG-0006ru-6Z
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 20:16:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mjrosato@linux.ibm.com>) id 1i6OPE-0002ou-AG
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 20:16:46 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:20944
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mjrosato@linux.ibm.com>)
 id 1i6OPB-0002n8-On; Fri, 06 Sep 2019 20:16:42 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x8707cQw014907; Fri, 6 Sep 2019 20:16:37 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2uv1jrrfbc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 06 Sep 2019 20:16:36 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x870DfC7026094;
 Fri, 6 Sep 2019 20:16:36 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.10])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2uv1jrrfb3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 06 Sep 2019 20:16:36 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
 by ppma02dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x870EcU0010258;
 Sat, 7 Sep 2019 00:16:35 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24]) by ppma02dal.us.ibm.com with ESMTP id 2uqgh828u5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 07 Sep 2019 00:16:35 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com
 [9.57.199.108])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x870GYs636831706
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 7 Sep 2019 00:16:34 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 787F6B205F;
 Sat,  7 Sep 2019 00:16:34 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EA49AB2064;
 Sat,  7 Sep 2019 00:16:33 +0000 (GMT)
Received: from oc4221205838.ibm.com (unknown [9.85.134.207])
 by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
 Sat,  7 Sep 2019 00:16:33 +0000 (GMT)
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: cohuck@redhat.com
Date: Fri,  6 Sep 2019 20:16:29 -0400
Message-Id: <1567815389-18229-6-git-send-email-mjrosato@linux.ibm.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1567815389-18229-1-git-send-email-mjrosato@linux.ibm.com>
References: <1567815389-18229-1-git-send-email-mjrosato@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-09-06_11:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1909070000
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: [Qemu-devel] [PATCH v3 5/5] s390: vfio_pci: Get zPCI function info
 from host
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

We use the VFIO_REGION_SUBTYPE_ZDEV_CLP subregion of
PCI_VENDOR_ID_IBM to retrieve the CLP information the
kernel exports.

To be compatible with previous kernel versions we fall back
on previous predefined values, same as the emulation values,
when the region is not found or when any problem happens
during the search for the information.

Once we retrieved the host device information, we take care to
- use the virtual UID and FID
- Disable all the IOMMU flags we do not support yet.
  Just keeping the refresh bit.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 hw/s390x/s390-pci-bus.c | 83 +++++++++++++++++++++++++++++++++++++++++++++++--
 hw/s390x/s390-pci-bus.h |  2 ++
 2 files changed, 83 insertions(+), 2 deletions(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 0d404c3..5069795 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -15,6 +15,8 @@
 #include "qapi/error.h"
 #include "qapi/visitor.h"
 #include "cpu.h"
+#include "s390-pci-clp.h"
+#include <linux/vfio_zdev.h>
 #include "s390-pci-bus.h"
 #include "s390-pci-inst.h"
 #include "hw/pci/pci_bus.h"
@@ -24,6 +26,9 @@
 #include "qemu/error-report.h"
 #include "qemu/module.h"
 
+#include "hw/vfio/pci.h"
+#include <sys/ioctl.h>
+
 #ifndef DEBUG_S390PCI_BUS
 #define DEBUG_S390PCI_BUS  0
 #endif
@@ -781,6 +786,76 @@ static void set_pbdev_info(S390PCIBusDevice *pbdev)
     pbdev->pci_grp = s390_grp_find(ZPCI_DEFAULT_FN_GRP);
 }
 
+static int get_pbdev_info(S390PCIBusDevice *pbdev)
+{
+    VFIOPCIDevice *vfio_pci;
+    VFIODevice *vdev;
+    struct vfio_region_info *info;
+    CLPRegion *clp_region;
+    int size;
+    int ret;
+
+    vfio_pci = container_of(pbdev->pdev, VFIOPCIDevice, pdev);
+    vdev = &vfio_pci->vbasedev;
+
+    if (vdev->num_regions < VFIO_PCI_NUM_REGIONS + 1) {
+        /* Fall back to old handling */
+        return -ENODEV;
+    }
+
+    ret = vfio_get_dev_region_info(vdev,
+                                   PCI_VENDOR_ID_IBM |
+                                   VFIO_REGION_TYPE_PCI_VENDOR_TYPE,
+                                   VFIO_REGION_SUBTYPE_ZDEV_CLP, &info);
+    if (ret) {
+        /* Fall back to old handling */
+        return -EIO;
+    }
+
+    if (info->size != (sizeof(CLPRegion) + CLP_UTIL_STR_LEN)) {
+        /* Fall back to old handling */
+        g_free(info);
+        return -ENOMEM;
+    }
+    clp_region = g_malloc0(sizeof(*clp_region) + CLP_UTIL_STR_LEN);
+    size = pread(vdev->fd, clp_region, (sizeof(*clp_region) + CLP_UTIL_STR_LEN),
+                 info->offset);
+    if (size != (sizeof(*clp_region) + CLP_UTIL_STR_LEN)) {
+        goto end;
+    }
+
+    pbdev->zpci_fn.fid = pbdev->fid;
+    pbdev->zpci_fn.uid = pbdev->uid;
+    pbdev->zpci_fn.sdma = clp_region->start_dma;
+    pbdev->zpci_fn.edma = clp_region->end_dma;
+    pbdev->zpci_fn.pchid = clp_region->pchid;
+    pbdev->zpci_fn.ug = clp_region->gid;
+    pbdev->pci_grp = s390_grp_find(clp_region->gid);
+
+    if (!pbdev->pci_grp) {
+        ClpRspQueryPciGrp *resgrp;
+
+        pbdev->pci_grp = s390_grp_create(clp_region->gid);
+
+        resgrp = &pbdev->pci_grp->zpci_grp;
+        if (clp_region->flags & VFIO_PCI_ZDEV_FLAGS_REFRESH) {
+            resgrp->fr = 1;
+        }
+        stq_p(&resgrp->dasm, clp_region->dasm);
+        stq_p(&resgrp->msia, clp_region->msi_addr);
+        stw_p(&resgrp->mui, clp_region->mui);
+        stw_p(&resgrp->i, clp_region->noi);
+        /* These two must be queried in a next iteration */
+        stw_p(&resgrp->maxstbl, 128);
+        resgrp->version = 0;
+    }
+
+end:
+    g_free(info);
+    g_free(clp_region);
+    return ret;
+}
+
 static void s390_pcihost_realize(DeviceState *dev, Error **errp)
 {
     PCIBus *b;
@@ -853,7 +928,8 @@ static int s390_pci_msix_init(S390PCIBusDevice *pbdev)
     name = g_strdup_printf("msix-s390-%04x", pbdev->uid);
     memory_region_init_io(&pbdev->msix_notify_mr, OBJECT(pbdev),
                           &s390_msi_ctrl_ops, pbdev, name, PAGE_SIZE);
-    memory_region_add_subregion(&pbdev->iommu->mr, ZPCI_MSI_ADDR,
+    memory_region_add_subregion(&pbdev->iommu->mr,
+                                pbdev->pci_grp->zpci_grp.msia,
                                 &pbdev->msix_notify_mr);
     g_free(name);
 
@@ -1003,12 +1079,15 @@ static void s390_pcihost_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
         pbdev->iommu = s390_pci_get_iommu(s, pci_get_bus(pdev), pdev->devfn);
         pbdev->iommu->pbdev = pbdev;
         pbdev->state = ZPCI_FS_DISABLED;
-        set_pbdev_info(pbdev);
 
         if (object_dynamic_cast(OBJECT(dev), "vfio-pci")) {
             pbdev->fh |= FH_SHM_VFIO;
+            if (get_pbdev_info(pbdev) != 0) {
+                set_pbdev_info(pbdev);
+            }
         } else {
             pbdev->fh |= FH_SHM_EMUL;
+            set_pbdev_info(pbdev);
         }
 
         if (s390_pci_msix_init(pbdev)) {
diff --git a/hw/s390x/s390-pci-bus.h b/hw/s390x/s390-pci-bus.h
index 8c969d1..151e2d0 100644
--- a/hw/s390x/s390-pci-bus.h
+++ b/hw/s390x/s390-pci-bus.h
@@ -320,6 +320,8 @@ typedef struct S390PCIGroup {
 } S390PCIGroup;
 S390PCIGroup *s390_grp_find(int ug);
 
+typedef struct vfio_region_zpci_info CLPRegion;
+
 struct S390PCIBusDevice {
     DeviceState qdev;
     PCIDevice *pdev;
-- 
1.8.3.1



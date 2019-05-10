Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E707C04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 14:44:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15B4021479
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 14:44:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15B4021479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44500 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP6kk-0005tc-EC
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 10:44:02 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47741)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1hP6fz-0001Da-Ha
	for qemu-devel@nongnu.org; Fri, 10 May 2019 10:39:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1hP6fy-0000fm-3e
	for qemu-devel@nongnu.org; Fri, 10 May 2019 10:39:07 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60392)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.ibm.com>)
	id 1hP6fx-0000ek-Sk
	for qemu-devel@nongnu.org; Fri, 10 May 2019 10:39:06 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x4AEZiGp088869
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 10:39:05 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2sdb468ftc-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 10:39:04 -0400
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.ibm.com>;
	Fri, 10 May 2019 15:39:02 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
	by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
	Authorized Use Only! Violators will be prosecuted; 
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Fri, 10 May 2019 15:38:58 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
	[9.149.105.62])
	by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id x4AEcvGO45154430
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK); Fri, 10 May 2019 14:38:57 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3B567AE051;
	Fri, 10 May 2019 14:38:57 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B54DEAE04D;
	Fri, 10 May 2019 14:38:56 +0000 (GMT)
Received: from morel-ThinkPad-W530.boeblingen.de.ibm.com (unknown
	[9.145.187.238])
	by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Fri, 10 May 2019 14:38:56 +0000 (GMT)
From: Pierre Morel <pmorel@linux.ibm.com>
To: cohuck@redhat.com
Date: Fri, 10 May 2019 16:38:53 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1557499133-24169-1-git-send-email-pmorel@linux.ibm.com>
References: <1557499133-24169-1-git-send-email-pmorel@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19051014-0020-0000-0000-0000033B5B8C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19051014-0021-0000-0000-0000218E0893
Message-Id: <1557499133-24169-6-git-send-email-pmorel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-05-09_02:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
	priorityscore=1501
	malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
	clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
	mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
	scancount=1 engine=8.0.1-1810050000 definitions=main-1905100100
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
Subject: [Qemu-devel] [PATCH 5/5] s390: vfio_pci: Get zPCI function info
 from host
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

The VFIO_IOMMU_INFO_CAPABILITIES flag allows to retrieve IOMMU specific
informations from the iommu associated with the zPCI VFIO device.

When we retrieve the host device information, we take care to
- use the virtual UID and FID
- Disable all the IOMMU flags we do not support yet.
  Just keeping the refresh bit.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
---
 hw/s390x/s390-pci-bus.c | 80 +++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 78 insertions(+), 2 deletions(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 6df80aa..3b7539c 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -23,6 +23,9 @@
 #include "hw/pci/msi.h"
 #include "qemu/error-report.h"
 
+#include "hw/vfio/pci.h"
+#include <sys/ioctl.h>
+
 #ifndef DEBUG_S390PCI_BUS
 #define DEBUG_S390PCI_BUS  0
 #endif
@@ -780,6 +783,75 @@ static void set_pbdev_info(S390PCIBusDevice *pbdev)
     pbdev->pci_grp = s390_grp_find(ZPCI_DEFAULT_FN_GRP);
 }
 
+static int s390_fill_zpci(S390PCIBusDevice *pbdev,
+                          struct vfio_info_cap_header *cap)
+{
+    ClpRspQueryPci *rsp_fn;
+    ClpRspQueryPciGrp *rsp_grp;
+    S390PCIGroup *pci_grp;
+
+    /* We expect the function response first */
+    if (cap->id != VFIO_IOMMU_INFO_CAP_QFN) {
+        return -ENODEV;
+    }
+    rsp_fn = (struct ClpRspQueryPci *)(cap + 1);
+    memcpy(&pbdev->zpci_fn, rsp_fn, sizeof(*rsp_fn));
+    /* We use the virtualized FID and UID */
+    pbdev->zpci_fn.fid = pbdev->fid;
+    pbdev->zpci_fn.uid = pbdev->uid;
+
+    cap = (struct vfio_info_cap_header *)((char *)cap + cap->next);
+    if (cap->id != VFIO_IOMMU_INFO_CAP_QGRP) {
+        return -ENODEV;
+    }
+    pci_grp = s390_grp_find(rsp_fn->ug);
+    if (!pci_grp) {
+        pci_grp = s390_grp_create(rsp_fn->ug);
+    }
+
+    rsp_grp = (struct ClpRspQueryPciGrp *)(cap + 1);
+
+    memcpy(&pci_grp->zpci_grp, rsp_grp, sizeof(*rsp_grp));
+    /* We only support the refresh bit */
+    pci_grp->zpci_grp.fr = 1;
+
+    pbdev->pci_grp = pci_grp;
+
+    return 0;
+}
+
+static int get_pbdev_info(S390PCIBusDevice *pbdev)
+{
+    VFIOPCIDevice *vfio_pci;
+    int fd;
+    int ret;
+    struct vfio_iommu_type1_info *info;
+    int size;
+
+    vfio_pci = container_of(pbdev->pdev, VFIOPCIDevice, pdev);
+    fd = vfio_pci->vbasedev.group->container->fd;
+    info = g_malloc0(sizeof(*info));
+    info->flags = VFIO_IOMMU_INFO_CAPABILITIES;
+    info->argsz = sizeof(*info);
+    ret = ioctl(fd, VFIO_IOMMU_GET_INFO, info);
+    if (ret) {
+        return ret;
+    }
+    size = info->argsz;
+    info = g_realloc(info, size);
+    info->flags = VFIO_IOMMU_INFO_CAPABILITIES;
+    info->argsz = size;
+    ret = ioctl(fd, VFIO_IOMMU_GET_INFO, info);
+    if (ret) {
+        return ret;
+    }
+    /* Fill zPCI parameters maxstbl, start dma, end dma...*/
+    /* using the caps */
+    ret = s390_fill_zpci(pbdev, (struct vfio_info_cap_header *)(info + 1));
+    g_free(info);
+    return ret;
+}
+
 static void s390_pcihost_realize(DeviceState *dev, Error **errp)
 {
     PCIBus *b;
@@ -852,7 +924,8 @@ static int s390_pci_msix_init(S390PCIBusDevice *pbdev)
     name = g_strdup_printf("msix-s390-%04x", pbdev->uid);
     memory_region_init_io(&pbdev->msix_notify_mr, OBJECT(pbdev),
                           &s390_msi_ctrl_ops, pbdev, name, PAGE_SIZE);
-    memory_region_add_subregion(&pbdev->iommu->mr, ZPCI_MSI_ADDR,
+    memory_region_add_subregion(&pbdev->iommu->mr,
+                                pbdev->pci_grp->zpci_grp.msia,
                                 &pbdev->msix_notify_mr);
     g_free(name);
 
@@ -1002,12 +1075,15 @@ static void s390_pcihost_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
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
-- 
2.7.4



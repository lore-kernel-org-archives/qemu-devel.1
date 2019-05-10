Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D860C04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 14:41:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C85AB21479
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 14:41:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C85AB21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44472 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP6hy-00039H-1c
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 10:41:10 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47702)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1hP6fy-0001D2-4B
	for qemu-devel@nongnu.org; Fri, 10 May 2019 10:39:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1hP6fx-0000eN-1d
	for qemu-devel@nongnu.org; Fri, 10 May 2019 10:39:06 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58518
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.ibm.com>)
	id 1hP6fw-0000du-TG
	for qemu-devel@nongnu.org; Fri, 10 May 2019 10:39:04 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x4AEa9NI029800
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 10:39:04 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2sdb4a0ht8-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 10:39:04 -0400
Received: from localhost
	by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.ibm.com>;
	Fri, 10 May 2019 15:39:02 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
	by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
	Authorized Use Only! Violators will be prosecuted; 
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Fri, 10 May 2019 15:38:58 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
	[9.149.105.62])
	by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id x4AEcuhT55771264
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK); Fri, 10 May 2019 14:38:56 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A40F1AE051;
	Fri, 10 May 2019 14:38:56 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2BCF9AE04D;
	Fri, 10 May 2019 14:38:56 +0000 (GMT)
Received: from morel-ThinkPad-W530.boeblingen.de.ibm.com (unknown
	[9.145.187.238])
	by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Fri, 10 May 2019 14:38:56 +0000 (GMT)
From: Pierre Morel <pmorel@linux.ibm.com>
To: cohuck@redhat.com
Date: Fri, 10 May 2019 16:38:52 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1557499133-24169-1-git-send-email-pmorel@linux.ibm.com>
References: <1557499133-24169-1-git-send-email-pmorel@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19051014-0028-0000-0000-0000036C5E46
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19051014-0029-0000-0000-0000242BE4A0
Message-Id: <1557499133-24169-5-git-send-email-pmorel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-05-09_02:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
	priorityscore=1501
	malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
	clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
	mlxlogscore=852 adultscore=0 classifier=spam adjust=0 reason=mlx
	scancount=1 engine=8.0.1-1810050000 definitions=main-1905100100
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: [Qemu-devel] [PATCH 4/5] s390: vfio_pci: Use a PCI Function
 structure
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

 We use a ClpRspQueryPci structure to hold the information
related to zPCI Function.

This allows us to be ready to support different zPCI functions
and to retrieve the zPCI function information from the host.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
---
 hw/s390x/s390-pci-bus.c  | 22 +++++++++++++++++-----
 hw/s390x/s390-pci-bus.h  |  1 +
 hw/s390x/s390-pci-inst.c |  8 ++------
 3 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 175ea8c..6df80aa 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -769,6 +769,17 @@ static void s390_pci_init_default_group(void)
     resgrp->version = 0;
 }
 
+static void set_pbdev_info(S390PCIBusDevice *pbdev)
+{
+    pbdev->zpci_fn.sdma = ZPCI_SDMA_ADDR;
+    pbdev->zpci_fn.edma = ZPCI_EDMA_ADDR;
+    pbdev->zpci_fn.pchid = 0;
+    pbdev->zpci_fn.ug = ZPCI_DEFAULT_FN_GRP;
+    pbdev->zpci_fn.fid = pbdev->fid;
+    pbdev->zpci_fn.uid = pbdev->uid;
+    pbdev->pci_grp = s390_grp_find(ZPCI_DEFAULT_FN_GRP);
+}
+
 static void s390_pcihost_realize(DeviceState *dev, Error **errp)
 {
     PCIBus *b;
@@ -987,17 +998,18 @@ static void s390_pcihost_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
             }
         }
 
+        pbdev->pdev = pdev;
+        pbdev->iommu = s390_pci_get_iommu(s, pci_get_bus(pdev), pdev->devfn);
+        pbdev->iommu->pbdev = pbdev;
+        pbdev->state = ZPCI_FS_DISABLED;
+        set_pbdev_info(pbdev);
+
         if (object_dynamic_cast(OBJECT(dev), "vfio-pci")) {
             pbdev->fh |= FH_SHM_VFIO;
         } else {
             pbdev->fh |= FH_SHM_EMUL;
         }
 
-        pbdev->pdev = pdev;
-        pbdev->iommu = s390_pci_get_iommu(s, pci_get_bus(pdev), pdev->devfn);
-        pbdev->iommu->pbdev = pbdev;
-        pbdev->state = ZPCI_FS_DISABLED;
-
         if (s390_pci_msix_init(pbdev)) {
             error_setg(errp, "MSI-X support is mandatory "
                        "in the S390 architecture");
diff --git a/hw/s390x/s390-pci-bus.h b/hw/s390x/s390-pci-bus.h
index e95a797..8c969d1 100644
--- a/hw/s390x/s390-pci-bus.h
+++ b/hw/s390x/s390-pci-bus.h
@@ -337,6 +337,7 @@ struct S390PCIBusDevice {
     uint16_t noi;
     uint8_t sum;
     S390PCIGroup *pci_grp;
+    ClpRspQueryPci zpci_fn;
     S390MsixInfo msix;
     AdapterRoutes routes;
     S390PCIIOMMU *iommu;
diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
index 8147847..68ca240 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -267,6 +267,8 @@ int clp_service_call(S390CPU *cpu, uint8_t r2, uintptr_t ra)
             goto out;
         }
 
+        memcpy(resquery, &pbdev->zpci_fn, sizeof(*resquery));
+
         for (i = 0; i < PCI_BAR_COUNT; i++) {
             uint32_t data = pci_get_long(pbdev->pdev->config +
                 PCI_BASE_ADDRESS_0 + (i * 4));
@@ -280,12 +282,6 @@ int clp_service_call(S390CPU *cpu, uint8_t r2, uintptr_t ra)
                     resquery->bar_size[i]);
         }
 
-        stq_p(&resquery->sdma, ZPCI_SDMA_ADDR);
-        stq_p(&resquery->edma, ZPCI_EDMA_ADDR);
-        stl_p(&resquery->fid, pbdev->fid);
-        stw_p(&resquery->pchid, 0);
-        stw_p(&resquery->ug, ZPCI_DEFAULT_FN_GRP);
-        stl_p(&resquery->uid, pbdev->uid);
         stw_p(&resquery->hdr.rsp, CLP_RC_OK);
         break;
     }
-- 
2.7.4



Return-Path: <SRS0=eB96=XC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 462B2C00307
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Sep 2019 00:18:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22AB120854
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Sep 2019 00:18:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22AB120854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6ORL-00006V-Tu
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 20:18:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42521)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mjrosato@linux.ibm.com>) id 1i6OPG-0006rt-62
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 20:16:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mjrosato@linux.ibm.com>) id 1i6OPE-0002p7-B3
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 20:16:46 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:29358
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mjrosato@linux.ibm.com>)
 id 1i6OPB-0002mq-Oe; Fri, 06 Sep 2019 20:16:42 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x8707ceA014864; Fri, 6 Sep 2019 20:16:35 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2uv1jrrfaw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 06 Sep 2019 20:16:35 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x87099Qx017900;
 Fri, 6 Sep 2019 20:16:35 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com
 [169.47.144.27])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2uv1jrrfan-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 06 Sep 2019 20:16:34 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
 by ppma05wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x8709N4o013237;
 Sat, 7 Sep 2019 00:16:34 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29]) by ppma05wdc.us.ibm.com with ESMTP id 2uu32uw9u5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 07 Sep 2019 00:16:34 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com
 [9.57.199.108])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x870GXbb52953446
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 7 Sep 2019 00:16:33 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6080FB2065;
 Sat,  7 Sep 2019 00:16:33 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E1DC5B2067;
 Sat,  7 Sep 2019 00:16:32 +0000 (GMT)
Received: from oc4221205838.ibm.com (unknown [9.85.134.207])
 by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
 Sat,  7 Sep 2019 00:16:32 +0000 (GMT)
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: cohuck@redhat.com
Date: Fri,  6 Sep 2019 20:16:27 -0400
Message-Id: <1567815389-18229-4-git-send-email-mjrosato@linux.ibm.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1567815389-18229-1-git-send-email-mjrosato@linux.ibm.com>
References: <1567815389-18229-1-git-send-email-mjrosato@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-09-06_11:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1909070000
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: [Qemu-devel] [PATCH v3 3/5] s390: vfio_pci: Use a PCI Group
 structure
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

We use a S390PCIGroup structure to hold the information
related to zPCI Function group.

This allows us to be ready to support multiple groups and to retrieve
the group information from the host.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
---
 hw/s390x/s390-pci-bus.c  | 42 ++++++++++++++++++++++++++++++++++++++++++
 hw/s390x/s390-pci-bus.h  | 11 ++++++++++-
 hw/s390x/s390-pci-inst.c | 22 +++++++++++++---------
 3 files changed, 65 insertions(+), 10 deletions(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 963a41c..e625217 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -730,6 +730,46 @@ static void s390_pci_iommu_free(S390pciState *s, PCIBus *bus, int32_t devfn)
     object_unref(OBJECT(iommu));
 }
 
+static S390PCIGroup *s390_grp_create(int ug)
+{
+    S390PCIGroup *grp;
+    S390pciState *s = s390_get_phb();
+
+    grp = g_new0(S390PCIGroup, 1);
+    grp->ug = ug;
+    QTAILQ_INSERT_TAIL(&s->zpci_grps, grp, link);
+    return grp;
+}
+
+S390PCIGroup *s390_grp_find(int ug)
+{
+    S390PCIGroup *grp;
+    S390pciState *s = s390_get_phb();
+
+    QTAILQ_FOREACH(grp, &s->zpci_grps, link) {
+        if ((grp->ug & CLP_REQ_QPCIG_MASK_PFGID) == ug) {
+            return grp;
+        }
+    }
+    return NULL;
+}
+
+static void s390_pci_init_default_group(void)
+{
+    S390PCIGroup *grp;
+    ClpRspQueryPciGrp *resgrp;
+
+    grp = s390_grp_create(ZPCI_DEFAULT_FN_GRP);
+    resgrp = &grp->zpci_grp;
+    resgrp->fr = 1;
+    stq_p(&resgrp->dasm, 0);
+    stq_p(&resgrp->msia, ZPCI_MSI_ADDR);
+    stw_p(&resgrp->mui, DEFAULT_MUI);
+    stw_p(&resgrp->i, 128);
+    stw_p(&resgrp->maxstbl, 128);
+    resgrp->version = 0;
+}
+
 static void s390_pcihost_realize(DeviceState *dev, Error **errp)
 {
     PCIBus *b;
@@ -766,7 +806,9 @@ static void s390_pcihost_realize(DeviceState *dev, Error **errp)
     s->bus_no = 0;
     QTAILQ_INIT(&s->pending_sei);
     QTAILQ_INIT(&s->zpci_devs);
+    QTAILQ_INIT(&s->zpci_grps);
 
+    s390_pci_init_default_group();
     css_register_io_adapters(CSS_IO_ADAPTER_PCI, true, false,
                              S390_ADAPTER_SUPPRESSIBLE, &local_err);
     error_propagate(errp, local_err);
diff --git a/hw/s390x/s390-pci-bus.h b/hw/s390x/s390-pci-bus.h
index a5d2049..e95a797 100644
--- a/hw/s390x/s390-pci-bus.h
+++ b/hw/s390x/s390-pci-bus.h
@@ -312,6 +312,14 @@ typedef struct ZpciFmb {
 } ZpciFmb;
 QEMU_BUILD_BUG_MSG(offsetof(ZpciFmb, fmt0) != 48, "padding in ZpciFmb");
 
+#define ZPCI_DEFAULT_FN_GRP 0x20
+typedef struct S390PCIGroup {
+    ClpRspQueryPciGrp zpci_grp;
+    int ug;
+    QTAILQ_ENTRY(S390PCIGroup) link;
+} S390PCIGroup;
+S390PCIGroup *s390_grp_find(int ug);
+
 struct S390PCIBusDevice {
     DeviceState qdev;
     PCIDevice *pdev;
@@ -327,8 +335,8 @@ struct S390PCIBusDevice {
     QEMUTimer *fmb_timer;
     uint8_t isc;
     uint16_t noi;
-    uint16_t maxstbl;
     uint8_t sum;
+    S390PCIGroup *pci_grp;
     S390MsixInfo msix;
     AdapterRoutes routes;
     S390PCIIOMMU *iommu;
@@ -353,6 +361,7 @@ typedef struct S390pciState {
     GHashTable *zpci_table;
     QTAILQ_HEAD(, SeiContainer) pending_sei;
     QTAILQ_HEAD(, S390PCIBusDevice) zpci_devs;
+    QTAILQ_HEAD(, S390PCIGroup) zpci_grps;
 } S390pciState;
 
 S390pciState *s390_get_phb(void);
diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
index 4b3bd4a..00dd176 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -284,21 +284,25 @@ int clp_service_call(S390CPU *cpu, uint8_t r2, uintptr_t ra)
         stq_p(&resquery->edma, ZPCI_EDMA_ADDR);
         stl_p(&resquery->fid, pbdev->fid);
         stw_p(&resquery->pchid, 0);
-        stw_p(&resquery->ug, 1);
+        stw_p(&resquery->ug, ZPCI_DEFAULT_FN_GRP);
         stl_p(&resquery->uid, pbdev->uid);
         stw_p(&resquery->hdr.rsp, CLP_RC_OK);
         break;
     }
     case CLP_QUERY_PCI_FNGRP: {
         ClpRspQueryPciGrp *resgrp = (ClpRspQueryPciGrp *)resh;
-        resgrp->fr = 1;
-        stq_p(&resgrp->dasm, 0);
-        stq_p(&resgrp->msia, ZPCI_MSI_ADDR);
-        stw_p(&resgrp->mui, DEFAULT_MUI);
-        stw_p(&resgrp->i, 128);
-        stw_p(&resgrp->maxstbl, 128);
-        resgrp->version = 0;
 
+        ClpReqQueryPciGrp *reqgrp = (ClpReqQueryPciGrp *)reqh;
+        S390PCIGroup *grp;
+
+        grp = s390_grp_find(reqgrp->g);
+        if (!grp) {
+            /* We do not allow access to unknown groups */
+            /* The group must have been obtained with a vfio device */
+            stw_p(&resgrp->hdr.rsp, CLP_RC_QUERYPCIFG_PFGID);
+            goto out;
+        }
+        memcpy(resgrp, &grp->zpci_grp, sizeof(ClpRspQueryPciGrp));
         stw_p(&resgrp->hdr.rsp, CLP_RC_OK);
         break;
     }
@@ -754,7 +758,7 @@ int pcistb_service_call(S390CPU *cpu, uint8_t r1, uint8_t r3, uint64_t gaddr,
     }
     /* Length must be greater than 8, a multiple of 8 */
     /* and not greater than maxstbl */
-    if ((len <= 8) || (len % 8) || (len > pbdev->maxstbl)) {
+    if ((len <= 8) || (len % 8) || (len > pbdev->pci_grp->zpci_grp.maxstbl)) {
         goto specification_error;
     }
     /* Do not cross a 4K-byte boundary */
-- 
1.8.3.1



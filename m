Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EB70C04AB2
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 14:45:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45A0521479
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 14:45:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45A0521479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44548 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP6m6-0006el-Gn
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 10:45:26 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47748)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1hP6fz-0001Dj-Na
	for qemu-devel@nongnu.org; Fri, 10 May 2019 10:39:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1hP6fx-0000fR-TK
	for qemu-devel@nongnu.org; Fri, 10 May 2019 10:39:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37108
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.ibm.com>)
	id 1hP6fx-0000ey-NR
	for qemu-devel@nongnu.org; Fri, 10 May 2019 10:39:05 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x4AEZo4I085916
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 10:39:05 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2sdb4x8d8y-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 10:39:04 -0400
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.ibm.com>;
	Fri, 10 May 2019 15:39:02 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
	by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
	Authorized Use Only! Violators will be prosecuted; 
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Fri, 10 May 2019 15:38:57 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
	[9.149.105.62])
	by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id x4AEcuDj55771262
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK); Fri, 10 May 2019 14:38:56 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1AA33AE045;
	Fri, 10 May 2019 14:38:56 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 98434AE051;
	Fri, 10 May 2019 14:38:55 +0000 (GMT)
Received: from morel-ThinkPad-W530.boeblingen.de.ibm.com (unknown
	[9.145.187.238])
	by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Fri, 10 May 2019 14:38:55 +0000 (GMT)
From: Pierre Morel <pmorel@linux.ibm.com>
To: cohuck@redhat.com
Date: Fri, 10 May 2019 16:38:51 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1557499133-24169-1-git-send-email-pmorel@linux.ibm.com>
References: <1557499133-24169-1-git-send-email-pmorel@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19051014-0020-0000-0000-0000033B5B8B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19051014-0021-0000-0000-0000218E0892
Message-Id: <1557499133-24169-4-git-send-email-pmorel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-05-09_02:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
	priorityscore=1501
	malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
	clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
	mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
	scancount=1 engine=8.0.1-1810050000 definitions=main-1905100100
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: [Qemu-devel] [PATCH 3/5] s390: vfio_pci: Use a PCI Group structure
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
index 2d0a28d..175ea8c 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -729,6 +729,46 @@ static void s390_pci_iommu_free(S390pciState *s, PCIBus *bus, int32_t devfn)
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
@@ -765,7 +805,9 @@ static void s390_pcihost_realize(DeviceState *dev, Error **errp)
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
index be28962..8147847 100644
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
@@ -752,7 +756,7 @@ int pcistb_service_call(S390CPU *cpu, uint8_t r1, uint8_t r3, uint64_t gaddr,
     }
     /* Length must be greater than 8, a multiple of 8 */
     /* and not greater than maxstbl */
-    if ((len <= 8) || (len % 8) || (len > pbdev->maxstbl)) {
+    if ((len <= 8) || (len % 8) || (len > pbdev->pci_grp->zpci_grp.maxstbl)) {
         goto specification_error;
     }
     /* Do not cross a 4K-byte boundary */
-- 
2.7.4



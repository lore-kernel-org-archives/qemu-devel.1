Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6458C282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 12:29:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79E3B20851
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 12:29:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79E3B20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35280 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTmqu-0003bd-Ny
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 08:29:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45833)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1hTmmZ-0008Hd-9O
	for qemu-devel@nongnu.org; Thu, 23 May 2019 08:25:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1hTmmX-0002UL-MP
	for qemu-devel@nongnu.org; Thu, 23 May 2019 08:25:15 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42872)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.ibm.com>)
	id 1hTmmX-0002Sp-2j
	for qemu-devel@nongnu.org; Thu, 23 May 2019 08:25:13 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x4NC9G6A024182
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 08:25:10 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2snrwvfg2a-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 08:25:10 -0400
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.ibm.com>;
	Thu, 23 May 2019 13:25:08 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
	by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
	Authorized Use Only! Violators will be prosecuted; 
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Thu, 23 May 2019 13:25:03 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
	(b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
	by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id x4NCP2e610158292
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK); Thu, 23 May 2019 12:25:02 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0AEB0A405B;
	Thu, 23 May 2019 12:25:02 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A478DA4054;
	Thu, 23 May 2019 12:25:01 +0000 (GMT)
Received: from morel-ThinkPad-W530.boeblingen.de.ibm.com (unknown
	[9.152.222.40])
	by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Thu, 23 May 2019 12:25:01 +0000 (GMT)
From: Pierre Morel <pmorel@linux.ibm.com>
To: cohuck@redhat.com
Date: Thu, 23 May 2019 14:24:58 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1558614300-24574-1-git-send-email-pmorel@linux.ibm.com>
References: <1558614300-24574-1-git-send-email-pmorel@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19052312-0020-0000-0000-0000033FAC96
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19052312-0021-0000-0000-0000219296CD
Message-Id: <1558614300-24574-4-git-send-email-pmorel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-05-23_10:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
	priorityscore=1501
	malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
	clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
	mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
	scancount=1 engine=8.0.1-1810050000 definitions=main-1905230087
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
Subject: [Qemu-devel] [PATCH v2 3/5] s390: vfio_pci: Use a PCI Group
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



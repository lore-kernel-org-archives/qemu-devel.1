Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6962EC31E50
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 13:56:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 409762080C
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 13:56:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 409762080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47726 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcs80-000516-DK
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 09:56:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33075)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <groug@kaod.org>) id 1hcrye-0004Pg-PM
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 09:47:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1hcryY-0000qc-Rq
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 09:47:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55418)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1hcryU-0000lN-VG
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 09:47:08 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x5HDdUmi056952
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 09:47:03 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2t6bmh143x-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 09:47:02 -0400
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <groug@kaod.org>;
 Mon, 17 Jun 2019 14:47:00 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
 by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 17 Jun 2019 14:46:59 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id x5HDkw5439977374
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Jun 2019 13:46:58 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2EDD44C044;
 Mon, 17 Jun 2019 13:46:58 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F36FE4C040;
 Mon, 17 Jun 2019 13:46:57 +0000 (GMT)
Received: from bahia.lan (unknown [9.145.14.35])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon, 17 Jun 2019 13:46:57 +0000 (GMT)
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 17 Jun 2019 15:46:57 +0200
In-Reply-To: <156077918969.433243.1416211899441569578.stgit@bahia.lan>
References: <156077918969.433243.1416211899441569578.stgit@bahia.lan>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19061713-0008-0000-0000-000002F47BC6
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19061713-0009-0000-0000-000022618DE3
Message-Id: <156077921763.433243.4614327010172954196.stgit@bahia.lan>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-06-17_06:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=818 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906170126
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
Subject: [Qemu-devel] [PATCH 5/6] xics/kvm: Add error propagation to
 ic*_set_kvm_state() functions
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
Cc: qemu-ppc@nongnu.org, =?utf-8?q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This allows errors happening there to be propagated up to spapr_irq,
just like XIVE already does.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/intc/xics.c        |   39 ++++++++++++++++++++++++++++++++++-----
 hw/intc/xics_kvm.c    |   37 ++++++++++++++++++++++---------------
 include/hw/ppc/xics.h |    6 +++---
 3 files changed, 59 insertions(+), 23 deletions(-)

diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index 1dc3a0f12280..69152e3d9ff6 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -267,7 +267,14 @@ static int icp_post_load(void *opaque, int version_id)
     ICPState *icp = opaque;
 
     if (kvm_irqchip_in_kernel()) {
-        return icp_set_kvm_state(icp);
+        Error *local_err = NULL;
+        int ret;
+
+        ret = icp_set_kvm_state(icp, &local_err);
+        if (ret < 0) {
+            error_report_err(local_err);
+            return ret;
+        }
     }
 
     return 0;
@@ -300,7 +307,12 @@ static void icp_reset_handler(void *dev)
     qemu_set_irq(icp->output, 0);
 
     if (kvm_irqchip_in_kernel()) {
-        icp_set_kvm_state(ICP(dev));
+        Error *local_err = NULL;
+
+        icp_set_kvm_state(ICP(dev), &local_err);
+        if (local_err) {
+            error_report_err(local_err);
+        }
     }
 }
 
@@ -555,7 +567,12 @@ static void ics_simple_reset(DeviceState *dev)
     icsc->parent_reset(dev);
 
     if (kvm_irqchip_in_kernel()) {
-        ics_set_kvm_state(ICS_BASE(dev));
+        Error *local_err = NULL;
+
+        ics_set_kvm_state(ICS_BASE(dev), &local_err);
+        if (local_err) {
+            error_report_err(local_err);
+        }
     }
 }
 
@@ -671,7 +688,14 @@ static int ics_base_post_load(void *opaque, int version_id)
     ICSState *ics = opaque;
 
     if (kvm_irqchip_in_kernel()) {
-        return ics_set_kvm_state(ics);
+        Error *local_err = NULL;
+        int ret;
+
+        ret = ics_set_kvm_state(ics, &local_err);
+        if (ret < 0) {
+            error_report_err(local_err);
+            return ret;
+        }
     }
 
     return 0;
@@ -757,8 +781,13 @@ void ics_set_irq_type(ICSState *ics, int srcno, bool lsi)
         lsi ? XICS_FLAGS_IRQ_LSI : XICS_FLAGS_IRQ_MSI;
 
     if (kvm_irqchip_in_kernel()) {
+        Error *local_err = NULL;
+
         ics_reset_irq(ics->irqs + srcno);
-        ics_set_kvm_state_one(ics, srcno);
+        ics_set_kvm_state_one(ics, srcno, &local_err);
+        if (local_err) {
+            error_report_err(local_err);
+        }
     }
 }
 
diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
index c9e25fb051bb..4bfbe1a84092 100644
--- a/hw/intc/xics_kvm.c
+++ b/hw/intc/xics_kvm.c
@@ -106,7 +106,7 @@ void icp_synchronize_state(ICPState *icp)
     }
 }
 
-int icp_set_kvm_state(ICPState *icp)
+int icp_set_kvm_state(ICPState *icp, Error **errp)
 {
     uint64_t state;
     int ret;
@@ -126,10 +126,11 @@ int icp_set_kvm_state(ICPState *icp)
         | ((uint64_t)icp->pending_priority << KVM_REG_PPC_ICP_PPRI_SHIFT);
 
     ret = kvm_set_one_reg(icp->cs, KVM_REG_PPC_ICP_STATE, &state);
-    if (ret != 0) {
-        error_report("Unable to restore KVM interrupt controller state (0x%"
-                PRIx64 ") for CPU %ld: %s", state, kvm_arch_vcpu_id(icp->cs),
-                strerror(errno));
+    if (ret < 0) {
+        error_setg_errno(errp, -ret,
+                         "Unable to restore KVM interrupt controller state (0x%"
+                         PRIx64 ") for CPU %ld", state,
+                         kvm_arch_vcpu_id(icp->cs));
         return ret;
     }
 
@@ -240,10 +241,9 @@ void ics_synchronize_state(ICSState *ics)
     ics_get_kvm_state(ics);
 }
 
-int ics_set_kvm_state_one(ICSState *ics, int srcno)
+int ics_set_kvm_state_one(ICSState *ics, int srcno, Error **errp)
 {
     uint64_t state;
-    Error *local_err = NULL;
     ICSIRQState *irq = &ics->irqs[srcno];
     int ret;
 
@@ -278,16 +278,15 @@ int ics_set_kvm_state_one(ICSState *ics, int srcno)
     }
 
     ret = kvm_device_access(kernel_xics_fd, KVM_DEV_XICS_GRP_SOURCES,
-                            srcno + ics->offset, &state, true, &local_err);
-    if (local_err) {
-        error_report_err(local_err);
+                            srcno + ics->offset, &state, true, errp);
+    if (ret < 0) {
         return ret;
     }
 
     return 0;
 }
 
-int ics_set_kvm_state(ICSState *ics)
+int ics_set_kvm_state(ICSState *ics, Error **errp)
 {
     int i;
 
@@ -297,10 +296,12 @@ int ics_set_kvm_state(ICSState *ics)
     }
 
     for (i = 0; i < ics->nr_irqs; i++) {
+        Error *local_err = NULL;
         int ret;
 
-        ret = ics_set_kvm_state_one(ics, i);
-        if (ret) {
+        ret = ics_set_kvm_state_one(ics, i, &local_err);
+        if (ret < 0) {
+            error_propagate(errp, local_err);
             return ret;
         }
     }
@@ -402,12 +403,18 @@ int xics_kvm_connect(SpaprMachineState *spapr, Error **errp)
     }
 
     /* Update the KVM sources */
-    ics_set_kvm_state(spapr->ics);
+    ics_set_kvm_state(spapr->ics, &local_err);
+    if (local_err) {
+        goto fail;
+    }
 
     /* Connect the presenters to the initial VCPUs of the machine */
     CPU_FOREACH(cs) {
         PowerPCCPU *cpu = POWERPC_CPU(cs);
-        icp_set_kvm_state(spapr_cpu_state(cpu)->icp);
+        icp_set_kvm_state(spapr_cpu_state(cpu)->icp, &local_err);
+        if (local_err) {
+            goto fail;
+        }
     }
 
     return 0;
diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
index eb65ad7e43b7..1eb7b5cd6847 100644
--- a/include/hw/ppc/xics.h
+++ b/include/hw/ppc/xics.h
@@ -190,13 +190,13 @@ Object *icp_create(Object *cpu, const char *type, XICSFabric *xi,
 
 /* KVM */
 void icp_get_kvm_state(ICPState *icp);
-int icp_set_kvm_state(ICPState *icp);
+int icp_set_kvm_state(ICPState *icp, Error **errp);
 void icp_synchronize_state(ICPState *icp);
 void icp_kvm_realize(DeviceState *dev, Error **errp);
 
 void ics_get_kvm_state(ICSState *ics);
-int ics_set_kvm_state_one(ICSState *ics, int srcno);
-int ics_set_kvm_state(ICSState *ics);
+int ics_set_kvm_state_one(ICSState *ics, int srcno, Error **errp);
+int ics_set_kvm_state(ICSState *ics, Error **errp);
 void ics_synchronize_state(ICSState *ics);
 void ics_kvm_set_irq(ICSState *ics, int srcno, int val);
 



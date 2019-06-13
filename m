Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D00ADC31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 18:10:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF3972082C
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 18:10:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF3972082C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43314 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbUAr-0006fZ-05
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 14:10:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55605)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <groug@kaod.org>) id 1hbSqY-0001Rz-Et
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 12:45:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1hbSqX-0007FZ-48
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 12:45:06 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57174)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1hbSqW-0007AX-Ol
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 12:45:05 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x5DGgcRs101726
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2019 12:45:01 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2t3sdujhs3-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2019 12:45:00 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <groug@kaod.org>;
 Thu, 13 Jun 2019 17:44:58 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 13 Jun 2019 17:44:55 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x5DGisCq59310172
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 13 Jun 2019 16:44:54 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 99CF64203F;
 Thu, 13 Jun 2019 16:44:54 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 61ECE42041;
 Thu, 13 Jun 2019 16:44:54 +0000 (GMT)
Received: from bahia.lab.toulouse-stg.fr.ibm.com (unknown [9.101.4.41])
 by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu, 13 Jun 2019 16:44:54 +0000 (GMT)
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 13 Jun 2019 18:44:54 +0200
In-Reply-To: <156044428869.125694.13827513253200184549.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
References: <156044428869.125694.13827513253200184549.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19061316-4275-0000-0000-00000342132A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19061316-4276-0000-0000-000038522E0C
Message-Id: <156044429419.125694.507569071972451514.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-06-13_11:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906130122
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
Subject: [Qemu-devel] [PATCH 1/3] xics/spapr: Prevent RTAS/hypercalls
 emulation to be used by in-kernel XICS
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
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 =?utf-8?q?C=C3=A9dric?= Le Goater <clg@kaod.org>, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The XICS-related RTAS calls and hypercalls in QEMU are supposed to be
called only when the KVM in-kernel XICS is in use.

Add some explicit checks to detect that, print an error message and report
an hardware error to the guest.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/intc/xics_spapr.c |   46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
index 5a1835e8b1ed..d470ab5f7a2a 100644
--- a/hw/intc/xics_spapr.c
+++ b/hw/intc/xics_spapr.c
@@ -41,11 +41,31 @@
  * Guest interfaces
  */
 
+static bool check_in_kernel_xics(const char *func)
+{
+    if (kvm_irqchip_in_kernel()) {
+        error_report("pseries: %s must never be called for in-kernel XICS",
+                     func);
+        return true;
+    }
+
+    return false;
+}
+
+#define CHECK_IN_KERNEL_XICS_HCALL              \
+    do {                                        \
+        if (check_in_kernel_xics(__func__)) {   \
+            return H_HARDWARE;                  \
+        }                                       \
+    } while (0)
+
 static target_ulong h_cppr(PowerPCCPU *cpu, SpaprMachineState *spapr,
                            target_ulong opcode, target_ulong *args)
 {
     target_ulong cppr = args[0];
 
+    CHECK_IN_KERNEL_XICS_HCALL;
+
     icp_set_cppr(spapr_cpu_state(cpu)->icp, cppr);
     return H_SUCCESS;
 }
@@ -56,6 +76,8 @@ static target_ulong h_ipi(PowerPCCPU *cpu, SpaprMachineState *spapr,
     target_ulong mfrr = args[1];
     ICPState *icp = xics_icp_get(XICS_FABRIC(spapr), args[0]);
 
+    CHECK_IN_KERNEL_XICS_HCALL;
+
     if (!icp) {
         return H_PARAMETER;
     }
@@ -69,6 +91,8 @@ static target_ulong h_xirr(PowerPCCPU *cpu, SpaprMachineState *spapr,
 {
     uint32_t xirr = icp_accept(spapr_cpu_state(cpu)->icp);
 
+    CHECK_IN_KERNEL_XICS_HCALL;
+
     args[0] = xirr;
     return H_SUCCESS;
 }
@@ -78,6 +102,8 @@ static target_ulong h_xirr_x(PowerPCCPU *cpu, SpaprMachineState *spapr,
 {
     uint32_t xirr = icp_accept(spapr_cpu_state(cpu)->icp);
 
+    CHECK_IN_KERNEL_XICS_HCALL;
+
     args[0] = xirr;
     args[1] = cpu_get_host_ticks();
     return H_SUCCESS;
@@ -88,6 +114,8 @@ static target_ulong h_eoi(PowerPCCPU *cpu, SpaprMachineState *spapr,
 {
     target_ulong xirr = args[0];
 
+    CHECK_IN_KERNEL_XICS_HCALL;
+
     icp_eoi(spapr_cpu_state(cpu)->icp, xirr);
     return H_SUCCESS;
 }
@@ -99,6 +127,8 @@ static target_ulong h_ipoll(PowerPCCPU *cpu, SpaprMachineState *spapr,
     uint32_t mfrr;
     uint32_t xirr;
 
+    CHECK_IN_KERNEL_XICS_HCALL;
+
     if (!icp) {
         return H_PARAMETER;
     }
@@ -111,6 +141,14 @@ static target_ulong h_ipoll(PowerPCCPU *cpu, SpaprMachineState *spapr,
     return H_SUCCESS;
 }
 
+#define CHECK_IN_KERNEL_XICS_RTAS(rets)                 \
+    do {                                                \
+        if (check_in_kernel_xics(__func__)) {           \
+            rtas_st((rets), 0, RTAS_OUT_HW_ERROR);      \
+            return;                                     \
+        }                                               \
+    } while (0)
+
 static void rtas_set_xive(PowerPCCPU *cpu, SpaprMachineState *spapr,
                           uint32_t token,
                           uint32_t nargs, target_ulong args,
@@ -119,6 +157,8 @@ static void rtas_set_xive(PowerPCCPU *cpu, SpaprMachineState *spapr,
     ICSState *ics = spapr->ics;
     uint32_t nr, srcno, server, priority;
 
+    CHECK_IN_KERNEL_XICS_RTAS(rets);
+
     if ((nargs != 3) || (nret != 1)) {
         rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
         return;
@@ -152,6 +192,8 @@ static void rtas_get_xive(PowerPCCPU *cpu, SpaprMachineState *spapr,
     ICSState *ics = spapr->ics;
     uint32_t nr, srcno;
 
+    CHECK_IN_KERNEL_XICS_RTAS(rets);
+
     if ((nargs != 1) || (nret != 3)) {
         rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
         return;
@@ -182,6 +224,8 @@ static void rtas_int_off(PowerPCCPU *cpu, SpaprMachineState *spapr,
     ICSState *ics = spapr->ics;
     uint32_t nr, srcno;
 
+    CHECK_IN_KERNEL_XICS_RTAS(rets);
+
     if ((nargs != 1) || (nret != 1)) {
         rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
         return;
@@ -213,6 +257,8 @@ static void rtas_int_on(PowerPCCPU *cpu, SpaprMachineState *spapr,
     ICSState *ics = spapr->ics;
     uint32_t nr, srcno;
 
+    CHECK_IN_KERNEL_XICS_RTAS(rets);
+
     if ((nargs != 1) || (nret != 1)) {
         rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
         return;



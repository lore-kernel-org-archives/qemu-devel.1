Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D2D8C31E57
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 12:08:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA5D720861
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 12:08:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA5D720861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46422 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcqQm-0004FC-7c
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 08:08:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60545)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <groug@kaod.org>) id 1hcqEo-0005Od-2x
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 07:55:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1hcqEl-0004GM-SQ
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 07:55:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53326)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1hcqEl-0004Cm-DH
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 07:55:47 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x5HBrRMF084612
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 07:55:43 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2t67eqy366-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 07:55:42 -0400
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <groug@kaod.org>;
 Mon, 17 Jun 2019 12:55:40 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 17 Jun 2019 12:55:38 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x5HBtbxG56950990
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Jun 2019 11:55:37 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 347884C059;
 Mon, 17 Jun 2019 11:55:37 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 056C64C046;
 Mon, 17 Jun 2019 11:55:37 +0000 (GMT)
Received: from bahia.lan (unknown [9.145.14.35])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Mon, 17 Jun 2019 11:55:36 +0000 (GMT)
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 17 Jun 2019 13:55:36 +0200
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19061711-0020-0000-0000-0000034ACF0D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19061711-0021-0000-0000-0000219E140D
Message-Id: <156077253666.424706.6104557911104491047.stgit@bahia.lan>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-06-17_06:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906170111
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
Subject: [Qemu-devel] [PATCH] xics/spapr: Only emulated XICS should use
 RTAS/hypercalls emulation
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

Checking that we're not using the in-kernel XICS is ok with the "xics"
interrupt controller mode, but it is definitely not enough with the
other modes since the guest could be using XIVE.

Ensure XIVE is not in use when emulated XICS RTAS/hypercalls are
called.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/intc/xics_spapr.c |   53 +++++++++++++++++++++++++-------------------------
 1 file changed, 27 insertions(+), 26 deletions(-)

diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
index 8d605b68a7a0..7cd3c93d719f 100644
--- a/hw/intc/xics_spapr.c
+++ b/hw/intc/xics_spapr.c
@@ -41,22 +41,23 @@
  * Guest interfaces
  */
 
-static bool check_in_kernel_xics(const char *func)
+static bool check_emulated_xics(SpaprMachineState *spapr, const char *func)
 {
-    if (kvm_irqchip_in_kernel()) {
-        error_report("pseries: %s must never be called for in-kernel XICS",
+    if (spapr_ovec_test(spapr->ov5_cas, OV5_XIVE_EXPLOIT) ||
+        kvm_irqchip_in_kernel()) {
+        error_report("pseries: %s must only be called for emulated XICS",
                      func);
-        return true;
+        return false;
     }
 
-    return false;
+    return true;
 }
 
-#define CHECK_IN_KERNEL_XICS_HCALL              \
-    do {                                        \
-        if (check_in_kernel_xics(__func__)) {   \
-            return H_HARDWARE;                  \
-        }                                       \
+#define CHECK_EMULATED_XICS_HCALL(spapr)               \
+    do {                                               \
+        if (!check_emulated_xics((spapr), __func__)) { \
+            return H_HARDWARE;                         \
+        }                                              \
     } while (0)
 
 static target_ulong h_cppr(PowerPCCPU *cpu, SpaprMachineState *spapr,
@@ -64,7 +65,7 @@ static target_ulong h_cppr(PowerPCCPU *cpu, SpaprMachineState *spapr,
 {
     target_ulong cppr = args[0];
 
-    CHECK_IN_KERNEL_XICS_HCALL;
+    CHECK_EMULATED_XICS_HCALL(spapr);
 
     icp_set_cppr(spapr_cpu_state(cpu)->icp, cppr);
     return H_SUCCESS;
@@ -76,7 +77,7 @@ static target_ulong h_ipi(PowerPCCPU *cpu, SpaprMachineState *spapr,
     target_ulong mfrr = args[1];
     ICPState *icp = xics_icp_get(XICS_FABRIC(spapr), args[0]);
 
-    CHECK_IN_KERNEL_XICS_HCALL;
+    CHECK_EMULATED_XICS_HCALL(spapr);
 
     if (!icp) {
         return H_PARAMETER;
@@ -91,7 +92,7 @@ static target_ulong h_xirr(PowerPCCPU *cpu, SpaprMachineState *spapr,
 {
     uint32_t xirr = icp_accept(spapr_cpu_state(cpu)->icp);
 
-    CHECK_IN_KERNEL_XICS_HCALL;
+    CHECK_EMULATED_XICS_HCALL(spapr);
 
     args[0] = xirr;
     return H_SUCCESS;
@@ -102,7 +103,7 @@ static target_ulong h_xirr_x(PowerPCCPU *cpu, SpaprMachineState *spapr,
 {
     uint32_t xirr = icp_accept(spapr_cpu_state(cpu)->icp);
 
-    CHECK_IN_KERNEL_XICS_HCALL;
+    CHECK_EMULATED_XICS_HCALL(spapr);
 
     args[0] = xirr;
     args[1] = cpu_get_host_ticks();
@@ -114,7 +115,7 @@ static target_ulong h_eoi(PowerPCCPU *cpu, SpaprMachineState *spapr,
 {
     target_ulong xirr = args[0];
 
-    CHECK_IN_KERNEL_XICS_HCALL;
+    CHECK_EMULATED_XICS_HCALL(spapr);
 
     icp_eoi(spapr_cpu_state(cpu)->icp, xirr);
     return H_SUCCESS;
@@ -127,7 +128,7 @@ static target_ulong h_ipoll(PowerPCCPU *cpu, SpaprMachineState *spapr,
     uint32_t mfrr;
     uint32_t xirr;
 
-    CHECK_IN_KERNEL_XICS_HCALL;
+    CHECK_EMULATED_XICS_HCALL(spapr);
 
     if (!icp) {
         return H_PARAMETER;
@@ -141,12 +142,12 @@ static target_ulong h_ipoll(PowerPCCPU *cpu, SpaprMachineState *spapr,
     return H_SUCCESS;
 }
 
-#define CHECK_IN_KERNEL_XICS_RTAS(rets)                 \
-    do {                                                \
-        if (check_in_kernel_xics(__func__)) {           \
-            rtas_st((rets), 0, RTAS_OUT_HW_ERROR);      \
-            return;                                     \
-        }                                               \
+#define CHECK_EMULATED_XICS_RTAS(spapr, rets)          \
+    do {                                               \
+        if (!check_emulated_xics((spapr), __func__)) { \
+            rtas_st((rets), 0, RTAS_OUT_HW_ERROR);     \
+            return;                                    \
+        }                                              \
     } while (0)
 
 static void rtas_set_xive(PowerPCCPU *cpu, SpaprMachineState *spapr,
@@ -157,7 +158,7 @@ static void rtas_set_xive(PowerPCCPU *cpu, SpaprMachineState *spapr,
     ICSState *ics = spapr->ics;
     uint32_t nr, srcno, server, priority;
 
-    CHECK_IN_KERNEL_XICS_RTAS(rets);
+    CHECK_EMULATED_XICS_RTAS(spapr, rets);
 
     if ((nargs != 3) || (nret != 1)) {
         rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
@@ -192,7 +193,7 @@ static void rtas_get_xive(PowerPCCPU *cpu, SpaprMachineState *spapr,
     ICSState *ics = spapr->ics;
     uint32_t nr, srcno;
 
-    CHECK_IN_KERNEL_XICS_RTAS(rets);
+    CHECK_EMULATED_XICS_RTAS(spapr, rets);
 
     if ((nargs != 1) || (nret != 3)) {
         rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
@@ -224,7 +225,7 @@ static void rtas_int_off(PowerPCCPU *cpu, SpaprMachineState *spapr,
     ICSState *ics = spapr->ics;
     uint32_t nr, srcno;
 
-    CHECK_IN_KERNEL_XICS_RTAS(rets);
+    CHECK_EMULATED_XICS_RTAS(spapr, rets);
 
     if ((nargs != 1) || (nret != 1)) {
         rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
@@ -257,7 +258,7 @@ static void rtas_int_on(PowerPCCPU *cpu, SpaprMachineState *spapr,
     ICSState *ics = spapr->ics;
     uint32_t nr, srcno;
 
-    CHECK_IN_KERNEL_XICS_RTAS(rets);
+    CHECK_EMULATED_XICS_RTAS(spapr, rets);
 
     if ((nargs != 1) || (nret != 1)) {
         rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);



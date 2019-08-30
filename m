Return-Path: <SRS0=DGTm=W2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E580C3A5A4
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2019 09:24:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D496C21726
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2019 09:24:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D496C21726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3d8m-0002Z3-3M
	for qemu-devel@archiver.kernel.org; Fri, 30 Aug 2019 05:24:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34563)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aravinda@linux.vnet.ibm.com>) id 1i3czM-0003wO-6p
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 05:14:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aravinda@linux.vnet.ibm.com>) id 1i3czK-0000tq-KD
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 05:14:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35482)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aravinda@linux.vnet.ibm.com>)
 id 1i3czA-0000Oj-0B; Fri, 30 Aug 2019 05:14:24 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x7U97KPb015892; Fri, 30 Aug 2019 05:14:12 -0400
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com
 [169.63.121.186])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2uq0em9egn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 30 Aug 2019 05:14:12 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
 by ppma03wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x7U99QXq013097;
 Fri, 30 Aug 2019 09:14:11 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23]) by ppma03wdc.us.ibm.com with ESMTP id 2upp5du5tx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 30 Aug 2019 09:14:11 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com
 [9.57.199.107])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x7U9EAce44368328
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 30 Aug 2019 09:14:10 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B7B25124054;
 Fri, 30 Aug 2019 09:14:10 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C431C124052;
 Fri, 30 Aug 2019 09:14:08 +0000 (GMT)
Received: from [127.0.1.1] (unknown [9.85.75.15])
 by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
 Fri, 30 Aug 2019 09:14:08 +0000 (GMT)
From: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
To: aik@ozlabs.ru, qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 david@gibson.dropbear.id.au
Date: Fri, 30 Aug 2019 14:44:07 +0530
Message-ID: <156715644777.27761.16844420952499810544.stgit@aravinda>
In-Reply-To: <156715632966.27761.8190459106519248668.stgit@aravinda>
References: <156715632966.27761.8190459106519248668.stgit@aravinda>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-08-30_04:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908300099
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
Subject: [Qemu-devel] [PATCH v12 5/6] ppc: spapr: Handle "ibm,
 nmi-register" and "ibm, nmi-interlock" RTAS calls
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
Cc: paulus@ozlabs.org, aravinda@linux.vnet.ibm.com, groug@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch adds support in QEMU to handle "ibm,nmi-register"
and "ibm,nmi-interlock" RTAS calls and sets the default
value of SPAPR_CAP_FWNMI_MCE to SPAPR_CAP_ON for machine
type 4.2.

The machine check notification address is saved when the
OS issues "ibm,nmi-register" RTAS call.

This patch also handles the case when multiple processors
experience machine check at or about the same time by
handling "ibm,nmi-interlock" call. In such cases, as per
PAPR, subsequent processors serialize waiting for the first
processor to issue the "ibm,nmi-interlock" call. The second
processor that also received a machine check error waits
till the first processor is done reading the error log.
The first processor issues "ibm,nmi-interlock" call
when the error log is consumed.

Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
---
 hw/ppc/spapr.c         |   12 +++++++++++-
 hw/ppc/spapr_rtas.c    |   50 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/hw/ppc/spapr.h |    5 ++++-
 3 files changed, 65 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 9f2e5d2..1c0908e 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2941,6 +2941,15 @@ static void spapr_machine_init(MachineState *machine)
 
         /* Resize rtas blob to accommodate error log */
         spapr->rtas_size = RTAS_ERROR_LOG_MAX;
+
+        /* Set fwnmi capability in KVM */
+        if (kvmppc_set_fwnmi() < 0) {
+            error_report("Could not enable FWNMI capability");
+            exit(1);
+        }
+
+        /* Register ibm,nmi-register and ibm,nmi-interlock RTAS calls */
+        spapr_fwnmi_register();
     }
 
     spapr->rtas_blob = g_malloc(spapr->rtas_size);
@@ -4508,7 +4517,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
     smc->default_caps.caps[SPAPR_CAP_NESTED_KVM_HV] = SPAPR_CAP_OFF;
     smc->default_caps.caps[SPAPR_CAP_LARGE_DECREMENTER] = SPAPR_CAP_ON;
     smc->default_caps.caps[SPAPR_CAP_CCF_ASSIST] = SPAPR_CAP_OFF;
-    smc->default_caps.caps[SPAPR_CAP_FWNMI_MCE] = SPAPR_CAP_OFF;
+    smc->default_caps.caps[SPAPR_CAP_FWNMI_MCE] = SPAPR_CAP_ON;
     spapr_caps_add_properties(smc, &error_abort);
     smc->irq = &spapr_irq_dual;
     smc->dr_phb_enabled = true;
@@ -4582,6 +4591,7 @@ static void spapr_machine_4_1_class_options(MachineClass *mc)
     smc->linux_pci_probe = false;
     compat_props_add(mc->compat_props, hw_compat_4_1, hw_compat_4_1_len);
     compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
+    smc->default_caps.caps[SPAPR_CAP_FWNMI_MCE] = SPAPR_CAP_OFF;
 }
 
 DEFINE_SPAPR_MACHINE(4_1, "4.1", false);
diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
index d8fb8a8..d892583 100644
--- a/hw/ppc/spapr_rtas.c
+++ b/hw/ppc/spapr_rtas.c
@@ -400,6 +400,48 @@ static void rtas_get_power_level(PowerPCCPU *cpu, SpaprMachineState *spapr,
     rtas_st(rets, 1, 100);
 }
 
+static void rtas_ibm_nmi_register(PowerPCCPU *cpu,
+                                  SpaprMachineState *spapr,
+                                  uint32_t token, uint32_t nargs,
+                                  target_ulong args,
+                                  uint32_t nret, target_ulong rets)
+{
+    hwaddr rtas_addr = spapr_get_rtas_addr();
+
+    if (!rtas_addr) {
+        rtas_st(rets, 0, RTAS_OUT_NOT_SUPPORTED);
+        return;
+    }
+
+    if (spapr_get_cap(spapr, SPAPR_CAP_FWNMI_MCE) == SPAPR_CAP_OFF) {
+        rtas_st(rets, 0, RTAS_OUT_NOT_SUPPORTED);
+        return;
+    }
+
+    spapr->guest_machine_check_addr = rtas_ld(args, 1);
+    rtas_st(rets, 0, RTAS_OUT_SUCCESS);
+}
+
+static void rtas_ibm_nmi_interlock(PowerPCCPU *cpu,
+                                   SpaprMachineState *spapr,
+                                   uint32_t token, uint32_t nargs,
+                                   target_ulong args,
+                                   uint32_t nret, target_ulong rets)
+{
+    if (spapr->guest_machine_check_addr == -1) {
+        /* NMI register not called */
+        rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
+    } else {
+        /*
+         * vCPU issuing "ibm,nmi-interlock" is done with NMI handling,
+         * hence unset mc_status.
+         */
+        spapr->mc_status = -1;
+        qemu_cond_signal(&spapr->mc_delivery_cond);
+        rtas_st(rets, 0, RTAS_OUT_SUCCESS);
+    }
+}
+
 static struct rtas_call {
     const char *name;
     spapr_rtas_fn fn;
@@ -544,6 +586,14 @@ hwaddr spapr_get_rtas_addr(void)
     return (hwaddr)fdt32_to_cpu(*rtas_data);
 }
 
+void spapr_fwnmi_register(void)
+{
+    spapr_rtas_register(RTAS_IBM_NMI_REGISTER, "ibm,nmi-register",
+                        rtas_ibm_nmi_register);
+    spapr_rtas_register(RTAS_IBM_NMI_INTERLOCK, "ibm,nmi-interlock",
+                        rtas_ibm_nmi_interlock);
+}
+
 static void core_rtas_register_types(void)
 {
     spapr_rtas_register(RTAS_DISPLAY_CHARACTER, "display-character",
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index ffefde7..dada821 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -655,8 +655,10 @@ target_ulong spapr_hypercall(PowerPCCPU *cpu, target_ulong opcode,
 #define RTAS_IBM_REMOVE_PE_DMA_WINDOW           (RTAS_TOKEN_BASE + 0x28)
 #define RTAS_IBM_RESET_PE_DMA_WINDOW            (RTAS_TOKEN_BASE + 0x29)
 #define RTAS_IBM_SUSPEND_ME                     (RTAS_TOKEN_BASE + 0x2A)
+#define RTAS_IBM_NMI_REGISTER                   (RTAS_TOKEN_BASE + 0x2B)
+#define RTAS_IBM_NMI_INTERLOCK                  (RTAS_TOKEN_BASE + 0x2C)
 
-#define RTAS_TOKEN_MAX                          (RTAS_TOKEN_BASE + 0x2B)
+#define RTAS_TOKEN_MAX                          (RTAS_TOKEN_BASE + 0x2D)
 
 /* RTAS ibm,get-system-parameter token values */
 #define RTAS_SYSPARM_SPLPAR_CHARACTERISTICS      20
@@ -908,4 +910,5 @@ void spapr_check_pagesize(SpaprMachineState *spapr, hwaddr pagesize,
 
 void spapr_set_all_lpcrs(target_ulong value, target_ulong mask);
 hwaddr spapr_get_rtas_addr(void);
+void spapr_fwnmi_register(void);
 #endif /* HW_SPAPR_H */



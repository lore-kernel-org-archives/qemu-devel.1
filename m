Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E68C31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 09:30:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77C5E207E0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 09:30:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77C5E207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58008 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haza2-0006v1-Oo
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 05:30:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39378)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aravinda@linux.vnet.ibm.com>) id 1hazS4-0001Yo-8E
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 05:21:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aravinda@linux.vnet.ibm.com>) id 1hazRz-00082Q-JE
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 05:21:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35686
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aravinda@linux.vnet.ibm.com>)
 id 1hazRz-00081m-9X
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 05:21:47 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x5C9DKxR063656
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2019 05:21:46 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2t2x2kj34g-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2019 05:21:46 -0400
Received: from localhost
 by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <aravinda@linux.vnet.ibm.com>;
 Wed, 12 Jun 2019 10:21:45 +0100
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
 by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 12 Jun 2019 10:21:42 +0100
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com
 [9.57.199.109])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x5C9LfIl30736808
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 12 Jun 2019 09:21:41 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 36013112065;
 Wed, 12 Jun 2019 09:21:41 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 573E6112064;
 Wed, 12 Jun 2019 09:21:39 +0000 (GMT)
Received: from [127.0.1.1] (unknown [9.124.31.35])
 by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
 Wed, 12 Jun 2019 09:21:39 +0000 (GMT)
From: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
To: aik@au1.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 david@gibson.dropbear.id.au
Date: Wed, 12 Jun 2019 14:51:38 +0530
In-Reply-To: <156033104292.26635.15759339817253067370.stgit@aravinda>
References: <156033104292.26635.15759339817253067370.stgit@aravinda>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19061209-2213-0000-0000-0000039E3F3C
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011250; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01216839; UDB=6.00639831; IPR=6.00997939; 
 MB=3.00027275; MTD=3.00000008; XFM=3.00000015; UTC=2019-06-12 09:21:43
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19061209-2214-0000-0000-00005ED502D5
Message-Id: <156033129836.26635.3348706829139659071.stgit@aravinda>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-06-12_05:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906120064
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: [Qemu-devel] [PATCH v10 6/6] ppc: spapr: Handle "ibm,
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
type 4.0.

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
 hw/ppc/spapr.c         |    6 ++++-
 hw/ppc/spapr_rtas.c    |   63 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/hw/ppc/spapr.h |    5 +++-
 3 files changed, 72 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 3d6d139..213d493 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2946,6 +2946,9 @@ static void spapr_machine_init(MachineState *machine)
         /* Create the error string for live migration blocker */
         error_setg(&spapr->fwnmi_migration_blocker,
                 "Live migration not supported during machine check handling");
+
+        /* Register ibm,nmi-register and ibm,nmi-interlock RTAS calls */
+        spapr_fwnmi_register();
     }
 
     spapr->rtas_blob = g_malloc(spapr->rtas_size);
@@ -4408,7 +4411,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
     smc->default_caps.caps[SPAPR_CAP_NESTED_KVM_HV] = SPAPR_CAP_OFF;
     smc->default_caps.caps[SPAPR_CAP_LARGE_DECREMENTER] = SPAPR_CAP_ON;
     smc->default_caps.caps[SPAPR_CAP_CCF_ASSIST] = SPAPR_CAP_OFF;
-    smc->default_caps.caps[SPAPR_CAP_FWNMI_MCE] = SPAPR_CAP_OFF;
+    smc->default_caps.caps[SPAPR_CAP_FWNMI_MCE] = SPAPR_CAP_ON;
     spapr_caps_add_properties(smc, &error_abort);
     smc->irq = &spapr_irq_dual;
     smc->dr_phb_enabled = true;
@@ -4512,6 +4515,7 @@ static void spapr_machine_3_1_class_options(MachineClass *mc)
     smc->default_caps.caps[SPAPR_CAP_SBBC] = SPAPR_CAP_BROKEN;
     smc->default_caps.caps[SPAPR_CAP_IBS] = SPAPR_CAP_BROKEN;
     smc->default_caps.caps[SPAPR_CAP_LARGE_DECREMENTER] = SPAPR_CAP_OFF;
+    smc->default_caps.caps[SPAPR_CAP_FWNMI_MCE] = SPAPR_CAP_OFF;
 }
 
 DEFINE_SPAPR_MACHINE(3_1, "3.1", false);
diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
index a015a80..e010cb2 100644
--- a/hw/ppc/spapr_rtas.c
+++ b/hw/ppc/spapr_rtas.c
@@ -49,6 +49,7 @@
 #include "hw/ppc/fdt.h"
 #include "target/ppc/mmu-hash64.h"
 #include "target/ppc/mmu-book3s-v3.h"
+#include "migration/blocker.h"
 
 static void rtas_display_character(PowerPCCPU *cpu, SpaprMachineState *spapr,
                                    uint32_t token, uint32_t nargs,
@@ -352,6 +353,60 @@ static void rtas_get_power_level(PowerPCCPU *cpu, SpaprMachineState *spapr,
     rtas_st(rets, 1, 100);
 }
 
+static void rtas_ibm_nmi_register(PowerPCCPU *cpu,
+                                  SpaprMachineState *spapr,
+                                  uint32_t token, uint32_t nargs,
+                                  target_ulong args,
+                                  uint32_t nret, target_ulong rets)
+{
+    int ret;
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
+    ret = kvmppc_fwnmi_enable(cpu);
+    if (ret == 1) {
+        rtas_st(rets, 0, RTAS_OUT_NOT_SUPPORTED);
+        return;
+    } else if (ret < 0) {
+        error_report("Couldn't enable KVM FWNMI capability");
+        rtas_st(rets, 0, RTAS_OUT_HW_ERROR);
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
+        migrate_del_blocker(spapr->fwnmi_migration_blocker);
+        rtas_st(rets, 0, RTAS_OUT_SUCCESS);
+    }
+}
+
 static struct rtas_call {
     const char *name;
     spapr_rtas_fn fn;
@@ -496,6 +551,14 @@ hwaddr spapr_get_rtas_addr(void)
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
index 0dedf0a..7ae53e2 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -637,8 +637,10 @@ target_ulong spapr_hypercall(PowerPCCPU *cpu, target_ulong opcode,
 #define RTAS_IBM_CREATE_PE_DMA_WINDOW           (RTAS_TOKEN_BASE + 0x27)
 #define RTAS_IBM_REMOVE_PE_DMA_WINDOW           (RTAS_TOKEN_BASE + 0x28)
 #define RTAS_IBM_RESET_PE_DMA_WINDOW            (RTAS_TOKEN_BASE + 0x29)
+#define RTAS_IBM_NMI_REGISTER                   (RTAS_TOKEN_BASE + 0x2A)
+#define RTAS_IBM_NMI_INTERLOCK                  (RTAS_TOKEN_BASE + 0x2B)
 
-#define RTAS_TOKEN_MAX                          (RTAS_TOKEN_BASE + 0x2A)
+#define RTAS_TOKEN_MAX                          (RTAS_TOKEN_BASE + 0x2C)
 
 /* RTAS ibm,get-system-parameter token values */
 #define RTAS_SYSPARM_SPLPAR_CHARACTERISTICS      20
@@ -894,4 +896,5 @@ void spapr_check_pagesize(SpaprMachineState *spapr, hwaddr pagesize,
 
 void spapr_set_all_lpcrs(target_ulong value, target_ulong mask);
 hwaddr spapr_get_rtas_addr(void);
+void spapr_fwnmi_register(void);
 #endif /* HW_SPAPR_H */



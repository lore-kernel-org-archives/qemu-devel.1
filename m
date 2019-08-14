Return-Path: <SRS0=fB5B=WK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6286C0650F
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 06:15:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C7BB208C2
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 06:15:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C7BB208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxmYv-0007Rm-76
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 02:15:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52442)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aravinda@linux.vnet.ibm.com>) id 1hxmVJ-0002ZB-In
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 02:11:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aravinda@linux.vnet.ibm.com>) id 1hxmVF-0006jT-OH
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 02:11:23 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:20152)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aravinda@linux.vnet.ibm.com>)
 id 1hxmVE-0006Zn-G4
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 02:11:20 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x7E673pD023102
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2019 02:11:15 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2uc9nexcwa-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2019 02:11:15 -0400
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <aravinda@linux.vnet.ibm.com>;
 Wed, 14 Aug 2019 07:11:14 +0100
Received: from b03cxnp08025.gho.boulder.ibm.com (9.17.130.17)
 by e32.co.us.ibm.com (192.168.1.132) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 14 Aug 2019 07:11:12 +0100
Received: from b03ledav004.gho.boulder.ibm.com
 (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x7E6BBxF52625856
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 14 Aug 2019 06:11:11 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 327F27805C;
 Wed, 14 Aug 2019 06:11:11 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0A4A978060;
 Wed, 14 Aug 2019 06:11:09 +0000 (GMT)
Received: from [127.0.1.1] (unknown [9.124.31.79])
 by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
 Wed, 14 Aug 2019 06:11:08 +0000 (GMT)
From: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
To: aik@au1.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 david@gibson.dropbear.id.au
Date: Wed, 14 Aug 2019 11:41:07 +0530
In-Reply-To: <156576293464.29984.1631520917528142744.stgit@aravinda>
References: <156576293464.29984.1631520917528142744.stgit@aravinda>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19081406-0004-0000-0000-00001535AEB8
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011590; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01246559; UDB=6.00657833; IPR=6.01028066; 
 MB=3.00028170; MTD=3.00000008; XFM=3.00000015; UTC=2019-08-14 06:11:14
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19081406-0005-0000-0000-00008CDE9E00
Message-Id: <156576306787.29984.3922767345151790072.stgit@aravinda>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-08-14_02:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908140060
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
Subject: [Qemu-devel] [patch-for-4.2 PATCH v11 2/6] ppc: spapr: Introduce
 FWNMI capability
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

Introduce the KVM capability KVM_CAP_PPC_FWNMI so that
the KVM causes guest exit with NMI as exit reason
when it encounters a machine check exception on the
address belonging to a guest. Without this capability
enabled, KVM redirects machine check exceptions to
guest's 0x200 vector.

This patch also introduces fwnmi-mce capability to
deal with the case when a guest with the
KVM_CAP_PPC_FWNMI capability enabled is attempted
to migrate to a host that does not support this
capability.

Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
---
 hw/ppc/spapr.c         |    1 +
 hw/ppc/spapr_caps.c    |   29 +++++++++++++++++++++++++++++
 include/hw/ppc/spapr.h |    4 +++-
 target/ppc/kvm.c       |   22 ++++++++++++++++++++++
 target/ppc/kvm_ppc.h   |   11 +++++++++++
 5 files changed, 66 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 855e9fb..07714cb 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4463,6 +4463,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
     smc->default_caps.caps[SPAPR_CAP_NESTED_KVM_HV] = SPAPR_CAP_OFF;
     smc->default_caps.caps[SPAPR_CAP_LARGE_DECREMENTER] = SPAPR_CAP_ON;
     smc->default_caps.caps[SPAPR_CAP_CCF_ASSIST] = SPAPR_CAP_OFF;
+    smc->default_caps.caps[SPAPR_CAP_FWNMI_MCE] = SPAPR_CAP_OFF;
     spapr_caps_add_properties(smc, &error_abort);
     smc->irq = &spapr_irq_dual;
     smc->dr_phb_enabled = true;
diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index 0263c78..5448123 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -481,6 +481,25 @@ static void cap_ccf_assist_apply(SpaprMachineState *spapr, uint8_t val,
     }
 }
 
+static void cap_fwnmi_mce_apply(SpaprMachineState *spapr, uint8_t val,
+                                Error **errp)
+{
+    if (!val) {
+        return; /* Disabled by default */
+    }
+
+    if (tcg_enabled()) {
+        /*
+         * TCG support may not be correct in some conditions (e.g., in case
+         * of software injected faults like duplicate SLBs).
+         */
+        warn_report("Firmware Assisted Non-Maskable Interrupts not supported in TCG");
+    } else if (kvm_enabled() && !kvmppc_has_cap_ppc_fwnmi()) {
+        error_setg(errp,
+"Firmware Assisted Non-Maskable Interrupts not supported by KVM, try cap-fwnmi-mce=off");
+    }
+}
+
 SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
     [SPAPR_CAP_HTM] = {
         .name = "htm",
@@ -580,6 +599,15 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
         .type = "bool",
         .apply = cap_ccf_assist_apply,
     },
+    [SPAPR_CAP_FWNMI_MCE] = {
+        .name = "fwnmi-mce",
+        .description = "Handle fwnmi machine check exceptions",
+        .index = SPAPR_CAP_FWNMI_MCE,
+        .get = spapr_cap_get_bool,
+        .set = spapr_cap_set_bool,
+        .type = "bool",
+        .apply = cap_fwnmi_mce_apply,
+    },
 };
 
 static SpaprCapabilities default_caps_with_cpu(SpaprMachineState *spapr,
@@ -719,6 +747,7 @@ SPAPR_CAP_MIG_STATE(hpt_maxpagesize, SPAPR_CAP_HPT_MAXPAGESIZE);
 SPAPR_CAP_MIG_STATE(nested_kvm_hv, SPAPR_CAP_NESTED_KVM_HV);
 SPAPR_CAP_MIG_STATE(large_decr, SPAPR_CAP_LARGE_DECREMENTER);
 SPAPR_CAP_MIG_STATE(ccf_assist, SPAPR_CAP_CCF_ASSIST);
+SPAPR_CAP_MIG_STATE(fwnmi, SPAPR_CAP_FWNMI_MCE);
 
 void spapr_caps_init(SpaprMachineState *spapr)
 {
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index fa7c380..01c106f 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -79,8 +79,10 @@ typedef enum {
 #define SPAPR_CAP_LARGE_DECREMENTER     0x08
 /* Count Cache Flush Assist HW Instruction */
 #define SPAPR_CAP_CCF_ASSIST            0x09
+/* FWNMI machine check handling */
+#define SPAPR_CAP_FWNMI_MCE             0x0A
 /* Num Caps */
-#define SPAPR_CAP_NUM                   (SPAPR_CAP_CCF_ASSIST + 1)
+#define SPAPR_CAP_NUM                   (SPAPR_CAP_FWNMI_MCE + 1)
 
 /*
  * Capability Values
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 5ab5e6c..c922bcb 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -83,6 +83,7 @@ static int cap_ppc_safe_indirect_branch;
 static int cap_ppc_count_cache_flush_assist;
 static int cap_ppc_nested_kvm_hv;
 static int cap_large_decr;
+static int cap_ppc_fwnmi;
 
 static uint32_t debug_inst_opcode;
 
@@ -2053,6 +2054,22 @@ void kvmppc_set_mpic_proxy(PowerPCCPU *cpu, int mpic_proxy)
     }
 }
 
+int kvmppc_set_fwnmi(void)
+{
+    PowerPCCPU *cpu = POWERPC_CPU(first_cpu);
+    CPUState *cs = CPU(cpu);
+    int ret;
+
+    ret = kvm_vcpu_enable_cap(cs, KVM_CAP_PPC_FWNMI, 0);
+    if (ret) {
+        error_report("This KVM version does not support FWNMI");
+        return ret;
+    }
+
+    cap_ppc_fwnmi = 1;
+    return ret;
+}
+
 int kvmppc_smt_threads(void)
 {
     return cap_ppc_smt ? cap_ppc_smt : 1;
@@ -2353,6 +2370,11 @@ bool kvmppc_has_cap_mmu_hash_v3(void)
     return cap_mmu_hash_v3;
 }
 
+bool kvmppc_has_cap_ppc_fwnmi(void)
+{
+    return cap_ppc_fwnmi;
+}
+
 static bool kvmppc_power8_host(void)
 {
     bool ret = false;
diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
index 98bd7d5..2990898 100644
--- a/target/ppc/kvm_ppc.h
+++ b/target/ppc/kvm_ppc.h
@@ -27,6 +27,8 @@ void kvmppc_enable_h_page_init(void);
 void kvmppc_set_papr(PowerPCCPU *cpu);
 int kvmppc_set_compat(PowerPCCPU *cpu, uint32_t compat_pvr);
 void kvmppc_set_mpic_proxy(PowerPCCPU *cpu, int mpic_proxy);
+int kvmppc_set_fwnmi(void);
+bool kvmppc_has_cap_ppc_fwnmi(void);
 int kvmppc_smt_threads(void);
 void kvmppc_hint_smt_possible(Error **errp);
 int kvmppc_set_smt_threads(int smt);
@@ -159,6 +161,15 @@ static inline void kvmppc_set_mpic_proxy(PowerPCCPU *cpu, int mpic_proxy)
 {
 }
 
+static inline int kvmppc_set_fwnmi(void)
+{
+}
+
+static inline bool kvmppc_has_cap_ppc_fwnmi(void)
+{
+    return false;
+}
+
 static inline int kvmppc_smt_threads(void)
 {
     return 1;



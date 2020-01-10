Return-Path: <SRS0=GavZ=27=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A2F8C282DD
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 15:16:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D276C2080D
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 15:16:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D276C2080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipw1H-0003XR-Kv
	for qemu-devel@archiver.kernel.org; Fri, 10 Jan 2020 10:16:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49668)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <farosas@linux.ibm.com>) id 1ipvz9-0001MA-78
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 10:14:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <farosas@linux.ibm.com>) id 1ipvz6-0000tO-RT
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 10:14:03 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:14024
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <farosas@linux.ibm.com>)
 id 1ipvz6-0000rr-LF; Fri, 10 Jan 2020 10:14:00 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 00AFC6Gb040959; Fri, 10 Jan 2020 10:13:56 -0500
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2xereh6f7u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Jan 2020 10:13:55 -0500
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 00AFCGh3041791;
 Fri, 10 Jan 2020 10:13:55 -0500
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com
 [169.53.41.122])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2xereh6f7j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Jan 2020 10:13:55 -0500
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
 by ppma04dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 00AFC0lb005683;
 Fri, 10 Jan 2020 15:13:54 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by ppma04dal.us.ibm.com with ESMTP id 2xajb7nh0y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Jan 2020 15:13:54 +0000
Received: from b03ledav006.gho.boulder.ibm.com
 (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 00AFDqBu51184060
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 10 Jan 2020 15:13:53 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DAB54C605A;
 Fri, 10 Jan 2020 15:13:52 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 855D9C605D;
 Fri, 10 Jan 2020 15:13:51 +0000 (GMT)
Received: from farosas.linux.ibm.com.br.ibm.com (unknown [9.86.27.174])
 by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
 Fri, 10 Jan 2020 15:13:51 +0000 (GMT)
From: Fabiano Rosas <farosas@linux.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 3/3] target/ppc: support single stepping with KVM HV
Date: Fri, 10 Jan 2020 12:13:44 -0300
Message-Id: <20200110151344.278471-4-farosas@linux.ibm.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200110151344.278471-1-farosas@linux.ibm.com>
References: <20200110151344.278471-1-farosas@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-01-10_01:2020-01-10,
 2020-01-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 spamscore=0
 impostorscore=0 malwarescore=0 suspectscore=1 phishscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 mlxlogscore=946 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-2001100129
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.158.5
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The hardware singlestep mechanism in POWER works via a Trace Interrupt
(0xd00) that happens after any instruction executes, whenever MSR_SE =
1 (PowerISA Section 6.5.15 - Trace Interrupt).

However, with kvm_hv, the Trace Interrupt happens inside the guest and
KVM has no visibility of it. Therefore, when the gdbstub uses the
KVM_SET_GUEST_DEBUG ioctl to enable singlestep, KVM simply ignores it.

This patch takes advantage of the Trace Interrupt to perform the step
inside the guest, but uses a breakpoint at the Trace Interrupt handler
to return control to KVM. The exit is treated by KVM as a regular
breakpoint and it returns to the host (and QEMU eventually).

Before signalling GDB, QEMU sets the Next Instruction Pointer to the
instruction following the one being stepped and restores the MSR,
SRR0, SRR1 values from before the step, effectively skipping the
interrupt handler execution and hiding the trace interrupt breakpoint
from GDB.

This approach works with both of GDB's 'scheduler-locking' options
(off, step).

Note:

- kvm_arch_emulate_singlestep happens after GDB asks for a single step,
  while the vcpus are stopped.

- kvm_handle_singlestep executes after the step, during the handling
  of the Emulation Assist Interrupt (breakpoint).

Signed-off-by: Fabiano Rosas <farosas@linux.ibm.com>
---
 hw/ppc/spapr_hcall.c     |   5 +
 target/ppc/cpu.h         |  21 +++
 target/ppc/excp_helper.c |  15 ++
 target/ppc/kvm.c         | 330 ++++++++++++++++++++++++++++++++++++++-
 target/ppc/kvm_ppc.h     |   6 +-
 5 files changed, 369 insertions(+), 8 deletions(-)

diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index f1799b1b70..194b68ed22 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1382,6 +1382,7 @@ static target_ulong h_set_mode_resource_addr_trans_mode(PowerPCCPU *cpu,
                                                         target_ulong value1,
                                                         target_ulong value2)
 {
+    CPUState *cs = CPU(cpu);
     PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
 
     if (!(pcc->insns_flags2 & PPC2_ISA207S)) {
@@ -1400,6 +1401,10 @@ static target_ulong h_set_mode_resource_addr_trans_mode(PowerPCCPU *cpu,
 
     spapr_set_all_lpcrs(mflags << LPCR_AIL_SHIFT, LPCR_AIL);
 
+    if (cs->singlestep_enabled && kvm_enabled()) {
+        kvm_singlestep_ail_change(cs);
+    }
+
     return H_SUCCESS;
 }
 
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 103bfe9dc2..b69f8565aa 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -440,6 +440,10 @@ typedef struct ppc_v3_pate_t {
 #define msr_ts   ((env->msr >> MSR_TS1)  & 3)
 #define msr_tm   ((env->msr >> MSR_TM)   & 1)
 
+#define srr1_ir ((env->spr[SPR_SRR1] >> MSR_IR) & 1)
+#define srr1_dr ((env->spr[SPR_SRR1] >> MSR_DR) & 1)
+#define srr1_se ((env->spr[SPR_SRR1] >> MSR_SE) & 1)
+
 #define DBCR0_ICMP (1 << 27)
 #define DBCR0_BRT (1 << 26)
 #define DBSR_ICMP (1 << 27)
@@ -1158,6 +1162,16 @@ struct CPUPPCState {
     uint32_t tm_vscr;
     uint64_t tm_dscr;
     uint64_t tm_tar;
+
+    /* Used for software single step */
+    target_ulong sstep_srr0;
+    target_ulong sstep_srr1;
+    target_ulong sstep_insn;
+    target_ulong trace_handler_addr;
+    int sstep_kind;
+#define SSTEP_REGULAR 0
+#define SSTEP_PENDING 1
+#define SSTEP_GUEST   2
 };
 
 #define SET_FIT_PERIOD(a_, b_, c_, d_)          \
@@ -1251,6 +1265,7 @@ struct PPCVirtualHypervisorClass {
     OBJECT_GET_CLASS(PPCVirtualHypervisorClass, (obj), \
                      TYPE_PPC_VIRTUAL_HYPERVISOR)
 
+target_ulong ppc_get_trace_int_handler_addr(CPUState *cs, bool mmu_on);
 void ppc_cpu_do_interrupt(CPUState *cpu);
 bool ppc_cpu_exec_interrupt(CPUState *cpu, int int_req);
 void ppc_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
@@ -2220,6 +2235,12 @@ enum {
                         PPC2_ISA300)
 };
 
+#define OP_RFID 19
+#define XOP_RFID 18
+#define OP_MOV 31
+#define XOP_MFMSR 83
+#define XOP_MTSPR 467
+
 /*****************************************************************************/
 /*
  * Memory access type :
diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 5752ed4a4d..87230f871a 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -784,6 +784,21 @@ static inline void powerpc_excp(PowerPCCPU *cpu, int excp_model, int excp)
     check_tlb_flush(env, false);
 }
 
+target_ulong ppc_get_trace_int_handler_addr(CPUState *cs, bool mmu_on)
+{
+    PowerPCCPU *cpu = POWERPC_CPU(cs);
+    CPUPPCState *env = &cpu->env;
+    int ail = AIL_NONE;
+
+    /* AIL is only used if translation is enabled */
+    if (mmu_on) {
+        ail = (env->spr[SPR_LPCR] & LPCR_AIL) >> LPCR_AIL_SHIFT;
+    }
+
+    return env->excp_vectors[POWERPC_EXCP_TRACE] |
+        ppc_excp_vector_offset(cs, ail);
+}
+
 void ppc_cpu_do_interrupt(CPUState *cs)
 {
     PowerPCCPU *cpu = POWERPC_CPU(cs);
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 6fb8687126..2b6cba59c8 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -1546,6 +1546,202 @@ void kvm_arch_remove_all_hw_breakpoints(void)
     nb_hw_breakpoint = nb_hw_watchpoint = 0;
 }
 
+static uint32_t ppc_gdb_read_insn(CPUState *cs, target_ulong addr)
+{
+    PowerPCCPU *cpu = POWERPC_CPU(cs);
+    CPUPPCState *env = &cpu->env;
+    uint32_t insn;
+
+    cpu_memory_rw_debug(cs, addr, (uint8_t *)&insn, sizeof(insn), 0);
+
+    if (msr_le) {
+        return ldl_le_p(&insn);
+    } else {
+        return ldl_be_p(&insn);
+    }
+}
+
+static uint32_t ppc_gdb_get_op(uint32_t insn)
+{
+    return extract32(insn, 26, 6);
+}
+
+static uint32_t ppc_gdb_get_xop(uint32_t insn)
+{
+    return extract32(insn, 1, 10);
+}
+
+static uint32_t ppc_gdb_get_spr(uint32_t insn)
+{
+    return extract32(insn, 11, 5) << 5 | extract32(insn, 16, 5);
+}
+
+static uint32_t ppc_gdb_get_rt(uint32_t insn)
+{
+    return extract32(insn, 21, 5);
+}
+
+static void kvm_insert_singlestep_breakpoint(CPUState *cs, bool mmu_on)
+{
+    PowerPCCPU *cpu = POWERPC_CPU(cs);
+    CPUPPCState *env = &cpu->env;
+    target_ulong bp_addr;
+    target_ulong saved_msr = env->msr;
+
+    bp_addr = ppc_get_trace_int_handler_addr(cs, mmu_on);
+    if (env->nip == bp_addr) {
+        /*
+         * We are trying to step the interrupt handler address itself;
+         * move the breakpoint to the next instruction.
+         */
+        bp_addr += 4;
+    }
+
+    /*
+     * The actual access by the guest might be made in a mode
+     * different than we are now (due to rfid) so temporarily set the
+     * MSR to reflect that during the breakpoint placement.
+     *
+     * Note: we need this because breakpoints currently use
+     * cpu_memory_rw_debug, which does the memory accesses from the
+     * guest point of view.
+     */
+    if ((msr_ir & msr_dr) != mmu_on) {
+        if (mmu_on) {
+            env->msr |= (1ULL << MSR_IR | 1ULL << MSR_DR);
+        } else {
+            env->msr &= ~(1ULL << MSR_IR | 1ULL << MSR_DR);
+        }
+    }
+
+    kvm_insert_breakpoint(cs, bp_addr, 4, GDB_BREAKPOINT_SW);
+    env->trace_handler_addr = bp_addr;
+    env->msr = saved_msr;
+}
+
+/*
+ * The emulated singlestep works by forcing a Trace Interrupt inside
+ * the guest by setting its MSR_SE bit.  When the guest executes the
+ * instruction, the Trace Interrupt triggers and the step is done. We
+ * then need to hide the fact that the interrupt ever happened before
+ * returning into the guest.
+ *
+ * Since the Trace Interrupt does not set MSR_HV (the whole point of
+ * having to emulate the step), we set a breakpoint at the interrupt
+ * handler address (0xd00) so that it reaches KVM (this is treated by
+ * KVM like an ordinary breakpoint) and control is returned to QEMU.
+ *
+ * There are things to consider before the step (this function):
+ *
+ * - The breakpoint location depends on where the interrupt vectors are,
+ *   which in turn depends on the LPCR_AIL and MSR_IR|DR bits;
+ *
+ * - If the stepped instruction changes the LPCR_AIL, the breakpoint
+ *   location needs to be updated mid-step;
+ *
+ * - If the stepped instruction is rfid, the MSR bits after the step
+ *   will come from SRR1.
+ *
+ *
+ * There are some fixups needed after the step, before returning to
+ * the guest (kvm_handle_singlestep):
+ *
+ * - The interrupt will set SRR0 and SRR1, so we need to restore them
+ *   to what they were before the interrupt;
+ *
+ * - If the stepped instruction wrote to the SRRs, we need to avoid
+ *   undoing that;
+ *
+ * - We set the MSR_SE bit, so it needs to be cleared.
+ *
+ */
+void kvm_arch_emulate_singlestep(CPUState *cs, int enabled)
+{
+    PowerPCCPU *cpu = POWERPC_CPU(cs);
+    CPUPPCState *env = &cpu->env;
+    uint32_t insn;
+    bool rfid, mmu_on;
+
+    if (!enabled) {
+        return;
+    }
+
+    if (env->sstep_kind != SSTEP_PENDING) {
+        env->sstep_kind = SSTEP_REGULAR;
+    }
+
+    cpu_synchronize_state(cs);
+    insn = ppc_gdb_read_insn(cs, env->nip);
+
+    /*
+     * rfid needs special handling because it:
+     *   - overwrites NIP with SRR0;
+     *   - overwrites MSR with SRR1;
+     *   - cannot be single stepped.
+     */
+    rfid = ppc_gdb_get_op(insn) == OP_RFID && ppc_gdb_get_xop(insn) == XOP_RFID;
+
+    if (rfid && (kvm_find_sw_breakpoint(cs, env->spr[SPR_SRR0]) ||
+                 env->sstep_kind == SSTEP_PENDING)) {
+        /*
+         * There is a breakpoint at the next instruction address or a
+         * pending step. It will already cause the vm exit we need for
+         * the single step, so there's nothing to be done.
+         */
+        env->sstep_kind = SSTEP_REGULAR;
+        return;
+    }
+
+    /*
+     * Save the registers that will be affected by the single step
+     * mechanism. These will be used after the step.
+     */
+    env->sstep_srr0 = env->spr[SPR_SRR0];
+    env->sstep_srr1 = env->spr[SPR_SRR1];
+    env->sstep_insn = insn;
+
+    /*
+     * MSR_SE = 1 will cause a Trace Interrupt in the guest after the
+     * next instruction executes. If this is a rfid, use SRR1 instead
+     * of MSR.
+     */
+    if (rfid) {
+        if ((env->spr[SPR_SRR1] >> MSR_SE) & 1) {
+            /*
+             * The guest is doing a single step itself. Make sure we
+             * restore it later.
+             */
+            env->sstep_kind = SSTEP_GUEST;
+        }
+
+        env->spr[SPR_SRR1] |= (1ULL << MSR_SE);
+        mmu_on = srr1_ir & srr1_dr;
+    } else {
+        env->msr |= (1ULL << MSR_SE);
+        mmu_on = msr_ir & msr_dr;
+    }
+
+    kvm_insert_singlestep_breakpoint(cs, mmu_on);
+}
+
+void kvm_singlestep_ail_change(CPUState *cs)
+{
+    PowerPCCPU *cpu = POWERPC_CPU(cs);
+    CPUPPCState *env = &cpu->env;
+
+    if (kvm_arch_can_singlestep(cs)) {
+        return;
+    }
+
+    /*
+     * The instruction being stepped altered the interrupt vectors
+     * location (AIL). Re-insert the single step breakpoint at the new
+     * location
+     */
+    kvm_remove_breakpoint(cs, env->trace_handler_addr, 4, GDB_BREAKPOINT_SW);
+    kvm_insert_singlestep_breakpoint(cs, (msr_ir & msr_dr));
+}
+
 void kvm_arch_update_guest_debug(CPUState *cs, struct kvm_guest_debug *dbg)
 {
     int n;
@@ -1585,6 +1781,98 @@ void kvm_arch_update_guest_debug(CPUState *cs, struct kvm_guest_debug *dbg)
     }
 }
 
+/* Revert any side-effects caused during single step */
+static void restore_singlestep_env(CPUState *cs)
+{
+    PowerPCCPU *cpu = POWERPC_CPU(cs);
+    CPUPPCState *env = &cpu->env;
+    uint32_t insn = env->sstep_insn;
+    int reg;
+    int spr;
+
+    env->spr[SPR_SRR0] = env->sstep_srr0;
+    env->spr[SPR_SRR1] = env->sstep_srr1;
+
+    if (ppc_gdb_get_op(insn) != OP_MOV) {
+        return;
+    }
+
+    reg = ppc_gdb_get_rt(insn);
+
+    switch (ppc_gdb_get_xop(insn)) {
+    case XOP_MTSPR:
+        /*
+         * mtspr: the guest altered the SRR, so do not use the
+         *        pre-step value.
+         */
+        spr = ppc_gdb_get_spr(insn);
+        if (spr == SPR_SRR0 || spr == SPR_SRR1) {
+            env->spr[spr] = env->gpr[reg];
+        }
+        break;
+    case XOP_MFMSR:
+        /*
+         * mfmsr: clear MSR_SE bit to avoid the guest knowing
+         *         that it is being single-stepped.
+         */
+        env->gpr[reg] &= ~(1ULL << MSR_SE);
+        break;
+    }
+}
+
+static int kvm_handle_singlestep(CPUState *cs, target_ulong address)
+{
+    PowerPCCPU *cpu = POWERPC_CPU(cs);
+    CPUPPCState *env = &cpu->env;
+
+    if (kvm_arch_can_singlestep(cs)) {
+        return DEBUG_RETURN_GDB;
+    }
+
+    cpu_synchronize_state(cs);
+
+    if (address == env->trace_handler_addr) {
+        kvm_remove_breakpoint(cs, env->trace_handler_addr, 4,
+                              GDB_BREAKPOINT_SW);
+
+        if (env->sstep_kind == SSTEP_GUEST) {
+            /*
+             * The guest expects the last instruction to have caused a
+             * single step, go back into the interrupt handler.
+             */
+            env->sstep_kind = SSTEP_REGULAR;
+            return DEBUG_RETURN_GDB;
+        }
+
+        env->nip = env->spr[SPR_SRR0];
+        /* Bits 33-36, 43-47 are set by the interrupt */
+        env->msr = env->spr[SPR_SRR1] & ~(1ULL << MSR_SE |
+                                          PPC_BITMASK(33, 36) |
+                                          PPC_BITMASK(43, 47));
+        restore_singlestep_env(cs);
+
+    } else if (address == env->trace_handler_addr + 4) {
+        /*
+         * A step at trace_handler_addr would interfere with the
+         * single step mechanism itself, so we have previously
+         * displaced the breakpoint to the next instruction.
+         */
+        kvm_remove_breakpoint(cs, env->trace_handler_addr + 4, 4,
+                              GDB_BREAKPOINT_SW);
+        restore_singlestep_env(cs);
+    } else {
+        /*
+         * Another interrupt (e.g. system call, program interrupt)
+         * took us somewhere else in the code and we hit a breakpoint
+         * there. Mark the step as pending.
+         */
+        env->sstep_kind = SSTEP_PENDING;
+    }
+
+    cs->singlestep_enabled = false;
+    return DEBUG_RETURN_GDB;
+}
+
 static int kvm_handle_hw_breakpoint(CPUState *cs,
                                     struct kvm_debug_exit_arch *arch_info)
 {
@@ -1612,13 +1900,41 @@ static int kvm_handle_hw_breakpoint(CPUState *cs,
     return handle;
 }
 
-static int kvm_handle_singlestep(void)
+static int kvm_handle_sw_breakpoint(CPUState *cs, target_ulong address)
 {
-    return DEBUG_RETURN_GDB;
-}
+    PowerPCCPU *cpu = POWERPC_CPU(cs);
+    CPUPPCState *env = &cpu->env;
+
+    if (kvm_arch_can_singlestep(cs)) {
+        return DEBUG_RETURN_GDB;
+    }
+
+    cpu_synchronize_state(cs);
+
+    if (address == env->trace_handler_addr) {
+        if (env->sstep_kind == SSTEP_PENDING) {
+            /*
+             * Although we have singlestep_enabled == false by now,
+             * the original step still wasn't handled (is pending).
+             */
+            cs->singlestep_enabled = true;
+            env->sstep_kind = SSTEP_REGULAR;
+
+            return kvm_handle_singlestep(cs, address);
+        }
+
+        CPU_FOREACH(cs) {
+            if (cs->singlestep_enabled) {
+                /*
+                 * We hit this breakpoint while another cpu is doing a
+                 * software single step. Go back into the guest to
+                 * give chance for the single step to finish.
+                 */
+                return DEBUG_RETURN_GUEST;
+            }
+        }
+    }
 
-static int kvm_handle_sw_breakpoint(void)
-{
     return DEBUG_RETURN_GDB;
 }
 
@@ -1629,7 +1945,7 @@ static int kvm_handle_debug(PowerPCCPU *cpu, struct kvm_run *run)
     struct kvm_debug_exit_arch *arch_info = &run->debug.arch;
 
     if (cs->singlestep_enabled) {
-        return kvm_handle_singlestep();
+        return kvm_handle_singlestep(cs, arch_info->address);
     }
 
     if (arch_info->status) {
@@ -1637,7 +1953,7 @@ static int kvm_handle_debug(PowerPCCPU *cpu, struct kvm_run *run)
     }
 
     if (kvm_find_sw_breakpoint(cs, arch_info->address)) {
-        return kvm_handle_sw_breakpoint();
+        return kvm_handle_sw_breakpoint(cs, arch_info->address);
     }
 
     /*
diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
index f22daabf51..dc1b6df422 100644
--- a/target/ppc/kvm_ppc.h
+++ b/target/ppc/kvm_ppc.h
@@ -81,7 +81,7 @@ bool kvmppc_hpt_needs_host_contiguous_pages(void);
 void kvm_check_mmu(PowerPCCPU *cpu, Error **errp);
 void kvmppc_set_reg_ppc_online(PowerPCCPU *cpu, unsigned int online);
 void kvmppc_set_reg_tb_offset(PowerPCCPU *cpu, int64_t tb_offset);
-
+void kvm_singlestep_ail_change(CPUState *cs);
 #else
 
 static inline uint32_t kvmppc_get_tbfreq(void)
@@ -211,6 +211,10 @@ static inline void kvmppc_set_reg_tb_offset(PowerPCCPU *cpu, int64_t tb_offset)
 {
 }
 
+static inline void kvm_singlestep_ail_change(CPUState *cs)
+{
+}
+
 #ifndef CONFIG_USER_ONLY
 static inline bool kvmppc_spapr_use_multitce(void)
 {
-- 
2.23.0



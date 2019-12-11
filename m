Return-Path: <SRS0=Q6KP=2B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD644C2D0C6
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 19:13:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97D7122527
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 19:13:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97D7122527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1if7QS-0003UH-EU
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 14:13:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46205)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <farosas@linux.ibm.com>) id 1if7NZ-0008Jz-O7
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 14:10:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <farosas@linux.ibm.com>) id 1if7NX-00022E-OJ
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 14:10:33 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:19898)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <farosas@linux.ibm.com>)
 id 1if7NX-00020e-IQ; Wed, 11 Dec 2019 14:10:31 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xBBJ0Pge104760; Wed, 11 Dec 2019 14:10:28 -0500
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2wtf6yqfxs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 11 Dec 2019 14:10:26 -0500
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id xBBJ0Ro1104841;
 Wed, 11 Dec 2019 14:10:24 -0500
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.11])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2wtf6yqfwf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 11 Dec 2019 14:10:24 -0500
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
 by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xBBJ19HC010412;
 Wed, 11 Dec 2019 19:10:23 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by ppma03dal.us.ibm.com with ESMTP id 2wr3q7s8gr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 11 Dec 2019 19:10:23 +0000
Received: from b03ledav006.gho.boulder.ibm.com
 (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xBBJALtg32244204
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 11 Dec 2019 19:10:21 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A22DEC605D;
 Wed, 11 Dec 2019 19:10:21 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 42D84C6069;
 Wed, 11 Dec 2019 19:10:20 +0000 (GMT)
Received: from farosas.linux.ibm.com.br.ibm.com (unknown [9.86.27.131])
 by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
 Wed, 11 Dec 2019 19:10:20 +0000 (GMT)
From: Fabiano Rosas <farosas@linux.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 3/3] target/ppc: support single stepping with KVM HV
Date: Wed, 11 Dec 2019 16:10:13 -0300
Message-Id: <20191211191013.454125-4-farosas@linux.ibm.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191211191013.454125-1-farosas@linux.ibm.com>
References: <20191211191013.454125-1-farosas@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-11_05:2019-12-11,2019-12-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 priorityscore=1501 adultscore=0 clxscore=1015 malwarescore=0
 suspectscore=1 impostorscore=0 bulkscore=0 phishscore=0 spamscore=0
 mlxscore=0 mlxlogscore=557 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912110156
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

- kvm_arch_set_singlestep happens after GDB asks for a single step,
  while the vcpus are stopped.

- kvm_handle_singlestep executes after the step, during the handling
  of the Emulation Assist Interrupt (breakpoint).

Signed-off-by: Fabiano Rosas <farosas@linux.ibm.com>
---
 target/ppc/cpu.h         |  16 ++++
 target/ppc/excp_helper.c |  13 +++
 target/ppc/gdbstub.c     |  35 +++++++
 target/ppc/kvm.c         | 195 +++++++++++++++++++++++++++++++++++++--
 4 files changed, 252 insertions(+), 7 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index e3e82327b7..37119cd0b4 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1156,6 +1156,11 @@ struct CPUPPCState {
     uint32_t tm_vscr;
     uint64_t tm_dscr;
     uint64_t tm_tar;
+
+    /* Used for software single step */
+    target_ulong sstep_msr;
+    target_ulong sstep_srr0;
+    target_ulong sstep_srr1;
 };
 
 #define SET_FIT_PERIOD(a_, b_, c_, d_)          \
@@ -1253,6 +1258,7 @@ struct PPCVirtualHypervisorClass {
     OBJECT_GET_CLASS(PPCVirtualHypervisorClass, (obj), \
                      TYPE_PPC_VIRTUAL_HYPERVISOR)
 
+target_ulong ppc_get_trace_int_handler_addr(CPUState *cs);
 void ppc_cpu_do_interrupt(CPUState *cpu);
 bool ppc_cpu_exec_interrupt(CPUState *cpu, int int_req);
 void ppc_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
@@ -1266,6 +1272,12 @@ int ppc_cpu_gdb_write_register_apple(CPUState *cpu, uint8_t *buf, int reg);
 void ppc_gdb_gen_spr_xml(PowerPCCPU *cpu);
 const char *ppc_gdb_get_dynamic_xml(CPUState *cs, const char *xml_name);
 #endif
+uint32_t ppc_gdb_read_insn(CPUState *cs, target_ulong addr);
+uint32_t ppc_gdb_get_op(uint32_t insn);
+uint32_t ppc_gdb_get_xop(uint32_t insn);
+uint32_t ppc_gdb_get_spr(uint32_t insn);
+uint32_t ppc_gdb_get_rt(uint32_t insn);
+
 int ppc64_cpu_write_elf64_note(WriteCoreDumpFunction f, CPUState *cs,
                                int cpuid, void *opaque);
 int ppc32_cpu_write_elf32_note(WriteCoreDumpFunction f, CPUState *cs,
@@ -2217,6 +2229,10 @@ enum {
                         PPC2_ISA300)
 };
 
+#define XOP_RFID 18
+#define XOP_MFMSR 83
+#define XOP_MTSPR 467
+
 /*****************************************************************************/
 /*
  * Memory access type :
diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 50b004d00d..8ce395004a 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -112,6 +112,8 @@ static uint64_t ppc_excp_vector_offset(CPUState *cs, int ail)
     uint64_t offset = 0;
 
     switch (ail) {
+    case AIL_NONE:
+        break;
     case AIL_0001_8000:
         offset = 0x18000;
         break;
@@ -782,6 +784,17 @@ static inline void powerpc_excp(PowerPCCPU *cpu, int excp_model, int excp)
     check_tlb_flush(env, false);
 }
 
+target_ulong ppc_get_trace_int_handler_addr(CPUState *cs)
+{
+    PowerPCCPU *cpu = POWERPC_CPU(cs);
+    CPUPPCState *env = &cpu->env;
+    int ail;
+
+    ail = (env->spr[SPR_LPCR] & LPCR_AIL) >> LPCR_AIL_SHIFT;
+    return env->excp_vectors[POWERPC_EXCP_TRACE] |
+        ppc_excp_vector_offset(cs, ail);
+}
+
 void ppc_cpu_do_interrupt(CPUState *cs)
 {
     PowerPCCPU *cpu = POWERPC_CPU(cs);
diff --git a/target/ppc/gdbstub.c b/target/ppc/gdbstub.c
index 823759c92e..540b767445 100644
--- a/target/ppc/gdbstub.c
+++ b/target/ppc/gdbstub.c
@@ -383,3 +383,38 @@ const char *ppc_gdb_get_dynamic_xml(CPUState *cs, const char *xml_name)
     return NULL;
 }
 #endif
+
+uint32_t ppc_gdb_read_insn(CPUState *cs, target_ulong addr)
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
+uint32_t ppc_gdb_get_op(uint32_t insn)
+{
+    return extract32(insn, 26, 6);
+}
+
+uint32_t ppc_gdb_get_xop(uint32_t insn)
+{
+    return extract32(insn, 1, 10);
+}
+
+uint32_t ppc_gdb_get_spr(uint32_t insn)
+{
+    return extract32(insn, 11, 5) << 5 | extract32(insn, 16, 5);
+}
+
+uint32_t ppc_gdb_get_rt(uint32_t insn)
+{
+    return extract32(insn, 21, 5);
+}
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 3a2cfe883c..fedb8e787d 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -1542,6 +1542,86 @@ void kvm_arch_remove_all_hw_breakpoints(void)
     nb_hw_breakpoint = nb_hw_watchpoint = 0;
 }
 
+void kvm_arch_set_singlestep(CPUState *cs, int enabled)
+{
+    PowerPCCPU *cpu = POWERPC_CPU(cs);
+    CPUPPCState *env = &cpu->env;
+    target_ulong trace_handler_addr;
+    uint32_t insn;
+    bool rfid;
+
+    if (!enabled) {
+        return;
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
+    rfid = ppc_gdb_get_op(insn) == 19 && ppc_gdb_get_xop(insn) == XOP_RFID;
+
+    if (rfid && kvm_find_sw_breakpoint(cs, env->spr[SPR_SRR0])) {
+        /*
+         * There is a breakpoint at the next instruction address. It
+         * will already cause the vm exit we need for the single step,
+         * so there's nothing to be done.
+         */
+        return;
+    }
+
+    /*
+     * Save the registers that will be affected by the single step
+     * mechanism. These will be restored after the step at
+     * kvm_handle_singlestep.
+     */
+    env->sstep_msr = env->msr;
+    env->sstep_srr0 = env->spr[SPR_SRR0];
+    env->sstep_srr1 = env->spr[SPR_SRR1];
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
+            env->sstep_msr |= (1ULL << MSR_SE);
+        }
+
+        env->spr[SPR_SRR1] |= (1ULL << MSR_SE);
+    } else {
+        env->msr |= (1ULL << MSR_SE);
+    }
+
+    /*
+     * We set a breakpoint at the interrupt handler address so
+     * that the singlestep will be seen by KVM (this is treated by
+     * KVM like an ordinary breakpoint) and control is returned to
+     * QEMU.
+     */
+    trace_handler_addr = ppc_get_trace_int_handler_addr(cs);
+
+    if (env->nip == trace_handler_addr) {
+        /*
+         * We are trying to step over the interrupt handler
+         * address itself; move the breakpoint to the next
+         * instruction.
+         */
+        trace_handler_addr += 4;
+    }
+
+    kvm_insert_breakpoint(cs, trace_handler_addr, 4, GDB_BREAKPOINT_SW);
+}
+
 void kvm_arch_update_guest_debug(CPUState *cs, struct kvm_guest_debug *dbg)
 {
     int n;
@@ -1581,6 +1661,91 @@ void kvm_arch_update_guest_debug(CPUState *cs, struct kvm_guest_debug *dbg)
     }
 }
 
+/* Revert any side-effects caused during single step */
+static void restore_singlestep_env(CPUState *cs)
+{
+    PowerPCCPU *cpu = POWERPC_CPU(cs);
+    CPUPPCState *env = &cpu->env;
+    uint32_t insn;
+    int reg;
+    int spr;
+
+    insn = ppc_gdb_read_insn(cs, env->spr[SPR_SRR0] - 4);
+
+    env->spr[SPR_SRR0] = env->sstep_srr0;
+    env->spr[SPR_SRR1] = env->sstep_srr1;
+
+    if (ppc_gdb_get_op(insn) != 31) {
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
+    target_ulong trace_handler_addr;
+
+    if (cap_ppc_singlestep) {
+        return 1;
+    }
+
+    cpu_synchronize_state(cs);
+    trace_handler_addr = ppc_get_trace_int_handler_addr(cs);
+
+    if (address == trace_handler_addr) {
+        kvm_remove_breakpoint(cs, trace_handler_addr, 4, GDB_BREAKPOINT_SW);
+
+        if (env->sstep_msr & (1ULL << MSR_SE)) {
+            /*
+             * The guest expects the last instruction to have caused a
+             * single step, go back into the interrupt handler.
+             */
+            return 1;
+        }
+
+        env->nip = env->spr[SPR_SRR0];
+        /* Bits 33-36, 43-47 are set by the interrupt */
+        env->msr = env->spr[SPR_SRR1] & ~(1ULL << MSR_SE |
+                                          PPC_BITMASK(33, 36) |
+                                          PPC_BITMASK(43, 47));
+        restore_singlestep_env(cs);
+
+    } else if (address == trace_handler_addr + 4) {
+        /*
+         * A step at trace_handler_addr would interfere with the
+         * singlestep mechanism itself, so we have previously
+         * displaced the breakpoint to the next instruction.
+         */
+        kvm_remove_breakpoint(cs, trace_handler_addr + 4, 4, GDB_BREAKPOINT_SW);
+        restore_singlestep_env(cs);
+    }
+
+    return 1;
+}
+
 static int kvm_handle_hw_breakpoint(CPUState *cs,
                                     struct kvm_debug_exit_arch *arch_info)
 {
@@ -1608,13 +1773,29 @@ static int kvm_handle_hw_breakpoint(CPUState *cs,
     return handle;
 }
 
-static int kvm_handle_singlestep(void)
+static int kvm_handle_sw_breakpoint(CPUState *cs, target_ulong address)
 {
-    return 1;
-}
+    target_ulong trace_handler_addr;
 
-static int kvm_handle_sw_breakpoint(void)
-{
+    if (cap_ppc_singlestep) {
+        return 1;
+    }
+
+    cpu_synchronize_state(cs);
+    trace_handler_addr = ppc_get_trace_int_handler_addr(cs);
+
+    if (address == trace_handler_addr) {
+        CPU_FOREACH(cs) {
+            if (cs->singlestep_enabled) {
+                /*
+                 * We hit this breakpoint while another cpu is doing a
+                 * software single step. Go back into the guest to
+                 * give chance for the single step to finish.
+                 */
+                return 0;
+            }
+        }
+    }
     return 1;
 }
 
@@ -1625,7 +1806,7 @@ static int kvm_handle_debug(PowerPCCPU *cpu, struct kvm_run *run)
     struct kvm_debug_exit_arch *arch_info = &run->debug.arch;
 
     if (cs->singlestep_enabled) {
-        return kvm_handle_singlestep();
+        return kvm_handle_singlestep(cs, arch_info->address);
     }
 
     if (arch_info->status) {
@@ -1633,7 +1814,7 @@ static int kvm_handle_debug(PowerPCCPU *cpu, struct kvm_run *run)
     }
 
     if (kvm_find_sw_breakpoint(cs, arch_info->address)) {
-        return kvm_handle_sw_breakpoint();
+        return kvm_handle_sw_breakpoint(cs, arch_info->address);
     }
 
     /*
-- 
2.23.0



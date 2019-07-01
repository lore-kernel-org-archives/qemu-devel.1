Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA137C0650E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 13:42:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8087E2146E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 13:42:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8087E2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhwZa-0000cv-PS
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 09:42:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40985)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hhwKc-00026M-Fr
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 09:26:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hhwKY-0002GK-KT
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 09:26:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47854)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>)
 id 1hhwKC-0001uj-Cd; Mon, 01 Jul 2019 09:26:30 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1A45630C31A6;
 Mon,  1 Jul 2019 13:26:21 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.205.170])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3BE136085B;
 Mon,  1 Jul 2019 13:26:15 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon,  1 Jul 2019 15:25:02 +0200
Message-Id: <20190701132516.26392-14-philmd@redhat.com>
In-Reply-To: <20190701132516.26392-1-philmd@redhat.com>
References: <20190701132516.26392-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Mon, 01 Jul 2019 13:26:21 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 13/27] target/arm: Move debug routines to
 debug_helper.c
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
Cc: Yang Zhong <yang.zhong@intel.com>, Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jones <drjones@redhat.com>, Samuel Ortiz <sameo@linux.intel.com>,
 Rob Bradford <robert.bradford@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These routines are TCG specific.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 target/arm/Makefile.objs  |   2 +-
 target/arm/cpu.c          |  11 +-
 target/arm/debug_helper.c | 334 ++++++++++++++++++++++++++++++++++++++
 target/arm/helper.c       |  23 ---
 target/arm/op_helper.c    | 295 ---------------------------------
 5 files changed, 339 insertions(+), 326 deletions(-)
 create mode 100644 target/arm/debug_helper.c

diff --git a/target/arm/Makefile.objs b/target/arm/Makefile.objs
index 5c154f01c5..294433da88 100644
--- a/target/arm/Makefile.objs
+++ b/target/arm/Makefile.objs
@@ -32,7 +32,7 @@ target/arm/translate-sve.o: target/arm/decode-sve.inc.c
 target/arm/translate.o: target/arm/decode-vfp.inc.c
 target/arm/translate.o: target/arm/decode-vfp-uncond.inc.c
=20
-obj-y +=3D tlb_helper.o
+obj-y +=3D tlb_helper.o debug_helper.o
 obj-y +=3D translate.o op_helper.o
 obj-y +=3D crypto_helper.o
 obj-y +=3D iwmmxt_helper.o vec_helper.o neon_helper.o
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index f21261c8ff..37afb12b2d 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2566,7 +2566,6 @@ static void arm_cpu_class_init(ObjectClass *oc, voi=
d *data)
     cc->gdb_write_register =3D arm_cpu_gdb_write_register;
 #ifndef CONFIG_USER_ONLY
     cc->do_interrupt =3D arm_cpu_do_interrupt;
-    cc->get_phys_page_attrs_debug =3D arm_cpu_get_phys_page_attrs_debug;
     cc->asidx_from_attrs =3D arm_asidx_from_attrs;
     cc->vmsd =3D &vmstate_arm_cpu;
     cc->virtio_is_big_endian =3D arm_cpu_virtio_is_big_endian;
@@ -2578,19 +2577,17 @@ static void arm_cpu_class_init(ObjectClass *oc, v=
oid *data)
     cc->gdb_arch_name =3D arm_gdb_arch_name;
     cc->gdb_get_dynamic_xml =3D arm_gdb_get_dynamic_xml;
     cc->gdb_stop_before_watchpoint =3D true;
-    cc->debug_excp_handler =3D arm_debug_excp_handler;
-    cc->debug_check_watchpoint =3D arm_debug_check_watchpoint;
-#if !defined(CONFIG_USER_ONLY)
-    cc->adjust_watchpoint_address =3D arm_adjust_watchpoint_address;
-#endif
-
     cc->disas_set_info =3D arm_disas_set_info;
 #ifdef CONFIG_TCG
     cc->tcg_initialize =3D arm_translate_init;
     cc->tlb_fill =3D arm_cpu_tlb_fill;
+    cc->debug_excp_handler =3D arm_debug_excp_handler;
+    cc->debug_check_watchpoint =3D arm_debug_check_watchpoint;
 #if !defined(CONFIG_USER_ONLY)
     cc->do_unaligned_access =3D arm_cpu_do_unaligned_access;
     cc->do_transaction_failed =3D arm_cpu_do_transaction_failed;
+    cc->adjust_watchpoint_address =3D arm_adjust_watchpoint_address;
+    cc->get_phys_page_attrs_debug =3D arm_cpu_get_phys_page_attrs_debug;
 #endif /* CONFIG_TCG && !CONFIG_USER_ONLY */
 #endif
 }
diff --git a/target/arm/debug_helper.c b/target/arm/debug_helper.c
new file mode 100644
index 0000000000..91d5b8e46f
--- /dev/null
+++ b/target/arm/debug_helper.c
@@ -0,0 +1,334 @@
+/*
+ * ARM debug helpers.
+ *
+ * This code is licensed under the GNU GPL v2 or later.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include "qemu/osdep.h"
+#include "cpu.h"
+#include "internals.h"
+#include "exec/exec-all.h"
+#include "exec/helper-proto.h"
+
+/* Return true if the linked breakpoint entry lbn passes its checks */
+static bool linked_bp_matches(ARMCPU *cpu, int lbn)
+{
+    CPUARMState *env =3D &cpu->env;
+    uint64_t bcr =3D env->cp15.dbgbcr[lbn];
+    int brps =3D extract32(cpu->dbgdidr, 24, 4);
+    int ctx_cmps =3D extract32(cpu->dbgdidr, 20, 4);
+    int bt;
+    uint32_t contextidr;
+
+    /*
+     * Links to unimplemented or non-context aware breakpoints are
+     * CONSTRAINED UNPREDICTABLE: either behave as if disabled, or
+     * as if linked to an UNKNOWN context-aware breakpoint (in which
+     * case DBGWCR<n>_EL1.LBN must indicate that breakpoint).
+     * We choose the former.
+     */
+    if (lbn > brps || lbn < (brps - ctx_cmps)) {
+        return false;
+    }
+
+    bcr =3D env->cp15.dbgbcr[lbn];
+
+    if (extract64(bcr, 0, 1) =3D=3D 0) {
+        /* Linked breakpoint disabled : generate no events */
+        return false;
+    }
+
+    bt =3D extract64(bcr, 20, 4);
+
+    /*
+     * We match the whole register even if this is AArch32 using the
+     * short descriptor format (in which case it holds both PROCID and A=
SID),
+     * since we don't implement the optional v7 context ID masking.
+     */
+    contextidr =3D extract64(env->cp15.contextidr_el[1], 0, 32);
+
+    switch (bt) {
+    case 3: /* linked context ID match */
+        if (arm_current_el(env) > 1) {
+            /* Context matches never fire in EL2 or (AArch64) EL3 */
+            return false;
+        }
+        return (contextidr =3D=3D extract64(env->cp15.dbgbvr[lbn], 0, 32=
));
+    case 5: /* linked address mismatch (reserved in AArch64) */
+    case 9: /* linked VMID match (reserved if no EL2) */
+    case 11: /* linked context ID and VMID match (reserved if no EL2) */
+    default:
+        /*
+         * Links to Unlinked context breakpoints must generate no
+         * events; we choose to do the same for reserved values too.
+         */
+        return false;
+    }
+
+    return false;
+}
+
+static bool bp_wp_matches(ARMCPU *cpu, int n, bool is_wp)
+{
+    CPUARMState *env =3D &cpu->env;
+    uint64_t cr;
+    int pac, hmc, ssc, wt, lbn;
+    /*
+     * Note that for watchpoints the check is against the CPU security
+     * state, not the S/NS attribute on the offending data access.
+     */
+    bool is_secure =3D arm_is_secure(env);
+    int access_el =3D arm_current_el(env);
+
+    if (is_wp) {
+        CPUWatchpoint *wp =3D env->cpu_watchpoint[n];
+
+        if (!wp || !(wp->flags & BP_WATCHPOINT_HIT)) {
+            return false;
+        }
+        cr =3D env->cp15.dbgwcr[n];
+        if (wp->hitattrs.user) {
+            /*
+             * The LDRT/STRT/LDT/STT "unprivileged access" instructions =
should
+             * match watchpoints as if they were accesses done at EL0, e=
ven if
+             * the CPU is at EL1 or higher.
+             */
+            access_el =3D 0;
+        }
+    } else {
+        uint64_t pc =3D is_a64(env) ? env->pc : env->regs[15];
+
+        if (!env->cpu_breakpoint[n] || env->cpu_breakpoint[n]->pc !=3D p=
c) {
+            return false;
+        }
+        cr =3D env->cp15.dbgbcr[n];
+    }
+    /*
+     * The WATCHPOINT_HIT flag guarantees us that the watchpoint is
+     * enabled and that the address and access type match; for breakpoin=
ts
+     * we know the address matched; check the remaining fields, includin=
g
+     * linked breakpoints. We rely on WCR and BCR having the same layout
+     * for the LBN, SSC, HMC, PAC/PMC and is-linked fields.
+     * Note that some combinations of {PAC, HMC, SSC} are reserved and
+     * must act either like some valid combination or as if the watchpoi=
nt
+     * were disabled. We choose the former, and use this together with
+     * the fact that EL3 must always be Secure and EL2 must always be
+     * Non-Secure to simplify the code slightly compared to the full
+     * table in the ARM ARM.
+     */
+    pac =3D extract64(cr, 1, 2);
+    hmc =3D extract64(cr, 13, 1);
+    ssc =3D extract64(cr, 14, 2);
+
+    switch (ssc) {
+    case 0:
+        break;
+    case 1:
+    case 3:
+        if (is_secure) {
+            return false;
+        }
+        break;
+    case 2:
+        if (!is_secure) {
+            return false;
+        }
+        break;
+    }
+
+    switch (access_el) {
+    case 3:
+    case 2:
+        if (!hmc) {
+            return false;
+        }
+        break;
+    case 1:
+        if (extract32(pac, 0, 1) =3D=3D 0) {
+            return false;
+        }
+        break;
+    case 0:
+        if (extract32(pac, 1, 1) =3D=3D 0) {
+            return false;
+        }
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    wt =3D extract64(cr, 20, 1);
+    lbn =3D extract64(cr, 16, 4);
+
+    if (wt && !linked_bp_matches(cpu, lbn)) {
+        return false;
+    }
+
+    return true;
+}
+
+static bool check_watchpoints(ARMCPU *cpu)
+{
+    CPUARMState *env =3D &cpu->env;
+    int n;
+
+    /*
+     * If watchpoints are disabled globally or we can't take debug
+     * exceptions here then watchpoint firings are ignored.
+     */
+    if (extract32(env->cp15.mdscr_el1, 15, 1) =3D=3D 0
+        || !arm_generate_debug_exceptions(env)) {
+        return false;
+    }
+
+    for (n =3D 0; n < ARRAY_SIZE(env->cpu_watchpoint); n++) {
+        if (bp_wp_matches(cpu, n, true)) {
+            return true;
+        }
+    }
+    return false;
+}
+
+static bool check_breakpoints(ARMCPU *cpu)
+{
+    CPUARMState *env =3D &cpu->env;
+    int n;
+
+    /*
+     * If breakpoints are disabled globally or we can't take debug
+     * exceptions here then breakpoint firings are ignored.
+     */
+    if (extract32(env->cp15.mdscr_el1, 15, 1) =3D=3D 0
+        || !arm_generate_debug_exceptions(env)) {
+        return false;
+    }
+
+    for (n =3D 0; n < ARRAY_SIZE(env->cpu_breakpoint); n++) {
+        if (bp_wp_matches(cpu, n, false)) {
+            return true;
+        }
+    }
+    return false;
+}
+
+void HELPER(check_breakpoints)(CPUARMState *env)
+{
+    ARMCPU *cpu =3D env_archcpu(env);
+
+    if (check_breakpoints(cpu)) {
+        HELPER(exception_internal(env, EXCP_DEBUG));
+    }
+}
+
+bool arm_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *wp)
+{
+    /*
+     * Called by core code when a CPU watchpoint fires; need to check if=
 this
+     * is also an architectural watchpoint match.
+     */
+    ARMCPU *cpu =3D ARM_CPU(cs);
+
+    return check_watchpoints(cpu);
+}
+
+void arm_debug_excp_handler(CPUState *cs)
+{
+    /*
+     * Called by core code when a watchpoint or breakpoint fires;
+     * need to check which one and raise the appropriate exception.
+     */
+    ARMCPU *cpu =3D ARM_CPU(cs);
+    CPUARMState *env =3D &cpu->env;
+    CPUWatchpoint *wp_hit =3D cs->watchpoint_hit;
+
+    if (wp_hit) {
+        if (wp_hit->flags & BP_CPU) {
+            bool wnr =3D (wp_hit->flags & BP_WATCHPOINT_HIT_WRITE) !=3D =
0;
+            bool same_el =3D arm_debug_target_el(env) =3D=3D arm_current=
_el(env);
+
+            cs->watchpoint_hit =3D NULL;
+
+            env->exception.fsr =3D arm_debug_exception_fsr(env);
+            env->exception.vaddress =3D wp_hit->hitaddr;
+            raise_exception(env, EXCP_DATA_ABORT,
+                    syn_watchpoint(same_el, 0, wnr),
+                    arm_debug_target_el(env));
+        }
+    } else {
+        uint64_t pc =3D is_a64(env) ? env->pc : env->regs[15];
+        bool same_el =3D (arm_debug_target_el(env) =3D=3D arm_current_el=
(env));
+
+        /*
+         * (1) GDB breakpoints should be handled first.
+         * (2) Do not raise a CPU exception if no CPU breakpoint has fir=
ed,
+         * since singlestep is also done by generating a debug internal
+         * exception.
+         */
+        if (cpu_breakpoint_test(cs, pc, BP_GDB)
+            || !cpu_breakpoint_test(cs, pc, BP_CPU)) {
+            return;
+        }
+
+        env->exception.fsr =3D arm_debug_exception_fsr(env);
+        /*
+         * FAR is UNKNOWN: clear vaddress to avoid potentially exposing
+         * values to the guest that it shouldn't be able to see at its
+         * exception/security level.
+         */
+        env->exception.vaddress =3D 0;
+        raise_exception(env, EXCP_PREFETCH_ABORT,
+                        syn_breakpoint(same_el),
+                        arm_debug_target_el(env));
+    }
+}
+
+#if !defined(CONFIG_USER_ONLY)
+
+vaddr arm_adjust_watchpoint_address(CPUState *cs, vaddr addr, int len)
+{
+    ARMCPU *cpu =3D ARM_CPU(cs);
+    CPUARMState *env =3D &cpu->env;
+
+    /*
+     * In BE32 system mode, target memory is stored byteswapped (on a
+     * little-endian host system), and by the time we reach here (via an
+     * opcode helper) the addresses of subword accesses have been adjust=
ed
+     * to account for that, which means that watchpoints will not match.
+     * Undo the adjustment here.
+     */
+    if (arm_sctlr_b(env)) {
+        if (len =3D=3D 1) {
+            addr ^=3D 3;
+        } else if (len =3D=3D 2) {
+            addr ^=3D 2;
+        }
+    }
+
+    return addr;
+}
+
+hwaddr arm_cpu_get_phys_page_attrs_debug(CPUState *cs, vaddr addr,
+                                         MemTxAttrs *attrs)
+{
+    ARMCPU *cpu =3D ARM_CPU(cs);
+    CPUARMState *env =3D &cpu->env;
+    hwaddr phys_addr;
+    target_ulong page_size;
+    int prot;
+    bool ret;
+    ARMMMUFaultInfo fi =3D {};
+    ARMMMUIdx mmu_idx =3D arm_mmu_idx(env);
+
+    *attrs =3D (MemTxAttrs) {};
+
+    ret =3D get_phys_addr(env, addr, 0, mmu_idx, &phys_addr,
+                        attrs, &prot, &page_size, &fi, NULL);
+
+    if (ret) {
+        return -1;
+    }
+    return phys_addr;
+}
+
+#endif
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 4ef908c611..49a0f05cd1 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -12759,29 +12759,6 @@ bool get_phys_addr(CPUARMState *env, target_ulon=
g address,
     }
 }
=20
-hwaddr arm_cpu_get_phys_page_attrs_debug(CPUState *cs, vaddr addr,
-                                         MemTxAttrs *attrs)
-{
-    ARMCPU *cpu =3D ARM_CPU(cs);
-    CPUARMState *env =3D &cpu->env;
-    hwaddr phys_addr;
-    target_ulong page_size;
-    int prot;
-    bool ret;
-    ARMMMUFaultInfo fi =3D {};
-    ARMMMUIdx mmu_idx =3D arm_mmu_idx(env);
-
-    *attrs =3D (MemTxAttrs) {};
-
-    ret =3D get_phys_addr(env, addr, 0, mmu_idx, &phys_addr,
-                        attrs, &prot, &page_size, &fi, NULL);
-
-    if (ret) {
-        return -1;
-    }
-    return phys_addr;
-}
-
 uint32_t HELPER(v7m_mrs)(CPUARMState *env, uint32_t reg)
 {
     uint32_t mask;
diff --git a/target/arm/op_helper.c b/target/arm/op_helper.c
index 9850993c11..1ab91f915e 100644
--- a/target/arm/op_helper.c
+++ b/target/arm/op_helper.c
@@ -831,301 +831,6 @@ void HELPER(pre_smc)(CPUARMState *env, uint32_t syn=
drome)
     }
 }
=20
-/* Return true if the linked breakpoint entry lbn passes its checks */
-static bool linked_bp_matches(ARMCPU *cpu, int lbn)
-{
-    CPUARMState *env =3D &cpu->env;
-    uint64_t bcr =3D env->cp15.dbgbcr[lbn];
-    int brps =3D extract32(cpu->dbgdidr, 24, 4);
-    int ctx_cmps =3D extract32(cpu->dbgdidr, 20, 4);
-    int bt;
-    uint32_t contextidr;
-
-    /*
-     * Links to unimplemented or non-context aware breakpoints are
-     * CONSTRAINED UNPREDICTABLE: either behave as if disabled, or
-     * as if linked to an UNKNOWN context-aware breakpoint (in which
-     * case DBGWCR<n>_EL1.LBN must indicate that breakpoint).
-     * We choose the former.
-     */
-    if (lbn > brps || lbn < (brps - ctx_cmps)) {
-        return false;
-    }
-
-    bcr =3D env->cp15.dbgbcr[lbn];
-
-    if (extract64(bcr, 0, 1) =3D=3D 0) {
-        /* Linked breakpoint disabled : generate no events */
-        return false;
-    }
-
-    bt =3D extract64(bcr, 20, 4);
-
-    /*
-     * We match the whole register even if this is AArch32 using the
-     * short descriptor format (in which case it holds both PROCID and A=
SID),
-     * since we don't implement the optional v7 context ID masking.
-     */
-    contextidr =3D extract64(env->cp15.contextidr_el[1], 0, 32);
-
-    switch (bt) {
-    case 3: /* linked context ID match */
-        if (arm_current_el(env) > 1) {
-            /* Context matches never fire in EL2 or (AArch64) EL3 */
-            return false;
-        }
-        return (contextidr =3D=3D extract64(env->cp15.dbgbvr[lbn], 0, 32=
));
-    case 5: /* linked address mismatch (reserved in AArch64) */
-    case 9: /* linked VMID match (reserved if no EL2) */
-    case 11: /* linked context ID and VMID match (reserved if no EL2) */
-    default:
-        /*
-         * Links to Unlinked context breakpoints must generate no
-         * events; we choose to do the same for reserved values too.
-         */
-        return false;
-    }
-
-    return false;
-}
-
-static bool bp_wp_matches(ARMCPU *cpu, int n, bool is_wp)
-{
-    CPUARMState *env =3D &cpu->env;
-    uint64_t cr;
-    int pac, hmc, ssc, wt, lbn;
-    /*
-     * Note that for watchpoints the check is against the CPU security
-     * state, not the S/NS attribute on the offending data access.
-     */
-    bool is_secure =3D arm_is_secure(env);
-    int access_el =3D arm_current_el(env);
-
-    if (is_wp) {
-        CPUWatchpoint *wp =3D env->cpu_watchpoint[n];
-
-        if (!wp || !(wp->flags & BP_WATCHPOINT_HIT)) {
-            return false;
-        }
-        cr =3D env->cp15.dbgwcr[n];
-        if (wp->hitattrs.user) {
-            /*
-             * The LDRT/STRT/LDT/STT "unprivileged access" instructions =
should
-             * match watchpoints as if they were accesses done at EL0, e=
ven if
-             * the CPU is at EL1 or higher.
-             */
-            access_el =3D 0;
-        }
-    } else {
-        uint64_t pc =3D is_a64(env) ? env->pc : env->regs[15];
-
-        if (!env->cpu_breakpoint[n] || env->cpu_breakpoint[n]->pc !=3D p=
c) {
-            return false;
-        }
-        cr =3D env->cp15.dbgbcr[n];
-    }
-    /*
-     * The WATCHPOINT_HIT flag guarantees us that the watchpoint is
-     * enabled and that the address and access type match; for breakpoin=
ts
-     * we know the address matched; check the remaining fields, includin=
g
-     * linked breakpoints. We rely on WCR and BCR having the same layout
-     * for the LBN, SSC, HMC, PAC/PMC and is-linked fields.
-     * Note that some combinations of {PAC, HMC, SSC} are reserved and
-     * must act either like some valid combination or as if the watchpoi=
nt
-     * were disabled. We choose the former, and use this together with
-     * the fact that EL3 must always be Secure and EL2 must always be
-     * Non-Secure to simplify the code slightly compared to the full
-     * table in the ARM ARM.
-     */
-    pac =3D extract64(cr, 1, 2);
-    hmc =3D extract64(cr, 13, 1);
-    ssc =3D extract64(cr, 14, 2);
-
-    switch (ssc) {
-    case 0:
-        break;
-    case 1:
-    case 3:
-        if (is_secure) {
-            return false;
-        }
-        break;
-    case 2:
-        if (!is_secure) {
-            return false;
-        }
-        break;
-    }
-
-    switch (access_el) {
-    case 3:
-    case 2:
-        if (!hmc) {
-            return false;
-        }
-        break;
-    case 1:
-        if (extract32(pac, 0, 1) =3D=3D 0) {
-            return false;
-        }
-        break;
-    case 0:
-        if (extract32(pac, 1, 1) =3D=3D 0) {
-            return false;
-        }
-        break;
-    default:
-        g_assert_not_reached();
-    }
-
-    wt =3D extract64(cr, 20, 1);
-    lbn =3D extract64(cr, 16, 4);
-
-    if (wt && !linked_bp_matches(cpu, lbn)) {
-        return false;
-    }
-
-    return true;
-}
-
-static bool check_watchpoints(ARMCPU *cpu)
-{
-    CPUARMState *env =3D &cpu->env;
-    int n;
-
-    /*
-     * If watchpoints are disabled globally or we can't take debug
-     * exceptions here then watchpoint firings are ignored.
-     */
-    if (extract32(env->cp15.mdscr_el1, 15, 1) =3D=3D 0
-        || !arm_generate_debug_exceptions(env)) {
-        return false;
-    }
-
-    for (n =3D 0; n < ARRAY_SIZE(env->cpu_watchpoint); n++) {
-        if (bp_wp_matches(cpu, n, true)) {
-            return true;
-        }
-    }
-    return false;
-}
-
-static bool check_breakpoints(ARMCPU *cpu)
-{
-    CPUARMState *env =3D &cpu->env;
-    int n;
-
-    /*
-     * If breakpoints are disabled globally or we can't take debug
-     * exceptions here then breakpoint firings are ignored.
-     */
-    if (extract32(env->cp15.mdscr_el1, 15, 1) =3D=3D 0
-        || !arm_generate_debug_exceptions(env)) {
-        return false;
-    }
-
-    for (n =3D 0; n < ARRAY_SIZE(env->cpu_breakpoint); n++) {
-        if (bp_wp_matches(cpu, n, false)) {
-            return true;
-        }
-    }
-    return false;
-}
-
-void HELPER(check_breakpoints)(CPUARMState *env)
-{
-    ARMCPU *cpu =3D env_archcpu(env);
-
-    if (check_breakpoints(cpu)) {
-        HELPER(exception_internal(env, EXCP_DEBUG));
-    }
-}
-
-bool arm_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *wp)
-{
-    /*
-     * Called by core code when a CPU watchpoint fires; need to check if=
 this
-     * is also an architectural watchpoint match.
-     */
-    ARMCPU *cpu =3D ARM_CPU(cs);
-
-    return check_watchpoints(cpu);
-}
-
-vaddr arm_adjust_watchpoint_address(CPUState *cs, vaddr addr, int len)
-{
-    ARMCPU *cpu =3D ARM_CPU(cs);
-    CPUARMState *env =3D &cpu->env;
-
-    /*
-     * In BE32 system mode, target memory is stored byteswapped (on a
-     * little-endian host system), and by the time we reach here (via an
-     * opcode helper) the addresses of subword accesses have been adjust=
ed
-     * to account for that, which means that watchpoints will not match.
-     * Undo the adjustment here.
-     */
-    if (arm_sctlr_b(env)) {
-        if (len =3D=3D 1) {
-            addr ^=3D 3;
-        } else if (len =3D=3D 2) {
-            addr ^=3D 2;
-        }
-    }
-
-    return addr;
-}
-
-void arm_debug_excp_handler(CPUState *cs)
-{
-    /*
-     * Called by core code when a watchpoint or breakpoint fires;
-     * need to check which one and raise the appropriate exception.
-     */
-    ARMCPU *cpu =3D ARM_CPU(cs);
-    CPUARMState *env =3D &cpu->env;
-    CPUWatchpoint *wp_hit =3D cs->watchpoint_hit;
-
-    if (wp_hit) {
-        if (wp_hit->flags & BP_CPU) {
-            bool wnr =3D (wp_hit->flags & BP_WATCHPOINT_HIT_WRITE) !=3D =
0;
-            bool same_el =3D arm_debug_target_el(env) =3D=3D arm_current=
_el(env);
-
-            cs->watchpoint_hit =3D NULL;
-
-            env->exception.fsr =3D arm_debug_exception_fsr(env);
-            env->exception.vaddress =3D wp_hit->hitaddr;
-            raise_exception(env, EXCP_DATA_ABORT,
-                    syn_watchpoint(same_el, 0, wnr),
-                    arm_debug_target_el(env));
-        }
-    } else {
-        uint64_t pc =3D is_a64(env) ? env->pc : env->regs[15];
-        bool same_el =3D (arm_debug_target_el(env) =3D=3D arm_current_el=
(env));
-
-        /*
-         * (1) GDB breakpoints should be handled first.
-         * (2) Do not raise a CPU exception if no CPU breakpoint has fir=
ed,
-         * since singlestep is also done by generating a debug internal
-         * exception.
-         */
-        if (cpu_breakpoint_test(cs, pc, BP_GDB)
-            || !cpu_breakpoint_test(cs, pc, BP_CPU)) {
-            return;
-        }
-
-        env->exception.fsr =3D arm_debug_exception_fsr(env);
-        /*
-         * FAR is UNKNOWN: clear vaddress to avoid potentially exposing
-         * values to the guest that it shouldn't be able to see at its
-         * exception/security level.
-         */
-        env->exception.vaddress =3D 0;
-        raise_exception(env, EXCP_PREFETCH_ABORT,
-                        syn_breakpoint(same_el),
-                        arm_debug_target_el(env));
-    }
-}
-
 /* ??? Flag setting arithmetic is awkward because we need to do comparis=
ons.
    The only way to do that in TCG is a conditional branch, which clobber=
s
    all our temporaries.  For now implement these as helper functions.  *=
/
--=20
2.20.1



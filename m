Return-Path: <SRS0=blGQ=VB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E0FC0651F
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 16:16:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D79F32189E
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 16:16:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NGcTqBRm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D79F32189E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hj4PN-0008QB-Gb
	for qemu-devel@archiver.kernel.org; Thu, 04 Jul 2019 12:16:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44134)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hj4HK-0007sS-IY
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 12:08:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hj4HI-0001zm-2f
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 12:08:10 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:51076)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hj4HH-0001yT-Pk
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 12:08:08 -0400
Received: by mail-wm1-x329.google.com with SMTP id n9so6259736wmi.0
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2019 09:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=fSFZ8Ir8Fwh9s0wZTfDaC/mvf3m/iW0XU/LH1HBLDR0=;
 b=NGcTqBRm2PynsN7hq/DXokeKxMcmvxGRIL5GVUOTbXMgJ+42s/oBXHB1X42ilUKRoK
 zo+yPN0hPJzIsMgy5784f4+fsyuGTukng97q3CVuq+1d1+LdVGKTC4XVBbI8PLEN8WVn
 CjV1XksWAGESasi3iGxEts3AZpmEhDgx8lK04+sDXcIpHv62NgZpPsezKuyNZb3wks4x
 VfZN85TA7ORvxIU6UnS7D4jteD04olzPOri+7AXdDwN5bUWUH8p95kTIhnTOdHO1yffy
 LBDI74CoHj47678hEgb7K/ajn/xa3P4eWDsvudOk94fTZmd2+5g0ggE/Gh2EjCqT83Tm
 Ah5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=fSFZ8Ir8Fwh9s0wZTfDaC/mvf3m/iW0XU/LH1HBLDR0=;
 b=FHyFTmaI9Y+Zr3kVZpTq+XGlQ2Q9EF2uNF10zWA1il+etEDGjn7ZhgcpZ5W2idfkMl
 PNL9FGx6AI7nDhwVz+xPgzGvpGq16D5BNSSpjTpeU7dsS5GDzWFBmGQTFnKL1hQ/koZk
 zm+O5WNMMYsoRl8kjpRC1FA2F2m3c4O4csTDWHMo+pCVnh4IQBVD1LTFAe5gGv4DqRFU
 a+v64EwqIAR9yb2a8Ncv+ZrDEaOE+i8TBk3R4M2HP3aCLJtac0GDZXvmdOPlHYx+bvVY
 hBWFC2qM4e/yqGpZ1GR7dnfAxFIFE0rs6VTZ8FqIyosr1Y6FJ6JxS3U9275RgGB8glD9
 +pig==
X-Gm-Message-State: APjAAAXNUQHMOjIWrgZF7OLnURodEHiV0sqg24EwVwmZ/BXgDfLogthm
 m/0oAWrtthAAy/ZyHFfOTnXqvpzImcbENQ==
X-Google-Smtp-Source: APXvYqyJlDAcfRbiWzNIuaEcbZOljVo3CgcXLa6XpGvVUORxx/niCM3QqgyXvajyvoNw6R0+xsuGHg==
X-Received: by 2002:a1c:a7c6:: with SMTP id q189mr211113wme.146.1562256486068; 
 Thu, 04 Jul 2019 09:08:06 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id s2sm3849690wmj.33.2019.07.04.09.08.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 04 Jul 2019 09:08:05 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu,  4 Jul 2019 17:07:54 +0100
Message-Id: <20190704160802.12419-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190704160802.12419-1-peter.maydell@linaro.org>
References: <20190704160802.12419-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::329
Subject: [Qemu-devel] [PULL 1/9] target/arm: Move debug routines to
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

These routines are TCG specific.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20190701194942.10092-2-philmd@redhat.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/Makefile.objs  |   2 +-
 target/arm/cpu.c          |   9 +-
 target/arm/debug_helper.c | 311 ++++++++++++++++++++++++++++++++++++++
 target/arm/op_helper.c    | 295 ------------------------------------
 4 files changed, 315 insertions(+), 302 deletions(-)
 create mode 100644 target/arm/debug_helper.c

diff --git a/target/arm/Makefile.objs b/target/arm/Makefile.objs
index 5c154f01c58..294433da880 100644
--- a/target/arm/Makefile.objs
+++ b/target/arm/Makefile.objs
@@ -32,7 +32,7 @@ target/arm/translate-sve.o: target/arm/decode-sve.inc.c
 target/arm/translate.o: target/arm/decode-vfp.inc.c
 target/arm/translate.o: target/arm/decode-vfp-uncond.inc.c
 
-obj-y += tlb_helper.o
+obj-y += tlb_helper.o debug_helper.o
 obj-y += translate.o op_helper.o
 obj-y += crypto_helper.o
 obj-y += iwmmxt_helper.o vec_helper.o neon_helper.o
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index f21261c8ff8..ca718fb38f4 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2578,19 +2578,16 @@ static void arm_cpu_class_init(ObjectClass *oc, void *data)
     cc->gdb_arch_name = arm_gdb_arch_name;
     cc->gdb_get_dynamic_xml = arm_gdb_get_dynamic_xml;
     cc->gdb_stop_before_watchpoint = true;
-    cc->debug_excp_handler = arm_debug_excp_handler;
-    cc->debug_check_watchpoint = arm_debug_check_watchpoint;
-#if !defined(CONFIG_USER_ONLY)
-    cc->adjust_watchpoint_address = arm_adjust_watchpoint_address;
-#endif
-
     cc->disas_set_info = arm_disas_set_info;
 #ifdef CONFIG_TCG
     cc->tcg_initialize = arm_translate_init;
     cc->tlb_fill = arm_cpu_tlb_fill;
+    cc->debug_excp_handler = arm_debug_excp_handler;
+    cc->debug_check_watchpoint = arm_debug_check_watchpoint;
 #if !defined(CONFIG_USER_ONLY)
     cc->do_unaligned_access = arm_cpu_do_unaligned_access;
     cc->do_transaction_failed = arm_cpu_do_transaction_failed;
+    cc->adjust_watchpoint_address = arm_adjust_watchpoint_address;
 #endif /* CONFIG_TCG && !CONFIG_USER_ONLY */
 #endif
 }
diff --git a/target/arm/debug_helper.c b/target/arm/debug_helper.c
new file mode 100644
index 00000000000..dde80273ff1
--- /dev/null
+++ b/target/arm/debug_helper.c
@@ -0,0 +1,311 @@
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
+    CPUARMState *env = &cpu->env;
+    uint64_t bcr = env->cp15.dbgbcr[lbn];
+    int brps = extract32(cpu->dbgdidr, 24, 4);
+    int ctx_cmps = extract32(cpu->dbgdidr, 20, 4);
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
+    bcr = env->cp15.dbgbcr[lbn];
+
+    if (extract64(bcr, 0, 1) == 0) {
+        /* Linked breakpoint disabled : generate no events */
+        return false;
+    }
+
+    bt = extract64(bcr, 20, 4);
+
+    /*
+     * We match the whole register even if this is AArch32 using the
+     * short descriptor format (in which case it holds both PROCID and ASID),
+     * since we don't implement the optional v7 context ID masking.
+     */
+    contextidr = extract64(env->cp15.contextidr_el[1], 0, 32);
+
+    switch (bt) {
+    case 3: /* linked context ID match */
+        if (arm_current_el(env) > 1) {
+            /* Context matches never fire in EL2 or (AArch64) EL3 */
+            return false;
+        }
+        return (contextidr == extract64(env->cp15.dbgbvr[lbn], 0, 32));
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
+    CPUARMState *env = &cpu->env;
+    uint64_t cr;
+    int pac, hmc, ssc, wt, lbn;
+    /*
+     * Note that for watchpoints the check is against the CPU security
+     * state, not the S/NS attribute on the offending data access.
+     */
+    bool is_secure = arm_is_secure(env);
+    int access_el = arm_current_el(env);
+
+    if (is_wp) {
+        CPUWatchpoint *wp = env->cpu_watchpoint[n];
+
+        if (!wp || !(wp->flags & BP_WATCHPOINT_HIT)) {
+            return false;
+        }
+        cr = env->cp15.dbgwcr[n];
+        if (wp->hitattrs.user) {
+            /*
+             * The LDRT/STRT/LDT/STT "unprivileged access" instructions should
+             * match watchpoints as if they were accesses done at EL0, even if
+             * the CPU is at EL1 or higher.
+             */
+            access_el = 0;
+        }
+    } else {
+        uint64_t pc = is_a64(env) ? env->pc : env->regs[15];
+
+        if (!env->cpu_breakpoint[n] || env->cpu_breakpoint[n]->pc != pc) {
+            return false;
+        }
+        cr = env->cp15.dbgbcr[n];
+    }
+    /*
+     * The WATCHPOINT_HIT flag guarantees us that the watchpoint is
+     * enabled and that the address and access type match; for breakpoints
+     * we know the address matched; check the remaining fields, including
+     * linked breakpoints. We rely on WCR and BCR having the same layout
+     * for the LBN, SSC, HMC, PAC/PMC and is-linked fields.
+     * Note that some combinations of {PAC, HMC, SSC} are reserved and
+     * must act either like some valid combination or as if the watchpoint
+     * were disabled. We choose the former, and use this together with
+     * the fact that EL3 must always be Secure and EL2 must always be
+     * Non-Secure to simplify the code slightly compared to the full
+     * table in the ARM ARM.
+     */
+    pac = extract64(cr, 1, 2);
+    hmc = extract64(cr, 13, 1);
+    ssc = extract64(cr, 14, 2);
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
+        if (extract32(pac, 0, 1) == 0) {
+            return false;
+        }
+        break;
+    case 0:
+        if (extract32(pac, 1, 1) == 0) {
+            return false;
+        }
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    wt = extract64(cr, 20, 1);
+    lbn = extract64(cr, 16, 4);
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
+    CPUARMState *env = &cpu->env;
+    int n;
+
+    /*
+     * If watchpoints are disabled globally or we can't take debug
+     * exceptions here then watchpoint firings are ignored.
+     */
+    if (extract32(env->cp15.mdscr_el1, 15, 1) == 0
+        || !arm_generate_debug_exceptions(env)) {
+        return false;
+    }
+
+    for (n = 0; n < ARRAY_SIZE(env->cpu_watchpoint); n++) {
+        if (bp_wp_matches(cpu, n, true)) {
+            return true;
+        }
+    }
+    return false;
+}
+
+static bool check_breakpoints(ARMCPU *cpu)
+{
+    CPUARMState *env = &cpu->env;
+    int n;
+
+    /*
+     * If breakpoints are disabled globally or we can't take debug
+     * exceptions here then breakpoint firings are ignored.
+     */
+    if (extract32(env->cp15.mdscr_el1, 15, 1) == 0
+        || !arm_generate_debug_exceptions(env)) {
+        return false;
+    }
+
+    for (n = 0; n < ARRAY_SIZE(env->cpu_breakpoint); n++) {
+        if (bp_wp_matches(cpu, n, false)) {
+            return true;
+        }
+    }
+    return false;
+}
+
+void HELPER(check_breakpoints)(CPUARMState *env)
+{
+    ARMCPU *cpu = env_archcpu(env);
+
+    if (check_breakpoints(cpu)) {
+        HELPER(exception_internal(env, EXCP_DEBUG));
+    }
+}
+
+bool arm_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *wp)
+{
+    /*
+     * Called by core code when a CPU watchpoint fires; need to check if this
+     * is also an architectural watchpoint match.
+     */
+    ARMCPU *cpu = ARM_CPU(cs);
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
+    ARMCPU *cpu = ARM_CPU(cs);
+    CPUARMState *env = &cpu->env;
+    CPUWatchpoint *wp_hit = cs->watchpoint_hit;
+
+    if (wp_hit) {
+        if (wp_hit->flags & BP_CPU) {
+            bool wnr = (wp_hit->flags & BP_WATCHPOINT_HIT_WRITE) != 0;
+            bool same_el = arm_debug_target_el(env) == arm_current_el(env);
+
+            cs->watchpoint_hit = NULL;
+
+            env->exception.fsr = arm_debug_exception_fsr(env);
+            env->exception.vaddress = wp_hit->hitaddr;
+            raise_exception(env, EXCP_DATA_ABORT,
+                    syn_watchpoint(same_el, 0, wnr),
+                    arm_debug_target_el(env));
+        }
+    } else {
+        uint64_t pc = is_a64(env) ? env->pc : env->regs[15];
+        bool same_el = (arm_debug_target_el(env) == arm_current_el(env));
+
+        /*
+         * (1) GDB breakpoints should be handled first.
+         * (2) Do not raise a CPU exception if no CPU breakpoint has fired,
+         * since singlestep is also done by generating a debug internal
+         * exception.
+         */
+        if (cpu_breakpoint_test(cs, pc, BP_GDB)
+            || !cpu_breakpoint_test(cs, pc, BP_CPU)) {
+            return;
+        }
+
+        env->exception.fsr = arm_debug_exception_fsr(env);
+        /*
+         * FAR is UNKNOWN: clear vaddress to avoid potentially exposing
+         * values to the guest that it shouldn't be able to see at its
+         * exception/security level.
+         */
+        env->exception.vaddress = 0;
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
+    ARMCPU *cpu = ARM_CPU(cs);
+    CPUARMState *env = &cpu->env;
+
+    /*
+     * In BE32 system mode, target memory is stored byteswapped (on a
+     * little-endian host system), and by the time we reach here (via an
+     * opcode helper) the addresses of subword accesses have been adjusted
+     * to account for that, which means that watchpoints will not match.
+     * Undo the adjustment here.
+     */
+    if (arm_sctlr_b(env)) {
+        if (len == 1) {
+            addr ^= 3;
+        } else if (len == 2) {
+            addr ^= 2;
+        }
+    }
+
+    return addr;
+}
+
+#endif
diff --git a/target/arm/op_helper.c b/target/arm/op_helper.c
index 9850993c114..1ab91f915e4 100644
--- a/target/arm/op_helper.c
+++ b/target/arm/op_helper.c
@@ -831,301 +831,6 @@ void HELPER(pre_smc)(CPUARMState *env, uint32_t syndrome)
     }
 }
 
-/* Return true if the linked breakpoint entry lbn passes its checks */
-static bool linked_bp_matches(ARMCPU *cpu, int lbn)
-{
-    CPUARMState *env = &cpu->env;
-    uint64_t bcr = env->cp15.dbgbcr[lbn];
-    int brps = extract32(cpu->dbgdidr, 24, 4);
-    int ctx_cmps = extract32(cpu->dbgdidr, 20, 4);
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
-    bcr = env->cp15.dbgbcr[lbn];
-
-    if (extract64(bcr, 0, 1) == 0) {
-        /* Linked breakpoint disabled : generate no events */
-        return false;
-    }
-
-    bt = extract64(bcr, 20, 4);
-
-    /*
-     * We match the whole register even if this is AArch32 using the
-     * short descriptor format (in which case it holds both PROCID and ASID),
-     * since we don't implement the optional v7 context ID masking.
-     */
-    contextidr = extract64(env->cp15.contextidr_el[1], 0, 32);
-
-    switch (bt) {
-    case 3: /* linked context ID match */
-        if (arm_current_el(env) > 1) {
-            /* Context matches never fire in EL2 or (AArch64) EL3 */
-            return false;
-        }
-        return (contextidr == extract64(env->cp15.dbgbvr[lbn], 0, 32));
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
-    CPUARMState *env = &cpu->env;
-    uint64_t cr;
-    int pac, hmc, ssc, wt, lbn;
-    /*
-     * Note that for watchpoints the check is against the CPU security
-     * state, not the S/NS attribute on the offending data access.
-     */
-    bool is_secure = arm_is_secure(env);
-    int access_el = arm_current_el(env);
-
-    if (is_wp) {
-        CPUWatchpoint *wp = env->cpu_watchpoint[n];
-
-        if (!wp || !(wp->flags & BP_WATCHPOINT_HIT)) {
-            return false;
-        }
-        cr = env->cp15.dbgwcr[n];
-        if (wp->hitattrs.user) {
-            /*
-             * The LDRT/STRT/LDT/STT "unprivileged access" instructions should
-             * match watchpoints as if they were accesses done at EL0, even if
-             * the CPU is at EL1 or higher.
-             */
-            access_el = 0;
-        }
-    } else {
-        uint64_t pc = is_a64(env) ? env->pc : env->regs[15];
-
-        if (!env->cpu_breakpoint[n] || env->cpu_breakpoint[n]->pc != pc) {
-            return false;
-        }
-        cr = env->cp15.dbgbcr[n];
-    }
-    /*
-     * The WATCHPOINT_HIT flag guarantees us that the watchpoint is
-     * enabled and that the address and access type match; for breakpoints
-     * we know the address matched; check the remaining fields, including
-     * linked breakpoints. We rely on WCR and BCR having the same layout
-     * for the LBN, SSC, HMC, PAC/PMC and is-linked fields.
-     * Note that some combinations of {PAC, HMC, SSC} are reserved and
-     * must act either like some valid combination or as if the watchpoint
-     * were disabled. We choose the former, and use this together with
-     * the fact that EL3 must always be Secure and EL2 must always be
-     * Non-Secure to simplify the code slightly compared to the full
-     * table in the ARM ARM.
-     */
-    pac = extract64(cr, 1, 2);
-    hmc = extract64(cr, 13, 1);
-    ssc = extract64(cr, 14, 2);
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
-        if (extract32(pac, 0, 1) == 0) {
-            return false;
-        }
-        break;
-    case 0:
-        if (extract32(pac, 1, 1) == 0) {
-            return false;
-        }
-        break;
-    default:
-        g_assert_not_reached();
-    }
-
-    wt = extract64(cr, 20, 1);
-    lbn = extract64(cr, 16, 4);
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
-    CPUARMState *env = &cpu->env;
-    int n;
-
-    /*
-     * If watchpoints are disabled globally or we can't take debug
-     * exceptions here then watchpoint firings are ignored.
-     */
-    if (extract32(env->cp15.mdscr_el1, 15, 1) == 0
-        || !arm_generate_debug_exceptions(env)) {
-        return false;
-    }
-
-    for (n = 0; n < ARRAY_SIZE(env->cpu_watchpoint); n++) {
-        if (bp_wp_matches(cpu, n, true)) {
-            return true;
-        }
-    }
-    return false;
-}
-
-static bool check_breakpoints(ARMCPU *cpu)
-{
-    CPUARMState *env = &cpu->env;
-    int n;
-
-    /*
-     * If breakpoints are disabled globally or we can't take debug
-     * exceptions here then breakpoint firings are ignored.
-     */
-    if (extract32(env->cp15.mdscr_el1, 15, 1) == 0
-        || !arm_generate_debug_exceptions(env)) {
-        return false;
-    }
-
-    for (n = 0; n < ARRAY_SIZE(env->cpu_breakpoint); n++) {
-        if (bp_wp_matches(cpu, n, false)) {
-            return true;
-        }
-    }
-    return false;
-}
-
-void HELPER(check_breakpoints)(CPUARMState *env)
-{
-    ARMCPU *cpu = env_archcpu(env);
-
-    if (check_breakpoints(cpu)) {
-        HELPER(exception_internal(env, EXCP_DEBUG));
-    }
-}
-
-bool arm_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *wp)
-{
-    /*
-     * Called by core code when a CPU watchpoint fires; need to check if this
-     * is also an architectural watchpoint match.
-     */
-    ARMCPU *cpu = ARM_CPU(cs);
-
-    return check_watchpoints(cpu);
-}
-
-vaddr arm_adjust_watchpoint_address(CPUState *cs, vaddr addr, int len)
-{
-    ARMCPU *cpu = ARM_CPU(cs);
-    CPUARMState *env = &cpu->env;
-
-    /*
-     * In BE32 system mode, target memory is stored byteswapped (on a
-     * little-endian host system), and by the time we reach here (via an
-     * opcode helper) the addresses of subword accesses have been adjusted
-     * to account for that, which means that watchpoints will not match.
-     * Undo the adjustment here.
-     */
-    if (arm_sctlr_b(env)) {
-        if (len == 1) {
-            addr ^= 3;
-        } else if (len == 2) {
-            addr ^= 2;
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
-    ARMCPU *cpu = ARM_CPU(cs);
-    CPUARMState *env = &cpu->env;
-    CPUWatchpoint *wp_hit = cs->watchpoint_hit;
-
-    if (wp_hit) {
-        if (wp_hit->flags & BP_CPU) {
-            bool wnr = (wp_hit->flags & BP_WATCHPOINT_HIT_WRITE) != 0;
-            bool same_el = arm_debug_target_el(env) == arm_current_el(env);
-
-            cs->watchpoint_hit = NULL;
-
-            env->exception.fsr = arm_debug_exception_fsr(env);
-            env->exception.vaddress = wp_hit->hitaddr;
-            raise_exception(env, EXCP_DATA_ABORT,
-                    syn_watchpoint(same_el, 0, wnr),
-                    arm_debug_target_el(env));
-        }
-    } else {
-        uint64_t pc = is_a64(env) ? env->pc : env->regs[15];
-        bool same_el = (arm_debug_target_el(env) == arm_current_el(env));
-
-        /*
-         * (1) GDB breakpoints should be handled first.
-         * (2) Do not raise a CPU exception if no CPU breakpoint has fired,
-         * since singlestep is also done by generating a debug internal
-         * exception.
-         */
-        if (cpu_breakpoint_test(cs, pc, BP_GDB)
-            || !cpu_breakpoint_test(cs, pc, BP_CPU)) {
-            return;
-        }
-
-        env->exception.fsr = arm_debug_exception_fsr(env);
-        /*
-         * FAR is UNKNOWN: clear vaddress to avoid potentially exposing
-         * values to the guest that it shouldn't be able to see at its
-         * exception/security level.
-         */
-        env->exception.vaddress = 0;
-        raise_exception(env, EXCP_PREFETCH_ABORT,
-                        syn_breakpoint(same_el),
-                        arm_debug_target_el(env));
-    }
-}
-
 /* ??? Flag setting arithmetic is awkward because we need to do comparisons.
    The only way to do that in TCG is a conditional branch, which clobbers
    all our temporaries.  For now implement these as helper functions.  */
-- 
2.20.1



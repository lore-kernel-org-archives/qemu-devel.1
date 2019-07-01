Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB534C5B578
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 21:26:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68C77206A2
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 21:26:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lgwylm3h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68C77206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hi3p0-0002il-IR
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 17:26:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44556)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hi3DN-000156-Pw
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 16:47:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hi3DJ-00014K-F2
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 16:47:51 -0400
Received: from mail-wm1-f53.google.com ([209.85.128.53]:39562)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hi3DJ-00013b-3T
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 16:47:49 -0400
Received: by mail-wm1-f53.google.com with SMTP id z23so915515wma.4
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 13:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=Yg5Vx+HL92u3RjZhwa/JrTs4lVp0MXgbzgCuIPXTEJA=;
 b=lgwylm3h7UNq3fo3wlBmzBiyP+kL1F6Tyqk2qXYEP/4I1HfRMaM2mjpMBLHocjwKeS
 liTjBfIaCBEtYPMSOhzxGLYDZI8sdMzHtUnNd9xu8oFaOmDJ7kb6ukLm80LBqymLck8I
 zboXqBPyW2GXCPpQfGKC2kLum3yceaAVoEB2y9aZk+xQ/h8Njk3p3EeZfejvf1VoFERL
 nEjaQWKIwwekmnyxhARddcuLar48WqPfGex/KPP1cnSTm7slIyaf194lyFxuUFeMRQWP
 vHvOO7hdP9O/j4vGMzyDtqSLdBapG1g963p/V+uvEnQEeEPN4Q43ATyT4DsGF1Zu/XO4
 bUlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Yg5Vx+HL92u3RjZhwa/JrTs4lVp0MXgbzgCuIPXTEJA=;
 b=ihzk15pORXBgtoBTwM489pEWmy3PgPsGrjXSSFu9MYRcGF4aWmcdoIeh64dvE9wbXa
 Pt3kpowMPNGX8aBlWJygAsgersLUu7mUie/ksXVTa5kBywPzgfvrRMFWx5f3Kza1lQj8
 /gEXQY5b2/Lr52uaPPa3ipPN6PjDCa9gU77mzUXNC1+FwIJhdiCRLla2szzK5/wfdOTd
 bDdfDmiOt/IL8QmQ39taiNEhnJUr+KsRfjcvBRpxIcXe2ITswI5OX3qrL7lavA8zlQHv
 AdML05JDnTF3k46lH9SvRDT3mdYphDvNBTKnIP7kNfeiDe/iJjDEwKGBkktXF8IaK1af
 G02w==
X-Gm-Message-State: APjAAAVUXjX7d9bKs93YDNQqVfYAbaaJeC9yCW/PRqOU8RF/l+h7LYa1
 slolTjY1pCQ10bDiS/MFgb9+u8zbhTReKA==
X-Google-Smtp-Source: APXvYqxXvlU4Lml+RgWEsGhLIpp1R5DGGSLLtwebfSiF9z6A7VTieayFOjyjWwq82ep0C1f+qz3SbQ==
X-Received: by 2002:a1c:1f06:: with SMTP id f6mr147412wmf.60.1561999229372;
 Mon, 01 Jul 2019 09:40:29 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id o6sm26573508wra.27.2019.07.01.09.40.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 01 Jul 2019 09:40:28 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon,  1 Jul 2019 17:39:36 +0100
Message-Id: <20190701163943.22313-40-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190701163943.22313-1-peter.maydell@linaro.org>
References: <20190701163943.22313-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.53
Subject: [Qemu-devel] [PULL 39/46] target/arm: Move TLB related routines to
 tlb_helper.c
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
The arm_deliver_fault() function is only used within the new
helper. Make it static.

Suggested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20190701132516.26392-13-philmd@redhat.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/Makefile.objs |   1 +
 target/arm/internals.h   |   3 -
 target/arm/cpu.c         |   6 +-
 target/arm/helper.c      |  53 -----------
 target/arm/op_helper.c   | 135 --------------------------
 target/arm/tlb_helper.c  | 200 +++++++++++++++++++++++++++++++++++++++
 6 files changed, 205 insertions(+), 193 deletions(-)
 create mode 100644 target/arm/tlb_helper.c

diff --git a/target/arm/Makefile.objs b/target/arm/Makefile.objs
index 3fcda66132a..5c154f01c58 100644
--- a/target/arm/Makefile.objs
+++ b/target/arm/Makefile.objs
@@ -32,6 +32,7 @@ target/arm/translate-sve.o: target/arm/decode-sve.inc.c
 target/arm/translate.o: target/arm/decode-vfp.inc.c
 target/arm/translate.o: target/arm/decode-vfp-uncond.inc.c
 
+obj-y += tlb_helper.o
 obj-y += translate.o op_helper.o
 obj-y += crypto_helper.o
 obj-y += iwmmxt_helper.o vec_helper.o neon_helper.o
diff --git a/target/arm/internals.h b/target/arm/internals.h
index ff5ab0328e8..46a1313d69d 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -765,9 +765,6 @@ bool arm_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
                       MMUAccessType access_type, int mmu_idx,
                       bool probe, uintptr_t retaddr);
 
-void arm_deliver_fault(ARMCPU *cpu, vaddr addr, MMUAccessType access_type,
-                       int mmu_idx, ARMMMUFaultInfo *fi) QEMU_NORETURN;
-
 /* Return true if the stage 1 translation regime is using LPAE format page
  * tables */
 bool arm_s1_regime_using_lpae_format(CPUARMState *env, ARMMMUIdx mmu_idx);
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 1f73631bac0..f21261c8ff8 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2566,8 +2566,6 @@ static void arm_cpu_class_init(ObjectClass *oc, void *data)
     cc->gdb_write_register = arm_cpu_gdb_write_register;
 #ifndef CONFIG_USER_ONLY
     cc->do_interrupt = arm_cpu_do_interrupt;
-    cc->do_unaligned_access = arm_cpu_do_unaligned_access;
-    cc->do_transaction_failed = arm_cpu_do_transaction_failed;
     cc->get_phys_page_attrs_debug = arm_cpu_get_phys_page_attrs_debug;
     cc->asidx_from_attrs = arm_asidx_from_attrs;
     cc->vmsd = &vmstate_arm_cpu;
@@ -2590,6 +2588,10 @@ static void arm_cpu_class_init(ObjectClass *oc, void *data)
 #ifdef CONFIG_TCG
     cc->tcg_initialize = arm_translate_init;
     cc->tlb_fill = arm_cpu_tlb_fill;
+#if !defined(CONFIG_USER_ONLY)
+    cc->do_unaligned_access = arm_cpu_do_unaligned_access;
+    cc->do_transaction_failed = arm_cpu_do_transaction_failed;
+#endif /* CONFIG_TCG && !CONFIG_USER_ONLY */
 #endif
 }
 
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 063f4778e0a..4ef908c611e 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -13244,59 +13244,6 @@ uint32_t HELPER(v7m_tt)(CPUARMState *env, uint32_t addr, uint32_t op)
 
 #endif
 
-bool arm_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
-                      MMUAccessType access_type, int mmu_idx,
-                      bool probe, uintptr_t retaddr)
-{
-    ARMCPU *cpu = ARM_CPU(cs);
-
-#ifdef CONFIG_USER_ONLY
-    cpu->env.exception.vaddress = address;
-    if (access_type == MMU_INST_FETCH) {
-        cs->exception_index = EXCP_PREFETCH_ABORT;
-    } else {
-        cs->exception_index = EXCP_DATA_ABORT;
-    }
-    cpu_loop_exit_restore(cs, retaddr);
-#else
-    hwaddr phys_addr;
-    target_ulong page_size;
-    int prot, ret;
-    MemTxAttrs attrs = {};
-    ARMMMUFaultInfo fi = {};
-
-    /*
-     * Walk the page table and (if the mapping exists) add the page
-     * to the TLB.  On success, return true.  Otherwise, if probing,
-     * return false.  Otherwise populate fsr with ARM DFSR/IFSR fault
-     * register format, and signal the fault.
-     */
-    ret = get_phys_addr(&cpu->env, address, access_type,
-                        core_to_arm_mmu_idx(&cpu->env, mmu_idx),
-                        &phys_addr, &attrs, &prot, &page_size, &fi, NULL);
-    if (likely(!ret)) {
-        /*
-         * Map a single [sub]page. Regions smaller than our declared
-         * target page size are handled specially, so for those we
-         * pass in the exact addresses.
-         */
-        if (page_size >= TARGET_PAGE_SIZE) {
-            phys_addr &= TARGET_PAGE_MASK;
-            address &= TARGET_PAGE_MASK;
-        }
-        tlb_set_page_with_attrs(cs, address, phys_addr, attrs,
-                                prot, mmu_idx, page_size);
-        return true;
-    } else if (probe) {
-        return false;
-    } else {
-        /* now we have a real cpu fault */
-        cpu_restore_state(cs, retaddr, true);
-        arm_deliver_fault(cpu, address, access_type, mmu_idx, &fi);
-    }
-#endif
-}
-
 /* Note that signed overflow is undefined in C.  The following routines are
    careful to use unsigned types where modulo arithmetic is required.
    Failure to do so _will_ break on newer gcc.  */
diff --git a/target/arm/op_helper.c b/target/arm/op_helper.c
index 7c835d3ce77..9850993c114 100644
--- a/target/arm/op_helper.c
+++ b/target/arm/op_helper.c
@@ -88,141 +88,6 @@ uint32_t HELPER(neon_tbl)(uint32_t ireg, uint32_t def, void *vn,
     return val;
 }
 
-#if !defined(CONFIG_USER_ONLY)
-
-static inline uint32_t merge_syn_data_abort(uint32_t template_syn,
-                                            unsigned int target_el,
-                                            bool same_el, bool ea,
-                                            bool s1ptw, bool is_write,
-                                            int fsc)
-{
-    uint32_t syn;
-
-    /*
-     * ISV is only set for data aborts routed to EL2 and
-     * never for stage-1 page table walks faulting on stage 2.
-     *
-     * Furthermore, ISV is only set for certain kinds of load/stores.
-     * If the template syndrome does not have ISV set, we should leave
-     * it cleared.
-     *
-     * See ARMv8 specs, D7-1974:
-     * ISS encoding for an exception from a Data Abort, the
-     * ISV field.
-     */
-    if (!(template_syn & ARM_EL_ISV) || target_el != 2 || s1ptw) {
-        syn = syn_data_abort_no_iss(same_el,
-                                    ea, 0, s1ptw, is_write, fsc);
-    } else {
-        /*
-         * Fields: IL, ISV, SAS, SSE, SRT, SF and AR come from the template
-         * syndrome created at translation time.
-         * Now we create the runtime syndrome with the remaining fields.
-         */
-        syn = syn_data_abort_with_iss(same_el,
-                                      0, 0, 0, 0, 0,
-                                      ea, 0, s1ptw, is_write, fsc,
-                                      false);
-        /* Merge the runtime syndrome with the template syndrome.  */
-        syn |= template_syn;
-    }
-    return syn;
-}
-
-void arm_deliver_fault(ARMCPU *cpu, vaddr addr, MMUAccessType access_type,
-                       int mmu_idx, ARMMMUFaultInfo *fi)
-{
-    CPUARMState *env = &cpu->env;
-    int target_el;
-    bool same_el;
-    uint32_t syn, exc, fsr, fsc;
-    ARMMMUIdx arm_mmu_idx = core_to_arm_mmu_idx(env, mmu_idx);
-
-    target_el = exception_target_el(env);
-    if (fi->stage2) {
-        target_el = 2;
-        env->cp15.hpfar_el2 = extract64(fi->s2addr, 12, 47) << 4;
-    }
-    same_el = (arm_current_el(env) == target_el);
-
-    if (target_el == 2 || arm_el_is_aa64(env, target_el) ||
-        arm_s1_regime_using_lpae_format(env, arm_mmu_idx)) {
-        /*
-         * LPAE format fault status register : bottom 6 bits are
-         * status code in the same form as needed for syndrome
-         */
-        fsr = arm_fi_to_lfsc(fi);
-        fsc = extract32(fsr, 0, 6);
-    } else {
-        fsr = arm_fi_to_sfsc(fi);
-        /*
-         * Short format FSR : this fault will never actually be reported
-         * to an EL that uses a syndrome register. Use a (currently)
-         * reserved FSR code in case the constructed syndrome does leak
-         * into the guest somehow.
-         */
-        fsc = 0x3f;
-    }
-
-    if (access_type == MMU_INST_FETCH) {
-        syn = syn_insn_abort(same_el, fi->ea, fi->s1ptw, fsc);
-        exc = EXCP_PREFETCH_ABORT;
-    } else {
-        syn = merge_syn_data_abort(env->exception.syndrome, target_el,
-                                   same_el, fi->ea, fi->s1ptw,
-                                   access_type == MMU_DATA_STORE,
-                                   fsc);
-        if (access_type == MMU_DATA_STORE
-            && arm_feature(env, ARM_FEATURE_V6)) {
-            fsr |= (1 << 11);
-        }
-        exc = EXCP_DATA_ABORT;
-    }
-
-    env->exception.vaddress = addr;
-    env->exception.fsr = fsr;
-    raise_exception(env, exc, syn, target_el);
-}
-
-/* Raise a data fault alignment exception for the specified virtual address */
-void arm_cpu_do_unaligned_access(CPUState *cs, vaddr vaddr,
-                                 MMUAccessType access_type,
-                                 int mmu_idx, uintptr_t retaddr)
-{
-    ARMCPU *cpu = ARM_CPU(cs);
-    ARMMMUFaultInfo fi = {};
-
-    /* now we have a real cpu fault */
-    cpu_restore_state(cs, retaddr, true);
-
-    fi.type = ARMFault_Alignment;
-    arm_deliver_fault(cpu, vaddr, access_type, mmu_idx, &fi);
-}
-
-/*
- * arm_cpu_do_transaction_failed: handle a memory system error response
- * (eg "no device/memory present at address") by raising an external abort
- * exception
- */
-void arm_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
-                                   vaddr addr, unsigned size,
-                                   MMUAccessType access_type,
-                                   int mmu_idx, MemTxAttrs attrs,
-                                   MemTxResult response, uintptr_t retaddr)
-{
-    ARMCPU *cpu = ARM_CPU(cs);
-    ARMMMUFaultInfo fi = {};
-
-    /* now we have a real cpu fault */
-    cpu_restore_state(cs, retaddr, true);
-
-    fi.ea = arm_extabort_type(response);
-    fi.type = ARMFault_SyncExternal;
-    arm_deliver_fault(cpu, addr, access_type, mmu_idx, &fi);
-}
-
-#endif /* !defined(CONFIG_USER_ONLY) */
-
 void HELPER(v8m_stackcheck)(CPUARMState *env, uint32_t newvalue)
 {
     /*
diff --git a/target/arm/tlb_helper.c b/target/arm/tlb_helper.c
new file mode 100644
index 00000000000..5feb3129417
--- /dev/null
+++ b/target/arm/tlb_helper.c
@@ -0,0 +1,200 @@
+/*
+ * ARM TLB (Translation lookaside buffer) helpers.
+ *
+ * This code is licensed under the GNU GPL v2 or later.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include "qemu/osdep.h"
+#include "cpu.h"
+#include "internals.h"
+#include "exec/exec-all.h"
+
+#if !defined(CONFIG_USER_ONLY)
+
+static inline uint32_t merge_syn_data_abort(uint32_t template_syn,
+                                            unsigned int target_el,
+                                            bool same_el, bool ea,
+                                            bool s1ptw, bool is_write,
+                                            int fsc)
+{
+    uint32_t syn;
+
+    /*
+     * ISV is only set for data aborts routed to EL2 and
+     * never for stage-1 page table walks faulting on stage 2.
+     *
+     * Furthermore, ISV is only set for certain kinds of load/stores.
+     * If the template syndrome does not have ISV set, we should leave
+     * it cleared.
+     *
+     * See ARMv8 specs, D7-1974:
+     * ISS encoding for an exception from a Data Abort, the
+     * ISV field.
+     */
+    if (!(template_syn & ARM_EL_ISV) || target_el != 2 || s1ptw) {
+        syn = syn_data_abort_no_iss(same_el,
+                                    ea, 0, s1ptw, is_write, fsc);
+    } else {
+        /*
+         * Fields: IL, ISV, SAS, SSE, SRT, SF and AR come from the template
+         * syndrome created at translation time.
+         * Now we create the runtime syndrome with the remaining fields.
+         */
+        syn = syn_data_abort_with_iss(same_el,
+                                      0, 0, 0, 0, 0,
+                                      ea, 0, s1ptw, is_write, fsc,
+                                      false);
+        /* Merge the runtime syndrome with the template syndrome.  */
+        syn |= template_syn;
+    }
+    return syn;
+}
+
+static void QEMU_NORETURN arm_deliver_fault(ARMCPU *cpu, vaddr addr,
+                                            MMUAccessType access_type,
+                                            int mmu_idx, ARMMMUFaultInfo *fi)
+{
+    CPUARMState *env = &cpu->env;
+    int target_el;
+    bool same_el;
+    uint32_t syn, exc, fsr, fsc;
+    ARMMMUIdx arm_mmu_idx = core_to_arm_mmu_idx(env, mmu_idx);
+
+    target_el = exception_target_el(env);
+    if (fi->stage2) {
+        target_el = 2;
+        env->cp15.hpfar_el2 = extract64(fi->s2addr, 12, 47) << 4;
+    }
+    same_el = (arm_current_el(env) == target_el);
+
+    if (target_el == 2 || arm_el_is_aa64(env, target_el) ||
+        arm_s1_regime_using_lpae_format(env, arm_mmu_idx)) {
+        /*
+         * LPAE format fault status register : bottom 6 bits are
+         * status code in the same form as needed for syndrome
+         */
+        fsr = arm_fi_to_lfsc(fi);
+        fsc = extract32(fsr, 0, 6);
+    } else {
+        fsr = arm_fi_to_sfsc(fi);
+        /*
+         * Short format FSR : this fault will never actually be reported
+         * to an EL that uses a syndrome register. Use a (currently)
+         * reserved FSR code in case the constructed syndrome does leak
+         * into the guest somehow.
+         */
+        fsc = 0x3f;
+    }
+
+    if (access_type == MMU_INST_FETCH) {
+        syn = syn_insn_abort(same_el, fi->ea, fi->s1ptw, fsc);
+        exc = EXCP_PREFETCH_ABORT;
+    } else {
+        syn = merge_syn_data_abort(env->exception.syndrome, target_el,
+                                   same_el, fi->ea, fi->s1ptw,
+                                   access_type == MMU_DATA_STORE,
+                                   fsc);
+        if (access_type == MMU_DATA_STORE
+            && arm_feature(env, ARM_FEATURE_V6)) {
+            fsr |= (1 << 11);
+        }
+        exc = EXCP_DATA_ABORT;
+    }
+
+    env->exception.vaddress = addr;
+    env->exception.fsr = fsr;
+    raise_exception(env, exc, syn, target_el);
+}
+
+/* Raise a data fault alignment exception for the specified virtual address */
+void arm_cpu_do_unaligned_access(CPUState *cs, vaddr vaddr,
+                                 MMUAccessType access_type,
+                                 int mmu_idx, uintptr_t retaddr)
+{
+    ARMCPU *cpu = ARM_CPU(cs);
+    ARMMMUFaultInfo fi = {};
+
+    /* now we have a real cpu fault */
+    cpu_restore_state(cs, retaddr, true);
+
+    fi.type = ARMFault_Alignment;
+    arm_deliver_fault(cpu, vaddr, access_type, mmu_idx, &fi);
+}
+
+/*
+ * arm_cpu_do_transaction_failed: handle a memory system error response
+ * (eg "no device/memory present at address") by raising an external abort
+ * exception
+ */
+void arm_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
+                                   vaddr addr, unsigned size,
+                                   MMUAccessType access_type,
+                                   int mmu_idx, MemTxAttrs attrs,
+                                   MemTxResult response, uintptr_t retaddr)
+{
+    ARMCPU *cpu = ARM_CPU(cs);
+    ARMMMUFaultInfo fi = {};
+
+    /* now we have a real cpu fault */
+    cpu_restore_state(cs, retaddr, true);
+
+    fi.ea = arm_extabort_type(response);
+    fi.type = ARMFault_SyncExternal;
+    arm_deliver_fault(cpu, addr, access_type, mmu_idx, &fi);
+}
+
+#endif /* !defined(CONFIG_USER_ONLY) */
+
+bool arm_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
+                      MMUAccessType access_type, int mmu_idx,
+                      bool probe, uintptr_t retaddr)
+{
+    ARMCPU *cpu = ARM_CPU(cs);
+
+#ifdef CONFIG_USER_ONLY
+    cpu->env.exception.vaddress = address;
+    if (access_type == MMU_INST_FETCH) {
+        cs->exception_index = EXCP_PREFETCH_ABORT;
+    } else {
+        cs->exception_index = EXCP_DATA_ABORT;
+    }
+    cpu_loop_exit_restore(cs, retaddr);
+#else
+    hwaddr phys_addr;
+    target_ulong page_size;
+    int prot, ret;
+    MemTxAttrs attrs = {};
+    ARMMMUFaultInfo fi = {};
+
+    /*
+     * Walk the page table and (if the mapping exists) add the page
+     * to the TLB.  On success, return true.  Otherwise, if probing,
+     * return false.  Otherwise populate fsr with ARM DFSR/IFSR fault
+     * register format, and signal the fault.
+     */
+    ret = get_phys_addr(&cpu->env, address, access_type,
+                        core_to_arm_mmu_idx(&cpu->env, mmu_idx),
+                        &phys_addr, &attrs, &prot, &page_size, &fi, NULL);
+    if (likely(!ret)) {
+        /*
+         * Map a single [sub]page. Regions smaller than our declared
+         * target page size are handled specially, so for those we
+         * pass in the exact addresses.
+         */
+        if (page_size >= TARGET_PAGE_SIZE) {
+            phys_addr &= TARGET_PAGE_MASK;
+            address &= TARGET_PAGE_MASK;
+        }
+        tlb_set_page_with_attrs(cs, address, phys_addr, attrs,
+                                prot, mmu_idx, page_size);
+        return true;
+    } else if (probe) {
+        return false;
+    } else {
+        /* now we have a real cpu fault */
+        cpu_restore_state(cs, retaddr, true);
+        arm_deliver_fault(cpu, address, access_type, mmu_idx, &fi);
+    }
+#endif
+}
-- 
2.20.1



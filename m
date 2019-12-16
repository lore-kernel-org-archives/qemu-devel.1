Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D416C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 22:16:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47D6A206EC
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 22:16:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RXqunFBH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47D6A206EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igyfT-0001e6-Ov
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 17:16:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36634)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1igyb5-0004oy-Qs
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 17:12:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1igyb3-0006y5-Pp
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 17:12:11 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:41189)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1igyb3-0006wk-Hj
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 17:12:09 -0500
Received: by mail-pf1-x443.google.com with SMTP id s18so6375020pfd.8
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 14:12:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=NbXcHmPvccOg4ApdYdFLAPaKmhXfD3r1GQk/f9IlktA=;
 b=RXqunFBH/hWJW+YR1NpAkTmn/s5ZVCPMAOkp/Y79IjYrfEJjzFBJloY9yb3ORi0CHY
 JQ3U5E2Dw0Kxgt9HKBG6Z2uJvg3MhtTf0bbbyOHr6Mgrceobyt0WrM81Pvx6+6UkHib9
 em5A9ac173AYr1eAiLPs+inUqd3zHq6nDauBT1T/X+NDU5g8p6li854Zc6WiUNCaq7Zh
 62PF72ej6LPIxjnJdAgVEsouZ4QftSCtqgDUS3DJ+v0c0xB3wj4TuLC6hz5cxKF1soBX
 2DrkAwUQaYmIrvJ1+xLqSUdlHSFr/lrjzUfNMZ5/jeSi/Osa/I9uUZJekvsOwQUAeVDU
 88VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NbXcHmPvccOg4ApdYdFLAPaKmhXfD3r1GQk/f9IlktA=;
 b=Aby9PTKjiXG3cXZgGToaZg4Ec+0xCTP28axMp1WlMHiNfVMI93vpqj1a9WfSkYl58F
 2XdaVjktyvlWHRrWa/NuLLL5QBN0k8m96vWbnYJ4Flm+vT8qlBYUqE48ScoeTxkUXTIa
 w/1xNdDebKp9fQd56OCMK2TWFsUN6kJw45aQbw6Ys/B0n4+3lNHmh8c1icNQ3u1dOrPI
 wSAtzMlW5s6PUkZlvy5FCvkuhJmmH0X7J8uBSTMtvAMy3g/Qh11e0WR3vgRN+1LyxwpA
 TdSbn17mKyHWXgrQ4bmxyRJICTg3dvKTEKyhJXJYK/kKD8InykQo4NnceOMk3RwGBZxu
 AMrw==
X-Gm-Message-State: APjAAAVF8Qr6sRvxkWhx+kEYp8JtQx8LMppAn7Rx4UEyFKnJeeDvdQBE
 OGTAuTpEjFpm71ZDX36nkpnueNQXIxg=
X-Google-Smtp-Source: APXvYqz9o99/BjTIY0DQ6kJDnj1Gyftt99jc5d1pMI54HkWQ2pfX31r19fWCeJbp2MPFgP4qqXjXfA==
X-Received: by 2002:a63:f814:: with SMTP id n20mr20920041pgh.318.1576534328037; 
 Mon, 16 Dec 2019 14:12:08 -0800 (PST)
Received: from localhost.localdomain
 ([2605:e000:c74f:dc00:6838:d2b2:17e2:8445])
 by smtp.gmail.com with ESMTPSA id d6sm529767pjl.8.2019.12.16.14.12.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2019 14:12:07 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 04/28] cputlb: Move body of cpu_ldst_template.h out of line
Date: Mon, 16 Dec 2019 12:11:34 -1000
Message-Id: <20191216221158.29572-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191216221158.29572-1-richard.henderson@linaro.org>
References: <20191216221158.29572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
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

With the tracing hooks, the inline functions are no longer
so simple.  Once out-of-line, the current tlb_entry lookup
is redundant with the one in the main load/store_helper.

This also begins the introduction of a new target facing
interface, with suffix *_mmuidx_ra.  This is not yet
official because the interface is not done for user-only.

Use abi_ptr instead of target_ulong in preparation for
user-only; the two types are identical for softmmu.

What remains in cpu_ldst_template.h are the expansions
for _code, _data, and MMU_MODE<N>_SUFFIX.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu_ldst.h          |  25 ++++++-
 include/exec/cpu_ldst_template.h | 125 +++++++------------------------
 accel/tcg/cputlb.c               | 116 ++++++++++++++++++++++++++++
 3 files changed, 166 insertions(+), 100 deletions(-)

diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
index fd499f7e2f..cf8af36dbc 100644
--- a/include/exec/cpu_ldst.h
+++ b/include/exec/cpu_ldst.h
@@ -152,7 +152,7 @@ static inline void clear_helper_retaddr(void)
 
 #else
 
-/* The memory helpers for tcg-generated code need tcg_target_long etc.  */
+/* Needed for TCG_OVERSIZED_GUEST */
 #include "tcg.h"
 
 static inline target_ulong tlb_addr_write(const CPUTLBEntry *entry)
@@ -185,6 +185,29 @@ static inline CPUTLBEntry *tlb_entry(CPUArchState *env, uintptr_t mmu_idx,
     return &env_tlb(env)->f[mmu_idx].table[tlb_index(env, mmu_idx, addr)];
 }
 
+uint32_t cpu_ldub_mmuidx_ra(CPUArchState *env, abi_ptr addr,
+                            int mmu_idx, uintptr_t ra);
+uint32_t cpu_lduw_mmuidx_ra(CPUArchState *env, abi_ptr addr,
+                            int mmu_idx, uintptr_t ra);
+uint32_t cpu_ldl_mmuidx_ra(CPUArchState *env, abi_ptr addr,
+                           int mmu_idx, uintptr_t ra);
+uint64_t cpu_ldq_mmuidx_ra(CPUArchState *env, abi_ptr addr,
+                           int mmu_idx, uintptr_t ra);
+
+int cpu_ldsb_mmuidx_ra(CPUArchState *env, abi_ptr addr,
+                       int mmu_idx, uintptr_t ra);
+int cpu_ldsw_mmuidx_ra(CPUArchState *env, abi_ptr addr,
+                       int mmu_idx, uintptr_t ra);
+
+void cpu_stb_mmuidx_ra(CPUArchState *env, abi_ptr addr, uint32_t val,
+                       int mmu_idx, uintptr_t retaddr);
+void cpu_stw_mmuidx_ra(CPUArchState *env, abi_ptr addr, uint32_t val,
+                       int mmu_idx, uintptr_t retaddr);
+void cpu_stl_mmuidx_ra(CPUArchState *env, abi_ptr addr, uint32_t val,
+                       int mmu_idx, uintptr_t retaddr);
+void cpu_stq_mmuidx_ra(CPUArchState *env, abi_ptr addr, uint64_t val,
+                       int mmu_idx, uintptr_t retaddr);
+
 #ifdef MMU_MODE0_SUFFIX
 #define CPU_MMU_INDEX 0
 #define MEMSUFFIX MMU_MODE0_SUFFIX
diff --git a/include/exec/cpu_ldst_template.h b/include/exec/cpu_ldst_template.h
index 0ad5de3ef9..ea39e29c19 100644
--- a/include/exec/cpu_ldst_template.h
+++ b/include/exec/cpu_ldst_template.h
@@ -24,13 +24,6 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 
-#if !defined(SOFTMMU_CODE_ACCESS)
-#include "trace-root.h"
-#endif
-
-#include "qemu/plugin.h"
-#include "trace/mem.h"
-
 #if DATA_SIZE == 8
 #define SUFFIX q
 #define USUFFIX q
@@ -63,56 +56,40 @@
 #define RES_TYPE uint32_t
 #endif
 
+/* generic load/store macros */
+
 #ifdef SOFTMMU_CODE_ACCESS
-#define ADDR_READ addr_code
-#define MMUSUFFIX _cmmu
-#define URETSUFFIX USUFFIX
-#define SRETSUFFIX glue(s, SUFFIX)
-#else
-#define ADDR_READ addr_read
-#define MMUSUFFIX _mmu
-#define URETSUFFIX USUFFIX
-#define SRETSUFFIX glue(s, SUFFIX)
+
+static inline RES_TYPE
+glue(glue(cpu_ld, USUFFIX), _code)(CPUArchState *env, target_ulong ptr)
+{
+    TCGMemOpIdx oi = make_memop_idx(MO_TE | SHIFT, CPU_MMU_INDEX);
+    return glue(glue(helper_ret_ld, USUFFIX), _cmmu)(env, ptr, oi, 0);
+}
+
+#if DATA_SIZE <= 2
+static inline int
+glue(glue(cpu_lds, SUFFIX), _code)(CPUArchState *env, target_ulong ptr)
+{
+    return (DATA_STYPE)glue(glue(cpu_ld, USUFFIX), _code)(env, ptr);
+}
 #endif
 
-/* generic load/store macros */
+#else
 
 static inline RES_TYPE
 glue(glue(glue(cpu_ld, USUFFIX), MEMSUFFIX), _ra)(CPUArchState *env,
                                                   target_ulong ptr,
                                                   uintptr_t retaddr)
 {
-    CPUTLBEntry *entry;
-    RES_TYPE res;
-    target_ulong addr;
-    int mmu_idx = CPU_MMU_INDEX;
-    MemOp op = MO_TE | SHIFT;
-#if !defined(SOFTMMU_CODE_ACCESS)
-    uint16_t meminfo = trace_mem_get_info(op, mmu_idx, false);
-    trace_guest_mem_before_exec(env_cpu(env), ptr, meminfo);
-#endif
-
-    addr = ptr;
-    entry = tlb_entry(env, mmu_idx, addr);
-    if (unlikely(entry->ADDR_READ !=
-                 (addr & (TARGET_PAGE_MASK | (DATA_SIZE - 1))))) {
-        TCGMemOpIdx oi = make_memop_idx(op, mmu_idx);
-        res = glue(glue(helper_ret_ld, URETSUFFIX), MMUSUFFIX)(env, addr,
-                                                               oi, retaddr);
-    } else {
-        uintptr_t hostaddr = addr + entry->addend;
-        res = glue(glue(ld, USUFFIX), _p)((uint8_t *)hostaddr);
-    }
-#ifndef SOFTMMU_CODE_ACCESS
-    qemu_plugin_vcpu_mem_cb(env_cpu(env), ptr, meminfo);
-#endif
-    return res;
+    return glue(glue(cpu_ld, USUFFIX), _mmuidx_ra)(env, ptr, CPU_MMU_INDEX,
+                                                   retaddr);
 }
 
 static inline RES_TYPE
 glue(glue(cpu_ld, USUFFIX), MEMSUFFIX)(CPUArchState *env, target_ulong ptr)
 {
-    return glue(glue(glue(cpu_ld, USUFFIX), MEMSUFFIX), _ra)(env, ptr, 0);
+    return glue(glue(cpu_ld, USUFFIX), _mmuidx_ra)(env, ptr, CPU_MMU_INDEX, 0);
 }
 
 #if DATA_SIZE <= 2
@@ -121,42 +98,17 @@ glue(glue(glue(cpu_lds, SUFFIX), MEMSUFFIX), _ra)(CPUArchState *env,
                                                   target_ulong ptr,
                                                   uintptr_t retaddr)
 {
-    CPUTLBEntry *entry;
-    int res;
-    target_ulong addr;
-    int mmu_idx = CPU_MMU_INDEX;
-    MemOp op = MO_TE | MO_SIGN | SHIFT;
-#ifndef SOFTMMU_CODE_ACCESS
-    uint16_t meminfo = trace_mem_get_info(op, mmu_idx, false);
-    trace_guest_mem_before_exec(env_cpu(env), ptr, meminfo);
-#endif
-
-    addr = ptr;
-    entry = tlb_entry(env, mmu_idx, addr);
-    if (unlikely(entry->ADDR_READ !=
-                 (addr & (TARGET_PAGE_MASK | (DATA_SIZE - 1))))) {
-        TCGMemOpIdx oi = make_memop_idx(op & ~MO_SIGN, mmu_idx);
-        res = (DATA_STYPE)glue(glue(helper_ret_ld, SRETSUFFIX),
-                               MMUSUFFIX)(env, addr, oi, retaddr);
-    } else {
-        uintptr_t hostaddr = addr + entry->addend;
-        res = glue(glue(lds, SUFFIX), _p)((uint8_t *)hostaddr);
-    }
-#ifndef SOFTMMU_CODE_ACCESS
-    qemu_plugin_vcpu_mem_cb(env_cpu(env), ptr, meminfo);
-#endif
-    return res;
+    return glue(glue(cpu_lds, SUFFIX), _mmuidx_ra)(env, ptr, CPU_MMU_INDEX,
+                                                   retaddr);
 }
 
 static inline int
 glue(glue(cpu_lds, SUFFIX), MEMSUFFIX)(CPUArchState *env, target_ulong ptr)
 {
-    return glue(glue(glue(cpu_lds, SUFFIX), MEMSUFFIX), _ra)(env, ptr, 0);
+    return glue(glue(cpu_lds, SUFFIX), _mmuidx_ra)(env, ptr, CPU_MMU_INDEX, 0);
 }
 #endif
 
-#ifndef SOFTMMU_CODE_ACCESS
-
 /* generic store macro */
 
 static inline void
@@ -164,36 +116,15 @@ glue(glue(glue(cpu_st, SUFFIX), MEMSUFFIX), _ra)(CPUArchState *env,
                                                  target_ulong ptr,
                                                  RES_TYPE v, uintptr_t retaddr)
 {
-    CPUTLBEntry *entry;
-    target_ulong addr;
-    int mmu_idx = CPU_MMU_INDEX;
-    MemOp op = MO_TE | SHIFT;
-#if !defined(SOFTMMU_CODE_ACCESS)
-    uint16_t meminfo = trace_mem_get_info(op, mmu_idx, true);
-    trace_guest_mem_before_exec(env_cpu(env), ptr, meminfo);
-#endif
-
-    addr = ptr;
-    entry = tlb_entry(env, mmu_idx, addr);
-    if (unlikely(tlb_addr_write(entry) !=
-                 (addr & (TARGET_PAGE_MASK | (DATA_SIZE - 1))))) {
-        TCGMemOpIdx oi = make_memop_idx(op, mmu_idx);
-        glue(glue(helper_ret_st, SUFFIX), MMUSUFFIX)(env, addr, v, oi,
-                                                     retaddr);
-    } else {
-        uintptr_t hostaddr = addr + entry->addend;
-        glue(glue(st, SUFFIX), _p)((uint8_t *)hostaddr, v);
-    }
-#ifndef SOFTMMU_CODE_ACCESS
-    qemu_plugin_vcpu_mem_cb(env_cpu(env), ptr, meminfo);
-#endif
+    glue(glue(cpu_st, SUFFIX), _mmuidx_ra)(env, ptr, v, CPU_MMU_INDEX,
+                                           retaddr);
 }
 
 static inline void
 glue(glue(cpu_st, SUFFIX), MEMSUFFIX)(CPUArchState *env, target_ulong ptr,
                                       RES_TYPE v)
 {
-    glue(glue(glue(cpu_st, SUFFIX), MEMSUFFIX), _ra)(env, ptr, v, 0);
+    glue(glue(cpu_st, SUFFIX), _mmuidx_ra)(env, ptr, v, CPU_MMU_INDEX, 0);
 }
 
 #endif /* !SOFTMMU_CODE_ACCESS */
@@ -204,8 +135,4 @@ glue(glue(cpu_st, SUFFIX), MEMSUFFIX)(CPUArchState *env, target_ulong ptr,
 #undef SUFFIX
 #undef USUFFIX
 #undef DATA_SIZE
-#undef MMUSUFFIX
-#undef ADDR_READ
-#undef URETSUFFIX
-#undef SRETSUFFIX
 #undef SHIFT
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 98221948d6..ddd19718bf 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -34,6 +34,9 @@
 #include "qemu/atomic.h"
 #include "qemu/atomic128.h"
 #include "translate-all.h"
+#include "trace-root.h"
+#include "qemu/plugin.h"
+#include "trace/mem.h"
 #ifdef CONFIG_PLUGIN
 #include "qemu/plugin-memory.h"
 #endif
@@ -1625,6 +1628,75 @@ tcg_target_ulong helper_be_ldsl_mmu(CPUArchState *env, target_ulong addr,
     return (int32_t)helper_be_ldul_mmu(env, addr, oi, retaddr);
 }
 
+/*
+ * Load helpers for cpu_ldst.h.
+ */
+
+static inline uint64_t cpu_load_helper(CPUArchState *env, abi_ptr addr,
+                                       int mmu_idx, uintptr_t retaddr,
+                                       MemOp op, FullLoadHelper *full_load)
+{
+    uint16_t meminfo;
+    TCGMemOpIdx oi;
+    uint64_t ret;
+
+    meminfo = trace_mem_get_info(op, mmu_idx, false);
+    trace_guest_mem_before_exec(env_cpu(env), addr, meminfo);
+
+    op &= ~MO_SIGN;
+    oi = make_memop_idx(op, mmu_idx);
+    ret = full_load(env, addr, oi, retaddr);
+
+    qemu_plugin_vcpu_mem_cb(env_cpu(env), addr, meminfo);
+
+    return ret;
+}
+
+uint32_t cpu_ldub_mmuidx_ra(CPUArchState *env, abi_ptr addr,
+                            int mmu_idx, uintptr_t ra)
+{
+    return cpu_load_helper(env, addr, mmu_idx, ra, MO_UB, full_ldub_mmu);
+}
+
+int cpu_ldsb_mmuidx_ra(CPUArchState *env, abi_ptr addr,
+                       int mmu_idx, uintptr_t ra)
+{
+    return (int8_t)cpu_load_helper(env, addr, mmu_idx, ra, MO_SB,
+                                   full_ldub_mmu);
+}
+
+uint32_t cpu_lduw_mmuidx_ra(CPUArchState *env, abi_ptr addr,
+                            int mmu_idx, uintptr_t ra)
+{
+    return cpu_load_helper(env, addr, mmu_idx, ra, MO_TEUW,
+                           MO_TE == MO_LE
+                           ? full_le_lduw_mmu : full_be_lduw_mmu);
+}
+
+int cpu_ldsw_mmuidx_ra(CPUArchState *env, abi_ptr addr,
+                       int mmu_idx, uintptr_t ra)
+{
+    return (int16_t)cpu_load_helper(env, addr, mmu_idx, ra, MO_TESW,
+                                    MO_TE == MO_LE
+                                    ? full_le_lduw_mmu : full_be_lduw_mmu);
+}
+
+uint32_t cpu_ldl_mmuidx_ra(CPUArchState *env, abi_ptr addr,
+                           int mmu_idx, uintptr_t ra)
+{
+    return cpu_load_helper(env, addr, mmu_idx, ra, MO_TEUL,
+                           MO_TE == MO_LE
+                           ? full_le_ldul_mmu : full_be_ldul_mmu);
+}
+
+uint64_t cpu_ldq_mmuidx_ra(CPUArchState *env, abi_ptr addr,
+                           int mmu_idx, uintptr_t ra)
+{
+    return cpu_load_helper(env, addr, mmu_idx, ra, MO_TEQ,
+                           MO_TE == MO_LE
+                           ? helper_le_ldq_mmu : helper_be_ldq_mmu);
+}
+
 /*
  * Store Helpers
  */
@@ -1854,6 +1926,50 @@ void helper_be_stq_mmu(CPUArchState *env, target_ulong addr, uint64_t val,
     store_helper(env, addr, val, oi, retaddr, MO_BEQ);
 }
 
+/*
+ * Store Helpers for cpu_ldst.h
+ */
+
+static inline void QEMU_ALWAYS_INLINE
+cpu_store_helper(CPUArchState *env, target_ulong addr, uint64_t val,
+                 int mmu_idx, uintptr_t retaddr, MemOp op)
+{
+    TCGMemOpIdx oi;
+    uint16_t meminfo;
+
+    meminfo = trace_mem_get_info(op, mmu_idx, true);
+    trace_guest_mem_before_exec(env_cpu(env), addr, meminfo);
+
+    oi = make_memop_idx(op, mmu_idx);
+    store_helper(env, addr, val, oi, retaddr, op);
+
+    qemu_plugin_vcpu_mem_cb(env_cpu(env), addr, meminfo);
+}
+
+void cpu_stb_mmuidx_ra(CPUArchState *env, target_ulong addr, uint32_t val,
+                       int mmu_idx, uintptr_t retaddr)
+{
+    cpu_store_helper(env, addr, val, mmu_idx, retaddr, MO_UB);
+}
+
+void cpu_stw_mmuidx_ra(CPUArchState *env, target_ulong addr, uint32_t val,
+                       int mmu_idx, uintptr_t retaddr)
+{
+    cpu_store_helper(env, addr, val, mmu_idx, retaddr, MO_TEUW);
+}
+
+void cpu_stl_mmuidx_ra(CPUArchState *env, target_ulong addr, uint32_t val,
+                       int mmu_idx, uintptr_t retaddr)
+{
+    cpu_store_helper(env, addr, val, mmu_idx, retaddr, MO_TEUL);
+}
+
+void cpu_stq_mmuidx_ra(CPUArchState *env, target_ulong addr, uint64_t val,
+                       int mmu_idx, uintptr_t retaddr)
+{
+    cpu_store_helper(env, addr, val, mmu_idx, retaddr, MO_TEQ);
+}
+
 /* First set of helpers allows passing in of OI and RETADDR.  This makes
    them callable from other helpers.  */
 
-- 
2.20.1



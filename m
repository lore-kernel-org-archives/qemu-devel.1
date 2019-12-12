Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88F91C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 04:03:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 463212173E
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 04:03:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wrb/9bxA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 463212173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifFgv-0002ld-3o
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 23:03:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48337)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ifFes-0000rC-4H
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 23:01:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ifFen-000411-4o
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 23:00:57 -0500
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:42302)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ifFem-0003wi-PG
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 23:00:52 -0500
Received: by mail-pg1-x541.google.com with SMTP id s64so425441pgb.9
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2019 20:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=pMXvRtwblwTVp1K7n5iNlYIpXrEp59o3OFgO4BWA3Ho=;
 b=Wrb/9bxATO9vWpo46CL1Ib8ZbAXNbLCxPxgz3/56q0XtIGkq3n/KBXC8OXhqmDN7wa
 CzBGueJTM7fjzJyrJhrXlp94jmxV1fEhh2IQA8dO8Nakn3/+Ljn3gcmj9Bd1zjNXFumd
 SuRt2WL6/rsUVM76tODz7DH832XQKfiaDp3Kbu3iyVdaU04a07WLVMubInH/sFU5/utG
 ZZwMUCm2BtRbGYIC57N3OkfJOtBLL9a4kllvf5BnLeEYKHpc6T2C8PwICjZUaAaTKBR8
 r0PqIcgjHeoqhIc3xon48xmYRA+K/IXYz2nN5Zs4JFg/zuqWHIbZn84k8yBMjg1G+W97
 QbYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=pMXvRtwblwTVp1K7n5iNlYIpXrEp59o3OFgO4BWA3Ho=;
 b=DXDwNzjcmBxpp/J3uASFte1qvYNID3bpcX4uCCxeEGHvNHTaieWb5csJ9Ou3389FDi
 NOJkc+bLfLAmEanrQ4u+FvKJ7qyEd1SyoP37kC8xhDwQB1xaegcTNAnb0h4WP4d26rz1
 RMSSdQ2WI1/WPwMjfi/xZ8vW8Hyt3zATAClHzC+qBF0FBJ4tJVdbIgTb9KKPCjq5R2l9
 RCW/ByQ6W10hWwR0dWMn2JA0fHPeW5ynhIXHmX3N6c4YosHyo36gSpkkz9kIypJZVdJc
 bL9aV5GFmkANnY3VptojTU0dzJkky1C5cxspAFDUDvu+r8Y3cNZqfwOe+7owrn9qF0l5
 5k5g==
X-Gm-Message-State: APjAAAUiikgyE9hUMEoPVsJ6BsYH++pR5IzMq51spAFZlBeRNNtnnpI2
 fW9eMdNviKqtraC9hsmL1OyvxyiA79U=
X-Google-Smtp-Source: APXvYqxhhtlageQDdkj9ZyJAQ3it1jYdT/6LylcZShLebwMTlox/oKfFEPC4C1yny2rLsxDW29itXQ==
X-Received: by 2002:a63:a03:: with SMTP id 3mr8128401pgk.117.1576123246186;
 Wed, 11 Dec 2019 20:00:46 -0800 (PST)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id z130sm4666391pgz.6.2019.12.11.20.00.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2019 20:00:45 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 04/28] cputlb: Move body of cpu_ldst_template.h out of line
Date: Wed, 11 Dec 2019 20:00:15 -0800
Message-Id: <20191212040039.26546-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191212040039.26546-1-richard.henderson@linaro.org>
References: <20191212040039.26546-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
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
index 98221948d6..4d3ec1d35a 100644
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
+static inline uint64_t QEMU_ALWAYS_INLINE
+cpu_load_helper(CPUArchState *env, abi_ptr addr, int mmu_idx,
+                uintptr_t retaddr, MemOp op, FullLoadHelper *full_load)
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
+    ret = load_helper(env, addr, oi, retaddr, op, false, full_load);
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



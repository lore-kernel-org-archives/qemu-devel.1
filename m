Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE94BC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 04:23:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60DCC214D8
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 04:23:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CkEazuxO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60DCC214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifG0G-0002cr-Fw
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 23:23:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51720)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ifFfE-0001BY-W4
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 23:01:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ifFfC-0004d1-NT
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 23:01:20 -0500
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:37328)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ifFfC-0004bd-F2
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 23:01:18 -0500
Received: by mail-pg1-x541.google.com with SMTP id q127so439164pga.4
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2019 20:01:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=33Q4Yqkuc7Q0/fUqgwOWgoOSsW6NeczfiBq3tI04bWU=;
 b=CkEazuxOwT4CSr9qzgQ+zz87JveXOkHyZm8DfK6cGSL8NAg+lnUumLmhjxfYekasT4
 OoF+nnN+hhRMWceGeYPNBw1TdXfVY0n9k7O8JXb8W8QTgDpl9JBpLtTI4Za+9oL44rae
 7RyXNaveZi8QR8r2ACvvM1QHfSU9N6tlGRZdoJJWxoJas6bkACSGcLk7QkQB8ZMLJGDy
 EshPM4XbAi6ys28kUU9ox87yiqctc13yj4F6Wt9TfZ7XpiAR0uN+QXSTpF0eaAJCfUN1
 yJnqQbmNUHXcxTJnlqrcOGWnqQm9Rz6X8Rqy8a+g/0EarORMwT1HFhUQSBMed/dSDa8/
 oZ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=33Q4Yqkuc7Q0/fUqgwOWgoOSsW6NeczfiBq3tI04bWU=;
 b=mEQ4cnL7TDXSh2uoppV1s7CRM45s5UxVVxsOVg/iMSJyxmYhxHVGceFJbhFKXLzJB9
 FWQjYZR4gWGZzLMx4c0W0hMoRuKZcH7mSoOZgDFHZthMXS8p0Gp3Uk+CAiTt+wBp0Hd3
 agCDa5jTxkQDYeZ6+z7X29HWNpTgxV53NdGJtDlYLFqb0diM83o8PUG456poKEdwOQgf
 5HGmsJE1xvEQ8kPOrRjeybwgD+PVNLwOwG9wHlxsEwfQuULBRY+C5T+m/5Tkfiq1npFt
 Jnfg538tf36jMg8NCWysRi5zvDY7cq+npoyVShHerVyMdETAsHdh6IongrMNEaF+9AXh
 W+lQ==
X-Gm-Message-State: APjAAAXESGfQVygA0TuKA2WUbGMN2MKqvgynwkBjkNoFy7zcuvGquDa/
 47zJWC0iBeatuJRbSkivvP14eeyc6S0=
X-Google-Smtp-Source: APXvYqyOI/q+erce3O/wr+4eTWPTmZkP22OK4hLbhmxtbHvGgsLnA6/fM/e5ThsZuMryfWHwKVwo7Q==
X-Received: by 2002:a63:512:: with SMTP id 18mr8227357pgf.221.1576123276957;
 Wed, 11 Dec 2019 20:01:16 -0800 (PST)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id z130sm4666391pgz.6.2019.12.11.20.01.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2019 20:01:16 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 28/28] cputlb: Expand cpu_ldst_template.h in cputlb.c
Date: Wed, 11 Dec 2019 20:00:39 -0800
Message-Id: <20191212040039.26546-29-richard.henderson@linaro.org>
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

Reduce the amount of preprocessor obfuscation by expanding
the text of each of the functions generated.  The result is
only slightly smaller than the original.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu_ldst.h          |  67 +++++++-----------
 include/exec/cpu_ldst_template.h | 117 -------------------------------
 accel/tcg/cputlb.c               | 107 +++++++++++++++++++++++++++-
 3 files changed, 130 insertions(+), 161 deletions(-)
 delete mode 100644 include/exec/cpu_ldst_template.h

diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
index eb2756e214..d7a20145ce 100644
--- a/include/exec/cpu_ldst.h
+++ b/include/exec/cpu_ldst.h
@@ -98,32 +98,6 @@ typedef target_ulong abi_ptr;
 #define TARGET_ABI_FMT_ptr TARGET_ABI_FMT_lx
 #endif
 
-#if defined(CONFIG_USER_ONLY)
-
-extern __thread uintptr_t helper_retaddr;
-
-static inline void set_helper_retaddr(uintptr_t ra)
-{
-    helper_retaddr = ra;
-    /*
-     * Ensure that this write is visible to the SIGSEGV handler that
-     * may be invoked due to a subsequent invalid memory operation.
-     */
-    signal_barrier();
-}
-
-static inline void clear_helper_retaddr(void)
-{
-    /*
-     * Ensure that previous memory operations have succeeded before
-     * removing the data visible to the signal handler.
-     */
-    signal_barrier();
-    helper_retaddr = 0;
-}
-
-/* In user-only mode we provide only the _code and _data accessors. */
-
 uint32_t cpu_ldub_data(CPUArchState *env, abi_ptr ptr);
 uint32_t cpu_lduw_data(CPUArchState *env, abi_ptr ptr);
 uint32_t cpu_ldl_data(CPUArchState *env, abi_ptr ptr);
@@ -152,6 +126,30 @@ void cpu_stl_data_ra(CPUArchState *env, abi_ptr ptr,
 void cpu_stq_data_ra(CPUArchState *env, abi_ptr ptr,
                      uint64_t val, uintptr_t retaddr);
 
+#if defined(CONFIG_USER_ONLY)
+
+extern __thread uintptr_t helper_retaddr;
+
+static inline void set_helper_retaddr(uintptr_t ra)
+{
+    helper_retaddr = ra;
+    /*
+     * Ensure that this write is visible to the SIGSEGV handler that
+     * may be invoked due to a subsequent invalid memory operation.
+     */
+    signal_barrier();
+}
+
+static inline void clear_helper_retaddr(void)
+{
+    /*
+     * Ensure that previous memory operations have succeeded before
+     * removing the data visible to the signal handler.
+     */
+    signal_barrier();
+    helper_retaddr = 0;
+}
+
 /*
  * Provide the same *_mmuidx_ra interface as for softmmu.
  * The mmu_idx argument is ignored.
@@ -275,23 +273,6 @@ void cpu_stl_mmuidx_ra(CPUArchState *env, abi_ptr addr, uint32_t val,
 void cpu_stq_mmuidx_ra(CPUArchState *env, abi_ptr addr, uint64_t val,
                        int mmu_idx, uintptr_t retaddr);
 
-/* these access are slower, they must be as rare as possible */
-#define CPU_MMU_INDEX (cpu_mmu_index(env, false))
-#define MEMSUFFIX _data
-#define DATA_SIZE 1
-#include "exec/cpu_ldst_template.h"
-
-#define DATA_SIZE 2
-#include "exec/cpu_ldst_template.h"
-
-#define DATA_SIZE 4
-#include "exec/cpu_ldst_template.h"
-
-#define DATA_SIZE 8
-#include "exec/cpu_ldst_template.h"
-#undef CPU_MMU_INDEX
-#undef MEMSUFFIX
-
 #endif /* defined(CONFIG_USER_ONLY) */
 
 uint32_t cpu_ldub_code(CPUArchState *env, abi_ptr addr);
diff --git a/include/exec/cpu_ldst_template.h b/include/exec/cpu_ldst_template.h
deleted file mode 100644
index e400979f23..0000000000
--- a/include/exec/cpu_ldst_template.h
+++ /dev/null
@@ -1,117 +0,0 @@
-/*
- *  Software MMU support
- *
- * Generate inline load/store functions for one MMU mode and data
- * size.
- *
- * Generate a store function as well as signed and unsigned loads.
- *
- * Not used directly but included from cpu_ldst.h.
- *
- *  Copyright (c) 2003 Fabrice Bellard
- *
- * This library is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
- *
- * This library is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, see <http://www.gnu.org/licenses/>.
- */
-
-#if DATA_SIZE == 8
-#define SUFFIX q
-#define USUFFIX q
-#define DATA_TYPE uint64_t
-#define SHIFT 3
-#elif DATA_SIZE == 4
-#define SUFFIX l
-#define USUFFIX l
-#define DATA_TYPE uint32_t
-#define SHIFT 2
-#elif DATA_SIZE == 2
-#define SUFFIX w
-#define USUFFIX uw
-#define DATA_TYPE uint16_t
-#define DATA_STYPE int16_t
-#define SHIFT 1
-#elif DATA_SIZE == 1
-#define SUFFIX b
-#define USUFFIX ub
-#define DATA_TYPE uint8_t
-#define DATA_STYPE int8_t
-#define SHIFT 0
-#else
-#error unsupported data size
-#endif
-
-#if DATA_SIZE == 8
-#define RES_TYPE uint64_t
-#else
-#define RES_TYPE uint32_t
-#endif
-
-/* generic load/store macros */
-
-static inline RES_TYPE
-glue(glue(glue(cpu_ld, USUFFIX), MEMSUFFIX), _ra)(CPUArchState *env,
-                                                  target_ulong ptr,
-                                                  uintptr_t retaddr)
-{
-    return glue(glue(cpu_ld, USUFFIX), _mmuidx_ra)(env, ptr, CPU_MMU_INDEX,
-                                                   retaddr);
-}
-
-static inline RES_TYPE
-glue(glue(cpu_ld, USUFFIX), MEMSUFFIX)(CPUArchState *env, target_ulong ptr)
-{
-    return glue(glue(cpu_ld, USUFFIX), _mmuidx_ra)(env, ptr, CPU_MMU_INDEX, 0);
-}
-
-#if DATA_SIZE <= 2
-static inline int
-glue(glue(glue(cpu_lds, SUFFIX), MEMSUFFIX), _ra)(CPUArchState *env,
-                                                  target_ulong ptr,
-                                                  uintptr_t retaddr)
-{
-    return glue(glue(cpu_lds, SUFFIX), _mmuidx_ra)(env, ptr, CPU_MMU_INDEX,
-                                                   retaddr);
-}
-
-static inline int
-glue(glue(cpu_lds, SUFFIX), MEMSUFFIX)(CPUArchState *env, target_ulong ptr)
-{
-    return glue(glue(cpu_lds, SUFFIX), _mmuidx_ra)(env, ptr, CPU_MMU_INDEX, 0);
-}
-#endif
-
-/* generic store macro */
-
-static inline void
-glue(glue(glue(cpu_st, SUFFIX), MEMSUFFIX), _ra)(CPUArchState *env,
-                                                 target_ulong ptr,
-                                                 RES_TYPE v, uintptr_t retaddr)
-{
-    glue(glue(cpu_st, SUFFIX), _mmuidx_ra)(env, ptr, v, CPU_MMU_INDEX,
-                                           retaddr);
-}
-
-static inline void
-glue(glue(cpu_st, SUFFIX), MEMSUFFIX)(CPUArchState *env, target_ulong ptr,
-                                      RES_TYPE v)
-{
-    glue(glue(cpu_st, SUFFIX), _mmuidx_ra)(env, ptr, v, CPU_MMU_INDEX, 0);
-}
-
-#undef RES_TYPE
-#undef DATA_TYPE
-#undef DATA_STYPE
-#undef SUFFIX
-#undef USUFFIX
-#undef DATA_SIZE
-#undef SHIFT
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 7d519738bb..34560dd3e1 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -35,7 +35,6 @@
 #include "qemu/atomic128.h"
 #include "translate-all.h"
 #include "trace-root.h"
-#include "qemu/plugin.h"
 #include "trace/mem.h"
 #ifdef CONFIG_PLUGIN
 #include "qemu/plugin-memory.h"
@@ -1697,6 +1696,68 @@ uint64_t cpu_ldq_mmuidx_ra(CPUArchState *env, abi_ptr addr,
                            ? helper_le_ldq_mmu : helper_be_ldq_mmu);
 }
 
+uint32_t cpu_ldub_data_ra(CPUArchState *env, target_ulong ptr,
+                          uintptr_t retaddr)
+{
+    return cpu_ldub_mmuidx_ra(env, ptr, cpu_mmu_index(env, false), retaddr);
+}
+
+int cpu_ldsb_data_ra(CPUArchState *env, target_ulong ptr, uintptr_t retaddr)
+{
+    return cpu_ldsb_mmuidx_ra(env, ptr, cpu_mmu_index(env, false), retaddr);
+}
+
+uint32_t cpu_lduw_data_ra(CPUArchState *env, target_ulong ptr,
+                          uintptr_t retaddr)
+{
+    return cpu_lduw_mmuidx_ra(env, ptr, cpu_mmu_index(env, false), retaddr);
+}
+
+int cpu_ldsw_data_ra(CPUArchState *env, target_ulong ptr, uintptr_t retaddr)
+{
+    return cpu_ldsw_mmuidx_ra(env, ptr, cpu_mmu_index(env, false), retaddr);
+}
+
+uint32_t cpu_ldl_data_ra(CPUArchState *env, target_ulong ptr, uintptr_t retaddr)
+{
+    return cpu_ldl_mmuidx_ra(env, ptr, cpu_mmu_index(env, false), retaddr);
+}
+
+uint64_t cpu_ldq_data_ra(CPUArchState *env, target_ulong ptr, uintptr_t retaddr)
+{
+    return cpu_ldq_mmuidx_ra(env, ptr, cpu_mmu_index(env, false), retaddr);
+}
+
+uint32_t cpu_ldub_data(CPUArchState *env, target_ulong ptr)
+{
+    return cpu_ldub_data_ra(env, ptr, 0);
+}
+
+int cpu_ldsb_data(CPUArchState *env, target_ulong ptr)
+{
+    return cpu_ldsb_data_ra(env, ptr, 0);
+}
+
+uint32_t cpu_lduw_data(CPUArchState *env, target_ulong ptr)
+{
+    return cpu_lduw_data_ra(env, ptr, 0);
+}
+
+int cpu_ldsw_data(CPUArchState *env, target_ulong ptr)
+{
+    return cpu_ldsw_data_ra(env, ptr, 0);
+}
+
+uint32_t cpu_ldl_data(CPUArchState *env, target_ulong ptr)
+{
+    return cpu_ldl_data_ra(env, ptr, 0);
+}
+
+uint64_t cpu_ldq_data(CPUArchState *env, target_ulong ptr)
+{
+    return cpu_ldq_data_ra(env, ptr, 0);
+}
+
 /*
  * Store Helpers
  */
@@ -1970,6 +2031,50 @@ void cpu_stq_mmuidx_ra(CPUArchState *env, target_ulong addr, uint64_t val,
     cpu_store_helper(env, addr, val, mmu_idx, retaddr, MO_TEQ);
 }
 
+void cpu_stb_data_ra(CPUArchState *env, target_ulong ptr,
+                     uint32_t val, uintptr_t retaddr)
+{
+    cpu_stb_mmuidx_ra(env, ptr, val, cpu_mmu_index(env, false), retaddr);
+}
+
+void cpu_stw_data_ra(CPUArchState *env, target_ulong ptr,
+                     uint32_t val, uintptr_t retaddr)
+{
+    cpu_stw_mmuidx_ra(env, ptr, val, cpu_mmu_index(env, false), retaddr);
+}
+
+void cpu_stl_data_ra(CPUArchState *env, target_ulong ptr,
+                     uint32_t val, uintptr_t retaddr)
+{
+    cpu_stl_mmuidx_ra(env, ptr, val, cpu_mmu_index(env, false), retaddr);
+}
+
+void cpu_stq_data_ra(CPUArchState *env, target_ulong ptr,
+                     uint64_t val, uintptr_t retaddr)
+{
+    cpu_stq_mmuidx_ra(env, ptr, val, cpu_mmu_index(env, false), retaddr);
+}
+
+void cpu_stb_data(CPUArchState *env, target_ulong ptr, uint32_t val)
+{
+    cpu_stb_data_ra(env, ptr, val, 0);
+}
+
+void cpu_stw_data(CPUArchState *env, target_ulong ptr, uint32_t val)
+{
+    cpu_stw_data_ra(env, ptr, val, 0);
+}
+
+void cpu_stl_data(CPUArchState *env, target_ulong ptr, uint32_t val)
+{
+    cpu_stl_data_ra(env, ptr, val, 0);
+}
+
+void cpu_stq_data(CPUArchState *env, target_ulong ptr, uint64_t val)
+{
+    cpu_stq_data_ra(env, ptr, val, 0);
+}
+
 /* First set of helpers allows passing in of OI and RETADDR.  This makes
    them callable from other helpers.  */
 
-- 
2.20.1



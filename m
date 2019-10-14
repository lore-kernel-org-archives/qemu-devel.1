Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C42E7C4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 10:55:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82A3D217D6
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 10:55:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NF/78zmf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82A3D217D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJy0Y-0004T9-At
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 06:55:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44457)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iJxvI-0007JL-CK
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 06:49:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iJxvF-0005wF-Hc
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 06:49:56 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:41044)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iJxvF-0005vJ-A4
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 06:49:53 -0400
Received: by mail-wr1-x442.google.com with SMTP id p4so3261069wrm.8
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 03:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0lNdGpSfBzDNvoyGaxV/lVsZ3aI25OqDjawAwKzIxio=;
 b=NF/78zmfLm9Ufsn0h9jcMT8fcdYr2bFQKTHEbmslC3Gp6vdWMugt3KRhaAnM8pRMVM
 zJTX+HoyHwqFFindjP2rEbAr85NLvTdFmYl+eWiKb7d599zM5PQThemcWDt/CW66wIr8
 lfI9mHirKWb8rO0OKTDmJhG7MntYGn7jh10Bn2pcwTW7HTuaRxH7Q7rN4glSX7oQPV0S
 Lvw2njQDGFOrWoyPrOS86HurVh7Wnx4T6S8h48wt16nyvPOyrSm+pDTnaObvB97NC9qR
 d3kqduHnBXNfFI1vyjT/77CuUR/fHUrOoOsdO+Bpjfm5QHi8UC6E1T1N6SpZVsl9BkOu
 K9Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=0lNdGpSfBzDNvoyGaxV/lVsZ3aI25OqDjawAwKzIxio=;
 b=KPJfHOUkZm+vBMUQM9JCWXEFDxJ6/bA45ZSR6Beb2J2GEaD4DcK+o32in1qSquVH36
 LDJ9rF+plPyLOPSXNGIsUG/t58BtNkeJrLisqfcU8zjE2BJq/Z8nJ4TMxLINi57XemgL
 rMrEbRHMrcNCy8KQhF+j+UhzyrZpMNMp2Lsn7UzVlgV0GasG4qGV9n6NFwo1VimgnIUw
 +Qaewk+z18uJMjoQUettBoUmP82xwpkP83RJAgI6FAE0wU09F2hG0uZU+tlVutzcPqBK
 NBMbEHefDnvvYrRTb4Jx3bhPR3YPpmItZ9MbllTyNhFY4k1AmHuiTXfY1w8m2t9dPrkv
 McoQ==
X-Gm-Message-State: APjAAAVomxo1Qhfnhzv5JBHoCTs1SLUwkugxTF+d7ASI4BtYYe/g4qws
 ECSbsfdJ7thcYrjH8ATw6sVnjg==
X-Google-Smtp-Source: APXvYqwtV7tEO4uY+3+Q8i+DZ57U0lUbhLKssdmqXRiimXgDpmWrqkF4vMA/qktu+qO8JxE96GzdQQ==
X-Received: by 2002:a5d:4b09:: with SMTP id v9mr24145158wrq.127.1571050192206; 
 Mon, 14 Oct 2019 03:49:52 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id w4sm15863674wrv.66.2019.10.14.03.49.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 03:49:51 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 740E11FF8F;
 Mon, 14 Oct 2019 11:49:49 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v5 02/55] trace: add mmu_index to mem_info
Date: Mon, 14 Oct 2019 11:48:55 +0100
Message-Id: <20191014104948.4291-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191014104948.4291-1-alex.bennee@linaro.org>
References: <20191014104948.4291-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: robert.foley@futurewei.com, Riku Voipio <riku.voipio@iki.fi>,
 peter.puhov@futurewei.com, aaron@os.amperecomputing.com, cota@braap.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We are going to re-use mem_info later for plugins and will need to
track the mmu_idx for softmmu code.

[TODO: convert everything to use TCGMemOpIdx?]

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v5
  - fix up shifts
---
 accel/tcg/atomic_template.h               |  6 ++---
 accel/tcg/cputlb.c                        |  2 ++
 accel/tcg/user-exec.c                     |  1 +
 include/exec/cpu_ldst_template.h          | 15 +++++------
 include/exec/cpu_ldst_useronly_template.h |  6 ++---
 scripts/tracetool/transform.py            |  1 +
 tcg/tcg-op.c                              |  8 +++---
 trace-events                              |  6 +++--
 trace/mem-internal.h                      | 31 ++++++++++++++++-------
 trace/mem.h                               |  7 ++---
 10 files changed, 50 insertions(+), 33 deletions(-)

diff --git a/accel/tcg/atomic_template.h b/accel/tcg/atomic_template.h
index 287433d809..dfeddf6a54 100644
--- a/accel/tcg/atomic_template.h
+++ b/accel/tcg/atomic_template.h
@@ -60,7 +60,7 @@
 #endif
 
 #define ATOMIC_TRACE_RMW do {                                           \
-        uint8_t info = glue(trace_mem_build_info_no_se, MEND)(SHIFT, false); \
+        uint16_t info = glue(trace_mem_build_info_no_se, MEND)(SHIFT, false, ATOMIC_MMU_IDX); \
                                                                         \
         trace_guest_mem_before_exec(env_cpu(env), addr, info);      \
         trace_guest_mem_before_exec(env_cpu(env), addr,             \
@@ -68,13 +68,13 @@
     } while (0)
 
 #define ATOMIC_TRACE_LD do {                                            \
-        uint8_t info = glue(trace_mem_build_info_no_se, MEND)(SHIFT, false); \
+        uint16_t info = glue(trace_mem_build_info_no_se, MEND)(SHIFT, false, ATOMIC_MMU_IDX); \
                                                                         \
         trace_guest_mem_before_exec(env_cpu(env), addr, info);      \
     } while (0)
 
 # define ATOMIC_TRACE_ST do {                                           \
-        uint8_t info = glue(trace_mem_build_info_no_se, MEND)(SHIFT, true); \
+        uint16_t info = glue(trace_mem_build_info_no_se, MEND)(SHIFT, true, ATOMIC_MMU_IDX); \
                                                                         \
         trace_guest_mem_before_exec(env_cpu(env), addr, info);      \
     } while (0)
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index defc8d5929..1210d8f243 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1811,6 +1811,7 @@ void helper_be_stq_mmu(CPUArchState *env, target_ulong addr, uint64_t val,
 #define ATOMIC_MMU_DECLS
 #define ATOMIC_MMU_LOOKUP atomic_mmu_lookup(env, addr, oi, retaddr)
 #define ATOMIC_MMU_CLEANUP
+#define ATOMIC_MMU_IDX oi
 
 #define DATA_SIZE 1
 #include "atomic_template.h"
@@ -1853,6 +1854,7 @@ void helper_be_stq_mmu(CPUArchState *env, target_ulong addr, uint64_t val,
 #define DATA_SIZE 8
 #include "atomic_template.h"
 #endif
+#undef ATOMIC_MMU_IDX
 
 /* Code access functions.  */
 
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 71c4bf6477..e9a58c5331 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -751,6 +751,7 @@ static void *atomic_mmu_lookup(CPUArchState *env, target_ulong addr,
 #define ATOMIC_MMU_DECLS do {} while (0)
 #define ATOMIC_MMU_LOOKUP  atomic_mmu_lookup(env, addr, DATA_SIZE, GETPC())
 #define ATOMIC_MMU_CLEANUP do { clear_helper_retaddr(); } while (0)
+#define ATOMIC_MMU_IDX 0
 
 #define ATOMIC_NAME(X)   HELPER(glue(glue(atomic_ ## X, SUFFIX), END))
 #define EXTRA_ARGS
diff --git a/include/exec/cpu_ldst_template.h b/include/exec/cpu_ldst_template.h
index af7e0b49f2..5750a26b9e 100644
--- a/include/exec/cpu_ldst_template.h
+++ b/include/exec/cpu_ldst_template.h
@@ -84,17 +84,16 @@ glue(glue(glue(cpu_ld, USUFFIX), MEMSUFFIX), _ra)(CPUArchState *env,
     CPUTLBEntry *entry;
     RES_TYPE res;
     target_ulong addr;
-    int mmu_idx;
+    int mmu_idx = CPU_MMU_INDEX;
     TCGMemOpIdx oi;
 
 #if !defined(SOFTMMU_CODE_ACCESS)
     trace_guest_mem_before_exec(
         env_cpu(env), ptr,
-        trace_mem_build_info(SHIFT, false, MO_TE, false));
+        trace_mem_build_info(SHIFT, false, MO_TE, false, mmu_idx));
 #endif
 
     addr = ptr;
-    mmu_idx = CPU_MMU_INDEX;
     entry = tlb_entry(env, mmu_idx, addr);
     if (unlikely(entry->ADDR_READ !=
                  (addr & (TARGET_PAGE_MASK | (DATA_SIZE - 1))))) {
@@ -123,17 +122,16 @@ glue(glue(glue(cpu_lds, SUFFIX), MEMSUFFIX), _ra)(CPUArchState *env,
     CPUTLBEntry *entry;
     int res;
     target_ulong addr;
-    int mmu_idx;
+    int mmu_idx = CPU_MMU_INDEX;
     TCGMemOpIdx oi;
 
 #if !defined(SOFTMMU_CODE_ACCESS)
     trace_guest_mem_before_exec(
         env_cpu(env), ptr,
-        trace_mem_build_info(SHIFT, true, MO_TE, false));
+        trace_mem_build_info(SHIFT, true, MO_TE, false, mmu_idx));
 #endif
 
     addr = ptr;
-    mmu_idx = CPU_MMU_INDEX;
     entry = tlb_entry(env, mmu_idx, addr);
     if (unlikely(entry->ADDR_READ !=
                  (addr & (TARGET_PAGE_MASK | (DATA_SIZE - 1))))) {
@@ -165,17 +163,16 @@ glue(glue(glue(cpu_st, SUFFIX), MEMSUFFIX), _ra)(CPUArchState *env,
 {
     CPUTLBEntry *entry;
     target_ulong addr;
-    int mmu_idx;
+    int mmu_idx = CPU_MMU_INDEX;
     TCGMemOpIdx oi;
 
 #if !defined(SOFTMMU_CODE_ACCESS)
     trace_guest_mem_before_exec(
         env_cpu(env), ptr,
-        trace_mem_build_info(SHIFT, false, MO_TE, true));
+        trace_mem_build_info(SHIFT, false, MO_TE, true, mmu_idx));
 #endif
 
     addr = ptr;
-    mmu_idx = CPU_MMU_INDEX;
     entry = tlb_entry(env, mmu_idx, addr);
     if (unlikely(tlb_addr_write(entry) !=
                  (addr & (TARGET_PAGE_MASK | (DATA_SIZE - 1))))) {
diff --git a/include/exec/cpu_ldst_useronly_template.h b/include/exec/cpu_ldst_useronly_template.h
index 2378f2958c..8f7f117ad4 100644
--- a/include/exec/cpu_ldst_useronly_template.h
+++ b/include/exec/cpu_ldst_useronly_template.h
@@ -73,7 +73,7 @@ glue(glue(cpu_ld, USUFFIX), MEMSUFFIX)(CPUArchState *env, abi_ptr ptr)
 #else
     trace_guest_mem_before_exec(
         env_cpu(env), ptr,
-        trace_mem_build_info(SHIFT, false, MO_TE, false));
+        trace_mem_build_info(SHIFT, false, MO_TE, false, 0));
     return glue(glue(ld, USUFFIX), _p)(g2h(ptr));
 #endif
 }
@@ -105,7 +105,7 @@ glue(glue(cpu_lds, SUFFIX), MEMSUFFIX)(CPUArchState *env, abi_ptr ptr)
 #else
     trace_guest_mem_before_exec(
         env_cpu(env), ptr,
-        trace_mem_build_info(SHIFT, true, MO_TE, false));
+        trace_mem_build_info(SHIFT, true, MO_TE, false, 0));
     return glue(glue(lds, SUFFIX), _p)(g2h(ptr));
 #endif
 }
@@ -132,7 +132,7 @@ glue(glue(cpu_st, SUFFIX), MEMSUFFIX)(CPUArchState *env, abi_ptr ptr,
 {
     trace_guest_mem_before_exec(
         env_cpu(env), ptr,
-        trace_mem_build_info(SHIFT, false, MO_TE, true));
+        trace_mem_build_info(SHIFT, false, MO_TE, true, 0));
     glue(glue(st, SUFFIX), _p)(g2h(ptr), v);
 }
 
diff --git a/scripts/tracetool/transform.py b/scripts/tracetool/transform.py
index e18b05315e..2ca9286046 100644
--- a/scripts/tracetool/transform.py
+++ b/scripts/tracetool/transform.py
@@ -83,6 +83,7 @@ TCG_2_HOST = {
 
 HOST_2_TCG_COMPAT = {
     "uint8_t": "uint32_t",
+    "uint16_t": "uint32_t",
     }
 
 
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index e87c327fbf..1388bd344d 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -2795,7 +2795,7 @@ void tcg_gen_qemu_ld_i32(TCGv_i32 val, TCGv addr, TCGArg idx, MemOp memop)
     tcg_gen_req_mo(TCG_MO_LD_LD | TCG_MO_ST_LD);
     memop = tcg_canonicalize_memop(memop, 0, 0);
     trace_guest_mem_before_tcg(tcg_ctx->cpu, cpu_env,
-                               addr, trace_mem_get_info(memop, 0));
+                               addr, trace_mem_get_info(memop, idx, 0));
 
     orig_memop = memop;
     if (!TCG_TARGET_HAS_MEMORY_BSWAP && (memop & MO_BSWAP)) {
@@ -2832,7 +2832,7 @@ void tcg_gen_qemu_st_i32(TCGv_i32 val, TCGv addr, TCGArg idx, MemOp memop)
     tcg_gen_req_mo(TCG_MO_LD_ST | TCG_MO_ST_ST);
     memop = tcg_canonicalize_memop(memop, 0, 1);
     trace_guest_mem_before_tcg(tcg_ctx->cpu, cpu_env,
-                               addr, trace_mem_get_info(memop, 1));
+                               addr, trace_mem_get_info(memop, idx, 1));
 
     if (!TCG_TARGET_HAS_MEMORY_BSWAP && (memop & MO_BSWAP)) {
         swap = tcg_temp_new_i32();
@@ -2875,7 +2875,7 @@ void tcg_gen_qemu_ld_i64(TCGv_i64 val, TCGv addr, TCGArg idx, MemOp memop)
     tcg_gen_req_mo(TCG_MO_LD_LD | TCG_MO_ST_LD);
     memop = tcg_canonicalize_memop(memop, 1, 0);
     trace_guest_mem_before_tcg(tcg_ctx->cpu, cpu_env,
-                               addr, trace_mem_get_info(memop, 0));
+                               addr, trace_mem_get_info(memop, idx, 0));
 
     orig_memop = memop;
     if (!TCG_TARGET_HAS_MEMORY_BSWAP && (memop & MO_BSWAP)) {
@@ -2923,7 +2923,7 @@ void tcg_gen_qemu_st_i64(TCGv_i64 val, TCGv addr, TCGArg idx, MemOp memop)
     tcg_gen_req_mo(TCG_MO_LD_ST | TCG_MO_ST_ST);
     memop = tcg_canonicalize_memop(memop, 1, 1);
     trace_guest_mem_before_tcg(tcg_ctx->cpu, cpu_env,
-                               addr, trace_mem_get_info(memop, 1));
+                               addr, trace_mem_get_info(memop, idx, 1));
 
     if (!TCG_TARGET_HAS_MEMORY_BSWAP && (memop & MO_BSWAP)) {
         swap = tcg_temp_new_i64();
diff --git a/trace-events b/trace-events
index 22133dfd3f..42107ebc69 100644
--- a/trace-events
+++ b/trace-events
@@ -152,12 +152,14 @@ vcpu guest_cpu_reset(void)
 #     uint8_t size_shift : 4; /* interpreted as "1 << size_shift" bytes */
 #     bool    sign_extend: 1; /* sign-extended */
 #     uint8_t endianness : 1; /* 0: little, 1: big */
-#     bool    store      : 1; /* wheter it's a store operation */
+#     bool    store      : 1; /* whether it is a store operation */
+#             pad        : 1;
+#     uint8_t mmuidx     : 4; /* mmuidx (softmmu only)  */
 # };
 #
 # Mode: user, softmmu
 # Targets: TCG(all)
-vcpu tcg guest_mem_before(TCGv vaddr, uint8_t info) "info=%d", "vaddr=0x%016"PRIx64" info=%d"
+vcpu tcg guest_mem_before(TCGv vaddr, uint16_t info) "info=%d", "vaddr=0x%016"PRIx64" info=%d"
 
 # linux-user/syscall.c
 # bsd-user/syscall.c
diff --git a/trace/mem-internal.h b/trace/mem-internal.h
index 1a010c1b27..0a32aa22ca 100644
--- a/trace/mem-internal.h
+++ b/trace/mem-internal.h
@@ -14,11 +14,13 @@
 #define TRACE_MEM_SE (1ULL << 4)    /* sign extended (y/n) */
 #define TRACE_MEM_BE (1ULL << 5)    /* big endian (y/n) */
 #define TRACE_MEM_ST (1ULL << 6)    /* store (y/n) */
+#define TRACE_MEM_MMU_SHIFT 8       /* mmu idx */
 
-static inline uint8_t trace_mem_build_info(
-    int size_shift, bool sign_extend, MemOp endianness, bool store)
+static inline uint16_t trace_mem_build_info(
+    int size_shift, bool sign_extend, MemOp endianness,
+    bool store, unsigned int mmu_idx)
 {
-    uint8_t res;
+    uint16_t res;
 
     res = size_shift & TRACE_MEM_SZ_SHIFT_MASK;
     if (sign_extend) {
@@ -30,25 +32,36 @@ static inline uint8_t trace_mem_build_info(
     if (store) {
         res |= TRACE_MEM_ST;
     }
+#ifdef CONFIG_SOFTMMU
+    res |= mmu_idx << TRACE_MEM_MMU_SHIFT;
+#endif
     return res;
 }
 
-static inline uint8_t trace_mem_get_info(MemOp op, bool store)
+static inline uint16_t trace_mem_get_info(MemOp op,
+                                          unsigned int mmu_idx,
+                                          bool store)
 {
     return trace_mem_build_info(op & MO_SIZE, !!(op & MO_SIGN),
-                                op & MO_BSWAP, store);
+                                op & MO_BSWAP, store,
+                                mmu_idx);
 }
 
+/* Used by the atomic helpers */
 static inline
-uint8_t trace_mem_build_info_no_se_be(int size_shift, bool store)
+uint16_t trace_mem_build_info_no_se_be(int size_shift, bool store,
+                                       TCGMemOpIdx oi)
 {
-    return trace_mem_build_info(size_shift, false, MO_BE, store);
+    return trace_mem_build_info(size_shift, false, MO_BE, store,
+                                get_mmuidx(oi));
 }
 
 static inline
-uint8_t trace_mem_build_info_no_se_le(int size_shift, bool store)
+uint16_t trace_mem_build_info_no_se_le(int size_shift, bool store,
+                                       TCGMemOpIdx oi)
 {
-    return trace_mem_build_info(size_shift, false, MO_LE, store);
+    return trace_mem_build_info(size_shift, false, MO_LE, store,
+                                get_mmuidx(oi));
 }
 
 #endif /* TRACE__MEM_INTERNAL_H */
diff --git a/trace/mem.h b/trace/mem.h
index 8cf213d85b..9644f592b4 100644
--- a/trace/mem.h
+++ b/trace/mem.h
@@ -18,15 +18,16 @@
  *
  * Return a value for the 'info' argument in guest memory access traces.
  */
-static uint8_t trace_mem_get_info(MemOp op, bool store);
+static uint16_t trace_mem_get_info(MemOp op, unsigned int mmu_idx, bool store);
 
 /**
  * trace_mem_build_info:
  *
  * Return a value for the 'info' argument in guest memory access traces.
  */
-static uint8_t trace_mem_build_info(int size_shift, bool sign_extend,
-                                    MemOp endianness, bool store);
+static uint16_t trace_mem_build_info(int size_shift, bool sign_extend,
+                                     MemOp endianness, bool store,
+                                     unsigned int mmuidx);
 
 
 #include "trace/mem-internal.h"
-- 
2.20.1



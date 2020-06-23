Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BE4DC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 19:52:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 049AE2080C
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 19:52:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x6GhM0YF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 049AE2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnoxn-0006Ob-69
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 15:52:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42128)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jnojW-0003q9-Qw
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 15:37:26 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:38307)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jnojT-0005fH-2M
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 15:37:26 -0400
Received: by mail-pf1-x443.google.com with SMTP id x207so10563454pfc.5
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 12:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=w4bwHB3W6upacTVCzRDkd6lSmHHaPuD3ZfcUdV+Sc04=;
 b=x6GhM0YF5GhRBkrv/DQ6GH6sBJtJS1KbHAjrbDgDeRnuJGeOtD+7erxFSLw77orxVe
 +apWxsG7cgF1xaBI3RQVxnHb7hKfopGxoQ7LCkAC/ny2rgy37e/vvwW233E6dKeomrDm
 IviUNS7fH814xpEm4PRYypBPSUFTKl+tE9zwWqDrlWfS/c6UXxv+82I45GfQDH+VYrPo
 VWorC1+lNOI4byjvLaKfhTI3kYO3FviVlZX+AzuaZRsFd+0zG3GSa6uriot0aVxzdrOw
 rF3TXi8o615m6R/YnvlbN2+1sbO/brd/OILLq7osWgEJgiKBVyrS3At0SaLgIJEztf8N
 g4Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=w4bwHB3W6upacTVCzRDkd6lSmHHaPuD3ZfcUdV+Sc04=;
 b=Q9tzKfh9oRL0lKGMLTRn9MhrMr9GI2YrezcddRwVVRzD64qif5NFi5pkyTA9J0xkd7
 h1OM47o3/9gGMPtDL82PhSMj3kG0/7irt8CULRTfQomakkDcHT639/pXmZVCVkEtjcup
 kbctI8xkrreIwtLYPzbeZPJjuEJSFvnB9zf7rEzTzFZJ4PqsWAy90bRAzx597azCdXPZ
 lQP8ixT5Kua1//q2nfnxmAH013y/ympEX8sOTXM2g1apeNzHYr8RgxET2XgmIrGljowf
 RqcofZLchKTmHeL+0YQi3rmwLaCr3m6gYjDC5QzXXMQIuNjmXzcuywsUkzGfdDwuN+wN
 uFsA==
X-Gm-Message-State: AOAM533/fsB+ZeaRUnQpVklcKTvWVCjI4nkEPsaZjHbFIkmAeRGiDWHp
 O7PezaQYBARcIKNer4x6LLbAb/Oe84w=
X-Google-Smtp-Source: ABdhPJybMahczvcPO9WZujb5Pb0WccSqalyXCDwGIKPCUnDQbbs6My1jJiIO4pfGC15aN9uDAGGOtQ==
X-Received: by 2002:a62:1c8a:: with SMTP id c132mr27190001pfc.69.1592941040927; 
 Tue, 23 Jun 2020 12:37:20 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id p12sm17927642pfq.69.2020.06.23.12.37.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2020 12:37:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 15/45] target/arm: Implement LDG, STG, ST2G instructions
Date: Tue, 23 Jun 2020 12:36:28 -0700
Message-Id: <20200623193658.623279-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200623193658.623279-1-richard.henderson@linaro.org>
References: <20200623193658.623279-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, david.spickett@linaro.org,
 steplong@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v2: Split out allocation_tag_mem.  Handle atomicity of stores.
v3: Add X[t] input to these insns; require pre-cleaned addresses.
v5: Fix !32-byte aligned operation of st2g.
v6: Fix op2 extract, stg pre/post-index, stores vs sp, commentary;
    use pre-computed ata.
v7: Fix STZG iteration (stephen long)
v8: Merge gen_probe_access patch; align address for ldg (pmm)
---
 target/arm/helper-a64.h    |   7 ++
 target/arm/helper.h        |   2 +
 target/arm/mte_helper.c    | 194 +++++++++++++++++++++++++++++++++++++
 target/arm/op_helper.c     |  16 +++
 target/arm/translate-a64.c | 172 +++++++++++++++++++++++++++++++-
 5 files changed, 386 insertions(+), 5 deletions(-)

diff --git a/target/arm/helper-a64.h b/target/arm/helper-a64.h
index 6c116481e8..2fa61b86fa 100644
--- a/target/arm/helper-a64.h
+++ b/target/arm/helper-a64.h
@@ -106,3 +106,10 @@ DEF_HELPER_FLAGS_2(xpacd, TCG_CALL_NO_RWG_SE, i64, env, i64)
 
 DEF_HELPER_FLAGS_3(irg, TCG_CALL_NO_RWG, i64, env, i64, i64)
 DEF_HELPER_FLAGS_4(addsubg, TCG_CALL_NO_RWG_SE, i64, env, i64, s32, i32)
+DEF_HELPER_FLAGS_3(ldg, TCG_CALL_NO_WG, i64, env, i64, i64)
+DEF_HELPER_FLAGS_3(stg, TCG_CALL_NO_WG, void, env, i64, i64)
+DEF_HELPER_FLAGS_3(stg_parallel, TCG_CALL_NO_WG, void, env, i64, i64)
+DEF_HELPER_FLAGS_2(stg_stub, TCG_CALL_NO_WG, void, env, i64)
+DEF_HELPER_FLAGS_3(st2g, TCG_CALL_NO_WG, void, env, i64, i64)
+DEF_HELPER_FLAGS_3(st2g_parallel, TCG_CALL_NO_WG, void, env, i64, i64)
+DEF_HELPER_FLAGS_2(st2g_stub, TCG_CALL_NO_WG, void, env, i64)
diff --git a/target/arm/helper.h b/target/arm/helper.h
index 2a20c8174c..759639a63a 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -96,6 +96,8 @@ DEF_HELPER_FLAGS_1(rebuild_hflags_a32_newel, TCG_CALL_NO_RWG, void, env)
 DEF_HELPER_FLAGS_2(rebuild_hflags_a32, TCG_CALL_NO_RWG, void, env, int)
 DEF_HELPER_FLAGS_2(rebuild_hflags_a64, TCG_CALL_NO_RWG, void, env, int)
 
+DEF_HELPER_FLAGS_5(probe_access, TCG_CALL_NO_WG, void, env, tl, i32, i32, i32)
+
 DEF_HELPER_1(vfp_get_fpscr, i32, env)
 DEF_HELPER_2(vfp_set_fpscr, void, env, i32)
 
diff --git a/target/arm/mte_helper.c b/target/arm/mte_helper.c
index 9ab9ed749d..7ec7930dfc 100644
--- a/target/arm/mte_helper.c
+++ b/target/arm/mte_helper.c
@@ -44,6 +44,40 @@ static int choose_nonexcluded_tag(int tag, int offset, uint16_t exclude)
     return tag;
 }
 
+/**
+ * allocation_tag_mem:
+ * @env: the cpu environment
+ * @ptr_mmu_idx: the addressing regime to use for the virtual address
+ * @ptr: the virtual address for which to look up tag memory
+ * @ptr_access: the access to use for the virtual address
+ * @ptr_size: the number of bytes in the normal memory access
+ * @tag_access: the access to use for the tag memory
+ * @tag_size: the number of bytes in the tag memory access
+ * @ra: the return address for exception handling
+ *
+ * Our tag memory is formatted as a sequence of little-endian nibbles.
+ * That is, the byte at (addr >> (LOG2_TAG_GRANULE + 1)) contains two
+ * tags, with the tag at [3:0] for the lower addr and the tag at [7:4]
+ * for the higher addr.
+ *
+ * Here, resolve the physical address from the virtual address, and return
+ * a pointer to the corresponding tag byte.  Exit with exception if the
+ * virtual address is not accessible for @ptr_access.
+ *
+ * The @ptr_size and @tag_size values may not have an obvious relation
+ * due to the alignment of @ptr, and the number of tag checks required.
+ *
+ * If there is no tag storage corresponding to @ptr, return NULL.
+ */
+static uint8_t *allocation_tag_mem(CPUARMState *env, int ptr_mmu_idx,
+                                   uint64_t ptr, MMUAccessType ptr_access,
+                                   int ptr_size, MMUAccessType tag_access,
+                                   int tag_size, uintptr_t ra)
+{
+    /* Tag storage not implemented.  */
+    return NULL;
+}
+
 uint64_t HELPER(irg)(CPUARMState *env, uint64_t rn, uint64_t rm)
 {
     int rtag;
@@ -80,3 +114,163 @@ uint64_t HELPER(addsubg)(CPUARMState *env, uint64_t ptr,
 
     return address_with_allocation_tag(ptr + offset, rtag);
 }
+
+static int load_tag1(uint64_t ptr, uint8_t *mem)
+{
+    int ofs = extract32(ptr, LOG2_TAG_GRANULE, 1) * 4;
+    return extract32(*mem, ofs, 4);
+}
+
+uint64_t HELPER(ldg)(CPUARMState *env, uint64_t ptr, uint64_t xt)
+{
+    int mmu_idx = cpu_mmu_index(env, false);
+    uint8_t *mem;
+    int rtag = 0;
+
+    /* Trap if accessing an invalid page.  */
+    mem = allocation_tag_mem(env, mmu_idx, ptr, MMU_DATA_LOAD, 1,
+                             MMU_DATA_LOAD, 1, GETPC());
+
+    /* Load if page supports tags. */
+    if (mem) {
+        rtag = load_tag1(ptr, mem);
+    }
+
+    return address_with_allocation_tag(xt, rtag);
+}
+
+static void check_tag_aligned(CPUARMState *env, uint64_t ptr, uintptr_t ra)
+{
+    if (unlikely(!QEMU_IS_ALIGNED(ptr, TAG_GRANULE))) {
+        arm_cpu_do_unaligned_access(env_cpu(env), ptr, MMU_DATA_STORE,
+                                    cpu_mmu_index(env, false), ra);
+        g_assert_not_reached();
+    }
+}
+
+/* For use in a non-parallel context, store to the given nibble.  */
+static void store_tag1(uint64_t ptr, uint8_t *mem, int tag)
+{
+    int ofs = extract32(ptr, LOG2_TAG_GRANULE, 1) * 4;
+    *mem = deposit32(*mem, ofs, 4, tag);
+}
+
+/* For use in a parallel context, atomically store to the given nibble.  */
+static void store_tag1_parallel(uint64_t ptr, uint8_t *mem, int tag)
+{
+    int ofs = extract32(ptr, LOG2_TAG_GRANULE, 1) * 4;
+    uint8_t old = atomic_read(mem);
+
+    while (1) {
+        uint8_t new = deposit32(old, ofs, 4, tag);
+        uint8_t cmp = atomic_cmpxchg(mem, old, new);
+        if (likely(cmp == old)) {
+            return;
+        }
+        old = cmp;
+    }
+}
+
+typedef void stg_store1(uint64_t, uint8_t *, int);
+
+static inline void do_stg(CPUARMState *env, uint64_t ptr, uint64_t xt,
+                          uintptr_t ra, stg_store1 store1)
+{
+    int mmu_idx = cpu_mmu_index(env, false);
+    uint8_t *mem;
+
+    check_tag_aligned(env, ptr, ra);
+
+    /* Trap if accessing an invalid page.  */
+    mem = allocation_tag_mem(env, mmu_idx, ptr, MMU_DATA_STORE, TAG_GRANULE,
+                             MMU_DATA_STORE, 1, ra);
+
+    /* Store if page supports tags. */
+    if (mem) {
+        store1(ptr, mem, allocation_tag_from_addr(xt));
+    }
+}
+
+void HELPER(stg)(CPUARMState *env, uint64_t ptr, uint64_t xt)
+{
+    do_stg(env, ptr, xt, GETPC(), store_tag1);
+}
+
+void HELPER(stg_parallel)(CPUARMState *env, uint64_t ptr, uint64_t xt)
+{
+    do_stg(env, ptr, xt, GETPC(), store_tag1_parallel);
+}
+
+void HELPER(stg_stub)(CPUARMState *env, uint64_t ptr)
+{
+    int mmu_idx = cpu_mmu_index(env, false);
+    uintptr_t ra = GETPC();
+
+    check_tag_aligned(env, ptr, ra);
+    probe_write(env, ptr, TAG_GRANULE, mmu_idx, ra);
+}
+
+static inline void do_st2g(CPUARMState *env, uint64_t ptr, uint64_t xt,
+                           uintptr_t ra, stg_store1 store1)
+{
+    int mmu_idx = cpu_mmu_index(env, false);
+    int tag = allocation_tag_from_addr(xt);
+    uint8_t *mem1, *mem2;
+
+    check_tag_aligned(env, ptr, ra);
+
+    /*
+     * Trap if accessing an invalid page(s).
+     * This takes priority over !allocation_tag_access_enabled.
+     */
+    if (ptr & TAG_GRANULE) {
+        /* Two stores unaligned mod TAG_GRANULE*2 -- modify two bytes. */
+        mem1 = allocation_tag_mem(env, mmu_idx, ptr, MMU_DATA_STORE,
+                                  TAG_GRANULE, MMU_DATA_STORE, 1, ra);
+        mem2 = allocation_tag_mem(env, mmu_idx, ptr + TAG_GRANULE,
+                                  MMU_DATA_STORE, TAG_GRANULE,
+                                  MMU_DATA_STORE, 1, ra);
+
+        /* Store if page(s) support tags. */
+        if (mem1) {
+            store1(TAG_GRANULE, mem1, tag);
+        }
+        if (mem2) {
+            store1(0, mem2, tag);
+        }
+    } else {
+        /* Two stores aligned mod TAG_GRANULE*2 -- modify one byte. */
+        mem1 = allocation_tag_mem(env, mmu_idx, ptr, MMU_DATA_STORE,
+                                  2 * TAG_GRANULE, MMU_DATA_STORE, 1, ra);
+        if (mem1) {
+            tag |= tag << 4;
+            atomic_set(mem1, tag);
+        }
+    }
+}
+
+void HELPER(st2g)(CPUARMState *env, uint64_t ptr, uint64_t xt)
+{
+    do_st2g(env, ptr, xt, GETPC(), store_tag1);
+}
+
+void HELPER(st2g_parallel)(CPUARMState *env, uint64_t ptr, uint64_t xt)
+{
+    do_st2g(env, ptr, xt, GETPC(), store_tag1_parallel);
+}
+
+void HELPER(st2g_stub)(CPUARMState *env, uint64_t ptr)
+{
+    int mmu_idx = cpu_mmu_index(env, false);
+    uintptr_t ra = GETPC();
+    int in_page = -(ptr | TARGET_PAGE_MASK);
+
+    check_tag_aligned(env, ptr, ra);
+
+    if (likely(in_page >= 2 * TAG_GRANULE)) {
+        probe_write(env, ptr, 2 * TAG_GRANULE, mmu_idx, ra);
+    } else {
+        probe_write(env, ptr, TAG_GRANULE, mmu_idx, ra);
+        probe_write(env, ptr + TAG_GRANULE, TAG_GRANULE, mmu_idx, ra);
+    }
+}
diff --git a/target/arm/op_helper.c b/target/arm/op_helper.c
index eb0de080f1..b1065216b2 100644
--- a/target/arm/op_helper.c
+++ b/target/arm/op_helper.c
@@ -935,3 +935,19 @@ uint32_t HELPER(ror_cc)(CPUARMState *env, uint32_t x, uint32_t i)
         return ((uint32_t)x >> shift) | (x << (32 - shift));
     }
 }
+
+void HELPER(probe_access)(CPUARMState *env, target_ulong ptr,
+                          uint32_t access_type, uint32_t mmu_idx,
+                          uint32_t size)
+{
+    uint32_t in_page = -((uint32_t)ptr | TARGET_PAGE_SIZE);
+    uintptr_t ra = GETPC();
+
+    if (likely(size <= in_page)) {
+        probe_access(env, ptr, size, access_type, mmu_idx, ra);
+    } else {
+        probe_access(env, ptr, in_page, access_type, mmu_idx, ra);
+        probe_access(env, ptr + in_page, size - in_page,
+                     access_type, mmu_idx, ra);
+    }
+}
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 5400516eef..c6152b3cc0 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -232,6 +232,19 @@ static void gen_address_with_allocation_tag0(TCGv_i64 dst, TCGv_i64 src)
     tcg_gen_andi_i64(dst, src, ~MAKE_64BIT_MASK(56, 4));
 }
 
+static void gen_probe_access(DisasContext *s, TCGv_i64 ptr,
+                             MMUAccessType acc, int log2_size)
+{
+    TCGv_i32 t_acc = tcg_const_i32(acc);
+    TCGv_i32 t_idx = tcg_const_i32(get_mem_index(s));
+    TCGv_i32 t_size = tcg_const_i32(1 << log2_size);
+
+    gen_helper_probe_access(cpu_env, ptr, t_acc, t_idx, t_size);
+    tcg_temp_free_i32(t_acc);
+    tcg_temp_free_i32(t_idx);
+    tcg_temp_free_i32(t_size);
+}
+
 typedef struct DisasCompare64 {
     TCGCond cond;
     TCGv_i64 value;
@@ -3685,6 +3698,154 @@ static void disas_ldst_single_struct(DisasContext *s, uint32_t insn)
     }
 }
 
+/*
+ * Load/Store memory tags
+ *
+ *  31 30 29         24     22  21     12    10      5      0
+ * +-----+-------------+-----+---+------+-----+------+------+
+ * | 1 1 | 0 1 1 0 0 1 | op1 | 1 | imm9 | op2 |  Rn  |  Rt  |
+ * +-----+-------------+-----+---+------+-----+------+------+
+ */
+static void disas_ldst_tag(DisasContext *s, uint32_t insn)
+{
+    int rt = extract32(insn, 0, 5);
+    int rn = extract32(insn, 5, 5);
+    uint64_t offset = sextract64(insn, 12, 9) << LOG2_TAG_GRANULE;
+    int op2 = extract32(insn, 10, 2);
+    int op1 = extract32(insn, 22, 2);
+    bool is_load = false, is_pair = false, is_zero = false;
+    int index = 0;
+    TCGv_i64 addr, clean_addr, tcg_rt;
+
+    /* We checked insn bits [29:24,21] in the caller.  */
+    if (extract32(insn, 30, 2) != 3) {
+        goto do_unallocated;
+    }
+
+    /*
+     * @index is a tri-state variable which has 3 states:
+     * < 0 : post-index, writeback
+     * = 0 : signed offset
+     * > 0 : pre-index, writeback
+     */
+    switch (op1) {
+    case 0:
+        if (op2 != 0) {
+            /* STG */
+            index = op2 - 2;
+            break;
+        }
+        goto do_unallocated;
+    case 1:
+        if (op2 != 0) {
+            /* STZG */
+            is_zero = true;
+            index = op2 - 2;
+        } else {
+            /* LDG */
+            is_load = true;
+        }
+        break;
+    case 2:
+        if (op2 != 0) {
+            /* ST2G */
+            is_pair = true;
+            index = op2 - 2;
+            break;
+        }
+        goto do_unallocated;
+    case 3:
+        if (op2 != 0) {
+            /* STZ2G */
+            is_pair = is_zero = true;
+            index = op2 - 2;
+            break;
+        }
+        goto do_unallocated;
+
+    default:
+    do_unallocated:
+        unallocated_encoding(s);
+        return;
+    }
+
+    if (!dc_isar_feature(aa64_mte_insn_reg, s)) {
+        goto do_unallocated;
+    }
+
+    if (rn == 31) {
+        gen_check_sp_alignment(s);
+    }
+
+    addr = read_cpu_reg_sp(s, rn, true);
+    if (index >= 0) {
+        /* pre-index or signed offset */
+        tcg_gen_addi_i64(addr, addr, offset);
+    }
+
+    if (is_load) {
+        tcg_gen_andi_i64(addr, addr, -TAG_GRANULE);
+        tcg_rt = cpu_reg(s, rt);
+        if (s->ata) {
+            gen_helper_ldg(tcg_rt, cpu_env, addr, tcg_rt);
+        } else {
+            clean_addr = clean_data_tbi(s, addr);
+            gen_probe_access(s, clean_addr, MMU_DATA_LOAD, MO_8);
+            gen_address_with_allocation_tag0(tcg_rt, addr);
+        }
+    } else {
+        tcg_rt = cpu_reg_sp(s, rt);
+        if (!s->ata) {
+            /*
+             * For STG and ST2G, we need to check alignment and probe memory.
+             * TODO: For STZG and STZ2G, we could rely on the stores below,
+             * at least for system mode; user-only won't enforce alignment.
+             */
+            if (is_pair) {
+                gen_helper_st2g_stub(cpu_env, addr);
+            } else {
+                gen_helper_stg_stub(cpu_env, addr);
+            }
+        } else if (tb_cflags(s->base.tb) & CF_PARALLEL) {
+            if (is_pair) {
+                gen_helper_st2g_parallel(cpu_env, addr, tcg_rt);
+            } else {
+                gen_helper_stg_parallel(cpu_env, addr, tcg_rt);
+            }
+        } else {
+            if (is_pair) {
+                gen_helper_st2g(cpu_env, addr, tcg_rt);
+            } else {
+                gen_helper_stg(cpu_env, addr, tcg_rt);
+            }
+        }
+    }
+
+    if (is_zero) {
+        TCGv_i64 clean_addr = clean_data_tbi(s, addr);
+        TCGv_i64 tcg_zero = tcg_const_i64(0);
+        int mem_index = get_mem_index(s);
+        int i, n = (1 + is_pair) << LOG2_TAG_GRANULE;
+
+        tcg_gen_qemu_st_i64(tcg_zero, clean_addr, mem_index,
+                            MO_Q | MO_ALIGN_16);
+        for (i = 8; i < n; i += 8) {
+            tcg_gen_addi_i64(clean_addr, clean_addr, 8);
+            tcg_gen_qemu_st_i64(tcg_zero, clean_addr, mem_index, MO_Q);
+        }
+        tcg_temp_free_i64(tcg_zero);
+    }
+
+    if (index != 0) {
+        /* pre-index or post-index */
+        if (index < 0) {
+            /* post-index */
+            tcg_gen_addi_i64(addr, addr, offset);
+        }
+        tcg_gen_mov_i64(cpu_reg_sp(s, rn), addr);
+    }
+}
+
 /* Loads and stores */
 static void disas_ldst(DisasContext *s, uint32_t insn)
 {
@@ -3709,13 +3870,14 @@ static void disas_ldst(DisasContext *s, uint32_t insn)
     case 0x0d: /* AdvSIMD load/store single structure */
         disas_ldst_single_struct(s, insn);
         break;
-    case 0x19: /* LDAPR/STLR (unscaled immediate) */
-        if (extract32(insn, 10, 2) != 0 ||
-            extract32(insn, 21, 1) != 0) {
+    case 0x19:
+        if (extract32(insn, 21, 1) != 0) {
+            disas_ldst_tag(s, insn);
+        } else if (extract32(insn, 10, 2) == 0) {
+            disas_ldst_ldapr_stlr(s, insn);
+        } else {
             unallocated_encoding(s);
-            break;
         }
-        disas_ldst_ldapr_stlr(s, insn);
         break;
     default:
         unallocated_encoding(s);
-- 
2.25.1



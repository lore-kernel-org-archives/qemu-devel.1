Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC1AAC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 01:24:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A534A2072F
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 01:24:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i4zYhcGz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A534A2072F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgI9F-0000SD-TC
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 21:24:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48898)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jgHyg-0004WE-95
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 21:13:58 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:46897)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jgHyf-0003eD-3v
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 21:13:57 -0400
Received: by mail-pf1-x443.google.com with SMTP id b16so396227pfi.13
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2020 18:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=p2/SXxqi/mpzPKEmHvCWYtwtCXux2aJOwAbCs1scM98=;
 b=i4zYhcGzr8zq6qOUKRVqD5zmliiA3slbkyILaQ+Lj4p75hh6PFbWc/h0hRPICTdBby
 4KoKCIHU5omb7UW3jhU0lej9yNTD1GUyVWj0DauSp8B5KRnR35TyY5AFVvRk2sHLSneR
 3gNv6nv5YSvz6v6shT98Dv6r6SN5EI+a9sQgdrNFKnimOzr43qmroLXPrInBpwLwii4m
 c2bXNPu5q2Aq5djP4L9ezhnsF1tm75T9VZksuq1ZnTlDTj3OPxn18R1Jl6f6YxKEIc4c
 inDMJiUyIHkXTMxAgKZOb5sMjyOf58MH5teW9RLcRRGRikU63W9mVp9frpgoi1bOf4Dc
 nWIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=p2/SXxqi/mpzPKEmHvCWYtwtCXux2aJOwAbCs1scM98=;
 b=Orr3uAMX835FXKOoXBzGZOkdwow6zo3jwzxmB9XyLtpUZFwuub7PCkVFD8WaawwC/m
 JUonw81qd0kz12GrlLUB4b8ZZIOa9w9tXCI5gZE5iuxdwRypIuskLPFGMt8lijENknwe
 ga4OtItED9YFAcQlusuZ5Ici+myy25NDZeR/0xFlVHvelyd5V7qaWYtGLJPlaOlnJ1hM
 Vt6Qycp4ew5YX2sMsTllc7+rGPqLzmsH52qNFaUYoQ2IK1CdabogrJZkeELaCSgOgJO8
 KZFVCdkb3bQFqaV6WEXs09Y7ELrbRCq9+pAWJgAfgb+E/b5dOaz1d+DgTlnPc/T8yhIw
 +LJA==
X-Gm-Message-State: AOAM533APVpm4o8oy6v4EGe6yBoUO1j01Pc1yrswtykNLuaQ+D+FybYX
 dCOy91oRTXHjI/VLG0WLvMpUMKfJzA4=
X-Google-Smtp-Source: ABdhPJx28Vx1Xg9Io8LVBkzjR2O3pxnYM5QQcRaIaeBIrDrAjF88v45blHUdc2PwC9u0/XMirR6nOg==
X-Received: by 2002:a17:90b:234c:: with SMTP id
 ms12mr2486958pjb.164.1591146835254; 
 Tue, 02 Jun 2020 18:13:55 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id 3sm290067pfe.85.2020.06.02.18.13.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2020 18:13:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 28/42] target/arm: Use mte_checkN for sve unpredicated loads
Date: Tue,  2 Jun 2020 18:13:03 -0700
Message-Id: <20200603011317.473934-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200603011317.473934-1-richard.henderson@linaro.org>
References: <20200603011317.473934-1-richard.henderson@linaro.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, steplong@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper-sve.h    |  2 +
 target/arm/sve_helper.c    | 70 +++++++++++++++++++++++++++-
 target/arm/translate-sve.c | 93 ++++++++++++++++----------------------
 3 files changed, 109 insertions(+), 56 deletions(-)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index 7a200755ac..550ae7f7e6 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -1138,6 +1138,8 @@ DEF_HELPER_FLAGS_5(sve_ftmad_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sve_ftmad_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sve_ftmad_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_4(sve_ldr, TCG_CALL_NO_WG, void, env, ptr, tl, int)
+
 DEF_HELPER_FLAGS_4(sve_ld1bb_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 DEF_HELPER_FLAGS_4(sve_ld2bb_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
 DEF_HELPER_FLAGS_4(sve_ld3bb_r, TCG_CALL_NO_WG, void, env, ptr, tl, i32)
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index e590db6637..04340cbe0c 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -3935,7 +3935,7 @@ void HELPER(sve_fcmla_zpzzz_d)(void *vd, void *vn, void *vm, void *va,
  */
 
 /*
- * Load one element into @vd + @reg_off from @host.
+ * Load one element into @vd + @reg_off, from @host.
  * The controlling predicate is known to be true.
  */
 typedef void sve_ldst1_host_fn(void *vd, intptr_t reg_off, void *host);
@@ -4129,6 +4129,74 @@ static bool sve_probe_page(SVEHostPage *info, bool nofault,
     return true;
 }
 
+/*
+ * Load contiguous data, unpredicated.
+ *
+ * Note that unpredicated load/store of vector/predicate registers
+ * are defined as a stream of bytes, which equates to little-endian
+ * operations on larger quantities.
+ *
+ * Note any MTE check is already handled.
+ */
+
+void HELPER(sve_ldr)(CPUARMState *env, void *vd, target_ulong addr, int size)
+{
+    int mmu_idx = cpu_mmu_index(env, false);
+    int in_page = -((int)addr | TARGET_PAGE_MASK);
+    uintptr_t ra = GETPC();
+    uint64_t val;
+    int i;
+
+    /* Small loads are expanded inline. */
+    tcg_debug_assert(size > 2 * 8);
+
+    /* Bulk copy the data from memory to the register. */
+    if (likely(size <= in_page)) {
+        void *host = probe_read(env, addr, size, mmu_idx, ra);
+
+        if (unlikely(!host)) {
+            goto mmio;
+        }
+        memcpy(vd, host, size);
+    } else {
+        void *h1 = probe_read(env, addr, in_page, mmu_idx, ra);
+        void *h2 = probe_read(env, addr + in_page, size - in_page, mmu_idx, ra);
+
+        if (unlikely(!h1 || !h2)) {
+            goto mmio;
+        }
+        memcpy(vd, h1, in_page);
+        memcpy(vd + in_page, h2, size - in_page);
+    }
+
+    /* Predicate load length may be any multiple of 2; ensure high bits 0. */
+    if (unlikely(size & 7)) {
+        memset(vd + size, 0, 8 - (size & 7));
+    }
+
+    /*
+     * The memcpy and memset above kept the bytes in memory order.
+     * The in-register format has uint64_t in host order, so for
+     * big-endian host we need to bswap.
+     */
+    for (i = 0; i < size; i += 8) {
+        le64_to_cpus(vd + i);
+    }
+    return;
+
+ mmio:
+    for (i = 0; i + 8 <= size; i += 8) {
+        val = cpu_ldq_le_data_ra(env, addr + i, ra);
+        *(uint64_t *)(vd + i) = val;
+    }
+
+    /* Predicate load length may be any multiple of 2. */
+    if (unlikely(i != size)) {
+        val = cpu_ldq_le_data_ra(env, addr + size - 8, ra);
+        val >>= (size - i) * 8;
+        *(uint64_t *)(vd + i + 8) = val;
+    }
+}
 
 /*
  * Analyse contiguous data, protected by a governing predicate.
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index ac7b3119e5..35b979fa13 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -4332,8 +4332,13 @@ static bool trans_UCVTF_dd(DisasContext *s, arg_rpr_esz *a)
  *** SVE Memory - 32-bit Gather and Unsized Contiguous Group
  */
 
-/* Subroutine loading a vector register at VOFS of LEN bytes.
+/*
+ * Subroutine loading a vector register at VOFS of LEN bytes.
  * The load should begin at the address Rn + IMM.
+ *
+ * Note that unpredicated load/store of vector/predicate registers
+ * are defined as a stream of bytes, which equates to little-endian
+ * operations on larger quantities.
  */
 
 static void do_ldr(DisasContext *s, uint32_t vofs, int len, int rn, int imm)
@@ -4342,81 +4347,59 @@ static void do_ldr(DisasContext *s, uint32_t vofs, int len, int rn, int imm)
     int len_remain = len % 8;
     int nparts = len / 8 + ctpop8(len_remain);
     int midx = get_mem_index(s);
-    TCGv_i64 addr, t0, t1;
+    TCGv_i64 dirty_addr, clean_addr, t0, t1;
+    int i;
 
-    addr = tcg_temp_new_i64();
-    t0 = tcg_temp_new_i64();
+    dirty_addr = read_cpu_reg_sp(s, rn, true);
+    tcg_gen_addi_i64(dirty_addr, dirty_addr, imm);
 
-    /* Note that unpredicated load/store of vector/predicate registers
-     * are defined as a stream of bytes, which equates to little-endian
-     * operations on larger quantities.  There is no nice way to force
-     * a little-endian load for aarch64_be-linux-user out of line.
-     *
-     * Attempt to keep code expansion to a minimum by limiting the
-     * amount of unrolling done.
-     */
-    if (nparts <= 4) {
-        int i;
+    clean_addr = gen_mte_checkN(s, dirty_addr, false, rn != 31, len, MO_8);
 
-        for (i = 0; i < len_align; i += 8) {
-            tcg_gen_addi_i64(addr, cpu_reg_sp(s, rn), imm + i);
-            tcg_gen_qemu_ld_i64(t0, addr, midx, MO_LEQ);
-            tcg_gen_st_i64(t0, cpu_env, vofs + i);
-        }
-    } else {
-        TCGLabel *loop = gen_new_label();
-        TCGv_ptr tp, i = tcg_const_local_ptr(0);
+    /* Limit tcg code expansion by doing large loads out of line. */
+    if (nparts > 4) {
+        TCGv_ptr t_rd = tcg_temp_new_ptr();
+        TCGv_i32 t_len = tcg_const_i32(len);
 
-        gen_set_label(loop);
-
-        /* Minimize the number of local temps that must be re-read from
-         * the stack each iteration.  Instead, re-compute values other
-         * than the loop counter.
-         */
-        tp = tcg_temp_new_ptr();
-        tcg_gen_addi_ptr(tp, i, imm);
-        tcg_gen_extu_ptr_i64(addr, tp);
-        tcg_gen_add_i64(addr, addr, cpu_reg_sp(s, rn));
-
-        tcg_gen_qemu_ld_i64(t0, addr, midx, MO_LEQ);
-
-        tcg_gen_add_ptr(tp, cpu_env, i);
-        tcg_gen_addi_ptr(i, i, 8);
-        tcg_gen_st_i64(t0, tp, vofs);
-        tcg_temp_free_ptr(tp);
-
-        tcg_gen_brcondi_ptr(TCG_COND_LTU, i, len_align, loop);
-        tcg_temp_free_ptr(i);
+        tcg_gen_addi_ptr(t_rd, cpu_env, vofs);
+        gen_helper_sve_ldr(cpu_env, t_rd, clean_addr, t_len);
+        tcg_temp_free_ptr(t_rd);
+        tcg_temp_free_i32(t_len);
+        return;
     }
 
-    /* Predicate register loads can be any multiple of 2.
-     * Note that we still store the entire 64-bit unit into cpu_env.
+    t0 = tcg_temp_new_i64();
+    for (i = 0; i < len_align; i += 8) {
+        tcg_gen_qemu_ld_i64(t0, clean_addr, midx, MO_LEQ);
+        tcg_gen_st_i64(t0, cpu_env, vofs + i);
+        tcg_gen_addi_i64(clean_addr, clean_addr, 8);
+    }
+
+    /*
+     * Predicate register loads can be any multiple of 2.
+     * Note that we still store the entire 64-bit unit into cpu_env
+     * so that the high bits are zeroed.
      */
     if (len_remain) {
-        tcg_gen_addi_i64(addr, cpu_reg_sp(s, rn), imm + len_align);
-
         switch (len_remain) {
         case 2:
-        case 4:
-        case 8:
-            tcg_gen_qemu_ld_i64(t0, addr, midx, MO_LE | ctz32(len_remain));
+            tcg_gen_qemu_ld_i64(t0, clean_addr, midx, MO_LEUW);
+            break;
+        case 4:
+            tcg_gen_qemu_ld_i64(t0, clean_addr, midx, MO_LEUL);
             break;
-
         case 6:
             t1 = tcg_temp_new_i64();
-            tcg_gen_qemu_ld_i64(t0, addr, midx, MO_LEUL);
-            tcg_gen_addi_i64(addr, addr, 4);
-            tcg_gen_qemu_ld_i64(t1, addr, midx, MO_LEUW);
+            tcg_gen_qemu_ld_i64(t0, clean_addr, midx, MO_LEUL);
+            tcg_gen_addi_i64(clean_addr, clean_addr, 4);
+            tcg_gen_qemu_ld_i64(t1, clean_addr, midx, MO_LEUW);
             tcg_gen_deposit_i64(t0, t0, t1, 32, 32);
             tcg_temp_free_i64(t1);
             break;
-
         default:
             g_assert_not_reached();
         }
         tcg_gen_st_i64(t0, cpu_env, vofs + len_align);
     }
-    tcg_temp_free_i64(addr);
     tcg_temp_free_i64(t0);
 }
 
-- 
2.25.1



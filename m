Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE77EC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 15:31:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89F4E2080C
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 15:31:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="waVUE6Kd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89F4E2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joqK1-000603-KM
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 11:31:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35992)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joq4O-00032T-WC
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 11:15:14 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:56276)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joq4L-0006c1-4X
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 11:15:12 -0400
Received: by mail-wm1-x330.google.com with SMTP id g75so9145590wme.5
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2020 08:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=/eAAFosRGRJgv69Ri2fpL1KyoB3EcB8x/VAhiKbENhM=;
 b=waVUE6KdRQtwT71HY2AIXFLpvtpxQkbgmFN9cOdjXNKuPWnZV6Ez63WBYfzZbMg/sg
 bZ17v2O/eQn5C1RslVVPYewEtLJHZHQ5gXYjWYKyt3/G8rstg0kh89HdPqEXDDDZeAdZ
 GHO149iSSjCvP9leJd3GOSDEGETALkFz9odDisDSoXeulGGuSlL7b1Fzh7ixuGwCUQpv
 7qgOWg/SlVil+ZNbrrfQ3oQ+vgBORp1a707yxw5a8j9UqhgsEorPFYeEwVGTE/f2eB4p
 Pq+umOAVAfgBZScSG3MFtqNxRl7iM9oNvAw+9I/ZPzIyPlU+9zeF+B5PJx0VM+TrMdfr
 MkyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/eAAFosRGRJgv69Ri2fpL1KyoB3EcB8x/VAhiKbENhM=;
 b=gBRQsNy2dkasUe9hi4t4vciyVm6W3nt5s/ELZxaOBVteYSbt5YJcg3K821TfGy+Xsr
 XsRwmqMVcQknSENk/ygTDDhhLV8wcK1OL/yTsBpF+sthmEsgwPCXY2TH8Tz8ceqieyhM
 m5VXZQUi5dOvNUpfL8zxF+JG6pK+cqUpix+NbvaUWJnmROcd1sJhStaE3fx40jASALfr
 lp+Rq3lgNt9393SkWHs7Fy/bjBUA/2REu5ob0M/jTYZ1zr7wY6IXiryh8ZF4oF1uj1bc
 nfmJceWmZfuHE2p2PI+i+CT+GieG0OXCORhsyK+5verRSF+U6nvQtUD/wcgNVzA9vYW5
 MUeg==
X-Gm-Message-State: AOAM531tHPMXbCOm4N1aaMVrFItxLSSDWrmPiOmKGeeWr4khN9CAfBLP
 ZBxstjHp6DGjdKutVKMnp+Vu7dzkUVDLPQ==
X-Google-Smtp-Source: ABdhPJyei/Rbh0uyCJ78an3Qm4VGERpbrO/+6F1US2MAZzYfTc2oNB802ONqwkz+jkHWfULUkZQn3w==
X-Received: by 2002:a1c:2d83:: with SMTP id t125mr4028438wmt.187.1593184507169; 
 Fri, 26 Jun 2020 08:15:07 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w13sm37838852wrr.67.2020.06.26.08.15.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2020 08:15:06 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 35/57] target/arm: Add gen_mte_check1
Date: Fri, 26 Jun 2020 16:14:02 +0100
Message-Id: <20200626151424.30117-36-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200626151424.30117-1-peter.maydell@linaro.org>
References: <20200626151424.30117-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

Replace existing uses of check_data_tbi in translate-a64.c that
perform a single logical memory access.  Leave the helper blank
for now to reduce the patch size.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200626033144.790098-24-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper-a64.h    |   1 +
 target/arm/internals.h     |   8 +++
 target/arm/translate-a64.h |   2 +
 target/arm/mte_helper.c    |   8 +++
 target/arm/translate-a64.c | 100 ++++++++++++++++++++++++++++---------
 5 files changed, 95 insertions(+), 24 deletions(-)

diff --git a/target/arm/helper-a64.h b/target/arm/helper-a64.h
index 7b628d100e0..2faa49d0a33 100644
--- a/target/arm/helper-a64.h
+++ b/target/arm/helper-a64.h
@@ -104,6 +104,7 @@ DEF_HELPER_FLAGS_3(autdb, TCG_CALL_NO_WG, i64, env, i64, i64)
 DEF_HELPER_FLAGS_2(xpaci, TCG_CALL_NO_RWG_SE, i64, env, i64)
 DEF_HELPER_FLAGS_2(xpacd, TCG_CALL_NO_RWG_SE, i64, env, i64)
 
+DEF_HELPER_FLAGS_3(mte_check1, TCG_CALL_NO_WG, i64, env, i32, i64)
 DEF_HELPER_FLAGS_3(irg, TCG_CALL_NO_RWG, i64, env, i64, i64)
 DEF_HELPER_FLAGS_4(addsubg, TCG_CALL_NO_RWG_SE, i64, env, i64, s32, i32)
 DEF_HELPER_FLAGS_3(ldg, TCG_CALL_NO_WG, i64, env, i64, i64)
diff --git a/target/arm/internals.h b/target/arm/internals.h
index 7c9abbabc9a..fb92ef6b840 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1310,6 +1310,14 @@ void arm_log_exception(int idx);
 #define LOG2_TAG_GRANULE 4
 #define TAG_GRANULE      (1 << LOG2_TAG_GRANULE)
 
+/* Bits within a descriptor passed to the helper_mte_check* functions. */
+FIELD(MTEDESC, MIDX,  0, 4)
+FIELD(MTEDESC, TBI,   4, 2)
+FIELD(MTEDESC, TCMA,  6, 2)
+FIELD(MTEDESC, WRITE, 8, 1)
+FIELD(MTEDESC, ESIZE, 9, 5)
+FIELD(MTEDESC, TSIZE, 14, 10)  /* mte_checkN only */
+
 static inline int allocation_tag_from_addr(uint64_t ptr)
 {
     return extract64(ptr, 56, 4);
diff --git a/target/arm/translate-a64.h b/target/arm/translate-a64.h
index da0f59a2cee..daab6a96665 100644
--- a/target/arm/translate-a64.h
+++ b/target/arm/translate-a64.h
@@ -40,6 +40,8 @@ TCGv_ptr get_fpstatus_ptr(bool);
 bool logic_imm_decode_wmask(uint64_t *result, unsigned int immn,
                             unsigned int imms, unsigned int immr);
 bool sve_access_check(DisasContext *s);
+TCGv_i64 gen_mte_check1(DisasContext *s, TCGv_i64 addr, bool is_write,
+                        bool tag_checked, int log2_size);
 
 /* We should have at some point before trying to access an FP register
  * done the necessary access check, so assert that
diff --git a/target/arm/mte_helper.c b/target/arm/mte_helper.c
index 27d4b4536c0..ec12768dfc3 100644
--- a/target/arm/mte_helper.c
+++ b/target/arm/mte_helper.c
@@ -358,3 +358,11 @@ void HELPER(stzgm_tags)(CPUARMState *env, uint64_t ptr, uint64_t val)
         memset(mem, tag_pair, tag_bytes);
     }
 }
+
+/*
+ * Perform an MTE checked access for a single logical or atomic access.
+ */
+uint64_t HELPER(mte_check1)(CPUARMState *env, uint32_t desc, uint64_t ptr)
+{
+    return ptr;
+}
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 7dc493774ec..4d0453c8956 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -204,20 +204,20 @@ static void gen_a64_set_pc(DisasContext *s, TCGv_i64 src)
 }
 
 /*
- * Return a "clean" address for ADDR according to TBID.
- * This is always a fresh temporary, as we need to be able to
- * increment this independently of a dirty write-back address.
+ * Handle MTE and/or TBI.
+ *
+ * For TBI, ideally, we would do nothing.  Proper behaviour on fault is
+ * for the tag to be present in the FAR_ELx register.  But for user-only
+ * mode we do not have a TLB with which to implement this, so we must
+ * remove the top byte now.
+ *
+ * Always return a fresh temporary that we can increment independently
+ * of the write-back address.
  */
+
 static TCGv_i64 clean_data_tbi(DisasContext *s, TCGv_i64 addr)
 {
     TCGv_i64 clean = new_tmp_a64(s);
-    /*
-     * In order to get the correct value in the FAR_ELx register,
-     * we must present the memory subsystem with the "dirty" address
-     * including the TBI.  In system mode we can make this work via
-     * the TLB, dropping the TBI during translation.  But for user-only
-     * mode we don't have that option, and must remove the top byte now.
-     */
 #ifdef CONFIG_USER_ONLY
     gen_top_byte_ignore(s, clean, addr, s->tbid);
 #else
@@ -245,6 +245,45 @@ static void gen_probe_access(DisasContext *s, TCGv_i64 ptr,
     tcg_temp_free_i32(t_size);
 }
 
+/*
+ * For MTE, check a single logical or atomic access.  This probes a single
+ * address, the exact one specified.  The size and alignment of the access
+ * is not relevant to MTE, per se, but watchpoints do require the size,
+ * and we want to recognize those before making any other changes to state.
+ */
+static TCGv_i64 gen_mte_check1_mmuidx(DisasContext *s, TCGv_i64 addr,
+                                      bool is_write, bool tag_checked,
+                                      int log2_size, bool is_unpriv,
+                                      int core_idx)
+{
+    if (tag_checked && s->mte_active[is_unpriv]) {
+        TCGv_i32 tcg_desc;
+        TCGv_i64 ret;
+        int desc = 0;
+
+        desc = FIELD_DP32(desc, MTEDESC, MIDX, core_idx);
+        desc = FIELD_DP32(desc, MTEDESC, TBI, s->tbid);
+        desc = FIELD_DP32(desc, MTEDESC, TCMA, s->tcma);
+        desc = FIELD_DP32(desc, MTEDESC, WRITE, is_write);
+        desc = FIELD_DP32(desc, MTEDESC, ESIZE, 1 << log2_size);
+        tcg_desc = tcg_const_i32(desc);
+
+        ret = new_tmp_a64(s);
+        gen_helper_mte_check1(ret, cpu_env, tcg_desc, addr);
+        tcg_temp_free_i32(tcg_desc);
+
+        return ret;
+    }
+    return clean_data_tbi(s, addr);
+}
+
+TCGv_i64 gen_mte_check1(DisasContext *s, TCGv_i64 addr, bool is_write,
+                        bool tag_checked, int log2_size)
+{
+    return gen_mte_check1_mmuidx(s, addr, is_write, tag_checked, log2_size,
+                                 false, get_mem_index(s));
+}
+
 typedef struct DisasCompare64 {
     TCGCond cond;
     TCGv_i64 value;
@@ -2367,7 +2406,7 @@ static void gen_compare_and_swap(DisasContext *s, int rs, int rt,
     if (rn == 31) {
         gen_check_sp_alignment(s);
     }
-    clean_addr = clean_data_tbi(s, cpu_reg_sp(s, rn));
+    clean_addr = gen_mte_check1(s, cpu_reg_sp(s, rn), true, rn != 31, size);
     tcg_gen_atomic_cmpxchg_i64(tcg_rs, clean_addr, tcg_rs, tcg_rt, memidx,
                                size | MO_ALIGN | s->be_data);
 }
@@ -2385,7 +2424,9 @@ static void gen_compare_and_swap_pair(DisasContext *s, int rs, int rt,
     if (rn == 31) {
         gen_check_sp_alignment(s);
     }
-    clean_addr = clean_data_tbi(s, cpu_reg_sp(s, rn));
+
+    /* This is a single atomic access, despite the "pair". */
+    clean_addr = gen_mte_check1(s, cpu_reg_sp(s, rn), true, rn != 31, size + 1);
 
     if (size == 2) {
         TCGv_i64 cmp = tcg_temp_new_i64();
@@ -2510,7 +2551,8 @@ static void disas_ldst_excl(DisasContext *s, uint32_t insn)
         if (is_lasr) {
             tcg_gen_mb(TCG_MO_ALL | TCG_BAR_STRL);
         }
-        clean_addr = clean_data_tbi(s, cpu_reg_sp(s, rn));
+        clean_addr = gen_mte_check1(s, cpu_reg_sp(s, rn),
+                                    true, rn != 31, size);
         gen_store_exclusive(s, rs, rt, rt2, clean_addr, size, false);
         return;
 
@@ -2519,7 +2561,8 @@ static void disas_ldst_excl(DisasContext *s, uint32_t insn)
         if (rn == 31) {
             gen_check_sp_alignment(s);
         }
-        clean_addr = clean_data_tbi(s, cpu_reg_sp(s, rn));
+        clean_addr = gen_mte_check1(s, cpu_reg_sp(s, rn),
+                                    false, rn != 31, size);
         s->is_ldex = true;
         gen_load_exclusive(s, rt, rt2, clean_addr, size, false);
         if (is_lasr) {
@@ -2539,7 +2582,8 @@ static void disas_ldst_excl(DisasContext *s, uint32_t insn)
             gen_check_sp_alignment(s);
         }
         tcg_gen_mb(TCG_MO_ALL | TCG_BAR_STRL);
-        clean_addr = clean_data_tbi(s, cpu_reg_sp(s, rn));
+        clean_addr = gen_mte_check1(s, cpu_reg_sp(s, rn),
+                                    true, rn != 31, size);
         do_gpr_st(s, cpu_reg(s, rt), clean_addr, size, true, rt,
                   disas_ldst_compute_iss_sf(size, false, 0), is_lasr);
         return;
@@ -2555,7 +2599,8 @@ static void disas_ldst_excl(DisasContext *s, uint32_t insn)
         if (rn == 31) {
             gen_check_sp_alignment(s);
         }
-        clean_addr = clean_data_tbi(s, cpu_reg_sp(s, rn));
+        clean_addr = gen_mte_check1(s, cpu_reg_sp(s, rn),
+                                    false, rn != 31, size);
         do_gpr_ld(s, cpu_reg(s, rt), clean_addr, size, false, false, true, rt,
                   disas_ldst_compute_iss_sf(size, false, 0), is_lasr);
         tcg_gen_mb(TCG_MO_ALL | TCG_BAR_LDAQ);
@@ -2569,7 +2614,8 @@ static void disas_ldst_excl(DisasContext *s, uint32_t insn)
             if (is_lasr) {
                 tcg_gen_mb(TCG_MO_ALL | TCG_BAR_STRL);
             }
-            clean_addr = clean_data_tbi(s, cpu_reg_sp(s, rn));
+            clean_addr = gen_mte_check1(s, cpu_reg_sp(s, rn),
+                                        true, rn != 31, size);
             gen_store_exclusive(s, rs, rt, rt2, clean_addr, size, true);
             return;
         }
@@ -2587,7 +2633,8 @@ static void disas_ldst_excl(DisasContext *s, uint32_t insn)
             if (rn == 31) {
                 gen_check_sp_alignment(s);
             }
-            clean_addr = clean_data_tbi(s, cpu_reg_sp(s, rn));
+            clean_addr = gen_mte_check1(s, cpu_reg_sp(s, rn),
+                                        false, rn != 31, size);
             s->is_ldex = true;
             gen_load_exclusive(s, rt, rt2, clean_addr, size, true);
             if (is_lasr) {
@@ -2881,6 +2928,7 @@ static void disas_ldst_reg_imm9(DisasContext *s, uint32_t insn,
     bool iss_valid = !is_vector;
     bool post_index;
     bool writeback;
+    int memidx;
 
     TCGv_i64 clean_addr, dirty_addr;
 
@@ -2938,7 +2986,11 @@ static void disas_ldst_reg_imm9(DisasContext *s, uint32_t insn,
     if (!post_index) {
         tcg_gen_addi_i64(dirty_addr, dirty_addr, imm9);
     }
-    clean_addr = clean_data_tbi(s, dirty_addr);
+
+    memidx = is_unpriv ? get_a64_user_mem_index(s) : get_mem_index(s);
+    clean_addr = gen_mte_check1_mmuidx(s, dirty_addr, is_store,
+                                       writeback || rn != 31,
+                                       size, is_unpriv, memidx);
 
     if (is_vector) {
         if (is_store) {
@@ -2948,7 +3000,6 @@ static void disas_ldst_reg_imm9(DisasContext *s, uint32_t insn,
         }
     } else {
         TCGv_i64 tcg_rt = cpu_reg(s, rt);
-        int memidx = is_unpriv ? get_a64_user_mem_index(s) : get_mem_index(s);
         bool iss_sf = disas_ldst_compute_iss_sf(size, is_signed, opc);
 
         if (is_store) {
@@ -3045,7 +3096,7 @@ static void disas_ldst_reg_roffset(DisasContext *s, uint32_t insn,
     ext_and_shift_reg(tcg_rm, tcg_rm, opt, shift ? size : 0);
 
     tcg_gen_add_i64(dirty_addr, dirty_addr, tcg_rm);
-    clean_addr = clean_data_tbi(s, dirty_addr);
+    clean_addr = gen_mte_check1(s, dirty_addr, is_store, true, size);
 
     if (is_vector) {
         if (is_store) {
@@ -3130,7 +3181,7 @@ static void disas_ldst_reg_unsigned_imm(DisasContext *s, uint32_t insn,
     dirty_addr = read_cpu_reg_sp(s, rn, 1);
     offset = imm12 << size;
     tcg_gen_addi_i64(dirty_addr, dirty_addr, offset);
-    clean_addr = clean_data_tbi(s, dirty_addr);
+    clean_addr = gen_mte_check1(s, dirty_addr, is_store, rn != 31, size);
 
     if (is_vector) {
         if (is_store) {
@@ -3223,7 +3274,7 @@ static void disas_ldst_atomic(DisasContext *s, uint32_t insn,
     if (rn == 31) {
         gen_check_sp_alignment(s);
     }
-    clean_addr = clean_data_tbi(s, cpu_reg_sp(s, rn));
+    clean_addr = gen_mte_check1(s, cpu_reg_sp(s, rn), false, rn != 31, size);
 
     if (o3_opc == 014) {
         /*
@@ -3300,7 +3351,8 @@ static void disas_ldst_pac(DisasContext *s, uint32_t insn,
     tcg_gen_addi_i64(dirty_addr, dirty_addr, offset);
 
     /* Note that "clean" and "dirty" here refer to TBI not PAC.  */
-    clean_addr = clean_data_tbi(s, dirty_addr);
+    clean_addr = gen_mte_check1(s, dirty_addr, false,
+                                is_wback || rn != 31, size);
 
     tcg_rt = cpu_reg(s, rt);
     do_gpr_ld(s, tcg_rt, clean_addr, size, /* is_signed */ false,
-- 
2.20.1



Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 610F3C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 05:16:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 913E8206C0
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 05:16:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="eySjWvaF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 913E8206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaB9f-0008FG-CH
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 00:16:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60198)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=57073d1dd=alistair.francis@wdc.com>)
 id 1kaApA-0004MN-Ij; Tue, 03 Nov 2020 23:55:10 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:21931)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=57073d1dd=alistair.francis@wdc.com>)
 id 1kaAp7-0005ml-2v; Tue, 03 Nov 2020 23:55:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1604466618; x=1636002618;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=oebXz+FU0S0tCY1aSc+EvOPS+hmZUBeVgzx3vCpSopA=;
 b=eySjWvaF/tCz3mzPbhuJ6uXaJElScCp9Q/z+iBeIq9cARCt7UAJhvBvT
 FNUnaIlh7fOSpP3+P+JeFunMHltIdkuE9/Jt8j6paASuOHA+DUmxk3R+Y
 SwsYLxa3F41LhOvt1JgxXChLSJkLyY/n7Qs8LveBOC1nZOYA94Rjz1HrN
 R1S4jr1LIoo/zyi4YlTJtRt6n7ZhVx6Z4Oz6sAc4UAEihtOprbnC0Y5BZ
 mbeeS0ltMxo1Bdcb+gfI2np5Ft/MPOo+4O2ZggSmzR218pMBDn8Mi2AWw
 EPmYrezIyBBKCWmY+ZTCzl5QfMeUYkxcjDRa5vXuCBMrJKOB2ujcuvwJt A==;
IronPort-SDR: db5BYLD/4mKbLmUwoGF5lo7R9rjXCPF8Ik49p2K5ZHyrOCpaOcDxyQb/3xeql3AcEZusgVNEut
 KSMPpSd8zyOWQK6Px6wvZxCB0KmDnVSrckweYB1qVSwBzcm5KBvvrc5Ae25+UJH4xwqsCyCJJs
 PPcWeO7rwUsE1mhlZztqh+S3HU64drP9LvD7RuLAfY4LTW6RNQYipx8bsiG8+r0YI0FqUkX1/A
 QZjgaijhwD5TheOErYy0Hmbr5CsmSqiYAupbg0HKB+uFf0mwkj5kxV0H/TRZ5Ql4LVe1AhqTSh
 ilg=
X-IronPort-AV: E=Sophos;i="5.77,449,1596470400"; d="scan'208";a="255296318"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 04 Nov 2020 13:10:15 +0800
IronPort-SDR: M8BhJKivNDHTfmIqrXapveidP0wepz+Idi3NvluD4adTDYL8BLWIEsrObxoya2vR0dJAwUwjTd
 bvOpJwL7/vNgMhwmEFherSIBWvtN2h4TOlLn8UPuofvtAif1I8qqKmMu1IHxBxCNo1dOBsqFVg
 stzUwRGcnrJbx5iShlrGRJecCjeSqGHgrQBn18L69EMS9zLQArzXtwMV/hyT2Q0D1SbwGdBrAf
 BgNUdb5CtCj9HJpgJVEPjP3ihqZvNTbPIl2YGuuwOf6OcI69qH1l10/qkVkarZ//A9Dt33w7Gn
 EQqqslTQ7002hYBZWE0++Au8
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2020 20:41:11 -0800
IronPort-SDR: 11GRjl6uRXk/LXGntNOrv/fJGZA3oz4og1dVCOUzu7b4JLlzsqaN8kb1gUQV7iMdTtl9VYKtS+
 HcdYvEJOAZOUe3h6g5qkucKRE2iyjMGege5GqVvCyB5oUwD0d+WZUvtV81MIGqumw/QZR/gUck
 WhPEE0b9kNw0WRyXEV7b4CZIthEF/pPT5RCkvtTaW38hQ7zPeDKXtcNmv/8DgOgOrnsLhgIYKo
 S0VsRObl3KoZeBXioe8YwCmjUCjv2c3Fxs7wi9uY08kN1+pv+NG6ryHiD1O1icPsp1CemKyVe+
 ol4=
WDCIronportException: Internal
Received: from usa003000.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.60.113])
 by uls-op-cesaip01.wdc.com with ESMTP; 03 Nov 2020 20:55:02 -0800
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v4 4/5] target/riscv: Remove the hyp load and store functions
Date: Tue,  3 Nov 2020 20:43:31 -0800
Message-Id: <189ac3e53ef2854824d18aad7074c6649f17de2c.1604464950.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1604464950.git.alistair.francis@wdc.com>
References: <cover.1604464950.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=68.232.143.124;
 envelope-from=prvs=57073d1dd=alistair.francis@wdc.com;
 helo=esa2.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 23:55:03
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: alistair.francis@wdc.com, richard.henderson@linaro.org, bmeng.cn@gmail.com,
 palmer@dabbelt.com, alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Remove the special Virtulisation load and store functions and just use
the standard tcg tcg_gen_qemu_ld_tl() and tcg_gen_qemu_st_tl() functions
instead.

As part of this change we ensure we still run an access check to make
sure we can perform the operations.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h                      |  12 +++
 target/riscv/helper.h                   |   2 -
 target/riscv/op_helper.c                |  86 -----------------
 target/riscv/translate.c                |   2 +
 target/riscv/insn_trans/trans_rvh.c.inc | 123 +++++++++---------------
 5 files changed, 59 insertions(+), 166 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 0cf48a1521..c0a326c843 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -375,6 +375,8 @@ FIELD(TB_FLAGS, VL_EQ_VLMAX, 2, 1)
 FIELD(TB_FLAGS, LMUL, 3, 2)
 FIELD(TB_FLAGS, SEW, 5, 3)
 FIELD(TB_FLAGS, VILL, 8, 1)
+/* Is a Hypervisor instruction load/store allowed? */
+FIELD(TB_FLAGS, HLSX, 9, 1)
 
 /*
  * A simplification for VLMAX
@@ -421,7 +423,17 @@ static inline void cpu_get_tb_cpu_state(CPURISCVState *env, target_ulong *pc,
     if (riscv_cpu_fp_enabled(env)) {
         flags |= env->mstatus & MSTATUS_FS;
     }
+
+    if (riscv_has_ext(env, RVH)) {
+        if (env->priv == PRV_M ||
+            (env->priv == PRV_S && !riscv_cpu_virt_enabled(env)) ||
+            (env->priv == PRV_U && !riscv_cpu_virt_enabled(env) &&
+                get_field(env->hstatus, HSTATUS_HU))) {
+            flags = FIELD_DP32(flags, TB_FLAGS, HLSX, 1);
+        }
+    }
 #endif
+
     *pflags = flags;
 }
 
diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 4b690147fb..ee35311052 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -81,8 +81,6 @@ DEF_HELPER_1(tlb_flush, void, env)
 #ifndef CONFIG_USER_ONLY
 DEF_HELPER_1(hyp_tlb_flush, void, env)
 DEF_HELPER_1(hyp_gvma_tlb_flush, void, env)
-DEF_HELPER_4(hyp_load, tl, env, tl, tl, tl)
-DEF_HELPER_5(hyp_store, void, env, tl, tl, tl, tl)
 DEF_HELPER_4(hyp_x_load, tl, env, tl, tl, tl)
 #endif
 
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 5759850e69..980d4f39e1 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -227,92 +227,6 @@ void helper_hyp_gvma_tlb_flush(CPURISCVState *env)
     helper_hyp_tlb_flush(env);
 }
 
-target_ulong helper_hyp_load(CPURISCVState *env, target_ulong address,
-                             target_ulong attrs, target_ulong memop)
-{
-    if (env->priv == PRV_M ||
-        (env->priv == PRV_S && !riscv_cpu_virt_enabled(env)) ||
-        (env->priv == PRV_U && !riscv_cpu_virt_enabled(env) &&
-            get_field(env->hstatus, HSTATUS_HU))) {
-        target_ulong pte;
-        int mmu_idx = cpu_mmu_index(env, false) | TB_FLAGS_PRIV_HYP_ACCESS_MASK;
-
-        switch (memop) {
-        case MO_SB:
-            pte = cpu_ldsb_mmuidx_ra(env, address, mmu_idx, GETPC());
-            break;
-        case MO_UB:
-            pte = cpu_ldub_mmuidx_ra(env, address, mmu_idx, GETPC());
-            break;
-        case MO_TESW:
-            pte = cpu_ldsw_mmuidx_ra(env, address, mmu_idx, GETPC());
-            break;
-        case MO_TEUW:
-            pte = cpu_lduw_mmuidx_ra(env, address, mmu_idx, GETPC());
-            break;
-        case MO_TESL:
-            pte = cpu_ldl_mmuidx_ra(env, address, mmu_idx, GETPC());
-            break;
-        case MO_TEUL:
-            pte = cpu_ldl_mmuidx_ra(env, address, mmu_idx, GETPC());
-            break;
-        case MO_TEQ:
-            pte = cpu_ldq_mmuidx_ra(env, address, mmu_idx, GETPC());
-            break;
-        default:
-            g_assert_not_reached();
-        }
-
-        return pte;
-    }
-
-    if (riscv_cpu_virt_enabled(env)) {
-        riscv_raise_exception(env, RISCV_EXCP_VIRT_INSTRUCTION_FAULT, GETPC());
-    } else {
-        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
-    }
-    return 0;
-}
-
-void helper_hyp_store(CPURISCVState *env, target_ulong address,
-                      target_ulong val, target_ulong attrs, target_ulong memop)
-{
-    if (env->priv == PRV_M ||
-        (env->priv == PRV_S && !riscv_cpu_virt_enabled(env)) ||
-        (env->priv == PRV_U && !riscv_cpu_virt_enabled(env) &&
-            get_field(env->hstatus, HSTATUS_HU))) {
-        int mmu_idx = cpu_mmu_index(env, false) | TB_FLAGS_PRIV_HYP_ACCESS_MASK;
-
-        switch (memop) {
-        case MO_SB:
-        case MO_UB:
-            cpu_stb_mmuidx_ra(env, address, val, mmu_idx, GETPC());
-            break;
-        case MO_TESW:
-        case MO_TEUW:
-            cpu_stw_mmuidx_ra(env, address, val, mmu_idx, GETPC());
-            break;
-        case MO_TESL:
-        case MO_TEUL:
-            cpu_stl_mmuidx_ra(env, address, val, mmu_idx, GETPC());
-            break;
-        case MO_TEQ:
-            cpu_stq_mmuidx_ra(env, address, val, mmu_idx, GETPC());
-            break;
-        default:
-            g_assert_not_reached();
-        }
-
-        return;
-    }
-
-    if (riscv_cpu_virt_enabled(env)) {
-        riscv_raise_exception(env, RISCV_EXCP_VIRT_INSTRUCTION_FAULT, GETPC());
-    } else {
-        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
-    }
-}
-
 target_ulong helper_hyp_x_load(CPURISCVState *env, target_ulong address,
                                target_ulong attrs, target_ulong memop)
 {
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 79dca2291b..554d52a4be 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -56,6 +56,7 @@ typedef struct DisasContext {
        to reset this known value.  */
     int frm;
     bool ext_ifencei;
+    bool hlsx;
     /* vector extension */
     bool vill;
     uint8_t lmul;
@@ -807,6 +808,7 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     ctx->frm = -1;  /* unknown rounding mode */
     ctx->ext_ifencei = cpu->cfg.ext_ifencei;
     ctx->vlen = cpu->cfg.vlen;
+    ctx->hlsx = FIELD_EX32(tb_flags, TB_FLAGS, HLSX);
     ctx->vill = FIELD_EX32(tb_flags, TB_FLAGS, VILL);
     ctx->sew = FIELD_EX32(tb_flags, TB_FLAGS, SEW);
     ctx->lmul = FIELD_EX32(tb_flags, TB_FLAGS, LMUL);
diff --git a/target/riscv/insn_trans/trans_rvh.c.inc b/target/riscv/insn_trans/trans_rvh.c.inc
index 881c9ef4d2..cc197e7186 100644
--- a/target/riscv/insn_trans/trans_rvh.c.inc
+++ b/target/riscv/insn_trans/trans_rvh.c.inc
@@ -16,26 +16,34 @@
  * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
+#ifndef CONFIG_USER_ONLY
+static void check_access(DisasContext *ctx) {
+    if (!ctx->hlsx) {
+        if (ctx->virt_enabled) {
+            generate_exception(ctx, RISCV_EXCP_VIRT_INSTRUCTION_FAULT);
+        } else {
+            generate_exception(ctx, RISCV_EXCP_ILLEGAL_INST);
+        }
+    }
+}
+#endif
+
 static bool trans_hlv_b(DisasContext *ctx, arg_hlv_b *a)
 {
     REQUIRE_EXT(ctx, RVH);
 #ifndef CONFIG_USER_ONLY
     TCGv t0 = tcg_temp_new();
     TCGv t1 = tcg_temp_new();
-    TCGv mem_idx = tcg_temp_new();
-    TCGv memop = tcg_temp_new();
+
+    check_access(ctx);
 
     gen_get_gpr(t0, a->rs1);
-    tcg_gen_movi_tl(mem_idx, ctx->mem_idx);
-    tcg_gen_movi_tl(memop, MO_SB);
 
-    gen_helper_hyp_load(t1, cpu_env, t0, mem_idx, memop);
+    tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx | TB_FLAGS_PRIV_HYP_ACCESS_MASK, MO_SB);
     gen_set_gpr(a->rd, t1);
 
     tcg_temp_free(t0);
     tcg_temp_free(t1);
-    tcg_temp_free(mem_idx);
-    tcg_temp_free(memop);
     return true;
 #else
     return false;
@@ -48,20 +56,16 @@ static bool trans_hlv_h(DisasContext *ctx, arg_hlv_h *a)
 #ifndef CONFIG_USER_ONLY
     TCGv t0 = tcg_temp_new();
     TCGv t1 = tcg_temp_new();
-    TCGv mem_idx = tcg_temp_new();
-    TCGv memop = tcg_temp_new();
+
+    check_access(ctx);
 
     gen_get_gpr(t0, a->rs1);
-    tcg_gen_movi_tl(mem_idx, ctx->mem_idx);
-    tcg_gen_movi_tl(memop, MO_TESW);
 
-    gen_helper_hyp_load(t1, cpu_env, t0, mem_idx, memop);
+    tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx | TB_FLAGS_PRIV_HYP_ACCESS_MASK, MO_TESW);
     gen_set_gpr(a->rd, t1);
 
     tcg_temp_free(t0);
     tcg_temp_free(t1);
-    tcg_temp_free(mem_idx);
-    tcg_temp_free(memop);
     return true;
 #else
     return false;
@@ -74,20 +78,16 @@ static bool trans_hlv_w(DisasContext *ctx, arg_hlv_w *a)
 #ifndef CONFIG_USER_ONLY
     TCGv t0 = tcg_temp_new();
     TCGv t1 = tcg_temp_new();
-    TCGv mem_idx = tcg_temp_new();
-    TCGv memop = tcg_temp_new();
+
+    check_access(ctx);
 
     gen_get_gpr(t0, a->rs1);
-    tcg_gen_movi_tl(mem_idx, ctx->mem_idx);
-    tcg_gen_movi_tl(memop, MO_TESL);
 
-    gen_helper_hyp_load(t1, cpu_env, t0, mem_idx, memop);
+    tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx | TB_FLAGS_PRIV_HYP_ACCESS_MASK, MO_TESL);
     gen_set_gpr(a->rd, t1);
 
     tcg_temp_free(t0);
     tcg_temp_free(t1);
-    tcg_temp_free(mem_idx);
-    tcg_temp_free(memop);
     return true;
 #else
     return false;
@@ -100,20 +100,16 @@ static bool trans_hlv_bu(DisasContext *ctx, arg_hlv_bu *a)
 #ifndef CONFIG_USER_ONLY
     TCGv t0 = tcg_temp_new();
     TCGv t1 = tcg_temp_new();
-    TCGv mem_idx = tcg_temp_new();
-    TCGv memop = tcg_temp_new();
+
+    check_access(ctx);
 
     gen_get_gpr(t0, a->rs1);
-    tcg_gen_movi_tl(mem_idx, ctx->mem_idx);
-    tcg_gen_movi_tl(memop, MO_UB);
 
-    gen_helper_hyp_load(t1, cpu_env, t0, mem_idx, memop);
+    tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx | TB_FLAGS_PRIV_HYP_ACCESS_MASK, MO_UB);
     gen_set_gpr(a->rd, t1);
 
     tcg_temp_free(t0);
     tcg_temp_free(t1);
-    tcg_temp_free(mem_idx);
-    tcg_temp_free(memop);
     return true;
 #else
     return false;
@@ -126,20 +122,15 @@ static bool trans_hlv_hu(DisasContext *ctx, arg_hlv_hu *a)
 #ifndef CONFIG_USER_ONLY
     TCGv t0 = tcg_temp_new();
     TCGv t1 = tcg_temp_new();
-    TCGv mem_idx = tcg_temp_new();
-    TCGv memop = tcg_temp_new();
 
-    gen_get_gpr(t0, a->rs1);
-    tcg_gen_movi_tl(mem_idx, ctx->mem_idx);
-    tcg_gen_movi_tl(memop, MO_TEUW);
+    check_access(ctx);
 
-    gen_helper_hyp_load(t1, cpu_env, t0, mem_idx, memop);
+    gen_get_gpr(t0, a->rs1);
+    tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx | TB_FLAGS_PRIV_HYP_ACCESS_MASK, MO_TEUW);
     gen_set_gpr(a->rd, t1);
 
     tcg_temp_free(t0);
     tcg_temp_free(t1);
-    tcg_temp_free(mem_idx);
-    tcg_temp_free(memop);
     return true;
 #else
     return false;
@@ -152,20 +143,16 @@ static bool trans_hsv_b(DisasContext *ctx, arg_hsv_b *a)
 #ifndef CONFIG_USER_ONLY
     TCGv t0 = tcg_temp_new();
     TCGv dat = tcg_temp_new();
-    TCGv mem_idx = tcg_temp_new();
-    TCGv memop = tcg_temp_new();
+
+    check_access(ctx);
 
     gen_get_gpr(t0, a->rs1);
     gen_get_gpr(dat, a->rs2);
-    tcg_gen_movi_tl(mem_idx, ctx->mem_idx);
-    tcg_gen_movi_tl(memop, MO_SB);
 
-    gen_helper_hyp_store(cpu_env, t0, dat, mem_idx, memop);
+    tcg_gen_qemu_st_tl(dat, t0, ctx->mem_idx | TB_FLAGS_PRIV_HYP_ACCESS_MASK, MO_SB);
 
     tcg_temp_free(t0);
     tcg_temp_free(dat);
-    tcg_temp_free(mem_idx);
-    tcg_temp_free(memop);
     return true;
 #else
     return false;
@@ -178,20 +165,16 @@ static bool trans_hsv_h(DisasContext *ctx, arg_hsv_h *a)
 #ifndef CONFIG_USER_ONLY
     TCGv t0 = tcg_temp_new();
     TCGv dat = tcg_temp_new();
-    TCGv mem_idx = tcg_temp_new();
-    TCGv memop = tcg_temp_new();
+
+    check_access(ctx);
 
     gen_get_gpr(t0, a->rs1);
     gen_get_gpr(dat, a->rs2);
-    tcg_gen_movi_tl(mem_idx, ctx->mem_idx);
-    tcg_gen_movi_tl(memop, MO_TESW);
 
-    gen_helper_hyp_store(cpu_env, t0, dat, mem_idx, memop);
+    tcg_gen_qemu_st_tl(dat, t0, ctx->mem_idx | TB_FLAGS_PRIV_HYP_ACCESS_MASK, MO_TESW);
 
     tcg_temp_free(t0);
     tcg_temp_free(dat);
-    tcg_temp_free(mem_idx);
-    tcg_temp_free(memop);
     return true;
 #else
     return false;
@@ -204,20 +187,16 @@ static bool trans_hsv_w(DisasContext *ctx, arg_hsv_w *a)
 #ifndef CONFIG_USER_ONLY
     TCGv t0 = tcg_temp_new();
     TCGv dat = tcg_temp_new();
-    TCGv mem_idx = tcg_temp_new();
-    TCGv memop = tcg_temp_new();
+
+    check_access(ctx);
 
     gen_get_gpr(t0, a->rs1);
     gen_get_gpr(dat, a->rs2);
-    tcg_gen_movi_tl(mem_idx, ctx->mem_idx);
-    tcg_gen_movi_tl(memop, MO_TESL);
 
-    gen_helper_hyp_store(cpu_env, t0, dat, mem_idx, memop);
+    tcg_gen_qemu_st_tl(dat, t0, ctx->mem_idx | TB_FLAGS_PRIV_HYP_ACCESS_MASK, MO_TESL);
 
     tcg_temp_free(t0);
     tcg_temp_free(dat);
-    tcg_temp_free(mem_idx);
-    tcg_temp_free(memop);
     return true;
 #else
     return false;
@@ -231,20 +210,16 @@ static bool trans_hlv_wu(DisasContext *ctx, arg_hlv_wu *a)
 #ifndef CONFIG_USER_ONLY
     TCGv t0 = tcg_temp_new();
     TCGv t1 = tcg_temp_new();
-    TCGv mem_idx = tcg_temp_new();
-    TCGv memop = tcg_temp_new();
+
+    check_access(ctx);
 
     gen_get_gpr(t0, a->rs1);
-    tcg_gen_movi_tl(mem_idx, ctx->mem_idx);
-    tcg_gen_movi_tl(memop, MO_TEUL);
 
-    gen_helper_hyp_load(t1, cpu_env, t0, mem_idx, memop);
+    tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx | TB_FLAGS_PRIV_HYP_ACCESS_MASK, MO_TEUL);
     gen_set_gpr(a->rd, t1);
 
     tcg_temp_free(t0);
     tcg_temp_free(t1);
-    tcg_temp_free(mem_idx);
-    tcg_temp_free(memop);
     return true;
 #else
     return false;
@@ -257,20 +232,16 @@ static bool trans_hlv_d(DisasContext *ctx, arg_hlv_d *a)
 #ifndef CONFIG_USER_ONLY
     TCGv t0 = tcg_temp_new();
     TCGv t1 = tcg_temp_new();
-    TCGv mem_idx = tcg_temp_new();
-    TCGv memop = tcg_temp_new();
+
+    check_access(ctx);
 
     gen_get_gpr(t0, a->rs1);
-    tcg_gen_movi_tl(mem_idx, ctx->mem_idx);
-    tcg_gen_movi_tl(memop, MO_TEQ);
 
-    gen_helper_hyp_load(t1, cpu_env, t0, mem_idx, memop);
+    tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx | TB_FLAGS_PRIV_HYP_ACCESS_MASK, MO_TEQ);
     gen_set_gpr(a->rd, t1);
 
     tcg_temp_free(t0);
     tcg_temp_free(t1);
-    tcg_temp_free(mem_idx);
-    tcg_temp_free(memop);
     return true;
 #else
     return false;
@@ -283,20 +254,16 @@ static bool trans_hsv_d(DisasContext *ctx, arg_hsv_d *a)
 #ifndef CONFIG_USER_ONLY
     TCGv t0 = tcg_temp_new();
     TCGv dat = tcg_temp_new();
-    TCGv mem_idx = tcg_temp_new();
-    TCGv memop = tcg_temp_new();
+
+    check_access(ctx);
 
     gen_get_gpr(t0, a->rs1);
     gen_get_gpr(dat, a->rs2);
-    tcg_gen_movi_tl(mem_idx, ctx->mem_idx);
-    tcg_gen_movi_tl(memop, MO_TEQ);
 
-    gen_helper_hyp_store(cpu_env, t0, dat, mem_idx, memop);
+    tcg_gen_qemu_st_tl(dat, t0, ctx->mem_idx | TB_FLAGS_PRIV_HYP_ACCESS_MASK, MO_TEQ);
 
     tcg_temp_free(t0);
     tcg_temp_free(dat);
-    tcg_temp_free(mem_idx);
-    tcg_temp_free(memop);
     return true;
 #else
     return false;
-- 
2.28.0



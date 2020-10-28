Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 705D0C388F7
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 14:55:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 879B8247A8
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 14:55:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="R2YQx993"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 879B8247A8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXmrT-0003m6-7I
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 10:55:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38570)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=563b96974=alistair.francis@wdc.com>)
 id 1kXmpq-00023P-EZ; Wed, 28 Oct 2020 10:53:58 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:10520)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=563b96974=alistair.francis@wdc.com>)
 id 1kXmpn-00038G-GB; Wed, 28 Oct 2020 10:53:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1603896835; x=1635432835;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=MA3yZb5xZY5wksazZHFHCFmSDbZgG6ZtV5oqcwwv4MM=;
 b=R2YQx993dMumHJDWL7LSuOUogrpi1sZjwbOPMxLjgZ7IKAla8Pb6+THb
 dzZR2CQ5lBlCLPkzy8mkikrGU1LQ0+uxuGojAWDX2ZGCpuBqoUVSeukIT
 JWHKKEGdppgXBsch14M5Ard0h/lA3HSKm5KBaUxMEP0MbrG0iWyEMY/OD
 S/X3m1WgDQI2OlW59y6wWMgjtShqRA9HcsYqZOkKe5MI/PRMUEfHaa9Ti
 ikFs+Ssb3ydnmsIBytyoKt4zM+gj3BPNhyxueHPzXXyapWAVhJ0B2q/iw
 kgrhr8ZNUygLMVW3VdQ94T4+135g6a0GIvrZt+rkVwlfDs2X6AEChGMid w==;
IronPort-SDR: 6pL8AiqHf3iv+QweqDinF+CTAb+vZNuSjqYyPz3Vx/YKK4XQzOFWQfpqeVfWeroTeqO8GgDBXZ
 X10cpOsPgBPb3NiN8M+N1HoMQDxn9tzluMflFUjO5BmRm35wGLdKf886T5ObBBTasNfXYXA78M
 I1WPzqhKJW+JWkPXEqmB3PgSgV2HIVT8Hy4z7IO0YfQ9T8SYRyBNXcEgb7o+V3F2leVrMYLdOk
 jy9RhQJ/q5VfxJCCmSb9s/LSmaUKELVcp6ixP8uyQenMMb3q2tJuJ9vIBz/+ErKQKngtWMhKf2
 pJw=
X-IronPort-AV: E=Sophos;i="5.77,426,1596470400"; d="scan'208";a="151200411"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 28 Oct 2020 22:53:54 +0800
IronPort-SDR: 0yTH+YFvA/jMpIwK00VLq6/g74+jr68HeU+osGZanO7i6bMwDgj6bH/fhieNqouHRrK5FpaYSR
 iGYtx42YjR/KOGkKV6JEzwOonLjBq+SAHs0FVS1P+jHvm84RPA8a6oesd//Lp6cu07l44k/G30
 nD+f/CSnkApSGIL3ZWoonXRHmxGIy/a0h+irLGcdSbaar+f0C3Ya+nGTEa50kQOqRUnuHlL+ku
 +AEPz5U2kVScusEH86U3eqZN1wMKtcmmEXWmm9i5xEf9GwWevMx39KH/vHVLsV2XTImo+wzq/K
 W6INN3aSEk//nqSgn5Euhxlo
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2020 07:39:03 -0700
IronPort-SDR: 6S/4F7ZL2SwCZkpdD33pq5ZdjKg5zoPsXW6Fenq3cTXTa9ayJzR98Qhb4lwyOPrm5D57jAttrn
 O6MF9bisAelVRWUXZyVf6D2PBhv0nwSljzvyomSIzfC0XrWKVVoqedKzbn4rWSjXvti/54yGar
 YJVPAW0KSu+v/iD9kzqNyC/Rda+P1TX/z6ZcYUp0oAO9JxdREXOnQB6tHktsztlU9k9J5SMxaM
 X9HBsnp8+PlQEHiOONnuyf1TlsQzrUpaByEXO0gT6lWfp3xH2XhW/QIIPq8wnPMGDKdLjfSOda
 pu0=
WDCIronportException: Internal
Received: from usa003000.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.60.131])
 by uls-op-cesaip01.wdc.com with ESMTP; 28 Oct 2020 07:53:54 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v2 4/5] target/riscv: Remove the hyp load and store functions
Date: Wed, 28 Oct 2020 07:42:29 -0700
Message-Id: <5ead43dea141994823a113a2e7f1494df12d32dd.1603896076.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1603896075.git.alistair.francis@wdc.com>
References: <cover.1603896075.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.144;
 envelope-from=prvs=563b96974=alistair.francis@wdc.com;
 helo=esa5.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/28 10:53:43
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
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
 target/riscv/helper.h                   |   3 +-
 target/riscv/op_helper.c                |  72 +--------------
 target/riscv/insn_trans/trans_rvh.c.inc | 111 +++++++-----------------
 3 files changed, 35 insertions(+), 151 deletions(-)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 4b690147fb..7dbdd117d2 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -81,8 +81,7 @@ DEF_HELPER_1(tlb_flush, void, env)
 #ifndef CONFIG_USER_ONLY
 DEF_HELPER_1(hyp_tlb_flush, void, env)
 DEF_HELPER_1(hyp_gvma_tlb_flush, void, env)
-DEF_HELPER_4(hyp_load, tl, env, tl, tl, tl)
-DEF_HELPER_5(hyp_store, void, env, tl, tl, tl, tl)
+DEF_HELPER_1(hyp_access_check, void, env)
 DEF_HELPER_4(hyp_x_load, tl, env, tl, tl, tl)
 #endif
 
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 5759850e69..d81d8282cc 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -227,82 +227,12 @@ void helper_hyp_gvma_tlb_flush(CPURISCVState *env)
     helper_hyp_tlb_flush(env);
 }
 
-target_ulong helper_hyp_load(CPURISCVState *env, target_ulong address,
-                             target_ulong attrs, target_ulong memop)
+void helper_hyp_access_check(CPURISCVState *env)
 {
     if (env->priv == PRV_M ||
         (env->priv == PRV_S && !riscv_cpu_virt_enabled(env)) ||
         (env->priv == PRV_U && !riscv_cpu_virt_enabled(env) &&
             get_field(env->hstatus, HSTATUS_HU))) {
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
         return;
     }
 
diff --git a/target/riscv/insn_trans/trans_rvh.c.inc b/target/riscv/insn_trans/trans_rvh.c.inc
index 881c9ef4d2..79968701e9 100644
--- a/target/riscv/insn_trans/trans_rvh.c.inc
+++ b/target/riscv/insn_trans/trans_rvh.c.inc
@@ -22,20 +22,16 @@ static bool trans_hlv_b(DisasContext *ctx, arg_hlv_b *a)
 #ifndef CONFIG_USER_ONLY
     TCGv t0 = tcg_temp_new();
     TCGv t1 = tcg_temp_new();
-    TCGv mem_idx = tcg_temp_new();
-    TCGv memop = tcg_temp_new();
+
+    gen_helper_hyp_access_check(cpu_env);
 
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
@@ -48,20 +44,16 @@ static bool trans_hlv_h(DisasContext *ctx, arg_hlv_h *a)
 #ifndef CONFIG_USER_ONLY
     TCGv t0 = tcg_temp_new();
     TCGv t1 = tcg_temp_new();
-    TCGv mem_idx = tcg_temp_new();
-    TCGv memop = tcg_temp_new();
+
+    gen_helper_hyp_access_check(cpu_env);
 
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
@@ -74,20 +66,16 @@ static bool trans_hlv_w(DisasContext *ctx, arg_hlv_w *a)
 #ifndef CONFIG_USER_ONLY
     TCGv t0 = tcg_temp_new();
     TCGv t1 = tcg_temp_new();
-    TCGv mem_idx = tcg_temp_new();
-    TCGv memop = tcg_temp_new();
+
+    gen_helper_hyp_access_check(cpu_env);
 
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
@@ -100,20 +88,16 @@ static bool trans_hlv_bu(DisasContext *ctx, arg_hlv_bu *a)
 #ifndef CONFIG_USER_ONLY
     TCGv t0 = tcg_temp_new();
     TCGv t1 = tcg_temp_new();
-    TCGv mem_idx = tcg_temp_new();
-    TCGv memop = tcg_temp_new();
+
+    gen_helper_hyp_access_check(cpu_env);
 
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
@@ -126,20 +110,15 @@ static bool trans_hlv_hu(DisasContext *ctx, arg_hlv_hu *a)
 #ifndef CONFIG_USER_ONLY
     TCGv t0 = tcg_temp_new();
     TCGv t1 = tcg_temp_new();
-    TCGv mem_idx = tcg_temp_new();
-    TCGv memop = tcg_temp_new();
 
-    gen_get_gpr(t0, a->rs1);
-    tcg_gen_movi_tl(mem_idx, ctx->mem_idx);
-    tcg_gen_movi_tl(memop, MO_TEUW);
+    gen_helper_hyp_access_check(cpu_env);
 
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
@@ -152,20 +131,16 @@ static bool trans_hsv_b(DisasContext *ctx, arg_hsv_b *a)
 #ifndef CONFIG_USER_ONLY
     TCGv t0 = tcg_temp_new();
     TCGv dat = tcg_temp_new();
-    TCGv mem_idx = tcg_temp_new();
-    TCGv memop = tcg_temp_new();
+
+    gen_helper_hyp_access_check(cpu_env);
 
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
@@ -178,20 +153,16 @@ static bool trans_hsv_h(DisasContext *ctx, arg_hsv_h *a)
 #ifndef CONFIG_USER_ONLY
     TCGv t0 = tcg_temp_new();
     TCGv dat = tcg_temp_new();
-    TCGv mem_idx = tcg_temp_new();
-    TCGv memop = tcg_temp_new();
+
+    gen_helper_hyp_access_check(cpu_env);
 
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
@@ -204,20 +175,16 @@ static bool trans_hsv_w(DisasContext *ctx, arg_hsv_w *a)
 #ifndef CONFIG_USER_ONLY
     TCGv t0 = tcg_temp_new();
     TCGv dat = tcg_temp_new();
-    TCGv mem_idx = tcg_temp_new();
-    TCGv memop = tcg_temp_new();
+
+    gen_helper_hyp_access_check(cpu_env);
 
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
@@ -231,20 +198,16 @@ static bool trans_hlv_wu(DisasContext *ctx, arg_hlv_wu *a)
 #ifndef CONFIG_USER_ONLY
     TCGv t0 = tcg_temp_new();
     TCGv t1 = tcg_temp_new();
-    TCGv mem_idx = tcg_temp_new();
-    TCGv memop = tcg_temp_new();
+
+    gen_helper_hyp_access_check(cpu_env);
 
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
@@ -257,20 +220,16 @@ static bool trans_hlv_d(DisasContext *ctx, arg_hlv_d *a)
 #ifndef CONFIG_USER_ONLY
     TCGv t0 = tcg_temp_new();
     TCGv t1 = tcg_temp_new();
-    TCGv mem_idx = tcg_temp_new();
-    TCGv memop = tcg_temp_new();
+
+    gen_helper_hyp_access_check(cpu_env);
 
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
@@ -283,20 +242,16 @@ static bool trans_hsv_d(DisasContext *ctx, arg_hsv_d *a)
 #ifndef CONFIG_USER_ONLY
     TCGv t0 = tcg_temp_new();
     TCGv dat = tcg_temp_new();
-    TCGv mem_idx = tcg_temp_new();
-    TCGv memop = tcg_temp_new();
+
+    gen_helper_hyp_access_check(cpu_env);
 
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



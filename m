Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F056DC4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 15:59:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3125621D47
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 15:59:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="RETUlIjd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3125621D47
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVzTA-0004Jb-4p
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 11:59:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35222)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=558518344=alistair.francis@wdc.com>)
 id 1kVz8M-0000IW-1T; Fri, 23 Oct 2020 11:37:38 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:38938)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=558518344=alistair.francis@wdc.com>)
 id 1kVz8I-0002qw-Cr; Fri, 23 Oct 2020 11:37:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1603467454; x=1635003454;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Sw2WvvMyUvkTM2H8wUUSAVVkRHlCoyKcGz/Cqub7o08=;
 b=RETUlIjdkrDend+APyhy6VByJDpjREHnzvQYR/KU7q3y3mHbQy4Rx1bV
 5Hjsob9ARESv8HvZkhiHEM/kuF2fWkSTYVT9WwfZDr/9VNjm63Q+bzhF6
 HOWlM/Idbe8lz8E58vIC8x+m/8j3eTZTSlGZqALhdHtct6ifh9o5k0tpR
 2Yb0Kjlge9gXHG/zlS6oALxyb2UaA9a98QJual9SFLRmwxI1uP3y1WWjh
 jpstW0RQ9cncByKZlkCRG8ydOqKGCPStfEq+dmT7WTZpIMnoe22ARGAYR
 qXJd2uY4qwf/SF8+PFgSgwP8y6TG5WsIH2/QCsGWghAvzwhM47nEEguBD Q==;
IronPort-SDR: BT9135chvvcBujuW5ChbpeEdEcIiOJkkJR+OGif05ZyLUjEJKUgX/sBxZKmAgoLFiHqOlI9oNZ
 IPJimreVFIoY6dEdkPoD+MiHh+VBgsOzOORNJSsGEOfeRcF7aODgIuKQwAbFCmaIRuPbRWDdn6
 8lz/lP/IaFjWq/2zxz6QAGpx1oTphgeKs8whYPQ4e+5eF3gW3fXVRM8A/fpDUrHH1CcKTZ+Xtg
 WQ3xiXYW8goqgpZnn55FUbStS/mE4fTH4eQYLnfy5ETsmZCadbf8Jaut0NsYWjUUKI+NRicJDM
 OV0=
X-IronPort-AV: E=Sophos;i="5.77,408,1596470400"; d="scan'208";a="260636279"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 23 Oct 2020 23:37:31 +0800
IronPort-SDR: kkea90N4W+8JQHU/J69VoEVMKVkUY7U80uTkQ0WOAHXOYATxmzArLMYoxQhnKTL9ClKsVRUcAH
 i1KIuu9NDS+GN8iRWL6H/zPYbRpREFUAwJZ72i6bcFoAfXgGgZCwcIYD09TRDv1nAwqd8DkWmW
 JHyLHXogEtaNF96IuCue9oruDLPc5Xn3bWvpsniMaifAtiOmn8bHJC/6urlDbuv/ndXdIug3aP
 zFc1sbFlVdrEzM7UgRxgj/cK71HeAy/02VfSIEMnxthSTlALpecrcxp3TsLsf8swHAVcvO5vtr
 FbOsaR72PCfg9F39jaYOAVGt
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2020 08:23:53 -0700
IronPort-SDR: evh9wMZ50kH5BN6mqjv/DZqfcteo6/7JSbAHDBpKNoJ4XN+OF1OHFs8Pgf5+5/LxnEsrQgnxr7
 Hzq7UIOKGHtr+9vlc36tTDXZEywuhK83OGh66oX8lhOYiNcr/GgfzoPAr1WG6UCN8RCBjgmyCn
 Dp1sx7S4uT0DVoYMg6x0IFzLSQa2gqWCVdXYM8Y0z6fdGgcyKtIMkVzcgah2xGom+MepsxgHz0
 MKHNtferLn5qvghSr0Ht9mBwlXkvBtTSTCIwXCXbxBZ4Bqq3JAny04pFtc4X7dV1ptPzr6sZYp
 Wj0=
WDCIronportException: Internal
Received: from cnf006900.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.60.46])
 by uls-op-cesaip02.wdc.com with ESMTP; 23 Oct 2020 08:37:31 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v1 4/5] target/riscv: Remove the hyp load and store functions
Date: Fri, 23 Oct 2020 08:26:10 -0700
Message-Id: <86ffdfec0896d397154ce1481417b424cb194119.1603466725.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1603466725.git.alistair.francis@wdc.com>
References: <cover.1603466725.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=558518344=alistair.francis@wdc.com;
 helo=esa1.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 11:37:20
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
index 556a23f031..95281db3ec 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -230,82 +230,12 @@ void helper_hyp_gvma_tlb_flush(CPURISCVState *env)
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



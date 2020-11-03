Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F571C2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 20:06:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9651206DC
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 20:06:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="JJ+ENXBN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9651206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ka2Zz-00028r-Sn
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 15:06:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36230)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=569a91e0c=alistair.francis@wdc.com>)
 id 1ka2Vv-0005FR-Kn; Tue, 03 Nov 2020 15:02:43 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:42884)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=569a91e0c=alistair.francis@wdc.com>)
 id 1ka2Vt-0002nd-3L; Tue, 03 Nov 2020 15:02:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1604433761; x=1635969761;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=qiMg3cmSSOlToKtci/8QICaks5E84A1dxD5K08sHebw=;
 b=JJ+ENXBNXgGDjmZONPap/+JjmIabyynSK6ZhW9G8q9ZkKr/3unT16SHJ
 DT5ey+6lG4g+dAL3+5oK/d1eO0E0YBMBOZsjS1fe8tLRbkrArS/E+bfLR
 dow+PyvwivBjkxhImIDhdHz6v+36LnTVZMsAD6tgIJLQFacxXwF/dM8NQ
 O+bF/qJZpfsp1yLKBek01fCj+rwgQpJaFC06tDl+wv/p53I3DMEJACjlw
 RyO7X+GO5uyK7ALal0wYuIjLxm9ZpqUm1An5OSB+GH15UKQngXOfIXaFk
 D2Icx9J1VYiSnr0ylVoFny38IHkoep0Oxy+dPtoDTdR/4nCOlfQffq6BY Q==;
IronPort-SDR: HZcj+k/XCnr5LJkR7X5lYxU/uz3maB7otmc0+noZCV6/917b3oBAL8BC3YrdxdUvOMvttb3JVh
 pfsnV6+LQTCEfw5WpBmj55gBTcMfBk1mLwHR7vC8Aenj5n+EGgujTjEutdUTuJUxK4+Slk3IIN
 g8JGOeNfyQ9Wu2Vm6So6zg5X0lOfSvoZbldmPcBuecFcUkzX8yqKDWYBDXcqKuDAeqqiB0Cvty
 uhR0H+OA3gRkVF6HQzLNhgiIcMisMfFSWK54HMy772+PP2Jw4kLdau+m8Rc6DG1mFlw/naoYNh
 S/E=
X-IronPort-AV: E=Sophos;i="5.77,448,1596470400"; d="scan'208";a="151793225"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 04 Nov 2020 04:02:40 +0800
IronPort-SDR: 0YWxuaelTzNkzQ+W24kjBxIrY2ApRNk+8SyMUQYW7pC2sJGLIA4ZPjw6ApUXfQb2pg6FDRcByI
 FvcJEsq8ruS+UwN2453PJ2NuD8P2ZysT+S+64ivDW2L+w1A8AAVAES7doCFdwYOylwCrZkH85k
 u95IWQkuqbOWGuv85AFreWD0wST14ToPpDAgQoA8SZUdwuCNrYuibG1zacpuj/3Nt+ykdivToD
 zdOWpBGPp15r/X8PY7GA01Wyv8SmDIeNJfpDc9BSAtY2Rlu1vXqVtQZcUVHxJsXFn1XDs8v/NZ
 1aziu2DoUyPqinVGLsQAsWOJ
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2020 11:47:38 -0800
IronPort-SDR: f+Tj+ANEz7c/cxk52c9dfE3QFwBDY/KgPXrXXGBJK+Tzb/ayJ/e2sxTUHQTFSb8tS65TwfvC1w
 RiSwJ2W/mRkOeU9aea4lNWwLkIXa7A1crtVFPxXRqh7kDkgT+d+pnZoMIckvd17JYkJ/2zcujX
 ow7FDx2taeqzvrYwZSIfkXFgriOvWrpuFK8hErWinUw82NwpHZnk++0LKlR0qD9tnfH0buGUrP
 jfQFtiEdpjTrpMQ5EglS52hoFO/MEzbsUdelCF3/9OE4yVs6syKlt/svaWVmD7t040Hyx4TzVP
 2V4=
WDCIronportException: Internal
Received: from usa003000.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.60.113])
 by uls-op-cesaip01.wdc.com with ESMTP; 03 Nov 2020 12:02:40 -0800
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v3 6/7] target/riscv: Remove the Hypervisor access check
 function
Date: Tue,  3 Nov 2020 11:51:09 -0800
Message-Id: <b379985cf25b2e46fac1377aa0c37e6a16c864d2.1604432950.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1604432950.git.alistair.francis@wdc.com>
References: <cover.1604432950.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.144;
 envelope-from=prvs=569a91e0c=alistair.francis@wdc.com;
 helo=esa5.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 14:48:57
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
Cc: richard.henderson@linaro.org, alistair.francis@wdc.com, bmeng.cn@gmail.com,
 palmer@dabbelt.com, alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Instead of using an external helper to ensure we can perform the
Hypervisor load/store instructions let's do it inline using TB_FLAGS.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h                      |  12 +++
 target/riscv/helper.h                   |   1 -
 target/riscv/op_helper.c                |  16 ----
 target/riscv/translate.c                |   2 +
 target/riscv/insn_trans/trans_rvh.c.inc | 121 +++++++++++++++++++++---
 5 files changed, 124 insertions(+), 28 deletions(-)

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
index 7dbdd117d2..ee35311052 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -81,7 +81,6 @@ DEF_HELPER_1(tlb_flush, void, env)
 #ifndef CONFIG_USER_ONLY
 DEF_HELPER_1(hyp_tlb_flush, void, env)
 DEF_HELPER_1(hyp_gvma_tlb_flush, void, env)
-DEF_HELPER_1(hyp_access_check, void, env)
 DEF_HELPER_4(hyp_x_load, tl, env, tl, tl, tl)
 #endif
 
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index d81d8282cc..980d4f39e1 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -227,22 +227,6 @@ void helper_hyp_gvma_tlb_flush(CPURISCVState *env)
     helper_hyp_tlb_flush(env);
 }
 
-void helper_hyp_access_check(CPURISCVState *env)
-{
-    if (env->priv == PRV_M ||
-        (env->priv == PRV_S && !riscv_cpu_virt_enabled(env)) ||
-        (env->priv == PRV_U && !riscv_cpu_virt_enabled(env) &&
-            get_field(env->hstatus, HSTATUS_HU))) {
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
index 79968701e9..b780ec8bc4 100644
--- a/target/riscv/insn_trans/trans_rvh.c.inc
+++ b/target/riscv/insn_trans/trans_rvh.c.inc
@@ -23,7 +23,16 @@ static bool trans_hlv_b(DisasContext *ctx, arg_hlv_b *a)
     TCGv t0 = tcg_temp_new();
     TCGv t1 = tcg_temp_new();
 
-    gen_helper_hyp_access_check(cpu_env);
+    if (!ctx->hlsx) {
+        if (ctx->virt_enabled) {
+            generate_exception(ctx, RISCV_EXCP_VIRT_INSTRUCTION_FAULT);
+        } else {
+            generate_exception(ctx, RISCV_EXCP_ILLEGAL_INST);
+        }
+        exit_tb(ctx); /* no chaining */
+        ctx->base.is_jmp = DISAS_NORETURN;
+        return false;
+    }
 
     gen_get_gpr(t0, a->rs1);
 
@@ -45,7 +54,16 @@ static bool trans_hlv_h(DisasContext *ctx, arg_hlv_h *a)
     TCGv t0 = tcg_temp_new();
     TCGv t1 = tcg_temp_new();
 
-    gen_helper_hyp_access_check(cpu_env);
+    if (!ctx->hlsx) {
+        if (ctx->virt_enabled) {
+            generate_exception(ctx, RISCV_EXCP_VIRT_INSTRUCTION_FAULT);
+        } else {
+            generate_exception(ctx, RISCV_EXCP_ILLEGAL_INST);
+        }
+        exit_tb(ctx); /* no chaining */
+        ctx->base.is_jmp = DISAS_NORETURN;
+        return false;
+    }
 
     gen_get_gpr(t0, a->rs1);
 
@@ -67,7 +85,16 @@ static bool trans_hlv_w(DisasContext *ctx, arg_hlv_w *a)
     TCGv t0 = tcg_temp_new();
     TCGv t1 = tcg_temp_new();
 
-    gen_helper_hyp_access_check(cpu_env);
+    if (!ctx->hlsx) {
+        if (ctx->virt_enabled) {
+            generate_exception(ctx, RISCV_EXCP_VIRT_INSTRUCTION_FAULT);
+        } else {
+            generate_exception(ctx, RISCV_EXCP_ILLEGAL_INST);
+        }
+        exit_tb(ctx); /* no chaining */
+        ctx->base.is_jmp = DISAS_NORETURN;
+        return false;
+    }
 
     gen_get_gpr(t0, a->rs1);
 
@@ -89,7 +116,16 @@ static bool trans_hlv_bu(DisasContext *ctx, arg_hlv_bu *a)
     TCGv t0 = tcg_temp_new();
     TCGv t1 = tcg_temp_new();
 
-    gen_helper_hyp_access_check(cpu_env);
+    if (!ctx->hlsx) {
+        if (ctx->virt_enabled) {
+            generate_exception(ctx, RISCV_EXCP_VIRT_INSTRUCTION_FAULT);
+        } else {
+            generate_exception(ctx, RISCV_EXCP_ILLEGAL_INST);
+        }
+        exit_tb(ctx); /* no chaining */
+        ctx->base.is_jmp = DISAS_NORETURN;
+        return false;
+    }
 
     gen_get_gpr(t0, a->rs1);
 
@@ -111,7 +147,16 @@ static bool trans_hlv_hu(DisasContext *ctx, arg_hlv_hu *a)
     TCGv t0 = tcg_temp_new();
     TCGv t1 = tcg_temp_new();
 
-    gen_helper_hyp_access_check(cpu_env);
+    if (!ctx->hlsx) {
+        if (ctx->virt_enabled) {
+            generate_exception(ctx, RISCV_EXCP_VIRT_INSTRUCTION_FAULT);
+        } else {
+            generate_exception(ctx, RISCV_EXCP_ILLEGAL_INST);
+        }
+        exit_tb(ctx); /* no chaining */
+        ctx->base.is_jmp = DISAS_NORETURN;
+        return false;
+    }
 
     gen_get_gpr(t0, a->rs1);
     tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx | TB_FLAGS_PRIV_HYP_ACCESS_MASK, MO_TEUW);
@@ -132,7 +177,16 @@ static bool trans_hsv_b(DisasContext *ctx, arg_hsv_b *a)
     TCGv t0 = tcg_temp_new();
     TCGv dat = tcg_temp_new();
 
-    gen_helper_hyp_access_check(cpu_env);
+    if (!ctx->hlsx) {
+        if (ctx->virt_enabled) {
+            generate_exception(ctx, RISCV_EXCP_VIRT_INSTRUCTION_FAULT);
+        } else {
+            generate_exception(ctx, RISCV_EXCP_ILLEGAL_INST);
+        }
+        exit_tb(ctx); /* no chaining */
+        ctx->base.is_jmp = DISAS_NORETURN;
+        return false;
+    }
 
     gen_get_gpr(t0, a->rs1);
     gen_get_gpr(dat, a->rs2);
@@ -154,7 +208,16 @@ static bool trans_hsv_h(DisasContext *ctx, arg_hsv_h *a)
     TCGv t0 = tcg_temp_new();
     TCGv dat = tcg_temp_new();
 
-    gen_helper_hyp_access_check(cpu_env);
+    if (!ctx->hlsx) {
+        if (ctx->virt_enabled) {
+            generate_exception(ctx, RISCV_EXCP_VIRT_INSTRUCTION_FAULT);
+        } else {
+            generate_exception(ctx, RISCV_EXCP_ILLEGAL_INST);
+        }
+        exit_tb(ctx); /* no chaining */
+        ctx->base.is_jmp = DISAS_NORETURN;
+        return false;
+    }
 
     gen_get_gpr(t0, a->rs1);
     gen_get_gpr(dat, a->rs2);
@@ -176,7 +239,16 @@ static bool trans_hsv_w(DisasContext *ctx, arg_hsv_w *a)
     TCGv t0 = tcg_temp_new();
     TCGv dat = tcg_temp_new();
 
-    gen_helper_hyp_access_check(cpu_env);
+    if (!ctx->hlsx) {
+        if (ctx->virt_enabled) {
+            generate_exception(ctx, RISCV_EXCP_VIRT_INSTRUCTION_FAULT);
+        } else {
+            generate_exception(ctx, RISCV_EXCP_ILLEGAL_INST);
+        }
+        exit_tb(ctx); /* no chaining */
+        ctx->base.is_jmp = DISAS_NORETURN;
+        return false;
+    }
 
     gen_get_gpr(t0, a->rs1);
     gen_get_gpr(dat, a->rs2);
@@ -199,7 +271,16 @@ static bool trans_hlv_wu(DisasContext *ctx, arg_hlv_wu *a)
     TCGv t0 = tcg_temp_new();
     TCGv t1 = tcg_temp_new();
 
-    gen_helper_hyp_access_check(cpu_env);
+    if (!ctx->hlsx) {
+        if (ctx->virt_enabled) {
+            generate_exception(ctx, RISCV_EXCP_VIRT_INSTRUCTION_FAULT);
+        } else {
+            generate_exception(ctx, RISCV_EXCP_ILLEGAL_INST);
+        }
+        exit_tb(ctx); /* no chaining */
+        ctx->base.is_jmp = DISAS_NORETURN;
+        return false;
+    }
 
     gen_get_gpr(t0, a->rs1);
 
@@ -221,7 +302,16 @@ static bool trans_hlv_d(DisasContext *ctx, arg_hlv_d *a)
     TCGv t0 = tcg_temp_new();
     TCGv t1 = tcg_temp_new();
 
-    gen_helper_hyp_access_check(cpu_env);
+    if (!ctx->hlsx) {
+        if (ctx->virt_enabled) {
+            generate_exception(ctx, RISCV_EXCP_VIRT_INSTRUCTION_FAULT);
+        } else {
+            generate_exception(ctx, RISCV_EXCP_ILLEGAL_INST);
+        }
+        exit_tb(ctx); /* no chaining */
+        ctx->base.is_jmp = DISAS_NORETURN;
+        return false;
+    }
 
     gen_get_gpr(t0, a->rs1);
 
@@ -243,7 +333,16 @@ static bool trans_hsv_d(DisasContext *ctx, arg_hsv_d *a)
     TCGv t0 = tcg_temp_new();
     TCGv dat = tcg_temp_new();
 
-    gen_helper_hyp_access_check(cpu_env);
+    if (!ctx->hlsx) {
+        if (ctx->virt_enabled) {
+            generate_exception(ctx, RISCV_EXCP_VIRT_INSTRUCTION_FAULT);
+        } else {
+            generate_exception(ctx, RISCV_EXCP_ILLEGAL_INST);
+        }
+        exit_tb(ctx); /* no chaining */
+        ctx->base.is_jmp = DISAS_NORETURN;
+        return false;
+    }
 
     gen_get_gpr(t0, a->rs1);
     gen_get_gpr(dat, a->rs2);
-- 
2.28.0



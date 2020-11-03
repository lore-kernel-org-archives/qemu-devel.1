Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5D94C2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 20:08:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34315206DF
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 20:08:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Ixn3P4af"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34315206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ka2bw-0004dm-CB
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 15:08:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36262)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=569a91e0c=alistair.francis@wdc.com>)
 id 1ka2Vy-0005NM-EQ; Tue, 03 Nov 2020 15:02:46 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:46099)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=569a91e0c=alistair.francis@wdc.com>)
 id 1ka2Vw-0002pC-Ep; Tue, 03 Nov 2020 15:02:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1604433764; x=1635969764;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=0FWs+c55/IE7tk7JOBQ1FAcsVvA1vrFYcMl1wvZJTQQ=;
 b=Ixn3P4afPkmzGHlRYjZ3rk2/UA6DR28UH13hNzlq1qyIuidRZVatar8Q
 FvorSW5meUOiO2FjPansfLCmBcBSMu6d3CkLpiafLOH9Tg8AOrRcVcKpj
 cR6r0z5kOQoPQsKrkTfm02uvaJxgQYjgBEvO7pFI7heViB7ZZWDbvsqYT
 ND+FkLJQl3p2gF4hxY8Qs3BeBKq+o3pfo46ayHJAZgeSiyyB5672eeewE
 HwZHMJUUCUm9eRzAlHGqEuCALhbuSvK6bkcJBisU3KWnaTiWNa4zUDTMV
 8vWyp+eNzXqUvUmpkDoRgrIbJ1omJsSkd8IjDe5BHVB3xMqZZ2qhezB6V A==;
IronPort-SDR: gMjpRD+76INuIGxc35ypaRfqsw/XSosgl1BLT/xfARoCvPiWEZyAUcZq1l+sQ2uBO0U+UazcwF
 3GV+rsgPGELNJQo4BnapV4s9KzFJ61FsRW7XjefRiPTSfCwSgObhQjr3FRS3sAEp/LQZd06VPt
 dBJlowA5CG68d1c/h38hCOO/+NRxwMJQQ5fby41wGxlLLP3wcjWLUuz+sG/603IDGzdJioP2A+
 2FdcWu7w1py55iT0/wrq2gRthwJREI3cCZ5hX2V53yP+pq4GrIltZ4SInaaQGyWDsbBf1+Lwmz
 J/0=
X-IronPort-AV: E=Sophos;i="5.77,448,1596470400"; d="scan'208";a="152912259"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 04 Nov 2020 04:02:42 +0800
IronPort-SDR: ggG30akx2UbE/uMV+b34UmTM8bBPa98hvMfPBphpUIzU4CNar0R4Zf97zjQTxSZpkqNJ96W3l/
 VgfNkw+2mVXPENhpOWpkdskddbv8gyUWh2T/eQcfD7Ma2uj+LfBqt291np4BgjXgvg1k6tRRdz
 gP6VfO6hYAlk2BAb9mYj56xMnRH0XEbbArs8sdAj6DjtkUFHBuuvlBeHmWjOTxvQSTaZQFRoW5
 2JFYHjWAvSqRJTHsXCptdT8eyfUy1L/hge9W6MZtRd4bEdsPnzAoeqtcs/mHlva4AecK/m0Rna
 7OBr7WEVh2f6zg12jMKC58cq
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2020 11:48:51 -0800
IronPort-SDR: 53VUA+eiwg3RLhloJeoIfRuDLCVWsO2RLajY2DxTd04eMbxLeyN5F8mQhf4l94VM9tS+2ivlvt
 a3qJTUtkAps4oimDayXLqaJ/99yw8A46XNeAx2oKhkEH8EqBwQ+jIdym/wngr2r6Z/hNvfXGF6
 HOUjBQkpl24xELfqZRzo1jfGyE8HHAekyOkwRS7JCJsb7LGWZkiEwlmEGR7ZPwHwkCpjPpQJ3G
 xPFoigbw1GDcbdo7YTVM3zuxigRyld1CKmPC/arI/WTS/Km4V6dE+hAWZkn6YROrVa699tqwhr
 hwg=
WDCIronportException: Internal
Received: from usa003000.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.60.113])
 by uls-op-cesaip02.wdc.com with ESMTP; 03 Nov 2020 12:02:43 -0800
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v3 7/7] target/riscv: Split the Hypervisor execute load helpers
Date: Tue,  3 Nov 2020 11:51:12 -0800
Message-Id: <078c49d9759ef845affe35ee690cb4242e511429.1604432950.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1604432950.git.alistair.francis@wdc.com>
References: <cover.1604432950.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.45;
 envelope-from=prvs=569a91e0c=alistair.francis@wdc.com;
 helo=esa6.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 15:02:42
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

Split the hypervisor execute load functions into two seperate functions.
This avoids us having to pass the memop to the C helper functions.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/helper.h                   |  3 +-
 target/riscv/op_helper.c                | 36 ++++++-----------------
 target/riscv/insn_trans/trans_rvh.c.inc | 38 ++++++++++++++++---------
 3 files changed, 35 insertions(+), 42 deletions(-)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index ee35311052..939731c345 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -81,7 +81,8 @@ DEF_HELPER_1(tlb_flush, void, env)
 #ifndef CONFIG_USER_ONLY
 DEF_HELPER_1(hyp_tlb_flush, void, env)
 DEF_HELPER_1(hyp_gvma_tlb_flush, void, env)
-DEF_HELPER_4(hyp_x_load, tl, env, tl, tl, tl)
+DEF_HELPER_2(hyp_hlvx_hu, tl, env, tl)
+DEF_HELPER_2(hyp_hlvx_wu, tl, env, tl)
 #endif
 
 /* Vector functions */
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 980d4f39e1..d55def76cf 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -227,36 +227,18 @@ void helper_hyp_gvma_tlb_flush(CPURISCVState *env)
     helper_hyp_tlb_flush(env);
 }
 
-target_ulong helper_hyp_x_load(CPURISCVState *env, target_ulong address,
-                               target_ulong attrs, target_ulong memop)
+target_ulong helper_hyp_hlvx_hu(CPURISCVState *env, target_ulong address)
 {
-    if (env->priv == PRV_M ||
-        (env->priv == PRV_S && !riscv_cpu_virt_enabled(env)) ||
-        (env->priv == PRV_U && !riscv_cpu_virt_enabled(env) &&
-            get_field(env->hstatus, HSTATUS_HU))) {
-        target_ulong pte;
-        int mmu_idx = cpu_mmu_index(env, false) | TB_FLAGS_PRIV_HYP_ACCESS_MASK;
-
-        switch (memop) {
-        case MO_TEUW:
-            pte = cpu_lduw_mmuidx_ra(env, address, mmu_idx, GETPC());
-            break;
-        case MO_TEUL:
-            pte = cpu_ldl_mmuidx_ra(env, address, mmu_idx, GETPC());
-            break;
-        default:
-            g_assert_not_reached();
-        }
+    int mmu_idx = cpu_mmu_index(env, true) | TB_FLAGS_PRIV_HYP_ACCESS_MASK;
 
-        return pte;
-    }
+    return cpu_lduw_mmuidx_ra(env, address, mmu_idx, GETPC());
+}
 
-    if (riscv_cpu_virt_enabled(env)) {
-        riscv_raise_exception(env, RISCV_EXCP_VIRT_INSTRUCTION_FAULT, GETPC());
-    } else {
-        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
-    }
-    return 0;
+target_ulong helper_hyp_hlvx_wu(CPURISCVState *env, target_ulong address)
+{
+    int mmu_idx = cpu_mmu_index(env, true) | TB_FLAGS_PRIV_HYP_ACCESS_MASK;
+
+    return cpu_ldl_mmuidx_ra(env, address, mmu_idx, GETPC());
 }
 
 #endif /* !CONFIG_USER_ONLY */
diff --git a/target/riscv/insn_trans/trans_rvh.c.inc b/target/riscv/insn_trans/trans_rvh.c.inc
index b780ec8bc4..7c49562d6a 100644
--- a/target/riscv/insn_trans/trans_rvh.c.inc
+++ b/target/riscv/insn_trans/trans_rvh.c.inc
@@ -364,20 +364,25 @@ static bool trans_hlvx_hu(DisasContext *ctx, arg_hlvx_hu *a)
 #ifndef CONFIG_USER_ONLY
     TCGv t0 = tcg_temp_new();
     TCGv t1 = tcg_temp_new();
-    TCGv mem_idx = tcg_temp_new();
-    TCGv memop = tcg_temp_new();
+
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
-    tcg_gen_movi_tl(mem_idx, ctx->mem_idx);
-    tcg_gen_movi_tl(memop, MO_TEUW);
 
-    gen_helper_hyp_x_load(t1, cpu_env, t0, mem_idx, memop);
+    gen_helper_hyp_hlvx_hu(t1, cpu_env, t0);
     gen_set_gpr(a->rd, t1);
 
     tcg_temp_free(t0);
     tcg_temp_free(t1);
-    tcg_temp_free(mem_idx);
-    tcg_temp_free(memop);
     return true;
 #else
     return false;
@@ -390,20 +395,25 @@ static bool trans_hlvx_wu(DisasContext *ctx, arg_hlvx_wu *a)
 #ifndef CONFIG_USER_ONLY
     TCGv t0 = tcg_temp_new();
     TCGv t1 = tcg_temp_new();
-    TCGv mem_idx = tcg_temp_new();
-    TCGv memop = tcg_temp_new();
+
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
-    tcg_gen_movi_tl(mem_idx, ctx->mem_idx);
-    tcg_gen_movi_tl(memop, MO_TEUL);
 
-    gen_helper_hyp_x_load(t1, cpu_env, t0, mem_idx, memop);
+    gen_helper_hyp_hlvx_wu(t1, cpu_env, t0);
     gen_set_gpr(a->rd, t1);
 
     tcg_temp_free(t0);
     tcg_temp_free(t1);
-    tcg_temp_free(mem_idx);
-    tcg_temp_free(memop);
     return true;
 #else
     return false;
-- 
2.28.0



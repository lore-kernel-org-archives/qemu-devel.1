Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A936C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 16:17:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85FE02192A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 16:17:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="aI/4embr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85FE02192A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57308 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVzki-0003mq-Bc
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 12:17:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35240)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=558518344=alistair.francis@wdc.com>)
 id 1kVz8N-0000MG-Lu; Fri, 23 Oct 2020 11:37:40 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:38922)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=558518344=alistair.francis@wdc.com>)
 id 1kVz8K-0002ph-6k; Fri, 23 Oct 2020 11:37:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1603467455; x=1635003455;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=JsNotCWqPXtMQJDMNM26RihKvw3OoLKQuyN0cv5sLG8=;
 b=aI/4embrgNRVvBa4ojH4isHunvqNNnj4EAviP14iVpARWIQy2276nHQ/
 IO/a03BaZl4DYlZxfsUuOBionRqHe0L9NKfymEoL4sSCnqFGu4Xyzxrfw
 J8BagRQNU9kMvnb66juvqSsax8By01gBJ0bsi/YUYLNae9OBR/z/oQ66U
 qbBDrDAgjYg4th3VgHZZ2xsDGl5BeJiHTgilDLhRZFa42sjcXaR1RsgXU
 F+LIadBB6z+T2jVypyQoSzMVI35c3aYgUrxwsOylSk5ivOz6hn7z/SfEl
 rKRL32zlbjROeHADnepk+XO+ttGebePQOKUdz2jBH1MDaXEUi+1441o2+ w==;
IronPort-SDR: F9cW3A5GhgHSPSnTE9SXiCai4jSzH0A8MXaZQvekV8T/XQzBFMY+BlYiWo0TH01+p5UVPaLSS6
 E8Q4zw6OF3XvOWq9L34csxBpdRqlwZsKIo2XMsmr2WLOoX93qoCVeD0hhZVPi3l3kEGOZLJSyq
 BvacW8H0w00tzfRchpgUFgnwUb5wycKIF75mq7UNuVYXaysfqM54qI2ILWU9OH6Fy+vZzaGNd2
 PMGLFbUqQ7dHuKLjTWjboZdCs5bhUuSkpnDB4c8PH5lgxayjuWkthEWv4El+ctY8B4QrtjFE8i
 9+w=
X-IronPort-AV: E=Sophos;i="5.77,408,1596470400"; d="scan'208";a="260636284"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 23 Oct 2020 23:37:33 +0800
IronPort-SDR: 57ls42kE9sR7HTXaKorJXBclfpOz2fCLH0sDMSwXva5eMzK9HqeEID8VUgCmpePthKtYdBA1Nr
 0iTmy7Eolm5ZfKaVjRs4wZVLv1c/vxYyDG/QS14/IzaNYOiQ3EyiFF3O5bi/ptdU2Lk8dlEa/v
 2ojF5xbAxOGRY4gtXyAdE+bWL5/O9qCshxMmLQmJZ2Ef1qN1ra84T6bxdZUOd3fQT2SCvWciji
 i8J1vSAf15NHvDIRwbjLO7IRwEXUeRpBzaLqOfDLfzDMC90E/3jHz9CFS4bC4+x21wRfsa7z45
 T+lkquuGp0yBcRyli6FzRv59
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2020 08:23:56 -0700
IronPort-SDR: oU2wtARq1RddWBFXtDA2OPRyAOXHq2ihqRC4UgEhQROnXM2boXaZeS18aRXfb6UhEe3LnZ7HQC
 WwIvy2BmaAQEoRXd5PctQ1GqWfX55uGO4BYE7OAOV9jcH0m1ub1TUeEq5e04n6JTRH7GgQ4/hD
 ZEhX0mDTaTRrt9gyzYdqdvmG3UBW8s716x0gTSXnzbLuSZFW6LCnP/y7bBxAmUdein85k7Mkte
 1cQy76l8HBko15JS2WeVxle2mspk0KGkxRJVHukkIvhSIZtiXN5Co8rJMPOMfEi+noXdWKI5Bg
 Xk8=
WDCIronportException: Internal
Received: from cnf006900.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.60.46])
 by uls-op-cesaip02.wdc.com with ESMTP; 23 Oct 2020 08:37:34 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v1 5/5] target/riscv: Split the Hypervisor execute load helpers
Date: Fri, 23 Oct 2020 08:26:13 -0700
Message-Id: <0baa57b4d690d5022bbfe488b93d1a7e552ae7a1.1603466725.git.alistair.francis@wdc.com>
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

Split the hypervisor execute load functions into two seperate functions.
This avoids us having to pass the memop to the C helper functions.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/helper.h                   |  3 +-
 target/riscv/op_helper.c                | 38 ++++++++++++++-----------
 target/riscv/insn_trans/trans_rvh.c.inc | 16 ++---------
 3 files changed, 26 insertions(+), 31 deletions(-)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 7dbdd117d2..ae50730273 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -82,7 +82,8 @@ DEF_HELPER_1(tlb_flush, void, env)
 DEF_HELPER_1(hyp_tlb_flush, void, env)
 DEF_HELPER_1(hyp_gvma_tlb_flush, void, env)
 DEF_HELPER_1(hyp_access_check, void, env)
-DEF_HELPER_4(hyp_x_load, tl, env, tl, tl, tl)
+DEF_HELPER_2(hyp_hlvx_hu, tl, env, tl)
+DEF_HELPER_2(hyp_hlvx_wu, tl, env, tl)
 #endif
 
 /* Vector functions */
diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
index 95281db3ec..065aa57d97 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -246,28 +246,34 @@ void helper_hyp_access_check(CPURISCVState *env)
     }
 }
 
-target_ulong helper_hyp_x_load(CPURISCVState *env, target_ulong address,
-                               target_ulong attrs, target_ulong memop)
+target_ulong helper_hyp_hlvx_hu(CPURISCVState *env, target_ulong address)
 {
     if (env->priv == PRV_M ||
         (env->priv == PRV_S && !riscv_cpu_virt_enabled(env)) ||
         (env->priv == PRV_U && !riscv_cpu_virt_enabled(env) &&
             get_field(env->hstatus, HSTATUS_HU))) {
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
+        int mmu_idx = cpu_mmu_index(env, true) | TB_FLAGS_PRIV_HYP_ACCESS_MASK;
+
+        return cpu_lduw_mmuidx_ra(env, address, mmu_idx, GETPC());
+    }
+
+    if (riscv_cpu_virt_enabled(env)) {
+        riscv_raise_exception(env, RISCV_EXCP_VIRT_INSTRUCTION_FAULT, GETPC());
+    } else {
+        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
+    }
+    return 0;
+}
+
+target_ulong helper_hyp_hlvx_wu(CPURISCVState *env, target_ulong address)
+{
+    if (env->priv == PRV_M ||
+        (env->priv == PRV_S && !riscv_cpu_virt_enabled(env)) ||
+        (env->priv == PRV_U && !riscv_cpu_virt_enabled(env) &&
+            get_field(env->hstatus, HSTATUS_HU))) {
+        int mmu_idx = cpu_mmu_index(env, true) | TB_FLAGS_PRIV_HYP_ACCESS_MASK;
 
-        return pte;
+        return cpu_ldl_mmuidx_ra(env, address, mmu_idx, GETPC());
     }
 
     if (riscv_cpu_virt_enabled(env)) {
diff --git a/target/riscv/insn_trans/trans_rvh.c.inc b/target/riscv/insn_trans/trans_rvh.c.inc
index 79968701e9..f3ffd742d3 100644
--- a/target/riscv/insn_trans/trans_rvh.c.inc
+++ b/target/riscv/insn_trans/trans_rvh.c.inc
@@ -265,20 +265,14 @@ static bool trans_hlvx_hu(DisasContext *ctx, arg_hlvx_hu *a)
 #ifndef CONFIG_USER_ONLY
     TCGv t0 = tcg_temp_new();
     TCGv t1 = tcg_temp_new();
-    TCGv mem_idx = tcg_temp_new();
-    TCGv memop = tcg_temp_new();
 
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
@@ -291,20 +285,14 @@ static bool trans_hlvx_wu(DisasContext *ctx, arg_hlvx_wu *a)
 #ifndef CONFIG_USER_ONLY
     TCGv t0 = tcg_temp_new();
     TCGv t1 = tcg_temp_new();
-    TCGv mem_idx = tcg_temp_new();
-    TCGv memop = tcg_temp_new();
 
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



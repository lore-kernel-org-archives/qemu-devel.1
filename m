Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 186BEC2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 05:07:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6ED4A20BED
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 05:07:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="JuyzOJai"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ED4A20BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaB1T-0004gX-1s
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 00:07:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60210)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=57073d1dd=alistair.francis@wdc.com>)
 id 1kaApC-0004ND-GZ; Tue, 03 Nov 2020 23:55:10 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:21933)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=57073d1dd=alistair.francis@wdc.com>)
 id 1kaAp9-0005nq-Dn; Tue, 03 Nov 2020 23:55:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1604466622; x=1636002622;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=3ASiHykrJWkIM9t2dOvM+UqrUoVsXYneSkga2iFI3YM=;
 b=JuyzOJaipV9EpCvV7+E1sy8x/gSq0b3iLF4DIJyAzxAq4PYhitJQy9+V
 koov6p3x33lT5dAzbY9b7hIILTEzMfSUHpeERI0x6zFCGwlwfJoI3pvwq
 LVta/AJt/1nlv90o/kkgZChaJJujDMDqHLGVhkOZqy4A/8i6hrXAtA7V2
 vWCD7Y7xIgI6bG+nYwajZP3JMLyFAYSznX7MVYtSb1ZQgV4mXPzdEI84d
 YLNbyUUDHpLugS5xnS93sivC7NTdMHoJOIE9Bks6lQMjaKKUYTVoDaSI1
 K4GH7dIFJ28wVl1FzPnpkniqLBC5IfS4UNQ2M9hQL4Go9VY9weupWbhcD Q==;
IronPort-SDR: 6j0EfC85/8rTHho+vbNPwfAmoLiHwtaGAMkEzGADzzi/GOi8Mz0F2m5C8upi/sVyyTvoPoZr/7
 ScyoMKXcuDGtbk9vH3F+EWbrKEO1PL+0d01Lq0Fv8vDrJ3CZeVIFHjGqcmJ2vwD7QQChjSyQq9
 3on+odECj7OVCyvQbLtZPXYz6xJ80t/WWEZyKVcqaMB9RXRzYO4AfxBFa1CCV7xB+sL6QC3QfZ
 0/bkc61lTTyYsrza36arPcMdydOeMvI0VqROqIZ8jVVlzxRLhEiWKaV632ut/kzPbGAYHyhUeS
 DUU=
X-IronPort-AV: E=Sophos;i="5.77,449,1596470400"; d="scan'208";a="255296321"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 04 Nov 2020 13:10:19 +0800
IronPort-SDR: 4R1GPGFhk+ZFWckMiEJwCVfcrk9/mjbiddzHHOOhdybfP/SXc6epdTcM1FdZjRfbYFnvY4EQ6t
 c//9I9SMCpihQg/ZOVh2ou8gg8nLglDIX6R8u6sa07rqjBRUSis0394wMLCzgyXbk0sUWdWoV8
 IyRafyCYO2axWntixi7R7Ff1HXuxgkMY+aCGSsliQ4+kLK1+jcEgB2ktAW6mAfVudUtTUG6rxR
 X08EmI1jIUwTpfFcrLmuEAOpdAeUN7OV2KDnOqelmmo9ckwqHKN3Y35v9zzYowzhcfYM8UJ1h9
 RbyQdptiF9Zf2HtHD+eGDNme
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2020 20:41:14 -0800
IronPort-SDR: xGdA7S243VrYTIRgWgP4n9nb4bWseJ7n2y6UbWN55vyBprJTB6VZhLE6RFcwxSkubLaN3UFgMp
 Qlr9HN0yiBIEo+4mHszvVKM/BmWF39kOTa6vQF5AkxfMsP9qkbMT1sbK3YW6w0mjfIKX5H0ToP
 tO9loUm/A8MvJoij/ZH2riaFQPFkpVKrO3wevENYbBD0/Ibpi9oEx9xtIy74pU1npgeCx8t7KF
 SDyQUl2imCAR8tJdY6QbSY4JzxtWPjg4OpzD7dzugHsc14DoHOg21v8lzXJTB6gheBR81dyk0g
 qkg=
WDCIronportException: Internal
Received: from usa003000.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.60.113])
 by uls-op-cesaip01.wdc.com with ESMTP; 03 Nov 2020 20:55:05 -0800
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v4 5/5] target/riscv: Split the Hypervisor execute load helpers
Date: Tue,  3 Nov 2020 20:43:34 -0800
Message-Id: <5b1550f0faa3c435cc77f3c1ae811dea98ab9e36.1604464950.git.alistair.francis@wdc.com>
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

Split the hypervisor execute load functions into two seperate functions.
This avoids us having to pass the memop to the C helper functions.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/helper.h                   |  3 ++-
 target/riscv/op_helper.c                | 36 +++++++------------------
 target/riscv/insn_trans/trans_rvh.c.inc | 20 +++++---------
 3 files changed, 17 insertions(+), 42 deletions(-)

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
index cc197e7186..ce7ed5affb 100644
--- a/target/riscv/insn_trans/trans_rvh.c.inc
+++ b/target/riscv/insn_trans/trans_rvh.c.inc
@@ -277,20 +277,16 @@ static bool trans_hlvx_hu(DisasContext *ctx, arg_hlvx_hu *a)
 #ifndef CONFIG_USER_ONLY
     TCGv t0 = tcg_temp_new();
     TCGv t1 = tcg_temp_new();
-    TCGv mem_idx = tcg_temp_new();
-    TCGv memop = tcg_temp_new();
+
+    check_access(ctx);
 
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
@@ -303,20 +299,16 @@ static bool trans_hlvx_wu(DisasContext *ctx, arg_hlvx_wu *a)
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



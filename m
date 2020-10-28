Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED2DC388F7
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 14:58:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 246F724724
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 14:58:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="dalxqAwh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 246F724724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXmuS-0007Sd-4t
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 10:58:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38590)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=563b96974=alistair.francis@wdc.com>)
 id 1kXmps-00027m-9a; Wed, 28 Oct 2020 10:54:00 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:10516)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=563b96974=alistair.francis@wdc.com>)
 id 1kXmpq-00036U-4d; Wed, 28 Oct 2020 10:53:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1603896838; x=1635432838;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=KntYN7zGHoqvB6l1jjDFFz/dW+GlIx3yJAuj7ZeGIxQ=;
 b=dalxqAwhFAG1Kib+VgIcE29h99CfuM3J7kBei1gC4RIB3IkFm7cAaoOQ
 LTKu8gOs/SezrYajCEkX30JD24n83jRNDDKbodezJYs0t5UPaf/yPNIg/
 e5ZmtpP7KANMiEWxUTpXwRTYzNOjsmyzu0lF60aeX7Z3f9qOEWjyLPAlp
 wjyCofnwjm2BCHYtmfydKn1UlfgeuB95z5sL9FrvWXbUO6rnnBAXNvyC8
 +GyszDj+xo/EdIAQzZzCd5FKQnm3Ufy99IZSitSUT7parsimEZ6vFR5py
 713XCZRU53xs5/W7CRq0B55416pmk7y3HA3qtxE4rBnFwOlerY1xDwwP+ A==;
IronPort-SDR: Vs5vlnNIsUCbGdPBeRL6Mh5ZSEDtzbz3sCmy24ZbAlwEapxlbE9BomClHbQFB/AZuku3+oXlgB
 bbPAytBYvWbWNUFeMGQh/509zAV/cj5MLTCJLAmB1Jq50HQ8BuVJRyNdvZWr6F7hhhZpNYKFif
 hPXkKxoW5LO6Pu/PreFtWPWZpPzt/c6YVi6RRsAIU4kDgvJcqY8KFQ0pzoO+1ztM5H9kI68fxX
 i/Z71uJ7pb8og+mx8hM20ffgNgid8YUBeejA9twOpg+gnR/PLyVDpjItv/g0KbdQr+ZKFEM2GQ
 OE8=
X-IronPort-AV: E=Sophos;i="5.77,426,1596470400"; d="scan'208";a="151200426"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 28 Oct 2020 22:53:56 +0800
IronPort-SDR: GjHRHJtWv/aNblOWAAIZwAIHILKVr6qLaTnFP7KXh4JXW/jPvqjwABnT/GHvuX4Lz2/ctQGrpe
 +3PEJ1XEmnMebapUcGzgfxnmPowMV1gbCgmibZZSMpb4TbsNFgsVF+nnt9eWYG6lfZ5IHZANtW
 C00PW3drAAGGjsel7FIOR8aU+ZCQDvP27P6QibWGzAAyskjqq5/OnCsIsA1lwylS9DlpAWfGgT
 gEDZ3iCWB9HH0JumFHrzOjscWdWP736sIQ4cfmHc+2uq8jcH1wCwM5gNqKOXwI86hM+AuBkyRd
 ID12WWjdRjDc161kwRtMd9Tf
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2020 07:39:06 -0700
IronPort-SDR: gussgivtZe/vtadAsAVF0pj2KSg1IdV79cpfJ/vwDgMB51aQ1/guWDJDLj5DJ/lqJctgkI9yg/
 btmfxKAqsnPwy6LASwc4Gf7+f52bX52EpTzlcnh6ruAUhCnBjOOm2Wf7VFQuWE8HPrMuBjLjXT
 grb9AdrOBsVpzjY6YF95yyREKc1IdLhZrT/g8FkAUrhfTRdEeUu4N/hP73WN4vfLZTrGiWcqQZ
 Enz5SpTjRq0xn7TKDOSKz6uEJcXem2SktaTi0jnQQoYh453xcN+QKEGtyT6zlSe5pWjo6RGXq0
 Xt4=
WDCIronportException: Internal
Received: from usa003000.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.60.131])
 by uls-op-cesaip02.wdc.com with ESMTP; 28 Oct 2020 07:53:57 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v2 5/5] target/riscv: Split the Hypervisor execute load helpers
Date: Wed, 28 Oct 2020 07:42:31 -0700
Message-Id: <a88d9bdcebe49ada0d0a69b37ac532124971c91c.1603896076.git.alistair.francis@wdc.com>
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
index d81d8282cc..ff4426cf4d 100644
--- a/target/riscv/op_helper.c
+++ b/target/riscv/op_helper.c
@@ -243,28 +243,34 @@ void helper_hyp_access_check(CPURISCVState *env)
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



Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB54CC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 15:22:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A57A207DA
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 15:22:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="AxVd1rUA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A57A207DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6bXC-0007yc-P6
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 11:22:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51698)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4887bfbec=alistair.francis@wdc.com>)
 id 1k6bQS-0003e8-Fx
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 11:15:24 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:55665)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4887bfbec=alistair.francis@wdc.com>)
 id 1k6bQQ-0007bQ-CH
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 11:15:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1597418123; x=1628954123;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=bS/x/2k+Xp6SqEpT+yZi1E8PzCi+JO9pFNGq4PWFuug=;
 b=AxVd1rUAramrgwMIRI36EvxY9cq4M5Z3Wz0RktEj6gHQW4RWxh/KcEko
 vLNk2DNXSYHD9gACJiNgKnGFkPZpzmeec9tjK/BrSRLwSj++MCKi+TFXV
 qcGXyH1ieqFy/FwGYUo8k0XAFPhsxy50UGHN98JRfSwbBSn/smSmN0fs2
 qTB/ROpca6NF59F2w2ZEE+UTEfEq48GFiiCvqekB844bvFYL6E/Pumpui
 y3+c34uPYkBFXNaLmfWJd3JpTviQ75chslOJzNZUHLyxeueDttTTqv9id
 bczM9wENveSxrWaMch9HpB/ZTK1wuPXyeKIitVlOk+YSmInsRIcyRXSE3 w==;
IronPort-SDR: MReZ5FJQ9J5rgYb3dOYX0jhrXNCxGGmVKSAhyZJQe+dIeSkVEnTRuUGowm6bUB0AMmIX2JOMKx
 JADKJDy/zE4F+6+Sa1YuW7bNtMMpSuT9m7t95HuN9D/r9Ioq3D0W6DFDmPeV39bVQRK8ivp40s
 muizXotdqpISyZCftTs0CxKB6kftc0KZEnW+wbiss0z8gQX1yg1uxB2nJcXtr5NqGAqqj03vl/
 UnzIhM0G9CzFn0ZCRMKcqViIv9KesIK9sEKhrTxFpTwwu6RucVLrKztuI0CaByrT0F/3Qq75Rz
 aHA=
X-IronPort-AV: E=Sophos;i="5.76,312,1592841600"; d="scan'208";a="144994818"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 14 Aug 2020 23:15:13 +0800
IronPort-SDR: EdoE3FP3qbZtfDnPP+YyqyR+ygUkiwNBAhrzGfxvQajxYOsW+NehCiTSqo2n78xf/UwiJKkVn9
 Whga0H3gi0Zw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Aug 2020 08:02:17 -0700
IronPort-SDR: rMjl+EhWH7H5lDzrpocaKywtKgsWIl24uHM0D8zPuSzeyEQLAOgGB2DnwieYUKirrfY9TdMuDb
 ThYRvUJNa+7w==
WDCIronportException: Internal
Received: from jbfyk72.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.59.14])
 by uls-op-cesaip02.wdc.com with ESMTP; 14 Aug 2020 08:15:12 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 05/20] target/riscv: Check nanboxed inputs in trans_rvf.inc.c
Date: Fri, 14 Aug 2020 08:04:51 -0700
Message-Id: <20200814150506.2070566-6-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200814150506.2070566-1-alistair.francis@wdc.com>
References: <20200814150506.2070566-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.144;
 envelope-from=prvs=4887bfbec=alistair.francis@wdc.com;
 helo=esa5.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/14 11:15:11
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 LIU Zhiwei <zhiwei_liu@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

If a 32-bit input is not properly nanboxed, then the input is replaced
with the default qnan.  The only inline expansion is for the sign-changing
set of instructions: FSGNJ.S, FSGNJX.S, FSGNJN.S.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
Message-Id: <20200724002807.441147-6-richard.henderson@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/insn_trans/trans_rvf.inc.c | 71 +++++++++++++++++++------
 target/riscv/translate.c                | 18 +++++++
 2 files changed, 73 insertions(+), 16 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvf.inc.c b/target/riscv/insn_trans/trans_rvf.inc.c
index 264d3139f1..832f01db6f 100644
--- a/target/riscv/insn_trans/trans_rvf.inc.c
+++ b/target/riscv/insn_trans/trans_rvf.inc.c
@@ -161,47 +161,86 @@ static bool trans_fsgnj_s(DisasContext *ctx, arg_fsgnj_s *a)
 {
     REQUIRE_FPU;
     REQUIRE_EXT(ctx, RVF);
+
     if (a->rs1 == a->rs2) { /* FMOV */
-        tcg_gen_mov_i64(cpu_fpr[a->rd], cpu_fpr[a->rs1]);
+        gen_check_nanbox_s(cpu_fpr[a->rd], cpu_fpr[a->rs1]);
     } else { /* FSGNJ */
-        tcg_gen_deposit_i64(cpu_fpr[a->rd], cpu_fpr[a->rs2], cpu_fpr[a->rs1],
-                            0, 31);
+        TCGv_i64 rs1 = tcg_temp_new_i64();
+        TCGv_i64 rs2 = tcg_temp_new_i64();
+
+        gen_check_nanbox_s(rs1, cpu_fpr[a->rs1]);
+        gen_check_nanbox_s(rs2, cpu_fpr[a->rs2]);
+
+        /* This formulation retains the nanboxing of rs2. */
+        tcg_gen_deposit_i64(cpu_fpr[a->rd], rs2, rs1, 0, 31);
+        tcg_temp_free_i64(rs1);
+        tcg_temp_free_i64(rs2);
     }
-    gen_nanbox_s(cpu_fpr[a->rd], cpu_fpr[a->rd]);
     mark_fs_dirty(ctx);
     return true;
 }
 
 static bool trans_fsgnjn_s(DisasContext *ctx, arg_fsgnjn_s *a)
 {
+    TCGv_i64 rs1, rs2, mask;
+
     REQUIRE_FPU;
     REQUIRE_EXT(ctx, RVF);
+
+    rs1 = tcg_temp_new_i64();
+    gen_check_nanbox_s(rs1, cpu_fpr[a->rs1]);
+
     if (a->rs1 == a->rs2) { /* FNEG */
-        tcg_gen_xori_i64(cpu_fpr[a->rd], cpu_fpr[a->rs1], INT32_MIN);
+        tcg_gen_xori_i64(cpu_fpr[a->rd], rs1, MAKE_64BIT_MASK(31, 1));
     } else {
-        TCGv_i64 t0 = tcg_temp_new_i64();
-        tcg_gen_not_i64(t0, cpu_fpr[a->rs2]);
-        tcg_gen_deposit_i64(cpu_fpr[a->rd], t0, cpu_fpr[a->rs1], 0, 31);
-        tcg_temp_free_i64(t0);
+        rs2 = tcg_temp_new_i64();
+        gen_check_nanbox_s(rs2, cpu_fpr[a->rs2]);
+
+        /*
+         * Replace bit 31 in rs1 with inverse in rs2.
+         * This formulation retains the nanboxing of rs1.
+         */
+        mask = tcg_const_i64(~MAKE_64BIT_MASK(31, 1));
+        tcg_gen_nor_i64(rs2, rs2, mask);
+        tcg_gen_and_i64(rs1, mask, rs1);
+        tcg_gen_or_i64(cpu_fpr[a->rd], rs1, rs2);
+
+        tcg_temp_free_i64(mask);
+        tcg_temp_free_i64(rs2);
     }
-    gen_nanbox_s(cpu_fpr[a->rd], cpu_fpr[a->rd]);
+    tcg_temp_free_i64(rs1);
+
     mark_fs_dirty(ctx);
     return true;
 }
 
 static bool trans_fsgnjx_s(DisasContext *ctx, arg_fsgnjx_s *a)
 {
+    TCGv_i64 rs1, rs2;
+
     REQUIRE_FPU;
     REQUIRE_EXT(ctx, RVF);
+
+    rs1 = tcg_temp_new_i64();
+    gen_check_nanbox_s(rs1, cpu_fpr[a->rs1]);
+
     if (a->rs1 == a->rs2) { /* FABS */
-        tcg_gen_andi_i64(cpu_fpr[a->rd], cpu_fpr[a->rs1], ~INT32_MIN);
+        tcg_gen_andi_i64(cpu_fpr[a->rd], rs1, ~MAKE_64BIT_MASK(31, 1));
     } else {
-        TCGv_i64 t0 = tcg_temp_new_i64();
-        tcg_gen_andi_i64(t0, cpu_fpr[a->rs2], INT32_MIN);
-        tcg_gen_xor_i64(cpu_fpr[a->rd], cpu_fpr[a->rs1], t0);
-        tcg_temp_free_i64(t0);
+        rs2 = tcg_temp_new_i64();
+        gen_check_nanbox_s(rs2, cpu_fpr[a->rs2]);
+
+        /*
+         * Xor bit 31 in rs1 with that in rs2.
+         * This formulation retains the nanboxing of rs1.
+         */
+        tcg_gen_andi_i64(rs2, rs2, MAKE_64BIT_MASK(31, 1));
+        tcg_gen_xor_i64(cpu_fpr[a->rd], rs1, rs2);
+
+        tcg_temp_free_i64(rs2);
     }
-    gen_nanbox_s(cpu_fpr[a->rd], cpu_fpr[a->rd]);
+    tcg_temp_free_i64(rs1);
+
     mark_fs_dirty(ctx);
     return true;
 }
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 12a746da97..bf35182776 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -101,6 +101,24 @@ static void gen_nanbox_s(TCGv_i64 out, TCGv_i64 in)
     tcg_gen_ori_i64(out, in, MAKE_64BIT_MASK(32, 32));
 }
 
+/*
+ * A narrow n-bit operation, where n < FLEN, checks that input operands
+ * are correctly Nan-boxed, i.e., all upper FLEN - n bits are 1.
+ * If so, the least-significant bits of the input are used, otherwise the
+ * input value is treated as an n-bit canonical NaN (v2.2 section 9.2).
+ *
+ * Here, the result is always nan-boxed, even the canonical nan.
+ */
+static void gen_check_nanbox_s(TCGv_i64 out, TCGv_i64 in)
+{
+    TCGv_i64 t_max = tcg_const_i64(0xffffffff00000000ull);
+    TCGv_i64 t_nan = tcg_const_i64(0xffffffff7fc00000ull);
+
+    tcg_gen_movcond_i64(TCG_COND_GEU, out, in, t_max, in, t_nan);
+    tcg_temp_free_i64(t_max);
+    tcg_temp_free_i64(t_nan);
+}
+
 static void generate_exception(DisasContext *ctx, int excp)
 {
     tcg_gen_movi_tl(cpu_pc, ctx->base.pc_next);
-- 
2.27.0



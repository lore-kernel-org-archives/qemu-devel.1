Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A95F7C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 22:42:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7422F20774
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 22:42:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="n4Qy0ilD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7422F20774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5zRi-0003xg-L9
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 18:42:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39452)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=486123ee4=alistair.francis@wdc.com>)
 id 1k5zQT-0002GC-Se
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 18:40:53 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:29822)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=486123ee4=alistair.francis@wdc.com>)
 id 1k5zQR-0005nU-8v
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 18:40:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1597272051; x=1628808051;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=0hinW4AOS9dVAXrUyO3aCuRIqVjkZ84Vja4z9gCfEqI=;
 b=n4Qy0ilD8ycfkLc4NLt9wqqmgtulRLobs7RUKwMpHrLjThZYAHknnI4h
 mgRuX17DiMrqQxAQGW6Rj+vTj20mLODSKGCm5zKhowc8y3rPz/xB/naQC
 cfiE1dyARPbSanh497JATGyvWR1+LhZiHHjkqullmlI9m5sh17YyQ5XVU
 RIu3CUr+fwz9gAzi2gK89e+rrJ3DKqnhoC0Zn9YF2+g8G9ZaAFDeOVKTI
 FwcIeObpT2zybNxx47Q+r3nUnDpoF0iew6WEgsO6UzqulQ/co2l80zXd8
 lhEf2s90KS0DkmE1TsgEmbVnmdX2Oox1ZeWZAl+H3Bbi5pYKmDJ7KD7oo w==;
IronPort-SDR: VH6Ni0wrUvwvu82f7uyaLHw8bVdqcuQDkK0v+quKazAYNsdWtrIlZhY1RXs9IvSoiQyvd2amJJ
 JzQH1r3Oh7zq78bfNlyHEelde01baTSyk6hZEh07BN9y1y3P67WYudHmfoxMWzs5hzO+NSX9WR
 l6GeoaT209wdnqvqm89Edd48VCKmfWmnGKQsY6fTg7mBx0tKqain5n9DWp7y+wID6q+Mr4edmP
 aEuOEwym6i4HMglDSvWpwLvk3mQMnemftzv+DM9b70WP+2HZGVfxfT3c2hlH4YM/L8fcUJ6uhX
 SKA=
X-IronPort-AV: E=Sophos;i="5.76,305,1592841600"; d="scan'208";a="254208925"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 13 Aug 2020 06:40:48 +0800
IronPort-SDR: jBU6wrqB5pfwiML5zGi2y61hv5MxgcX2y4FHIz3+D56PnuIOhpPZebLOeTRESPSCwpTf8nfwOU
 On1yg8b3HS5A==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Aug 2020 15:27:56 -0700
IronPort-SDR: 6a2e7DP39UqrkmNW31tE8KU93iV7b2XzZkgSvFld5Xi8pUiEX6zcDzOoqMmMJTaFtF91iojoVN
 nZvui5MowPoA==
WDCIronportException: Internal
Received: from jbfyk72.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.59.14])
 by uls-op-cesaip01.wdc.com with ESMTP; 12 Aug 2020 15:40:45 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Subject: [PULL 05/20] target/riscv: Check nanboxed inputs in trans_rvf.inc.c
Date: Wed, 12 Aug 2020 15:30:30 -0700
Message-Id: <20200812223045.96803-6-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200812223045.96803-1-alistair.francis@wdc.com>
References: <20200812223045.96803-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=486123ee4=alistair.francis@wdc.com;
 helo=esa1.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/12 18:40:48
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
index 264d3139f1..f9a9e0643a 100644
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
+        tcg_gen_andc_i64(rs2, mask, rs2);
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



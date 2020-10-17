Return-Path: <SRS0=yvcL=DY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,GAPPY_SUBJECT,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FEC5C433E7
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 07:13:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC412207BC
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 07:13:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ji0W6mX2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC412207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTgPM-00049y-Sv
	for qemu-devel@archiver.kernel.org; Sat, 17 Oct 2020 03:13:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36842)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1kTgNt-0002La-Ct; Sat, 17 Oct 2020 03:12:09 -0400
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:43311)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1kTgNp-0003lF-6i; Sat, 17 Oct 2020 03:12:09 -0400
Received: by mail-lf1-x141.google.com with SMTP id l28so6249126lfp.10;
 Sat, 17 Oct 2020 00:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Lc9QIvOC4BQ5aEV3wggBnbdGYDm7vcPEJjFI1O17k4M=;
 b=ji0W6mX2C5dsWJ5Jc4KfU5qN8J6valFn9cIH20BjDlia5PNJjOhrCGrfWeXN5QHwM0
 ZhZrdSKr+ZsVzh4jiOtxo6WRzILemChReCige29ftJwybtbT6C5Y19ACH7IL7JvAb0ej
 LrWC2SsNtmI7PKofJwacknEjjyKjPxf+Gtw5PXxjB/u5OU/11V6TErF2OzhUezv+Vx9p
 TvcgkIVqNstd2CjjQkMV6IQqu5EsgatZQ4pIF9Wh6PLgHQCW/jXNfgavN9kZ81uCgls2
 pysWH9myzUJGLWNZUtxSsNi+Kc2E9qpYtzkiFBH5w96kPYFCr8B0brhDkSklCN5G5Z3+
 BZDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Lc9QIvOC4BQ5aEV3wggBnbdGYDm7vcPEJjFI1O17k4M=;
 b=mCSM47wAZ1w5r8yzVhVtofM3UM//AZRGexTJklAWhycsmIWYjbN6UdWdK/AgUFnsiq
 pbRvtSjLt07kvmpnu9gqnlJz8lLJeENcDaSgX9e1TzW5QVVVOE6ZMcE5iW1ND4pYEj1a
 CBQ4zmsisb/967S7+8n/T/YfqSyo0i369pv3jtohZ/c9v8dfgoNiE0mGwzPtvLa/76Hr
 24r6K2JEQzxn0qJP9ivt28V8IuloNocdOU0f+cUA3wlIxwNmHPlizxVU4lBsCtuG+vD1
 DrcojiIcAVYu9IIGxH7YQtQ9eJ9at2NHWkaneeImPDveZDI5BqBRriWDs/nPcAZ5IwVP
 yoPA==
X-Gm-Message-State: AOAM533gdOGwj4Ww9dBUR5kcPLiAHQENZjarfrwIlbZkxJbGdSjykL8L
 ll9g+4TmaOaBg3xMa0c4LpE=
X-Google-Smtp-Source: ABdhPJy2tLjS3HqMGLCBUkaekxD/kpuNiL597GYgRQJo9qkhRQQ2ooKLrV/vXc4mIKXsuumPnbBA+Q==
X-Received: by 2002:a19:3859:: with SMTP id d25mr3058111lfj.179.1602918723203; 
 Sat, 17 Oct 2020 00:12:03 -0700 (PDT)
Received: from neptune.lab ([46.39.229.194])
 by smtp.googlemail.com with ESMTPSA id 184sm1626905lfh.232.2020.10.17.00.12.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2020 00:12:02 -0700 (PDT)
From: Alexey Baturo <baturo.alexey@gmail.com>
X-Google-Original-From: Alexey Baturo <space.monkey.delivers@gmail.com>
To: 
Subject: [PATCH v4 4/5] [RISCV_PM] Support pointer masking for RISC-V for
 i/c/f/d/a types of instructions
Date: Sat, 17 Oct 2020 10:11:53 +0300
Message-Id: <20201017071154.20642-5-space.monkey.delivers@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201017071154.20642-1-space.monkey.delivers@gmail.com>
References: <20201017071154.20642-1-space.monkey.delivers@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::141;
 envelope-from=baturo.alexey@gmail.com; helo=mail-lf1-x141.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 GAPPY_SUBJECT=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: baturo.alexey@gmail.com, qemu-riscv@nongnu.org, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de, richard.henderson@linaro.org,
 qemu-devel@nongnu.org, space.monkey.delivers@gmail.com,
 Alistair.Francis@wdc.com, kupokupokupopo@gmail.com, palmer@dabbelt.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alexey Baturo <space.monkey.delivers@gmail.com>
---
 target/riscv/insn_trans/trans_rva.c.inc |  3 +++
 target/riscv/insn_trans/trans_rvd.c.inc |  2 ++
 target/riscv/insn_trans/trans_rvf.c.inc |  2 ++
 target/riscv/insn_trans/trans_rvi.c.inc |  2 ++
 target/riscv/translate.c                | 14 ++++++++++++++
 5 files changed, 23 insertions(+)

diff --git a/target/riscv/insn_trans/trans_rva.c.inc b/target/riscv/insn_trans/trans_rva.c.inc
index be8a9f06dd..5559e347ba 100644
--- a/target/riscv/insn_trans/trans_rva.c.inc
+++ b/target/riscv/insn_trans/trans_rva.c.inc
@@ -26,6 +26,7 @@ static inline bool gen_lr(DisasContext *ctx, arg_atomic *a, MemOp mop)
     if (a->rl) {
         tcg_gen_mb(TCG_MO_ALL | TCG_BAR_STRL);
     }
+    gen_pm_adjust_address(ctx, src1, src1);
     tcg_gen_qemu_ld_tl(load_val, src1, ctx->mem_idx, mop);
     if (a->aq) {
         tcg_gen_mb(TCG_MO_ALL | TCG_BAR_LDAQ);
@@ -46,6 +47,7 @@ static inline bool gen_sc(DisasContext *ctx, arg_atomic *a, MemOp mop)
     TCGLabel *l2 = gen_new_label();
 
     gen_get_gpr(src1, a->rs1);
+    gen_pm_adjust_address(ctx, src1, src1);
     tcg_gen_brcond_tl(TCG_COND_NE, load_res, src1, l1);
 
     gen_get_gpr(src2, a->rs2);
@@ -91,6 +93,7 @@ static bool gen_amo(DisasContext *ctx, arg_atomic *a,
     gen_get_gpr(src1, a->rs1);
     gen_get_gpr(src2, a->rs2);
 
+    gen_pm_adjust_address(ctx, src1, src1);
     (*func)(src2, src1, src2, ctx->mem_idx, mop);
 
     gen_set_gpr(a->rd, src2);
diff --git a/target/riscv/insn_trans/trans_rvd.c.inc b/target/riscv/insn_trans/trans_rvd.c.inc
index 4f832637fa..935342f66d 100644
--- a/target/riscv/insn_trans/trans_rvd.c.inc
+++ b/target/riscv/insn_trans/trans_rvd.c.inc
@@ -25,6 +25,7 @@ static bool trans_fld(DisasContext *ctx, arg_fld *a)
     TCGv t0 = tcg_temp_new();
     gen_get_gpr(t0, a->rs1);
     tcg_gen_addi_tl(t0, t0, a->imm);
+    gen_pm_adjust_address(ctx, t0, t0);
 
     tcg_gen_qemu_ld_i64(cpu_fpr[a->rd], t0, ctx->mem_idx, MO_TEQ);
 
@@ -40,6 +41,7 @@ static bool trans_fsd(DisasContext *ctx, arg_fsd *a)
     TCGv t0 = tcg_temp_new();
     gen_get_gpr(t0, a->rs1);
     tcg_gen_addi_tl(t0, t0, a->imm);
+    gen_pm_adjust_address(ctx, t0, t0);
 
     tcg_gen_qemu_st_i64(cpu_fpr[a->rs2], t0, ctx->mem_idx, MO_TEQ);
 
diff --git a/target/riscv/insn_trans/trans_rvf.c.inc b/target/riscv/insn_trans/trans_rvf.c.inc
index 3dfec8211d..04b3c3eb3d 100644
--- a/target/riscv/insn_trans/trans_rvf.c.inc
+++ b/target/riscv/insn_trans/trans_rvf.c.inc
@@ -30,6 +30,7 @@ static bool trans_flw(DisasContext *ctx, arg_flw *a)
     TCGv t0 = tcg_temp_new();
     gen_get_gpr(t0, a->rs1);
     tcg_gen_addi_tl(t0, t0, a->imm);
+    gen_pm_adjust_address(ctx, t0, t0);
 
     tcg_gen_qemu_ld_i64(cpu_fpr[a->rd], t0, ctx->mem_idx, MO_TEUL);
     gen_nanbox_s(cpu_fpr[a->rd], cpu_fpr[a->rd]);
@@ -47,6 +48,7 @@ static bool trans_fsw(DisasContext *ctx, arg_fsw *a)
     gen_get_gpr(t0, a->rs1);
 
     tcg_gen_addi_tl(t0, t0, a->imm);
+    gen_pm_adjust_address(ctx, t0, t0);
 
     tcg_gen_qemu_st_i64(cpu_fpr[a->rs2], t0, ctx->mem_idx, MO_TEUL);
 
diff --git a/target/riscv/insn_trans/trans_rvi.c.inc b/target/riscv/insn_trans/trans_rvi.c.inc
index d04ca0394c..bee7f6be46 100644
--- a/target/riscv/insn_trans/trans_rvi.c.inc
+++ b/target/riscv/insn_trans/trans_rvi.c.inc
@@ -141,6 +141,7 @@ static bool gen_load(DisasContext *ctx, arg_lb *a, MemOp memop)
     TCGv t1 = tcg_temp_new();
     gen_get_gpr(t0, a->rs1);
     tcg_gen_addi_tl(t0, t0, a->imm);
+    gen_pm_adjust_address(ctx, t0, t0);
 
     tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, memop);
     gen_set_gpr(a->rd, t1);
@@ -180,6 +181,7 @@ static bool gen_store(DisasContext *ctx, arg_sb *a, MemOp memop)
     TCGv dat = tcg_temp_new();
     gen_get_gpr(t0, a->rs1);
     tcg_gen_addi_tl(t0, t0, a->imm);
+    gen_pm_adjust_address(ctx, t0, t0);
     gen_get_gpr(dat, a->rs2);
 
     tcg_gen_qemu_st_tl(dat, t0, ctx->mem_idx, memop);
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 79dca2291b..a7cbf909f3 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -101,6 +101,16 @@ static void gen_nanbox_s(TCGv_i64 out, TCGv_i64 in)
     tcg_gen_ori_i64(out, in, MAKE_64BIT_MASK(32, 32));
 }
 
+/*
+ * Temp stub: generates address adjustment for PointerMasking
+ */
+static void gen_pm_adjust_address(DisasContext *s,
+                                  TCGv_i64      dst,
+                                  TCGv_i64      src)
+{
+    tcg_gen_mov_i64(dst, src);
+}
+
 /*
  * A narrow n-bit operation, where n < FLEN, checks that input operands
  * are correctly Nan-boxed, i.e., all upper FLEN - n bits are 1.
@@ -380,6 +390,7 @@ static void gen_load_c(DisasContext *ctx, uint32_t opc, int rd, int rs1,
     TCGv t1 = tcg_temp_new();
     gen_get_gpr(t0, rs1);
     tcg_gen_addi_tl(t0, t0, imm);
+    gen_pm_adjust_address(ctx, t0, t0);
     int memop = tcg_memop_lookup[(opc >> 12) & 0x7];
 
     if (memop < 0) {
@@ -400,6 +411,7 @@ static void gen_store_c(DisasContext *ctx, uint32_t opc, int rs1, int rs2,
     TCGv dat = tcg_temp_new();
     gen_get_gpr(t0, rs1);
     tcg_gen_addi_tl(t0, t0, imm);
+    gen_pm_adjust_address(ctx, t0, t0);
     gen_get_gpr(dat, rs2);
     int memop = tcg_memop_lookup[(opc >> 12) & 0x7];
 
@@ -459,6 +471,7 @@ static void gen_fp_load(DisasContext *ctx, uint32_t opc, int rd,
     t0 = tcg_temp_new();
     gen_get_gpr(t0, rs1);
     tcg_gen_addi_tl(t0, t0, imm);
+    gen_pm_adjust_address(ctx, t0, t0);
 
     switch (opc) {
     case OPC_RISC_FLW:
@@ -498,6 +511,7 @@ static void gen_fp_store(DisasContext *ctx, uint32_t opc, int rs1,
     t0 = tcg_temp_new();
     gen_get_gpr(t0, rs1);
     tcg_gen_addi_tl(t0, t0, imm);
+    gen_pm_adjust_address(ctx, t0, t0);
 
     switch (opc) {
     case OPC_RISC_FSW:
-- 
2.20.1



Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,GAPPY_SUBJECT,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C357C433E7
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 17:07:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A54B21D7F
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 17:07:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ISpHB9Dg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A54B21D7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSkFb-0007vj-BO
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 13:07:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42784)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1kSkAW-00034A-6R; Wed, 14 Oct 2020 13:02:28 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629]:40089)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <baturo.alexey@gmail.com>)
 id 1kSkAU-0000oq-1d; Wed, 14 Oct 2020 13:02:27 -0400
Received: by mail-ej1-x629.google.com with SMTP id p15so5851111ejm.7;
 Wed, 14 Oct 2020 10:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=R5ZfAEJcxF8L7mjg3epMOTbrndRoxVitDSaReXwIGpQ=;
 b=ISpHB9Dgqj/yAxmEmAAoj8invKcNRyWcvGHyvQR1mWTipfbdebWwwKWLvz37yAYzKJ
 Aate+LmQnP6xQUmX6VXJbpR9dSD1R2PCEJr6IgkwE0tpjbB6EhMHYjqVB5NJd4FTz13d
 2am8r9VABwlW22NNZZ71oDF9BnQcR7sdWWbYzmgMNfuSwtlDLYt8ZkQoKCI30dfGfQMp
 ckR0f4zS17uDRnN7/E9G1txFW8mmnrUFIT/d1xdFmq6yw9YL2WJmwILI6vn2Yn/NWQu7
 FJM63y0BgcLOCuOTpi70p7mDyTD4axeetLpKrwo7OeWN267fbbmkKm5woVlw3lCdXaad
 UErw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=R5ZfAEJcxF8L7mjg3epMOTbrndRoxVitDSaReXwIGpQ=;
 b=N90UT+dxwHdY9aD384lVOHGBLZTj3iyuv4fcgeXcvPdYlAqJ9AbceenoFHvZjCNTSU
 gZbIbApA40V5caHRf57ACE8v/Dj7pe0PBwcvjDEl5BqAWhRR4NlCTTr2LoLCnA78ztWo
 MMS4FpSF5hjWOrH4JsqgNkiZGRPhpygUr1A0dpqIMGFQOTwH8thmY/FlxIcQsUsWw1Hq
 j7gBiRfSohHM9vWQjF17CeyPdgdboxNyTvKrqNSOWmX8G/hf4qUr2GDgLhitvCC4ZiSK
 pCKCGvIwxNLLI4vRpoksDXikIiX2kWnyiatb5PactYW+9uGvyIvsPOOG85W7L/uUZFBg
 bW0w==
X-Gm-Message-State: AOAM530dJIRKGNxXTRA7trsAEwzuvQQoHC1fV4VSO5KCQWnUqtctLYCX
 ak6yzVzRPJPoUuSxrtSGMl4=
X-Google-Smtp-Source: ABdhPJzzW+CbNVtOoWiR7rbJKhaJl50P0Fimg6VqIwESqHHeAUrsz/HzLNrgS5Bb+t0jMwxnoThPDA==
X-Received: by 2002:a17:906:3b8e:: with SMTP id
 u14mr6168809ejf.127.1602694944238; 
 Wed, 14 Oct 2020 10:02:24 -0700 (PDT)
Received: from neptune.lab ([46.39.229.194])
 by smtp.googlemail.com with ESMTPSA id g3sm76012edy.12.2020.10.14.10.02.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2020 10:02:23 -0700 (PDT)
From: Alexey Baturo <baturo.alexey@gmail.com>
X-Google-Original-From: Alexey Baturo <space.monkey.delivers@gmail.com>
To: 
Subject: [PATCH 5/5] [RISCV_PM] Support pointer masking for RISC-V for
 i/c/f/d/a types of instructions
Date: Wed, 14 Oct 2020 20:01:59 +0300
Message-Id: <20201014170159.26932-6-space.monkey.delivers@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201014170159.26932-1-space.monkey.delivers@gmail.com>
References: <20201014170159.26932-1-space.monkey.delivers@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=baturo.alexey@gmail.com; helo=mail-ej1-x629.google.com
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
Cc: baturo.alexey@gmail.com,
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 space.monkey.delivers@gmail.com, Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alexey Baturo <space.monkey.delivers@gmail.com>
---
 target/riscv/insn_trans/trans_rva.c.inc |  9 +++++++++
 target/riscv/insn_trans/trans_rvd.c.inc |  6 ++++++
 target/riscv/insn_trans/trans_rvf.c.inc |  6 ++++++
 target/riscv/insn_trans/trans_rvi.c.inc |  6 ++++++
 target/riscv/translate.c                | 12 ++++++++++++
 5 files changed, 39 insertions(+)

diff --git a/target/riscv/insn_trans/trans_rva.c.inc b/target/riscv/insn_trans/trans_rva.c.inc
index be8a9f06dd..3bf2e82013 100644
--- a/target/riscv/insn_trans/trans_rva.c.inc
+++ b/target/riscv/insn_trans/trans_rva.c.inc
@@ -26,6 +26,9 @@ static inline bool gen_lr(DisasContext *ctx, arg_atomic *a, MemOp mop)
     if (a->rl) {
         tcg_gen_mb(TCG_MO_ALL | TCG_BAR_STRL);
     }
+    if (has_ext(ctx, RVJ)) {
+        src1 = apply_pointer_masking(ctx, src1);
+    }
     tcg_gen_qemu_ld_tl(load_val, src1, ctx->mem_idx, mop);
     if (a->aq) {
         tcg_gen_mb(TCG_MO_ALL | TCG_BAR_LDAQ);
@@ -46,6 +49,9 @@ static inline bool gen_sc(DisasContext *ctx, arg_atomic *a, MemOp mop)
     TCGLabel *l2 = gen_new_label();
 
     gen_get_gpr(src1, a->rs1);
+    if (has_ext(ctx, RVJ)) {
+        src1 = apply_pointer_masking(ctx, src1);
+    }
     tcg_gen_brcond_tl(TCG_COND_NE, load_res, src1, l1);
 
     gen_get_gpr(src2, a->rs2);
@@ -91,6 +97,9 @@ static bool gen_amo(DisasContext *ctx, arg_atomic *a,
     gen_get_gpr(src1, a->rs1);
     gen_get_gpr(src2, a->rs2);
 
+    if (has_ext(ctx, RVJ)) {
+        src1 = apply_pointer_masking(ctx, src1);
+    }
     (*func)(src2, src1, src2, ctx->mem_idx, mop);
 
     gen_set_gpr(a->rd, src2);
diff --git a/target/riscv/insn_trans/trans_rvd.c.inc b/target/riscv/insn_trans/trans_rvd.c.inc
index 4f832637fa..0391bb02be 100644
--- a/target/riscv/insn_trans/trans_rvd.c.inc
+++ b/target/riscv/insn_trans/trans_rvd.c.inc
@@ -25,6 +25,9 @@ static bool trans_fld(DisasContext *ctx, arg_fld *a)
     TCGv t0 = tcg_temp_new();
     gen_get_gpr(t0, a->rs1);
     tcg_gen_addi_tl(t0, t0, a->imm);
+    if (has_ext(ctx, RVJ)) {
+        t0 = apply_pointer_masking(ctx, t0);
+    }
 
     tcg_gen_qemu_ld_i64(cpu_fpr[a->rd], t0, ctx->mem_idx, MO_TEQ);
 
@@ -40,6 +43,9 @@ static bool trans_fsd(DisasContext *ctx, arg_fsd *a)
     TCGv t0 = tcg_temp_new();
     gen_get_gpr(t0, a->rs1);
     tcg_gen_addi_tl(t0, t0, a->imm);
+    if (has_ext(ctx, RVJ)) {
+        t0 = apply_pointer_masking(ctx, t0);
+    }
 
     tcg_gen_qemu_st_i64(cpu_fpr[a->rs2], t0, ctx->mem_idx, MO_TEQ);
 
diff --git a/target/riscv/insn_trans/trans_rvf.c.inc b/target/riscv/insn_trans/trans_rvf.c.inc
index 3dfec8211d..176bc992e1 100644
--- a/target/riscv/insn_trans/trans_rvf.c.inc
+++ b/target/riscv/insn_trans/trans_rvf.c.inc
@@ -30,6 +30,9 @@ static bool trans_flw(DisasContext *ctx, arg_flw *a)
     TCGv t0 = tcg_temp_new();
     gen_get_gpr(t0, a->rs1);
     tcg_gen_addi_tl(t0, t0, a->imm);
+    if (has_ext(ctx, RVJ)) {
+        t0 = apply_pointer_masking(ctx, t0);
+    }
 
     tcg_gen_qemu_ld_i64(cpu_fpr[a->rd], t0, ctx->mem_idx, MO_TEUL);
     gen_nanbox_s(cpu_fpr[a->rd], cpu_fpr[a->rd]);
@@ -47,6 +50,9 @@ static bool trans_fsw(DisasContext *ctx, arg_fsw *a)
     gen_get_gpr(t0, a->rs1);
 
     tcg_gen_addi_tl(t0, t0, a->imm);
+    if (has_ext(ctx, RVJ)) {
+        t0 = apply_pointer_masking(ctx, t0);
+    }
 
     tcg_gen_qemu_st_i64(cpu_fpr[a->rs2], t0, ctx->mem_idx, MO_TEUL);
 
diff --git a/target/riscv/insn_trans/trans_rvi.c.inc b/target/riscv/insn_trans/trans_rvi.c.inc
index d04ca0394c..3ee2fea271 100644
--- a/target/riscv/insn_trans/trans_rvi.c.inc
+++ b/target/riscv/insn_trans/trans_rvi.c.inc
@@ -141,6 +141,9 @@ static bool gen_load(DisasContext *ctx, arg_lb *a, MemOp memop)
     TCGv t1 = tcg_temp_new();
     gen_get_gpr(t0, a->rs1);
     tcg_gen_addi_tl(t0, t0, a->imm);
+    if (has_ext(ctx, RVJ)) {
+        t0 = apply_pointer_masking(ctx, t0);
+    }
 
     tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, memop);
     gen_set_gpr(a->rd, t1);
@@ -180,6 +183,9 @@ static bool gen_store(DisasContext *ctx, arg_sb *a, MemOp memop)
     TCGv dat = tcg_temp_new();
     gen_get_gpr(t0, a->rs1);
     tcg_gen_addi_tl(t0, t0, a->imm);
+    if (has_ext(ctx, RVJ)) {
+        t0 = apply_pointer_masking(ctx, t0);
+    }
     gen_get_gpr(dat, a->rs2);
 
     tcg_gen_qemu_st_tl(dat, t0, ctx->mem_idx, memop);
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 338a967e0c..0b086753d4 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -416,6 +416,9 @@ static void gen_load_c(DisasContext *ctx, uint32_t opc, int rd, int rs1,
     TCGv t1 = tcg_temp_new();
     gen_get_gpr(t0, rs1);
     tcg_gen_addi_tl(t0, t0, imm);
+    if (has_ext(ctx, RVJ)) {
+        t0 = apply_pointer_masking(ctx, t0);
+    }
     int memop = tcg_memop_lookup[(opc >> 12) & 0x7];
 
     if (memop < 0) {
@@ -436,6 +439,9 @@ static void gen_store_c(DisasContext *ctx, uint32_t opc, int rs1, int rs2,
     TCGv dat = tcg_temp_new();
     gen_get_gpr(t0, rs1);
     tcg_gen_addi_tl(t0, t0, imm);
+    if (has_ext(ctx, RVJ)) {
+        t0 = apply_pointer_masking(ctx, t0);
+    }
     gen_get_gpr(dat, rs2);
     int memop = tcg_memop_lookup[(opc >> 12) & 0x7];
 
@@ -495,6 +501,9 @@ static void gen_fp_load(DisasContext *ctx, uint32_t opc, int rd,
     t0 = tcg_temp_new();
     gen_get_gpr(t0, rs1);
     tcg_gen_addi_tl(t0, t0, imm);
+    if (riscv_has_ext(env, RVJ)) {
+        t0 = apply_pointer_masking(ctx, t0);
+    }
 
     switch (opc) {
     case OPC_RISC_FLW:
@@ -534,6 +543,9 @@ static void gen_fp_store(DisasContext *ctx, uint32_t opc, int rs1,
     t0 = tcg_temp_new();
     gen_get_gpr(t0, rs1);
     tcg_gen_addi_tl(t0, t0, imm);
+    if (riscv_has_ext(env, RVJ)) {
+        t0 = apply_pointer_masking(ctx, t0);
+    }
 
     switch (opc) {
     case OPC_RISC_FSW:
-- 
2.20.1



Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B2EC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 19:33:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1718207D4
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 19:33:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qfrCPgvI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1718207D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkure-0003Iw-Qi
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 15:33:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46054)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jkun6-0003NN-7c
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 15:29:08 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:46317)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jkun3-0004iz-Mx
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 15:29:07 -0400
Received: by mail-wr1-x435.google.com with SMTP id x6so18289365wrm.13
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2020 12:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=bhNHHGAWghjftc/HKLdKGz55TUKqNK7zCNOxSxW8eWM=;
 b=qfrCPgvIUtT7QNlu2bpzoiJI58hdndAvJzK4/QrqAT8qfsFofcvcxsHvMenEUAtKsw
 UCMb61K0aa2FhCi1seIbqa7io+FQ5DfJFuyo79gFO1MKEx0+rwCrmugI7cKWNCVUu5Iw
 bn8ujDhYD9N2/7QPCFzpo+byT1NPvH6P1BkVfnCVwSG9gHsuvTg64HjR9Jma0RfVwOU9
 KfEeNknHj1aEby6L9Utcym+5ZHcoZOD5lE/anARf1KX7e2J9wbF+N//kfm2CiCuH/URN
 FnvugzQqMZn9Q1C3MuvWmqUejVq3AJdwtCmRc2bBNHRQP6Qm1WK2fjtWE++CginWJPtN
 OKIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=bhNHHGAWghjftc/HKLdKGz55TUKqNK7zCNOxSxW8eWM=;
 b=hdg8LD9QlV+jdSwfVbvzJzwBL48mqF+WNR05aseNbex4uXVNqxCwHQ6KQtKxE5OA75
 5UMcG71eDwdoX66TN85+cvo9Spf9a621UZQIFJ0jOx3Vd0mSHayWS3B76KRXmD4NU1Fc
 Jdm7RkQslNVKsj9eRZem5LwhyXUi3FC8Z0v43lNtVs81J+mO/GKTJlQOQdzjedd2bRN4
 vLLB9Jcs15l/IYUhDlAQ1uy4S6lU+o5luFBoCyQCq5mERXUVvn2cvmltbZtp1S2vcEyU
 SEHPUmdO+xGYe6QVdHe4Rb1cMUMkROpLcEgn98LvcPPr/kaBj/rfkz8jHcm7zKA4N13G
 lqgA==
X-Gm-Message-State: AOAM531n/AJYDzQIgoNbNxHr5G1iDB9a5Qyhf1v717WLVfWYBjAB+fLl
 ZtaqCiqcDMrN89pocStC+dFrNTwd
X-Google-Smtp-Source: ABdhPJxfj9TS4gJA73lmPr2Ij2mZMZYY3CHRjQyJryIAk09e0qqr+fXKCAmH8LEuuBjBWLZ5zPeAyw==
X-Received: by 2002:adf:ef50:: with SMTP id c16mr29780367wrp.161.1592249344286; 
 Mon, 15 Jun 2020 12:29:04 -0700 (PDT)
Received: from rtrkw774-lin.syrmia.com ([46.240.135.226])
 by smtp.gmail.com with ESMTPSA id 138sm713098wma.23.2020.06.15.12.29.03
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 15 Jun 2020 12:29:03 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL 01/18] target/mips: Legalize Loongson insn flags
Date: Mon, 15 Jun 2020 21:28:43 +0200
Message-Id: <1592249340-8365-2-git-send-email-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1592249340-8365-1-git-send-email-aleksandar.qemu.devel@gmail.com>
References: <1592249340-8365-1-git-send-email-aleksandar.qemu.devel@gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wr1-x435.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: aleksandar.qemu.devel@gmail.com, Jiaxun Yang <jiaxun.yang@flygoat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jiaxun Yang <jiaxun.yang@flygoat.com>

To match the actual status of Loongson insn, we split flags
for LMMI and LEXT from INSN_LOONGSON2F.

As Loongson-2F only implemented interger part of LEXT, we'll
not enable LEXT for the processor, but instead we're still using
INSN_LOONGSON2F as switch flag of these instructions.

All multimedia instructions have been moved to LMMI flag. Loongson-2F
and Loongson-3A are sharing these instructions.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Message-Id: <20200614080049.31134-2-jiaxun.yang@flygoat.com>
---
 target/mips/mips-defs.h |  4 ++--
 target/mips/translate.c | 13 +++++++------
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/target/mips/mips-defs.h b/target/mips/mips-defs.h
index 0c12910..f1b833f 100644
--- a/target/mips/mips-defs.h
+++ b/target/mips/mips-defs.h
@@ -70,7 +70,7 @@
 #define CPU_VR54XX      (CPU_MIPS4 | INSN_VR54XX)
 #define CPU_R5900       (CPU_MIPS3 | INSN_R5900)
 #define CPU_LOONGSON2E  (CPU_MIPS3 | INSN_LOONGSON2E)
-#define CPU_LOONGSON2F  (CPU_MIPS3 | INSN_LOONGSON2F)
+#define CPU_LOONGSON2F  (CPU_MIPS3 | INSN_LOONGSON2F | ASE_LMMI)
 
 #define CPU_MIPS5       (CPU_MIPS4 | ISA_MIPS5)
 
@@ -97,7 +97,7 @@
 /* Wave Computing: "nanoMIPS" */
 #define CPU_NANOMIPS32  (CPU_MIPS32R6 | ISA_NANOMIPS32)
 
-#define CPU_LOONGSON3A  (CPU_MIPS64R2 | INSN_LOONGSON3A)
+#define CPU_LOONGSON3A  (CPU_MIPS64R2 | INSN_LOONGSON3A | ASE_LMMI | ASE_LEXT)
 
 /*
  * Strictly follow the architecture standard:
diff --git a/target/mips/translate.c b/target/mips/translate.c
index 2caf4cb..e49f32f 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -1046,7 +1046,7 @@ enum {
     OPC_BC2NEZ  = (0x0D << 21) | OPC_CP2,
 };
 
-#define MASK_LMI(op)    (MASK_OP_MAJOR(op) | (op & (0x1F << 21)) | (op & 0x1F))
+#define MASK_LMMI(op)    (MASK_OP_MAJOR(op) | (op & (0x1F << 21)) | (op & 0x1F))
 
 enum {
     OPC_PADDSH      = (24 << 21) | (0x00) | OPC_CP2,
@@ -3421,7 +3421,8 @@ static void gen_ld(DisasContext *ctx, uint32_t opc,
     TCGv t0, t1, t2;
     int mem_idx = ctx->mem_idx;
 
-    if (rt == 0 && ctx->insn_flags & (INSN_LOONGSON2E | INSN_LOONGSON2F)) {
+    if (rt == 0 && ctx->insn_flags & (INSN_LOONGSON2E | INSN_LOONGSON2F |
+                                      INSN_LOONGSON3A)) {
         /*
          * Loongson CPU uses a load to zero register for prefetch.
          * We emulate it as a NOP. On other CPU we must perform the
@@ -5531,7 +5532,7 @@ static void gen_loongson_multimedia(DisasContext *ctx, int rd, int rs, int rt)
     TCGv_i64 t0, t1;
     TCGCond cond;
 
-    opc = MASK_LMI(ctx->opcode);
+    opc = MASK_LMMI(ctx->opcode);
     switch (opc) {
     case OPC_ADD_CP2:
     case OPC_SUB_CP2:
@@ -27161,7 +27162,7 @@ static void decode_opc_special2_legacy(CPUMIPSState *env, DisasContext *ctx)
     case OPC_MULTU_G_2F:
     case OPC_MOD_G_2F:
     case OPC_MODU_G_2F:
-        check_insn(ctx, INSN_LOONGSON2F);
+        check_insn(ctx, INSN_LOONGSON2F | ASE_LEXT);
         gen_loongson_integer(ctx, op1, rd, rs, rt);
         break;
     case OPC_CLO:
@@ -27194,7 +27195,7 @@ static void decode_opc_special2_legacy(CPUMIPSState *env, DisasContext *ctx)
     case OPC_DDIVU_G_2F:
     case OPC_DMOD_G_2F:
     case OPC_DMODU_G_2F:
-        check_insn(ctx, INSN_LOONGSON2F);
+        check_insn(ctx, INSN_LOONGSON2F | ASE_LEXT);
         gen_loongson_integer(ctx, op1, rd, rs, rt);
         break;
 #endif
@@ -30641,7 +30642,7 @@ static void decode_opc(CPUMIPSState *env, DisasContext *ctx)
         }
         break;
     case OPC_CP2:
-        check_insn(ctx, INSN_LOONGSON2F);
+        check_insn(ctx, ASE_LMMI);
         /* Note that these instructions use different fields.  */
         gen_loongson_multimedia(ctx, sa, rd, rt);
         break;
-- 
2.7.4



Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33CF5C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 19:23:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0EFC20756
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 19:23:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dGxpRwG/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0EFC20756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkuhr-0007xd-6j
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 15:23:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44880)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jkugu-0006KD-Ph
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 15:22:44 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:42716)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jkugt-0003oG-5a
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 15:22:44 -0400
Received: by mail-wr1-x42f.google.com with SMTP id p5so18291075wrw.9
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2020 12:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=bhNHHGAWghjftc/HKLdKGz55TUKqNK7zCNOxSxW8eWM=;
 b=dGxpRwG/XOyRf32xWNtP7GlRA+8n7lKAJfWqof8s/+OkNe1Mx613eKql35r1mKkeOV
 uTTXTl1kL7iKHnHG5hcOGEzchTQWOVAg2uK1NDVVUtENw/Lq47iAqoPL1Opti96TZZcS
 lVz1OmXIZGOGDOTt+MeqcqYAavWy2cyVn5Awd3F/LofbaWo6Eh1V5hSy5US/KOcacyR0
 xqkuwgSlIpr9ywWJ3v/2nfGMejZcVJ5GmnaQ4dk/chq8mXDxZiWX6oyWUt8gWKlAY1Q6
 P++vZUPZzZYGZQ2kDAE5cp1yo5fSNCcqkrp53lr7xFsTeZQwYd9xpdu+ASjG05ewU87M
 KAyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=bhNHHGAWghjftc/HKLdKGz55TUKqNK7zCNOxSxW8eWM=;
 b=qgLL0/c20p92Fx3xLoL6AU4PjbL++ZJxvmDEodDDGoFOgbNBeICZTwKGsFpqSap1sR
 jQIy6qnw3CcCgmJY6OvyUwgWfwLRuGCYt4IKfJH+Aa2WCSZ2iMcD6J2yMYWE0crn+9H7
 5N8PqGFzRSj6SvxzDmlIV3SmMPqO128dY4QN2KlL1Rtoxk3zm132H3iBoIN2OX6EMhpY
 +L5fFqVQDJUOZia8rTOUZBgO+9dFzlhC9TdrScsrw81OOoHaXLmpp+5HpkEBDJJR2Ax/
 1NS7okM7IpdKVRL3BfqZtkCwx8ZBFALHhVrrr/F/avIyxFjgrtIxYOaxX7VUVKUZBoMb
 ywrA==
X-Gm-Message-State: AOAM530kfF/x3rxpcVBBXS9wbIIzXmUqJYVWIGkJupzcFM/Yoxyh8pb1
 B+ajL36QBXAidu2myKdC/obhCQWH
X-Google-Smtp-Source: ABdhPJxtPq5Hn4gQt4zArqnlOz9T3JnO63LdejL1/dOQsSxsIdw96Km5QoVMUfqqB/8+vplDLjeMDg==
X-Received: by 2002:a5d:554a:: with SMTP id g10mr31390439wrw.334.1592248961546; 
 Mon, 15 Jun 2020 12:22:41 -0700 (PDT)
Received: from rtrkw774-lin.syrmia.com ([46.240.135.226])
 by smtp.gmail.com with ESMTPSA id 50sm27823909wra.1.2020.06.15.12.22.40
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 15 Jun 2020 12:22:41 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL 01/18] target/mips: Legalize Loongson insn flags
Date: Mon, 15 Jun 2020 21:22:16 +0200
Message-Id: <1592248953-8162-2-git-send-email-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1592248953-8162-1-git-send-email-aleksandar.qemu.devel@gmail.com>
References: <1592248953-8162-1-git-send-email-aleksandar.qemu.devel@gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wr1-x42f.google.com
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



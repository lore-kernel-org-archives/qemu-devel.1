Return-Path: <SRS0=yvcL=DY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97A80C43457
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 14:14:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F10220704
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 14:14:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QI6AoIed"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F10220704
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTmz0-0000M9-Bn
	for qemu-devel@archiver.kernel.org; Sat, 17 Oct 2020 10:14:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36578)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTmo0-0001fN-C7
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 10:03:34 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335]:36870)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTmnt-0003ii-12
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 10:03:26 -0400
Received: by mail-wm1-x335.google.com with SMTP id j136so8387656wmj.2
 for <qemu-devel@nongnu.org>; Sat, 17 Oct 2020 07:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=vLpi4Ok952k/O5t7O1lK6hwZKOdIsy56EvHrjOgW/9g=;
 b=QI6AoIedhod/25yyws8sXRpP3Ab6b83I/zWtfQlU3GMjCyt1W6Lqlk8eBKIJEZMUtj
 N1pL2HUoVYvPFM+DPoVkC8FZdlB9GXQ1QKajpuOQZ1A68Tl1p1wm5M03KZE2RzKiqS3D
 KBGaIC0ErWCpQfh0L0+GjEcqYSfJrnqULvfm1iDCgZpIohnpkLMZqI/2bxvzoyS9Ap97
 0YalK/tfMU+Xsw/b39xz9bdpkCycDYjAoMWbcNNXWzczY7VJ3ffuReR68fmWOTFzs74g
 hSBfXXoEBoWYuvUwkJaaxxxxe+88Atr9bnk2SRu512Do7B4MTH1EyVgIV1CDFVVSW9po
 ElWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=vLpi4Ok952k/O5t7O1lK6hwZKOdIsy56EvHrjOgW/9g=;
 b=YOzz4+8RPbotrErSz6aCBoY6w1LMcVoa1xTRmSBsTCkMfRx3Q8e41efcak62r6GG6j
 vtJZ5OPbrFrJOqULTWknTRmHNSqINtE6PjcL0WaQD40qGiuWxSRi0sDoZKXmFhQbCyFD
 9xuT51rsg5VHns6A9hVZWWZBg4/ONrBRLDc40jY/X41+4Q+ls9Z/ZHAwDkTL0+wp8l8O
 svGWC4AWTc2z7j+Be2sl4E/z8mUuLcLPTciunvaXEadSWzFXbzYSJ3OYpA/uRuUw+zS5
 OZJaPQ5n9vYzWYVPvwlk0xwk3nvVIQJZQkCj3EebaU/gmVKbzvYxy5cm2jz5BinFoWOq
 1rJg==
X-Gm-Message-State: AOAM532NRmONdZ24ztsw6YyfKjLUfQ3CQaeYaib6H5TfPW2bXtso1N0r
 4OieWOINx8olnqDPiJxPs4PwWmvdOtY=
X-Google-Smtp-Source: ABdhPJxFe5x167yezDjoEusJwDopfpCmIr6Ukt3R4uGJhJLT6p5SOYhg0gy4lHE2ckaCSGXseGn7rw==
X-Received: by 2002:a1c:cc07:: with SMTP id h7mr9065305wmb.55.1602943403353;
 Sat, 17 Oct 2020 07:03:23 -0700 (PDT)
Received: from localhost.localdomain
 (117.red-83-52-172.dynamicip.rima-tde.net. [83.52.172.117])
 by smtp.gmail.com with ESMTPSA id v4sm7231835wmg.35.2020.10.17.07.03.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2020 07:03:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/44] target/mips: Add loongson-ext lswc2 group of
 instructions (Part 1)
Date: Sat, 17 Oct 2020 16:02:07 +0200
Message-Id: <20201017140243.1078718-9-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201017140243.1078718-1-f4bug@amsat.org>
References: <20201017140243.1078718-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x335.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Paul Burton <paulburton@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Huacai Chen <chenhc@lemote.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jiaxun Yang <jiaxun.yang@flygoat.com>

LWC2 & SWC2 have been rewritten by Loongson EXT vendor ASE
as "load/store quad word" and "shifted load/store" groups of
instructions.

This patch add implementation of these instructions:

  gslq: load 16 bytes to GPR
  gssq: store 16 bytes from GPR
  gslqc1: load 16 bytes to FPR
  gssqc1: store 16 bytes from FPR

Details of Loongson-EXT is here:
https://github.com/FlyGoat/loongson-insn/blob/master/loongson-ext.md

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Huacai Chen <chenhc@lemote.com>
Message-Id: <1602831120-3377-3-git-send-email-chenhc@lemote.com>
[PMD: Restrict t1 variable to TARGET_MIPS64, remove unused t2/fp0]
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/mips/translate.c | 86 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index b4d009078e0..e83954d782f 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -460,6 +460,17 @@ enum {
     R6_OPC_SCD         = 0x27 | OPC_SPECIAL3,
 };
 
+/* Loongson EXT load/store quad word opcodes */
+#define MASK_LOONGSON_GSLSQ(op)           (MASK_OP_MAJOR(op) | (op & 0x8020))
+enum {
+    OPC_GSLQ        = 0x0020 | OPC_LWC2,
+    OPC_GSLQC1      = 0x8020 | OPC_LWC2,
+    OPC_GSSHFL      = OPC_LWC2,
+    OPC_GSSQ        = 0x0020 | OPC_SWC2,
+    OPC_GSSQC1      = 0x8020 | OPC_SWC2,
+    OPC_GSSHFS      = OPC_SWC2,
+};
+
 /* BSHFL opcodes */
 #define MASK_BSHFL(op)              (MASK_SPECIAL3(op) | (op & (0x1F << 6)))
 
@@ -5910,6 +5921,79 @@ no_rd:
     tcg_temp_free_i64(t1);
 }
 
+static void gen_loongson_lswc2(DisasContext *ctx, int rt,
+                               int rs, int rd)
+{
+    TCGv t0;
+#if defined(TARGET_MIPS64)
+    TCGv t1;
+    int lsq_rt1 = ctx->opcode & 0x1f;
+    int lsq_offset = sextract32(ctx->opcode, 6, 9) << 4;
+#endif
+
+    t0 = tcg_temp_new();
+
+    switch (MASK_LOONGSON_GSLSQ(ctx->opcode)) {
+#if defined(TARGET_MIPS64)
+    case OPC_GSLQ:
+        t1 = tcg_temp_new();
+        gen_base_offset_addr(ctx, t0, rs, lsq_offset);
+        tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, MO_TEQ |
+                           ctx->default_tcg_memop_mask);
+        gen_base_offset_addr(ctx, t0, rs, lsq_offset + 8);
+        tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, MO_TEQ |
+                           ctx->default_tcg_memop_mask);
+        gen_store_gpr(t1, rt);
+        gen_store_gpr(t0, lsq_rt1);
+        tcg_temp_free(t1);
+        break;
+    case OPC_GSLQC1:
+        check_cp1_enabled(ctx);
+        t1 = tcg_temp_new();
+        gen_base_offset_addr(ctx, t0, rs, lsq_offset);
+        tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, MO_TEQ |
+                           ctx->default_tcg_memop_mask);
+        gen_base_offset_addr(ctx, t0, rs, lsq_offset + 8);
+        tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, MO_TEQ |
+                           ctx->default_tcg_memop_mask);
+        gen_store_fpr64(ctx, t1, rt);
+        gen_store_fpr64(ctx, t0, lsq_rt1);
+        tcg_temp_free(t1);
+        break;
+    case OPC_GSSQ:
+        t1 = tcg_temp_new();
+        gen_base_offset_addr(ctx, t0, rs, lsq_offset);
+        gen_load_gpr(t1, rt);
+        tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, MO_TEQ |
+                           ctx->default_tcg_memop_mask);
+        gen_base_offset_addr(ctx, t0, rs, lsq_offset + 8);
+        gen_load_gpr(t1, lsq_rt1);
+        tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, MO_TEQ |
+                           ctx->default_tcg_memop_mask);
+        tcg_temp_free(t1);
+        break;
+    case OPC_GSSQC1:
+        check_cp1_enabled(ctx);
+        t1 = tcg_temp_new();
+        gen_base_offset_addr(ctx, t0, rs, lsq_offset);
+        gen_load_fpr64(ctx, t1, rt);
+        tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, MO_TEQ |
+                           ctx->default_tcg_memop_mask);
+        gen_base_offset_addr(ctx, t0, rs, lsq_offset + 8);
+        gen_load_fpr64(ctx, t1, lsq_rt1);
+        tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, MO_TEQ |
+                           ctx->default_tcg_memop_mask);
+        tcg_temp_free(t1);
+        break;
+#endif
+    default:
+        MIPS_INVAL("loongson_gslsq");
+        generate_exception_end(ctx, EXCP_RI);
+        break;
+    }
+    tcg_temp_free(t0);
+}
+
 /* Traps */
 static void gen_trap(DisasContext *ctx, uint32_t opc,
                      int rs, int rt, int16_t imm)
@@ -30774,6 +30858,8 @@ static void decode_opc(CPUMIPSState *env, DisasContext *ctx)
             /* OPC_BC, OPC_BALC */
             gen_compute_compact_branch(ctx, op, 0, 0,
                                        sextract32(ctx->opcode << 2, 0, 28));
+        } else if (ctx->insn_flags & ASE_LEXT) {
+            gen_loongson_lswc2(ctx, rt, rs, rd);
         } else {
             /* OPC_LWC2, OPC_SWC2 */
             /* COP2: Not implemented. */
-- 
2.26.2



Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C35C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 06:55:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9320C207C4
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 06:55:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gJfT15CA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9320C207C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTJdn-0000MJ-Lo
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 02:55:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56504)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1kTJb0-0005fk-7O
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 02:52:10 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532]:43815)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1kTJax-00005c-3r
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 02:52:09 -0400
Received: by mail-pg1-x532.google.com with SMTP id r10so837995pgb.10
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2020 23:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Yzj7GQKI/kXfeIzt4sfEcNHDfEjwO9GdyHRQDH+VRMQ=;
 b=gJfT15CA52pehkN7uHBg3QUxlgZysOqazmCHedypp/cGk3nmvNscpiO9xDrfettuMA
 i9hH3UdvxCS9mnkGMd+zqv8HeaiQjGeLY8GFUKqE3/DQqXhb/q82X9ew/x9JeSUPXE2j
 /6gRbxUSryqsIRXetybXIawDjUlmA2VVcRy1pfpWXtFlyRRwpjn+3e2nmgWUMTwA6fd/
 jfRvDLW+gqv8IO1/TlmlXEn7xq3FKjhwgv3WgHi9rQVE02qpkvWBxmr5vMj6UsrnSZuo
 b7LUNjTKHYibAjGYUmKB9JO8q1iL4ppQr19qQu4tU1cR6H8EPjb+zTWEH2mkcbTRjG7f
 hubQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=Yzj7GQKI/kXfeIzt4sfEcNHDfEjwO9GdyHRQDH+VRMQ=;
 b=l2AkgogRl1kBmU0KwrSpF/6UIWHQyamd0jRAMJqibCPO4Xy3sScFNlRaNNGJ4DHzlc
 f+4ATh5AwLtzquM0UKyKCggwu9Nu4vfWTUTjol9depdmbtnkLuMDhulFdrupT0zejBvt
 Z5Pr+dmjTuQbzUIQ8SwERcbt4g3MCIvMxmgHmAJYb4ylDXSX+u5vm56k78CmXlpo1knV
 DISf1eBA5ORrxjvkA/g2RD59N1AfO3Rzdz1XVzM3diu39j6/vRyAR72xvhTH/U7fC+c1
 CoQoYoEbMaQ2RGYBDpOeJW3SJmnUhwUmvblqn90vNqR0M6oidz6SR1thjDPGzsHOZzqI
 O6Eg==
X-Gm-Message-State: AOAM533ae/XMxByf4kTFJ6ATtJaN7RhB4G00y/DWZ4/SFirtDQFNTL/4
 qktZ9bUnNmFic2yuLly0oGE=
X-Google-Smtp-Source: ABdhPJxYDyEoV8VwB3yOWPG5FQaNaO6ntyL4ML1E/rfZnbFJRlpFuoj4ULW/CuTe9fo5jZ5lbOpPYA==
X-Received: by 2002:a62:32c5:0:b029:158:7361:58d3 with SMTP id
 y188-20020a6232c50000b0290158736158d3mr2308166pfy.75.1602831125513; 
 Thu, 15 Oct 2020 23:52:05 -0700 (PDT)
Received: from software.domain.org ([45.77.13.216])
 by smtp.gmail.com with ESMTPSA id v21sm1552200pjg.44.2020.10.15.23.52.00
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 15 Oct 2020 23:52:04 -0700 (PDT)
From: Huacai Chen <zltjiangshi@gmail.com>
X-Google-Original-From: Huacai Chen <chenhc@lemote.com>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Subject: [PATCH V14 2/8] target/mips: Add loongson-ext lswc2 group of
 instructions (Part 1)
Date: Fri, 16 Oct 2020 14:51:54 +0800
Message-Id: <1602831120-3377-3-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1602831120-3377-1-git-send-email-chenhc@lemote.com>
References: <1602831120-3377-1-git-send-email-chenhc@lemote.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=zltjiangshi@gmail.com; helo=mail-pg1-x532.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Huacai Chen <chenhuacai@gmail.com>, qemu-devel@nongnu.org,
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
---
 target/mips/translate.c | 86 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 398edf7289..20a7f36c7c 100644
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
+    TCGv t0, t1, t2;
+    TCGv_i32 fp0;
+#if defined(TARGET_MIPS64)
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
+                            ctx->default_tcg_memop_mask);
+        gen_base_offset_addr(ctx, t0, rs, lsq_offset + 8);
+        tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, MO_TEQ |
+                            ctx->default_tcg_memop_mask);
+        gen_store_gpr(t1, rt);
+        gen_store_gpr(t0, lsq_rt1);
+        tcg_temp_free(t1);
+        break;
+    case OPC_GSLQC1:
+        check_cp1_enabled(ctx);
+        t1 = tcg_temp_new();
+        gen_base_offset_addr(ctx, t0, rs, lsq_offset);
+        tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, MO_TEQ |
+                            ctx->default_tcg_memop_mask);
+        gen_base_offset_addr(ctx, t0, rs, lsq_offset + 8);
+        tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, MO_TEQ |
+                            ctx->default_tcg_memop_mask);
+        gen_store_fpr64(ctx, t1, rt);
+        gen_store_fpr64(ctx, t0, lsq_rt1);
+        tcg_temp_free(t1);
+        break;
+    case OPC_GSSQ:
+        t1 = tcg_temp_new();
+        gen_base_offset_addr(ctx, t0, rs, lsq_offset);
+        gen_load_gpr(t1, rt);
+        tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, MO_TEQ |
+                            ctx->default_tcg_memop_mask);
+        gen_base_offset_addr(ctx, t0, rs, lsq_offset + 8);
+        gen_load_gpr(t1, lsq_rt1);
+        tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, MO_TEQ |
+                            ctx->default_tcg_memop_mask);
+        tcg_temp_free(t1);
+        break;
+    case OPC_GSSQC1:
+        check_cp1_enabled(ctx);
+        t1 = tcg_temp_new();
+        gen_base_offset_addr(ctx, t0, rs, lsq_offset);
+        gen_load_fpr64(ctx, t1, rt);
+        tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, MO_TEQ |
+                            ctx->default_tcg_memop_mask);
+        gen_base_offset_addr(ctx, t0, rs, lsq_offset + 8);
+        gen_load_fpr64(ctx, t1, lsq_rt1);
+        tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, MO_TEQ |
+                            ctx->default_tcg_memop_mask);
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
2.17.2



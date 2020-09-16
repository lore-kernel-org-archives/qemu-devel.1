Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E61C43461
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 02:16:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A201206C9
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 02:16:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O763oEa/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A201206C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIMzx-0000Ir-F7
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 22:16:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45726)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1kIMyW-0006wp-Ri
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 22:15:12 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a]:37221)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1kIMyU-0003vt-Ev
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 22:15:12 -0400
Received: by mail-pg1-x52a.google.com with SMTP id l71so522188pge.4
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2020 19:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=SJfuvnuIuxb8UautkTbnC/ceIfcPxqPXuVxZap91eU8=;
 b=O763oEa/fpwf3b1PkgouP2ZsF3CPc6iNsMozEknjTSzJEYHOv1QFPb+u4dwOTrEq6p
 jv/gmGOFbNjfRoUKy+fdC9zbELzAQ2dXBdRmTPRLO14gQ8d0wWZxKq74JEIgqDVmZ5My
 qmkf60mn73MduTFyTmW2KvZmPKzSEWk7y3DIXL4ACKnacrLwe3znY2KvtKD7fz0K9R3k
 rDw9cP2tbtB2X2qXTSJAjVDOvM4e/b7tfCA/MiIJEFKV5OWlEMOEHFoTfBqwgW8uW6iQ
 f6kZp+UY0sBxXStnz0epZNqzvAucQSY/FNXGsZhnUuMJXNSfSuenZlZW5JzMz0yhOFgx
 L/TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=SJfuvnuIuxb8UautkTbnC/ceIfcPxqPXuVxZap91eU8=;
 b=bZstCT8wGj4fdqs1wpPh3gaMjV20cxx1lDbo+YBaZFEKm+v1jRAHSJb4CUs4Pumu3C
 oDj8/4X1mbisrLAR9JS5a2OhzTBUaSrkHgGMFPyPkFS9toljZyK1jXqyNvrBoa+RZL9l
 YoFcOzN2urUIyb5h4OGd1zHs4HKdBjs2tW5krDggWdJCCvTx0qxr8P318tGmKGN0Nuur
 pEbScOPQLIL6jM5rNholpyRBKKr7YWYH9TQ9QkdJvyCedooNZmr44yTpZtCfmMGnTupT
 LgBf8fmKQQ/3K6Pja4WX4YDzvJH64BA7GndcNE4StnILtY9dfRWGagd47YXcacG1wST+
 lWjQ==
X-Gm-Message-State: AOAM531mCYIUffWzHX5x4TGuRe71p79CYQDXXOvzxZzeTVgWcdSTMR4r
 sAsCfnxL80b0xfsljv0oF5Y=
X-Google-Smtp-Source: ABdhPJy+DTLmhGlOfoQHbc6Q8ntsH2v9l4ET3utN5G5LHSawnGjFWIjx7BSdO/9OtCHiFpFjGFxXsg==
X-Received: by 2002:aa7:8216:0:b029:142:2501:3968 with SMTP id
 k22-20020aa782160000b029014225013968mr4389432pfi.45.1600222508813; 
 Tue, 15 Sep 2020 19:15:08 -0700 (PDT)
Received: from software.domain.org ([45.77.13.216])
 by smtp.gmail.com with ESMTPSA id y29sm16149486pfq.207.2020.09.15.19.15.05
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 15 Sep 2020 19:15:08 -0700 (PDT)
From: Huacai Chen <zltjiangshi@gmail.com>
X-Google-Original-From: Huacai Chen <chenhc@lemote.com>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Subject: [PATCH V9 5/6] target/mips: Add loongson-ext lsdc2 group of
 instructions
Date: Wed, 16 Sep 2020 10:12:23 +0800
Message-Id: <1600222344-16808-6-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1600222344-16808-1-git-send-email-chenhc@lemote.com>
References: <1600222344-16808-1-git-send-email-chenhc@lemote.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=zltjiangshi@gmail.com; helo=mail-pg1-x52a.google.com
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
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Huacai Chen <chenhc@lemote.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jiaxun Yang <jiaxun.yang@flygoat.com>

LDC2/SDC2 opcodes have been rewritten as "load & store with offset"
group of instructions by loongson-ext ASE.

This patch add implementation of these instructions:
gslbx: load 1 bytes to GPR
gslhx: load 2 bytes to GPR
gslwx: load 4 bytes to GPR
gsldx: load 8 bytes to GPR
gslwxc1: load 4 bytes to FPR
gsldxc1: load 8 bytes to FPR
gssbx: store 1 bytes from GPR
gsshx: store 2 bytes from GPR
gsswx: store 4 bytes from GPR
gssdx: store 8 bytes from GPR
gsswxc1: store 4 bytes from FPR
gssdxc1: store 8 bytes from FPR

Details of Loongson-EXT is here:
https://github.com/FlyGoat/loongson-insn/blob/master/loongson-ext.md

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 target/mips/translate.c | 179 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 179 insertions(+)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 2bcf1ce..c7ec8cf 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -484,6 +484,24 @@ enum {
     OPC_GSSDRC1     = 0x7 | OPC_GSSHFS,
 };
 
+/* Loongson EXT LDC2/SDC2 opcodes */
+#define MASK_LOONGSON_LSDC2(op)           (MASK_OP_MAJOR(op) | (op & 0x7))
+
+enum {
+    OPC_GSLBX      = 0x0 | OPC_LDC2,
+    OPC_GSLHX      = 0x1 | OPC_LDC2,
+    OPC_GSLWX      = 0x2 | OPC_LDC2,
+    OPC_GSLDX      = 0x3 | OPC_LDC2,
+    OPC_GSLWXC1    = 0x6 | OPC_LDC2,
+    OPC_GSLDXC1    = 0x7 | OPC_LDC2,
+    OPC_GSSBX      = 0x0 | OPC_SDC2,
+    OPC_GSSHX      = 0x1 | OPC_SDC2,
+    OPC_GSSWX      = 0x2 | OPC_SDC2,
+    OPC_GSSDX      = 0x3 | OPC_SDC2,
+    OPC_GSSWXC1    = 0x6 | OPC_SDC2,
+    OPC_GSSDXC1    = 0x7 | OPC_SDC2,
+};
+
 /* BSHFL opcodes */
 #define MASK_BSHFL(op)              (MASK_SPECIAL3(op) | (op & (0x1F << 6)))
 
@@ -6166,6 +6184,165 @@ static void gen_loongson_lswc2(DisasContext *ctx, int rt,
     tcg_temp_free(t0);
 }
 
+/* Loongson EXT LDC2/SDC2 */
+static void gen_loongson_lsdc2(DisasContext *ctx, int rt,
+                                int rs, int rd)
+{
+    int offset = (int8_t)(ctx->opcode >> 3);
+    uint32_t opc = MASK_LOONGSON_LSDC2(ctx->opcode);
+    TCGv t0, t1;
+    TCGv_i32 fp0;
+
+    /* Pre-conditions */
+    switch (opc) {
+    case OPC_GSLBX:
+    case OPC_GSLHX:
+    case OPC_GSLWX:
+    case OPC_GSLDX:
+        /* prefetch, implement as NOP */
+        if (rt == 0) {
+            return;
+        }
+        break;
+    case OPC_GSSBX:
+    case OPC_GSSHX:
+    case OPC_GSSWX:
+    case OPC_GSSDX:
+        break;
+    case OPC_GSLWXC1:
+#if defined(TARGET_MIPS64)
+    case OPC_GSLDXC1:
+#endif
+        check_cp1_enabled(ctx);
+        /* prefetch, implement as NOP */
+        if (rt == 0) {
+            return;
+        }
+        break;
+    case OPC_GSSWXC1:
+#if defined(TARGET_MIPS64)
+    case OPC_GSSDXC1:
+#endif
+        check_cp1_enabled(ctx);
+        break;
+    default:
+        MIPS_INVAL("loongson_lsdc2");
+        generate_exception_end(ctx, EXCP_RI);
+        return;
+        break;
+    }
+
+    t0 = tcg_temp_new();
+
+    gen_base_offset_addr(ctx, t0, rs, offset);
+    gen_op_addr_add(ctx, t0, cpu_gpr[rd], t0);
+
+    switch (opc) {
+    case OPC_GSLBX:
+        tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, MO_SB);
+        gen_store_gpr(t0, rt);
+        break;
+    case OPC_GSLHX:
+        tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, MO_TESW |
+                            ctx->default_tcg_memop_mask);
+        gen_store_gpr(t0, rt);
+        break;
+    case OPC_GSLWX:
+        gen_base_offset_addr(ctx, t0, rs, offset);
+        if (rd) {
+            gen_op_addr_add(ctx, t0, cpu_gpr[rd], t0);
+        }
+        tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, MO_TESL |
+                            ctx->default_tcg_memop_mask);
+        gen_store_gpr(t0, rt);
+        break;
+#if defined(TARGET_MIPS64)
+    case OPC_GSLDX:
+        gen_base_offset_addr(ctx, t0, rs, offset);
+        if (rd) {
+            gen_op_addr_add(ctx, t0, cpu_gpr[rd], t0);
+        }
+        tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, MO_TEQ |
+                            ctx->default_tcg_memop_mask);
+        gen_store_gpr(t0, rt);
+        break;
+#endif
+    case OPC_GSLWXC1:
+        check_cp1_enabled(ctx);
+        gen_base_offset_addr(ctx, t0, rs, offset);
+        if (rd) {
+            gen_op_addr_add(ctx, t0, cpu_gpr[rd], t0);
+        }
+        fp0 = tcg_temp_new_i32();
+        tcg_gen_qemu_ld_i32(fp0, t0, ctx->mem_idx, MO_TESL |
+                            ctx->default_tcg_memop_mask);
+        gen_store_fpr32(ctx, fp0, rt);
+        tcg_temp_free_i32(fp0);
+        break;
+#if defined(TARGET_MIPS64)
+    case OPC_GSLDXC1:
+        check_cp1_enabled(ctx);
+        gen_base_offset_addr(ctx, t0, rs, offset);
+        if (rd) {
+            gen_op_addr_add(ctx, t0, cpu_gpr[rd], t0);
+        }
+        tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, MO_TEQ |
+                            ctx->default_tcg_memop_mask);
+        gen_store_fpr64(ctx, t0, rt);
+        break;
+#endif
+    case OPC_GSSBX:
+        t1 = tcg_temp_new();
+        gen_load_gpr(t1, rt);
+        tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, MO_SB);
+        tcg_temp_free(t1);
+        break;
+    case OPC_GSSHX:
+        t1 = tcg_temp_new();
+        gen_load_gpr(t1, rt);
+        tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, MO_TEUW |
+                            ctx->default_tcg_memop_mask);
+        tcg_temp_free(t1);
+        break;
+    case OPC_GSSWX:
+        t1 = tcg_temp_new();
+        gen_load_gpr(t1, rt);
+        tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, MO_TEUL |
+                            ctx->default_tcg_memop_mask);
+        tcg_temp_free(t1);
+        break;
+#if defined(TARGET_MIPS64)
+    case OPC_GSSDX:
+        t1 = tcg_temp_new();
+        gen_load_gpr(t1, rt);
+        tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, MO_TEQ |
+                            ctx->default_tcg_memop_mask);
+        tcg_temp_free(t1);
+        break;
+#endif
+    case OPC_GSSWXC1:
+        fp0 = tcg_temp_new_i32();
+        gen_load_fpr32(ctx, fp0, rt);
+        tcg_gen_qemu_st_i32(fp0, t0, ctx->mem_idx, MO_TEUL |
+                            ctx->default_tcg_memop_mask);
+        tcg_temp_free_i32(fp0);
+        break;
+#if defined(TARGET_MIPS64)
+    case OPC_GSSDXC1:
+        t1 = tcg_temp_new();
+        gen_load_fpr64(ctx, t1, rt);
+        tcg_gen_qemu_st_i64(t1, t0, ctx->mem_idx, MO_TEQ |
+                            ctx->default_tcg_memop_mask);
+        tcg_temp_free(t1);
+        break;
+#endif
+    default:
+        break;
+    }
+
+    tcg_temp_free(t0);
+}
+
 /* Traps */
 static void gen_trap(DisasContext *ctx, uint32_t opc,
                      int rs, int rt, int16_t imm)
@@ -31049,6 +31226,8 @@ static void decode_opc(CPUMIPSState *env, DisasContext *ctx)
                 /* OPC_JIC, OPC_JIALC */
                 gen_compute_compact_branch(ctx, op, 0, rt, imm);
             }
+        } else if (ctx->insn_flags & ASE_LEXT) {
+            gen_loongson_lsdc2(ctx, rt, rs, rd);
         } else {
             /* OPC_LWC2, OPC_SWC2 */
             /* COP2: Not implemented. */
-- 
2.7.0



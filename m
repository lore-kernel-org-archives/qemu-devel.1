Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AB75C2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 09:53:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA0C8204EA
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 09:53:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rSmTG4Pj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA0C8204EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMpqj-0008DY-Lu
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 05:53:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56060)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1kMppL-0006yI-9a
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 05:52:11 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432]:42347)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1kMppG-00071r-MM
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 05:52:10 -0400
Received: by mail-pf1-x432.google.com with SMTP id d6so484451pfn.9
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2020 02:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=D6iiIz227df4UnhGBpVBE1iUkHKjfa+M0wTeStzOqDo=;
 b=rSmTG4PjEMrgfAcx6yQ5G5IEbzhRMGK1XEHYNRjdBkPSW2yMXkfQcErWaN3icMgFYN
 ZjizRF2QJ7+mFsj97rVpqrdbsGjRvtg2MSdk3f/GyxsVsjdiFBTQhI80ZvxgHAOHjcqG
 2w5LtD3gRxvACAGODeTxMrC+tMUEte02HVsHvUEO/VujlNFGR/NJOwNFowIgc0ntmFB7
 aXOZuIX8NscxRcUk/tJpUZu0B2Kor6ZuZ3RnQa8RXTX4nJTdvjPhhwzqT+BfDhh4Yprw
 z8A6GGajhi+Whn6rjuLhymucHWNAd6tOuDCbMZxIkxPkcL9F+FiZLkVzdFanf7ikh5YU
 XUhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=D6iiIz227df4UnhGBpVBE1iUkHKjfa+M0wTeStzOqDo=;
 b=K1yfS6xr0dRiXB7PVFDWGmoUyNavkVcNtjOXcgoE8PFkn1bk75KbKT1d5qgASnbizO
 z/FB8QAk0F3Y9dy4wpBhz+g71d97mOr9pz9uNAupru7lRhsmnoMwRuYiUodgQ+OMQ+FC
 mY/Eio6yEzH2u/SuzjAIz6AYyKy9jcsp2hKbZLhRK1BhrnWIhEXkzRD8bSsfo4G3DpWQ
 97bcJlF6/1LSDpIj+QBQqGKh3S/sq+HY+OrT1IZphQpThoenBTMLzNMaA0PtqEBA+uf6
 bf3nP389V9rkAqj5o0Nze7VmKjC9hTgcwd5IN18HkA7xZBX2nQwRNafYWEkHxVjAt/C4
 HLkQ==
X-Gm-Message-State: AOAM5306+tS4gQnbYFXMqOR1ND1+7DcPVWVNB9HwaQpisKH9149s7XEA
 xHeDpLKW++271Bx7F2FTLgg=
X-Google-Smtp-Source: ABdhPJyHDcNYc5bvtCcm7MHPAM2fingV81SuIQSWo/9AObesyIJJ++e41UaC4J1q21YWSoIqaNUVow==
X-Received: by 2002:a65:5a02:: with SMTP id y2mr565371pgs.26.1601286725259;
 Mon, 28 Sep 2020 02:52:05 -0700 (PDT)
Received: from software.domain.org ([45.77.13.216])
 by smtp.gmail.com with ESMTPSA id j4sm865417pfj.143.2020.09.28.02.52.01
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 28 Sep 2020 02:52:04 -0700 (PDT)
From: Huacai Chen <zltjiangshi@gmail.com>
X-Google-Original-From: Huacai Chen <chenhc@lemote.com>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Subject: [PATCH V12 3/8] target/mips: Add loongson-ext lswc2 group of
 instructions (Part 1)
Date: Mon, 28 Sep 2020 17:49:41 +0800
Message-Id: <1601286586-1810-4-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1601286586-1810-1-git-send-email-chenhc@lemote.com>
References: <1601286586-1810-1-git-send-email-chenhc@lemote.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=zltjiangshi@gmail.com; helo=mail-pf1-x432.google.com
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

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 target/mips/translate.c | 87 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 398edf7..cb0adde 100644
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
 
@@ -5910,6 +5921,80 @@ no_rd:
     tcg_temp_free_i64(t1);
 }
 
+static void gen_loongson_lswc2(DisasContext *ctx, int rt,
+                                int rs, int rd)
+{
+    TCGv t0, t1, t2;
+    TCGv_i32 fp0;
+#if defined(TARGET_MIPS64)
+    int lsq_rt1 = ctx->opcode & 0x1f;
+    int lsq_offset = ((int)((ctx->opcode >> 6) & 0x1ff) << 23) >> 19;
+#endif
+    int shf_offset = (int8_t)(ctx->opcode >> 6);
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
@@ -30774,6 +30859,8 @@ static void decode_opc(CPUMIPSState *env, DisasContext *ctx)
             /* OPC_BC, OPC_BALC */
             gen_compute_compact_branch(ctx, op, 0, 0,
                                        sextract32(ctx->opcode << 2, 0, 28));
+        } else if (ctx->insn_flags & ASE_LEXT) {
+            gen_loongson_lswc2(ctx, rt, rs, rd);
         } else {
             /* OPC_LWC2, OPC_SWC2 */
             /* COP2: Not implemented. */
-- 
2.7.0



Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17504C4363C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 08:47:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B0FC21D7A
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 08:47:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NnRljx8B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B0FC21D7A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQ56o-0002Tb-2c
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 04:47:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50662)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1kQ52y-0007yK-Ep
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 04:43:41 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431]:36000)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1kQ52s-0002cJ-L4
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 04:43:40 -0400
Received: by mail-pf1-x431.google.com with SMTP id b26so952995pff.3
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2020 01:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=tV9wfM08qK1md651scVvF7oqkhy4mXbnUPVNtx2QJbo=;
 b=NnRljx8BfKzEwCwLPuI5sDNNEyCiDYC3+vC9UDziILX2sRrFrhFnC37bMDYebERL2P
 FFwHjo9yJ3WWh+z2Qn1op8Fjh1CV5INbmwnn/bXNkh/BPhAmUgMlp04XOnqgx8kclQ9Z
 qcr/b8Jsl5VZml+R67BAXvgWupvgRyN40rPV6c2pNGjQQaeIa1irc3Vap0IxIOfYNFjv
 xvk/qJWWFvdAz8lISyodxkadH3do0l7pKnRBnlx1kaMPcI9VWh2hHVXBCcb04FBX5huy
 86edPEBt5XXTlkFemUdhE5oxSb0EIt5TGrpADLlKOnSEV57CKW4dcNiwFYInveLc7Qy4
 LScw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=tV9wfM08qK1md651scVvF7oqkhy4mXbnUPVNtx2QJbo=;
 b=Je9AVHA89yUpypqjRralzllqG2ZOSs7HB6A4wShvwERc/lIEcd17lL8SWvK3toDy9V
 VelJxr0aWsjqpPQFRybVosG9qyImlhTfl4m0VTc4Jm4zqe3o1IEM9i0ly7XCU0OdCMfl
 kL6UDPr3TBkcPkOU/+kAW4H1N9wSCjoc/TxCIgsRmELTnR1RTVaeg8j0GMmHil6i0x7s
 zb41f2SkKe89Xn7WNNeHXStilaX54V6GOeA7uQnnXxNsp23njOsju5Xn2hxBwUxXDdqt
 3MrwQkc9R/YLqa9NNWJ9hz8KWA8P9bBVcwgrzr3iBezd6+lPqCUdX3ws9AhqKOA/4Sm2
 CdPA==
X-Gm-Message-State: AOAM530OGn+620+pXBM4OZl0NlZyyYiqQ4woUaAde8SgQ+eg1Jf/8OTO
 dGc6te3ZG1ftIWvXC9pLnRM=
X-Google-Smtp-Source: ABdhPJzqRI6ydjODgu6Xq8ZFEcIDDAAQuNhgdy8OB/izZCiifUxhbBDzfWh/qAQeCoc9h13XOtjYbQ==
X-Received: by 2002:a63:cc0e:: with SMTP id x14mr2095564pgf.321.1602060213020; 
 Wed, 07 Oct 2020 01:43:33 -0700 (PDT)
Received: from software.domain.org ([45.77.13.216])
 by smtp.gmail.com with ESMTPSA id i9sm1999692pfq.53.2020.10.07.01.43.29
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 07 Oct 2020 01:43:32 -0700 (PDT)
From: Huacai Chen <zltjiangshi@gmail.com>
X-Google-Original-From: Huacai Chen <chenhc@lemote.com>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Subject: [PATCH V13 5/9] target/mips: Add loongson-ext lswc2 group of
 instructions (Part 2)
Date: Wed,  7 Oct 2020 16:39:31 +0800
Message-Id: <1602059975-10115-6-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1602059975-10115-1-git-send-email-chenhc@lemote.com>
References: <1602059975-10115-1-git-send-email-chenhc@lemote.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=zltjiangshi@gmail.com; helo=mail-pf1-x431.google.com
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

LWC2 & SWC2 have been rewritten by Loongson EXT vendor ASE
as "load/store quad word" and "shifted load/store" groups of
instructions.

This patch add implementation of these instructions:
gslwlc1: similar to lwl but RT is FPR instead of GPR
gslwrc1: similar to lwr but RT is FPR instead of GPR
gsldlc1: similar to ldl but RT is FPR instead of GPR
gsldrc1: similar to ldr but RT is FPR instead of GPR
gsswlc1: similar to swl but RT is FPR instead of GPR
gsswrc1: similar to swr but RT is FPR instead of GPR
gssdlc1: similar to sdl but RT is FPR instead of GPR
gssdrc1: similar to sdr but RT is FPR instead of GPR

Details of Loongson-EXT is here:
https://github.com/FlyGoat/loongson-insn/blob/master/loongson-ext.md

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 target/mips/translate.c | 177 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 177 insertions(+)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index cb0adde..916b57f 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -471,6 +471,19 @@ enum {
     OPC_GSSHFS      = OPC_SWC2,
 };
 
+/* Loongson EXT shifted load/store opcodes */
+#define MASK_LOONGSON_GSSHFLS(op)         (MASK_OP_MAJOR(op) | (op & 0xc03f))
+enum {
+    OPC_GSLWLC1     = 0x4 | OPC_GSSHFL,
+    OPC_GSLWRC1     = 0x5 | OPC_GSSHFL,
+    OPC_GSLDLC1     = 0x6 | OPC_GSSHFL,
+    OPC_GSLDRC1     = 0x7 | OPC_GSSHFL,
+    OPC_GSSWLC1     = 0x4 | OPC_GSSHFS,
+    OPC_GSSWRC1     = 0x5 | OPC_GSSHFS,
+    OPC_GSSDLC1     = 0x6 | OPC_GSSHFS,
+    OPC_GSSDRC1     = 0x7 | OPC_GSSHFS,
+};
+
 /* BSHFL opcodes */
 #define MASK_BSHFL(op)              (MASK_SPECIAL3(op) | (op & (0x1F << 6)))
 
@@ -5987,6 +6000,170 @@ static void gen_loongson_lswc2(DisasContext *ctx, int rt,
         tcg_temp_free(t1);
         break;
 #endif
+    case OPC_GSSHFL:
+        switch (MASK_LOONGSON_GSSHFLS(ctx->opcode)) {
+        case OPC_GSLWLC1:
+            check_cp1_enabled(ctx);
+            gen_base_offset_addr(ctx, t0, rs, shf_offset);
+            t1 = tcg_temp_new();
+            tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, MO_UB);
+            tcg_gen_andi_tl(t1, t0, 3);
+#ifndef TARGET_WORDS_BIGENDIAN
+            tcg_gen_xori_tl(t1, t1, 3);
+#endif
+            tcg_gen_shli_tl(t1, t1, 3);
+            tcg_gen_andi_tl(t0, t0, ~3);
+            tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, MO_TEUL);
+            tcg_gen_shl_tl(t0, t0, t1);
+            t2 = tcg_const_tl(-1);
+            tcg_gen_shl_tl(t2, t2, t1);
+            fp0 = tcg_temp_new_i32();
+            gen_load_fpr32(ctx, fp0, rt);
+            tcg_gen_ext_i32_tl(t1, fp0);
+            tcg_gen_andc_tl(t1, t1, t2);
+            tcg_temp_free(t2);
+            tcg_gen_or_tl(t0, t0, t1);
+            tcg_temp_free(t1);
+#if defined(TARGET_MIPS64)
+            tcg_gen_extrl_i64_i32(fp0, t0);
+#else
+            tcg_gen_ext32s_tl(fp0, t0);
+#endif
+            gen_store_fpr32(ctx, fp0, rt);
+            tcg_temp_free_i32(fp0);
+            break;
+        case OPC_GSLWRC1:
+            check_cp1_enabled(ctx);
+            gen_base_offset_addr(ctx, t0, rs, shf_offset);
+            t1 = tcg_temp_new();
+            tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, MO_UB);
+            tcg_gen_andi_tl(t1, t0, 3);
+#ifdef TARGET_WORDS_BIGENDIAN
+            tcg_gen_xori_tl(t1, t1, 3);
+#endif
+            tcg_gen_shli_tl(t1, t1, 3);
+            tcg_gen_andi_tl(t0, t0, ~3);
+            tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, MO_TEUL);
+            tcg_gen_shr_tl(t0, t0, t1);
+            tcg_gen_xori_tl(t1, t1, 31);
+            t2 = tcg_const_tl(0xfffffffeull);
+            tcg_gen_shl_tl(t2, t2, t1);
+            fp0 = tcg_temp_new_i32();
+            gen_load_fpr32(ctx, fp0, rt);
+            tcg_gen_ext_i32_tl(t1, fp0);
+            tcg_gen_and_tl(t1, t1, t2);
+            tcg_temp_free(t2);
+            tcg_gen_or_tl(t0, t0, t1);
+            tcg_temp_free(t1);
+#if defined(TARGET_MIPS64)
+            tcg_gen_extrl_i64_i32(fp0, t0);
+#else
+            tcg_gen_ext32s_tl(fp0, t0);
+#endif
+            gen_store_fpr32(ctx, fp0, rt);
+            tcg_temp_free_i32(fp0);
+            break;
+#if defined(TARGET_MIPS64)
+        case OPC_GSLDLC1:
+            check_cp1_enabled(ctx);
+            gen_base_offset_addr(ctx, t0, rs, shf_offset);
+            t1 = tcg_temp_new();
+            tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, MO_UB);
+            tcg_gen_andi_tl(t1, t0, 7);
+#ifndef TARGET_WORDS_BIGENDIAN
+            tcg_gen_xori_tl(t1, t1, 7);
+#endif
+            tcg_gen_shli_tl(t1, t1, 3);
+            tcg_gen_andi_tl(t0, t0, ~7);
+            tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, MO_TEQ);
+            tcg_gen_shl_tl(t0, t0, t1);
+            t2 = tcg_const_tl(-1);
+            tcg_gen_shl_tl(t2, t2, t1);
+            gen_load_fpr64(ctx, t1, rt);
+            tcg_gen_andc_tl(t1, t1, t2);
+            tcg_temp_free(t2);
+            tcg_gen_or_tl(t0, t0, t1);
+            tcg_temp_free(t1);
+            gen_store_fpr64(ctx, t0, rt);
+            break;
+        case OPC_GSLDRC1:
+            check_cp1_enabled(ctx);
+            gen_base_offset_addr(ctx, t0, rs, shf_offset);
+            t1 = tcg_temp_new();
+            tcg_gen_qemu_ld_tl(t1, t0, ctx->mem_idx, MO_UB);
+            tcg_gen_andi_tl(t1, t0, 7);
+#ifdef TARGET_WORDS_BIGENDIAN
+            tcg_gen_xori_tl(t1, t1, 7);
+#endif
+            tcg_gen_shli_tl(t1, t1, 3);
+            tcg_gen_andi_tl(t0, t0, ~7);
+            tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, MO_TEQ);
+            tcg_gen_shr_tl(t0, t0, t1);
+            tcg_gen_xori_tl(t1, t1, 63);
+            t2 = tcg_const_tl(0xfffffffffffffffeull);
+            tcg_gen_shl_tl(t2, t2, t1);
+            gen_load_fpr64(ctx, t1, rt);
+            tcg_gen_and_tl(t1, t1, t2);
+            tcg_temp_free(t2);
+            tcg_gen_or_tl(t0, t0, t1);
+            tcg_temp_free(t1);
+            gen_store_fpr64(ctx, t0, rt);
+            break;
+#endif
+        default:
+            MIPS_INVAL("loongson_gsshfl");
+            generate_exception_end(ctx, EXCP_RI);
+            break;
+        }
+        break;
+    case OPC_GSSHFS:
+        switch (MASK_LOONGSON_GSSHFLS(ctx->opcode)) {
+        case OPC_GSSWLC1:
+            check_cp1_enabled(ctx);
+            t1 = tcg_temp_new();
+            gen_base_offset_addr(ctx, t0, rs, shf_offset);
+            fp0 = tcg_temp_new_i32();
+            gen_load_fpr32(ctx, fp0, rt);
+            tcg_gen_ext_i32_tl(t1, fp0);
+            gen_helper_0e2i(swl, t1, t0, ctx->mem_idx);
+            tcg_temp_free_i32(fp0);
+            tcg_temp_free(t1);
+            break;
+        case OPC_GSSWRC1:
+            check_cp1_enabled(ctx);
+            t1 = tcg_temp_new();
+            gen_base_offset_addr(ctx, t0, rs, shf_offset);
+            fp0 = tcg_temp_new_i32();
+            gen_load_fpr32(ctx, fp0, rt);
+            tcg_gen_ext_i32_tl(t1, fp0);
+            gen_helper_0e2i(swr, t1, t0, ctx->mem_idx);
+            tcg_temp_free_i32(fp0);
+            tcg_temp_free(t1);
+            break;
+#if defined(TARGET_MIPS64)
+        case OPC_GSSDLC1:
+            check_cp1_enabled(ctx);
+            t1 = tcg_temp_new();
+            gen_base_offset_addr(ctx, t0, rs, shf_offset);
+            gen_load_fpr64(ctx, t1, rt);
+            gen_helper_0e2i(sdl, t1, t0, ctx->mem_idx);
+            tcg_temp_free(t1);
+            break;
+        case OPC_GSSDRC1:
+            check_cp1_enabled(ctx);
+            t1 = tcg_temp_new();
+            gen_base_offset_addr(ctx, t0, rs, shf_offset);
+            gen_load_fpr64(ctx, t1, rt);
+            gen_helper_0e2i(sdr, t1, t0, ctx->mem_idx);
+            tcg_temp_free(t1);
+            break;
+#endif
+        default:
+            MIPS_INVAL("loongson_gsshfs");
+            generate_exception_end(ctx, EXCP_RI);
+            break;
+        }
+        break;
     default:
         MIPS_INVAL("loongson_gslsq");
         generate_exception_end(ctx, EXCP_RI);
-- 
2.7.0



Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5692C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 11:55:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A09AE2064B
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 11:55:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TwBVHhUN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A09AE2064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnhWb-0005Ou-R6
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 07:55:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44110)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jnhH1-0002vT-GQ
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 07:39:31 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:44681)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jnhGy-0003Ep-QC
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 07:39:30 -0400
Received: by mail-wr1-x42e.google.com with SMTP id b6so20155035wrs.11
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 04:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=7ABA729UVkpFOfH4LLy6vk4NgixPmbR3i5MHSNOuZUk=;
 b=TwBVHhUNeNHeBVExzduvB76aSjvylzK0ZQfhj6uwN+/oBK0Ih0uyoDSDZ6aBD0/Qer
 T0ybRjB5xn2fHpxkXigNuf/Ew4aX8iquATdaCx335rvSJ19oq7d4Q+LOZjIA/PNxiOVG
 FBNL5NkhlEHcCdjyjiCXkHNbZNj101F7iMTQgLLuphST674EDu7cFKF9meqDVYnFWBTv
 OyuBW7SrLCCA4pGiwKcmyEJ+8g6OmeKlMFssiYyujwDvoOWokJfxPikLLopwZhZOZQjH
 cfYUZok01chLGksB1GbicX1k1US8AZXXyTfeHqd+4S8+OsP578nmuPPeiuCtdNZXyrzx
 xvWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7ABA729UVkpFOfH4LLy6vk4NgixPmbR3i5MHSNOuZUk=;
 b=SqIZR3CG6hyKr27Qbgv+1wHz6VWoR5MRjSTiYmr2/Fe+aydQ2tqBEw8FYV98LyIl/S
 EHltijNx9T5tFOCQeQCAlnBF78BcffqqmZTgRWzY+MN4UEbh8BI3aJhTzqPgbnSpKqG5
 tAM449UbQJvQ2VoyBwVGiSlNQvDWE1u8npIvNY8E8cT+OYT5WO5lSEZoobuJTTPHk2Vl
 Sj2eNfz9sRf7R2n08bdP90qYNurQA39Dsj82QMZ5B4UeWXA2IjPnU6Gm21cjtNn9HPjP
 jGBOjxHiXpI/3u/2Pi8Ncdhpm3vhKjWGDNz8FDqf6kna+MUVu6l4GCRQTwffaYmDKq3g
 KAYw==
X-Gm-Message-State: AOAM530OGVaw9yLzQMTb/LnpomoBVCOohVZynQMQVikfOMqPNJsC0j2+
 ZenbXUF6UeqhWMU0/80yLm/UzoeEOOoYqw==
X-Google-Smtp-Source: ABdhPJzLCLU6/Aumf9YwWZOCb6Wsmjr2k626/PSkCgLXb5xFXhaPsQ6IEkr5tGZqannf7wp6ecJxng==
X-Received: by 2002:adf:e2ce:: with SMTP id d14mr25090255wrj.415.1592912367049; 
 Tue, 23 Jun 2020 04:39:27 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id m10sm4022177wru.4.2020.06.23.04.39.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2020 04:39:26 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 18/42] target/arm: Convert Neon 2-reg-misc fp-compare-with-zero
 insns to decodetree
Date: Tue, 23 Jun 2020 12:38:40 +0100
Message-Id: <20200623113904.28805-19-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200623113904.28805-1-peter.maydell@linaro.org>
References: <20200623113904.28805-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Convert the fp-compare-with-zero insns in the Neon 2-reg-misc group to
decodetree.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200616170844.13318-17-peter.maydell@linaro.org
---
 target/arm/neon-dp.decode       |  6 ++++
 target/arm/translate-neon.inc.c | 28 ++++++++++++++++++
 target/arm/translate.c          | 50 ++++-----------------------------
 3 files changed, 39 insertions(+), 45 deletions(-)

diff --git a/target/arm/neon-dp.decode b/target/arm/neon-dp.decode
index ea8d5fd99c3..c9acd00f1e8 100644
--- a/target/arm/neon-dp.decode
+++ b/target/arm/neon-dp.decode
@@ -479,6 +479,12 @@ Vimm_1r          1111 001 . 1 . 000 ... .... cmode:4 0 . op:1 1 .... @1reg_imm
     VABS         1111 001 11 . 11 .. 01 .... 0 0110 . . 0 .... @2misc
     VNEG         1111 001 11 . 11 .. 01 .... 0 0111 . . 0 .... @2misc
 
+    VCGT0_F      1111 001 11 . 11 .. 01 .... 0 1000 . . 0 .... @2misc
+    VCGE0_F      1111 001 11 . 11 .. 01 .... 0 1001 . . 0 .... @2misc
+    VCEQ0_F      1111 001 11 . 11 .. 01 .... 0 1010 . . 0 .... @2misc
+    VCLE0_F      1111 001 11 . 11 .. 01 .... 0 1011 . . 0 .... @2misc
+    VCLT0_F      1111 001 11 . 11 .. 01 .... 0 1100 . . 0 .... @2misc
+
     VABS_F       1111 001 11 . 11 .. 01 .... 0 1110 . . 0 .... @2misc
     VNEG_F       1111 001 11 . 11 .. 01 .... 0 1111 . . 0 .... @2misc
 
diff --git a/target/arm/translate-neon.inc.c b/target/arm/translate-neon.inc.c
index ab183e47d7d..a62da21b152 100644
--- a/target/arm/translate-neon.inc.c
+++ b/target/arm/translate-neon.inc.c
@@ -3768,3 +3768,31 @@ static bool trans_VRINTX(DisasContext *s, arg_2misc *a)
     }
     return do_2misc_fp(s, a, gen_helper_rints_exact);
 }
+
+#define WRAP_FP_CMP0_FWD(WRAPNAME, FUNC)                        \
+    static void WRAPNAME(TCGv_i32 d, TCGv_i32 m, TCGv_ptr fpst) \
+    {                                                           \
+        TCGv_i32 zero = tcg_const_i32(0);                       \
+        FUNC(d, m, zero, fpst);                                 \
+        tcg_temp_free_i32(zero);                                \
+    }
+#define WRAP_FP_CMP0_REV(WRAPNAME, FUNC)                        \
+    static void WRAPNAME(TCGv_i32 d, TCGv_i32 m, TCGv_ptr fpst) \
+    {                                                           \
+        TCGv_i32 zero = tcg_const_i32(0);                       \
+        FUNC(d, zero, m, fpst);                                 \
+        tcg_temp_free_i32(zero);                                \
+    }
+
+#define DO_FP_CMP0(INSN, FUNC, REV)                             \
+    WRAP_FP_CMP0_##REV(gen_##INSN, FUNC)                        \
+    static bool trans_##INSN(DisasContext *s, arg_2misc *a)     \
+    {                                                           \
+        return do_2misc_fp(s, a, gen_##INSN);                   \
+    }
+
+DO_FP_CMP0(VCGT0_F, gen_helper_neon_cgt_f32, FWD)
+DO_FP_CMP0(VCGE0_F, gen_helper_neon_cge_f32, FWD)
+DO_FP_CMP0(VCEQ0_F, gen_helper_neon_ceq_f32, FWD)
+DO_FP_CMP0(VCLE0_F, gen_helper_neon_cge_f32, REV)
+DO_FP_CMP0(VCLT0_F, gen_helper_neon_cgt_f32, REV)
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 48377860c75..dc98928856d 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -4954,6 +4954,11 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                 case NEON_2RM_VCVT_SF:
                 case NEON_2RM_VCVT_UF:
                 case NEON_2RM_VRINTX:
+                case NEON_2RM_VCGT0_F:
+                case NEON_2RM_VCGE0_F:
+                case NEON_2RM_VCEQ0_F:
+                case NEON_2RM_VCLE0_F:
+                case NEON_2RM_VCLT0_F:
                     /* handled by decodetree */
                     return 1;
                 case NEON_2RM_VTRN:
@@ -4975,51 +4980,6 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                     for (pass = 0; pass < (q ? 4 : 2); pass++) {
                         tmp = neon_load_reg(rm, pass);
                         switch (op) {
-                        case NEON_2RM_VCGT0_F:
-                        {
-                            TCGv_ptr fpstatus = get_fpstatus_ptr(1);
-                            tmp2 = tcg_const_i32(0);
-                            gen_helper_neon_cgt_f32(tmp, tmp, tmp2, fpstatus);
-                            tcg_temp_free_i32(tmp2);
-                            tcg_temp_free_ptr(fpstatus);
-                            break;
-                        }
-                        case NEON_2RM_VCGE0_F:
-                        {
-                            TCGv_ptr fpstatus = get_fpstatus_ptr(1);
-                            tmp2 = tcg_const_i32(0);
-                            gen_helper_neon_cge_f32(tmp, tmp, tmp2, fpstatus);
-                            tcg_temp_free_i32(tmp2);
-                            tcg_temp_free_ptr(fpstatus);
-                            break;
-                        }
-                        case NEON_2RM_VCEQ0_F:
-                        {
-                            TCGv_ptr fpstatus = get_fpstatus_ptr(1);
-                            tmp2 = tcg_const_i32(0);
-                            gen_helper_neon_ceq_f32(tmp, tmp, tmp2, fpstatus);
-                            tcg_temp_free_i32(tmp2);
-                            tcg_temp_free_ptr(fpstatus);
-                            break;
-                        }
-                        case NEON_2RM_VCLE0_F:
-                        {
-                            TCGv_ptr fpstatus = get_fpstatus_ptr(1);
-                            tmp2 = tcg_const_i32(0);
-                            gen_helper_neon_cge_f32(tmp, tmp2, tmp, fpstatus);
-                            tcg_temp_free_i32(tmp2);
-                            tcg_temp_free_ptr(fpstatus);
-                            break;
-                        }
-                        case NEON_2RM_VCLT0_F:
-                        {
-                            TCGv_ptr fpstatus = get_fpstatus_ptr(1);
-                            tmp2 = tcg_const_i32(0);
-                            gen_helper_neon_cgt_f32(tmp, tmp2, tmp, fpstatus);
-                            tcg_temp_free_i32(tmp2);
-                            tcg_temp_free_ptr(fpstatus);
-                            break;
-                        }
                         case NEON_2RM_VSWP:
                             tmp2 = neon_load_reg(rd, pass);
                             neon_store_reg(rm, pass, tmp2);
-- 
2.20.1



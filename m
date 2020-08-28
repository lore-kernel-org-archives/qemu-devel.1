Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56E47C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 14:37:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 220E020757
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 14:37:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HAGpYxz7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 220E020757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBfVj-0001sB-DS
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 10:37:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51486)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBfEx-0001CB-7O
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 10:20:27 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:43219)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBfEv-0005F5-8J
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 10:20:26 -0400
Received: by mail-pg1-x543.google.com with SMTP id d19so517032pgl.10
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 07:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2qRjDe/fKYjb4A+1fYr4Tr7VDgkxS0k1+OZKcZn8JeA=;
 b=HAGpYxz7OLQtR6GzgNuIJ+RM1TWi2yy6QIJiIop2ZxyeDivAsLAJCuRDIyhj4JWzgi
 t4zAcmPkqTFE1Rm9jcF98GiQG22BFGcxNOm1QIR6UWmH+M51REndv3wnN/W6k6XVcnQm
 Vv59Gi0A1RMw4thcy80BkS2kSLOp1iUajiVv6ONN/Gq9mYW1NGFpEC43llpvlI5i0WMc
 4UVw2qABTU2TP0HoeSf98vjJiysuJOsq+zFf5I6/wSN5rUn+ziEhB/7z3alMU+2M16Ku
 W6nAvj2cf7Os0TBoyyEJfvQBrOHpmefqMk0UhLX/oLw8WZ6AaiFsqnDnqGgT+Ojp0lQq
 VQ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2qRjDe/fKYjb4A+1fYr4Tr7VDgkxS0k1+OZKcZn8JeA=;
 b=c61e7+FTmN48ahnMrRxnWM4+XPJ75kPRC1itEBqZSG9Gf0I3gyMFR069l7dG8dMvzR
 7+KfRJvEXsA8AijH4YwyJ+TvommJm3qt0a2Qrw3FGhHYQ/96FiP7FHy0Bb8wxotACgpm
 dsDWPzHO858RPZ5IYz0Jfr3so3jqzkDz4u6nCWpQw9umVgkDZrg4P5TgMZHBVlLsDPy1
 MEGcYugIKKNq5/yIO+F32qxQwYGrkX55I+TwFoNNiBwklWdLoInX4vZq1qI5U0mr2IPd
 y3OyMrK0oip9PW60gi3Okg9fIqp2ksH3DK9agiOLDzWCr9hLNEXkAaOrkGLeBQiVSLoh
 S+jA==
X-Gm-Message-State: AOAM530staTnZlEkZjHPVRMVeuMNtPOMWNog+C3yfW0PikfQGWfZFnVi
 Kl9TFfZsuNSbGap2wGVcYAGre6tWWSRlwA==
X-Google-Smtp-Source: ABdhPJyhPdHUuw5RnWy11RDpu9Cnwib/Ykmy73HVTPMt7HSfztf+SRn7PLh3b7a8pW/yMMIYQU+HIw==
X-Received: by 2002:a65:568b:: with SMTP id v11mr1409464pgs.396.1598624423310; 
 Fri, 28 Aug 2020 07:20:23 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id j3sm1403080pjw.23.2020.08.28.07.20.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 07:20:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 41/76] target/microblaze: Convert dec_mul to decodetree
Date: Fri, 28 Aug 2020 07:18:54 -0700
Message-Id: <20200828141929.77854-42-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200828141929.77854-1-richard.henderson@linaro.org>
References: <20200828141929.77854-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x543.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: edgar.iglesias@xilinx.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/insns.decode |  6 +++
 target/microblaze/translate.c  | 77 ++++++++++++++--------------------
 2 files changed, 37 insertions(+), 46 deletions(-)

diff --git a/target/microblaze/insns.decode b/target/microblaze/insns.decode
index 93bd51c78b..1a2e22e44a 100644
--- a/target/microblaze/insns.decode
+++ b/target/microblaze/insns.decode
@@ -50,6 +50,12 @@ andni           101011 ..... ..... ................     @typeb
 cmp             000101 ..... ..... ..... 000 0000 0001  @typea
 cmpu            000101 ..... ..... ..... 000 0000 0011  @typea
 
+mul             010000 ..... ..... ..... 000 0000 0000  @typea
+mulh            010000 ..... ..... ..... 000 0000 0001  @typea
+mulhu           010000 ..... ..... ..... 000 0000 0011  @typea
+mulhsu          010000 ..... ..... ..... 000 0000 0010  @typea
+muli            011000 ..... ..... ................     @typeb
+
 or              100000 ..... ..... ..... 000 0000 0000  @typea
 ori             101000 ..... ..... ................     @typeb
 
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index a143f17e9d..617e208583 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -287,6 +287,10 @@ static bool do_typeb_val(DisasContext *dc, arg_typeb *arg, bool side_effects,
     static bool trans_##NAME(DisasContext *dc, arg_typeb *a) \
     { return do_typeb_imm(dc, a, SE, FNI); }
 
+#define DO_TYPEBI_CFG(NAME, CFG, SE, FNI) \
+    static bool trans_##NAME(DisasContext *dc, arg_typeb *a) \
+    { return dc->cpu->cfg.CFG && do_typeb_imm(dc, a, SE, FNI); }
+
 #define DO_TYPEBV(NAME, SE, FN) \
     static bool trans_##NAME(DisasContext *dc, arg_typeb *a) \
     { return do_typeb_val(dc, a, SE, FN); }
@@ -364,6 +368,33 @@ static void gen_cmpu(TCGv_i32 out, TCGv_i32 ina, TCGv_i32 inb)
 DO_TYPEA(cmp, false, gen_cmp)
 DO_TYPEA(cmpu, false, gen_cmpu)
 
+static void gen_mulh(TCGv_i32 out, TCGv_i32 ina, TCGv_i32 inb)
+{
+    TCGv_i32 tmp = tcg_temp_new_i32();
+    tcg_gen_muls2_i32(tmp, out, ina, inb);
+    tcg_temp_free_i32(tmp);
+}
+
+static void gen_mulhu(TCGv_i32 out, TCGv_i32 ina, TCGv_i32 inb)
+{
+    TCGv_i32 tmp = tcg_temp_new_i32();
+    tcg_gen_mulu2_i32(tmp, out, ina, inb);
+    tcg_temp_free_i32(tmp);
+}
+
+static void gen_mulhsu(TCGv_i32 out, TCGv_i32 ina, TCGv_i32 inb)
+{
+    TCGv_i32 tmp = tcg_temp_new_i32();
+    tcg_gen_mulsu2_i32(tmp, out, ina, inb);
+    tcg_temp_free_i32(tmp);
+}
+
+DO_TYPEA_CFG(mul, use_hw_mul, false, tcg_gen_mul_i32)
+DO_TYPEA_CFG(mulh, use_hw_mul >= 2, false, gen_mulh)
+DO_TYPEA_CFG(mulhu, use_hw_mul >= 2, false, gen_mulhu)
+DO_TYPEA_CFG(mulhsu, use_hw_mul >= 2, false, gen_mulhsu)
+DO_TYPEBI_CFG(muli, use_hw_mul, false, tcg_gen_muli_i32)
+
 DO_TYPEA(or, false, tcg_gen_or_i32)
 DO_TYPEBI(ori, false, tcg_gen_ori_i32)
 
@@ -652,51 +683,6 @@ static void dec_msr(DisasContext *dc)
     }
 }
 
-/* Multiplier unit.  */
-static void dec_mul(DisasContext *dc)
-{
-    TCGv_i32 tmp;
-    unsigned int subcode;
-
-    if (trap_illegal(dc, !dc->cpu->cfg.use_hw_mul)) {
-        return;
-    }
-
-    subcode = dc->imm & 3;
-
-    if (dc->type_b) {
-        tcg_gen_mul_i32(cpu_R[dc->rd], cpu_R[dc->ra], *(dec_alu_op_b(dc)));
-        return;
-    }
-
-    /* mulh, mulhsu and mulhu are not available if C_USE_HW_MUL is < 2.  */
-    if (subcode >= 1 && subcode <= 3 && dc->cpu->cfg.use_hw_mul < 2) {
-        /* nop??? */
-    }
-
-    tmp = tcg_temp_new_i32();
-    switch (subcode) {
-        case 0:
-            tcg_gen_mul_i32(cpu_R[dc->rd], cpu_R[dc->ra], cpu_R[dc->rb]);
-            break;
-        case 1:
-            tcg_gen_muls2_i32(tmp, cpu_R[dc->rd],
-                              cpu_R[dc->ra], cpu_R[dc->rb]);
-            break;
-        case 2:
-            tcg_gen_mulsu2_i32(tmp, cpu_R[dc->rd],
-                               cpu_R[dc->ra], cpu_R[dc->rb]);
-            break;
-        case 3:
-            tcg_gen_mulu2_i32(tmp, cpu_R[dc->rd], cpu_R[dc->ra], cpu_R[dc->rb]);
-            break;
-        default:
-            cpu_abort(CPU(dc->cpu), "unknown MUL insn %x\n", subcode);
-            break;
-    }
-    tcg_temp_free_i32(tmp);
-}
-
 /* Div unit.  */
 static void dec_div(DisasContext *dc)
 {
@@ -1579,7 +1565,6 @@ static struct decoder_info {
     {DEC_BCC, dec_bcc},
     {DEC_RTS, dec_rts},
     {DEC_FPU, dec_fpu},
-    {DEC_MUL, dec_mul},
     {DEC_DIV, dec_div},
     {DEC_MSR, dec_msr},
     {DEC_STREAM, dec_stream},
-- 
2.25.1



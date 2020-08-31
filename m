Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A53E2C433E6
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 16:21:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F8A92073A
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 16:21:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F5SxQKa3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F8A92073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCmZ5-0001Xo-I0
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 12:21:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34180)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCmKi-00057x-MT
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 12:07:00 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036]:33657)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCmKg-00063B-MV
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 12:07:00 -0400
Received: by mail-pj1-x1036.google.com with SMTP id np15so179831pjb.0
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 09:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=McrdZ6KxrFqHOEaBx6VbvyuikujwerCjRA8qh9K2y7E=;
 b=F5SxQKa3n5qWf1xi6KVvx9P+wP+PGUXBYVzAuXLfprr99h96NeCnLlZFQLZR7mQEwy
 nFdT8cbQGq7wyUTSBbHWlwKSn+fdQw6hw/62NZDU2sGXHWkY0Ekd+EHSWz/HqHMDYuUI
 cfaApwf3iEXF0k4NNP0fmFIbSTF82LABLAmMRGlNY2/DGuHdwHxC4ojm1L2RU48Km6lc
 wt122SXyatOmg7I380v6Pp1cRE7SQclvF5zdi7IgR7MjTgDktHKkP9GVD5HddQ9x92Nn
 2K5c3AQhwBn7pwaaj0VH+lXWXoVmq1zHkK1LwxwdwBNz/b7Z7fHPQ1DoX5svMYUtysNm
 QMMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=McrdZ6KxrFqHOEaBx6VbvyuikujwerCjRA8qh9K2y7E=;
 b=uiTRhs288Sqkz1r4qZWOolApJmsh2KcjYKhYuRxi3DeS4o4xKOkT6Nk4qvY/D5/srv
 zi5xLqABuExur4MWEkfebb1ryQvCY2N8DjoDXOIEfoPjQUIGj8PQwqD77H/ztqz3COjv
 H46T84ZTPOQYyiq0V8KgY3Q+E7xQTyy0+qj797XT3q5p+DSM0A1yTWiYb16h1v0wDaOa
 /6iax4soCDAyvy8lDqp+sKb3jlnezjpLJuQIYbghDzbfKWBuBIIyHi1LF9KUhr1+adtp
 XdH0BbxxB4MBnLF8YfnmRkBalF5JBc4KsiJzUKPhUK70L0Q0P5Yl+sgOKodE0b5PQ/wy
 SAyQ==
X-Gm-Message-State: AOAM532KJO58oFiLDhjyBCcvnWiVvYL7s6HZJy5i+4DoU5ng0bMZzGBP
 jYD4bO/qM53bhhZ47hWHHlOftHowePJBGg==
X-Google-Smtp-Source: ABdhPJyB+zY8SK60zUVpCHgEUsg9Wj7d1ekWbt5P4g3w+xhhQmEzn6f8nok5RLkOlBuU4xmWW2ysaw==
X-Received: by 2002:a17:90b:2388:: with SMTP id
 mr8mr62823pjb.161.1598890016919; 
 Mon, 31 Aug 2020 09:06:56 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id gt13sm17218pjb.43.2020.08.31.09.06.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2020 09:06:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 39/76] target/microblaze: Convert dec_pattern to decodetree
Date: Mon, 31 Aug 2020 09:05:24 -0700
Message-Id: <20200831160601.833692-40-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200831160601.833692-1-richard.henderson@linaro.org>
References: <20200831160601.833692-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
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
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Tested-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/insns.decode |  4 ++
 target/microblaze/translate.c  | 67 +++++++++-------------------------
 2 files changed, 22 insertions(+), 49 deletions(-)

diff --git a/target/microblaze/insns.decode b/target/microblaze/insns.decode
index a611cc83a7..16519f05dc 100644
--- a/target/microblaze/insns.decode
+++ b/target/microblaze/insns.decode
@@ -44,6 +44,10 @@ addikc          001110 ..... ..... ................     @typeb
 cmp             000101 ..... ..... ..... 000 0000 0001  @typea
 cmpu            000101 ..... ..... ..... 000 0000 0011  @typea
 
+pcmpbf          100000 ..... ..... ..... 100 0000 0000  @typea
+pcmpeq          100010 ..... ..... ..... 100 0000 0000  @typea
+pcmpne          100011 ..... ..... ..... 100 0000 0000  @typea
+
 rsub            000001 ..... ..... ..... 000 0000 0000  @typea
 rsubc           000011 ..... ..... ..... 000 0000 0000  @typea
 rsubk           000101 ..... ..... ..... 000 0000 0000  @typea
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 8da477457d..7ebf0e1e7d 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -279,6 +279,10 @@ static bool do_typeb_val(DisasContext *dc, arg_typeb *arg, bool side_effects,
     static bool trans_##NAME(DisasContext *dc, arg_typea *a) \
     { return do_typea(dc, a, SE, FN); }
 
+#define DO_TYPEA_CFG(NAME, CFG, SE, FN) \
+    static bool trans_##NAME(DisasContext *dc, arg_typea *a) \
+    { return dc->cpu->cfg.CFG && do_typea(dc, a, SE, FN); }
+
 #define DO_TYPEBI(NAME, SE, FNI) \
     static bool trans_##NAME(DisasContext *dc, arg_typeb *a) \
     { return do_typeb_imm(dc, a, SE, FNI); }
@@ -350,6 +354,20 @@ static void gen_cmpu(TCGv_i32 out, TCGv_i32 ina, TCGv_i32 inb)
 DO_TYPEA(cmp, false, gen_cmp)
 DO_TYPEA(cmpu, false, gen_cmpu)
 
+static void gen_pcmpeq(TCGv_i32 out, TCGv_i32 ina, TCGv_i32 inb)
+{
+    tcg_gen_setcond_i32(TCG_COND_EQ, out, ina, inb);
+}
+
+static void gen_pcmpne(TCGv_i32 out, TCGv_i32 ina, TCGv_i32 inb)
+{
+    tcg_gen_setcond_i32(TCG_COND_NE, out, ina, inb);
+}
+
+DO_TYPEA_CFG(pcmpbf, use_pcmp_instr, false, gen_helper_pcmpbf)
+DO_TYPEA_CFG(pcmpeq, use_pcmp_instr, false, gen_pcmpeq)
+DO_TYPEA_CFG(pcmpne, use_pcmp_instr, false, gen_pcmpne)
+
 /* No input carry, but output carry. */
 static void gen_rsub(TCGv_i32 out, TCGv_i32 ina, TCGv_i32 inb)
 {
@@ -413,49 +431,10 @@ static bool trans_zero(DisasContext *dc, arg_zero *arg)
     return false;
 }
 
-static void dec_pattern(DisasContext *dc)
-{
-    unsigned int mode;
-
-    if (trap_illegal(dc, !dc->cpu->cfg.use_pcmp_instr)) {
-        return;
-    }
-
-    mode = dc->opcode & 3;
-    switch (mode) {
-        case 0:
-            /* pcmpbf.  */
-            if (dc->rd)
-                gen_helper_pcmpbf(cpu_R[dc->rd], cpu_R[dc->ra], cpu_R[dc->rb]);
-            break;
-        case 2:
-            if (dc->rd) {
-                tcg_gen_setcond_i32(TCG_COND_EQ, cpu_R[dc->rd],
-                                   cpu_R[dc->ra], cpu_R[dc->rb]);
-            }
-            break;
-        case 3:
-            if (dc->rd) {
-                tcg_gen_setcond_i32(TCG_COND_NE, cpu_R[dc->rd],
-                                   cpu_R[dc->ra], cpu_R[dc->rb]);
-            }
-            break;
-        default:
-            cpu_abort(CPU(dc->cpu),
-                      "unsupported pattern insn opcode=%x\n", dc->opcode);
-            break;
-    }
-}
-
 static void dec_and(DisasContext *dc)
 {
     unsigned int not;
 
-    if (!dc->type_b && (dc->imm & (1 << 10))) {
-        dec_pattern(dc);
-        return;
-    }
-
     not = dc->opcode & (1 << 1);
 
     if (!dc->rd)
@@ -469,22 +448,12 @@ static void dec_and(DisasContext *dc)
 
 static void dec_or(DisasContext *dc)
 {
-    if (!dc->type_b && (dc->imm & (1 << 10))) {
-        dec_pattern(dc);
-        return;
-    }
-
     if (dc->rd)
         tcg_gen_or_i32(cpu_R[dc->rd], cpu_R[dc->ra], *(dec_alu_op_b(dc)));
 }
 
 static void dec_xor(DisasContext *dc)
 {
-    if (!dc->type_b && (dc->imm & (1 << 10))) {
-        dec_pattern(dc);
-        return;
-    }
-
     if (dc->rd)
         tcg_gen_xor_i32(cpu_R[dc->rd], cpu_R[dc->ra], *(dec_alu_op_b(dc)));
 }
-- 
2.25.1



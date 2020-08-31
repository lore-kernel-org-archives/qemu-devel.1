Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E09FC433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 16:19:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 316612073A
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 16:19:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MaM8GbIJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 316612073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCmX4-0005H5-Cv
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 12:19:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34154)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCmKh-00053x-4F
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 12:06:59 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029]:54419)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCmKe-00062l-6a
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 12:06:58 -0400
Received: by mail-pj1-x1029.google.com with SMTP id mm21so23101pjb.4
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 09:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=eN+TJwZQmH9g/Oqdr8zFkz2I/AR8C6M5MJukpRXnGo0=;
 b=MaM8GbIJW5jy/uI7I7d2U1yACDBe14bN8QChoXoSAhgaxYUyu3UoOhYanF1MypuNEJ
 CVUXrQqv5scMIUO4fE+AxnIJawjk2mYnidBCmaBlb/bkr0cAtgor4x6tZGWD4577tSuG
 jrZKCCPxyCzpDEx8iFkTpqv0SsO70dQRZNLSEbEHB7O9AQuUzIA77SowW3nq9JVmxbOD
 CBS+CPjCdXTKTtSqhh/BNfwdkS5cyiEqBoLKlXpJxOlhMj+ZOcioYJOGa+skOeTIhLtV
 xX3jQIOgRM/afgMvaMcQ/fCavdwt0lbMN8IiT12aF6qB+KMeQXELkupxoDw7EpIWiajw
 liQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=eN+TJwZQmH9g/Oqdr8zFkz2I/AR8C6M5MJukpRXnGo0=;
 b=pNlcebVPB6BZ+OJ3ZRL86wk9WlkPwoJFG1H/G7Jt9vOBHDRfmN+SDFNARwUcxU3Ul4
 JLf0/Xko8ED869z+KDGBZnj+eZDjz3kKtsw7c/1RRjmOZD8y9dhDRcxdM/AfvD/B9gBF
 hwUDbu2p5oWVt5f1epk6B/fXyn++NAtUxlUJMNyZdEGXY+zgWKvyLes/5+YOzkLX9TZL
 xqPrTQiLYPlGW1VWZzCI/pqo2h3s4SDYLTrFF/LnoIhLDBvG9FINA1B4I57JjtD+JW3O
 mgEgqE0M7fpHxZ7Y0jdBDyawaf9x49/N15sQk0+p9l0jyvJwx9MAV5IIx0xshyNKbyYY
 JxzA==
X-Gm-Message-State: AOAM5326UKt5/F4ejrzST9XB3MJqxkxB7QMp+TjoOzoD9IIzM1V4ibRF
 lNCVdSfkDiSw4suMJSyeonz+H0GW76lPAQ==
X-Google-Smtp-Source: ABdhPJxtjKSqFMiDG+4wWCqI6AYUroJAh6ouL8JJzcF7V4p+6RcKliBYgU3AeIQtGMRfFwaRBOsV+g==
X-Received: by 2002:a17:90a:e7c8:: with SMTP id
 kb8mr99383pjb.104.1598890014389; 
 Mon, 31 Aug 2020 09:06:54 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id gt13sm17218pjb.43.2020.08.31.09.06.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2020 09:06:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 37/76] target/microblaze: Convert dec_sub to decodetree
Date: Mon, 31 Aug 2020 09:05:22 -0700
Message-Id: <20200831160601.833692-38-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200831160601.833692-1-richard.henderson@linaro.org>
References: <20200831160601.833692-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
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

Use tcg_gen_add2_i32 for computing carry.
This removes the last use of helper_carry, so remove that.

Tested-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/helper.h     |   1 -
 target/microblaze/insns.decode |  13 ++++
 target/microblaze/op_helper.c  |  16 -----
 target/microblaze/translate.c  | 110 ++++++++++++++++-----------------
 4 files changed, 65 insertions(+), 75 deletions(-)

diff --git a/target/microblaze/helper.h b/target/microblaze/helper.h
index 9309142f8d..988abf7661 100644
--- a/target/microblaze/helper.h
+++ b/target/microblaze/helper.h
@@ -1,5 +1,4 @@
 DEF_HELPER_FLAGS_2(raise_exception, TCG_CALL_NO_WG, noreturn, env, i32)
-DEF_HELPER_FLAGS_3(carry, TCG_CALL_NO_RWG_SE, i32, i32, i32, i32)
 DEF_HELPER_2(cmp, i32, i32, i32)
 DEF_HELPER_2(cmpu, i32, i32, i32)
 
diff --git a/target/microblaze/insns.decode b/target/microblaze/insns.decode
index 5f289a446c..a611cc83a7 100644
--- a/target/microblaze/insns.decode
+++ b/target/microblaze/insns.decode
@@ -40,3 +40,16 @@ addi            001000 ..... ..... ................     @typeb
 addic           001010 ..... ..... ................     @typeb
 addik           001100 ..... ..... ................     @typeb
 addikc          001110 ..... ..... ................     @typeb
+
+cmp             000101 ..... ..... ..... 000 0000 0001  @typea
+cmpu            000101 ..... ..... ..... 000 0000 0011  @typea
+
+rsub            000001 ..... ..... ..... 000 0000 0000  @typea
+rsubc           000011 ..... ..... ..... 000 0000 0000  @typea
+rsubk           000101 ..... ..... ..... 000 0000 0000  @typea
+rsubkc          000111 ..... ..... ..... 000 0000 0000  @typea
+
+rsubi           001001 ..... ..... ................     @typeb
+rsubic          001011 ..... ..... ................     @typeb
+rsubik          001101 ..... ..... ................     @typeb
+rsubikc         001111 ..... ..... ................     @typeb
diff --git a/target/microblaze/op_helper.c b/target/microblaze/op_helper.c
index decdca0fd8..9bb6a2ad76 100644
--- a/target/microblaze/op_helper.c
+++ b/target/microblaze/op_helper.c
@@ -69,17 +69,6 @@ void helper_raise_exception(CPUMBState *env, uint32_t index)
     cpu_loop_exit(cs);
 }
 
-static inline uint32_t compute_carry(uint32_t a, uint32_t b, uint32_t cin)
-{
-    uint32_t cout = 0;
-
-    if ((b == ~0) && cin)
-        cout = 1;
-    else if ((~0 - a) < (b + cin))
-        cout = 1;
-    return cout;
-}
-
 uint32_t helper_cmp(uint32_t a, uint32_t b)
 {
     uint32_t t;
@@ -100,11 +89,6 @@ uint32_t helper_cmpu(uint32_t a, uint32_t b)
     return t;
 }
 
-uint32_t helper_carry(uint32_t a, uint32_t b, uint32_t cf)
-{
-    return compute_carry(a, b, cf);
-}
-
 static inline int div_prepare(CPUMBState *env, uint32_t a, uint32_t b)
 {
     MicroBlazeCPU *cpu = env_archcpu(env);
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index de822bd7b7..0e7d24ddca 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -327,6 +327,58 @@ DO_TYPEBV(addic, true, gen_addc)
 DO_TYPEBI(addik, false, tcg_gen_addi_i32)
 DO_TYPEBV(addikc, true, gen_addkc)
 
+DO_TYPEA(cmp, false, gen_helper_cmp)
+DO_TYPEA(cmpu, false, gen_helper_cmpu)
+
+/* No input carry, but output carry. */
+static void gen_rsub(TCGv_i32 out, TCGv_i32 ina, TCGv_i32 inb)
+{
+    tcg_gen_setcond_i32(TCG_COND_GEU, cpu_msr_c, inb, ina);
+    tcg_gen_sub_i32(out, inb, ina);
+}
+
+/* Input and output carry. */
+static void gen_rsubc(TCGv_i32 out, TCGv_i32 ina, TCGv_i32 inb)
+{
+    TCGv_i32 zero = tcg_const_i32(0);
+    TCGv_i32 tmp = tcg_temp_new_i32();
+
+    tcg_gen_not_i32(tmp, ina);
+    tcg_gen_add2_i32(tmp, cpu_msr_c, tmp, zero, cpu_msr_c, zero);
+    tcg_gen_add2_i32(out, cpu_msr_c, tmp, cpu_msr_c, inb, zero);
+
+    tcg_temp_free_i32(zero);
+    tcg_temp_free_i32(tmp);
+}
+
+/* No input or output carry. */
+static void gen_rsubk(TCGv_i32 out, TCGv_i32 ina, TCGv_i32 inb)
+{
+    tcg_gen_sub_i32(out, inb, ina);
+}
+
+/* Input carry, no output carry. */
+static void gen_rsubkc(TCGv_i32 out, TCGv_i32 ina, TCGv_i32 inb)
+{
+    TCGv_i32 nota = tcg_temp_new_i32();
+
+    tcg_gen_not_i32(nota, ina);
+    tcg_gen_add_i32(out, inb, nota);
+    tcg_gen_add_i32(out, out, cpu_msr_c);
+
+    tcg_temp_free_i32(nota);
+}
+
+DO_TYPEA(rsub, true, gen_rsub)
+DO_TYPEA(rsubc, true, gen_rsubc)
+DO_TYPEA(rsubk, false, gen_rsubk)
+DO_TYPEA(rsubkc, true, gen_rsubkc)
+
+DO_TYPEBV(rsubi, true, gen_rsub)
+DO_TYPEBV(rsubic, true, gen_rsubc)
+DO_TYPEBV(rsubik, false, gen_rsubk)
+DO_TYPEBV(rsubikc, true, gen_rsubkc)
+
 static bool trans_zero(DisasContext *dc, arg_zero *arg)
 {
     /* If opcode_0_illegal, trap.  */
@@ -341,63 +393,6 @@ static bool trans_zero(DisasContext *dc, arg_zero *arg)
     return false;
 }
 
-static void dec_sub(DisasContext *dc)
-{
-    unsigned int u, cmp, k, c;
-    TCGv_i32 cf, na;
-
-    u = dc->imm & 2;
-    k = dc->opcode & 4;
-    c = dc->opcode & 2;
-    cmp = (dc->imm & 1) && (!dc->type_b) && k;
-
-    if (cmp) {
-        if (dc->rd) {
-            if (u)
-                gen_helper_cmpu(cpu_R[dc->rd], cpu_R[dc->ra], cpu_R[dc->rb]);
-            else
-                gen_helper_cmp(cpu_R[dc->rd], cpu_R[dc->ra], cpu_R[dc->rb]);
-        }
-        return;
-    }
-
-    /* Take care of the easy cases first.  */
-    if (k) {
-        /* k - keep carry, no need to update MSR.  */
-        /* If rd == r0, it's a nop.  */
-        if (dc->rd) {
-            tcg_gen_sub_i32(cpu_R[dc->rd], *(dec_alu_op_b(dc)), cpu_R[dc->ra]);
-
-            if (c) {
-                /* c - Add carry into the result.  */
-                tcg_gen_add_i32(cpu_R[dc->rd], cpu_R[dc->rd], cpu_msr_c);
-            }
-        }
-        return;
-    }
-
-    /* From now on, we can assume k is zero.  So we need to update MSR.  */
-    /* Extract carry. And complement a into na.  */
-    cf = tcg_temp_new_i32();
-    na = tcg_temp_new_i32();
-    if (c) {
-        tcg_gen_mov_i32(cf, cpu_msr_c);
-    } else {
-        tcg_gen_movi_i32(cf, 1);
-    }
-
-    /* d = b + ~a + c. carry defaults to 1.  */
-    tcg_gen_not_i32(na, cpu_R[dc->ra]);
-
-    gen_helper_carry(cpu_msr_c, na, *(dec_alu_op_b(dc)), cf);
-    if (dc->rd) {
-        tcg_gen_add_i32(cpu_R[dc->rd], na, *(dec_alu_op_b(dc)));
-        tcg_gen_add_i32(cpu_R[dc->rd], cpu_R[dc->rd], cf);
-    }
-    tcg_temp_free_i32(cf);
-    tcg_temp_free_i32(na);
-}
-
 static void dec_pattern(DisasContext *dc)
 {
     unsigned int mode;
@@ -1597,7 +1592,6 @@ static struct decoder_info {
     };
     void (*dec)(DisasContext *dc);
 } decinfo[] = {
-    {DEC_SUB, dec_sub},
     {DEC_AND, dec_and},
     {DEC_XOR, dec_xor},
     {DEC_OR, dec_or},
-- 
2.25.1



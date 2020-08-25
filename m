Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9614AC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 21:17:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5042820738
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 21:17:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hTvvp9yj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5042820738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAgK6-0000Yk-GT
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 17:17:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35974)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAg3f-0007zZ-FP
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 17:00:43 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:38472)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAg3d-0001r8-4i
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 17:00:42 -0400
Received: by mail-pj1-x1044.google.com with SMTP id ls14so122394pjb.3
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 14:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=52+gLLOfsTHLGvsiEqn5D8Con58Yn2k7gp1YJlK0G5Q=;
 b=hTvvp9yj2N8foHkD2ug5g7F5FI8EQ9jfKMb0VnZabua3pAvWRVG/ajWmf7Q4yx9kBV
 Ui58laJka1mGYGI12mDvtWrkIyVGvMkZDCzscIwELzCs0CmUlfQrpGlhWLjL/yWptrE8
 ZerDtpSu7T+UgArhOPWA7rxSb7QKNg1CbSMOIviN81wWuYcv2QY1uQCqq+9dqtkjWtJJ
 2Rg5zVWfnu1xGx1LiizdxwNDp8F4qWo3K8zY7M1klzOpolxEvnGatOiu+plwBQ23vn1J
 5LvY1tYoZ9qp/6DeurdlJrqQMYP8rxIT47dkn/FnZ5Mt4fJFj+HMfxYhl158Oog+lZfG
 IKQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=52+gLLOfsTHLGvsiEqn5D8Con58Yn2k7gp1YJlK0G5Q=;
 b=iivvUwOdlghc5W3OAArAXvECmXgDDl2TW+dDPFR35DSoZf7EBlqKnvM80BZtPXxvnC
 NcqEWJ0xVEhUsRzvKq5UcQ9TG8GOZi4Pzwb+AGx+atRYHGJv8z0bV8reLB8FGnyHBsGg
 4JHO6IvglMp7hLGyfCyqeaqdacMrDk2CfsvZX3WstBaOHsHsoE7KTQ/lfhOLCFlWWT36
 lWutizhhAk0iUILUCb3j86orr68Odq48f/fI0UecD6BHNjKIEKoKiAdEGaesquNXjPJ3
 K5ry7+dpLH0GbBBJ3JujzpbGM35mcKsO5zEeW7564b1+s3uUdmP+mFlw6vYIFDsWXRFp
 7Dyg==
X-Gm-Message-State: AOAM5322GtwUVcKR9Sdlq6j0reRq8abgRI8bVYCjEzdBnvOd9inS/ru+
 CaUY2xX/XUy0N7SelK3O2Ka2DzD73T5y5Q==
X-Google-Smtp-Source: ABdhPJxu2Gt6lrwjKxglnd6s2x0liq681n4iwUjMNgD9etPrVOB15+apZMJ0XqWYZJ11X1UUVxYXBw==
X-Received: by 2002:a17:90b:1b47:: with SMTP id
 nv7mr2886233pjb.128.1598389239342; 
 Tue, 25 Aug 2020 14:00:39 -0700 (PDT)
Received: from localhost.localdomain
 (h216-228-167-147.bendor.dedicated.static.tds.net. [216.228.167.147])
 by smtp.gmail.com with ESMTPSA id k4sm16074pgr.87.2020.08.25.14.00.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2020 14:00:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 37/77] target/microblaze: Convert dec_sub to decodetree
Date: Tue, 25 Aug 2020 13:59:10 -0700
Message-Id: <20200825205950.730499-38-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200825205950.730499-1-richard.henderson@linaro.org>
References: <20200825205950.730499-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1044;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1044.google.com
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
Cc: edgar.iglesias@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use tcg_gen_add2_i32 for computing carry.
This removes the last use of helper_carry, so remove that.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/helper.h     |   1 -
 target/microblaze/insns.decode |  13 +++++
 target/microblaze/op_helper.c  |  16 -----
 target/microblaze/translate.c  | 104 ++++++++++++++++-----------------
 4 files changed, 62 insertions(+), 72 deletions(-)

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
index c62f826bcc..3f5f7b1852 100644
--- a/target/microblaze/insns.decode
+++ b/target/microblaze/insns.decode
@@ -37,3 +37,16 @@ addi            001000 ..... ..... ................     @typeb
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
index c3cc4db629..98050f64b7 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -327,63 +327,58 @@ DO_TYPEBV(addic, true, gen_addc)
 DO_TYPEBI(addik, false, tcg_gen_addi_i32)
 DO_TYPEBV(addikc, true, gen_addkc)
 
-static void dec_sub(DisasContext *dc)
+DO_TYPEA(cmp, false, gen_helper_cmp)
+DO_TYPEA(cmpu, false, gen_helper_cmpu)
+
+/* No input carry, but output carry. */
+static void gen_rsub(TCGv_i32 out, TCGv_i32 ina, TCGv_i32 inb)
 {
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
+    tcg_gen_setcond_i32(TCG_COND_GEU, cpu_msr_c, inb, ina);
+    tcg_gen_sub_i32(out, inb, ina);
 }
 
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
 static void dec_pattern(DisasContext *dc)
 {
     unsigned int mode;
@@ -1583,7 +1578,6 @@ static struct decoder_info {
     };
     void (*dec)(DisasContext *dc);
 } decinfo[] = {
-    {DEC_SUB, dec_sub},
     {DEC_AND, dec_and},
     {DEC_XOR, dec_xor},
     {DEC_OR, dec_or},
-- 
2.25.1



Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 993DCC3A59F
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 00:12:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54CD42173E
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 00:12:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qLWXYUwI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54CD42173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2P6Q-00056V-TC
	for qemu-devel@archiver.kernel.org; Mon, 26 Aug 2019 20:12:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33589)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i2P1e-0007yZ-Jy
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 20:07:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i2P1b-00072q-Tj
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 20:07:54 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:32839)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i2P1b-00072Z-Kx
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 20:07:51 -0400
Received: by mail-pf1-x442.google.com with SMTP id g2so12877688pfq.0
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2019 17:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=gZkm7jkvofBBnuZZFZQL9KwuepLJPwHfg7uaed0lYTY=;
 b=qLWXYUwIaC+GpUkYZ8EDCQVrXjMfeU0S83zqb5Ia0EuRdJvK8BgFpgxtOAtLENCrnQ
 U/mUeu1JKjr7pnlsjm8mBCnfxTiSUT6BY2jKxVtzzwypqoqfAVjBvVzBjkIA5BD0BPye
 sFS5vN1X9G+i7l/lXiboXTqW9Wx1h7g9+K+jLVDgdcMDjhlOK0b53/czv0PZt2AqV11a
 5BZa7lrK3xXvmQEdWCp1u/EDpE9gGggfOfRtwXmkQz/KrcAmJ4oDlgzq0HW1xQJSmAr6
 pGU6J3sfc3pHxsK3Ryg5EBhr8w52YCRzmJXNQ25oLhv7FVN31kzdK3kLlrG3Q6gMOHTJ
 9FWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=gZkm7jkvofBBnuZZFZQL9KwuepLJPwHfg7uaed0lYTY=;
 b=S27vy6fx915c9lWkIaQRaNAcJ0L3xbDjuJMfs1JpvaCgg2U/en/ORdgsINbDI/r6Ej
 I2l/Fwid3WTU0KRiLwGYOVPsJqEFojUUQ278wEJmQ2efXsDMrj+iJlwMy3DqTb0d4NVZ
 XdK+EttJ7pHYyjv75fRcWr0zDK+ty5nNrj6ju6sISawZ08CsWNjzNR2p7QQ9+NhB5JkF
 7QK8VeSn9n7+c6E1RJaDk03RcNDZFr8iuwQDHWMsWisnHoUTJV+QQDT3alxJQSekZngw
 nPbPbj5nXlCVDiuev/SQWN1GumK0fI9wONvYlnnM/OL65/jV/IJRfLF9SYTQocjUQYti
 UVpw==
X-Gm-Message-State: APjAAAXL8uk+7y/DL6bdWNhkyinznWuqwthSTfhdPa96jvS6dk4BWfQG
 KIIuKwvRBTpwn63346NLt0sZXVDjsmk=
X-Google-Smtp-Source: APXvYqxD8+AgPRhNlaotl3x3jbZic+sXGF5gS38kDds/fxNcUMp8CEFLRK/qr7L+zbDFUN2mUI183g==
X-Received: by 2002:aa7:8705:: with SMTP id b5mr23425499pfo.205.1566864470127; 
 Mon, 26 Aug 2019 17:07:50 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id e189sm11691067pgc.15.2019.08.26.17.07.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Aug 2019 17:07:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 26 Aug 2019 17:07:34 -0700
Message-Id: <20190827000745.19645-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190827000745.19645-1-richard.henderson@linaro.org>
References: <20190827000745.19645-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: [Qemu-devel] [PATCH 02/13] target/openrisc: Replace cpu register
 array with a function
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
Cc: shorne@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The writes to cpu_R[0] are now a race across threads, now that we
do code generation in parallel.  Stage the change by introducing
a function to return the temp for R0.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/openrisc/translate.c | 213 ++++++++++++++++++++----------------
 1 file changed, 116 insertions(+), 97 deletions(-)

diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index ed2197c371..3812dc4427 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -63,7 +63,7 @@ static inline bool is_user(DisasContext *dc)
 #include "decode.inc.c"
 
 static TCGv cpu_sr;
-static TCGv cpu_R[32];
+static TCGv cpu_regs[32];
 static TCGv cpu_R0;
 static TCGv cpu_pc;
 static TCGv jmp_pc;            /* l.jr/l.jalr temp pc */
@@ -117,12 +117,12 @@ void openrisc_translate_init(void)
                                      offsetof(CPUOpenRISCState, mac),
                                      "mac");
     for (i = 0; i < 32; i++) {
-        cpu_R[i] = tcg_global_mem_new(cpu_env,
-                                      offsetof(CPUOpenRISCState,
-                                               shadow_gpr[0][i]),
-                                      regnames[i]);
+        cpu_regs[i] = tcg_global_mem_new(cpu_env,
+                                         offsetof(CPUOpenRISCState,
+                                                  shadow_gpr[0][i]),
+                                         regnames[i]);
     }
-    cpu_R0 = cpu_R[0];
+    cpu_R0 = cpu_regs[0];
 }
 
 static void gen_exception(DisasContext *dc, unsigned int excp)
@@ -163,6 +163,11 @@ static void check_ov64s(DisasContext *dc)
 }
 #endif*/
 
+static TCGv cpu_R(DisasContext *dc, int reg)
+{
+    return cpu_regs[reg];
+}
+
 /*
  * We're about to write to REG.  On the off-chance that the user is
  * writing to R0, re-instate the architectural register.
@@ -170,7 +175,7 @@ static void check_ov64s(DisasContext *dc)
 static void check_r0_write(DisasContext *dc, int reg)
 {
     if (unlikely(reg == 0)) {
-        cpu_R[0] = cpu_R0;
+        cpu_regs[0] = cpu_R0;
     }
 }
 
@@ -439,98 +444,98 @@ static void gen_msbu(DisasContext *dc, TCGv srca, TCGv srcb)
 static bool trans_l_add(DisasContext *dc, arg_dab *a)
 {
     check_r0_write(dc, a->d);
-    gen_add(dc, cpu_R[a->d], cpu_R[a->a], cpu_R[a->b]);
+    gen_add(dc, cpu_R(dc, a->d), cpu_R(dc, a->a), cpu_R(dc, a->b));
     return true;
 }
 
 static bool trans_l_addc(DisasContext *dc, arg_dab *a)
 {
     check_r0_write(dc, a->d);
-    gen_addc(dc, cpu_R[a->d], cpu_R[a->a], cpu_R[a->b]);
+    gen_addc(dc, cpu_R(dc, a->d), cpu_R(dc, a->a), cpu_R(dc, a->b));
     return true;
 }
 
 static bool trans_l_sub(DisasContext *dc, arg_dab *a)
 {
     check_r0_write(dc, a->d);
-    gen_sub(dc, cpu_R[a->d], cpu_R[a->a], cpu_R[a->b]);
+    gen_sub(dc, cpu_R(dc, a->d), cpu_R(dc, a->a), cpu_R(dc, a->b));
     return true;
 }
 
 static bool trans_l_and(DisasContext *dc, arg_dab *a)
 {
     check_r0_write(dc, a->d);
-    tcg_gen_and_tl(cpu_R[a->d], cpu_R[a->a], cpu_R[a->b]);
+    tcg_gen_and_tl(cpu_R(dc, a->d), cpu_R(dc, a->a), cpu_R(dc, a->b));
     return true;
 }
 
 static bool trans_l_or(DisasContext *dc, arg_dab *a)
 {
     check_r0_write(dc, a->d);
-    tcg_gen_or_tl(cpu_R[a->d], cpu_R[a->a], cpu_R[a->b]);
+    tcg_gen_or_tl(cpu_R(dc, a->d), cpu_R(dc, a->a), cpu_R(dc, a->b));
     return true;
 }
 
 static bool trans_l_xor(DisasContext *dc, arg_dab *a)
 {
     check_r0_write(dc, a->d);
-    tcg_gen_xor_tl(cpu_R[a->d], cpu_R[a->a], cpu_R[a->b]);
+    tcg_gen_xor_tl(cpu_R(dc, a->d), cpu_R(dc, a->a), cpu_R(dc, a->b));
     return true;
 }
 
 static bool trans_l_sll(DisasContext *dc, arg_dab *a)
 {
     check_r0_write(dc, a->d);
-    tcg_gen_shl_tl(cpu_R[a->d], cpu_R[a->a], cpu_R[a->b]);
+    tcg_gen_shl_tl(cpu_R(dc, a->d), cpu_R(dc, a->a), cpu_R(dc, a->b));
     return true;
 }
 
 static bool trans_l_srl(DisasContext *dc, arg_dab *a)
 {
     check_r0_write(dc, a->d);
-    tcg_gen_shr_tl(cpu_R[a->d], cpu_R[a->a], cpu_R[a->b]);
+    tcg_gen_shr_tl(cpu_R(dc, a->d), cpu_R(dc, a->a), cpu_R(dc, a->b));
     return true;
 }
 
 static bool trans_l_sra(DisasContext *dc, arg_dab *a)
 {
     check_r0_write(dc, a->d);
-    tcg_gen_sar_tl(cpu_R[a->d], cpu_R[a->a], cpu_R[a->b]);
+    tcg_gen_sar_tl(cpu_R(dc, a->d), cpu_R(dc, a->a), cpu_R(dc, a->b));
     return true;
 }
 
 static bool trans_l_ror(DisasContext *dc, arg_dab *a)
 {
     check_r0_write(dc, a->d);
-    tcg_gen_rotr_tl(cpu_R[a->d], cpu_R[a->a], cpu_R[a->b]);
+    tcg_gen_rotr_tl(cpu_R(dc, a->d), cpu_R(dc, a->a), cpu_R(dc, a->b));
     return true;
 }
 
 static bool trans_l_exths(DisasContext *dc, arg_da *a)
 {
     check_r0_write(dc, a->d);
-    tcg_gen_ext16s_tl(cpu_R[a->d], cpu_R[a->a]);
+    tcg_gen_ext16s_tl(cpu_R(dc, a->d), cpu_R(dc, a->a));
     return true;
 }
 
 static bool trans_l_extbs(DisasContext *dc, arg_da *a)
 {
     check_r0_write(dc, a->d);
-    tcg_gen_ext8s_tl(cpu_R[a->d], cpu_R[a->a]);
+    tcg_gen_ext8s_tl(cpu_R(dc, a->d), cpu_R(dc, a->a));
     return true;
 }
 
 static bool trans_l_exthz(DisasContext *dc, arg_da *a)
 {
     check_r0_write(dc, a->d);
-    tcg_gen_ext16u_tl(cpu_R[a->d], cpu_R[a->a]);
+    tcg_gen_ext16u_tl(cpu_R(dc, a->d), cpu_R(dc, a->a));
     return true;
 }
 
 static bool trans_l_extbz(DisasContext *dc, arg_da *a)
 {
     check_r0_write(dc, a->d);
-    tcg_gen_ext8u_tl(cpu_R[a->d], cpu_R[a->a]);
+    tcg_gen_ext8u_tl(cpu_R(dc, a->d), cpu_R(dc, a->a));
     return true;
 }
 
@@ -540,8 +545,8 @@ static bool trans_l_cmov(DisasContext *dc, arg_dab *a)
 
     check_r0_write(dc, a->d);
     zero = tcg_const_tl(0);
-    tcg_gen_movcond_tl(TCG_COND_NE, cpu_R[a->d], cpu_sr_f, zero,
-                       cpu_R[a->a], cpu_R[a->b]);
+    tcg_gen_movcond_tl(TCG_COND_NE, cpu_R(dc, a->d), cpu_sr_f, zero,
+                       cpu_R(dc, a->a), cpu_R(dc, a->b));
     tcg_temp_free(zero);
     return true;
 }
@@ -549,56 +554,56 @@ static bool trans_l_cmov(DisasContext *dc, arg_dab *a)
 static bool trans_l_ff1(DisasContext *dc, arg_da *a)
 {
     check_r0_write(dc, a->d);
-    tcg_gen_ctzi_tl(cpu_R[a->d], cpu_R[a->a], -1);
-    tcg_gen_addi_tl(cpu_R[a->d], cpu_R[a->d], 1);
+    tcg_gen_ctzi_tl(cpu_R(dc, a->d), cpu_R(dc, a->a), -1);
+    tcg_gen_addi_tl(cpu_R(dc, a->d), cpu_R(dc, a->d), 1);
     return true;
 }
 
 static bool trans_l_fl1(DisasContext *dc, arg_da *a)
 {
     check_r0_write(dc, a->d);
-    tcg_gen_clzi_tl(cpu_R[a->d], cpu_R[a->a], TARGET_LONG_BITS);
-    tcg_gen_subfi_tl(cpu_R[a->d], TARGET_LONG_BITS, cpu_R[a->d]);
+    tcg_gen_clzi_tl(cpu_R(dc, a->d), cpu_R(dc, a->a), TARGET_LONG_BITS);
+    tcg_gen_subfi_tl(cpu_R(dc, a->d), TARGET_LONG_BITS, cpu_R(dc, a->d));
     return true;
 }
 
 static bool trans_l_mul(DisasContext *dc, arg_dab *a)
 {
     check_r0_write(dc, a->d);
-    gen_mul(dc, cpu_R[a->d], cpu_R[a->a], cpu_R[a->b]);
+    gen_mul(dc, cpu_R(dc, a->d), cpu_R(dc, a->a), cpu_R(dc, a->b));
     return true;
 }
 
 static bool trans_l_mulu(DisasContext *dc, arg_dab *a)
 {
     check_r0_write(dc, a->d);
-    gen_mulu(dc, cpu_R[a->d], cpu_R[a->a], cpu_R[a->b]);
+    gen_mulu(dc, cpu_R(dc, a->d), cpu_R(dc, a->a), cpu_R(dc, a->b));
     return true;
 }
 
 static bool trans_l_div(DisasContext *dc, arg_dab *a)
 {
     check_r0_write(dc, a->d);
-    gen_div(dc, cpu_R[a->d], cpu_R[a->a], cpu_R[a->b]);
+    gen_div(dc, cpu_R(dc, a->d), cpu_R(dc, a->a), cpu_R(dc, a->b));
     return true;
 }
 
 static bool trans_l_divu(DisasContext *dc, arg_dab *a)
 {
     check_r0_write(dc, a->d);
-    gen_divu(dc, cpu_R[a->d], cpu_R[a->a], cpu_R[a->b]);
+    gen_divu(dc, cpu_R(dc, a->d), cpu_R(dc, a->a), cpu_R(dc, a->b));
     return true;
 }
 
 static bool trans_l_muld(DisasContext *dc, arg_ab *a)
 {
-    gen_muld(dc, cpu_R[a->a], cpu_R[a->b]);
+    gen_muld(dc, cpu_R(dc, a->a), cpu_R(dc, a->b));
     return true;
 }
 
 static bool trans_l_muldu(DisasContext *dc, arg_ab *a)
 {
-    gen_muldu(dc, cpu_R[a->a], cpu_R[a->b]);
+    gen_muldu(dc, cpu_R(dc, a->a), cpu_R(dc, a->b));
     return true;
 }
 
@@ -617,7 +622,7 @@ static bool trans_l_jal(DisasContext *dc, arg_l_jal *a)
     target_ulong tmp_pc = dc->base.pc_next + a->n * 4;
     target_ulong ret_pc = dc->base.pc_next + 8;
 
-    tcg_gen_movi_tl(cpu_R[9], ret_pc);
+    tcg_gen_movi_tl(cpu_regs[9], ret_pc);
     /* Optimize jal being used to load the PC for PIC.  */
     if (tmp_pc != ret_pc) {
         tcg_gen_movi_tl(jmp_pc, tmp_pc);
@@ -656,15 +661,15 @@ static bool trans_l_bnf(DisasContext *dc, arg_l_bf *a)
 
 static bool trans_l_jr(DisasContext *dc, arg_l_jr *a)
 {
-    tcg_gen_mov_tl(jmp_pc, cpu_R[a->b]);
+    tcg_gen_mov_tl(jmp_pc, cpu_R(dc, a->b));
     dc->delayed_branch = 2;
     return true;
 }
 
 static bool trans_l_jalr(DisasContext *dc, arg_l_jalr *a)
 {
-    tcg_gen_mov_tl(jmp_pc, cpu_R[a->b]);
-    tcg_gen_movi_tl(cpu_R[9], dc->base.pc_next + 8);
+    tcg_gen_mov_tl(jmp_pc, cpu_R(dc, a->b));
+    tcg_gen_movi_tl(cpu_regs[9], dc->base.pc_next + 8);
     dc->delayed_branch = 2;
     return true;
 }
@@ -675,10 +680,10 @@ static bool trans_l_lwa(DisasContext *dc, arg_load *a)
 
     check_r0_write(dc, a->d);
     ea = tcg_temp_new();
-    tcg_gen_addi_tl(ea, cpu_R[a->a], a->i);
-    tcg_gen_qemu_ld_tl(cpu_R[a->d], ea, dc->mem_idx, MO_TEUL);
+    tcg_gen_addi_tl(ea, cpu_R(dc, a->a), a->i);
+    tcg_gen_qemu_ld_tl(cpu_R(dc, a->d), ea, dc->mem_idx, MO_TEUL);
     tcg_gen_mov_tl(cpu_lock_addr, ea);
-    tcg_gen_mov_tl(cpu_lock_value, cpu_R[a->d]);
+    tcg_gen_mov_tl(cpu_lock_value, cpu_R(dc, a->d));
     tcg_temp_free(ea);
     return true;
 }
@@ -689,8 +694,8 @@ static void do_load(DisasContext *dc, arg_load *a, TCGMemOp mop)
 
     check_r0_write(dc, a->d);
     ea = tcg_temp_new();
-    tcg_gen_addi_tl(ea, cpu_R[a->a], a->i);
-    tcg_gen_qemu_ld_tl(cpu_R[a->d], ea, dc->mem_idx, mop);
+    tcg_gen_addi_tl(ea, cpu_R(dc, a->a), a->i);
+    tcg_gen_qemu_ld_tl(cpu_R(dc, a->d), ea, dc->mem_idx, mop);
     tcg_temp_free(ea);
 }
 
@@ -736,13 +741,13 @@ static bool trans_l_swa(DisasContext *dc, arg_store *a)
     TCGLabel *lab_fail, *lab_done;
 
     ea = tcg_temp_new();
-    tcg_gen_addi_tl(ea, cpu_R[a->a], a->i);
+    tcg_gen_addi_tl(ea, cpu_R(dc, a->a), a->i);
 
     /* For TB_FLAGS_R0_0, the branch below invalidates the temporary assigned
-       to cpu_R[0].  Since l.swa is quite often immediately followed by a
+       to cpu_regs[0].  Since l.swa is quite often immediately followed by a
        branch, don't bother reallocating; finish the TB using the "real" R0.
        This also takes care of RB input across the branch.  */
-    cpu_R[0] = cpu_R0;
+    cpu_regs[0] = cpu_R0;
 
     lab_fail = gen_new_label();
     lab_done = gen_new_label();
@@ -751,7 +756,7 @@ static bool trans_l_swa(DisasContext *dc, arg_store *a)
 
     val = tcg_temp_new();
     tcg_gen_atomic_cmpxchg_tl(val, cpu_lock_addr, cpu_lock_value,
-                              cpu_R[a->b], dc->mem_idx, MO_TEUL);
+                              cpu_regs[a->b], dc->mem_idx, MO_TEUL);
     tcg_gen_setcond_tl(TCG_COND_EQ, cpu_sr_f, val, cpu_lock_value);
     tcg_temp_free(val);
 
@@ -768,8 +773,8 @@ static bool trans_l_swa(DisasContext *dc, arg_store *a)
 static void do_store(DisasContext *dc, arg_store *a, TCGMemOp mop)
 {
     TCGv t0 = tcg_temp_new();
-    tcg_gen_addi_tl(t0, cpu_R[a->a], a->i);
-    tcg_gen_qemu_st_tl(cpu_R[a->b], t0, dc->mem_idx, mop);
+    tcg_gen_addi_tl(t0, cpu_R(dc, a->a), a->i);
+    tcg_gen_qemu_st_tl(cpu_R(dc, a->b), t0, dc->mem_idx, mop);
     tcg_temp_free(t0);
 }
 
@@ -802,7 +807,7 @@ static bool trans_l_addi(DisasContext *dc, arg_rri *a)
 
     check_r0_write(dc, a->d);
     t0 = tcg_const_tl(a->i);
-    gen_add(dc, cpu_R[a->d], cpu_R[a->a], t0);
+    gen_add(dc, cpu_R(dc, a->d), cpu_R(dc, a->a), t0);
     tcg_temp_free(t0);
     return true;
 }
@@ -813,7 +818,7 @@ static bool trans_l_addic(DisasContext *dc, arg_rri *a)
 
     check_r0_write(dc, a->d);
     t0 = tcg_const_tl(a->i);
-    gen_addc(dc, cpu_R[a->d], cpu_R[a->a], t0);
+    gen_addc(dc, cpu_R(dc, a->d), cpu_R(dc, a->a), t0);
     tcg_temp_free(t0);
     return true;
 }
@@ -824,7 +829,7 @@ static bool trans_l_muli(DisasContext *dc, arg_rri *a)
 
     check_r0_write(dc, a->d);
     t0 = tcg_const_tl(a->i);
-    gen_mul(dc, cpu_R[a->d], cpu_R[a->a], t0);
+    gen_mul(dc, cpu_R(dc, a->d), cpu_R(dc, a->a), t0);
     tcg_temp_free(t0);
     return true;
 }
@@ -834,7 +839,7 @@ static bool trans_l_maci(DisasContext *dc, arg_l_maci *a)
     TCGv t0;
 
     t0 = tcg_const_tl(a->i);
-    gen_mac(dc, cpu_R[a->a], t0);
+    gen_mac(dc, cpu_R(dc, a->a), t0);
     tcg_temp_free(t0);
     return true;
 }
@@ -842,21 +847,21 @@ static bool trans_l_maci(DisasContext *dc, arg_l_maci *a)
 static bool trans_l_andi(DisasContext *dc, arg_rrk *a)
 {
     check_r0_write(dc, a->d);
-    tcg_gen_andi_tl(cpu_R[a->d], cpu_R[a->a], a->k);
+    tcg_gen_andi_tl(cpu_R(dc, a->d), cpu_R(dc, a->a), a->k);
     return true;
 }
 
 static bool trans_l_ori(DisasContext *dc, arg_rrk *a)
 {
     check_r0_write(dc, a->d);
-    tcg_gen_ori_tl(cpu_R[a->d], cpu_R[a->a], a->k);
+    tcg_gen_ori_tl(cpu_R(dc, a->d), cpu_R(dc, a->a), a->k);
     return true;
 }
 
 static bool trans_l_xori(DisasContext *dc, arg_rri *a)
 {
     check_r0_write(dc, a->d);
-    tcg_gen_xori_tl(cpu_R[a->d], cpu_R[a->a], a->i);
+    tcg_gen_xori_tl(cpu_R(dc, a->d), cpu_R(dc, a->a), a->i);
     return true;
 }
 
@@ -868,8 +873,8 @@ static bool trans_l_mfspr(DisasContext *dc, arg_l_mfspr *a)
         gen_illegal_exception(dc);
     } else {
         TCGv spr = tcg_temp_new();
-        tcg_gen_ori_tl(spr, cpu_R[a->a], a->k);
-        gen_helper_mfspr(cpu_R[a->d], cpu_env, cpu_R[a->d], spr);
+        tcg_gen_ori_tl(spr, cpu_R(dc, a->a), a->k);
+        gen_helper_mfspr(cpu_R(dc, a->d), cpu_env, cpu_R(dc, a->d), spr);
         tcg_temp_free(spr);
     }
     return true;
@@ -896,8 +901,8 @@ static bool trans_l_mtspr(DisasContext *dc, arg_l_mtspr *a)
         dc->base.is_jmp = DISAS_EXIT;
 
         spr = tcg_temp_new();
-        tcg_gen_ori_tl(spr, cpu_R[a->a], a->k);
-        gen_helper_mtspr(cpu_env, spr, cpu_R[a->b]);
+        tcg_gen_ori_tl(spr, cpu_R(dc, a->a), a->k);
+        gen_helper_mtspr(cpu_env, spr, cpu_R(dc, a->b));
         tcg_temp_free(spr);
     }
     return true;
@@ -905,188 +910,202 @@ static bool trans_l_mtspr(DisasContext *dc, arg_l_mtspr *a)
 
 static bool trans_l_mac(DisasContext *dc, arg_ab *a)
 {
-    gen_mac(dc, cpu_R[a->a], cpu_R[a->b]);
+    gen_mac(dc, cpu_R(dc, a->a), cpu_R(dc, a->b));
     return true;
 }
 
 static bool trans_l_msb(DisasContext *dc, arg_ab *a)
 {
-    gen_msb(dc, cpu_R[a->a], cpu_R[a->b]);
+    gen_msb(dc, cpu_R(dc, a->a), cpu_R(dc, a->b));
     return true;
 }
 
 static bool trans_l_macu(DisasContext *dc, arg_ab *a)
 {
-    gen_macu(dc, cpu_R[a->a], cpu_R[a->b]);
+    gen_macu(dc, cpu_R(dc, a->a), cpu_R(dc, a->b));
     return true;
 }
 
 static bool trans_l_msbu(DisasContext *dc, arg_ab *a)
 {
-    gen_msbu(dc, cpu_R[a->a], cpu_R[a->b]);
+    gen_msbu(dc, cpu_R(dc, a->a), cpu_R(dc, a->b));
     return true;
 }
 
 static bool trans_l_slli(DisasContext *dc, arg_dal *a)
 {
     check_r0_write(dc, a->d);
-    tcg_gen_shli_tl(cpu_R[a->d], cpu_R[a->a], a->l & (TARGET_LONG_BITS - 1));
+    tcg_gen_shli_tl(cpu_R(dc, a->d), cpu_R(dc, a->a),
+                    a->l & (TARGET_LONG_BITS - 1));
     return true;
 }
 
 static bool trans_l_srli(DisasContext *dc, arg_dal *a)
 {
     check_r0_write(dc, a->d);
-    tcg_gen_shri_tl(cpu_R[a->d], cpu_R[a->a], a->l & (TARGET_LONG_BITS - 1));
+    tcg_gen_shri_tl(cpu_R(dc, a->d), cpu_R(dc, a->a),
+                    a->l & (TARGET_LONG_BITS - 1));
     return true;
 }
 
 static bool trans_l_srai(DisasContext *dc, arg_dal *a)
 {
     check_r0_write(dc, a->d);
-    tcg_gen_sari_tl(cpu_R[a->d], cpu_R[a->a], a->l & (TARGET_LONG_BITS - 1));
+    tcg_gen_sari_tl(cpu_R(dc, a->d), cpu_R(dc, a->a),
+                    a->l & (TARGET_LONG_BITS - 1));
     return true;
 }
 
 static bool trans_l_rori(DisasContext *dc, arg_dal *a)
 {
     check_r0_write(dc, a->d);
-    tcg_gen_rotri_tl(cpu_R[a->d], cpu_R[a->a], a->l & (TARGET_LONG_BITS - 1));
+    tcg_gen_rotri_tl(cpu_R(dc, a->d), cpu_R(dc, a->a),
+                     a->l & (TARGET_LONG_BITS - 1));
     return true;
 }
 
 static bool trans_l_movhi(DisasContext *dc, arg_l_movhi *a)
 {
     check_r0_write(dc, a->d);
-    tcg_gen_movi_tl(cpu_R[a->d], a->k << 16);
+    tcg_gen_movi_tl(cpu_R(dc, a->d), a->k << 16);
     return true;
 }
 
 static bool trans_l_macrc(DisasContext *dc, arg_l_macrc *a)
 {
     check_r0_write(dc, a->d);
-    tcg_gen_trunc_i64_tl(cpu_R[a->d], cpu_mac);
+    tcg_gen_trunc_i64_tl(cpu_R(dc, a->d), cpu_mac);
     tcg_gen_movi_i64(cpu_mac, 0);
     return true;
 }
 
 static bool trans_l_sfeq(DisasContext *dc, arg_ab *a)
 {
-    tcg_gen_setcond_tl(TCG_COND_EQ, cpu_sr_f, cpu_R[a->a], cpu_R[a->b]);
+    tcg_gen_setcond_tl(TCG_COND_EQ, cpu_sr_f,
+                       cpu_R(dc, a->a), cpu_R(dc, a->b));
     return true;
 }
 
 static bool trans_l_sfne(DisasContext *dc, arg_ab *a)
 {
-    tcg_gen_setcond_tl(TCG_COND_NE, cpu_sr_f, cpu_R[a->a], cpu_R[a->b]);
+    tcg_gen_setcond_tl(TCG_COND_NE, cpu_sr_f,
+                       cpu_R(dc, a->a), cpu_R(dc, a->b));
     return true;
 }
 
 static bool trans_l_sfgtu(DisasContext *dc, arg_ab *a)
 {
-    tcg_gen_setcond_tl(TCG_COND_GTU, cpu_sr_f, cpu_R[a->a], cpu_R[a->b]);
+    tcg_gen_setcond_tl(TCG_COND_GTU, cpu_sr_f,
+                       cpu_R(dc, a->a), cpu_R(dc, a->b));
     return true;
 }
 
 static bool trans_l_sfgeu(DisasContext *dc, arg_ab *a)
 {
-    tcg_gen_setcond_tl(TCG_COND_GEU, cpu_sr_f, cpu_R[a->a], cpu_R[a->b]);
+    tcg_gen_setcond_tl(TCG_COND_GEU, cpu_sr_f,
+                       cpu_R(dc, a->a), cpu_R(dc, a->b));
     return true;
 }
 
 static bool trans_l_sfltu(DisasContext *dc, arg_ab *a)
 {
-    tcg_gen_setcond_tl(TCG_COND_LTU, cpu_sr_f, cpu_R[a->a], cpu_R[a->b]);
+    tcg_gen_setcond_tl(TCG_COND_LTU, cpu_sr_f,
+                       cpu_R(dc, a->a), cpu_R(dc, a->b));
     return true;
 }
 
 static bool trans_l_sfleu(DisasContext *dc, arg_ab *a)
 {
-    tcg_gen_setcond_tl(TCG_COND_LEU, cpu_sr_f, cpu_R[a->a], cpu_R[a->b]);
+    tcg_gen_setcond_tl(TCG_COND_LEU, cpu_sr_f,
+                       cpu_R(dc, a->a), cpu_R(dc, a->b));
     return true;
 }
 
 static bool trans_l_sfgts(DisasContext *dc, arg_ab *a)
 {
-    tcg_gen_setcond_tl(TCG_COND_GT, cpu_sr_f, cpu_R[a->a], cpu_R[a->b]);
+    tcg_gen_setcond_tl(TCG_COND_GT, cpu_sr_f,
+                       cpu_R(dc, a->a), cpu_R(dc, a->b));
     return true;
 }
 
 static bool trans_l_sfges(DisasContext *dc, arg_ab *a)
 {
-    tcg_gen_setcond_tl(TCG_COND_GE, cpu_sr_f, cpu_R[a->a], cpu_R[a->b]);
+    tcg_gen_setcond_tl(TCG_COND_GE, cpu_sr_f,
+                       cpu_R(dc, a->a), cpu_R(dc, a->b));
     return true;
 }
 
 static bool trans_l_sflts(DisasContext *dc, arg_ab *a)
 {
-    tcg_gen_setcond_tl(TCG_COND_LT, cpu_sr_f, cpu_R[a->a], cpu_R[a->b]);
+    tcg_gen_setcond_tl(TCG_COND_LT, cpu_sr_f,
+                       cpu_R(dc, a->a), cpu_R(dc, a->b));
     return true;
 }
 
 static bool trans_l_sfles(DisasContext *dc, arg_ab *a)
 {
-    tcg_gen_setcond_tl(TCG_COND_LE, cpu_sr_f, cpu_R[a->a], cpu_R[a->b]);
+    tcg_gen_setcond_tl(TCG_COND_LE,
+                       cpu_sr_f, cpu_R(dc, a->a), cpu_R(dc, a->b));
     return true;
 }
 
 static bool trans_l_sfeqi(DisasContext *dc, arg_ai *a)
 {
-    tcg_gen_setcondi_tl(TCG_COND_EQ, cpu_sr_f, cpu_R[a->a], a->i);
+    tcg_gen_setcondi_tl(TCG_COND_EQ, cpu_sr_f, cpu_R(dc, a->a), a->i);
     return true;
 }
 
 static bool trans_l_sfnei(DisasContext *dc, arg_ai *a)
 {
-    tcg_gen_setcondi_tl(TCG_COND_NE, cpu_sr_f, cpu_R[a->a], a->i);
+    tcg_gen_setcondi_tl(TCG_COND_NE, cpu_sr_f, cpu_R(dc, a->a), a->i);
     return true;
 }
 
 static bool trans_l_sfgtui(DisasContext *dc, arg_ai *a)
 {
-    tcg_gen_setcondi_tl(TCG_COND_GTU, cpu_sr_f, cpu_R[a->a], a->i);
+    tcg_gen_setcondi_tl(TCG_COND_GTU, cpu_sr_f, cpu_R(dc, a->a), a->i);
     return true;
 }
 
 static bool trans_l_sfgeui(DisasContext *dc, arg_ai *a)
 {
-    tcg_gen_setcondi_tl(TCG_COND_GEU, cpu_sr_f, cpu_R[a->a], a->i);
+    tcg_gen_setcondi_tl(TCG_COND_GEU, cpu_sr_f, cpu_R(dc, a->a), a->i);
     return true;
 }
 
 static bool trans_l_sfltui(DisasContext *dc, arg_ai *a)
 {
-    tcg_gen_setcondi_tl(TCG_COND_LTU, cpu_sr_f, cpu_R[a->a], a->i);
+    tcg_gen_setcondi_tl(TCG_COND_LTU, cpu_sr_f, cpu_R(dc, a->a), a->i);
     return true;
 }
 
 static bool trans_l_sfleui(DisasContext *dc, arg_ai *a)
 {
-    tcg_gen_setcondi_tl(TCG_COND_LEU, cpu_sr_f, cpu_R[a->a], a->i);
+    tcg_gen_setcondi_tl(TCG_COND_LEU, cpu_sr_f, cpu_R(dc, a->a), a->i);
     return true;
 }
 
 static bool trans_l_sfgtsi(DisasContext *dc, arg_ai *a)
 {
-    tcg_gen_setcondi_tl(TCG_COND_GT, cpu_sr_f, cpu_R[a->a], a->i);
+    tcg_gen_setcondi_tl(TCG_COND_GT, cpu_sr_f, cpu_R(dc, a->a), a->i);
     return true;
 }
 
 static bool trans_l_sfgesi(DisasContext *dc, arg_ai *a)
 {
-    tcg_gen_setcondi_tl(TCG_COND_GE, cpu_sr_f, cpu_R[a->a], a->i);
+    tcg_gen_setcondi_tl(TCG_COND_GE, cpu_sr_f, cpu_R(dc, a->a), a->i);
     return true;
 }
 
 static bool trans_l_sfltsi(DisasContext *dc, arg_ai *a)
 {
-    tcg_gen_setcondi_tl(TCG_COND_LT, cpu_sr_f, cpu_R[a->a], a->i);
+    tcg_gen_setcondi_tl(TCG_COND_LT, cpu_sr_f, cpu_R(dc, a->a), a->i);
     return true;
 }
 
 static bool trans_l_sflesi(DisasContext *dc, arg_ai *a)
 {
-    tcg_gen_setcondi_tl(TCG_COND_LE, cpu_sr_f, cpu_R[a->a], a->i);
+    tcg_gen_setcondi_tl(TCG_COND_LE, cpu_sr_f, cpu_R(dc, a->a), a->i);
     return true;
 }
 
@@ -1137,7 +1156,7 @@ static void do_fp2(DisasContext *dc, arg_da *a,
                    void (*fn)(TCGv, TCGv_env, TCGv))
 {
     check_r0_write(dc, a->d);
-    fn(cpu_R[a->d], cpu_env, cpu_R[a->a]);
+    fn(cpu_R(dc, a->d), cpu_env, cpu_R(dc, a->a));
     gen_helper_update_fpcsr(cpu_env);
 }
 
@@ -1145,7 +1164,7 @@ static void do_fp3(DisasContext *dc, arg_dab *a,
                    void (*fn)(TCGv, TCGv_env, TCGv, TCGv))
 {
     check_r0_write(dc, a->d);
-    fn(cpu_R[a->d], cpu_env, cpu_R[a->a], cpu_R[a->b]);
+    fn(cpu_R(dc, a->d), cpu_env, cpu_R(dc, a->a), cpu_R(dc, a->b));
     gen_helper_update_fpcsr(cpu_env);
 }
 
@@ -1154,9 +1173,9 @@ static void do_fpcmp(DisasContext *dc, arg_ab *a,
                      bool inv, bool swap)
 {
     if (swap) {
-        fn(cpu_sr_f, cpu_env, cpu_R[a->b], cpu_R[a->a]);
+        fn(cpu_sr_f, cpu_env, cpu_R(dc, a->b), cpu_R(dc, a->a));
     } else {
-        fn(cpu_sr_f, cpu_env, cpu_R[a->a], cpu_R[a->b]);
+        fn(cpu_sr_f, cpu_env, cpu_R(dc, a->a), cpu_R(dc, a->b));
     }
     if (inv) {
         tcg_gen_xori_tl(cpu_sr_f, cpu_sr_f, 1);
@@ -1209,8 +1228,8 @@ static bool trans_lf_ftoi_s(DisasContext *dc, arg_da *a)
 static bool trans_lf_madd_s(DisasContext *dc, arg_dab *a)
 {
     check_r0_write(dc, a->d);
-    gen_helper_float_madd_s(cpu_R[a->d], cpu_env, cpu_R[a->d],
-                            cpu_R[a->a], cpu_R[a->b]);
+    gen_helper_float_madd_s(cpu_R(dc, a->d), cpu_env, cpu_R(dc, a->d),
+                            cpu_R(dc, a->a), cpu_R(dc, a->b));
     gen_helper_update_fpcsr(cpu_env);
     return true;
 }
@@ -1273,9 +1292,9 @@ static void openrisc_tr_tb_start(DisasContextBase *db, CPUState *cs)
     /* Allow the TCG optimizer to see that R0 == 0,
        when it's true, which is the common case.  */
     if (dc->tb_flags & TB_FLAGS_R0_0) {
-        cpu_R[0] = tcg_const_tl(0);
+        cpu_regs[0] = tcg_const_tl(0);
     } else {
-        cpu_R[0] = cpu_R0;
+        cpu_regs[0] = cpu_R0;
     }
 }
 
-- 
2.17.1



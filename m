Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9A63C28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 18:31:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDC63206D5
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 18:31:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jFLvcqiY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDC63206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWOpJ-0005sE-TS
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 14:31:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60860)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jWOo7-0004PC-J0
 for qemu-devel@nongnu.org; Wed, 06 May 2020 14:30:11 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434]:44716)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jWOo6-0002vV-HZ
 for qemu-devel@nongnu.org; Wed, 06 May 2020 14:30:11 -0400
Received: by mail-pf1-x434.google.com with SMTP id p25so1416495pfn.11
 for <qemu-devel@nongnu.org>; Wed, 06 May 2020 11:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5E0pEn1U5VJfEC9GIolsazf+hdnyrEpcxC1RvioT0xA=;
 b=jFLvcqiYGISXRMM0FKutCgu/Sua2GUHF+S4yVxVCNZMv+gJpwDRgsd1wbfiBSIXPt7
 bVB9vRAPz05lXnoU4iO8Y84VQptCzabad84itsWEdCPcQ0q1WXZixRmW8O07V1zQVDys
 31cAaH9ojZO6Jxnh+uJABOWeJV9/gTq1DFtPa/Op/WvpZazAd9HAuTOiqVkGez/jHceR
 fBEnCfwpr9ciqoxm3/obhZ98Qeky6c+j9CKa/eH1XdBhq5d3a8jJ7vIACA9Nu0qgT67Z
 fsjQSBrjHohnoz6Zy2vpAlnXUzYTj5A6F0vjMWWAn0zaJ+stwGNOshlGXnN/9wH6F7Lr
 s/tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5E0pEn1U5VJfEC9GIolsazf+hdnyrEpcxC1RvioT0xA=;
 b=d8C51ssznMWxieuEfHv4ur0VitAn0u8H09VkwjOMFDZnRHbxyTZNR604HinQkg/w+1
 IJjlBUOcslViHZ4Nhc2dxpZqQuUZkO+70dcoEwgDi/K/N7i3T1BxJXdThBh9FJKp5bVT
 seWDA475z2Oq0NlueaxMn8aON710u3qbb0XT8XAbKiW4xWg+RLcLIWaAY0B7wBZQR9hh
 azRvmoiTgaIFXcxNvUsckj6NkyLnVfK6GM0x/7Fk7Hy9nfDxAXVgn5O57mf9JLHTzBtX
 CjAi/WJt+TzBfj4G/Y6mGCzxmfcX71kdpw/k4Ld0SuGnlO2xx7gVd6J2YrYPi7XFR4KP
 xMsA==
X-Gm-Message-State: AGi0PuanFYgpVil++B8tdc5+3cSbx8j72po2ltenxepmBnzy4o8yw0c+
 pFo2dT+XS+V5D8HBGEseqc0FPJYEEyA=
X-Google-Smtp-Source: APiQypLaSHAr9FQkbqyeQOa6EA7YM4gGCKTNCiFF2NWsqLRykbcvPb9Na2LJVwCSTia96nI+57Dm4g==
X-Received: by 2002:a62:3383:: with SMTP id z125mr9423461pfz.271.1588789808748; 
 Wed, 06 May 2020 11:30:08 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id w11sm2572589pfq.100.2020.05.06.11.30.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2020 11:30:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/10] target/arm: Use tcg_gen_gvec_dup_imm
Date: Wed,  6 May 2020 11:29:56 -0700
Message-Id: <20200506183002.3192-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200506183002.3192-1-richard.henderson@linaro.org>
References: <20200506183002.3192-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In a few cases, we're able to remove some manual replication.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-a64.c | 10 +++++-----
 target/arm/translate-sve.c | 12 +++++-------
 target/arm/translate.c     |  9 ++++++---
 3 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index a896f9c4b8..62e5729904 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -502,7 +502,7 @@ static void clear_vec_high(DisasContext *s, bool is_q, int rd)
         tcg_temp_free_i64(tcg_zero);
     }
     if (vsz > 16) {
-        tcg_gen_gvec_dup8i(ofs + 16, vsz - 16, vsz - 16, 0);
+        tcg_gen_gvec_dup_imm(MO_64, ofs + 16, vsz - 16, vsz - 16, 0);
     }
 }
 
@@ -7785,8 +7785,8 @@ static void disas_simd_mod_imm(DisasContext *s, uint32_t insn)
 
     if (!((cmode & 0x9) == 0x1 || (cmode & 0xd) == 0x9)) {
         /* MOVI or MVNI, with MVNI negation handled above.  */
-        tcg_gen_gvec_dup64i(vec_full_reg_offset(s, rd), is_q ? 16 : 8,
-                            vec_full_reg_size(s), imm);
+        tcg_gen_gvec_dup_imm(MO_64, vec_full_reg_offset(s, rd), is_q ? 16 : 8,
+                             vec_full_reg_size(s), imm);
     } else {
         /* ORR or BIC, with BIC negation to AND handled above.  */
         if (is_neg) {
@@ -10214,8 +10214,8 @@ static void handle_vec_simd_shri(DisasContext *s, bool is_q, bool is_u,
         if (is_u) {
             if (shift == 8 << size) {
                 /* Shift count the same size as element size produces zero.  */
-                tcg_gen_gvec_dup8i(vec_full_reg_offset(s, rd),
-                                   is_q ? 16 : 8, vec_full_reg_size(s), 0);
+                tcg_gen_gvec_dup_imm(size, vec_full_reg_offset(s, rd),
+                                     is_q ? 16 : 8, vec_full_reg_size(s), 0);
             } else {
                 gen_gvec_fn2i(s, is_q, rd, rn, shift, tcg_gen_gvec_shri, size);
             }
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index b35bad245e..6c8bda4e4c 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -177,7 +177,7 @@ static bool do_mov_z(DisasContext *s, int rd, int rn)
 static void do_dupi_z(DisasContext *s, int rd, uint64_t word)
 {
     unsigned vsz = vec_full_reg_size(s);
-    tcg_gen_gvec_dup64i(vec_full_reg_offset(s, rd), vsz, vsz, word);
+    tcg_gen_gvec_dup_imm(MO_64, vec_full_reg_offset(s, rd), vsz, vsz, word);
 }
 
 /* Invoke a vector expander on two Pregs.  */
@@ -1453,7 +1453,7 @@ static bool do_predset(DisasContext *s, int esz, int rd, int pat, bool setflag)
         unsigned oprsz = size_for_gvec(setsz / 8);
 
         if (oprsz * 8 == setsz) {
-            tcg_gen_gvec_dup64i(ofs, oprsz, maxsz, word);
+            tcg_gen_gvec_dup_imm(MO_64, ofs, oprsz, maxsz, word);
             goto done;
         }
     }
@@ -2044,7 +2044,7 @@ static bool trans_DUP_x(DisasContext *s, arg_DUP_x *a)
             unsigned nofs = vec_reg_offset(s, a->rn, index, esz);
             tcg_gen_gvec_dup_mem(esz, dofs, nofs, vsz, vsz);
         } else {
-            tcg_gen_gvec_dup64i(dofs, vsz, vsz, 0);
+            tcg_gen_gvec_dup_imm(esz, dofs, vsz, vsz, 0);
         }
     }
     return true;
@@ -3260,9 +3260,7 @@ static bool trans_FDUP(DisasContext *s, arg_FDUP *a)
 
         /* Decode the VFP immediate.  */
         imm = vfp_expand_imm(a->esz, a->imm);
-        imm = dup_const(a->esz, imm);
-
-        tcg_gen_gvec_dup64i(dofs, vsz, vsz, imm);
+        tcg_gen_gvec_dup_imm(a->esz, dofs, vsz, vsz, imm);
     }
     return true;
 }
@@ -3276,7 +3274,7 @@ static bool trans_DUP_i(DisasContext *s, arg_DUP_i *a)
         unsigned vsz = vec_full_reg_size(s);
         int dofs = vec_full_reg_offset(s, a->rd);
 
-        tcg_gen_gvec_dup64i(dofs, vsz, vsz, dup_const(a->esz, a->imm));
+        tcg_gen_gvec_dup_imm(a->esz, dofs, vsz, vsz, a->imm);
     }
     return true;
 }
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 025747c0bd..74fac1d09c 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -5209,7 +5209,8 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                                           MIN(shift, (8 << size) - 1),
                                           vec_size, vec_size);
                     } else if (shift >= 8 << size) {
-                        tcg_gen_gvec_dup8i(rd_ofs, vec_size, vec_size, 0);
+                        tcg_gen_gvec_dup_imm(MO_8, rd_ofs, vec_size,
+                                             vec_size, 0);
                     } else {
                         tcg_gen_gvec_shri(size, rd_ofs, rm_ofs, shift,
                                           vec_size, vec_size);
@@ -5260,7 +5261,8 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                          * architecturally valid and results in zero.
                          */
                         if (shift >= 8 << size) {
-                            tcg_gen_gvec_dup8i(rd_ofs, vec_size, vec_size, 0);
+                            tcg_gen_gvec_dup_imm(size, rd_ofs,
+                                                 vec_size, vec_size, 0);
                         } else {
                             tcg_gen_gvec_shli(size, rd_ofs, rm_ofs, shift,
                                               vec_size, vec_size);
@@ -5606,7 +5608,8 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
                     }
                     tcg_temp_free_i64(t64);
                 } else {
-                    tcg_gen_gvec_dup32i(reg_ofs, vec_size, vec_size, imm);
+                    tcg_gen_gvec_dup_imm(MO_32, reg_ofs, vec_size,
+                                         vec_size, imm);
                 }
             }
         }
-- 
2.20.1



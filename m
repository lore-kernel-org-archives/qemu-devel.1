Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B3C9C38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 18:29:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBCEE2192A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 18:29:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tYuUW3no"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBCEE2192A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX7kV-0003R7-Vg
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 14:29:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33718)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jX7hf-0006py-Fb
 for qemu-devel@nongnu.org; Fri, 08 May 2020 14:26:31 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:54673)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jX7hd-0006Jt-O9
 for qemu-devel@nongnu.org; Fri, 08 May 2020 14:26:31 -0400
Received: by mail-pj1-x1042.google.com with SMTP id y6so4678005pjc.4
 for <qemu-devel@nongnu.org>; Fri, 08 May 2020 11:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=xmadSpOQwsQc/jlcXZb4SKOmMYrqNW8ASv1JO/0wGNg=;
 b=tYuUW3noapmBsjf9Wk0HHaIHWWfTxMAUtFJqikZiu/8nqfOashyFzq8tJjElf55zsX
 MDMgsCLzgQlKST4xgfBdEX5HyY8udTR0likL1fcEOIBtomUnnU20gQLCCJ8gdCSrmhb1
 WAH+G7jx0LwhqESjmjk5dUNYloME/m2UzAvjWCRjO7ZdgRFQWquJtG0VJnWsAfqEruW/
 O/kstVkIPLFyLtlUfyUgZ4gC1kGtTO+OXPobnz3je9vUYs4MKCRyzQkmN2rtaGryLTho
 ed9Wceknh0aUIqi3TbRUg63sHqp7ykyzFlRMixacomoCDmCfjHs6Zz6J/klgux02mvPx
 wMTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xmadSpOQwsQc/jlcXZb4SKOmMYrqNW8ASv1JO/0wGNg=;
 b=YzdzjhtY1mLYIq/s6Bp6CfT9NUrgGwpGlzDrxkZiaLajj6WRFu+GPuqnifPbGKnMlk
 mmGrf2ZN6JmLJCom0VJhbxtLrvQ3uQfoCNhuRtI9PqSplDyO7f/UDQVm1K4xIU2UxGio
 QTuuBENwgeoLY/cwFyp9zvf9LdsuUI4caxg0eIh1EO4JqiAvnaX1+4Cbs4T4W6+7hmz3
 e7PJ7rG2GQebLwoj1dHiTogddZYuFMZA4IpLuOdXbnLffCtlXn4vXbm0LfA0thbvnjtH
 uZ93deg1CXTQMQnoW6zgJBLaLZI4xrPQ29a005JXET2eXnpr/m6HM5KLCmaZUfX8224q
 Bcfg==
X-Gm-Message-State: AGi0Pub+cvHcUR8rT8rHjtVumo80LKUL7RPMjDxzT9dWSLvCqDMdDMNT
 Bw6ZDQF5GiSmsdG66gLOM7fdtH1V9YA=
X-Google-Smtp-Source: APiQypK6gkCs8Hv4mGSTfTwKO8mUhygDuKI8EOwOu30jIeaQmuThjm1YVLe3jBrD4BuX693AyRzdBw==
X-Received: by 2002:a17:902:8b84:: with SMTP id
 ay4mr3692583plb.167.1588962387626; 
 Fri, 08 May 2020 11:26:27 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id u9sm2421775pfn.197.2020.05.08.11.26.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2020 11:26:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 07/19] tcg: Use tcg_constant_{i32, i64,
 vec} with tcg gvec expanders
Date: Fri,  8 May 2020 11:26:04 -0700
Message-Id: <20200508182616.18318-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200508182616.18318-1-richard.henderson@linaro.org>
References: <20200508182616.18318-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1042.google.com
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
Cc: alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op-gvec.c | 125 +++++++++++++++++++---------------------------
 1 file changed, 50 insertions(+), 75 deletions(-)

diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index 3707c0effb..8ecaf4d67e 100644
--- a/tcg/tcg-op-gvec.c
+++ b/tcg/tcg-op-gvec.c
@@ -96,7 +96,7 @@ void tcg_gen_gvec_2_ool(uint32_t dofs, uint32_t aofs,
                         gen_helper_gvec_2 *fn)
 {
     TCGv_ptr a0, a1;
-    TCGv_i32 desc = tcg_const_i32(simd_desc(oprsz, maxsz, data));
+    TCGv_i32 desc = tcg_constant_i32(simd_desc(oprsz, maxsz, data));
 
     a0 = tcg_temp_new_ptr();
     a1 = tcg_temp_new_ptr();
@@ -108,7 +108,6 @@ void tcg_gen_gvec_2_ool(uint32_t dofs, uint32_t aofs,
 
     tcg_temp_free_ptr(a0);
     tcg_temp_free_ptr(a1);
-    tcg_temp_free_i32(desc);
 }
 
 /* Generate a call to a gvec-style helper with two vector operands
@@ -118,7 +117,7 @@ void tcg_gen_gvec_2i_ool(uint32_t dofs, uint32_t aofs, TCGv_i64 c,
                          gen_helper_gvec_2i *fn)
 {
     TCGv_ptr a0, a1;
-    TCGv_i32 desc = tcg_const_i32(simd_desc(oprsz, maxsz, data));
+    TCGv_i32 desc = tcg_constant_i32(simd_desc(oprsz, maxsz, data));
 
     a0 = tcg_temp_new_ptr();
     a1 = tcg_temp_new_ptr();
@@ -130,7 +129,6 @@ void tcg_gen_gvec_2i_ool(uint32_t dofs, uint32_t aofs, TCGv_i64 c,
 
     tcg_temp_free_ptr(a0);
     tcg_temp_free_ptr(a1);
-    tcg_temp_free_i32(desc);
 }
 
 /* Generate a call to a gvec-style helper with three vector operands.  */
@@ -139,7 +137,7 @@ void tcg_gen_gvec_3_ool(uint32_t dofs, uint32_t aofs, uint32_t bofs,
                         gen_helper_gvec_3 *fn)
 {
     TCGv_ptr a0, a1, a2;
-    TCGv_i32 desc = tcg_const_i32(simd_desc(oprsz, maxsz, data));
+    TCGv_i32 desc = tcg_constant_i32(simd_desc(oprsz, maxsz, data));
 
     a0 = tcg_temp_new_ptr();
     a1 = tcg_temp_new_ptr();
@@ -154,7 +152,6 @@ void tcg_gen_gvec_3_ool(uint32_t dofs, uint32_t aofs, uint32_t bofs,
     tcg_temp_free_ptr(a0);
     tcg_temp_free_ptr(a1);
     tcg_temp_free_ptr(a2);
-    tcg_temp_free_i32(desc);
 }
 
 /* Generate a call to a gvec-style helper with four vector operands.  */
@@ -163,7 +160,7 @@ void tcg_gen_gvec_4_ool(uint32_t dofs, uint32_t aofs, uint32_t bofs,
                         int32_t data, gen_helper_gvec_4 *fn)
 {
     TCGv_ptr a0, a1, a2, a3;
-    TCGv_i32 desc = tcg_const_i32(simd_desc(oprsz, maxsz, data));
+    TCGv_i32 desc = tcg_constant_i32(simd_desc(oprsz, maxsz, data));
 
     a0 = tcg_temp_new_ptr();
     a1 = tcg_temp_new_ptr();
@@ -181,7 +178,6 @@ void tcg_gen_gvec_4_ool(uint32_t dofs, uint32_t aofs, uint32_t bofs,
     tcg_temp_free_ptr(a1);
     tcg_temp_free_ptr(a2);
     tcg_temp_free_ptr(a3);
-    tcg_temp_free_i32(desc);
 }
 
 /* Generate a call to a gvec-style helper with five vector operands.  */
@@ -190,7 +186,7 @@ void tcg_gen_gvec_5_ool(uint32_t dofs, uint32_t aofs, uint32_t bofs,
                         uint32_t maxsz, int32_t data, gen_helper_gvec_5 *fn)
 {
     TCGv_ptr a0, a1, a2, a3, a4;
-    TCGv_i32 desc = tcg_const_i32(simd_desc(oprsz, maxsz, data));
+    TCGv_i32 desc = tcg_constant_i32(simd_desc(oprsz, maxsz, data));
 
     a0 = tcg_temp_new_ptr();
     a1 = tcg_temp_new_ptr();
@@ -211,7 +207,6 @@ void tcg_gen_gvec_5_ool(uint32_t dofs, uint32_t aofs, uint32_t bofs,
     tcg_temp_free_ptr(a2);
     tcg_temp_free_ptr(a3);
     tcg_temp_free_ptr(a4);
-    tcg_temp_free_i32(desc);
 }
 
 /* Generate a call to a gvec-style helper with three vector operands
@@ -221,7 +216,7 @@ void tcg_gen_gvec_2_ptr(uint32_t dofs, uint32_t aofs,
                         int32_t data, gen_helper_gvec_2_ptr *fn)
 {
     TCGv_ptr a0, a1;
-    TCGv_i32 desc = tcg_const_i32(simd_desc(oprsz, maxsz, data));
+    TCGv_i32 desc = tcg_constant_i32(simd_desc(oprsz, maxsz, data));
 
     a0 = tcg_temp_new_ptr();
     a1 = tcg_temp_new_ptr();
@@ -233,7 +228,6 @@ void tcg_gen_gvec_2_ptr(uint32_t dofs, uint32_t aofs,
 
     tcg_temp_free_ptr(a0);
     tcg_temp_free_ptr(a1);
-    tcg_temp_free_i32(desc);
 }
 
 /* Generate a call to a gvec-style helper with three vector operands
@@ -243,7 +237,7 @@ void tcg_gen_gvec_3_ptr(uint32_t dofs, uint32_t aofs, uint32_t bofs,
                         int32_t data, gen_helper_gvec_3_ptr *fn)
 {
     TCGv_ptr a0, a1, a2;
-    TCGv_i32 desc = tcg_const_i32(simd_desc(oprsz, maxsz, data));
+    TCGv_i32 desc = tcg_constant_i32(simd_desc(oprsz, maxsz, data));
 
     a0 = tcg_temp_new_ptr();
     a1 = tcg_temp_new_ptr();
@@ -258,7 +252,6 @@ void tcg_gen_gvec_3_ptr(uint32_t dofs, uint32_t aofs, uint32_t bofs,
     tcg_temp_free_ptr(a0);
     tcg_temp_free_ptr(a1);
     tcg_temp_free_ptr(a2);
-    tcg_temp_free_i32(desc);
 }
 
 /* Generate a call to a gvec-style helper with four vector operands
@@ -269,7 +262,7 @@ void tcg_gen_gvec_4_ptr(uint32_t dofs, uint32_t aofs, uint32_t bofs,
                         gen_helper_gvec_4_ptr *fn)
 {
     TCGv_ptr a0, a1, a2, a3;
-    TCGv_i32 desc = tcg_const_i32(simd_desc(oprsz, maxsz, data));
+    TCGv_i32 desc = tcg_constant_i32(simd_desc(oprsz, maxsz, data));
 
     a0 = tcg_temp_new_ptr();
     a1 = tcg_temp_new_ptr();
@@ -287,7 +280,6 @@ void tcg_gen_gvec_4_ptr(uint32_t dofs, uint32_t aofs, uint32_t bofs,
     tcg_temp_free_ptr(a1);
     tcg_temp_free_ptr(a2);
     tcg_temp_free_ptr(a3);
-    tcg_temp_free_i32(desc);
 }
 
 /* Generate a call to a gvec-style helper with five vector operands
@@ -298,7 +290,7 @@ void tcg_gen_gvec_5_ptr(uint32_t dofs, uint32_t aofs, uint32_t bofs,
                         gen_helper_gvec_5_ptr *fn)
 {
     TCGv_ptr a0, a1, a2, a3, a4;
-    TCGv_i32 desc = tcg_const_i32(simd_desc(oprsz, maxsz, data));
+    TCGv_i32 desc = tcg_constant_i32(simd_desc(oprsz, maxsz, data));
 
     a0 = tcg_temp_new_ptr();
     a1 = tcg_temp_new_ptr();
@@ -319,7 +311,6 @@ void tcg_gen_gvec_5_ptr(uint32_t dofs, uint32_t aofs, uint32_t bofs,
     tcg_temp_free_ptr(a2);
     tcg_temp_free_ptr(a3);
     tcg_temp_free_ptr(a4);
-    tcg_temp_free_i32(desc);
 }
 
 /* Return true if we want to implement something of OPRSZ bytes
@@ -609,16 +600,13 @@ static void do_dup(unsigned vece, uint32_t dofs, uint32_t oprsz,
     /* Otherwise implement out of line.  */
     t_ptr = tcg_temp_new_ptr();
     tcg_gen_addi_ptr(t_ptr, cpu_env, dofs);
-    t_desc = tcg_const_i32(simd_desc(oprsz, maxsz, 0));
+    t_desc = tcg_constant_i32(simd_desc(oprsz, maxsz, 0));
 
     if (vece == MO_64) {
-        if (in_64) {
-            gen_helper_gvec_dup64(t_ptr, t_desc, in_64);
-        } else {
-            t_64 = tcg_const_i64(in_c);
-            gen_helper_gvec_dup64(t_ptr, t_desc, t_64);
-            tcg_temp_free_i64(t_64);
+        if (!in_64) {
+            in_64 = tcg_constant_i64(in_c);
         }
+        gen_helper_gvec_dup64(t_ptr, t_desc, in_64);
     } else {
         typedef void dup_fn(TCGv_ptr, TCGv_i32, TCGv_i32);
         static dup_fn * const fns[3] = {
@@ -646,7 +634,6 @@ static void do_dup(unsigned vece, uint32_t dofs, uint32_t oprsz,
     }
 
     tcg_temp_free_ptr(t_ptr);
-    tcg_temp_free_i32(t_desc);
     return;
 
  done:
@@ -1196,10 +1183,8 @@ void tcg_gen_gvec_2i(uint32_t dofs, uint32_t aofs, uint32_t oprsz,
             if (g->fno) {
                 tcg_gen_gvec_2_ool(dofs, aofs, oprsz, maxsz, c, g->fno);
             } else {
-                TCGv_i64 tcg_c = tcg_const_i64(c);
-                tcg_gen_gvec_2i_ool(dofs, aofs, tcg_c, oprsz,
-                                    maxsz, c, g->fnoi);
-                tcg_temp_free_i64(tcg_c);
+                tcg_gen_gvec_2i_ool(dofs, aofs, tcg_constant_i64(c),
+                                    oprsz, maxsz, 0, g->fnoi);
             }
             oprsz = maxsz;
         }
@@ -1647,16 +1632,14 @@ static void gen_addv_mask(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b, TCGv_i64 m)
 
 void tcg_gen_vec_add8_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
 {
-    TCGv_i64 m = tcg_const_i64(dup_const(MO_8, 0x80));
+    TCGv_i64 m = tcg_constant_i64(dup_const(MO_8, 0x80));
     gen_addv_mask(d, a, b, m);
-    tcg_temp_free_i64(m);
 }
 
 void tcg_gen_vec_add16_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
 {
-    TCGv_i64 m = tcg_const_i64(dup_const(MO_16, 0x8000));
+    TCGv_i64 m = tcg_constant_i64(dup_const(MO_16, 0x8000));
     gen_addv_mask(d, a, b, m);
-    tcg_temp_free_i64(m);
 }
 
 void tcg_gen_vec_add32_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
@@ -1740,9 +1723,8 @@ void tcg_gen_gvec_adds(unsigned vece, uint32_t dofs, uint32_t aofs,
 void tcg_gen_gvec_addi(unsigned vece, uint32_t dofs, uint32_t aofs,
                        int64_t c, uint32_t oprsz, uint32_t maxsz)
 {
-    TCGv_i64 tmp = tcg_const_i64(c);
+    TCGv_i64 tmp = tcg_constant_i64(c);
     tcg_gen_gvec_adds(vece, dofs, aofs, tmp, oprsz, maxsz);
-    tcg_temp_free_i64(tmp);
 }
 
 static const TCGOpcode vecop_list_sub[] = { INDEX_op_sub_vec, 0 };
@@ -1800,16 +1782,14 @@ static void gen_subv_mask(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b, TCGv_i64 m)
 
 void tcg_gen_vec_sub8_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
 {
-    TCGv_i64 m = tcg_const_i64(dup_const(MO_8, 0x80));
+    TCGv_i64 m = tcg_constant_i64(dup_const(MO_8, 0x80));
     gen_subv_mask(d, a, b, m);
-    tcg_temp_free_i64(m);
 }
 
 void tcg_gen_vec_sub16_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
 {
-    TCGv_i64 m = tcg_const_i64(dup_const(MO_16, 0x8000));
+    TCGv_i64 m = tcg_constant_i64(dup_const(MO_16, 0x8000));
     gen_subv_mask(d, a, b, m);
-    tcg_temp_free_i64(m);
 }
 
 void tcg_gen_vec_sub32_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
@@ -1920,9 +1900,8 @@ void tcg_gen_gvec_muls(unsigned vece, uint32_t dofs, uint32_t aofs,
 void tcg_gen_gvec_muli(unsigned vece, uint32_t dofs, uint32_t aofs,
                        int64_t c, uint32_t oprsz, uint32_t maxsz)
 {
-    TCGv_i64 tmp = tcg_const_i64(c);
+    TCGv_i64 tmp = tcg_constant_i64(c);
     tcg_gen_gvec_muls(vece, dofs, aofs, tmp, oprsz, maxsz);
-    tcg_temp_free_i64(tmp);
 }
 
 void tcg_gen_gvec_ssadd(unsigned vece, uint32_t dofs, uint32_t aofs,
@@ -1979,18 +1958,16 @@ void tcg_gen_gvec_sssub(unsigned vece, uint32_t dofs, uint32_t aofs,
 
 static void tcg_gen_usadd_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
 {
-    TCGv_i32 max = tcg_const_i32(-1);
+    TCGv_i32 max = tcg_constant_i32(-1);
     tcg_gen_add_i32(d, a, b);
     tcg_gen_movcond_i32(TCG_COND_LTU, d, d, a, max, d);
-    tcg_temp_free_i32(max);
 }
 
 static void tcg_gen_usadd_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
 {
-    TCGv_i64 max = tcg_const_i64(-1);
+    TCGv_i64 max = tcg_constant_i64(-1);
     tcg_gen_add_i64(d, a, b);
     tcg_gen_movcond_i64(TCG_COND_LTU, d, d, a, max, d);
-    tcg_temp_free_i64(max);
 }
 
 void tcg_gen_gvec_usadd(unsigned vece, uint32_t dofs, uint32_t aofs,
@@ -2023,18 +2000,16 @@ void tcg_gen_gvec_usadd(unsigned vece, uint32_t dofs, uint32_t aofs,
 
 static void tcg_gen_ussub_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
 {
-    TCGv_i32 min = tcg_const_i32(0);
+    TCGv_i32 min = tcg_constant_i32(0);
     tcg_gen_sub_i32(d, a, b);
     tcg_gen_movcond_i32(TCG_COND_LTU, d, a, b, min, d);
-    tcg_temp_free_i32(min);
 }
 
 static void tcg_gen_ussub_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b)
 {
-    TCGv_i64 min = tcg_const_i64(0);
+    TCGv_i64 min = tcg_constant_i64(0);
     tcg_gen_sub_i64(d, a, b);
     tcg_gen_movcond_i64(TCG_COND_LTU, d, a, b, min, d);
-    tcg_temp_free_i64(min);
 }
 
 void tcg_gen_gvec_ussub(unsigned vece, uint32_t dofs, uint32_t aofs,
@@ -2195,16 +2170,14 @@ static void gen_negv_mask(TCGv_i64 d, TCGv_i64 b, TCGv_i64 m)
 
 void tcg_gen_vec_neg8_i64(TCGv_i64 d, TCGv_i64 b)
 {
-    TCGv_i64 m = tcg_const_i64(dup_const(MO_8, 0x80));
+    TCGv_i64 m = tcg_constant_i64(dup_const(MO_8, 0x80));
     gen_negv_mask(d, b, m);
-    tcg_temp_free_i64(m);
 }
 
 void tcg_gen_vec_neg16_i64(TCGv_i64 d, TCGv_i64 b)
 {
-    TCGv_i64 m = tcg_const_i64(dup_const(MO_16, 0x8000));
+    TCGv_i64 m = tcg_constant_i64(dup_const(MO_16, 0x8000));
     gen_negv_mask(d, b, m);
-    tcg_temp_free_i64(m);
 }
 
 void tcg_gen_vec_neg32_i64(TCGv_i64 d, TCGv_i64 b)
@@ -2472,9 +2445,8 @@ void tcg_gen_gvec_ands(unsigned vece, uint32_t dofs, uint32_t aofs,
 void tcg_gen_gvec_andi(unsigned vece, uint32_t dofs, uint32_t aofs,
                        int64_t c, uint32_t oprsz, uint32_t maxsz)
 {
-    TCGv_i64 tmp = tcg_const_i64(dup_const(vece, c));
+    TCGv_i64 tmp = tcg_constant_i64(dup_const(vece, c));
     tcg_gen_gvec_2s(dofs, aofs, oprsz, maxsz, tmp, &gop_ands);
-    tcg_temp_free_i64(tmp);
 }
 
 static const GVecGen2s gop_xors = {
@@ -2497,9 +2469,8 @@ void tcg_gen_gvec_xors(unsigned vece, uint32_t dofs, uint32_t aofs,
 void tcg_gen_gvec_xori(unsigned vece, uint32_t dofs, uint32_t aofs,
                        int64_t c, uint32_t oprsz, uint32_t maxsz)
 {
-    TCGv_i64 tmp = tcg_const_i64(dup_const(vece, c));
+    TCGv_i64 tmp = tcg_constant_i64(dup_const(vece, c));
     tcg_gen_gvec_2s(dofs, aofs, oprsz, maxsz, tmp, &gop_xors);
-    tcg_temp_free_i64(tmp);
 }
 
 static const GVecGen2s gop_ors = {
@@ -2522,9 +2493,8 @@ void tcg_gen_gvec_ors(unsigned vece, uint32_t dofs, uint32_t aofs,
 void tcg_gen_gvec_ori(unsigned vece, uint32_t dofs, uint32_t aofs,
                       int64_t c, uint32_t oprsz, uint32_t maxsz)
 {
-    TCGv_i64 tmp = tcg_const_i64(dup_const(vece, c));
+    TCGv_i64 tmp = tcg_constant_i64(dup_const(vece, c));
     tcg_gen_gvec_2s(dofs, aofs, oprsz, maxsz, tmp, &gop_ors);
-    tcg_temp_free_i64(tmp);
 }
 
 void tcg_gen_vec_shl8i_i64(TCGv_i64 d, TCGv_i64 a, int64_t c)
@@ -3011,10 +2981,11 @@ void tcg_gen_gvec_rotls(unsigned vece, uint32_t dofs, uint32_t aofs,
 static void tcg_gen_shlv_mod_vec(unsigned vece, TCGv_vec d,
                                  TCGv_vec a, TCGv_vec b)
 {
-    TCGv_vec t = tcg_temp_new_vec_matching(d);
+    TCGType type = tcgv_vec_temp(d)->type;
+    TCGv_vec t = tcg_temp_new_vec(type);
+    TCGv_vec m = tcg_constant_vec(type, vece, (8 << vece) - 1);
 
-    tcg_gen_dupi_vec(vece, t, (8 << vece) - 1);
-    tcg_gen_and_vec(vece, t, t, b);
+    tcg_gen_and_vec(vece, t, b, m);
     tcg_gen_shlv_vec(vece, d, a, t);
     tcg_temp_free_vec(t);
 }
@@ -3074,10 +3045,11 @@ void tcg_gen_gvec_shlv(unsigned vece, uint32_t dofs, uint32_t aofs,
 static void tcg_gen_shrv_mod_vec(unsigned vece, TCGv_vec d,
                                  TCGv_vec a, TCGv_vec b)
 {
-    TCGv_vec t = tcg_temp_new_vec_matching(d);
+    TCGType type = tcgv_vec_temp(d)->type;
+    TCGv_vec t = tcg_temp_new_vec(type);
+    TCGv_vec m = tcg_constant_vec(type, vece, (8 << vece) - 1);
 
-    tcg_gen_dupi_vec(vece, t, (8 << vece) - 1);
-    tcg_gen_and_vec(vece, t, t, b);
+    tcg_gen_and_vec(vece, t, b, m);
     tcg_gen_shrv_vec(vece, d, a, t);
     tcg_temp_free_vec(t);
 }
@@ -3137,10 +3109,11 @@ void tcg_gen_gvec_shrv(unsigned vece, uint32_t dofs, uint32_t aofs,
 static void tcg_gen_sarv_mod_vec(unsigned vece, TCGv_vec d,
                                  TCGv_vec a, TCGv_vec b)
 {
-    TCGv_vec t = tcg_temp_new_vec_matching(d);
+    TCGType type = tcgv_vec_temp(d)->type;
+    TCGv_vec t = tcg_temp_new_vec(type);
+    TCGv_vec m = tcg_constant_vec(type, vece, (8 << vece) - 1);
 
-    tcg_gen_dupi_vec(vece, t, (8 << vece) - 1);
-    tcg_gen_and_vec(vece, t, t, b);
+    tcg_gen_and_vec(vece, t, b, m);
     tcg_gen_sarv_vec(vece, d, a, t);
     tcg_temp_free_vec(t);
 }
@@ -3200,10 +3173,11 @@ void tcg_gen_gvec_sarv(unsigned vece, uint32_t dofs, uint32_t aofs,
 static void tcg_gen_rotlv_mod_vec(unsigned vece, TCGv_vec d,
                                   TCGv_vec a, TCGv_vec b)
 {
-    TCGv_vec t = tcg_temp_new_vec_matching(d);
+    TCGType type = tcgv_vec_temp(d)->type;
+    TCGv_vec t = tcg_temp_new_vec(type);
+    TCGv_vec m = tcg_constant_vec(type, vece, (8 << vece) - 1);
 
-    tcg_gen_dupi_vec(vece, t, (8 << vece) - 1);
-    tcg_gen_and_vec(vece, t, t, b);
+    tcg_gen_and_vec(vece, t, b, m);
     tcg_gen_rotlv_vec(vece, d, a, t);
     tcg_temp_free_vec(t);
 }
@@ -3259,10 +3233,11 @@ void tcg_gen_gvec_rotlv(unsigned vece, uint32_t dofs, uint32_t aofs,
 static void tcg_gen_rotrv_mod_vec(unsigned vece, TCGv_vec d,
                                   TCGv_vec a, TCGv_vec b)
 {
-    TCGv_vec t = tcg_temp_new_vec_matching(d);
+    TCGType type = tcgv_vec_temp(d)->type;
+    TCGv_vec t = tcg_temp_new_vec(type);
+    TCGv_vec m = tcg_constant_vec(type, vece, (8 << vece) - 1);
 
-    tcg_gen_dupi_vec(vece, t, (8 << vece) - 1);
-    tcg_gen_and_vec(vece, t, t, b);
+    tcg_gen_and_vec(vece, t, b, m);
     tcg_gen_rotrv_vec(vece, d, a, t);
     tcg_temp_free_vec(t);
 }
-- 
2.20.1



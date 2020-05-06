Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8E12C28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 18:34:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9896B20736
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 18:34:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uJmz11sO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9896B20736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWOsF-00014d-Jn
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 14:34:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60948)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jWOoE-0004aF-6Q
 for qemu-devel@nongnu.org; Wed, 06 May 2020 14:30:18 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432]:46565)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jWOoD-00032s-2C
 for qemu-devel@nongnu.org; Wed, 06 May 2020 14:30:17 -0400
Received: by mail-pf1-x432.google.com with SMTP id 145so1408459pfw.13
 for <qemu-devel@nongnu.org>; Wed, 06 May 2020 11:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=hktRCt+zPcMLEnvaBC38jKwfPbiQdX/9XB+JNDn/fPU=;
 b=uJmz11sOKwhuxr29agT+kmoXmmHiRIW+iBUJyD7hrknHRoMUGUwZ85b7NWpGfZjOAs
 4jXozEzsO15Ago5zYhdvHYo4T+BFyOlKpt0iWUOEY6IFDngYJg562436QIE1CHTYY/Uz
 ILrY23vDuJKEEXfipOs2VhIhmWWwq7qBj1+cOxe0bSEqs6i2aQPtxKEaiIjUO/iN60E5
 meFWIb/MiUZTl6cU20Kot/6Iv0lxJLX2FfsHHPN+Oo6H8M7tnIqTcTrf9MsQUcAKB02l
 xr6EF0s2EhP/2cr2ta2KR4qlKF1l52Qekolk5tNgGcISrhuO9i4fdafS/f6Yi/7ISbJ0
 7RZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hktRCt+zPcMLEnvaBC38jKwfPbiQdX/9XB+JNDn/fPU=;
 b=OwG4GMBHpRdEWMsgbNqvdipPUbWRLhP0hPBssg8gwoGaCTkPksVG5fI9QVqSXH0GYl
 upTQkrNA6I+F2tKjSZeAOAhIitEfGa033oDDpxm5aU0icSlVBATn3NG7eCU1R0NklE+h
 A00jSbEk+CVvh8HDk/YYQ0m5bt8OFNU0Y7Eh2g78H901tWVeWa0G5UwEuyhUPbFy8wYW
 ZAB5v69BKRT3HrA+4cy4IcURdwgwA27NDN36B4p7/Gk0QSTOzQyUICBecoQl99ysBpjM
 0fcKKmRWgYGsA4sTKLnsmtTa2gnnGZdDsYBKwFExjBwjD2tHR8OpYT2uo8raYmGKGrx2
 v1og==
X-Gm-Message-State: AGi0PubOtT27ZSsj8nWUerNBjnwp+neh3MWHJRKOIkX/+yPH127lP6W/
 uztEtOLUWGxSDK5JCMGi59dTtUjSVjQ=
X-Google-Smtp-Source: APiQypJOm3/3xLRWNwKKpN5sOaV4O8hG7IRkyueWzug4kiLnZhgPTVVZ9tmpu8ELHLhYTwm5lL7y5w==
X-Received: by 2002:aa7:9302:: with SMTP id 2mr9461325pfj.256.1588789815175;
 Wed, 06 May 2020 11:30:15 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id w11sm2572589pfq.100.2020.05.06.11.30.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2020 11:30:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/10] tcg: Add load_dest parameter to GVecGen2
Date: Wed,  6 May 2020 11:30:01 -0700
Message-Id: <20200506183002.3192-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200506183002.3192-1-richard.henderson@linaro.org>
References: <20200506183002.3192-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

We have this same parameter for GVecGen2i, GVecGen3,
and GVecGen3i.  This will make some SVE2 insns easier
to parameterize.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-gvec.h |  2 ++
 tcg/tcg-op-gvec.c         | 45 ++++++++++++++++++++++++++++-----------
 2 files changed, 34 insertions(+), 13 deletions(-)

diff --git a/include/tcg/tcg-op-gvec.h b/include/tcg/tcg-op-gvec.h
index d89f91f40e..cea6497341 100644
--- a/include/tcg/tcg-op-gvec.h
+++ b/include/tcg/tcg-op-gvec.h
@@ -109,6 +109,8 @@ typedef struct {
     uint8_t vece;
     /* Prefer i64 to v64.  */
     bool prefer_i64;
+    /* Load dest as a 2nd source operand.  */
+    bool load_dest;
 } GVecGen2;
 
 typedef struct {
diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index 43cac1a0bf..049a55e700 100644
--- a/tcg/tcg-op-gvec.c
+++ b/tcg/tcg-op-gvec.c
@@ -663,17 +663,22 @@ static void expand_clr(uint32_t dofs, uint32_t maxsz)
 
 /* Expand OPSZ bytes worth of two-operand operations using i32 elements.  */
 static void expand_2_i32(uint32_t dofs, uint32_t aofs, uint32_t oprsz,
-                         void (*fni)(TCGv_i32, TCGv_i32))
+                         bool load_dest, void (*fni)(TCGv_i32, TCGv_i32))
 {
     TCGv_i32 t0 = tcg_temp_new_i32();
+    TCGv_i32 t1 = tcg_temp_new_i32();
     uint32_t i;
 
     for (i = 0; i < oprsz; i += 4) {
         tcg_gen_ld_i32(t0, cpu_env, aofs + i);
-        fni(t0, t0);
-        tcg_gen_st_i32(t0, cpu_env, dofs + i);
+        if (load_dest) {
+            tcg_gen_ld_i32(t1, cpu_env, dofs + i);
+        }
+        fni(t1, t0);
+        tcg_gen_st_i32(t1, cpu_env, dofs + i);
     }
     tcg_temp_free_i32(t0);
+    tcg_temp_free_i32(t1);
 }
 
 static void expand_2i_i32(uint32_t dofs, uint32_t aofs, uint32_t oprsz,
@@ -793,17 +798,22 @@ static void expand_4_i32(uint32_t dofs, uint32_t aofs, uint32_t bofs,
 
 /* Expand OPSZ bytes worth of two-operand operations using i64 elements.  */
 static void expand_2_i64(uint32_t dofs, uint32_t aofs, uint32_t oprsz,
-                         void (*fni)(TCGv_i64, TCGv_i64))
+                         bool load_dest, void (*fni)(TCGv_i64, TCGv_i64))
 {
     TCGv_i64 t0 = tcg_temp_new_i64();
+    TCGv_i64 t1 = tcg_temp_new_i64();
     uint32_t i;
 
     for (i = 0; i < oprsz; i += 8) {
         tcg_gen_ld_i64(t0, cpu_env, aofs + i);
-        fni(t0, t0);
-        tcg_gen_st_i64(t0, cpu_env, dofs + i);
+        if (load_dest) {
+            tcg_gen_ld_i64(t1, cpu_env, dofs + i);
+        }
+        fni(t1, t0);
+        tcg_gen_st_i64(t1, cpu_env, dofs + i);
     }
     tcg_temp_free_i64(t0);
+    tcg_temp_free_i64(t1);
 }
 
 static void expand_2i_i64(uint32_t dofs, uint32_t aofs, uint32_t oprsz,
@@ -924,17 +934,23 @@ static void expand_4_i64(uint32_t dofs, uint32_t aofs, uint32_t bofs,
 /* Expand OPSZ bytes worth of two-operand operations using host vectors.  */
 static void expand_2_vec(unsigned vece, uint32_t dofs, uint32_t aofs,
                          uint32_t oprsz, uint32_t tysz, TCGType type,
+                         bool load_dest,
                          void (*fni)(unsigned, TCGv_vec, TCGv_vec))
 {
     TCGv_vec t0 = tcg_temp_new_vec(type);
+    TCGv_vec t1 = tcg_temp_new_vec(type);
     uint32_t i;
 
     for (i = 0; i < oprsz; i += tysz) {
         tcg_gen_ld_vec(t0, cpu_env, aofs + i);
-        fni(vece, t0, t0);
-        tcg_gen_st_vec(t0, cpu_env, dofs + i);
+        if (load_dest) {
+            tcg_gen_ld_vec(t1, cpu_env, dofs + i);
+        }
+        fni(vece, t1, t0);
+        tcg_gen_st_vec(t1, cpu_env, dofs + i);
     }
     tcg_temp_free_vec(t0);
+    tcg_temp_free_vec(t1);
 }
 
 /* Expand OPSZ bytes worth of two-vector operands and an immediate operand
@@ -1088,7 +1104,8 @@ void tcg_gen_gvec_2(uint32_t dofs, uint32_t aofs,
          * that e.g. size == 80 would be expanded with 2x32 + 1x16.
          */
         some = QEMU_ALIGN_DOWN(oprsz, 32);
-        expand_2_vec(g->vece, dofs, aofs, some, 32, TCG_TYPE_V256, g->fniv);
+        expand_2_vec(g->vece, dofs, aofs, some, 32, TCG_TYPE_V256,
+                     g->load_dest, g->fniv);
         if (some == oprsz) {
             break;
         }
@@ -1098,17 +1115,19 @@ void tcg_gen_gvec_2(uint32_t dofs, uint32_t aofs,
         maxsz -= some;
         /* fallthru */
     case TCG_TYPE_V128:
-        expand_2_vec(g->vece, dofs, aofs, oprsz, 16, TCG_TYPE_V128, g->fniv);
+        expand_2_vec(g->vece, dofs, aofs, oprsz, 16, TCG_TYPE_V128,
+                     g->load_dest, g->fniv);
         break;
     case TCG_TYPE_V64:
-        expand_2_vec(g->vece, dofs, aofs, oprsz, 8, TCG_TYPE_V64, g->fniv);
+        expand_2_vec(g->vece, dofs, aofs, oprsz, 8, TCG_TYPE_V64,
+                     g->load_dest, g->fniv);
         break;
 
     case 0:
         if (g->fni8 && check_size_impl(oprsz, 8)) {
-            expand_2_i64(dofs, aofs, oprsz, g->fni8);
+            expand_2_i64(dofs, aofs, oprsz, g->load_dest, g->fni8);
         } else if (g->fni4 && check_size_impl(oprsz, 4)) {
-            expand_2_i32(dofs, aofs, oprsz, g->fni4);
+            expand_2_i32(dofs, aofs, oprsz, g->load_dest, g->fni4);
         } else {
             assert(g->fno != NULL);
             tcg_gen_gvec_2_ool(dofs, aofs, oprsz, maxsz, g->data, g->fno);
-- 
2.20.1



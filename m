Return-Path: <SRS0=r7Ry=6C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4FBCC38A29
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2020 16:23:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DFA32054F
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2020 16:23:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WXSbWM+k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DFA32054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPqFa-00017C-O1
	for qemu-devel@archiver.kernel.org; Sat, 18 Apr 2020 12:23:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48131)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jPqBi-00048S-8z
 for qemu-devel@nongnu.org; Sat, 18 Apr 2020 12:19:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jPqBg-00050q-SZ
 for qemu-devel@nongnu.org; Sat, 18 Apr 2020 12:19:26 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:33859)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jPqBg-0004yy-Mg
 for qemu-devel@nongnu.org; Sat, 18 Apr 2020 12:19:24 -0400
Received: by mail-pf1-x444.google.com with SMTP id d1so2704261pfh.1
 for <qemu-devel@nongnu.org>; Sat, 18 Apr 2020 09:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=jnoGz1Jnxdfh+y+NorE/kRAs3qyr4Q4Rbpyv23cxSxY=;
 b=WXSbWM+kCCFQSkXgZ8HzhR59qFBZ2mFxmuuW97ha4MYxtkTO2FT61LqbKedi0vyJpe
 uP3MDJEoBZMQuepLtap6GyAATbcKO5bquR7Pv0tEomjfOiAafa80ESckpAcIeSvpBj11
 m+KwxvmWC8HUpD6nitY6q346nzh3JmekU2BaZzKGaKGz1nKunwmJM75n/uiqV9PQGGVO
 afwdUfxc3ZtKmBzdkIPpeVnQiVZWk8TU/TcHibEi2FhkHTSs7Yl/1IO2U4q0jN27lOQR
 CvofDOi6eU9p+4NOwS5FIiZxUECEwuryfPzlvWquqbhZROlBkLyge4qhRFvLI5G9E3op
 BO3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jnoGz1Jnxdfh+y+NorE/kRAs3qyr4Q4Rbpyv23cxSxY=;
 b=njQgn7A5sCSd3EekJNQoaQH7FSFjYRKEdWexxWc4Qcyuz+CLTGXYfoex4u3RHV7Jrz
 f0aG6CMF9LriLBe6PFOnQolr9ZFfxEA8SWZQ/f0NaiLDtPvJjV3O4qy8jX51W4ZTHTsq
 TyGjP7MfPy4k0cSjTX9LMDoisebXMZbBl1oL1dIZ0Nm4sSFlxRkeoSAXz9OL8/V7ifjr
 urnkfosoGdIfP3Jby6Sad7VKljnHUXMQhB1WkaccHgQgtYPFHpNuCUDT+tBjpH1UdE33
 C3pDszO8zVKmIOdH4V6TlvpMP0BZS+ITjBoIFizpjuzsscAU9xWAUZhaQXC+I2Grrgey
 m2OQ==
X-Gm-Message-State: AGi0PuYCi7KqKcZFOCc0+SbVrDZOlbCNhSfzk9oC15gJ7fbPuuLP8rKP
 CUxK8POkZhqx5ICpDtKS6hoiKb8M+ZQ=
X-Google-Smtp-Source: APiQypJTbeyp/8kA94pYszo1r5NWz8CHdXVEi0ctCOLZBuljy1sy4L++kkgkHEdE3hnGbnpwgIFFvw==
X-Received: by 2002:aa7:9f03:: with SMTP id g3mr9174714pfr.287.1587226763198; 
 Sat, 18 Apr 2020 09:19:23 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id i187sm22398382pfc.112.2020.04.18.09.19.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Apr 2020 09:19:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 05/16] tcg: Use tcg_constant_{i32,vec} with tcg vec expanders
Date: Sat, 18 Apr 2020 09:19:03 -0700
Message-Id: <20200418161914.4387-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200418161914.4387-1-richard.henderson@linaro.org>
References: <20200418161914.4387-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op-vec.c | 63 ++++++++++++++++++++++++++----------------------
 1 file changed, 34 insertions(+), 29 deletions(-)

diff --git a/tcg/tcg-op-vec.c b/tcg/tcg-op-vec.c
index f3927089a7..655b3ae32d 100644
--- a/tcg/tcg-op-vec.c
+++ b/tcg/tcg-op-vec.c
@@ -233,25 +233,17 @@ void tcg_gen_mov_vec(TCGv_vec r, TCGv_vec a)
     }
 }
 
-#define MO_REG  (TCG_TARGET_REG_BITS == 64 ? MO_64 : MO_32)
-
-static void do_dupi_vec(TCGv_vec r, unsigned vece, TCGArg a)
-{
-    TCGTemp *rt = tcgv_vec_temp(r);
-    vec_gen_2(INDEX_op_dupi_vec, rt->base_type, vece, temp_arg(rt), a);
-}
-
 TCGv_vec tcg_const_zeros_vec(TCGType type)
 {
     TCGv_vec ret = tcg_temp_new_vec(type);
-    do_dupi_vec(ret, MO_REG, 0);
+    tcg_gen_mov_vec(ret, tcg_constant_vec(type, MO_8, 0));
     return ret;
 }
 
 TCGv_vec tcg_const_ones_vec(TCGType type)
 {
     TCGv_vec ret = tcg_temp_new_vec(type);
-    do_dupi_vec(ret, MO_REG, -1);
+    tcg_gen_mov_vec(ret, tcg_constant_vec(type, MO_8, -1));
     return ret;
 }
 
@@ -267,37 +259,50 @@ TCGv_vec tcg_const_ones_vec_matching(TCGv_vec m)
     return tcg_const_ones_vec(t->base_type);
 }
 
-void tcg_gen_dup64i_vec(TCGv_vec r, uint64_t a)
+void tcg_gen_dupi_vec(unsigned vece, TCGv_vec dest, uint64_t val)
 {
-    if (TCG_TARGET_REG_BITS == 32 && a == deposit64(a, 32, 32, a)) {
-        do_dupi_vec(r, MO_32, a);
-    } else if (TCG_TARGET_REG_BITS == 64 || a == (uint64_t)(int32_t)a) {
-        do_dupi_vec(r, MO_64, a);
-    } else {
-        TCGv_i64 c = tcg_const_i64(a);
-        tcg_gen_dup_i64_vec(MO_64, r, c);
-        tcg_temp_free_i64(c);
+    TCGType type = tcgv_vec_temp(dest)->base_type;
+
+    /*
+     * For MO_64 constants that can't be represented in tcg_target_long,
+     * we must use INDEX_op_dup2_vec.
+     */
+    if (TCG_TARGET_REG_BITS == 32) {
+        val = dup_const(vece, val);
+        if (val != deposit64(val, 32, 32, val) &&
+            val != (uint64_t)(int32_t)val) {
+            uint32_t vl = extract64(val, 0, 32);
+            uint32_t vh = extract64(val, 32, 32);
+            TCGArg al = tcgv_i32_arg(tcg_constant_i32(vl));
+            TCGArg ah = tcgv_i32_arg(tcg_constant_i32(vh));
+            TCGArg di = tcgv_vec_arg(dest);
+
+            vec_gen_3(INDEX_op_dup2_vec, type, MO_64, di, al, ah);
+            return;
+        }
     }
+
+    tcg_gen_mov_vec(dest, tcg_constant_vec(type, vece, val));
 }
 
-void tcg_gen_dup32i_vec(TCGv_vec r, uint32_t a)
+void tcg_gen_dup64i_vec(TCGv_vec dest, uint64_t val)
 {
-    do_dupi_vec(r, MO_REG, dup_const(MO_32, a));
+    tcg_gen_dupi_vec(MO_64, dest, val);
 }
 
-void tcg_gen_dup16i_vec(TCGv_vec r, uint32_t a)
+void tcg_gen_dup32i_vec(TCGv_vec dest, uint32_t val)
 {
-    do_dupi_vec(r, MO_REG, dup_const(MO_16, a));
+    tcg_gen_dupi_vec(MO_32, dest, val);
 }
 
-void tcg_gen_dup8i_vec(TCGv_vec r, uint32_t a)
+void tcg_gen_dup16i_vec(TCGv_vec dest, uint32_t val)
 {
-    do_dupi_vec(r, MO_REG, dup_const(MO_8, a));
+    tcg_gen_dupi_vec(MO_16, dest, val);
 }
 
-void tcg_gen_dupi_vec(unsigned vece, TCGv_vec r, uint64_t a)
+void tcg_gen_dup8i_vec(TCGv_vec dest, uint32_t val)
 {
-    do_dupi_vec(r, MO_REG, dup_const(vece, a));
+    tcg_gen_dupi_vec(MO_8, dest, val);
 }
 
 void tcg_gen_dup_i64_vec(unsigned vece, TCGv_vec r, TCGv_i64 a)
@@ -502,8 +507,8 @@ void tcg_gen_abs_vec(unsigned vece, TCGv_vec r, TCGv_vec a)
             if (tcg_can_emit_vec_op(INDEX_op_sari_vec, type, vece) > 0) {
                 tcg_gen_sari_vec(vece, t, a, (8 << vece) - 1);
             } else {
-                do_dupi_vec(t, MO_REG, 0);
-                tcg_gen_cmp_vec(TCG_COND_LT, vece, t, a, t);
+                tcg_gen_cmp_vec(TCG_COND_LT, vece, t, a,
+                                tcg_constant_vec(type, vece, 0));
             }
             tcg_gen_xor_vec(vece, r, a, t);
             tcg_gen_sub_vec(vece, r, r, t);
-- 
2.20.1



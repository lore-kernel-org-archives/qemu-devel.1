Return-Path: <SRS0=PlQC=BZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D86C433E1
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 15:13:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D270523101
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 15:13:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gG284Da9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D270523101
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6xsK-0004Kw-1R
	for qemu-devel@archiver.kernel.org; Sat, 15 Aug 2020 11:13:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52922)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k6xo2-0006xh-4a
 for qemu-devel@nongnu.org; Sat, 15 Aug 2020 11:09:14 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:34964)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k6xnz-00084J-QY
 for qemu-devel@nongnu.org; Sat, 15 Aug 2020 11:09:13 -0400
Received: by mail-oi1-x241.google.com with SMTP id k4so10835933oik.2
 for <qemu-devel@nongnu.org>; Sat, 15 Aug 2020 08:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=x4ut4WZwpjGYcQOKgnzpo5v3a5LcV3S0PAGa2UNZBIM=;
 b=gG284Da9hxLVdfCl2ISzxrSvmsk5ZP0k51X88l8lXXLnObQbs90FdTMvR9cQyxUt5a
 bz1NGhhyfB77FrbgaCevsPfna37TtKCBV2X7h3/Q0ll9SfTIX7Kepk96K6dBwnCo2lyI
 gfJSdrLrSiquGZdQkthb39w1NzYsSA9l92LzgdKz9XDth/Xx005Dobe2lLDb9IdqyLBZ
 x/WK1BSeSrDzGApKWz9oq2Q8quDU4mLVbiYolNNPlvfa8AphAcN/6UZsBzzaJcKZG/K+
 axyq8+CB9YEpw6i2NVEHDJuDAJpdIAZMNCIsJKv3dIn35wcrMhnY1pz5WvM51Vwdw4+i
 ACBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=x4ut4WZwpjGYcQOKgnzpo5v3a5LcV3S0PAGa2UNZBIM=;
 b=DcbvLZNiqcTwHEJ5OweuB/QJsRyzwSxZIJq0BX8C+MZsWLnFe2EWqFzO8JJjGitKuJ
 xxY2i2rnAJA/8d797LqhFkqJii8r6wqmw7BV4EKw1qQSjYJ+8uz06i3v7xZgFazjEouX
 mafucE/2KCSYdtJ7yDZ7PdX7rrKdig1lPC6Fg0fRe+yraZtMfQgJXLVbcKBtr/sQKaHB
 gHTt/UT15T/4JGuRl0hO85cSyt1pBfhwxDqICdNgZjtfjigFvNGu8Ku3ThoYJHqaEoxP
 majyftnzci0VmQfLfJaQA5hjEyLbGHapbX6lR7EaZOy1h+V9nZHKI2DjFS24YTVyTpXv
 Umsg==
X-Gm-Message-State: AOAM5320HHlYgkYNy4mNTIhVDJoQ90YI5541TjRWRNjQpOk1mXLh8iC2
 S8hVFqFknOxXkUSh5ox4wtg7iXS4czMpXQ==
X-Google-Smtp-Source: ABdhPJyiwS3I+JtLT7keKFwqQDP+rbA+2OWyTRWzX2sTneA+UJSMG/le4reA+ciRNXCh6kTFTHidfg==
X-Received: by 2002:a17:90a:a101:: with SMTP id
 s1mr3993200pjp.205.1597455116091; 
 Fri, 14 Aug 2020 18:31:56 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id y196sm10625528pfc.202.2020.08.14.18.31.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2020 18:31:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 06/20] target/arm: Clean up 4-operand predicate expansion
Date: Fri, 14 Aug 2020 18:31:31 -0700
Message-Id: <20200815013145.539409-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200815013145.539409-1-richard.henderson@linaro.org>
References: <20200815013145.539409-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::241;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x241.google.com
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Move the check for !S into do_pppp_flags, which allows to merge in
do_vecop4_p.  Split out gen_gvec_fn_ppp without sve_access_check,
to mirror gen_gvec_fn_zzz.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-sve.c | 111 ++++++++++++++-----------------------
 1 file changed, 43 insertions(+), 68 deletions(-)

diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index d310709de3..13a0194d59 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -179,31 +179,13 @@ static void do_dupi_z(DisasContext *s, int rd, uint64_t word)
 }
 
 /* Invoke a vector expander on three Pregs.  */
-static bool do_vector3_p(DisasContext *s, GVecGen3Fn *gvec_fn,
-                         int esz, int rd, int rn, int rm)
+static void gen_gvec_fn_ppp(DisasContext *s, GVecGen3Fn *gvec_fn,
+                            int rd, int rn, int rm)
 {
-    if (sve_access_check(s)) {
-        unsigned psz = pred_gvec_reg_size(s);
-        gvec_fn(esz, pred_full_reg_offset(s, rd),
-                pred_full_reg_offset(s, rn),
-                pred_full_reg_offset(s, rm), psz, psz);
-    }
-    return true;
-}
-
-/* Invoke a vector operation on four Pregs.  */
-static bool do_vecop4_p(DisasContext *s, const GVecGen4 *gvec_op,
-                        int rd, int rn, int rm, int rg)
-{
-    if (sve_access_check(s)) {
-        unsigned psz = pred_gvec_reg_size(s);
-        tcg_gen_gvec_4(pred_full_reg_offset(s, rd),
-                       pred_full_reg_offset(s, rn),
-                       pred_full_reg_offset(s, rm),
-                       pred_full_reg_offset(s, rg),
-                       psz, psz, gvec_op);
-    }
-    return true;
+    unsigned psz = pred_gvec_reg_size(s);
+    gvec_fn(MO_64, pred_full_reg_offset(s, rd),
+            pred_full_reg_offset(s, rn),
+            pred_full_reg_offset(s, rm), psz, psz);
 }
 
 /* Invoke a vector move on two Pregs.  */
@@ -1067,6 +1049,11 @@ static bool do_pppp_flags(DisasContext *s, arg_rprr_s *a,
     int mofs = pred_full_reg_offset(s, a->rm);
     int gofs = pred_full_reg_offset(s, a->pg);
 
+    if (!a->s) {
+        tcg_gen_gvec_4(dofs, nofs, mofs, gofs, psz, psz, gvec_op);
+        return true;
+    }
+
     if (psz == 8) {
         /* Do the operation and the flags generation in temps.  */
         TCGv_i64 pd = tcg_temp_new_i64();
@@ -1126,19 +1113,24 @@ static bool trans_AND_pppp(DisasContext *s, arg_rprr_s *a)
         .fno = gen_helper_sve_and_pppp,
         .prefer_i64 = TCG_TARGET_REG_BITS == 64,
     };
-    if (a->s) {
-        return do_pppp_flags(s, a, &op);
-    } else if (a->rn == a->rm) {
-        if (a->pg == a->rn) {
-            return do_mov_p(s, a->rd, a->rn);
-        } else {
-            return do_vector3_p(s, tcg_gen_gvec_and, 0, a->rd, a->rn, a->pg);
+
+    if (!a->s) {
+        if (!sve_access_check(s)) {
+            return true;
+        }
+        if (a->rn == a->rm) {
+            if (a->pg == a->rn) {
+                do_mov_p(s, a->rd, a->rn);
+            } else {
+                gen_gvec_fn_ppp(s, tcg_gen_gvec_and, a->rd, a->rn, a->pg);
+            }
+            return true;
+        } else if (a->pg == a->rn || a->pg == a->rm) {
+            gen_gvec_fn_ppp(s, tcg_gen_gvec_and, a->rd, a->rn, a->rm);
+            return true;
         }
-    } else if (a->pg == a->rn || a->pg == a->rm) {
-        return do_vector3_p(s, tcg_gen_gvec_and, 0, a->rd, a->rn, a->rm);
-    } else {
-        return do_vecop4_p(s, &op, a->rd, a->rn, a->rm, a->pg);
     }
+    return do_pppp_flags(s, a, &op);
 }
 
 static void gen_bic_pg_i64(TCGv_i64 pd, TCGv_i64 pn, TCGv_i64 pm, TCGv_i64 pg)
@@ -1162,13 +1154,14 @@ static bool trans_BIC_pppp(DisasContext *s, arg_rprr_s *a)
         .fno = gen_helper_sve_bic_pppp,
         .prefer_i64 = TCG_TARGET_REG_BITS == 64,
     };
-    if (a->s) {
-        return do_pppp_flags(s, a, &op);
-    } else if (a->pg == a->rn) {
-        return do_vector3_p(s, tcg_gen_gvec_andc, 0, a->rd, a->rn, a->rm);
-    } else {
-        return do_vecop4_p(s, &op, a->rd, a->rn, a->rm, a->pg);
+
+    if (!a->s && a->pg == a->rn) {
+        if (sve_access_check(s)) {
+            gen_gvec_fn_ppp(s, tcg_gen_gvec_andc, a->rd, a->rn, a->rm);
+        }
+        return true;
     }
+    return do_pppp_flags(s, a, &op);
 }
 
 static void gen_eor_pg_i64(TCGv_i64 pd, TCGv_i64 pn, TCGv_i64 pm, TCGv_i64 pg)
@@ -1192,11 +1185,7 @@ static bool trans_EOR_pppp(DisasContext *s, arg_rprr_s *a)
         .fno = gen_helper_sve_eor_pppp,
         .prefer_i64 = TCG_TARGET_REG_BITS == 64,
     };
-    if (a->s) {
-        return do_pppp_flags(s, a, &op);
-    } else {
-        return do_vecop4_p(s, &op, a->rd, a->rn, a->rm, a->pg);
-    }
+    return do_pppp_flags(s, a, &op);
 }
 
 static void gen_sel_pg_i64(TCGv_i64 pd, TCGv_i64 pn, TCGv_i64 pm, TCGv_i64 pg)
@@ -1222,11 +1211,11 @@ static bool trans_SEL_pppp(DisasContext *s, arg_rprr_s *a)
         .fno = gen_helper_sve_sel_pppp,
         .prefer_i64 = TCG_TARGET_REG_BITS == 64,
     };
+
     if (a->s) {
         return false;
-    } else {
-        return do_vecop4_p(s, &op, a->rd, a->rn, a->rm, a->pg);
     }
+    return do_pppp_flags(s, a, &op);
 }
 
 static void gen_orr_pg_i64(TCGv_i64 pd, TCGv_i64 pn, TCGv_i64 pm, TCGv_i64 pg)
@@ -1250,13 +1239,11 @@ static bool trans_ORR_pppp(DisasContext *s, arg_rprr_s *a)
         .fno = gen_helper_sve_orr_pppp,
         .prefer_i64 = TCG_TARGET_REG_BITS == 64,
     };
-    if (a->s) {
-        return do_pppp_flags(s, a, &op);
-    } else if (a->pg == a->rn && a->rn == a->rm) {
+
+    if (!a->s && a->pg == a->rn && a->rn == a->rm) {
         return do_mov_p(s, a->rd, a->rn);
-    } else {
-        return do_vecop4_p(s, &op, a->rd, a->rn, a->rm, a->pg);
     }
+    return do_pppp_flags(s, a, &op);
 }
 
 static void gen_orn_pg_i64(TCGv_i64 pd, TCGv_i64 pn, TCGv_i64 pm, TCGv_i64 pg)
@@ -1280,11 +1267,7 @@ static bool trans_ORN_pppp(DisasContext *s, arg_rprr_s *a)
         .fno = gen_helper_sve_orn_pppp,
         .prefer_i64 = TCG_TARGET_REG_BITS == 64,
     };
-    if (a->s) {
-        return do_pppp_flags(s, a, &op);
-    } else {
-        return do_vecop4_p(s, &op, a->rd, a->rn, a->rm, a->pg);
-    }
+    return do_pppp_flags(s, a, &op);
 }
 
 static void gen_nor_pg_i64(TCGv_i64 pd, TCGv_i64 pn, TCGv_i64 pm, TCGv_i64 pg)
@@ -1308,11 +1291,7 @@ static bool trans_NOR_pppp(DisasContext *s, arg_rprr_s *a)
         .fno = gen_helper_sve_nor_pppp,
         .prefer_i64 = TCG_TARGET_REG_BITS == 64,
     };
-    if (a->s) {
-        return do_pppp_flags(s, a, &op);
-    } else {
-        return do_vecop4_p(s, &op, a->rd, a->rn, a->rm, a->pg);
-    }
+    return do_pppp_flags(s, a, &op);
 }
 
 static void gen_nand_pg_i64(TCGv_i64 pd, TCGv_i64 pn, TCGv_i64 pm, TCGv_i64 pg)
@@ -1336,11 +1315,7 @@ static bool trans_NAND_pppp(DisasContext *s, arg_rprr_s *a)
         .fno = gen_helper_sve_nand_pppp,
         .prefer_i64 = TCG_TARGET_REG_BITS == 64,
     };
-    if (a->s) {
-        return do_pppp_flags(s, a, &op);
-    } else {
-        return do_vecop4_p(s, &op, a->rd, a->rn, a->rm, a->pg);
-    }
+    return do_pppp_flags(s, a, &op);
 }
 
 /*
-- 
2.25.1



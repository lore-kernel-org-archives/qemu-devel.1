Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF8D5C433E7
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 09:36:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD6F42075B
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 09:36:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="esPBCtH8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD6F42075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBaoO-0003vk-W7
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 05:36:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46124)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBacp-0004yk-JW
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 05:24:47 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:40904)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBacn-0004Lp-Lj
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 05:24:47 -0400
Received: by mail-wr1-x442.google.com with SMTP id b18so626564wrs.7
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 02:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=R9aJ6ZzsAt8r/J9YsHCHCH48yC3gV9MTgkevSI5WBYE=;
 b=esPBCtH8k6zN2+mjrIlu+7aSnkyGB53KouSMFOYPQGycSFIYaZUSwMuTVCgA3Yaz3b
 M3iieF2o/qki/KWEjObITwfFcr6hIVwyRjSFGtIYLmfqntKF7VpAM9RK2fREz5FJOm/g
 ZSa/GIWQXUonHBZnPGpvIgm0po5C/S7ltszBX9dNOO5q6PzdE5auFsPS/ekyN9EixpSJ
 mMy+9Yjdj8khfgINzUF/KDdWub+h0s9VTcG4bTS9ymrxQahf4mgqzC1k976FwbQZ96c8
 XBxowEdFzR7k10S7R8aDcvWfw876/z4JxcHBP+/DN2QLEvOFgSU6oApcyaHp7tWSfxWp
 yM0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=R9aJ6ZzsAt8r/J9YsHCHCH48yC3gV9MTgkevSI5WBYE=;
 b=U14zS9VkecApSi4smwJfZsH5R600L1dd1no9Bu9n9jAWcIWRzCBfI5OajKPLuYu08J
 TZ4f39eHn+kYv/IvkCGmGpBRvE42LdyIb/6KIflH9csnSC4NKtYQj7IDWW2vqmD0TRWn
 a8JkoMpKGmf1PkhIRFdO13Np0G/GIV59dy24y1FN6ea+iwI4acLnfylok24GEhG8Q90+
 UBZRXDVRPX8GOUf8rLOVF37gR6jtaXu3rSJBMqFev+g0c+3kZcDK17wklTBBI7oQrpJH
 4TI0RwGND0ys29EnNovBju0JW1qZQrwgTlEBJbO/GnXdMyYuRuUwkJvDIH5Fdl0ZJXwn
 aoAg==
X-Gm-Message-State: AOAM530EGmCisymivRnrhQO/Fz+O2us4s4ENzijhkWfiPPCqH3vYYfxU
 mue0nzVBQ6ZhX+jOUmiAJjs5daRKrJ8nH/4N
X-Google-Smtp-Source: ABdhPJygwu4rUeH+VLpGoELJq/Ad2/OO4utv/AXAr6/zTsaqjrV5LAS4d1QLiErN7r+LAR887Ly/+g==
X-Received: by 2002:a5d:5383:: with SMTP id d3mr661370wrv.42.1598606684002;
 Fri, 28 Aug 2020 02:24:44 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id t13sm912304wru.65.2020.08.28.02.24.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 02:24:42 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 24/35] target/arm: Clean up 4-operand predicate expansion
Date: Fri, 28 Aug 2020 10:24:02 +0100
Message-Id: <20200828092413.22206-25-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200828092413.22206-1-peter.maydell@linaro.org>
References: <20200828092413.22206-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x442.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

Move the check for !S into do_pppp_flags, which allows to merge in
do_vecop4_p.  Split out gen_gvec_fn_ppp without sve_access_check,
to mirror gen_gvec_fn_zzz.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20200815013145.539409-7-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-sve.c | 111 ++++++++++++++-----------------------
 1 file changed, 43 insertions(+), 68 deletions(-)

diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 6dac70359b6..5dfc129e73b 100644
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
2.20.1



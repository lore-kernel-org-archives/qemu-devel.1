Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89347C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 09:34:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51C722075B
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 09:34:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LnMhMzK0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51C722075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBalj-0005ZP-Hb
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 05:33:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46050)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBack-0004l6-P9
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 05:24:42 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:54464)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBaci-0004L9-TC
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 05:24:42 -0400
Received: by mail-wm1-x342.google.com with SMTP id s13so288929wmh.4
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 02:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=XWqrP7P6ifh7UylLR9sH8s6fDvvfs3o2/XqIvzFw09A=;
 b=LnMhMzK014flqiNvxdXgTN92rCw3Qteltc1jg06XnOughPFctccK5gwSYuukB2/r5C
 ANNND+K7oqycjriVjcj/IQSkqloqI2XM3QEMLi2PUgtW7mPbuVWc/+5aZSPSexNW2IrN
 qzIvhfdUGy+mHYC2PtFUf/3nVPnKVp6JATFJebVuXmTBeHhyFB+AVTqYoFR58vT5A8M6
 WAjRZAflpIAj41541Y64eear4+ELCk9WfyITCQKTmzaM7pztKK/qcXdGZyHXhuDkwm+p
 WBGIt3JZy7hxYkxZDO8XwNsQFeJWK5iIZTn+T26G8Z608sNu9C4hrln5vdUQwSi42wKn
 visA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XWqrP7P6ifh7UylLR9sH8s6fDvvfs3o2/XqIvzFw09A=;
 b=od8rIx/gtc5PtFSiEV8X/KPrZm6RafURHvoUgZ7Mni8FCBRR3HVOSubwHCkbC8mjw9
 HGiXxao4jGko18t3kraqFxxgQWwkut0XL7kpmapSY7AhYomzhH38xEoVgZ/qvbv4F8kg
 A7knIsyMnMWdaKnOLiwGa3qUc5EziDofFxkGoX7LnBfzy46ldSzQLTlABuZdwzaGk4cL
 0E4HcQ8vJ87yD0qyY8hAQeb9YQfS2pKi5PTkA07aYRAziU0AwmMe+mhf0oUBUN3LH6Zo
 l6qZODZ5orMWN/YjngG1teQiWfOaV7VLeMY9DvNb25INQcnQHOrsHPJlV/saK325IGyn
 kOkg==
X-Gm-Message-State: AOAM532SkicOZ4tVD1Z4mclUkGR2Ky9hCBbwUc+WO42+h4rwaHnH6eCS
 8lqQmOq/BeYblXyuCwe8AgMVEBmyWt+IRgnZ
X-Google-Smtp-Source: ABdhPJyDCLJKag3uHykBzeugKpt+gID/dCF2aj0HoshQWCyCf6KmL7ITFskIpPUg3PdNSI58VOSUpw==
X-Received: by 2002:a7b:c1c3:: with SMTP id a3mr788476wmj.68.1598606679151;
 Fri, 28 Aug 2020 02:24:39 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id t13sm912304wru.65.2020.08.28.02.24.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 02:24:38 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 21/35] target/arm: Split out gen_gvec_fn_zzz, do_zzz_fn
Date: Fri, 28 Aug 2020 10:23:59 +0100
Message-Id: <20200828092413.22206-22-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200828092413.22206-1-peter.maydell@linaro.org>
References: <20200828092413.22206-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x342.google.com
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

Model gen_gvec_fn_zzz on gen_gvec_fn3 in translate-a64.c, but
indicating which kind of register and in which order.

Model do_zzz_fn on the other do_foo functions that take an
argument set and verify sve enabled.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20200815013145.539409-4-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-sve.c | 43 +++++++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 19 deletions(-)

diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index f1803eb72bf..9a3d060c052 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -153,16 +153,13 @@ static void gen_gvec_fn_zz(DisasContext *s, GVecGen2Fn *gvec_fn,
 }
 
 /* Invoke a vector expander on three Zregs.  */
-static bool do_vector3_z(DisasContext *s, GVecGen3Fn *gvec_fn,
-                         int esz, int rd, int rn, int rm)
+static void gen_gvec_fn_zzz(DisasContext *s, GVecGen3Fn *gvec_fn,
+                            int esz, int rd, int rn, int rm)
 {
-    if (sve_access_check(s)) {
-        unsigned vsz = vec_full_reg_size(s);
-        gvec_fn(esz, vec_full_reg_offset(s, rd),
-                vec_full_reg_offset(s, rn),
-                vec_full_reg_offset(s, rm), vsz, vsz);
-    }
-    return true;
+    unsigned vsz = vec_full_reg_size(s);
+    gvec_fn(esz, vec_full_reg_offset(s, rd),
+            vec_full_reg_offset(s, rn),
+            vec_full_reg_offset(s, rm), vsz, vsz);
 }
 
 /* Invoke a vector move on two Zregs.  */
@@ -274,24 +271,32 @@ const uint64_t pred_esz_masks[4] = {
  *** SVE Logical - Unpredicated Group
  */
 
+static bool do_zzz_fn(DisasContext *s, arg_rrr_esz *a, GVecGen3Fn *gvec_fn)
+{
+    if (sve_access_check(s)) {
+        gen_gvec_fn_zzz(s, gvec_fn, a->esz, a->rd, a->rn, a->rm);
+    }
+    return true;
+}
+
 static bool trans_AND_zzz(DisasContext *s, arg_rrr_esz *a)
 {
-    return do_vector3_z(s, tcg_gen_gvec_and, 0, a->rd, a->rn, a->rm);
+    return do_zzz_fn(s, a, tcg_gen_gvec_and);
 }
 
 static bool trans_ORR_zzz(DisasContext *s, arg_rrr_esz *a)
 {
-    return do_vector3_z(s, tcg_gen_gvec_or, 0, a->rd, a->rn, a->rm);
+    return do_zzz_fn(s, a, tcg_gen_gvec_or);
 }
 
 static bool trans_EOR_zzz(DisasContext *s, arg_rrr_esz *a)
 {
-    return do_vector3_z(s, tcg_gen_gvec_xor, 0, a->rd, a->rn, a->rm);
+    return do_zzz_fn(s, a, tcg_gen_gvec_xor);
 }
 
 static bool trans_BIC_zzz(DisasContext *s, arg_rrr_esz *a)
 {
-    return do_vector3_z(s, tcg_gen_gvec_andc, 0, a->rd, a->rn, a->rm);
+    return do_zzz_fn(s, a, tcg_gen_gvec_andc);
 }
 
 /*
@@ -300,32 +305,32 @@ static bool trans_BIC_zzz(DisasContext *s, arg_rrr_esz *a)
 
 static bool trans_ADD_zzz(DisasContext *s, arg_rrr_esz *a)
 {
-    return do_vector3_z(s, tcg_gen_gvec_add, a->esz, a->rd, a->rn, a->rm);
+    return do_zzz_fn(s, a, tcg_gen_gvec_add);
 }
 
 static bool trans_SUB_zzz(DisasContext *s, arg_rrr_esz *a)
 {
-    return do_vector3_z(s, tcg_gen_gvec_sub, a->esz, a->rd, a->rn, a->rm);
+    return do_zzz_fn(s, a, tcg_gen_gvec_sub);
 }
 
 static bool trans_SQADD_zzz(DisasContext *s, arg_rrr_esz *a)
 {
-    return do_vector3_z(s, tcg_gen_gvec_ssadd, a->esz, a->rd, a->rn, a->rm);
+    return do_zzz_fn(s, a, tcg_gen_gvec_ssadd);
 }
 
 static bool trans_SQSUB_zzz(DisasContext *s, arg_rrr_esz *a)
 {
-    return do_vector3_z(s, tcg_gen_gvec_sssub, a->esz, a->rd, a->rn, a->rm);
+    return do_zzz_fn(s, a, tcg_gen_gvec_sssub);
 }
 
 static bool trans_UQADD_zzz(DisasContext *s, arg_rrr_esz *a)
 {
-    return do_vector3_z(s, tcg_gen_gvec_usadd, a->esz, a->rd, a->rn, a->rm);
+    return do_zzz_fn(s, a, tcg_gen_gvec_usadd);
 }
 
 static bool trans_UQSUB_zzz(DisasContext *s, arg_rrr_esz *a)
 {
-    return do_vector3_z(s, tcg_gen_gvec_ussub, a->esz, a->rd, a->rn, a->rm);
+    return do_zzz_fn(s, a, tcg_gen_gvec_ussub);
 }
 
 /*
-- 
2.20.1



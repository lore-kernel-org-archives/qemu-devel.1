Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF2F8C433E7
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 09:39:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACEF0208D5
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 09:39:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XtguVoWU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACEF0208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBaqs-0007ue-07
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 05:39:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46198)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBacv-0005GK-RB
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 05:24:53 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:39640)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBact-0004NU-Vk
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 05:24:53 -0400
Received: by mail-wr1-x441.google.com with SMTP id a5so628889wrm.6
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 02:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=ARAQy4tCdSBdjclnWDkwZ2HKWjzfpU6AW1h+l0b73s0=;
 b=XtguVoWUd0UZDwHexS0Sh3l9e1nYrCzWAFKA3G00Tly5RpAYeTwatbtnljzOnd/sDL
 vJ7rlkAbk6P/o03TIMw653a0fefl/VBN1MQbsIaNxsDKXB9WQq1dFz3clqRd8Nq1uYrL
 9Xm4N8ulRvhs3kV1e0GtUvFTVOIuTIlmnnpuY1wV6fBeQCvaDeuRGW2G5jSCsm9MGl/H
 Ji/CAz+xzbGH26dIHa3QpL3HHGRe4SaeKBD8v2OR30IVWgm3EPmt89Z0MHLWf3rsUSop
 x6L33UVL6qfnkwacEI6v4Os+k17/G9B06fHqyfBZMj23S8SgVsGGfPpacgpqQCQkxKjO
 KIsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ARAQy4tCdSBdjclnWDkwZ2HKWjzfpU6AW1h+l0b73s0=;
 b=TErtZOTmy5SHUN2IMXmaivr9nhEYSzllnDYFoYR0rik9gOg+u8ZssZOKjFUIT591az
 VtBpJhZZjOLHWnTXnYthCw2tNBGwNbRfzVi9QjiLJIQENp63cP3l/dJ6JZ+JrVgr9uxk
 SyZs3uaLlA4y7r9ZHccpbRq1J78i9lzkczvlTJ10SL16UQ4/TMlG2fmLXrGAoujDFvI1
 8PsoS09i6wYYT08MisgsiEXIx8QHwsqEw1xPRqN4gruElniXMZc4+BRlarNZK+6rV3FY
 3NItwyVf4nNMAOYdTAmQ/nuEJnh78a762wjZYIToYThrwlYf/eBu4zNTP46uTFivt9XU
 6RNQ==
X-Gm-Message-State: AOAM530oX7n+DkV3AB+GTr/UWL7bIJcZFUx/muNYhn2Jk35szjoXsWsM
 sjRxsmdykKQTGs2JMjVg+zP4zJSecQbvsKCO
X-Google-Smtp-Source: ABdhPJyu2IVjxpvKj1S92s2DR4m9jWslmGeUEekfIoBzCuDx5lvyLlpHlAw+qGLfAgScn50Y5VFHtA==
X-Received: by 2002:a5d:6b88:: with SMTP id n8mr643309wrx.244.1598606690389;
 Fri, 28 Aug 2020 02:24:50 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id t13sm912304wru.65.2020.08.28.02.24.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 02:24:49 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 29/35] target/arm: Split out gen_gvec_ool_zzz
Date: Fri, 28 Aug 2020 10:24:07 +0100
Message-Id: <20200828092413.22206-30-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200828092413.22206-1-peter.maydell@linaro.org>
References: <20200828092413.22206-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x441.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20200815013145.539409-12-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-sve.c | 53 +++++++++++++-------------------------
 1 file changed, 18 insertions(+), 35 deletions(-)

diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 6d10e2ac2c7..0d5bcf6c1ed 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -142,6 +142,17 @@ static int pred_gvec_reg_size(DisasContext *s)
     return size_for_gvec(pred_full_reg_size(s));
 }
 
+/* Invoke an out-of-line helper on 3 Zregs. */
+static void gen_gvec_ool_zzz(DisasContext *s, gen_helper_gvec_3 *fn,
+                             int rd, int rn, int rm, int data)
+{
+    unsigned vsz = vec_full_reg_size(s);
+    tcg_gen_gvec_3_ool(vec_full_reg_offset(s, rd),
+                       vec_full_reg_offset(s, rn),
+                       vec_full_reg_offset(s, rm),
+                       vsz, vsz, data, fn);
+}
+
 /* Invoke an out-of-line helper on 2 Zregs and a predicate. */
 static void gen_gvec_ool_zzp(DisasContext *s, gen_helper_gvec_3 *fn,
                              int rd, int rn, int pg, int data)
@@ -769,11 +780,7 @@ static bool do_zzw_ool(DisasContext *s, arg_rrr_esz *a, gen_helper_gvec_3 *fn)
         return false;
     }
     if (sve_access_check(s)) {
-        unsigned vsz = vec_full_reg_size(s);
-        tcg_gen_gvec_3_ool(vec_full_reg_offset(s, a->rd),
-                           vec_full_reg_offset(s, a->rn),
-                           vec_full_reg_offset(s, a->rm),
-                           vsz, vsz, 0, fn);
+        gen_gvec_ool_zzz(s, fn, a->rd, a->rn, a->rm, 0);
     }
     return true;
 }
@@ -947,11 +954,7 @@ static bool trans_RDVL(DisasContext *s, arg_RDVL *a)
 static bool do_adr(DisasContext *s, arg_rrri *a, gen_helper_gvec_3 *fn)
 {
     if (sve_access_check(s)) {
-        unsigned vsz = vec_full_reg_size(s);
-        tcg_gen_gvec_3_ool(vec_full_reg_offset(s, a->rd),
-                           vec_full_reg_offset(s, a->rn),
-                           vec_full_reg_offset(s, a->rm),
-                           vsz, vsz, a->imm, fn);
+        gen_gvec_ool_zzz(s, fn, a->rd, a->rn, a->rm, a->imm);
     }
     return true;
 }
@@ -1012,11 +1015,7 @@ static bool trans_FTSSEL(DisasContext *s, arg_rrr_esz *a)
         return false;
     }
     if (sve_access_check(s)) {
-        unsigned vsz = vec_full_reg_size(s);
-        tcg_gen_gvec_3_ool(vec_full_reg_offset(s, a->rd),
-                           vec_full_reg_offset(s, a->rn),
-                           vec_full_reg_offset(s, a->rm),
-                           vsz, vsz, 0, fns[a->esz]);
+        gen_gvec_ool_zzz(s, fns[a->esz], a->rd, a->rn, a->rm, 0);
     }
     return true;
 }
@@ -2067,11 +2066,7 @@ static bool trans_TBL(DisasContext *s, arg_rrr_esz *a)
     };
 
     if (sve_access_check(s)) {
-        unsigned vsz = vec_full_reg_size(s);
-        tcg_gen_gvec_3_ool(vec_full_reg_offset(s, a->rd),
-                           vec_full_reg_offset(s, a->rn),
-                           vec_full_reg_offset(s, a->rm),
-                           vsz, vsz, 0, fns[a->esz]);
+        gen_gvec_ool_zzz(s, fns[a->esz], a->rd, a->rn, a->rm, 0);
     }
     return true;
 }
@@ -2244,11 +2239,7 @@ static bool do_zzz_data_ool(DisasContext *s, arg_rrr_esz *a, int data,
                             gen_helper_gvec_3 *fn)
 {
     if (sve_access_check(s)) {
-        unsigned vsz = vec_full_reg_size(s);
-        tcg_gen_gvec_3_ool(vec_full_reg_offset(s, a->rd),
-                           vec_full_reg_offset(s, a->rn),
-                           vec_full_reg_offset(s, a->rm),
-                           vsz, vsz, data, fn);
+        gen_gvec_ool_zzz(s, fn, a->rd, a->rn, a->rm, data);
     }
     return true;
 }
@@ -3373,11 +3364,7 @@ static bool trans_DOT_zzz(DisasContext *s, arg_DOT_zzz *a)
     };
 
     if (sve_access_check(s)) {
-        unsigned vsz = vec_full_reg_size(s);
-        tcg_gen_gvec_3_ool(vec_full_reg_offset(s, a->rd),
-                           vec_full_reg_offset(s, a->rn),
-                           vec_full_reg_offset(s, a->rm),
-                           vsz, vsz, 0, fns[a->u][a->sz]);
+        gen_gvec_ool_zzz(s, fns[a->u][a->sz], a->rd, a->rn, a->rm, 0);
     }
     return true;
 }
@@ -3390,11 +3377,7 @@ static bool trans_DOT_zzx(DisasContext *s, arg_DOT_zzx *a)
     };
 
     if (sve_access_check(s)) {
-        unsigned vsz = vec_full_reg_size(s);
-        tcg_gen_gvec_3_ool(vec_full_reg_offset(s, a->rd),
-                           vec_full_reg_offset(s, a->rn),
-                           vec_full_reg_offset(s, a->rm),
-                           vsz, vsz, a->index, fns[a->u][a->sz]);
+        gen_gvec_ool_zzz(s, fns[a->u][a->sz], a->rd, a->rn, a->rm, a->index);
     }
     return true;
 }
-- 
2.20.1



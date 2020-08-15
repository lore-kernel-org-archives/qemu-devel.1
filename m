Return-Path: <SRS0=PlQC=BZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D50B2C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 17:07:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95DC023B30
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 17:07:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t2I2BFiV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95DC023B30
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6zeG-0003rS-Po
	for qemu-devel@archiver.kernel.org; Sat, 15 Aug 2020 13:07:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42606)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k6zdT-0002m4-Cb
 for qemu-devel@nongnu.org; Sat, 15 Aug 2020 13:06:27 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:35375)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k6zdR-0001Oe-Ng
 for qemu-devel@nongnu.org; Sat, 15 Aug 2020 13:06:27 -0400
Received: by mail-oi1-x243.google.com with SMTP id k4so11055205oik.2
 for <qemu-devel@nongnu.org>; Sat, 15 Aug 2020 10:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=AQeYh8suqz3vP9Br20s8Z+PHQd0HdWmpnfFfXQ0gVk0=;
 b=t2I2BFiVfxZRRTbfGq6Pp8+KC7+vdcTG7s5uPvYm5KTwr7LPY8+qxlUceEO7cRkVii
 gtqwVWEtHqLa3ySJvJi/ZDBT1bvvU75Wqt4BrncS1AMw0TthNkV9lsHDNtHhT+jBh4vu
 glijcRgpMjAQ4oqO1S4Hjh5JOIxsyKLTp4mtLSWJazvHXxWOiBghvAbidl4Pimw2qryi
 ZV9TQPS84gKMtVk6xKoIedIUohdMWyk332yW7YHeOuVgs5cqnXu5KLJW6Vh80HyMTayv
 7GdN0GGziLd8Gd3nEeoOXZY4ZfJdIhWf5I+4pYe7w3cL6mkjlJ50qAudPY8zrRF7pPTv
 x3Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=AQeYh8suqz3vP9Br20s8Z+PHQd0HdWmpnfFfXQ0gVk0=;
 b=a+kxizJjRLXkdaB+UZOQ6yNCGSbuNFJoNPaT2iqcYPsc2PpP6GfmQIyME3D8IpQasN
 oJ/z2zNcQU+tWY7oRuKyZvpdthx9RBC06nywLgFrvTzMTZN5wUxveMR0eqwMjwyfIxlN
 bqT5aC9KdtbtoTPDEs9AoaSKAwu+6mKOjosuWqRpW4+5l11ngxAGadf55dNv37unjZdQ
 RpwJO6v6TSwX/SOxYtYPYSCETENasyjxpNZPr/D0niz4rf8pyZhh+AEg3hWYVEXqBFU7
 Qm6VjwxsFM1FDDb9qePzGWe9az8gJP+lm7K97YyQJFuViwfOPDQNyqI+mhyvm1KYtUhj
 ahHw==
X-Gm-Message-State: AOAM531yHXShWL3r3bpz+sVLp++yG5tV3L1z16RGEfkutT/vE/Lt7KgW
 NbklA+0w2+MHaRBrQm9LSsZ/qLyrKgnLGA==
X-Google-Smtp-Source: ABdhPJyXSe+HVnKwHo1cJeOw1w3YJUvvbvNIdA+j0ZhxJOi7dg9pOB+/vtMmktr9rqycYpW1OwFXpg==
X-Received: by 2002:a17:90a:eb09:: with SMTP id
 j9mr4558758pjz.192.1597455114402; 
 Fri, 14 Aug 2020 18:31:54 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id y196sm10625528pfc.202.2020.08.14.18.31.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2020 18:31:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 05/20] target/arm: Merge do_vector2_p into do_mov_p
Date: Fri, 14 Aug 2020 18:31:30 -0700
Message-Id: <20200815013145.539409-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200815013145.539409-1-richard.henderson@linaro.org>
References: <20200815013145.539409-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::243;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x243.google.com
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

This is the only user of the function.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-sve.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index b0fa38db1c..d310709de3 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -178,18 +178,6 @@ static void do_dupi_z(DisasContext *s, int rd, uint64_t word)
     tcg_gen_gvec_dup_imm(MO_64, vec_full_reg_offset(s, rd), vsz, vsz, word);
 }
 
-/* Invoke a vector expander on two Pregs.  */
-static bool do_vector2_p(DisasContext *s, GVecGen2Fn *gvec_fn,
-                         int esz, int rd, int rn)
-{
-    if (sve_access_check(s)) {
-        unsigned psz = pred_gvec_reg_size(s);
-        gvec_fn(esz, pred_full_reg_offset(s, rd),
-                pred_full_reg_offset(s, rn), psz, psz);
-    }
-    return true;
-}
-
 /* Invoke a vector expander on three Pregs.  */
 static bool do_vector3_p(DisasContext *s, GVecGen3Fn *gvec_fn,
                          int esz, int rd, int rn, int rm)
@@ -221,7 +209,12 @@ static bool do_vecop4_p(DisasContext *s, const GVecGen4 *gvec_op,
 /* Invoke a vector move on two Pregs.  */
 static bool do_mov_p(DisasContext *s, int rd, int rn)
 {
-    return do_vector2_p(s, tcg_gen_gvec_mov, 0, rd, rn);
+    if (sve_access_check(s)) {
+        unsigned psz = pred_gvec_reg_size(s);
+        tcg_gen_gvec_mov(MO_8, pred_full_reg_offset(s, rd),
+                         pred_full_reg_offset(s, rn), psz, psz);
+    }
+    return true;
 }
 
 /* Set the cpu flags as per a return from an SVE helper.  */
-- 
2.25.1



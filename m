Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D76C2C4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 01:28:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E78A21534
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 01:28:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UNmGmyxe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E78A21534
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLG3T-0001E0-Jw
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 21:28:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43750)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kLG0O-0004tY-JT
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 21:25:04 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:36357)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kLG0M-0005hq-Q8
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 21:25:04 -0400
Received: by mail-pj1-x1042.google.com with SMTP id b17so695682pji.1
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2020 18:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+yuwP80qij/nuD82ane1l2a4D7zi8BJkB3dvAAaGtzw=;
 b=UNmGmyxeiXfK+0oAEpdRfj5RvWB+jjKuC0YK++ypXm+2tOLj+hNuu7I+8CpIXsCDTS
 oDHOrG3TU6xOlc2TuN/eKG2ztUVd12CN2FiduN54hAge5ZoTTNGVAyHd6zMQlvb+LHvE
 oWx6AhCx7EACdxVF/dvqKsr1yJ14DeQkBmCnOCA5w40SuJ9BBr24LGGvtdbGaoS/Tk/O
 sgu6O2oz21xWUvKFSOb0u94BO2TxaFpRmT0AdMOpf14ACyOTVVdJNfCparFSXDNqIwG5
 +9Sp05QD35xi0SVnKljkbZXGDE022dyHYIIzlPa3iz0sR50tef8VNball/Vc/hLrYnL8
 1pIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+yuwP80qij/nuD82ane1l2a4D7zi8BJkB3dvAAaGtzw=;
 b=Gsibhts93Qd0uA1JpsSuNd+sxaUNiuWoTJ1xmuf70q5DemxCTekkdtjvSnH+iyvmRC
 Dm6h+upHoS7qCNqAlVN3BiYxWjbjLgWJalJjspAeCXpOHrKddUBdsZtD3wevWp/SEFyb
 q84uT2RJ5hMrgeife2TgAgaHq3Z/lSGejOKGaLUuQLXKvJkw7CdKYUZi7AsOFTcB2q4P
 1cxBORpXtvC+Ict/F3MkLlzv125KFl6N/QtyUy1SH4eWW2J77XmZpUQFQjglW0MQmIZW
 ZTOT+WsgAm4q41TVU/WcL5HCsQTUOE4dvxu6zlMyycfHlPACz664MoQ7V8c1o8hTLhx4
 F0rQ==
X-Gm-Message-State: AOAM532KNcnDr7L+nU798mCFkqipBV5b4c1StIeund3PPWM0EnhSJLZ8
 gY9ApZ7IfR/r9yAAs8VdNZmzEJCGWJAkpw==
X-Google-Smtp-Source: ABdhPJyb+MmvOlKUd6ouRwQjKyW8bAqvU8adzSllui5uj4vj9dqe+ehivfzJQ5PcKtVX7xgEnIZwtw==
X-Received: by 2002:a17:902:e9d2:b029:d1:e5e7:be63 with SMTP id
 18-20020a170902e9d2b02900d1e5e7be63mr2253409plk.61.1600910701132; 
 Wed, 23 Sep 2020 18:25:01 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id k27sm938432pgm.29.2020.09.23.18.25.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2020 18:25:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 5/8] softfloat: Inline pick_nan_muladd into its caller
Date: Wed, 23 Sep 2020 18:24:50 -0700
Message-Id: <20200924012453.659757-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200924012453.659757-1-richard.henderson@linaro.org>
References: <20200924012453.659757-1-richard.henderson@linaro.org>
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
Cc: bharata@linux.ibm.com, alex.bennee@linaro.org, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Because of FloatParts, there will only ever be one caller.
Inlining allows us to re-use abc_mask for the snan test.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c | 75 +++++++++++++++++++++++--------------------------
 1 file changed, 35 insertions(+), 40 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 3e625c47cd..e038434a07 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -929,45 +929,6 @@ static FloatParts pick_nan(FloatParts a, FloatParts b, float_status *s)
     return a;
 }
 
-static FloatParts pick_nan_muladd(FloatParts a, FloatParts b, FloatParts c,
-                                  bool inf_zero, float_status *s)
-{
-    int which;
-
-    if (is_snan(a.cls) || is_snan(b.cls) || is_snan(c.cls)) {
-        s->float_exception_flags |= float_flag_invalid;
-    }
-
-    which = pickNaNMulAdd(a.cls, b.cls, c.cls, inf_zero, s);
-
-    if (s->default_nan_mode) {
-        /* Note that this check is after pickNaNMulAdd so that function
-         * has an opportunity to set the Invalid flag.
-         */
-        which = 3;
-    }
-
-    switch (which) {
-    case 0:
-        break;
-    case 1:
-        a = b;
-        break;
-    case 2:
-        a = c;
-        break;
-    case 3:
-        return parts_default_nan(s);
-    default:
-        g_assert_not_reached();
-    }
-
-    if (is_snan(a.cls)) {
-        return parts_silence_nan(a, s);
-    }
-    return a;
-}
-
 /*
  * Returns the result of adding or subtracting the values of the
  * floating-point values `a' and `b'. The operation is performed
@@ -1366,7 +1327,41 @@ static FloatParts muladd_floats(FloatParts a, FloatParts b, FloatParts c,
      * off to the target-specific pick-a-NaN routine.
      */
     if (unlikely(abc_mask & float_cmask_anynan)) {
-        return pick_nan_muladd(a, b, c, inf_zero, s);
+        int which;
+
+        if (unlikely(abc_mask & float_cmask_snan)) {
+            float_raise(float_flag_invalid, s);
+        }
+
+        which = pickNaNMulAdd(a.cls, b.cls, c.cls, inf_zero, s);
+
+        if (s->default_nan_mode) {
+            /*
+             * Note that this check is after pickNaNMulAdd so that function
+             * has an opportunity to set the Invalid flag for inf_zero.
+             */
+            which = 3;
+        }
+
+        switch (which) {
+        case 0:
+            break;
+        case 1:
+            a = b;
+            break;
+        case 2:
+            a = c;
+            break;
+        case 3:
+            return parts_default_nan(s);
+        default:
+            g_assert_not_reached();
+        }
+
+        if (is_snan(a.cls)) {
+            return parts_silence_nan(a, s);
+        }
+        return a;
     }
 
     if (unlikely(inf_zero)) {
-- 
2.25.1



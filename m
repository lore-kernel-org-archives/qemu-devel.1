Return-Path: <SRS0=E7tW=DZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 513A5C433E7
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Oct 2020 21:07:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DD0D21D41
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Oct 2020 21:07:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gXU6isMI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DD0D21D41
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUFu0-0004x4-Gs
	for qemu-devel@archiver.kernel.org; Sun, 18 Oct 2020 17:07:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43330)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kUFss-00048u-JI
 for qemu-devel@nongnu.org; Sun, 18 Oct 2020 17:06:30 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533]:39585)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kUFsq-0004xx-MA
 for qemu-devel@nongnu.org; Sun, 18 Oct 2020 17:06:30 -0400
Received: by mail-pg1-x533.google.com with SMTP id o7so4797717pgv.6
 for <qemu-devel@nongnu.org>; Sun, 18 Oct 2020 14:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=XIO/iwNNPyVpra/AXQSKFIgdMRkHVeNhqQxZp6Kohhc=;
 b=gXU6isMImszNz+pYZgiaqwr6wJJvT8TdtAbvdrqOz+BpXlRAi2qFlZMd2zsPssesGp
 NMk3mgDWn+6ZIdeOUAgj38Q1W8kUtp+wXSvsQ8kGiNvvkZjPPVaNrx3tudIAes4eE6VT
 k350Q1CcjA7BoZLhcUULRQQEI1Me7nu68nIj2uKSjJe2cenmuuuN/Z2GVeUk2/oOJr7/
 eGSkInp9+IEMxnmyf5p7EDMK0snuPB0DnLzEEEr11F3bc38AxIuyqg7ElIT0hbRhPVMV
 +Bc74EVFp0j19Ocj6kBSgajAm13ZyvFe5dRE+DLqtSpHEzLTcbY7tQ3vXvJJAdDrPuCR
 fdpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XIO/iwNNPyVpra/AXQSKFIgdMRkHVeNhqQxZp6Kohhc=;
 b=mFPTNdhNjFTK0Pd/yrtqnHnbXFAZbC8GdQBa6oK4azCRkCY4tu813fPrc2nwkx0P7G
 sPRty2fW1b/PzHweS3pGH2YgnYHpPr5WZnisk5fO3qB+c05m95PViCj6QAdMiO2CboOL
 yHPlB/qfO3tVkynj5sZMzZccH8CbtW3F7YQSyDPaUws1rVjiv93dEG8I49PaRjfSf//a
 byRKiHOYAbJ6o1tN9k4F3dSDyKm5FxRSmkJ9lyUmQPmhnUH2o56IK/ON4yhGvdXJdCVz
 iTNCKxTVWgdXA4FGD6T6TTw4k2eaxuzI185E4k9AWqqAk1zBuTELLhlF8E1+F0VCBoTm
 K08A==
X-Gm-Message-State: AOAM531rgJz9K1vnMOFlYaks/i26olnPKbeEpqYeYNIWZxv9mlGelO36
 97np137+pFfybK/rH4IC2e3dqexSGeIZ2A==
X-Google-Smtp-Source: ABdhPJwNRdCL4q5twTg+0/g1AHo03WZEaAP6To5Ok1xcMQv6vvC7RuS5GK4XvvBMDJllUI+ySNCakg==
X-Received: by 2002:a62:4e0f:0:b029:156:13e0:efa7 with SMTP id
 c15-20020a624e0f0000b029015613e0efa7mr13708413pfb.73.1603055186663; 
 Sun, 18 Oct 2020 14:06:26 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id a18sm9067349pgw.50.2020.10.18.14.06.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Oct 2020 14:06:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] softfpu: Generalize pick_nan_muladd to opaque structures
Date: Sun, 18 Oct 2020 14:06:25 -0700
Message-Id: <20201018210625.1232930-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <4ba9afe5-d5f0-7315-2a6f-139a4a6e66be@linaro.org>
References: <4ba9afe5-d5f0-7315-2a6f-139a4a6e66be@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x533.google.com
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
Cc: Alex Bennee <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This will allow us to share code between FloatParts and FloatParts128.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
Cc: Alex Bennee <alex.bennee@linaro.org>

What do you think of this instead of inlining pick_nan_muladd
into the two muladd implementations?


r~

---
 fpu/softfloat.c | 40 ++++++++++++++++++++++++----------------
 1 file changed, 24 insertions(+), 16 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 3e625c47cd..60fdddd163 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -929,16 +929,23 @@ static FloatParts pick_nan(FloatParts a, FloatParts b, float_status *s)
     return a;
 }
 
-static FloatParts pick_nan_muladd(FloatParts a, FloatParts b, FloatParts c,
-                                  bool inf_zero, float_status *s)
+/*
+ * Given pointers to A, B, C, and the respective classes, return the
+ * pointer to the structure that is the NaN result, or NULL to signal
+ * that the result is the default NaN.
+ */
+static inline void *
+pick_nan_muladd(FloatClass a_cls, FloatClass b_cls, FloatClass c_cls,
+                void *a, void *b, void *c,
+                bool inf_zero, int abc_mask, float_status *s)
 {
     int which;
 
-    if (is_snan(a.cls) || is_snan(b.cls) || is_snan(c.cls)) {
+    if (unlikely(abc_mask & float_cmask_snan)) {
         s->float_exception_flags |= float_flag_invalid;
     }
 
-    which = pickNaNMulAdd(a.cls, b.cls, c.cls, inf_zero, s);
+    which = pickNaNMulAdd(a_cls, b_cls, c_cls, inf_zero, s);
 
     if (s->default_nan_mode) {
         /* Note that this check is after pickNaNMulAdd so that function
@@ -949,23 +956,16 @@ static FloatParts pick_nan_muladd(FloatParts a, FloatParts b, FloatParts c,
 
     switch (which) {
     case 0:
-        break;
+        return a;
     case 1:
-        a = b;
-        break;
+        return b;
     case 2:
-        a = c;
-        break;
+        return c;
     case 3:
-        return parts_default_nan(s);
+        return NULL;
     default:
         g_assert_not_reached();
     }
-
-    if (is_snan(a.cls)) {
-        return parts_silence_nan(a, s);
-    }
-    return a;
 }
 
 /*
@@ -1366,7 +1366,15 @@ static FloatParts muladd_floats(FloatParts a, FloatParts b, FloatParts c,
      * off to the target-specific pick-a-NaN routine.
      */
     if (unlikely(abc_mask & float_cmask_anynan)) {
-        return pick_nan_muladd(a, b, c, inf_zero, s);
+        FloatParts *r = pick_nan_muladd(a.cls, b.cls, c.cls, &a, &b, &c,
+                                        inf_zero, abc_mask, s);
+        if (r == NULL) {
+            return parts_default_nan(s);
+        }
+        if (is_snan(r->cls)) {
+            return parts_silence_nan(*r, s);
+        }
+        return *r;
     }
 
     if (unlikely(inf_zero)) {
-- 
2.25.1



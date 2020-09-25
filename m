Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6F43C4727D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 15:30:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 511F9235F9
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 15:30:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OiKnVN91"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 511F9235F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLpfs-0001Ie-Dp
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 11:30:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59794)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kLpWt-00013i-RT
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 11:20:59 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:35903)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kLpWs-0005RI-1A
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 11:20:59 -0400
Received: by mail-pf1-x441.google.com with SMTP id d9so3520005pfd.3
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 08:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=UqQqsLP6qYPuAh+FMkFGchn7mynGi7GNJsDQP3A30QE=;
 b=OiKnVN91aBweyamlSCjk0SaZouoMY1iYZUf3pZWoda1TxCUEC8IdUtYaH6L1nrFCYY
 KP32aPS1nYAv52mgEJimPKWzySn4WHNheeizJlD0oEz/Tg2bxbsA30+7hAPAeqn6nve9
 Cfxb1qfVzXfrz9GGjv/Jt+v0ODO1nOP1N8OjRLDry29TnEHfz4GQ1nVrfYe8Fazot11I
 17y+i7u6zd3/uNg/QaGQBJyikSVVVBXWdLroV7LGhSLNfHjaV7PU5SezhvwUjNnF05EP
 G8O2bNFj+EOv1TiuAsZqvkXz3Zeo47VUYS9VJsFUMinXbU1ZNRWLs+QaNwxkJ/oZIYTZ
 dPLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UqQqsLP6qYPuAh+FMkFGchn7mynGi7GNJsDQP3A30QE=;
 b=FnnTlZxGxKkCvUuvCoXzVH8LMeddDIlC2gFwAWQzUxSEhw2nho8khVgNorcZlLd4Yr
 MfRziTFWUliB0kkQBDDN56ltmLKWHvCMO8mnAfaEmlaMJX7+qSukgsJ6hQ9hiNV+yWkK
 kTdkaZSVQQErwUvB3bC0Qwcj+fO4XTxEIGF07pH8b5caGZ/0pyFKlNkAYKJpM6SldYzk
 RNjGFPSUeqRhXBO+Cpq5g/r/KPOvHgw6inYv+UnGv+GsitrTmf2P7Y+R9aF6BZVuLZHZ
 5JmiHRgmymyCMCn6B9C3EUyKEsg33VsPjifeGZnSlKkXEgDmfxus1Pf4EYVX6LDccL4g
 CT6g==
X-Gm-Message-State: AOAM531tBsIJnHcV8hpZYzdeomsaN89bs4rtoi5Ckgkzj1ThzdZPUI61
 XERRQcCtyRYC5tRj388PciWGbzKH1lOK6A==
X-Google-Smtp-Source: ABdhPJzOcwpx0gcIDdFnWkfdUPaWe5iqpKyxO3QIEuYD2zJ0NfzhA1wuSM0E+9G4Ony0d3WI4+3FSQ==
X-Received: by 2002:a62:7b94:0:b029:142:2501:35e4 with SMTP id
 w142-20020a627b940000b0290142250135e4mr4582809pfc.68.1601047256226; 
 Fri, 25 Sep 2020 08:20:56 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id a5sm2717859pgk.13.2020.09.25.08.20.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2020 08:20:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 05/10] softfloat: Inline pick_nan_muladd into its caller
Date: Fri, 25 Sep 2020 08:20:42 -0700
Message-Id: <20200925152047.709901-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200925152047.709901-1-richard.henderson@linaro.org>
References: <20200925152047.709901-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x441.google.com
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

Reviewed-by: David Hildenbrand <david@redhat.com>
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



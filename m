Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88072C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 18:51:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53347206D8
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 18:51:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DlS++alC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53347206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZfQF-0003Zg-FZ
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 14:51:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54000)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jZfMm-00082g-Kp
 for qemu-devel@nongnu.org; Fri, 15 May 2020 14:47:28 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029]:40872)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jZfMl-0005sm-GV
 for qemu-devel@nongnu.org; Fri, 15 May 2020 14:47:28 -0400
Received: by mail-pj1-x1029.google.com with SMTP id fu13so1359464pjb.5
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 11:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=sDsWd7cEdqbJ8T+RDdCYVYocOyGqUc9YgStV0gdweYI=;
 b=DlS++alCxWWICHae4BiFLQEbLJqwsch8Ygr3J7ZNBbaAHoS33z3s4nT9FtgBG/YLug
 EEa/dpCTFFbNcoHEgxxRhxluwrknUhVi8Q0r+zP/oDcoBvsWrsTHrJQ4ztgarb4Y1S+B
 Cc4LsCTGYkbeNaaT05mA9NP0uDftlzet6icYKD5RKXZPWLPMRIF4FS2ifn4XNHeaadHD
 JCvwveCetQGy8Z6tVNDbh0BGtWltuccsux3zW6HhZ3HJQ5GNQbhobJ25hW4qmRSvDOVA
 /VNP02fAaa1uuevQ0nUGeD+NVIrRh4YENsg1ibltx6bLHgQEzUmB5oz46gtOStsMz3/X
 SjQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=sDsWd7cEdqbJ8T+RDdCYVYocOyGqUc9YgStV0gdweYI=;
 b=iuKo95WoBQKeWo0afrTNwdCCs9rjdFdYD0ZdGKaIb0pB3U6nvL6JC7BzMBMtCIpvlP
 e9rHHF84Czmfrnlw81sVn7dztNsKh5W9HBpnwRCf0mp/bYeHkzcyNintvlCmjdImW1iZ
 tr07QZU8sMpTeIr0G+bOkqlY6h5SpNhen4nnn63klH277JD5keabck/Pg7+eDY75yO7o
 acSZSMt2BBPuy7AlCcixkVfcJz8NNYDnNZ9StlgS9DNYsC4FzbuLInIUMrRz16+3QqNV
 9f7st6IzMxIHfrgxymc5hH0AVGD6L3CPlnc9fx33Ijmy+fbr3idrZIBijFc56ESqUwIz
 wo0A==
X-Gm-Message-State: AOAM531Z62X5/IcPJXmbqszUCR583MEAw8cLML0qNGhZmX81mtyw2iYt
 jzntu5f1yT2TpK7SROpJEackfmsUEQ0=
X-Google-Smtp-Source: ABdhPJwQGgSEmMvUrPYV832IT7JiutGUAi4G5/oHd7rYGrFhIWEYhUXpT4RCPlPezRc9Eje06pxElA==
X-Received: by 2002:a17:90a:c253:: with SMTP id
 d19mr5205958pjx.210.1589568445504; 
 Fri, 15 May 2020 11:47:25 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id u73sm2743630pfc.0.2020.05.15.11.47.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2020 11:47:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 1/4] softfloat: silence sNaN for conversions to/from floatx80
Date: Fri, 15 May 2020 11:47:19 -0700
Message-Id: <20200515184722.31182-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200515184722.31182-1-richard.henderson@linaro.org>
References: <20200515184722.31182-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
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
Cc: peter.maydell@linaro.org, Joseph Myers <joseph@codesourcery.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Joseph Myers <joseph@codesourcery.com>

Conversions between IEEE floating-point formats should convert
signaling NaNs to quiet NaNs.  Most of those in QEMU's softfloat code
do so, but those for floatx80 fail to.  Fix those conversions to
silence signaling NaNs as well.

Signed-off-by: Joseph Myers <joseph@codesourcery.com>
Message-Id: <alpine.DEB.2.21.2005042336170.22972@digraph.polyomino.org.uk>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c                         | 24 +++++++---
 tests/tcg/i386/test-i386-snan-convert.c | 63 +++++++++++++++++++++++++
 2 files changed, 81 insertions(+), 6 deletions(-)
 create mode 100644 tests/tcg/i386/test-i386-snan-convert.c

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index ae6ba71854..ac116c70b8 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -4498,7 +4498,9 @@ floatx80 float32_to_floatx80(float32 a, float_status *status)
     aSign = extractFloat32Sign( a );
     if ( aExp == 0xFF ) {
         if (aSig) {
-            return commonNaNToFloatx80(float32ToCommonNaN(a, status), status);
+            floatx80 res = commonNaNToFloatx80(float32ToCommonNaN(a, status),
+                                               status);
+            return floatx80_silence_nan(res, status);
         }
         return packFloatx80(aSign,
                             floatx80_infinity_high,
@@ -5016,7 +5018,9 @@ floatx80 float64_to_floatx80(float64 a, float_status *status)
     aSign = extractFloat64Sign( a );
     if ( aExp == 0x7FF ) {
         if (aSig) {
-            return commonNaNToFloatx80(float64ToCommonNaN(a, status), status);
+            floatx80 res = commonNaNToFloatx80(float64ToCommonNaN(a, status),
+                                               status);
+            return floatx80_silence_nan(res, status);
         }
         return packFloatx80(aSign,
                             floatx80_infinity_high,
@@ -5618,7 +5622,9 @@ float32 floatx80_to_float32(floatx80 a, float_status *status)
     aSign = extractFloatx80Sign( a );
     if ( aExp == 0x7FFF ) {
         if ( (uint64_t) ( aSig<<1 ) ) {
-            return commonNaNToFloat32(floatx80ToCommonNaN(a, status), status);
+            float32 res = commonNaNToFloat32(floatx80ToCommonNaN(a, status),
+                                             status);
+            return float32_silence_nan(res, status);
         }
         return packFloat32( aSign, 0xFF, 0 );
     }
@@ -5650,7 +5656,9 @@ float64 floatx80_to_float64(floatx80 a, float_status *status)
     aSign = extractFloatx80Sign( a );
     if ( aExp == 0x7FFF ) {
         if ( (uint64_t) ( aSig<<1 ) ) {
-            return commonNaNToFloat64(floatx80ToCommonNaN(a, status), status);
+            float64 res = commonNaNToFloat64(floatx80ToCommonNaN(a, status),
+                                             status);
+            return float64_silence_nan(res, status);
         }
         return packFloat64( aSign, 0x7FF, 0 );
     }
@@ -5681,7 +5689,9 @@ float128 floatx80_to_float128(floatx80 a, float_status *status)
     aExp = extractFloatx80Exp( a );
     aSign = extractFloatx80Sign( a );
     if ( ( aExp == 0x7FFF ) && (uint64_t) ( aSig<<1 ) ) {
-        return commonNaNToFloat128(floatx80ToCommonNaN(a, status), status);
+        float128 res = commonNaNToFloat128(floatx80ToCommonNaN(a, status),
+                                           status);
+        return float128_silence_nan(res, status);
     }
     shift128Right( aSig<<1, 0, 16, &zSig0, &zSig1 );
     return packFloat128( aSign, aExp, zSig0, zSig1 );
@@ -6959,7 +6969,9 @@ floatx80 float128_to_floatx80(float128 a, float_status *status)
     aSign = extractFloat128Sign( a );
     if ( aExp == 0x7FFF ) {
         if ( aSig0 | aSig1 ) {
-            return commonNaNToFloatx80(float128ToCommonNaN(a, status), status);
+            floatx80 res = commonNaNToFloatx80(float128ToCommonNaN(a, status),
+                                               status);
+            return floatx80_silence_nan(res, status);
         }
         return packFloatx80(aSign, floatx80_infinity_high,
                                    floatx80_infinity_low);
diff --git a/tests/tcg/i386/test-i386-snan-convert.c b/tests/tcg/i386/test-i386-snan-convert.c
new file mode 100644
index 0000000000..ed6d535ce2
--- /dev/null
+++ b/tests/tcg/i386/test-i386-snan-convert.c
@@ -0,0 +1,63 @@
+/* Test conversions of signaling NaNs to and from long double.  */
+
+#include <stdint.h>
+#include <stdio.h>
+
+volatile float f_res;
+volatile double d_res;
+volatile long double ld_res;
+
+volatile float f_snan = __builtin_nansf("");
+volatile double d_snan = __builtin_nans("");
+volatile long double ld_snan = __builtin_nansl("");
+
+int issignaling_f(float x)
+{
+    union { float f; uint32_t u; } u = { .f = x };
+    return (u.u & 0x7fffffff) > 0x7f800000 && (u.u & 0x400000) == 0;
+}
+
+int issignaling_d(double x)
+{
+    union { double d; uint64_t u; } u = { .d = x };
+    return (((u.u & UINT64_C(0x7fffffffffffffff)) >
+            UINT64_C(0x7ff0000000000000)) &&
+            (u.u & UINT64_C(0x8000000000000)) == 0);
+}
+
+int issignaling_ld(long double x)
+{
+    union {
+        long double ld;
+        struct { uint64_t sig; uint16_t sign_exp; } s;
+    } u = { .ld = x };
+    return ((u.s.sign_exp & 0x7fff) == 0x7fff &&
+            (u.s.sig >> 63) != 0 &&
+            (u.s.sig & UINT64_C(0x4000000000000000)) == 0);
+}
+
+int main(void)
+{
+    int ret = 0;
+    ld_res = f_snan;
+    if (issignaling_ld(ld_res)) {
+        printf("FAIL: float -> long double\n");
+        ret = 1;
+    }
+    ld_res = d_snan;
+    if (issignaling_ld(ld_res)) {
+        printf("FAIL: double -> long double\n");
+        ret = 1;
+    }
+    f_res = ld_snan;
+    if (issignaling_d(f_res)) {
+        printf("FAIL: long double -> float\n");
+        ret = 1;
+    }
+    d_res = ld_snan;
+    if (issignaling_d(d_res)) {
+        printf("FAIL: long double -> double\n");
+        ret = 1;
+    }
+    return ret;
+}
-- 
2.20.1



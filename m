Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45FD3C32750
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 12:50:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 134CA20840
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 12:50:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uND/gZqX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 134CA20840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxWGN-0003yf-9t
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 08:50:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53530)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hxWFK-0002Gd-SL
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 08:49:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hxWFJ-0000cd-OV
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 08:49:50 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:36754)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hxWFJ-0000bg-H1
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 08:49:49 -0400
Received: by mail-wm1-x344.google.com with SMTP id g67so1349200wme.1
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2019 05:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ki6/qS5/kkWXkqIOjzkIPrV1IVbRhLJ3aywqEzrIZU8=;
 b=uND/gZqXPc8xqzhQS4i+6ajDn5604DAUVmHBkL3UoOSYpG7qAxHGmMLLR7s6l9jh3A
 JLMfrrs4O0UJOLlcujvkyTyNaJvK2zztvAzpZ3vYwG+/Zr7GiXWlJv1pUddXNgI4EuKS
 r0yd3jL8rWmy4g7WTrq0LN4xJLGOJbHFPFEiIdP3pbLrOCt0CNiqw2ty9POnpyyBKWcw
 nHSj/8q3H5DFSzv9nRDcTRxL6DFWaVt0Pg+6pU6/1pyKJpH2qkCV4MQYGzt1KdcD6ZHC
 +56LqCQ8f3x7O14y6UD4M/t8RLZM17g2KTrpWBctO6Rbom7R5IgvsNw0y8sRXQKFZ8YG
 tfmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ki6/qS5/kkWXkqIOjzkIPrV1IVbRhLJ3aywqEzrIZU8=;
 b=gxJklrWhwNzL2feqZLxVdx4sLb/1RUldvCfYIvEmtTk+ejpcKCgCmeizK6IfylbCu5
 2fYUrO62FWPUpLbug+x7lOCEt4MJT6V7pgiyoyvyVdoZo2dMp5RmUp0MC8v4ZqbAYIUV
 GrTjfZ4qRsOPojevVTZ7MOEn5jZ/oaQJo5NfZAhpdMNtmy9bCWf/PstfY7FBxRPQY9Qt
 x5mG9L6ci+MeU7/UTGEiYSqmnkRT7v8HCwuSbwDuV9aqiNchh+FeTkfaegi9KyxPKdhA
 ICz0OYDSwkQIPoSkAK4/6OeKAUUzIvZvS0F2UvhoJeog2xQ6Gx9FbF0D3I37DWLJbOMf
 +GGA==
X-Gm-Message-State: APjAAAVJX81UAw4zSzqm7OCHhnFi2FpjveEmYAaO+gNSE9cA/Y1tDyNa
 x7A1E/JaEXrjPR/pktyh1ah3rw==
X-Google-Smtp-Source: APXvYqyIvbTKcWw635qxSG8C4efec+JQ2EMGKssr4Bf82IKIb0WuTIe0gH3tU9AqrOIiVaGz0JB6RA==
X-Received: by 2002:a05:600c:224c:: with SMTP id
 a12mr3016123wmm.12.1565700588351; 
 Tue, 13 Aug 2019 05:49:48 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id c8sm4349416wrn.50.2019.08.13.05.49.47
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 13 Aug 2019 05:49:47 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 044C91FF8C;
 Tue, 13 Aug 2019 13:49:47 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue, 13 Aug 2019 13:49:34 +0100
Message-Id: <20190813124946.25322-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190813124946.25322-1-alex.bennee@linaro.org>
References: <20190813124946.25322-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: [Qemu-devel] [PATCH v3 01/13] fpu: replace LIT64 usage with
 UINT64_C for specialize constants
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, armbru@redhat.com,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We have a wrapper that does the right thing from stdint.h so lets use
it for our constants in softfloat-specialize.h

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 fpu/softfloat-specialize.h | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/fpu/softfloat-specialize.h b/fpu/softfloat-specialize.h
index 7b8895726c5..5ab2fa19415 100644
--- a/fpu/softfloat-specialize.h
+++ b/fpu/softfloat-specialize.h
@@ -196,11 +196,11 @@ floatx80 floatx80_default_nan(float_status *status)
     /* None of the targets that have snan_bit_is_one use floatx80.  */
     assert(!snan_bit_is_one(status));
 #if defined(TARGET_M68K)
-    r.low = LIT64(0xFFFFFFFFFFFFFFFF);
+    r.low = UINT64_C(0xFFFFFFFFFFFFFFFF);
     r.high = 0x7FFF;
 #else
     /* X86 */
-    r.low = LIT64(0xC000000000000000);
+    r.low = UINT64_C(0xC000000000000000);
     r.high = 0xFFFF;
 #endif
     return r;
@@ -212,9 +212,9 @@ floatx80 floatx80_default_nan(float_status *status)
 
 #define floatx80_infinity_high 0x7FFF
 #if defined(TARGET_M68K)
-#define floatx80_infinity_low  LIT64(0x0000000000000000)
+#define floatx80_infinity_low  UINT64_C(0x0000000000000000)
 #else
-#define floatx80_infinity_low  LIT64(0x8000000000000000)
+#define floatx80_infinity_low  UINT64_C(0x8000000000000000)
 #endif
 
 const floatx80 floatx80_infinity
@@ -667,7 +667,7 @@ int float64_is_signaling_nan(float64 a_, float_status *status)
         return ((a << 1) >= 0xFFF0000000000000ULL);
     } else {
         return (((a >> 51) & 0xFFF) == 0xFFE)
-            && (a & LIT64(0x0007FFFFFFFFFFFF));
+            && (a & UINT64_C(0x0007FFFFFFFFFFFF));
     }
 #endif
 }
@@ -707,7 +707,7 @@ static float64 commonNaNToFloat64(commonNaNT a, float_status *status)
     if (mantissa) {
         return make_float64(
               (((uint64_t) a.sign) << 63)
-            | LIT64(0x7FF0000000000000)
+            | UINT64_C(0x7FF0000000000000)
             | (a.high >> 12));
     } else {
         return float64_default_nan(status);
@@ -790,7 +790,7 @@ int floatx80_is_quiet_nan(floatx80 a, float_status *status)
             && (a.low == aLow);
     } else {
         return ((a.high & 0x7FFF) == 0x7FFF)
-            && (LIT64(0x8000000000000000) <= ((uint64_t)(a.low << 1)));
+            && (UINT64_C(0x8000000000000000) <= ((uint64_t)(a.low << 1)));
     }
 #endif
 }
@@ -812,7 +812,7 @@ int floatx80_is_signaling_nan(floatx80 a, float_status *status)
     } else {
         uint64_t aLow;
 
-        aLow = a.low & ~LIT64(0x4000000000000000);
+        aLow = a.low & ~UINT64_C(0x4000000000000000);
         return ((a.high & 0x7FFF) == 0x7FFF)
             && (uint64_t)(aLow << 1)
             && (a.low == aLow);
@@ -829,7 +829,7 @@ floatx80 floatx80_silence_nan(floatx80 a, float_status *status)
 {
     /* None of the targets that have snan_bit_is_one use floatx80.  */
     assert(!snan_bit_is_one(status));
-    a.low |= LIT64(0xC000000000000000);
+    a.low |= UINT64_C(0xC000000000000000);
     return a;
 }
 
@@ -874,7 +874,7 @@ static floatx80 commonNaNToFloatx80(commonNaNT a, float_status *status)
     }
 
     if (a.high >> 1) {
-        z.low = LIT64(0x8000000000000000) | a.high >> 1;
+        z.low = UINT64_C(0x8000000000000000) | a.high >> 1;
         z.high = (((uint16_t)a.sign) << 15) | 0x7FFF;
     } else {
         z = floatx80_default_nan(status);
@@ -969,7 +969,7 @@ int float128_is_signaling_nan(float128 a, float_status *status)
             && (a.low || (a.high & 0x0000FFFFFFFFFFFFULL));
     } else {
         return (((a.high >> 47) & 0xFFFF) == 0xFFFE)
-            && (a.low || (a.high & LIT64(0x00007FFFFFFFFFFF)));
+            && (a.low || (a.high & UINT64_C(0x00007FFFFFFFFFFF)));
     }
 #endif
 }
@@ -987,7 +987,7 @@ float128 float128_silence_nan(float128 a, float_status *status)
     if (snan_bit_is_one(status)) {
         return float128_default_nan(status);
     } else {
-        a.high |= LIT64(0x0000800000000000);
+        a.high |= UINT64_C(0x0000800000000000);
         return a;
     }
 #endif
@@ -1025,7 +1025,7 @@ static float128 commonNaNToFloat128(commonNaNT a, float_status *status)
     }
 
     shift128Right(a.high, a.low, 16, &z.high, &z.low);
-    z.high |= (((uint64_t)a.sign) << 63) | LIT64(0x7FFF000000000000);
+    z.high |= (((uint64_t)a.sign) << 63) | UINT64_C(0x7FFF000000000000);
     return z;
 }
 
-- 
2.20.1



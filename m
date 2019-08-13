Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBB97C32750
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 12:50:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B898520840
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 12:50:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KTkXDOfv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B898520840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxWGP-00046g-VU
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 08:50:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53552)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hxWFL-0002Gf-Ru
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 08:49:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hxWFK-0000dn-Ih
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 08:49:51 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:35039)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hxWFK-0000ci-CI
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 08:49:50 -0400
Received: by mail-wm1-x342.google.com with SMTP id l2so1348443wmg.0
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2019 05:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=XEpGqIEUvdb5555PJIVv1BtkiLX36JbwzRPDngAmByI=;
 b=KTkXDOfvvzmzwEWGNlnD/FCJwALfDoET6FmIW3cUt4zj7aLXANfRtM0zGEqIHgusoL
 +MTUG5hXLFxVr2fFzb64aT/EPPxVN0dRVJO5Y+8nkf0WnZBGxK+lUEowJnM75gUPycoj
 G8xyBuXjUyAsNGXxA61tZ5ubc4lXSjNSo0JK4UXekBuqRqMr2175Jlxjby8okhSa0pun
 eotqhlOsFNyJWekhqmEhmnxsJ9OfTr89C59cjCou8pPxN0w5LFGXG/+3Dp3yE+lsfxpZ
 tSOJ5ZWAX9eOxQzTZWqcJhYOGrLyUWewYVskT4iZQ4OTZeh2z9Pf88+4GlUwXoYELc/U
 mGZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XEpGqIEUvdb5555PJIVv1BtkiLX36JbwzRPDngAmByI=;
 b=sj/dc+UqSLBIFAsTfczoUCfJWVW2P5h6M0uwmzUNVBuiE7cbHzatotSme/X69hJSjM
 f0AmaFaTEbDTL/Hqm1Sbl1eFl9/msl98c1ShiVIM+MdBK3nKjsZHzfKguU8PlqRxKXYq
 pKc6Dl/lkTafTTY91vTgwCatJtAmHbMM2imQioXh6EJLq6S0+mDQQPZywgqK2PD6gIiN
 2eoNaBRMKULRq7GdWUJ0/TGTxl3Ed6oN+UACkH250lNPxj5WkbU/5lmgO9IDe1ZcBbfV
 hb/X1LyfL6bxAf1KIzVLEgxYBEYinE+4sFKd+uHKHzo12sJC53Nh1Zex/2AU0yo+mMEO
 wkBg==
X-Gm-Message-State: APjAAAVbM8EWgqJKtk8nolaaWQd15dfQyn67MEonWszlI14OFpHBTyos
 ycAd1LpCdujE9YpsnP7grm4vCw==
X-Google-Smtp-Source: APXvYqxWfDk+MNBMYqnGnnw0A7mkyqGBff/Yk05bLC0SIOJteQ+850DgoCOJmpmKYspwugY+fGQuXQ==
X-Received: by 2002:a7b:c649:: with SMTP id q9mr2916718wmk.108.1565700589199; 
 Tue, 13 Aug 2019 05:49:49 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id 16sm1977052wmx.45.2019.08.13.05.49.47
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 13 Aug 2019 05:49:47 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 1A2241FF8F;
 Tue, 13 Aug 2019 13:49:47 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue, 13 Aug 2019 13:49:35 +0100
Message-Id: <20190813124946.25322-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190813124946.25322-1-alex.bennee@linaro.org>
References: <20190813124946.25322-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: [Qemu-devel] [PATCH v3 02/13] fpu: convert
 float[16/32/64]_squash_denormal to new modern style
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

This also allows us to remove the extractFloat16exp/frac helpers.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 fpu/softfloat.c | 110 +++++++++++++++++++++---------------------------
 1 file changed, 47 insertions(+), 63 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 2ba36ec3703..0a434555cd8 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -414,24 +414,6 @@ float64_gen2(float64 xa, float64 xb, float_status *s,
     return soft(ua.s, ub.s, s);
 }
 
-/*----------------------------------------------------------------------------
-| Returns the fraction bits of the half-precision floating-point value `a'.
-*----------------------------------------------------------------------------*/
-
-static inline uint32_t extractFloat16Frac(float16 a)
-{
-    return float16_val(a) & 0x3ff;
-}
-
-/*----------------------------------------------------------------------------
-| Returns the exponent bits of the half-precision floating-point value `a'.
-*----------------------------------------------------------------------------*/
-
-static inline int extractFloat16Exp(float16 a)
-{
-    return (float16_val(a) >> 10) & 0x1f;
-}
-
 /*----------------------------------------------------------------------------
 | Returns the fraction bits of the single-precision floating-point value `a'.
 *----------------------------------------------------------------------------*/
@@ -3306,6 +3288,53 @@ float64 float64_silence_nan(float64 a, float_status *status)
     return float64_pack_raw(p);
 }
 
+
+/*----------------------------------------------------------------------------
+| If `a' is denormal and we are in flush-to-zero mode then set the
+| input-denormal exception and return zero. Otherwise just return the value.
+*----------------------------------------------------------------------------*/
+
+static FloatParts parts_squash_denormal(FloatParts p, float_status *status)
+{
+    if (p.exp == 0 && p.frac != 0) {
+        float_raise(float_flag_input_denormal, status);
+        p.frac = 0;
+        p.cls = float_class_zero;
+    }
+
+    return p;
+}
+
+float16 float16_squash_input_denormal(float16 a, float_status *status)
+{
+    if (status->flush_inputs_to_zero) {
+        FloatParts p = float16_unpack_raw(a);
+        p = parts_squash_denormal(p, status);
+        return float16_pack_raw(p);
+    }
+    return a;
+}
+
+float32 float32_squash_input_denormal(float32 a, float_status *status)
+{
+    if (status->flush_inputs_to_zero) {
+        FloatParts p = float32_unpack_raw(a);
+        p = parts_squash_denormal(p, status);
+        return float32_pack_raw(p);
+    }
+    return a;
+}
+
+float64 float64_squash_input_denormal(float64 a, float_status *status)
+{
+    if (status->flush_inputs_to_zero) {
+        FloatParts p = float64_unpack_raw(a);
+        p = parts_squash_denormal(p, status);
+        return float64_pack_raw(p);
+    }
+    return a;
+}
+
 /*----------------------------------------------------------------------------
 | Takes a 64-bit fixed-point value `absZ' with binary point between bits 6
 | and 7, and returns the properly rounded 32-bit integer corresponding to the
@@ -3482,21 +3511,6 @@ static int64_t roundAndPackUint64(flag zSign, uint64_t absZ0,
     return absZ0;
 }
 
-/*----------------------------------------------------------------------------
-| If `a' is denormal and we are in flush-to-zero mode then set the
-| input-denormal exception and return zero. Otherwise just return the value.
-*----------------------------------------------------------------------------*/
-float32 float32_squash_input_denormal(float32 a, float_status *status)
-{
-    if (status->flush_inputs_to_zero) {
-        if (extractFloat32Exp(a) == 0 && extractFloat32Frac(a) != 0) {
-            float_raise(float_flag_input_denormal, status);
-            return make_float32(float32_val(a) & 0x80000000);
-        }
-    }
-    return a;
-}
-
 /*----------------------------------------------------------------------------
 | Normalizes the subnormal single-precision floating-point value represented
 | by the denormalized significand `aSig'.  The normalized exponent and
@@ -3635,21 +3649,6 @@ static float32
 
 }
 
-/*----------------------------------------------------------------------------
-| If `a' is denormal and we are in flush-to-zero mode then set the
-| input-denormal exception and return zero. Otherwise just return the value.
-*----------------------------------------------------------------------------*/
-float64 float64_squash_input_denormal(float64 a, float_status *status)
-{
-    if (status->flush_inputs_to_zero) {
-        if (extractFloat64Exp(a) == 0 && extractFloat64Frac(a) != 0) {
-            float_raise(float_flag_input_denormal, status);
-            return make_float64(float64_val(a) & (1ULL << 63));
-        }
-    }
-    return a;
-}
-
 /*----------------------------------------------------------------------------
 | Normalizes the subnormal double-precision floating-point value represented
 | by the denormalized significand `aSig'.  The normalized exponent and
@@ -4981,21 +4980,6 @@ int float32_unordered_quiet(float32 a, float32 b, float_status *status)
     return 0;
 }
 
-/*----------------------------------------------------------------------------
-| If `a' is denormal and we are in flush-to-zero mode then set the
-| input-denormal exception and return zero. Otherwise just return the value.
-*----------------------------------------------------------------------------*/
-float16 float16_squash_input_denormal(float16 a, float_status *status)
-{
-    if (status->flush_inputs_to_zero) {
-        if (extractFloat16Exp(a) == 0 && extractFloat16Frac(a) != 0) {
-            float_raise(float_flag_input_denormal, status);
-            return make_float16(float16_val(a) & 0x8000);
-        }
-    }
-    return a;
-}
-
 /*----------------------------------------------------------------------------
 | Returns the result of converting the double-precision floating-point value
 | `a' to the extended double-precision floating-point format.  The conversion
-- 
2.20.1



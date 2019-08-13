Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A816EC32750
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 12:57:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61D36206C2
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 12:57:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AEyuXyHx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61D36206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxWMU-0005AS-EK
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 08:57:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53603)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hxWFP-0002NX-6Z
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 08:49:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hxWFN-0000hG-0r
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 08:49:55 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:33749)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hxWFM-0000gG-Nb
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 08:49:52 -0400
Received: by mail-wm1-x341.google.com with SMTP id p77so1010331wme.0
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2019 05:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=hOLI7tuxGPQjXT0Wu0CPJzX+iAqQQ6MgBHKIRDBk/oY=;
 b=AEyuXyHxnE+hC0U+9AkjSVWX2LF+UWCKN5wTWjUCuJPl4o2Q/23dhRiHubh3Jsg7Z7
 yMZe18zPfBXZEsCtNa53DGVfZOT00N7ylMBM7ID/8aMAGAnHOEIZdBsgPoXPu810lUha
 EnuxzIyYGvoiRh5G656xvEsFMdq8jwHp5O5atlRam86A7PjMRr63Ic7qoI+dq8g6JUK7
 RMqU7RQPeJpOWtZnaF/10l3O0alVQ3ftDGY5WIzXj+d7/+CD+5sucmHZFjWnvauoxDGy
 bHNE9Ykg1G2izHoFQomnvhGHu72eFDQKepeq3DMOh2f7mxIx6cOTgXqB8xe1gBy+HDgQ
 M4yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=hOLI7tuxGPQjXT0Wu0CPJzX+iAqQQ6MgBHKIRDBk/oY=;
 b=NSk0aUBw0+F7140v9AquC4XwZrlSwnVdvrPF9OvK5f9XFu13cNhWLnA16DJkdXVUq8
 25y798jenWG2addoXL7UOUN7r5FPOTqcn+oNa8EhLvHnr2/x+H3mceEQwZH6GJ3J3zVC
 HcnU0neUrhIRkdC7Z/LkdufMFiikjKgt9g7tW87lby9hNvPIZYexPKM11Eg793DB5wBw
 KQzaWuW0Pwcviax8xA94H+V3Y3u/EJ+d0pS8nq8zGRymrg/JrY6iwpMN6MBJhJdpdgfQ
 htFUYJH2UpNYl1XeXyvfQV/Y3kEuXF6lMYTptNOKjBRAaBpj6/CSlb7IwUfKG3fIZgW1
 eGiQ==
X-Gm-Message-State: APjAAAWlADZMsxtlIA79DqpTtuD/T8xHmgQMXirMp+ZnnXYNMgQFTc18
 bS88itVKzlDODotrOLMXEaCqgA==
X-Google-Smtp-Source: APXvYqzVhgEgYhXpkY/UVmn6QdVSzyKuMvbTNgfyKmvwGZQ/A9PCdes6qkbMnB7ukxm67MuWY6ktzA==
X-Received: by 2002:a1c:2d87:: with SMTP id t129mr2918315wmt.157.1565700591469; 
 Tue, 13 Aug 2019 05:49:51 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id l2sm1090343wmj.4.2019.08.13.05.49.48
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 13 Aug 2019 05:49:49 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 5A9E41FF92;
 Tue, 13 Aug 2019 13:49:47 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue, 13 Aug 2019 13:49:38 +0100
Message-Id: <20190813124946.25322-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190813124946.25322-1-alex.bennee@linaro.org>
References: <20190813124946.25322-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: [Qemu-devel] [PATCH v3 05/13] fpu: replace LIT64 with UINT64_C
 macros
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

In our quest to eliminate the home rolled LIT64 macro we fixup usage
inside the softfloat code. While we are at it we remove some of the
extraneous spaces to closer fit the house style.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 fpu/softfloat.c                | 118 ++++++++++++++++-----------------
 include/fpu/softfloat-macros.h |   6 +-
 2 files changed, 62 insertions(+), 62 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index a1e1e9a8559..6bf6241710f 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -447,7 +447,7 @@ static inline flag extractFloat32Sign(float32 a)
 
 static inline uint64_t extractFloat64Frac(float64 a)
 {
-    return float64_val(a) & LIT64(0x000FFFFFFFFFFFFF);
+    return float64_val(a) & UINT64_C(0x000FFFFFFFFFFFFF);
 }
 
 /*----------------------------------------------------------------------------
@@ -3251,7 +3251,7 @@ float128 float128_default_nan(float_status *status)
      */
     r.low = -(p.frac & 1);
     r.high = p.frac >> (DECOMPOSED_BINARY_POINT - 48);
-    r.high |= LIT64(0x7FFF000000000000);
+    r.high |= UINT64_C(0x7FFF000000000000);
     r.high |= (uint64_t)p.sign << 63;
 
     return r;
@@ -3758,7 +3758,7 @@ static float64 roundAndPackFloat64(flag zSign, int zExp, uint64_t zSig,
                    (status->float_detect_tininess
                     == float_tininess_before_rounding)
                 || ( zExp < -1 )
-                || ( zSig + roundIncrement < LIT64( 0x8000000000000000 ) );
+                || ( zSig + roundIncrement < UINT64_C(0x8000000000000000) );
             shift64RightJamming( zSig, - zExp, &zSig );
             zExp = 0;
             roundBits = zSig & 0x3FF;
@@ -3858,12 +3858,12 @@ floatx80 roundAndPackFloatx80(int8_t roundingPrecision, flag zSign,
     roundNearestEven = ( roundingMode == float_round_nearest_even );
     if ( roundingPrecision == 80 ) goto precision80;
     if ( roundingPrecision == 64 ) {
-        roundIncrement = LIT64( 0x0000000000000400 );
-        roundMask = LIT64( 0x00000000000007FF );
+        roundIncrement = UINT64_C(0x0000000000000400);
+        roundMask = UINT64_C(0x00000000000007FF);
     }
     else if ( roundingPrecision == 32 ) {
-        roundIncrement = LIT64( 0x0000008000000000 );
-        roundMask = LIT64( 0x000000FFFFFFFFFF );
+        roundIncrement = UINT64_C(0x0000008000000000);
+        roundMask = UINT64_C(0x000000FFFFFFFFFF);
     }
     else {
         goto precision80;
@@ -3927,7 +3927,7 @@ floatx80 roundAndPackFloatx80(int8_t roundingPrecision, flag zSign,
     zSig0 += roundIncrement;
     if ( zSig0 < roundIncrement ) {
         ++zExp;
-        zSig0 = LIT64( 0x8000000000000000 );
+        zSig0 = UINT64_C(0x8000000000000000);
     }
     roundIncrement = roundMask + 1;
     if ( roundNearestEven && ( roundBits<<1 == roundIncrement ) ) {
@@ -3957,7 +3957,7 @@ floatx80 roundAndPackFloatx80(int8_t roundingPrecision, flag zSign,
     if ( 0x7FFD <= (uint32_t) ( zExp - 1 ) ) {
         if (    ( 0x7FFE < zExp )
              || (    ( zExp == 0x7FFE )
-                  && ( zSig0 == LIT64( 0xFFFFFFFFFFFFFFFF ) )
+                  && ( zSig0 == UINT64_C(0xFFFFFFFFFFFFFFFF) )
                   && increment
                 )
            ) {
@@ -3980,7 +3980,7 @@ floatx80 roundAndPackFloatx80(int8_t roundingPrecision, flag zSign,
                     == float_tininess_before_rounding)
                 || ( zExp < 0 )
                 || ! increment
-                || ( zSig0 < LIT64( 0xFFFFFFFFFFFFFFFF ) );
+                || ( zSig0 < UINT64_C(0xFFFFFFFFFFFFFFFF) );
             shift64ExtraRightJamming( zSig0, zSig1, 1 - zExp, &zSig0, &zSig1 );
             zExp = 0;
             if (isTiny && zSig1) {
@@ -4022,7 +4022,7 @@ floatx80 roundAndPackFloatx80(int8_t roundingPrecision, flag zSign,
         ++zSig0;
         if ( zSig0 == 0 ) {
             ++zExp;
-            zSig0 = LIT64( 0x8000000000000000 );
+            zSig0 = UINT64_C(0x8000000000000000);
         }
         else {
             zSig0 &= ~ ( ( (uint64_t) ( zSig1<<1 ) == 0 ) & roundNearestEven );
@@ -4084,7 +4084,7 @@ static inline uint64_t extractFloat128Frac1( float128 a )
 static inline uint64_t extractFloat128Frac0( float128 a )
 {
 
-    return a.high & LIT64( 0x0000FFFFFFFFFFFF );
+    return a.high & UINT64_C(0x0000FFFFFFFFFFFF);
 
 }
 
@@ -4230,8 +4230,8 @@ static float128 roundAndPackFloat128(flag zSign, int32_t zExp,
         if (    ( 0x7FFD < zExp )
              || (    ( zExp == 0x7FFD )
                   && eq128(
-                         LIT64( 0x0001FFFFFFFFFFFF ),
-                         LIT64( 0xFFFFFFFFFFFFFFFF ),
+                         UINT64_C(0x0001FFFFFFFFFFFF),
+                         UINT64_C(0xFFFFFFFFFFFFFFFF),
                          zSig0,
                          zSig1
                      )
@@ -4248,8 +4248,8 @@ static float128 roundAndPackFloat128(flag zSign, int32_t zExp,
                     packFloat128(
                         zSign,
                         0x7FFE,
-                        LIT64( 0x0000FFFFFFFFFFFF ),
-                        LIT64( 0xFFFFFFFFFFFFFFFF )
+                        UINT64_C(0x0000FFFFFFFFFFFF),
+                        UINT64_C(0xFFFFFFFFFFFFFFFF)
                     );
             }
             return packFloat128( zSign, 0x7FFF, 0, 0 );
@@ -4267,8 +4267,8 @@ static float128 roundAndPackFloat128(flag zSign, int32_t zExp,
                 || lt128(
                        zSig0,
                        zSig1,
-                       LIT64( 0x0001FFFFFFFFFFFF ),
-                       LIT64( 0xFFFFFFFFFFFFFFFF )
+                       UINT64_C(0x0001FFFFFFFFFFFF),
+                       UINT64_C(0xFFFFFFFFFFFFFFFF)
                    );
             shift128ExtraRightJamming(
                 zSig0, zSig1, zSig2, - zExp, &zSig0, &zSig1, &zSig2 );
@@ -5011,7 +5011,7 @@ floatx80 float64_to_floatx80(float64 a, float_status *status)
     }
     return
         packFloatx80(
-            aSign, aExp + 0x3C00, ( aSig | LIT64( 0x0010000000000000 ) )<<11 );
+            aSign, aExp + 0x3C00, (aSig | UINT64_C(0x0010000000000000)) << 11);
 
 }
 
@@ -5095,8 +5095,8 @@ float64 float64_rem(float64 a, float64 b, float_status *status)
         normalizeFloat64Subnormal( aSig, &aExp, &aSig );
     }
     expDiff = aExp - bExp;
-    aSig = ( aSig | LIT64( 0x0010000000000000 ) )<<11;
-    bSig = ( bSig | LIT64( 0x0010000000000000 ) )<<11;
+    aSig = (aSig | UINT64_C(0x0010000000000000)) << 11;
+    bSig = (bSig | UINT64_C(0x0010000000000000)) << 11;
     if ( expDiff < 0 ) {
         if ( expDiff < -1 ) return a;
         aSig >>= 1;
@@ -5169,13 +5169,13 @@ float64 float64_log2(float64 a, float_status *status)
     }
 
     aExp -= 0x3FF;
-    aSig |= LIT64( 0x0010000000000000 );
+    aSig |= UINT64_C(0x0010000000000000);
     zSign = aExp < 0;
     zSig = (uint64_t)aExp << 52;
     for (i = 1LL << 51; i > 0; i >>= 1) {
         mul64To128( aSig, aSig, &aSig0, &aSig1 );
         aSig = ( aSig0 << 12 ) | ( aSig1 >> 52 );
-        if ( aSig & LIT64( 0x0020000000000000 ) ) {
+        if ( aSig & UINT64_C(0x0020000000000000) ) {
             aSig >>= 1;
             zSig |= i;
         }
@@ -5555,7 +5555,7 @@ int64_t floatx80_to_int64_round_to_zero(floatx80 a, float_status *status)
     aSign = extractFloatx80Sign( a );
     shiftCount = aExp - 0x403E;
     if ( 0 <= shiftCount ) {
-        aSig &= LIT64( 0x7FFFFFFFFFFFFFFF );
+        aSig &= UINT64_C(0x7FFFFFFFFFFFFFFF);
         if ( ( a.high != 0xC03E ) || aSig ) {
             float_raise(float_flag_invalid, status);
             if ( ! aSign || ( ( aExp == 0x7FFF ) && aSig ) ) {
@@ -5724,23 +5724,23 @@ floatx80 floatx80_round_to_int(floatx80 a, float_status *status)
             if ( ( aExp == 0x3FFE ) && (uint64_t) ( extractFloatx80Frac( a )<<1 )
                ) {
                 return
-                    packFloatx80( aSign, 0x3FFF, LIT64( 0x8000000000000000 ) );
+                    packFloatx80( aSign, 0x3FFF, UINT64_C(0x8000000000000000));
             }
             break;
         case float_round_ties_away:
             if (aExp == 0x3FFE) {
-                return packFloatx80(aSign, 0x3FFF, LIT64(0x8000000000000000));
+                return packFloatx80(aSign, 0x3FFF, UINT64_C(0x8000000000000000));
             }
             break;
          case float_round_down:
             return
                   aSign ?
-                      packFloatx80( 1, 0x3FFF, LIT64( 0x8000000000000000 ) )
+                      packFloatx80( 1, 0x3FFF, UINT64_C(0x8000000000000000))
                 : packFloatx80( 0, 0, 0 );
          case float_round_up:
             return
                   aSign ? packFloatx80( 1, 0, 0 )
-                : packFloatx80( 0, 0x3FFF, LIT64( 0x8000000000000000 ) );
+                : packFloatx80( 0, 0x3FFF, UINT64_C(0x8000000000000000));
         }
         return packFloatx80( aSign, 0, 0 );
     }
@@ -5776,7 +5776,7 @@ floatx80 floatx80_round_to_int(floatx80 a, float_status *status)
     z.low &= ~ roundBitsMask;
     if ( z.low == 0 ) {
         ++z.high;
-        z.low = LIT64( 0x8000000000000000 );
+        z.low = UINT64_C(0x8000000000000000);
     }
     if (z.low != a.low) {
         status->float_exception_flags |= float_flag_inexact;
@@ -5849,7 +5849,7 @@ static floatx80 addFloatx80Sigs(floatx80 a, floatx80 b, flag zSign,
     if ( (int64_t) zSig0 < 0 ) goto roundAndPack;
  shiftRight1:
     shift64ExtraRightJamming( zSig0, zSig1, 1, &zSig0, &zSig1 );
-    zSig0 |= LIT64( 0x8000000000000000 );
+    zSig0 |= UINT64_C(0x8000000000000000);
     ++zExp;
  roundAndPack:
     return roundAndPackFloatx80(status->floatx80_rounding_precision,
@@ -6171,7 +6171,7 @@ floatx80 floatx80_rem(floatx80 a, floatx80 b, float_status *status)
         if ( (uint64_t) ( aSig0<<1 ) == 0 ) return a;
         normalizeFloatx80Subnormal( aSig0, &aExp, &aSig0 );
     }
-    bSig |= LIT64( 0x8000000000000000 );
+    bSig |= UINT64_C(0x8000000000000000);
     zSign = aSign;
     expDiff = aExp - bExp;
     aSig1 = 0;
@@ -6273,7 +6273,7 @@ floatx80 floatx80_sqrt(floatx80 a, float_status *status)
         add128( rem0, rem1, zSig0>>63, doubleZSig0 | 1, &rem0, &rem1 );
     }
     zSig1 = estimateDiv128To64( rem1, 0, doubleZSig0 );
-    if ( ( zSig1 & LIT64( 0x3FFFFFFFFFFFFFFF ) ) <= 5 ) {
+    if ( ( zSig1 & UINT64_C(0x3FFFFFFFFFFFFFFF) ) <= 5 ) {
         if ( zSig1 == 0 ) zSig1 = 1;
         mul64To128( doubleZSig0, zSig1, &term1, &term2 );
         sub128( rem1, 0, term1, term2, &rem1, &rem2 );
@@ -6572,7 +6572,7 @@ int32_t float128_to_int32(float128 a, float_status *status)
     aExp = extractFloat128Exp( a );
     aSign = extractFloat128Sign( a );
     if ( ( aExp == 0x7FFF ) && ( aSig0 | aSig1 ) ) aSign = 0;
-    if ( aExp ) aSig0 |= LIT64( 0x0001000000000000 );
+    if ( aExp ) aSig0 |= UINT64_C(0x0001000000000000);
     aSig0 |= ( aSig1 != 0 );
     shiftCount = 0x4028 - aExp;
     if ( 0 < shiftCount ) shift64RightJamming( aSig0, shiftCount, &aSig0 );
@@ -6612,7 +6612,7 @@ int32_t float128_to_int32_round_to_zero(float128 a, float_status *status)
         }
         return 0;
     }
-    aSig0 |= LIT64( 0x0001000000000000 );
+    aSig0 |= UINT64_C(0x0001000000000000);
     shiftCount = 0x402F - aExp;
     savedASig = aSig0;
     aSig0 >>= shiftCount;
@@ -6650,14 +6650,14 @@ int64_t float128_to_int64(float128 a, float_status *status)
     aSig0 = extractFloat128Frac0( a );
     aExp = extractFloat128Exp( a );
     aSign = extractFloat128Sign( a );
-    if ( aExp ) aSig0 |= LIT64( 0x0001000000000000 );
+    if ( aExp ) aSig0 |= UINT64_C(0x0001000000000000);
     shiftCount = 0x402F - aExp;
     if ( shiftCount <= 0 ) {
         if ( 0x403E < aExp ) {
             float_raise(float_flag_invalid, status);
             if (    ! aSign
                  || (    ( aExp == 0x7FFF )
-                      && ( aSig1 || ( aSig0 != LIT64( 0x0001000000000000 ) ) )
+                      && ( aSig1 || ( aSig0 != UINT64_C(0x0001000000000000) ) )
                     )
                ) {
                 return INT64_MAX;
@@ -6694,13 +6694,13 @@ int64_t float128_to_int64_round_to_zero(float128 a, float_status *status)
     aSig0 = extractFloat128Frac0( a );
     aExp = extractFloat128Exp( a );
     aSign = extractFloat128Sign( a );
-    if ( aExp ) aSig0 |= LIT64( 0x0001000000000000 );
+    if ( aExp ) aSig0 |= UINT64_C(0x0001000000000000);
     shiftCount = aExp - 0x402F;
     if ( 0 < shiftCount ) {
         if ( 0x403E <= aExp ) {
-            aSig0 &= LIT64( 0x0000FFFFFFFFFFFF );
-            if (    ( a.high == LIT64( 0xC03E000000000000 ) )
-                 && ( aSig1 < LIT64( 0x0002000000000000 ) ) ) {
+            aSig0 &= UINT64_C(0x0000FFFFFFFFFFFF);
+            if (    ( a.high == UINT64_C(0xC03E000000000000) )
+                 && ( aSig1 < UINT64_C(0x0002000000000000) ) ) {
                 if (aSig1) {
                     status->float_exception_flags |= float_flag_inexact;
                 }
@@ -6913,7 +6913,7 @@ float64 float128_to_float64(float128 a, float_status *status)
     shortShift128Left( aSig0, aSig1, 14, &aSig0, &aSig1 );
     aSig0 |= ( aSig1 != 0 );
     if ( aExp || aSig0 ) {
-        aSig0 |= LIT64( 0x4000000000000000 );
+        aSig0 |= UINT64_C(0x4000000000000000);
         aExp -= 0x3C01;
     }
     return roundAndPackFloat64(aSign, aExp, aSig0, status);
@@ -6949,7 +6949,7 @@ floatx80 float128_to_floatx80(float128 a, float_status *status)
         normalizeFloat128Subnormal( aSig0, aSig1, &aExp, &aSig0, &aSig1 );
     }
     else {
-        aSig0 |= LIT64( 0x0001000000000000 );
+        aSig0 |= UINT64_C(0x0001000000000000);
     }
     shortShift128Left( aSig0, aSig1, 15, &aSig0, &aSig1 );
     return roundAndPackFloatx80(80, aSign, aExp, aSig0, aSig1, status);
@@ -7145,7 +7145,7 @@ static float128 addFloat128Sigs(float128 a, float128 b, flag zSign,
             --expDiff;
         }
         else {
-            bSig0 |= LIT64( 0x0001000000000000 );
+            bSig0 |= UINT64_C(0x0001000000000000);
         }
         shift128ExtraRightJamming(
             bSig0, bSig1, 0, expDiff, &bSig0, &bSig1, &zSig2 );
@@ -7162,7 +7162,7 @@ static float128 addFloat128Sigs(float128 a, float128 b, flag zSign,
             ++expDiff;
         }
         else {
-            aSig0 |= LIT64( 0x0001000000000000 );
+            aSig0 |= UINT64_C(0x0001000000000000);
         }
         shift128ExtraRightJamming(
             aSig0, aSig1, 0, - expDiff, &aSig0, &aSig1, &zSig2 );
@@ -7186,14 +7186,14 @@ static float128 addFloat128Sigs(float128 a, float128 b, flag zSign,
             return packFloat128( zSign, 0, zSig0, zSig1 );
         }
         zSig2 = 0;
-        zSig0 |= LIT64( 0x0002000000000000 );
+        zSig0 |= UINT64_C(0x0002000000000000);
         zExp = aExp;
         goto shiftRight1;
     }
-    aSig0 |= LIT64( 0x0001000000000000 );
+    aSig0 |= UINT64_C(0x0001000000000000);
     add128( aSig0, aSig1, bSig0, bSig1, &zSig0, &zSig1 );
     --zExp;
-    if ( zSig0 < LIT64( 0x0002000000000000 ) ) goto roundAndPack;
+    if ( zSig0 < UINT64_C(0x0002000000000000) ) goto roundAndPack;
     ++zExp;
  shiftRight1:
     shift128ExtraRightJamming(
@@ -7257,10 +7257,10 @@ static float128 subFloat128Sigs(float128 a, float128 b, flag zSign,
         ++expDiff;
     }
     else {
-        aSig0 |= LIT64( 0x4000000000000000 );
+        aSig0 |= UINT64_C(0x4000000000000000);
     }
     shift128RightJamming( aSig0, aSig1, - expDiff, &aSig0, &aSig1 );
-    bSig0 |= LIT64( 0x4000000000000000 );
+    bSig0 |= UINT64_C(0x4000000000000000);
  bBigger:
     sub128( bSig0, bSig1, aSig0, aSig1, &zSig0, &zSig1 );
     zExp = bExp;
@@ -7277,10 +7277,10 @@ static float128 subFloat128Sigs(float128 a, float128 b, flag zSign,
         --expDiff;
     }
     else {
-        bSig0 |= LIT64( 0x4000000000000000 );
+        bSig0 |= UINT64_C(0x4000000000000000);
     }
     shift128RightJamming( bSig0, bSig1, expDiff, &bSig0, &bSig1 );
-    aSig0 |= LIT64( 0x4000000000000000 );
+    aSig0 |= UINT64_C(0x4000000000000000);
  aBigger:
     sub128( aSig0, aSig1, bSig0, bSig1, &zSig0, &zSig1 );
     zExp = aExp;
@@ -7382,12 +7382,12 @@ float128 float128_mul(float128 a, float128 b, float_status *status)
         normalizeFloat128Subnormal( bSig0, bSig1, &bExp, &bSig0, &bSig1 );
     }
     zExp = aExp + bExp - 0x4000;
-    aSig0 |= LIT64( 0x0001000000000000 );
+    aSig0 |= UINT64_C(0x0001000000000000);
     shortShift128Left( bSig0, bSig1, 16, &bSig0, &bSig1 );
     mul128To256( aSig0, aSig1, bSig0, bSig1, &zSig0, &zSig1, &zSig2, &zSig3 );
     add128( zSig0, zSig1, aSig0, aSig1, &zSig0, &zSig1 );
     zSig2 |= ( zSig3 != 0 );
-    if ( LIT64( 0x0002000000000000 ) <= zSig0 ) {
+    if (UINT64_C( 0x0002000000000000) <= zSig0 ) {
         shift128ExtraRightJamming(
             zSig0, zSig1, zSig2, 1, &zSig0, &zSig1, &zSig2 );
         ++zExp;
@@ -7454,9 +7454,9 @@ float128 float128_div(float128 a, float128 b, float_status *status)
     }
     zExp = aExp - bExp + 0x3FFD;
     shortShift128Left(
-        aSig0 | LIT64( 0x0001000000000000 ), aSig1, 15, &aSig0, &aSig1 );
+        aSig0 | UINT64_C(0x0001000000000000), aSig1, 15, &aSig0, &aSig1 );
     shortShift128Left(
-        bSig0 | LIT64( 0x0001000000000000 ), bSig1, 15, &bSig0, &bSig1 );
+        bSig0 | UINT64_C(0x0001000000000000), bSig1, 15, &bSig0, &bSig1 );
     if ( le128( bSig0, bSig1, aSig0, aSig1 ) ) {
         shift128Right( aSig0, aSig1, 1, &aSig0, &aSig1 );
         ++zExp;
@@ -7532,14 +7532,14 @@ float128 float128_rem(float128 a, float128 b, float_status *status)
     expDiff = aExp - bExp;
     if ( expDiff < -1 ) return a;
     shortShift128Left(
-        aSig0 | LIT64( 0x0001000000000000 ),
+        aSig0 | UINT64_C(0x0001000000000000),
         aSig1,
         15 - ( expDiff < 0 ),
         &aSig0,
         &aSig1
     );
     shortShift128Left(
-        bSig0 | LIT64( 0x0001000000000000 ), bSig1, 15, &bSig0, &bSig1 );
+        bSig0 | UINT64_C(0x0001000000000000), bSig1, 15, &bSig0, &bSig1 );
     q = le128( bSig0, bSig1, aSig0, aSig1 );
     if ( q ) sub128( aSig0, aSig1, bSig0, bSig1, &aSig0, &aSig1 );
     expDiff -= 64;
@@ -7625,7 +7625,7 @@ float128 float128_sqrt(float128 a, float_status *status)
         normalizeFloat128Subnormal( aSig0, aSig1, &aExp, &aSig0, &aSig1 );
     }
     zExp = ( ( aExp - 0x3FFF )>>1 ) + 0x3FFE;
-    aSig0 |= LIT64( 0x0001000000000000 );
+    aSig0 |= UINT64_C(0x0001000000000000);
     zSig0 = estimateSqrt32( aExp, aSig0>>17 );
     shortShift128Left( aSig0, aSig1, 13 - ( aExp & 1 ), &aSig0, &aSig1 );
     zSig0 = estimateDiv128To64( aSig0, aSig1, zSig0<<32 ) + ( zSig0<<30 );
@@ -8046,7 +8046,7 @@ float128 float128_scalbn(float128 a, int n, float_status *status)
         return a;
     }
     if (aExp != 0) {
-        aSig0 |= LIT64( 0x0001000000000000 );
+        aSig0 |= UINT64_C(0x0001000000000000);
     } else if (aSig0 == 0 && aSig1 == 0) {
         return a;
     } else {
diff --git a/include/fpu/softfloat-macros.h b/include/fpu/softfloat-macros.h
index c55aa6d1742..9a1d254a95b 100644
--- a/include/fpu/softfloat-macros.h
+++ b/include/fpu/softfloat-macros.h
@@ -616,13 +616,13 @@ static inline uint64_t estimateDiv128To64(uint64_t a0, uint64_t a1, uint64_t b)
     uint64_t rem0, rem1, term0, term1;
     uint64_t z;
 
-    if ( b <= a0 ) return LIT64( 0xFFFFFFFFFFFFFFFF );
+    if ( b <= a0 ) return UINT64_C(0xFFFFFFFFFFFFFFFF);
     b0 = b>>32;
-    z = ( b0<<32 <= a0 ) ? LIT64( 0xFFFFFFFF00000000 ) : ( a0 / b0 )<<32;
+    z = ( b0<<32 <= a0 ) ? UINT64_C(0xFFFFFFFF00000000) : ( a0 / b0 )<<32;
     mul64To128( b, z, &term0, &term1 );
     sub128( a0, a1, term0, term1, &rem0, &rem1 );
     while ( ( (int64_t) rem0 ) < 0 ) {
-        z -= LIT64( 0x100000000 );
+        z -= UINT64_C(0x100000000);
         b1 = b<<32;
         add128( rem0, rem1, b0, b1, &rem0, &rem1 );
     }
-- 
2.20.1



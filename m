Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82329C3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 12:54:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 367A120851
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 12:54:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LUg3Knjx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 367A120851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzhAo-0005dy-QL
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 08:54:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37947)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1hzgbS-0003Bg-0b
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 08:17:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hzgbG-0007H4-FQ
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 08:17:31 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:35121)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hzgbE-00079E-4G
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 08:17:24 -0400
Received: by mail-wm1-x331.google.com with SMTP id l2so1417186wmg.0
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 05:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=94JkIX95m9OxCbqrnIqjjMCyjUTwjXOMbVGxMOTVgvQ=;
 b=LUg3KnjxYxWF5fPL/y7rE3BH4r/NFrEXhRm1QPlzG3XBVUCMge2V5BXzfNJoLIsCmM
 6A6RVE5nsi4p3XFsm8DpropDO93MHXschY+U4F91RY+w/NJ+JIsaKUHzuLQeHV4A6PUy
 iwpYVTHum0tnrnvJOKgX1OsiCLjliSdqC1Wo4e3zy9N9x+mwabDF7OfXkTkYaccJDP1q
 LwiBfT8AVYX0PUB2ilITIHaUaSC/cJ4yLrcNjxOfSaDglVhDCNkUBKT1K+OOvywFXPEd
 jN4x4VSqRg/QhZavYrSS5P4ARu8Q5GZpyggucwNuN5PzaxSnXLEqMsmKJOI7u5mtnUvt
 jOmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=94JkIX95m9OxCbqrnIqjjMCyjUTwjXOMbVGxMOTVgvQ=;
 b=Ypy8Z2IoLR7/BXgxlwoN70gOKlcyYWPFF3s2JmmevxQ5Ax3T1W0MZNryloIXZSL9Ri
 FPzzBdPPJcF8Vi72H3URTYTlVLV5mpaano3G108Whgu/4AQzFkBH3VntqX3tXhO+UGeK
 iSxZgWQwLi8khSbZ/ZLA3WRxy03JpwUKgMPicKtWK7UP7fd4wa6EU8Q/8pXDvn/3qAHf
 rTtqFE0RWnymS577baGNTjVkcorDYDBa9SfhEfGTCLQ91NslBIXntn0S9lAZtdpcdoA/
 //C6Rngw3fnfycBHfMpFAinKD+K/OYNAHmISkZ5awy9aaYQf/B5uonVqpEF73bkLSyEO
 GRbw==
X-Gm-Message-State: APjAAAWt3tTamBg/dNU4oM9EsegIA8Z//HCilWb4p7mWDWV7wlDuo1An
 bwVRQ33CIg/9pSC0sEM2lkbYUA==
X-Google-Smtp-Source: APXvYqzZg0IJa/fViUDgnr2+EKR61z/MZDC6gk01gtvir3wrM/SnltqUfaucGumkF9VXxXosw291PQ==
X-Received: by 2002:a1c:ca09:: with SMTP id a9mr19681949wmg.43.1566217035150; 
 Mon, 19 Aug 2019 05:17:15 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id p186sm12109896wme.9.2019.08.19.05.17.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2019 05:17:12 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 5B6FE1FF92;
 Mon, 19 Aug 2019 13:17:10 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Mon, 19 Aug 2019 13:17:02 +0100
Message-Id: <20190819121709.31597-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190819121709.31597-1-alex.bennee@linaro.org>
References: <20190819121709.31597-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::331
Subject: [Qemu-devel] [PULL 05/12] target/m68k: replace LIT64 with UINT64_C
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In our quest to eliminate the home rolled LIT64 macro we fixup usage
inside for m68k's many constants.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

diff --git a/target/m68k/softfloat.c b/target/m68k/softfloat.c
index 591a6f1dcec..24c313ed690 100644
--- a/target/m68k/softfloat.c
+++ b/target/m68k/softfloat.c
@@ -26,7 +26,7 @@
 
 #define pi_exp      0x4000
 #define piby2_exp   0x3FFF
-#define pi_sig      LIT64(0xc90fdaa22168c235)
+#define pi_sig      UINT64_C(0xc90fdaa22168c235)
 
 static floatx80 propagateFloatx80NaNOneArg(floatx80 a, float_status *status)
 {
@@ -87,7 +87,7 @@ floatx80 floatx80_mod(floatx80 a, floatx80 b, float_status *status)
         }
         normalizeFloatx80Subnormal(aSig0, &aExp, &aSig0);
     }
-    bSig |= LIT64(0x8000000000000000);
+    bSig |= UINT64_C(0x8000000000000000);
     zSign = aSign;
     expDiff = aExp - bExp;
     aSig1 = 0;
@@ -289,7 +289,7 @@ floatx80 floatx80_move(floatx80 a, float_status *status)
  */
 
 #define one_exp     0x3FFF
-#define one_sig     LIT64(0x8000000000000000)
+#define one_sig     UINT64_C(0x8000000000000000)
 
 /*
  * Function for compactifying extended double-precision floating point values.
@@ -373,7 +373,7 @@ floatx80 floatx80_lognp1(floatx80 a, float_status *status)
         k = aExp - 0x3FFF;
         fp1 = int32_to_floatx80(k, status);
 
-        fSig = (aSig & LIT64(0xFE00000000000000)) | LIT64(0x0100000000000000);
+        fSig = (aSig & UINT64_C(0xFE00000000000000)) | UINT64_C(0x0100000000000000);
         j = (fSig >> 56) & 0x7E; /* DISPLACEMENT FOR 1/F */
 
         f = packFloatx80(0, 0x3FFF, fSig); /* F */
@@ -384,7 +384,7 @@ floatx80 floatx80_lognp1(floatx80 a, float_status *status)
     lp1cont1:
         /* LP1CONT1 */
         fp0 = floatx80_mul(fp0, log_tbl[j], status); /* FP0 IS U = (Y-F)/F */
-        logof2 = packFloatx80(0, 0x3FFE, LIT64(0xB17217F7D1CF79AC));
+        logof2 = packFloatx80(0, 0x3FFE, UINT64_C(0xB17217F7D1CF79AC));
         klog2 = floatx80_mul(fp1, logof2, status); /* FP1 IS K*LOG2 */
         fp2 = floatx80_mul(fp0, fp0, status); /* FP2 IS V=U*U */
 
@@ -431,7 +431,7 @@ floatx80 floatx80_lognp1(floatx80 a, float_status *status)
     } else if (compact < 0x3FFEF07D || compact > 0x3FFF8841) {
         /* |X| < 1/16 or |X| > -1/16 */
         /* LP1CARE */
-        fSig = (aSig & LIT64(0xFE00000000000000)) | LIT64(0x0100000000000000);
+        fSig = (aSig & UINT64_C(0xFE00000000000000)) | UINT64_C(0x0100000000000000);
         f = packFloatx80(0, 0x3FFF, fSig); /* F */
         j = (fSig >> 56) & 0x7E; /* DISPLACEMENT FOR 1/F */
 
@@ -562,7 +562,7 @@ floatx80 floatx80_logn(floatx80 a, float_status *status)
         k += adjk;
         fp1 = int32_to_floatx80(k, status);
 
-        fSig = (aSig & LIT64(0xFE00000000000000)) | LIT64(0x0100000000000000);
+        fSig = (aSig & UINT64_C(0xFE00000000000000)) | UINT64_C(0x0100000000000000);
         j = (fSig >> 56) & 0x7E; /* DISPLACEMENT FOR 1/F */
 
         f = packFloatx80(0, 0x3FFF, fSig); /* F */
@@ -572,7 +572,7 @@ floatx80 floatx80_logn(floatx80 a, float_status *status)
 
         /* LP1CONT1 */
         fp0 = floatx80_mul(fp0, log_tbl[j], status); /* FP0 IS U = (Y-F)/F */
-        logof2 = packFloatx80(0, 0x3FFE, LIT64(0xB17217F7D1CF79AC));
+        logof2 = packFloatx80(0, 0x3FFE, UINT64_C(0xB17217F7D1CF79AC));
         klog2 = floatx80_mul(fp1, logof2, status); /* FP1 IS K*LOG2 */
         fp2 = floatx80_mul(fp0, fp0, status); /* FP2 IS V=U*U */
 
@@ -712,7 +712,7 @@ floatx80 floatx80_log10(floatx80 a, float_status *status)
     status->floatx80_rounding_precision = 80;
 
     fp0 = floatx80_logn(a, status);
-    fp1 = packFloatx80(0, 0x3FFD, LIT64(0xDE5BD8A937287195)); /* INV_L10 */
+    fp1 = packFloatx80(0, 0x3FFD, UINT64_C(0xDE5BD8A937287195)); /* INV_L10 */
 
     status->float_rounding_mode = user_rnd_mode;
     status->floatx80_rounding_precision = user_rnd_prec;
@@ -778,7 +778,7 @@ floatx80 floatx80_log2(floatx80 a, float_status *status)
         a = int32_to_floatx80(aExp - 0x3FFF, status);
     } else {
         fp0 = floatx80_logn(a, status);
-        fp1 = packFloatx80(0, 0x3FFF, LIT64(0xB8AA3B295C17F0BC)); /* INV_L2 */
+        fp1 = packFloatx80(0, 0x3FFF, UINT64_C(0xB8AA3B295C17F0BC)); /* INV_L2 */
 
         status->float_rounding_mode = user_rnd_mode;
         status->floatx80_rounding_precision = user_rnd_prec;
@@ -862,7 +862,7 @@ floatx80 floatx80_etox(floatx80 a, float_status *status)
             fp0 = floatx80_mul(fp0, float32_to_floatx80(
                                make_float32(0xBC317218), status),
                                status); /* N * L1, L1 = lead(-log2/64) */
-            l2 = packFloatx80(0, 0x3FDC, LIT64(0x82E308654361C4C6));
+            l2 = packFloatx80(0, 0x3FDC, UINT64_C(0x82E308654361C4C6));
             fp2 = floatx80_mul(fp2, l2, status); /* N * L2, L1+L2 = -log2/64 */
             fp0 = floatx80_add(fp0, fp1, status); /* X + N*L1 */
             fp0 = floatx80_add(fp0, fp2, status); /* R */
@@ -1082,7 +1082,7 @@ floatx80 floatx80_twotox(floatx80 a, float_status *status)
                            make_float32(0x3C800000), status),
                            status); /* (1/64)*N */
         fp0 = floatx80_sub(fp0, fp1, status); /* X - (1/64)*INT(64 X) */
-        fp2 = packFloatx80(0, 0x3FFE, LIT64(0xB17217F7D1CF79AC)); /* LOG2 */
+        fp2 = packFloatx80(0, 0x3FFE, UINT64_C(0xB17217F7D1CF79AC)); /* LOG2 */
         fp0 = floatx80_mul(fp0, fp2, status); /* R */
 
         /* EXPR */
@@ -1233,11 +1233,11 @@ floatx80 floatx80_tentox(floatx80 a, float_status *status)
         fp1 = floatx80_mul(fp1, float64_to_floatx80(
                            make_float64(0x3F734413509F8000), status),
                            status); /* N*(LOG2/64LOG10)_LEAD */
-        fp3 = packFloatx80(1, 0x3FCD, LIT64(0xC0219DC1DA994FD2));
+        fp3 = packFloatx80(1, 0x3FCD, UINT64_C(0xC0219DC1DA994FD2));
         fp2 = floatx80_mul(fp2, fp3, status); /* N*(LOG2/64LOG10)_TRAIL */
         fp0 = floatx80_sub(fp0, fp1, status); /* X - N L_LEAD */
         fp0 = floatx80_sub(fp0, fp2, status); /* X - N L_TRAIL */
-        fp2 = packFloatx80(0, 0x4000, LIT64(0x935D8DDDAAA8AC17)); /* LOG10 */
+        fp2 = packFloatx80(0, 0x4000, UINT64_C(0x935D8DDDAAA8AC17)); /* LOG10 */
         fp0 = floatx80_mul(fp0, fp2, status); /* R */
 
         /* EXPR */
@@ -1329,9 +1329,9 @@ floatx80 floatx80_tan(floatx80 a, float_status *status)
             fp1 = packFloatx80(0, 0, 0);
             if (compact == 0x7FFEFFFF) {
                 twopi1 = packFloatx80(aSign ^ 1, 0x7FFE,
-                                      LIT64(0xC90FDAA200000000));
+                                      UINT64_C(0xC90FDAA200000000));
                 twopi2 = packFloatx80(aSign ^ 1, 0x7FDC,
-                                      LIT64(0x85A308D300000000));
+                                      UINT64_C(0x85A308D300000000));
                 fp0 = floatx80_add(fp0, twopi1, status);
                 fp1 = fp0;
                 fp0 = floatx80_add(fp0, twopi2, status);
@@ -1350,9 +1350,9 @@ floatx80 floatx80_tan(floatx80 a, float_status *status)
                 endflag = 0;
             }
             invtwopi = packFloatx80(0, 0x3FFE - l,
-                                    LIT64(0xA2F9836E4E44152A)); /* INVTWOPI */
-            twopi1 = packFloatx80(0, 0x3FFF + l, LIT64(0xC90FDAA200000000));
-            twopi2 = packFloatx80(0, 0x3FDD + l, LIT64(0x85A308D300000000));
+                                    UINT64_C(0xA2F9836E4E44152A)); /* INVTWOPI */
+            twopi1 = packFloatx80(0, 0x3FFF + l, UINT64_C(0xC90FDAA200000000));
+            twopi2 = packFloatx80(0, 0x3FDD + l, UINT64_C(0x85A308D300000000));
 
             /* SIGN(INARG)*2^63 IN SGL */
             twoto63 = packFloat32(xSign, 0xBE, 0);
@@ -1415,17 +1415,17 @@ floatx80 floatx80_tan(floatx80 a, float_status *status)
             fp3 = floatx80_add(fp3, float64_to_floatx80(
                                make_float64(0xBF346F59B39BA65F), status),
                                status); /* Q3+SQ4 */
-            fp4 = packFloatx80(0, 0x3FF6, LIT64(0xE073D3FC199C4A00));
+            fp4 = packFloatx80(0, 0x3FF6, UINT64_C(0xE073D3FC199C4A00));
             fp2 = floatx80_add(fp2, fp4, status); /* P2+SP3 */
             fp3 = floatx80_mul(fp3, fp0, status); /* S(Q3+SQ4) */
             fp2 = floatx80_mul(fp2, fp0, status); /* S(P2+SP3) */
-            fp4 = packFloatx80(0, 0x3FF9, LIT64(0xD23CD68415D95FA1));
+            fp4 = packFloatx80(0, 0x3FF9, UINT64_C(0xD23CD68415D95FA1));
             fp3 = floatx80_add(fp3, fp4, status); /* Q2+S(Q3+SQ4) */
-            fp4 = packFloatx80(1, 0x3FFC, LIT64(0x8895A6C5FB423BCA));
+            fp4 = packFloatx80(1, 0x3FFC, UINT64_C(0x8895A6C5FB423BCA));
             fp2 = floatx80_add(fp2, fp4, status); /* P1+S(P2+SP3) */
             fp3 = floatx80_mul(fp3, fp0, status); /* S(Q2+S(Q3+SQ4)) */
             fp2 = floatx80_mul(fp2, fp0, status); /* S(P1+S(P2+SP3)) */
-            fp4 = packFloatx80(1, 0x3FFD, LIT64(0xEEF57E0DA84BC8CE));
+            fp4 = packFloatx80(1, 0x3FFD, UINT64_C(0xEEF57E0DA84BC8CE));
             fp3 = floatx80_add(fp3, fp4, status); /* Q1+S(Q2+S(Q3+SQ4)) */
             fp2 = floatx80_mul(fp2, fp1, status); /* RS(P1+S(P2+SP3)) */
             fp0 = floatx80_mul(fp0, fp3, status); /* S(Q1+S(Q2+S(Q3+SQ4))) */
@@ -1459,17 +1459,17 @@ floatx80 floatx80_tan(floatx80 a, float_status *status)
             fp3 = floatx80_add(fp3, float64_to_floatx80(
                                make_float64(0xBF346F59B39BA65F), status),
                                status); /* Q3+SQ4 */
-            fp4 = packFloatx80(0, 0x3FF6, LIT64(0xE073D3FC199C4A00));
+            fp4 = packFloatx80(0, 0x3FF6, UINT64_C(0xE073D3FC199C4A00));
             fp2 = floatx80_add(fp2, fp4, status); /* P2+SP3 */
             fp3 = floatx80_mul(fp3, fp1, status); /* S(Q3+SQ4) */
             fp2 = floatx80_mul(fp2, fp1, status); /* S(P2+SP3) */
-            fp4 = packFloatx80(0, 0x3FF9, LIT64(0xD23CD68415D95FA1));
+            fp4 = packFloatx80(0, 0x3FF9, UINT64_C(0xD23CD68415D95FA1));
             fp3 = floatx80_add(fp3, fp4, status); /* Q2+S(Q3+SQ4) */
-            fp4 = packFloatx80(1, 0x3FFC, LIT64(0x8895A6C5FB423BCA));
+            fp4 = packFloatx80(1, 0x3FFC, UINT64_C(0x8895A6C5FB423BCA));
             fp2 = floatx80_add(fp2, fp4, status); /* P1+S(P2+SP3) */
             fp3 = floatx80_mul(fp3, fp1, status); /* S(Q2+S(Q3+SQ4)) */
             fp2 = floatx80_mul(fp2, fp1, status); /* S(P1+S(P2+SP3)) */
-            fp4 = packFloatx80(1, 0x3FFD, LIT64(0xEEF57E0DA84BC8CE));
+            fp4 = packFloatx80(1, 0x3FFD, UINT64_C(0xEEF57E0DA84BC8CE));
             fp3 = floatx80_add(fp3, fp4, status); /* Q1+S(Q2+S(Q3+SQ4)) */
             fp2 = floatx80_mul(fp2, fp0, status); /* RS(P1+S(P2+SP3)) */
             fp1 = floatx80_mul(fp1, fp3, status); /* S(Q1+S(Q2+S(Q3+SQ4))) */
@@ -1539,9 +1539,9 @@ floatx80 floatx80_sin(floatx80 a, float_status *status)
             fp1 = packFloatx80(0, 0, 0);
             if (compact == 0x7FFEFFFF) {
                 twopi1 = packFloatx80(aSign ^ 1, 0x7FFE,
-                                      LIT64(0xC90FDAA200000000));
+                                      UINT64_C(0xC90FDAA200000000));
                 twopi2 = packFloatx80(aSign ^ 1, 0x7FDC,
-                                      LIT64(0x85A308D300000000));
+                                      UINT64_C(0x85A308D300000000));
                 fp0 = floatx80_add(fp0, twopi1, status);
                 fp1 = fp0;
                 fp0 = floatx80_add(fp0, twopi2, status);
@@ -1560,9 +1560,9 @@ floatx80 floatx80_sin(floatx80 a, float_status *status)
                 endflag = 0;
             }
             invtwopi = packFloatx80(0, 0x3FFE - l,
-                                    LIT64(0xA2F9836E4E44152A)); /* INVTWOPI */
-            twopi1 = packFloatx80(0, 0x3FFF + l, LIT64(0xC90FDAA200000000));
-            twopi2 = packFloatx80(0, 0x3FDD + l, LIT64(0x85A308D300000000));
+                                    UINT64_C(0xA2F9836E4E44152A)); /* INVTWOPI */
+            twopi1 = packFloatx80(0, 0x3FFF + l, UINT64_C(0xC90FDAA200000000));
+            twopi2 = packFloatx80(0, 0x3FDD + l, UINT64_C(0x85A308D300000000));
 
             /* SIGN(INARG)*2^63 IN SGL */
             twoto63 = packFloat32(xSign, 0xBE, 0);
@@ -1650,11 +1650,11 @@ floatx80 floatx80_sin(floatx80 a, float_status *status)
             fp2 = floatx80_add(fp2, float64_to_floatx80(
                                make_float64(0x3EFA01A01A01D423), status),
                                status); /* B4+T(B6+TB8) */
-            fp4 = packFloatx80(1, 0x3FF5, LIT64(0xB60B60B60B61D438));
+            fp4 = packFloatx80(1, 0x3FF5, UINT64_C(0xB60B60B60B61D438));
             fp3 = floatx80_add(fp3, fp4, status); /* B3+T(B5+TB7) */
             fp2 = floatx80_mul(fp2, fp1, status); /* T(B4+T(B6+TB8)) */
             fp1 = floatx80_mul(fp1, fp3, status); /* T(B3+T(B5+TB7)) */
-            fp4 = packFloatx80(0, 0x3FFA, LIT64(0xAAAAAAAAAAAAAB5E));
+            fp4 = packFloatx80(0, 0x3FFA, UINT64_C(0xAAAAAAAAAAAAAB5E));
             fp2 = floatx80_add(fp2, fp4, status); /* B2+T(B4+T(B6+TB8)) */
             fp1 = floatx80_add(fp1, float32_to_floatx80(
                                make_float32(0xBF000000), status),
@@ -1702,11 +1702,11 @@ floatx80 floatx80_sin(floatx80 a, float_status *status)
             fp3 = floatx80_add(fp3, float64_to_floatx80(
                                make_float64(0xBF2A01A01A018B59), status),
                                status); /* A3+T(A5+TA7) */
-            fp4 = packFloatx80(0, 0x3FF8, LIT64(0x88888888888859AF));
+            fp4 = packFloatx80(0, 0x3FF8, UINT64_C(0x88888888888859AF));
             fp2 = floatx80_add(fp2, fp4, status); /* A2+T(A4+TA6) */
             fp1 = floatx80_mul(fp1, fp3, status); /* T(A3+T(A5+TA7)) */
             fp2 = floatx80_mul(fp2, fp0, status); /* S(A2+T(A4+TA6)) */
-            fp4 = packFloatx80(1, 0x3FFC, LIT64(0xAAAAAAAAAAAAAA99));
+            fp4 = packFloatx80(1, 0x3FFC, UINT64_C(0xAAAAAAAAAAAAAA99));
             fp1 = floatx80_add(fp1, fp4, status); /* A1+T(A3+T(A5+TA7)) */
             fp1 = floatx80_add(fp1, fp2,
                                status); /* [A1+T(A3+T(A5+TA7))]+
@@ -1778,9 +1778,9 @@ floatx80 floatx80_cos(floatx80 a, float_status *status)
             fp1 = packFloatx80(0, 0, 0);
             if (compact == 0x7FFEFFFF) {
                 twopi1 = packFloatx80(aSign ^ 1, 0x7FFE,
-                                      LIT64(0xC90FDAA200000000));
+                                      UINT64_C(0xC90FDAA200000000));
                 twopi2 = packFloatx80(aSign ^ 1, 0x7FDC,
-                                      LIT64(0x85A308D300000000));
+                                      UINT64_C(0x85A308D300000000));
                 fp0 = floatx80_add(fp0, twopi1, status);
                 fp1 = fp0;
                 fp0 = floatx80_add(fp0, twopi2, status);
@@ -1799,9 +1799,9 @@ floatx80 floatx80_cos(floatx80 a, float_status *status)
                 endflag = 0;
             }
             invtwopi = packFloatx80(0, 0x3FFE - l,
-                                    LIT64(0xA2F9836E4E44152A)); /* INVTWOPI */
-            twopi1 = packFloatx80(0, 0x3FFF + l, LIT64(0xC90FDAA200000000));
-            twopi2 = packFloatx80(0, 0x3FDD + l, LIT64(0x85A308D300000000));
+                                    UINT64_C(0xA2F9836E4E44152A)); /* INVTWOPI */
+            twopi1 = packFloatx80(0, 0x3FFF + l, UINT64_C(0xC90FDAA200000000));
+            twopi2 = packFloatx80(0, 0x3FDD + l, UINT64_C(0x85A308D300000000));
 
             /* SIGN(INARG)*2^63 IN SGL */
             twoto63 = packFloat32(xSign, 0xBE, 0);
@@ -1890,11 +1890,11 @@ floatx80 floatx80_cos(floatx80 a, float_status *status)
             fp2 = floatx80_add(fp2, float64_to_floatx80(
                                make_float64(0x3EFA01A01A01D423), status),
                                status); /* B4+T(B6+TB8) */
-            fp4 = packFloatx80(1, 0x3FF5, LIT64(0xB60B60B60B61D438));
+            fp4 = packFloatx80(1, 0x3FF5, UINT64_C(0xB60B60B60B61D438));
             fp3 = floatx80_add(fp3, fp4, status); /* B3+T(B5+TB7) */
             fp2 = floatx80_mul(fp2, fp1, status); /* T(B4+T(B6+TB8)) */
             fp1 = floatx80_mul(fp1, fp3, status); /* T(B3+T(B5+TB7)) */
-            fp4 = packFloatx80(0, 0x3FFA, LIT64(0xAAAAAAAAAAAAAB5E));
+            fp4 = packFloatx80(0, 0x3FFA, UINT64_C(0xAAAAAAAAAAAAAB5E));
             fp2 = floatx80_add(fp2, fp4, status); /* B2+T(B4+T(B6+TB8)) */
             fp1 = floatx80_add(fp1, float32_to_floatx80(
                                make_float32(0xBF000000), status),
@@ -1941,11 +1941,11 @@ floatx80 floatx80_cos(floatx80 a, float_status *status)
             fp3 = floatx80_add(fp3, float64_to_floatx80(
                                make_float64(0xBF2A01A01A018B59), status),
                                status); /* A3+T(A5+TA7) */
-            fp4 = packFloatx80(0, 0x3FF8, LIT64(0x88888888888859AF));
+            fp4 = packFloatx80(0, 0x3FF8, UINT64_C(0x88888888888859AF));
             fp2 = floatx80_add(fp2, fp4, status); /* A2+T(A4+TA6) */
             fp1 = floatx80_mul(fp1, fp3, status); /* T(A3+T(A5+TA7)) */
             fp2 = floatx80_mul(fp2, fp0, status); /* S(A2+T(A4+TA6)) */
-            fp4 = packFloatx80(1, 0x3FFC, LIT64(0xAAAAAAAAAAAAAA99));
+            fp4 = packFloatx80(1, 0x3FFC, UINT64_C(0xAAAAAAAAAAAAAA99));
             fp1 = floatx80_add(fp1, fp4, status); /* A1+T(A3+T(A5+TA7)) */
             fp1 = floatx80_add(fp1, fp2, status);
                                     /* [A1+T(A3+T(A5+TA7))]+[S(A2+T(A4+TA6))] */
@@ -2114,8 +2114,8 @@ floatx80 floatx80_atan(floatx80 a, float_status *status)
             }
         }
     } else {
-        aSig &= LIT64(0xF800000000000000);
-        aSig |= LIT64(0x0400000000000000);
+        aSig &= UINT64_C(0xF800000000000000);
+        aSig |= UINT64_C(0x0400000000000000);
         xsave = packFloatx80(aSign, aExp, aSig); /* F */
         fp0 = a;
         fp1 = a; /* X */
@@ -2430,7 +2430,7 @@ floatx80 floatx80_etoxm1(floatx80 a, float_status *status)
             fp0 = floatx80_mul(fp0, float32_to_floatx80(
                                make_float32(0xBC317218), status),
                                status); /* N * L1, L1 = lead(-log2/64) */
-            l2 = packFloatx80(0, 0x3FDC, LIT64(0x82E308654361C4C6));
+            l2 = packFloatx80(0, 0x3FDC, UINT64_C(0x82E308654361C4C6));
             fp2 = floatx80_mul(fp2, l2, status); /* N * L2, L1+L2 = -log2/64 */
             fp0 = floatx80_add(fp0, fp1, status); /* X + N*L1 */
             fp0 = floatx80_add(fp0, fp2, status); /* R */
@@ -2562,7 +2562,7 @@ floatx80 floatx80_etoxm1(floatx80 a, float_status *status)
             fp2 = floatx80_add(fp2, float64_to_floatx80(
                                make_float64(0x3FA5555555555555), status),
                                status); /* B3 */
-            fp3 = packFloatx80(0, 0x3FFC, LIT64(0xAAAAAAAAAAAAAAAB));
+            fp3 = packFloatx80(0, 0x3FFC, UINT64_C(0xAAAAAAAAAAAAAAAB));
             fp1 = floatx80_add(fp1, fp3, status); /* B2 */
             fp2 = floatx80_mul(fp2, fp0, status);
             fp1 = floatx80_mul(fp1, fp0, status);
-- 
2.20.1



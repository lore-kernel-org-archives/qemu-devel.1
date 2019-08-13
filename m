Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 361D1C32750
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 12:54:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E495B206C2
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 12:54:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MPIruIxj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E495B206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxWKE-0002IE-7B
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 08:54:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53597)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hxWFO-0002Mg-Sa
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 08:49:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hxWFM-0000gf-Gh
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 08:49:54 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:33751)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hxWFM-0000fW-7c
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 08:49:52 -0400
Received: by mail-wm1-x344.google.com with SMTP id p77so1010318wme.0
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2019 05:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=uKFfYLwGDxkhF+x/WRYO18ExbbxVDbTux4XTAAdRgok=;
 b=MPIruIxjNhSBkrD2J0poFO+E5+0gKerwPaOXVjswltq6aMawrhnZ0BkZmr5mtLz++z
 c1xUo2aSxs0XdeMntOdv+RWi1s9KqGdH48Tor4lyQMl4g7qb3Egl+jyUtstkrBYKx2Sf
 xXKJNOLbcWgXI4WGWpkBUBqqdh9Ll7RNxsFimpdUo3FqnqJNVuO5ykq5haLVsYns4HEQ
 bFrDV50BIpmjai4tzjfwOEU/67JuiiJNYPCaB2GCO+WRS/7VK4I9d5/1NeZfwIBg1Kc/
 c/gaLd387orICz5QpXYWKKwsfB7ynKeuqS8WH8LIGjJ6Z/KZIs0nGFxpuP7GXUcFti3S
 cx4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uKFfYLwGDxkhF+x/WRYO18ExbbxVDbTux4XTAAdRgok=;
 b=HhoHVDXpqKwOYkAY+SJ5WKV7C/xnTjgTkni3JkgOtFtltfzzPG+KE7WGCKNPzDplGK
 eLr+BTQLdv6yMV0f4IbB0poKMwhEkkvv8Zs7/6Hc6hMejqiAwOEeWZ1swFwyv9m+Mcwc
 hUO1AooQD+Fup8Ev+gUw+iO1vM7eA8cmBlZaHz8GT7rA6FHJ06VH3VZlGxSXyRGrXMxy
 0nYAoxIiPYq/H9StoW9/V4wyDqFhDsRCh3JGTXEGr6osOdnuwBSmU70+3JAAERN7n/J+
 VmfJj+G9w8TCBy4H3umtfYKGP0FbE2X6SGGexo4qUnhGD4vBxJ8yKwdDcMsw48rQ/Gom
 VNoQ==
X-Gm-Message-State: APjAAAUrhhx/HDuLv1il8Kp/w1Xb9M3ClgO1q4McvSJbl4PRpkSI5nLy
 plgTbeIBG6swK5AItKey5bEGfQ==
X-Google-Smtp-Source: APXvYqy8fjwBP5ZhuVRKSC/Wa4FuEnxPLSRwJo5W7umr6MC/hIewSv2tK/omhkZLEkHwU2USHaSM4g==
X-Received: by 2002:a05:600c:352:: with SMTP id
 u18mr2969633wmd.141.1565700591008; 
 Tue, 13 Aug 2019 05:49:51 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id c12sm6541563wrx.46.2019.08.13.05.49.48
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 13 Aug 2019 05:49:49 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 706401FF93;
 Tue, 13 Aug 2019 13:49:47 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue, 13 Aug 2019 13:49:39 +0100
Message-Id: <20190813124946.25322-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190813124946.25322-1-alex.bennee@linaro.org>
References: <20190813124946.25322-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: [Qemu-devel] [PATCH v3 06/13] target/m68k: replace LIT64 with
 UINT64_C macros
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, armbru@redhat.com,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In our quest to eliminate the home rolled LIT64 macro we fixup usage
inside for m68k's many constants.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/m68k/softfloat.c | 98 ++++++++++++++++++++---------------------
 1 file changed, 49 insertions(+), 49 deletions(-)

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



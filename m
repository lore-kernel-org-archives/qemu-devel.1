Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8CA8C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 09:31:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1E6A2078D
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 09:31:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tBR7M21G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1E6A2078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiabH-0004zA-R7
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 05:31:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52964)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jiaa4-00041X-2X
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 05:30:04 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:44925)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jiaa2-0001lb-Iq
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 05:30:03 -0400
Received: by mail-wr1-x443.google.com with SMTP id y17so20448982wrn.11
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 02:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=PUO1lSkgvXGHXXKlWvXVLnXM01W2gI9I/oSbMzNxU2I=;
 b=tBR7M21GnFZEcd3FdzRMfioO4kz91krRIMCrdcf0xxzowarhMHatfR+SgFrmDv3J9r
 IQ5QBtme1+f6/sJGzdSxNZ9nKkbHlhA804JJ0fmCFvrPYyh+2ztEP9tfCtm0ESFCC7m5
 u7XAHQBxpQtBqLSVMePs0PtEkZGe69PRXcPy3B8DXdFf1zuBkGGVU90I4S9lVCI5FUjn
 TBJnW8JxGbJBz3oHd8AOXUGC5iApzBY8GmElh2D0uNBCJpYVuIz29ec/ATHmbH7rEOFl
 mC+0ljrU3IBoBw5GvLatF3A/KrR9agUQ0xg49HK1KLoBuqkk4XQlosW0JAyvv6yu8ufj
 iSrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=PUO1lSkgvXGHXXKlWvXVLnXM01W2gI9I/oSbMzNxU2I=;
 b=cjYr5dM+eD0kD59rT0FDLrKADj+PpfUYLhUFTl3xx2grxJhnG01FbzQCAafwAGNa6J
 wM0mhwjzT8cQPTjnSu/8qeWH9d3oD8EAmaEqNUeApvu3mQ7ku+WsGKRbznVM8XApzSCg
 bl9hC83nj58uQR1iutTum4UOurTo+3uUohtv0CUm0olepD6BCye0l+B7J9o61AfcwMJ9
 K+YirR88KspSuqDVZ1Lk4xgh7qmO+/62t4+Zv1WA0dIaRPnrzk/ib/+IkRMaZ0ER2KNT
 yr0gpB+0ymyFRBB3/VNnZe9zGSCPFnxaHuXIZmJHKafHJRkq7wq2AqfHPJGy+e+/tMng
 VDRw==
X-Gm-Message-State: AOAM532fnAAuEJoGzbsLHishdRh/X8U7CI97I6jZv9qGB3EbxMgFL1f9
 fSuzwW5nH0jKk9IJ92qcFOoCVA==
X-Google-Smtp-Source: ABdhPJy27yRA1w0sBjLu9B4qJRZ8VWiRGm/mBSSmTFSrc6HUJfDEuNTuys5HoL/BQkw/Q0IoFEz5Lg==
X-Received: by 2002:a5d:4bcb:: with SMTP id l11mr3602975wrt.363.1591694999656; 
 Tue, 09 Jun 2020 02:29:59 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id v28sm2868488wra.77.2020.06.09.02.29.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 02:29:58 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 4152B1FF7E;
 Tue,  9 Jun 2020 10:29:57 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH] softfloat: partially convert float32_to_floatx80 to new
 style (HACK)
Date: Tue,  9 Jun 2020 10:29:46 +0100
Message-Id: <20200609092946.21710-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x443.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Joseph Myers <joseph@codesourcery.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is just an experimental conversion of one of the float to x80
conversions to use the "new style" decomposition code. Of course it
elides over any potential fraction loss you may get doing actual
calculation but it may allow us to eliminate some more old code.

Of course the ideal would still to be to find a way to handle the
a bigger fractional part needed for x80 (and float128) in the common
code but so far I haven't managed to find a way to unionise the
FloatParts structure that doesn't slow down the existing 16/32/64
paths with unnecessary padding.

Is it worth converting the conversion routines nonetheless?

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: Joseph Myers <joseph@codesourcery.com>
---
 fpu/softfloat.c | 40 +++++++++++++++++++---------------------
 1 file changed, 19 insertions(+), 21 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index dc2266b86ec..ccf00b1cac6 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -4438,31 +4438,29 @@ float128 uint64_to_float128(uint64_t a, float_status *status)
 
 floatx80 float32_to_floatx80(float32 a, float_status *status)
 {
-    bool aSign;
-    int aExp;
-    uint32_t aSig;
+    FloatParts pa = float32_unpack_canonical(a, status);
 
-    a = float32_squash_input_denormal(a, status);
-    aSig = extractFloat32Frac( a );
-    aExp = extractFloat32Exp( a );
-    aSign = extractFloat32Sign( a );
-    if ( aExp == 0xFF ) {
-        if (aSig) {
-            floatx80 res = commonNaNToFloatx80(float32ToCommonNaN(a, status),
-                                               status);
-            return floatx80_silence_nan(res, status);
-        }
-        return packFloatx80(aSign,
+    switch (pa.cls) {
+    case float_class_snan:
+    case float_class_qnan:
+    {
+        floatx80 res = commonNaNToFloatx80(float32ToCommonNaN(a, status), status);
+        return floatx80_silence_nan(res, status);
+    }
+    case float_class_inf:
+        return packFloatx80(pa.sign,
                             floatx80_infinity_high,
                             floatx80_infinity_low);
+        break;
+    case float_class_zero:
+        return packFloatx80(pa.sign, 0, 0);
+    case float_class_normal:
+        /* pa.frac << 1 drops the IMPLICIT 1 to leave only the
+           fractional part */
+        return packFloatx80(pa.sign, pa.exp + 16383, pa.frac << 1);
+    default:
+        g_assert_not_reached();
     }
-    if ( aExp == 0 ) {
-        if ( aSig == 0 ) return packFloatx80( aSign, 0, 0 );
-        normalizeFloat32Subnormal( aSig, &aExp, &aSig );
-    }
-    aSig |= 0x00800000;
-    return packFloatx80( aSign, aExp + 0x3F80, ( (uint64_t) aSig )<<40 );
-
 }
 
 /*----------------------------------------------------------------------------
-- 
2.20.1



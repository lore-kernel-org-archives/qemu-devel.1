Return-Path: <SRS0=E7tW=DZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C16AAC433E7
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Oct 2020 20:35:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23EEB22277
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Oct 2020 20:35:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RSDY/bFA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23EEB22277
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUFOc-0002SO-Vy
	for qemu-devel@archiver.kernel.org; Sun, 18 Oct 2020 16:35:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37642)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kUFN6-00019i-JL
 for qemu-devel@nongnu.org; Sun, 18 Oct 2020 16:33:40 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:51846)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kUFN4-0000u5-H0
 for qemu-devel@nongnu.org; Sun, 18 Oct 2020 16:33:40 -0400
Received: by mail-pj1-x1041.google.com with SMTP id a17so4183041pju.1
 for <qemu-devel@nongnu.org>; Sun, 18 Oct 2020 13:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=HkaZmOYCbeOEQHSWOXfsMEUX3KESG1xSv3gcl046LOA=;
 b=RSDY/bFA7fG32VuTRkP1kgz2dPrXqkFZJDHa4BvHe6deOtgv44M8Vgtod2eFQg5LXK
 gy0y8YkWhMRcfz1m2LyfhLq/T5v6yxdwa+AjtzSg0jC/Er1jMk4EOvWdL0+DUYe+Y4aI
 H0Gqf0rrBr6z+spUE/HQexxRpqs52edLCTpzBhOlRTrbEUMVYZQtPQT4kUosF9kbJo+7
 N0p9ygB46YE10DzLWNYyI/xD+9p2banJZHIK09FYiE5jpHIzoXiTzjDjgPD+sb78CXST
 bqKwQ8eOcPBP9PUGcGMaIiMyEa+AsZnjkFjMM3H1j19EW9+ANkf2Nd71RE2sLV4kRMiH
 9/bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=HkaZmOYCbeOEQHSWOXfsMEUX3KESG1xSv3gcl046LOA=;
 b=TyO0lnC5UHArBit9YH17wVpm/CRy7DUlpYJEyS9ZzhYIcJ5fada61k7bULlBwjxlq8
 4MZEGUSVBv1vV3fAFo5USDGCQUgHIabzy0b1bXdJNGPbmy/TSzaMFpX+EBhBQE884B4F
 OXFk1/W7i9Mo3PNSjonEOMShTamsevasefdMi3wrBe+h6Eimgh11MFkHjsbbrFj5ttC4
 XGy60izPjWKXdCLKpH3lN98gLLqbWUrpQslzZfSiETMwGUTdiuloCDILDiXrWH1IOO7m
 9Yr9M/D6oTDZZXhQkNtbe/6NY2x7ITfXnwYRmsTUMZ2KbquQ4meXs20mDmFSRBQI0RAi
 PdFQ==
X-Gm-Message-State: AOAM532AdSirYvGoDkbYIg9iUsCXGXd0p50uQ9TFX7LFNrsSh2B2164H
 pCVc2GxIWSy/G4ZQXyElyTnF5TR/gAVeJQ==
X-Google-Smtp-Source: ABdhPJy8xaAVVvcchVhkyzd8CGJOcJGlduxus2fKDDJ6QLT+hyS8o4GSQ3JIshUvManE75T56v2fzw==
X-Received: by 2002:a17:90a:8c02:: with SMTP id
 a2mr14628649pjo.186.1603053216443; 
 Sun, 18 Oct 2020 13:33:36 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id q21sm9284910pgg.45.2020.10.18.13.33.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Oct 2020 13:33:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] softfloat: Mark base int-to-float routines QEMU_FLATTEN
Date: Sun, 18 Oct 2020 13:33:34 -0700
Message-Id: <20201018203334.1229243-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1041.google.com
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
Cc: alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This merges the int_to_float routine and the round_pack_canonical
routine into the same function, allowing the FloatParts structure
to be decomposed by the compiler.

This results in a 60-75% speedup of the flattened function.

Leave the narrower integer inputs to tail-call the int64_t version.

Buglink: https://bugs.launchpad.net/qemu/+bug/1892081
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 7b6aee9323..2cbcf5bf10 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -2794,7 +2794,8 @@ static FloatParts int_to_float(int64_t a, int scale, float_status *status)
     return r;
 }
 
-float16 int64_to_float16_scalbn(int64_t a, int scale, float_status *status)
+float16 QEMU_FLATTEN
+int64_to_float16_scalbn(int64_t a, int scale, float_status *status)
 {
     FloatParts pa = int_to_float(a, scale, status);
     return float16_round_pack_canonical(pa, status);
@@ -2830,7 +2831,8 @@ float16 int8_to_float16(int8_t a, float_status *status)
     return int64_to_float16_scalbn(a, 0, status);
 }
 
-float32 int64_to_float32_scalbn(int64_t a, int scale, float_status *status)
+float32 QEMU_FLATTEN
+int64_to_float32_scalbn(int64_t a, int scale, float_status *status)
 {
     FloatParts pa = int_to_float(a, scale, status);
     return float32_round_pack_canonical(pa, status);
@@ -2861,7 +2863,8 @@ float32 int16_to_float32(int16_t a, float_status *status)
     return int64_to_float32_scalbn(a, 0, status);
 }
 
-float64 int64_to_float64_scalbn(int64_t a, int scale, float_status *status)
+float64 QEMU_FLATTEN
+int64_to_float64_scalbn(int64_t a, int scale, float_status *status)
 {
     FloatParts pa = int_to_float(a, scale, status);
     return float64_round_pack_canonical(pa, status);
@@ -2897,7 +2900,8 @@ float64 int16_to_float64(int16_t a, float_status *status)
  * to the bfloat16 format.
  */
 
-bfloat16 int64_to_bfloat16_scalbn(int64_t a, int scale, float_status *status)
+bfloat16 QEMU_FLATTEN
+int64_to_bfloat16_scalbn(int64_t a, int scale, float_status *status)
 {
     FloatParts pa = int_to_float(a, scale, status);
     return bfloat16_round_pack_canonical(pa, status);
@@ -2959,7 +2963,8 @@ static FloatParts uint_to_float(uint64_t a, int scale, float_status *status)
     return r;
 }
 
-float16 uint64_to_float16_scalbn(uint64_t a, int scale, float_status *status)
+float16 QEMU_FLATTEN
+uint64_to_float16_scalbn(uint64_t a, int scale, float_status *status)
 {
     FloatParts pa = uint_to_float(a, scale, status);
     return float16_round_pack_canonical(pa, status);
@@ -2995,7 +3000,8 @@ float16 uint8_to_float16(uint8_t a, float_status *status)
     return uint64_to_float16_scalbn(a, 0, status);
 }
 
-float32 uint64_to_float32_scalbn(uint64_t a, int scale, float_status *status)
+float32 QEMU_FLATTEN
+uint64_to_float32_scalbn(uint64_t a, int scale, float_status *status)
 {
     FloatParts pa = uint_to_float(a, scale, status);
     return float32_round_pack_canonical(pa, status);
@@ -3026,7 +3032,8 @@ float32 uint16_to_float32(uint16_t a, float_status *status)
     return uint64_to_float32_scalbn(a, 0, status);
 }
 
-float64 uint64_to_float64_scalbn(uint64_t a, int scale, float_status *status)
+float64 QEMU_FLATTEN
+uint64_to_float64_scalbn(uint64_t a, int scale, float_status *status)
 {
     FloatParts pa = uint_to_float(a, scale, status);
     return float64_round_pack_canonical(pa, status);
@@ -3062,7 +3069,8 @@ float64 uint16_to_float64(uint16_t a, float_status *status)
  * bfloat16 format.
  */
 
-bfloat16 uint64_to_bfloat16_scalbn(uint64_t a, int scale, float_status *status)
+bfloat16 QEMU_FLATTEN
+uint64_to_bfloat16_scalbn(uint64_t a, int scale, float_status *status)
 {
     FloatParts pa = uint_to_float(a, scale, status);
     return bfloat16_round_pack_canonical(pa, status);
-- 
2.25.1



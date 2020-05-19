Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 691F3C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 16:51:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24E432075F
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 16:51:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lXgkkvCE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24E432075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb5Sg-0006XZ-8S
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 12:51:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59638)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jb5RQ-0004gb-Sw
 for qemu-devel@nongnu.org; Tue, 19 May 2020 12:50:08 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435]:36818)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jb5RO-0006DP-IN
 for qemu-devel@nongnu.org; Tue, 19 May 2020 12:50:08 -0400
Received: by mail-pf1-x435.google.com with SMTP id z1so185928pfn.3
 for <qemu-devel@nongnu.org>; Tue, 19 May 2020 09:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=PCmqWRwoeQAvE87APi5hhUVbKMEOrTBeCc5Dp8TlOV8=;
 b=lXgkkvCEDiOxOzqa9nqiLGnoy0RJchcAmruLkohGQwJ4bqD48eK4GMyAdyCfbK15qB
 9oNuX4b2dFMln5jSJGzKbEMTHEHnFfG+di9cNNimpV8t5Rjga26OnvWDV3/1OoU80thn
 xwI7VIlIDfzu+dV/Ngays0XbdPFZtqjUMLN+uiBjoiRLGSzS9poN5aHCCynJzKVmT7+3
 PMLWZDTVdaYvAcsP547Kg6eXsMTeWwimYCCGOjmBC0DlrVJD3IglnyOFi+FOpZNIaPhW
 xTPs6qSQAT0qfTawXFlhFZfmBJcghjW9Naybzv7uLklcfNHc5/ZAfbGGaUKKdpdnznLO
 95yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=PCmqWRwoeQAvE87APi5hhUVbKMEOrTBeCc5Dp8TlOV8=;
 b=nOSRcL1W4IWNw8ENynVzzwzCY93mirAjgWgTmEZLKhSoWuu4Ufe9ZgNk5p/3DoqsBt
 3qIIiSxaHgpszLXtIoRgdNtwQ62HkpYyQEcYyo31kjsTCLYzWJRSBFSFwpmYFNRp2THC
 W1GGi/NGUus0rKDTcWZD8zWtG06Rt3XYD+EWvSFhtTOu+690S15h/iK1h0zu0FsKkFbj
 Jju060CHKREc4zRuJoUQ7aCJa5TVE0zTq78jbSjr4m6hWH9f4dWAB5hRqm/J2BWKziQg
 LeU4syqUrcq0Z3qzcMysuoAScc8yrF7+ivfwNIk/zxxymh23vDDxcFwze65G12uDlKWI
 Zz+w==
X-Gm-Message-State: AOAM532/0SlrrG5gjpY8cYElo/byjxSjyAd8W44+LsqnLUnnOPRfmAJM
 nYFnYRyfknHRrS+OoZbL+jy2VlDi0VI=
X-Google-Smtp-Source: ABdhPJxG5wevGxHhG+XN8NlCEHIBIUVILNe4vOFrMchCOMwf79p1VRuvuk690aZFHDwQArqVN9WzGA==
X-Received: by 2002:a63:5717:: with SMTP id l23mr91724pgb.217.1589907004704;
 Tue, 19 May 2020 09:50:04 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id gx21sm96685pjb.47.2020.05.19.09.50.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2020 09:50:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/10] softfloat: Name rounding mode enum
Date: Tue, 19 May 2020 09:49:51 -0700
Message-Id: <20200519164957.26920-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200519164957.26920-1-richard.henderson@linaro.org>
References: <20200519164957.26920-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Give the previously unnamed enum a typedef name.  Use the packed
attribute so that we do not affect the layout of the float_status
struct.  Use it in the prototypes of relevant functions.

Adjust switch statements as necessary to avoid compiler warnings.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/fpu/softfloat-helpers.h |  5 +--
 include/fpu/softfloat-types.h   |  6 ++--
 include/fpu/softfloat.h         | 39 +++++++++++-----------
 fpu/softfloat.c                 | 57 ++++++++++++++++++++-------------
 target/arm/vfp_helper.c         |  4 +--
 target/m68k/fpu_helper.c        |  6 ++--
 6 files changed, 66 insertions(+), 51 deletions(-)

diff --git a/include/fpu/softfloat-helpers.h b/include/fpu/softfloat-helpers.h
index 40d32a6d5d..735ed6b653 100644
--- a/include/fpu/softfloat-helpers.h
+++ b/include/fpu/softfloat-helpers.h
@@ -58,7 +58,8 @@ static inline void set_float_detect_tininess(bool val, float_status *status)
     status->tininess_before_rounding = val;
 }
 
-static inline void set_float_rounding_mode(int val, float_status *status)
+static inline void set_float_rounding_mode(FloatRoundMode val,
+                                           float_status *status)
 {
     status->float_rounding_mode = val;
 }
@@ -99,7 +100,7 @@ static inline bool get_float_detect_tininess(float_status *status)
     return status->tininess_before_rounding;
 }
 
-static inline int get_float_rounding_mode(float_status *status)
+static inline FloatRoundMode get_float_rounding_mode(float_status *status)
 {
     return status->float_rounding_mode;
 }
diff --git a/include/fpu/softfloat-types.h b/include/fpu/softfloat-types.h
index 874ddd9f93..7680193ebc 100644
--- a/include/fpu/softfloat-types.h
+++ b/include/fpu/softfloat-types.h
@@ -123,7 +123,7 @@ typedef struct {
  *Software IEC/IEEE floating-point rounding mode.
  */
 
-enum {
+typedef enum __attribute__((__packed__)) {
     float_round_nearest_even = 0,
     float_round_down         = 1,
     float_round_up           = 2,
@@ -131,7 +131,7 @@ enum {
     float_round_ties_away    = 4,
     /* Not an IEEE rounding mode: round to the closest odd mantissa value */
     float_round_to_odd       = 5,
-};
+} FloatRoundMode;
 
 /*
  * Software IEC/IEEE floating-point exception flags.
@@ -156,7 +156,7 @@ enum {
  */
 
 typedef struct float_status {
-    signed char float_rounding_mode;
+    FloatRoundMode float_rounding_mode;
     uint8_t     float_exception_flags;
     signed char floatx80_rounding_precision;
     bool tininess_before_rounding;
diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index 3f588da7c7..ca75f764aa 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -186,9 +186,9 @@ float32 float16_to_float32(float16, bool ieee, float_status *status);
 float16 float64_to_float16(float64 a, bool ieee, float_status *status);
 float64 float16_to_float64(float16 a, bool ieee, float_status *status);
 
-int16_t float16_to_int16_scalbn(float16, int, int, float_status *status);
-int32_t float16_to_int32_scalbn(float16, int, int, float_status *status);
-int64_t float16_to_int64_scalbn(float16, int, int, float_status *status);
+int16_t float16_to_int16_scalbn(float16, FloatRoundMode, int, float_status *);
+int32_t float16_to_int32_scalbn(float16, FloatRoundMode, int, float_status *);
+int64_t float16_to_int64_scalbn(float16, FloatRoundMode, int, float_status *);
 
 int16_t float16_to_int16(float16, float_status *status);
 int32_t float16_to_int32(float16, float_status *status);
@@ -198,9 +198,12 @@ int16_t float16_to_int16_round_to_zero(float16, float_status *status);
 int32_t float16_to_int32_round_to_zero(float16, float_status *status);
 int64_t float16_to_int64_round_to_zero(float16, float_status *status);
 
-uint16_t float16_to_uint16_scalbn(float16 a, int, int, float_status *status);
-uint32_t float16_to_uint32_scalbn(float16 a, int, int, float_status *status);
-uint64_t float16_to_uint64_scalbn(float16 a, int, int, float_status *status);
+uint16_t float16_to_uint16_scalbn(float16 a, FloatRoundMode,
+                                  int, float_status *status);
+uint32_t float16_to_uint32_scalbn(float16 a, FloatRoundMode,
+                                  int, float_status *status);
+uint64_t float16_to_uint64_scalbn(float16 a, FloatRoundMode,
+                                  int, float_status *status);
 
 uint16_t float16_to_uint16(float16 a, float_status *status);
 uint32_t float16_to_uint32(float16 a, float_status *status);
@@ -298,9 +301,9 @@ float16 float16_default_nan(float_status *status);
 | Software IEC/IEEE single-precision conversion routines.
 *----------------------------------------------------------------------------*/
 
-int16_t float32_to_int16_scalbn(float32, int, int, float_status *status);
-int32_t float32_to_int32_scalbn(float32, int, int, float_status *status);
-int64_t float32_to_int64_scalbn(float32, int, int, float_status *status);
+int16_t float32_to_int16_scalbn(float32, FloatRoundMode, int, float_status *);
+int32_t float32_to_int32_scalbn(float32, FloatRoundMode, int, float_status *);
+int64_t float32_to_int64_scalbn(float32, FloatRoundMode, int, float_status *);
 
 int16_t float32_to_int16(float32, float_status *status);
 int32_t float32_to_int32(float32, float_status *status);
@@ -310,9 +313,9 @@ int16_t float32_to_int16_round_to_zero(float32, float_status *status);
 int32_t float32_to_int32_round_to_zero(float32, float_status *status);
 int64_t float32_to_int64_round_to_zero(float32, float_status *status);
 
-uint16_t float32_to_uint16_scalbn(float32, int, int, float_status *status);
-uint32_t float32_to_uint32_scalbn(float32, int, int, float_status *status);
-uint64_t float32_to_uint64_scalbn(float32, int, int, float_status *status);
+uint16_t float32_to_uint16_scalbn(float32, FloatRoundMode, int, float_status *);
+uint32_t float32_to_uint32_scalbn(float32, FloatRoundMode, int, float_status *);
+uint64_t float32_to_uint64_scalbn(float32, FloatRoundMode, int, float_status *);
 
 uint16_t float32_to_uint16(float32, float_status *status);
 uint32_t float32_to_uint32(float32, float_status *status);
@@ -455,9 +458,9 @@ float32 float32_default_nan(float_status *status);
 | Software IEC/IEEE double-precision conversion routines.
 *----------------------------------------------------------------------------*/
 
-int16_t float64_to_int16_scalbn(float64, int, int, float_status *status);
-int32_t float64_to_int32_scalbn(float64, int, int, float_status *status);
-int64_t float64_to_int64_scalbn(float64, int, int, float_status *status);
+int16_t float64_to_int16_scalbn(float64, FloatRoundMode, int, float_status *);
+int32_t float64_to_int32_scalbn(float64, FloatRoundMode, int, float_status *);
+int64_t float64_to_int64_scalbn(float64, FloatRoundMode, int, float_status *);
 
 int16_t float64_to_int16(float64, float_status *status);
 int32_t float64_to_int32(float64, float_status *status);
@@ -467,9 +470,9 @@ int16_t float64_to_int16_round_to_zero(float64, float_status *status);
 int32_t float64_to_int32_round_to_zero(float64, float_status *status);
 int64_t float64_to_int64_round_to_zero(float64, float_status *status);
 
-uint16_t float64_to_uint16_scalbn(float64, int, int, float_status *status);
-uint32_t float64_to_uint32_scalbn(float64, int, int, float_status *status);
-uint64_t float64_to_uint64_scalbn(float64, int, int, float_status *status);
+uint16_t float64_to_uint16_scalbn(float64, FloatRoundMode, int, float_status *);
+uint32_t float64_to_uint32_scalbn(float64, FloatRoundMode, int, float_status *);
+uint64_t float64_to_uint64_scalbn(float64, FloatRoundMode, int, float_status *);
 
 uint16_t float64_to_uint16(float64, float_status *status);
 uint32_t float64_to_uint32(float64, float_status *status);
diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 65d457a548..93d8a03de6 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -759,6 +759,8 @@ static FloatParts round_canonical(FloatParts p, float_status *s,
                 case float_round_to_odd:
                     inc = frac & frac_lsb ? 0 : round_mask;
                     break;
+                default:
+                    break;
                 }
                 flags |= float_flag_inexact;
                 frac += inc;
@@ -1928,7 +1930,7 @@ float32 float64_to_float32(float64 a, float_status *s)
  * Arithmetic.
  */
 
-static FloatParts round_to_int(FloatParts a, int rmode,
+static FloatParts round_to_int(FloatParts a, FloatRoundMode rmode,
                                int scale, float_status *s)
 {
     switch (a.cls) {
@@ -2061,8 +2063,8 @@ float64 float64_round_to_int(float64 a, float_status *s)
  * is returned.
 */
 
-static int64_t round_to_int_and_pack(FloatParts in, int rmode, int scale,
-                                     int64_t min, int64_t max,
+static int64_t round_to_int_and_pack(FloatParts in, FloatRoundMode rmode,
+                                     int scale, int64_t min, int64_t max,
                                      float_status *s)
 {
     uint64_t r;
@@ -2107,63 +2109,63 @@ static int64_t round_to_int_and_pack(FloatParts in, int rmode, int scale,
     }
 }
 
-int16_t float16_to_int16_scalbn(float16 a, int rmode, int scale,
+int16_t float16_to_int16_scalbn(float16 a, FloatRoundMode rmode, int scale,
                                 float_status *s)
 {
     return round_to_int_and_pack(float16_unpack_canonical(a, s),
                                  rmode, scale, INT16_MIN, INT16_MAX, s);
 }
 
-int32_t float16_to_int32_scalbn(float16 a, int rmode, int scale,
+int32_t float16_to_int32_scalbn(float16 a, FloatRoundMode rmode, int scale,
                                 float_status *s)
 {
     return round_to_int_and_pack(float16_unpack_canonical(a, s),
                                  rmode, scale, INT32_MIN, INT32_MAX, s);
 }
 
-int64_t float16_to_int64_scalbn(float16 a, int rmode, int scale,
+int64_t float16_to_int64_scalbn(float16 a, FloatRoundMode rmode, int scale,
                                 float_status *s)
 {
     return round_to_int_and_pack(float16_unpack_canonical(a, s),
                                  rmode, scale, INT64_MIN, INT64_MAX, s);
 }
 
-int16_t float32_to_int16_scalbn(float32 a, int rmode, int scale,
+int16_t float32_to_int16_scalbn(float32 a, FloatRoundMode rmode, int scale,
                                 float_status *s)
 {
     return round_to_int_and_pack(float32_unpack_canonical(a, s),
                                  rmode, scale, INT16_MIN, INT16_MAX, s);
 }
 
-int32_t float32_to_int32_scalbn(float32 a, int rmode, int scale,
+int32_t float32_to_int32_scalbn(float32 a, FloatRoundMode rmode, int scale,
                                 float_status *s)
 {
     return round_to_int_and_pack(float32_unpack_canonical(a, s),
                                  rmode, scale, INT32_MIN, INT32_MAX, s);
 }
 
-int64_t float32_to_int64_scalbn(float32 a, int rmode, int scale,
+int64_t float32_to_int64_scalbn(float32 a, FloatRoundMode rmode, int scale,
                                 float_status *s)
 {
     return round_to_int_and_pack(float32_unpack_canonical(a, s),
                                  rmode, scale, INT64_MIN, INT64_MAX, s);
 }
 
-int16_t float64_to_int16_scalbn(float64 a, int rmode, int scale,
+int16_t float64_to_int16_scalbn(float64 a, FloatRoundMode rmode, int scale,
                                 float_status *s)
 {
     return round_to_int_and_pack(float64_unpack_canonical(a, s),
                                  rmode, scale, INT16_MIN, INT16_MAX, s);
 }
 
-int32_t float64_to_int32_scalbn(float64 a, int rmode, int scale,
+int32_t float64_to_int32_scalbn(float64 a, FloatRoundMode rmode, int scale,
                                 float_status *s)
 {
     return round_to_int_and_pack(float64_unpack_canonical(a, s),
                                  rmode, scale, INT32_MIN, INT32_MAX, s);
 }
 
-int64_t float64_to_int64_scalbn(float64 a, int rmode, int scale,
+int64_t float64_to_int64_scalbn(float64 a, FloatRoundMode rmode, int scale,
                                 float_status *s)
 {
     return round_to_int_and_pack(float64_unpack_canonical(a, s),
@@ -2273,8 +2275,9 @@ int64_t float64_to_int64_round_to_zero(float64 a, float_status *s)
  *  flag.
  */
 
-static uint64_t round_to_uint_and_pack(FloatParts in, int rmode, int scale,
-                                       uint64_t max, float_status *s)
+static uint64_t round_to_uint_and_pack(FloatParts in, FloatRoundMode rmode,
+                                       int scale, uint64_t max,
+                                       float_status *s)
 {
     int orig_flags = get_float_exception_flags(s);
     FloatParts p = round_to_int(in, rmode, scale, s);
@@ -2319,63 +2322,63 @@ static uint64_t round_to_uint_and_pack(FloatParts in, int rmode, int scale,
     }
 }
 
-uint16_t float16_to_uint16_scalbn(float16 a, int rmode, int scale,
+uint16_t float16_to_uint16_scalbn(float16 a, FloatRoundMode rmode, int scale,
                                   float_status *s)
 {
     return round_to_uint_and_pack(float16_unpack_canonical(a, s),
                                   rmode, scale, UINT16_MAX, s);
 }
 
-uint32_t float16_to_uint32_scalbn(float16 a, int rmode, int scale,
+uint32_t float16_to_uint32_scalbn(float16 a, FloatRoundMode rmode, int scale,
                                   float_status *s)
 {
     return round_to_uint_and_pack(float16_unpack_canonical(a, s),
                                   rmode, scale, UINT32_MAX, s);
 }
 
-uint64_t float16_to_uint64_scalbn(float16 a, int rmode, int scale,
+uint64_t float16_to_uint64_scalbn(float16 a, FloatRoundMode rmode, int scale,
                                   float_status *s)
 {
     return round_to_uint_and_pack(float16_unpack_canonical(a, s),
                                   rmode, scale, UINT64_MAX, s);
 }
 
-uint16_t float32_to_uint16_scalbn(float32 a, int rmode, int scale,
+uint16_t float32_to_uint16_scalbn(float32 a, FloatRoundMode rmode, int scale,
                                   float_status *s)
 {
     return round_to_uint_and_pack(float32_unpack_canonical(a, s),
                                   rmode, scale, UINT16_MAX, s);
 }
 
-uint32_t float32_to_uint32_scalbn(float32 a, int rmode, int scale,
+uint32_t float32_to_uint32_scalbn(float32 a, FloatRoundMode rmode, int scale,
                                   float_status *s)
 {
     return round_to_uint_and_pack(float32_unpack_canonical(a, s),
                                   rmode, scale, UINT32_MAX, s);
 }
 
-uint64_t float32_to_uint64_scalbn(float32 a, int rmode, int scale,
+uint64_t float32_to_uint64_scalbn(float32 a, FloatRoundMode rmode, int scale,
                                   float_status *s)
 {
     return round_to_uint_and_pack(float32_unpack_canonical(a, s),
                                   rmode, scale, UINT64_MAX, s);
 }
 
-uint16_t float64_to_uint16_scalbn(float64 a, int rmode, int scale,
+uint16_t float64_to_uint16_scalbn(float64 a, FloatRoundMode rmode, int scale,
                                   float_status *s)
 {
     return round_to_uint_and_pack(float64_unpack_canonical(a, s),
                                   rmode, scale, UINT16_MAX, s);
 }
 
-uint32_t float64_to_uint32_scalbn(float64 a, int rmode, int scale,
+uint32_t float64_to_uint32_scalbn(float64 a, FloatRoundMode rmode, int scale,
                                   float_status *s)
 {
     return round_to_uint_and_pack(float64_unpack_canonical(a, s),
                                   rmode, scale, UINT32_MAX, s);
 }
 
-uint64_t float64_to_uint64_scalbn(float64 a, int rmode, int scale,
+uint64_t float64_to_uint64_scalbn(float64 a, FloatRoundMode rmode, int scale,
                                   float_status *s)
 {
     return round_to_uint_and_pack(float64_unpack_canonical(a, s),
@@ -5715,6 +5718,11 @@ floatx80 floatx80_round_to_int(floatx80 a, float_status *status)
             return
                   aSign ? packFloatx80( 1, 0, 0 )
                 : packFloatx80( 0, 0x3FFF, UINT64_C(0x8000000000000000));
+
+        case float_round_to_zero:
+            break;
+        default:
+            g_assert_not_reached();
         }
         return packFloatx80( aSign, 0, 0 );
     }
@@ -7047,6 +7055,9 @@ float128 float128_round_to_int(float128 a, float_status *status)
 
             case float_round_to_odd:
                 return packFloat128(aSign, 0x3FFF, 0, 0);
+
+            case float_round_to_zero:
+                break;
             }
             return packFloat128( aSign, 0, 0, 0 );
         }
diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index 42625747d1..0920694764 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -697,9 +697,9 @@ static bool round_to_inf(float_status *fpst, bool sign_bit)
         return sign_bit;
     case float_round_to_zero: /* Round to Zero */
         return false;
+    default:
+        g_assert_not_reached();
     }
-
-    g_assert_not_reached();
 }
 
 uint32_t HELPER(recpe_f16)(uint32_t input, void *fpstp)
diff --git a/target/m68k/fpu_helper.c b/target/m68k/fpu_helper.c
index 4137542ec0..36e6c704d1 100644
--- a/target/m68k/fpu_helper.c
+++ b/target/m68k/fpu_helper.c
@@ -149,7 +149,7 @@ void cpu_m68k_set_fpcr(CPUM68KState *env, uint32_t val)
 
 void HELPER(fitrunc)(CPUM68KState *env, FPReg *res, FPReg *val)
 {
-    int rounding_mode = get_float_rounding_mode(&env->fp_status);
+    FloatRoundMode rounding_mode = get_float_rounding_mode(&env->fp_status);
     set_float_rounding_mode(float_round_to_zero, &env->fp_status);
     res->d = floatx80_round_to_int(val->d, &env->fp_status);
     set_float_rounding_mode(rounding_mode, &env->fp_status);
@@ -300,7 +300,7 @@ void HELPER(fdmul)(CPUM68KState *env, FPReg *res, FPReg *val0, FPReg *val1)
 
 void HELPER(fsglmul)(CPUM68KState *env, FPReg *res, FPReg *val0, FPReg *val1)
 {
-    int rounding_mode = get_float_rounding_mode(&env->fp_status);
+    FloatRoundMode rounding_mode = get_float_rounding_mode(&env->fp_status);
     floatx80 a, b;
 
     PREC_BEGIN(32);
@@ -333,7 +333,7 @@ void HELPER(fddiv)(CPUM68KState *env, FPReg *res, FPReg *val0, FPReg *val1)
 
 void HELPER(fsgldiv)(CPUM68KState *env, FPReg *res, FPReg *val0, FPReg *val1)
 {
-    int rounding_mode = get_float_rounding_mode(&env->fp_status);
+    FloatRoundMode rounding_mode = get_float_rounding_mode(&env->fp_status);
     floatx80 a, b;
 
     PREC_BEGIN(32);
-- 
2.20.1



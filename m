Return-Path: <SRS0=e36u=CI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D6FC433E6
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2020 02:34:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE27C2075B
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2020 02:34:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Eb1ZzKte"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE27C2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCDAo-00077g-3z
	for qemu-devel@archiver.kernel.org; Sat, 29 Aug 2020 22:34:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52860)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCD8i-0002lC-Ro
 for qemu-devel@nongnu.org; Sat, 29 Aug 2020 22:32:16 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a]:39941)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCD8g-0002Yn-DF
 for qemu-devel@nongnu.org; Sat, 29 Aug 2020 22:32:16 -0400
Received: by mail-pl1-x62a.google.com with SMTP id z15so1421843plo.7
 for <qemu-devel@nongnu.org>; Sat, 29 Aug 2020 19:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NO3P9ik3JgoBcB+gtLZEAETdlVtAEmQlYrb0l66oha4=;
 b=Eb1ZzKtevnMxJjzR6Cfxw7hOIFDI3QedSXz35giQKKD3U/5maYhqqwbs6n6BmhfKcj
 Qv0YAsgy22obJSPy3xXVm1fimCez1xAMRRHFb2TW9Ik6m0AxZXHf78X2TdgoQ4/Tf2ni
 lvPZe9MLQ1IX84TGwtVOmu0uqjkO+XN/oVrnsGaV1t4XUXlgX2DXrD70b83y6j6EymJJ
 ZPb1c8xCCrf/HZ8eJzYDE/9xJrI1hTaMqBd0/WvLoTPwoRokPh6vRd5VP8HduxIq+fNb
 gVeWZrPM+Ckr0TZI/fvBVYJDvSjJ54oHYH86gJwx0e3CZ4mjNs+/IRQVxsD/GWI2zXb5
 UuMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NO3P9ik3JgoBcB+gtLZEAETdlVtAEmQlYrb0l66oha4=;
 b=SD+HUg13EXE6W+T32PLhGQo9ll79BtCLtGbpPv0FUs8B1P6JfL6/ffmpFMvXRIjFjF
 X8++Pw+/5GwB3ROYbSYZaiFZSOpWfHFBBvl7u6BQNkw83bnrvNpbGS8UkKlBygXM/uph
 Sgr38YVa1z3ExH0Ky+CdpM1MZky1RQihuGaERcOUqux6i4pnW4tRNyJ6uZnYs49vdP8N
 Opus7cONarPUCWq/AbKb0p5YYX8uXqLN/559moIYEZjmnu9LvWYseBpQPmljU6NEP6eC
 p0cZwUgOyQUdBtgRnFaHIupPLFJNjT1ri3rBli0MZDHYsbc1LdGmFmX57qq9tbuZDa44
 XKww==
X-Gm-Message-State: AOAM531rNqGF/K6Ql7F+oKTAt4j1cTlzPFw7qGlX8fEG7Q7LmRtT7BJz
 tb89YbdT3rECaOu7i219rPg+dAVbplhkdg==
X-Google-Smtp-Source: ABdhPJzQivLzjQqC+rRbV5KI8+RWcZZtgUNJqoximVXGMG63GidnzMqFaG6WmcjKYA6d09GCUrGOlA==
X-Received: by 2002:a17:902:708b:: with SMTP id
 z11mr4352889plk.326.1598754732552; 
 Sat, 29 Aug 2020 19:32:12 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id l23sm3546269pgt.16.2020.08.29.19.32.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 29 Aug 2020 19:32:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 5/7] softfloat: Define convert operations for bfloat16
Date: Sat, 29 Aug 2020 19:32:01 -0700
Message-Id: <20200830023203.612312-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200830023203.612312-1-richard.henderson@linaro.org>
References: <20200830023203.612312-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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
Cc: peter.maydell@linaro.org, LIU Zhiwei <zhiwei_liu@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: LIU Zhiwei <zhiwei_liu@c-sky.com>

Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200813071421.2509-3-zhiwei_liu@c-sky.com>
[rth: Use FloatRoundMode for conversion functions.]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/fpu/softfloat.h |  54 ++++++++++
 fpu/softfloat.c         | 223 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 277 insertions(+)

diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index 68b3cf488d..95f0789a92 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -348,6 +348,60 @@ static inline bool float16_unordered_quiet(float16 a, float16 b,
 #define float16_three make_float16(0x4200)
 #define float16_infinity make_float16(0x7c00)
 
+/*----------------------------------------------------------------------------
+| Software bfloat16 conversion routines.
+*----------------------------------------------------------------------------*/
+
+bfloat16 bfloat16_round_to_int(bfloat16, float_status *status);
+bfloat16 float32_to_bfloat16(float32, float_status *status);
+float32 bfloat16_to_float32(bfloat16, float_status *status);
+bfloat16 float64_to_bfloat16(float64 a, float_status *status);
+float64 bfloat16_to_float64(bfloat16 a, float_status *status);
+
+int16_t bfloat16_to_int16_scalbn(bfloat16, FloatRoundMode,
+                                 int, float_status *status);
+int32_t bfloat16_to_int32_scalbn(bfloat16, FloatRoundMode,
+                                 int, float_status *status);
+int64_t bfloat16_to_int64_scalbn(bfloat16, FloatRoundMode,
+                                 int, float_status *status);
+
+int16_t bfloat16_to_int16(bfloat16, float_status *status);
+int32_t bfloat16_to_int32(bfloat16, float_status *status);
+int64_t bfloat16_to_int64(bfloat16, float_status *status);
+
+int16_t bfloat16_to_int16_round_to_zero(bfloat16, float_status *status);
+int32_t bfloat16_to_int32_round_to_zero(bfloat16, float_status *status);
+int64_t bfloat16_to_int64_round_to_zero(bfloat16, float_status *status);
+
+uint16_t bfloat16_to_uint16_scalbn(bfloat16 a, FloatRoundMode,
+                                   int, float_status *status);
+uint32_t bfloat16_to_uint32_scalbn(bfloat16 a, FloatRoundMode,
+                                   int, float_status *status);
+uint64_t bfloat16_to_uint64_scalbn(bfloat16 a, FloatRoundMode,
+                                   int, float_status *status);
+
+uint16_t bfloat16_to_uint16(bfloat16 a, float_status *status);
+uint32_t bfloat16_to_uint32(bfloat16 a, float_status *status);
+uint64_t bfloat16_to_uint64(bfloat16 a, float_status *status);
+
+uint16_t bfloat16_to_uint16_round_to_zero(bfloat16 a, float_status *status);
+uint32_t bfloat16_to_uint32_round_to_zero(bfloat16 a, float_status *status);
+uint64_t bfloat16_to_uint64_round_to_zero(bfloat16 a, float_status *status);
+
+bfloat16 int16_to_bfloat16_scalbn(int16_t a, int, float_status *status);
+bfloat16 int32_to_bfloat16_scalbn(int32_t a, int, float_status *status);
+bfloat16 int64_to_bfloat16_scalbn(int64_t a, int, float_status *status);
+bfloat16 uint16_to_bfloat16_scalbn(uint16_t a, int, float_status *status);
+bfloat16 uint32_to_bfloat16_scalbn(uint32_t a, int, float_status *status);
+bfloat16 uint64_to_bfloat16_scalbn(uint64_t a, int, float_status *status);
+
+bfloat16 int16_to_bfloat16(int16_t a, float_status *status);
+bfloat16 int32_to_bfloat16(int32_t a, float_status *status);
+bfloat16 int64_to_bfloat16(int64_t a, float_status *status);
+bfloat16 uint16_to_bfloat16(uint16_t a, float_status *status);
+bfloat16 uint32_to_bfloat16(uint32_t a, float_status *status);
+bfloat16 uint64_to_bfloat16(uint64_t a, float_status *status);
+
 /*----------------------------------------------------------------------------
 | Software bfloat16 operations.
 *----------------------------------------------------------------------------*/
diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 77d81ab9b0..67cfa0fd82 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -2014,6 +2014,34 @@ float32 float64_to_float32(float64 a, float_status *s)
     return float32_round_pack_canonical(pr, s);
 }
 
+float32 bfloat16_to_float32(bfloat16 a, float_status *s)
+{
+    FloatParts p = bfloat16_unpack_canonical(a, s);
+    FloatParts pr = float_to_float(p, &float32_params, s);
+    return float32_round_pack_canonical(pr, s);
+}
+
+float64 bfloat16_to_float64(bfloat16 a, float_status *s)
+{
+    FloatParts p = bfloat16_unpack_canonical(a, s);
+    FloatParts pr = float_to_float(p, &float64_params, s);
+    return float64_round_pack_canonical(pr, s);
+}
+
+bfloat16 float32_to_bfloat16(float32 a, float_status *s)
+{
+    FloatParts p = float32_unpack_canonical(a, s);
+    FloatParts pr = float_to_float(p, &bfloat16_params, s);
+    return bfloat16_round_pack_canonical(pr, s);
+}
+
+bfloat16 float64_to_bfloat16(float64 a, float_status *s)
+{
+    FloatParts p = float64_unpack_canonical(a, s);
+    FloatParts pr = float_to_float(p, &bfloat16_params, s);
+    return bfloat16_round_pack_canonical(pr, s);
+}
+
 /*
  * Rounds the floating-point value `a' to an integer, and returns the
  * result as a floating-point value. The operation is performed
@@ -2143,6 +2171,18 @@ float64 float64_round_to_int(float64 a, float_status *s)
     return float64_round_pack_canonical(pr, s);
 }
 
+/*
+ * Rounds the bfloat16 value `a' to an integer, and returns the
+ * result as a bfloat16 value.
+ */
+
+bfloat16 bfloat16_round_to_int(bfloat16 a, float_status *s)
+{
+    FloatParts pa = bfloat16_unpack_canonical(a, s);
+    FloatParts pr = round_to_int(pa, s->float_rounding_mode, 0, s);
+    return bfloat16_round_pack_canonical(pr, s);
+}
+
 /*
  * Returns the result of converting the floating-point value `a' to
  * the two's complement integer format. The conversion is performed
@@ -2365,6 +2405,62 @@ int64_t float64_to_int64_round_to_zero(float64 a, float_status *s)
     return float64_to_int64_scalbn(a, float_round_to_zero, 0, s);
 }
 
+/*
+ * Returns the result of converting the floating-point value `a' to
+ * the two's complement integer format.
+ */
+
+int16_t bfloat16_to_int16_scalbn(bfloat16 a, FloatRoundMode rmode, int scale,
+                                 float_status *s)
+{
+    return round_to_int_and_pack(bfloat16_unpack_canonical(a, s),
+                                 rmode, scale, INT16_MIN, INT16_MAX, s);
+}
+
+int32_t bfloat16_to_int32_scalbn(bfloat16 a, FloatRoundMode rmode, int scale,
+                                 float_status *s)
+{
+    return round_to_int_and_pack(bfloat16_unpack_canonical(a, s),
+                                 rmode, scale, INT32_MIN, INT32_MAX, s);
+}
+
+int64_t bfloat16_to_int64_scalbn(bfloat16 a, FloatRoundMode rmode, int scale,
+                                 float_status *s)
+{
+    return round_to_int_and_pack(bfloat16_unpack_canonical(a, s),
+                                 rmode, scale, INT64_MIN, INT64_MAX, s);
+}
+
+int16_t bfloat16_to_int16(bfloat16 a, float_status *s)
+{
+    return bfloat16_to_int16_scalbn(a, s->float_rounding_mode, 0, s);
+}
+
+int32_t bfloat16_to_int32(bfloat16 a, float_status *s)
+{
+    return bfloat16_to_int32_scalbn(a, s->float_rounding_mode, 0, s);
+}
+
+int64_t bfloat16_to_int64(bfloat16 a, float_status *s)
+{
+    return bfloat16_to_int64_scalbn(a, s->float_rounding_mode, 0, s);
+}
+
+int16_t bfloat16_to_int16_round_to_zero(bfloat16 a, float_status *s)
+{
+    return bfloat16_to_int16_scalbn(a, float_round_to_zero, 0, s);
+}
+
+int32_t bfloat16_to_int32_round_to_zero(bfloat16 a, float_status *s)
+{
+    return bfloat16_to_int32_scalbn(a, float_round_to_zero, 0, s);
+}
+
+int64_t bfloat16_to_int64_round_to_zero(bfloat16 a, float_status *s)
+{
+    return bfloat16_to_int64_scalbn(a, float_round_to_zero, 0, s);
+}
+
 /*
  *  Returns the result of converting the floating-point value `a' to
  *  the unsigned integer format. The conversion is performed according
@@ -2590,6 +2686,62 @@ uint64_t float64_to_uint64_round_to_zero(float64 a, float_status *s)
     return float64_to_uint64_scalbn(a, float_round_to_zero, 0, s);
 }
 
+/*
+ *  Returns the result of converting the bfloat16 value `a' to
+ *  the unsigned integer format.
+ */
+
+uint16_t bfloat16_to_uint16_scalbn(bfloat16 a, FloatRoundMode rmode,
+                                   int scale, float_status *s)
+{
+    return round_to_uint_and_pack(bfloat16_unpack_canonical(a, s),
+                                  rmode, scale, UINT16_MAX, s);
+}
+
+uint32_t bfloat16_to_uint32_scalbn(bfloat16 a, FloatRoundMode rmode,
+                                   int scale, float_status *s)
+{
+    return round_to_uint_and_pack(bfloat16_unpack_canonical(a, s),
+                                  rmode, scale, UINT32_MAX, s);
+}
+
+uint64_t bfloat16_to_uint64_scalbn(bfloat16 a, FloatRoundMode rmode,
+                                   int scale, float_status *s)
+{
+    return round_to_uint_and_pack(bfloat16_unpack_canonical(a, s),
+                                  rmode, scale, UINT64_MAX, s);
+}
+
+uint16_t bfloat16_to_uint16(bfloat16 a, float_status *s)
+{
+    return bfloat16_to_uint16_scalbn(a, s->float_rounding_mode, 0, s);
+}
+
+uint32_t bfloat16_to_uint32(bfloat16 a, float_status *s)
+{
+    return bfloat16_to_uint32_scalbn(a, s->float_rounding_mode, 0, s);
+}
+
+uint64_t bfloat16_to_uint64(bfloat16 a, float_status *s)
+{
+    return bfloat16_to_uint64_scalbn(a, s->float_rounding_mode, 0, s);
+}
+
+uint16_t bfloat16_to_uint16_round_to_zero(bfloat16 a, float_status *s)
+{
+    return bfloat16_to_uint16_scalbn(a, float_round_to_zero, 0, s);
+}
+
+uint32_t bfloat16_to_uint32_round_to_zero(bfloat16 a, float_status *s)
+{
+    return bfloat16_to_uint32_scalbn(a, float_round_to_zero, 0, s);
+}
+
+uint64_t bfloat16_to_uint64_round_to_zero(bfloat16 a, float_status *s)
+{
+    return bfloat16_to_uint64_scalbn(a, float_round_to_zero, 0, s);
+}
+
 /*
  * Integer to float conversions
  *
@@ -2721,6 +2873,41 @@ float64 int16_to_float64(int16_t a, float_status *status)
     return int64_to_float64_scalbn(a, 0, status);
 }
 
+/*
+ * Returns the result of converting the two's complement integer `a'
+ * to the bfloat16 format.
+ */
+
+bfloat16 int64_to_bfloat16_scalbn(int64_t a, int scale, float_status *status)
+{
+    FloatParts pa = int_to_float(a, scale, status);
+    return bfloat16_round_pack_canonical(pa, status);
+}
+
+bfloat16 int32_to_bfloat16_scalbn(int32_t a, int scale, float_status *status)
+{
+    return int64_to_bfloat16_scalbn(a, scale, status);
+}
+
+bfloat16 int16_to_bfloat16_scalbn(int16_t a, int scale, float_status *status)
+{
+    return int64_to_bfloat16_scalbn(a, scale, status);
+}
+
+bfloat16 int64_to_bfloat16(int64_t a, float_status *status)
+{
+    return int64_to_bfloat16_scalbn(a, 0, status);
+}
+
+bfloat16 int32_to_bfloat16(int32_t a, float_status *status)
+{
+    return int64_to_bfloat16_scalbn(a, 0, status);
+}
+
+bfloat16 int16_to_bfloat16(int16_t a, float_status *status)
+{
+    return int64_to_bfloat16_scalbn(a, 0, status);
+}
 
 /*
  * Unsigned Integer to float conversions
@@ -2851,6 +3038,42 @@ float64 uint16_to_float64(uint16_t a, float_status *status)
     return uint64_to_float64_scalbn(a, 0, status);
 }
 
+/*
+ * Returns the result of converting the unsigned integer `a' to the
+ * bfloat16 format.
+ */
+
+bfloat16 uint64_to_bfloat16_scalbn(uint64_t a, int scale, float_status *status)
+{
+    FloatParts pa = uint_to_float(a, scale, status);
+    return bfloat16_round_pack_canonical(pa, status);
+}
+
+bfloat16 uint32_to_bfloat16_scalbn(uint32_t a, int scale, float_status *status)
+{
+    return uint64_to_bfloat16_scalbn(a, scale, status);
+}
+
+bfloat16 uint16_to_bfloat16_scalbn(uint16_t a, int scale, float_status *status)
+{
+    return uint64_to_bfloat16_scalbn(a, scale, status);
+}
+
+bfloat16 uint64_to_bfloat16(uint64_t a, float_status *status)
+{
+    return uint64_to_bfloat16_scalbn(a, 0, status);
+}
+
+bfloat16 uint32_to_bfloat16(uint32_t a, float_status *status)
+{
+    return uint64_to_bfloat16_scalbn(a, 0, status);
+}
+
+bfloat16 uint16_to_bfloat16(uint16_t a, float_status *status)
+{
+    return uint64_to_bfloat16_scalbn(a, 0, status);
+}
+
 /* Float Min/Max */
 /* min() and max() functions. These can't be implemented as
  * 'compare and pick one input' because that would mishandle
-- 
2.25.1



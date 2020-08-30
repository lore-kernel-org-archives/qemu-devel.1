Return-Path: <SRS0=e36u=CI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3489C433E2
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2020 02:34:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88EEE2075B
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2020 02:34:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eujSZMG0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88EEE2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCDAm-00075A-Oe
	for qemu-devel@archiver.kernel.org; Sat, 29 Aug 2020 22:34:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52810)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCD8e-0002cL-ML
 for qemu-devel@nongnu.org; Sat, 29 Aug 2020 22:32:12 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f]:33343)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCD8c-0002XG-O0
 for qemu-devel@nongnu.org; Sat, 29 Aug 2020 22:32:12 -0400
Received: by mail-pf1-x42f.google.com with SMTP id u20so2685743pfn.0
 for <qemu-devel@nongnu.org>; Sat, 29 Aug 2020 19:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2o0LpaVcYKa7uZBP60GqezuNuuAdNkWUvWUtF7iSdv4=;
 b=eujSZMG0/JDvnPfdM0oEMgzSKGBq+JEX7D1r3kCiXwk9WxvVnt7YXJpm9Mg6kFXynH
 nSNkHWRRBh7X55ghR2/JbXSfN6Nruszm+wvGF5Z8DyxcZp5VD9r3wnMqWjA70vnRGmog
 Hg9Lb4Zj7I1vzP13uOsUfynJvz31AaBnYlVYweXieYp8iOhxO9kTUyvm6ZlFrsAwK7oS
 5R13Wl+aDuZmoa27Hvj/sW9IospFdTM+kn7TyWLs9FYF9UWYvoZphXn8XgYSauCiDfUs
 AzPVfb/3MN9ccTySf2quLmCgIKz8gfFQcuC8W7bPdgDpwxHbjrzjQWRdsorZfnoeWb/v
 EQ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2o0LpaVcYKa7uZBP60GqezuNuuAdNkWUvWUtF7iSdv4=;
 b=RILAFOwCv1LYq4Udf0wpLXi8cnvgBAIw3xEpQF+SAxkj6IfwpH9DqjIo2lKfBWWdtq
 0AZgJKs3zxS1ioRZmbMNT1GHofVcIJEJEM8z3FhCQd8EUW5VzSo4MtBg4hOsFR3E4qJG
 vyU9M9I1uArGfTGQLMFOJxSGUSSRN/1OiZsOJ+j6YWxL4VvNeZpN8kiIgOxbGHPsk1iM
 ngOtXuI2NWOrEC/FMy9yTM3m6wVQVImXMuKOwYNbcXbUEX3CeeTSVpOvWAYvtmcnrH87
 d0Z9lGG4D3fvZHhMSaKiglE62X86UL98sbn4D5aS1J9EOHGMIVtGBlUJea4rHs4Z5ESV
 TCJg==
X-Gm-Message-State: AOAM533zQvDOfqzUl1V47nWvt/pd5fDKULFCHBnBXc3dnI5YojcjLJzU
 Kj5Eyhnh1pBTaHkACpiVhdMZQ5JCDc2mZg==
X-Google-Smtp-Source: ABdhPJxXRw7rnxzcNbtJY2c8ipTjgkXmTO1PtqASMfw30neYE4zw0LtA/sOuG/eOMtDC2RyMpxM6iA==
X-Received: by 2002:a63:cb0a:: with SMTP id p10mr44139pgg.314.1598754728656;
 Sat, 29 Aug 2020 19:32:08 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id l23sm3546269pgt.16.2020.08.29.19.32.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 29 Aug 2020 19:32:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 2/7] softfloat: Add fp16 and uint8/int8 conversion functions
Date: Sat, 29 Aug 2020 19:31:58 -0700
Message-Id: <20200830023203.612312-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200830023203.612312-1-richard.henderson@linaro.org>
References: <20200830023203.612312-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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
Cc: Frank Chang <frank.chang@sifive.com>, peter.maydell@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Frank Chang <frank.chang@sifive.com>

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Frank Chang <frank.chang@sifive.com>
Message-Id: <1596102747-20226-4-git-send-email-chihmin.chao@sifive.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/fpu/softfloat.h |  8 ++++++++
 fpu/softfloat.c         | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index 573fce99bc..0a5a5e5d0b 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -136,9 +136,11 @@ float16 uint16_to_float16_scalbn(uint16_t a, int, float_status *status);
 float16 uint32_to_float16_scalbn(uint32_t a, int, float_status *status);
 float16 uint64_to_float16_scalbn(uint64_t a, int, float_status *status);
 
+float16 int8_to_float16(int8_t a, float_status *status);
 float16 int16_to_float16(int16_t a, float_status *status);
 float16 int32_to_float16(int32_t a, float_status *status);
 float16 int64_to_float16(int64_t a, float_status *status);
+float16 uint8_to_float16(uint8_t a, float_status *status);
 float16 uint16_to_float16(uint16_t a, float_status *status);
 float16 uint32_to_float16(uint32_t a, float_status *status);
 float16 uint64_to_float16(uint64_t a, float_status *status);
@@ -187,10 +189,13 @@ float32 float16_to_float32(float16, bool ieee, float_status *status);
 float16 float64_to_float16(float64 a, bool ieee, float_status *status);
 float64 float16_to_float64(float16 a, bool ieee, float_status *status);
 
+int8_t  float16_to_int8_scalbn(float16, FloatRoundMode, int,
+                               float_status *status);
 int16_t float16_to_int16_scalbn(float16, FloatRoundMode, int, float_status *);
 int32_t float16_to_int32_scalbn(float16, FloatRoundMode, int, float_status *);
 int64_t float16_to_int64_scalbn(float16, FloatRoundMode, int, float_status *);
 
+int8_t  float16_to_int8(float16, float_status *status);
 int16_t float16_to_int16(float16, float_status *status);
 int32_t float16_to_int32(float16, float_status *status);
 int64_t float16_to_int64(float16, float_status *status);
@@ -199,6 +204,8 @@ int16_t float16_to_int16_round_to_zero(float16, float_status *status);
 int32_t float16_to_int32_round_to_zero(float16, float_status *status);
 int64_t float16_to_int64_round_to_zero(float16, float_status *status);
 
+uint8_t float16_to_uint8_scalbn(float16 a, FloatRoundMode,
+                                int, float_status *status);
 uint16_t float16_to_uint16_scalbn(float16 a, FloatRoundMode,
                                   int, float_status *status);
 uint32_t float16_to_uint32_scalbn(float16 a, FloatRoundMode,
@@ -206,6 +213,7 @@ uint32_t float16_to_uint32_scalbn(float16 a, FloatRoundMode,
 uint64_t float16_to_uint64_scalbn(float16 a, FloatRoundMode,
                                   int, float_status *status);
 
+uint8_t  float16_to_uint8(float16 a, float_status *status);
 uint16_t float16_to_uint16(float16 a, float_status *status);
 uint32_t float16_to_uint32(float16 a, float_status *status);
 uint64_t float16_to_uint64(float16 a, float_status *status);
diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 33abc8207b..64de0b40f7 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -2109,6 +2109,13 @@ static int64_t round_to_int_and_pack(FloatParts in, FloatRoundMode rmode,
     }
 }
 
+int8_t float16_to_int8_scalbn(float16 a, FloatRoundMode rmode, int scale,
+                              float_status *s)
+{
+    return round_to_int_and_pack(float16_unpack_canonical(a, s),
+                                 rmode, scale, INT8_MIN, INT8_MAX, s);
+}
+
 int16_t float16_to_int16_scalbn(float16 a, FloatRoundMode rmode, int scale,
                                 float_status *s)
 {
@@ -2172,6 +2179,11 @@ int64_t float64_to_int64_scalbn(float64 a, FloatRoundMode rmode, int scale,
                                  rmode, scale, INT64_MIN, INT64_MAX, s);
 }
 
+int8_t float16_to_int8(float16 a, float_status *s)
+{
+    return float16_to_int8_scalbn(a, s->float_rounding_mode, 0, s);
+}
+
 int16_t float16_to_int16(float16 a, float_status *s)
 {
     return float16_to_int16_scalbn(a, s->float_rounding_mode, 0, s);
@@ -2322,6 +2334,13 @@ static uint64_t round_to_uint_and_pack(FloatParts in, FloatRoundMode rmode,
     }
 }
 
+uint8_t float16_to_uint8_scalbn(float16 a, FloatRoundMode rmode, int scale,
+                                float_status *s)
+{
+    return round_to_uint_and_pack(float16_unpack_canonical(a, s),
+                                  rmode, scale, UINT8_MAX, s);
+}
+
 uint16_t float16_to_uint16_scalbn(float16 a, FloatRoundMode rmode, int scale,
                                   float_status *s)
 {
@@ -2385,6 +2404,11 @@ uint64_t float64_to_uint64_scalbn(float64 a, FloatRoundMode rmode, int scale,
                                   rmode, scale, UINT64_MAX, s);
 }
 
+uint8_t float16_to_uint8(float16 a, float_status *s)
+{
+    return float16_to_uint8_scalbn(a, s->float_rounding_mode, 0, s);
+}
+
 uint16_t float16_to_uint16(float16 a, float_status *s)
 {
     return float16_to_uint16_scalbn(a, s->float_rounding_mode, 0, s);
@@ -2539,6 +2563,11 @@ float16 int16_to_float16(int16_t a, float_status *status)
     return int64_to_float16_scalbn(a, 0, status);
 }
 
+float16 int8_to_float16(int8_t a, float_status *status)
+{
+    return int64_to_float16_scalbn(a, 0, status);
+}
+
 float32 int64_to_float32_scalbn(int64_t a, int scale, float_status *status)
 {
     FloatParts pa = int_to_float(a, scale, status);
@@ -2664,6 +2693,11 @@ float16 uint16_to_float16(uint16_t a, float_status *status)
     return uint64_to_float16_scalbn(a, 0, status);
 }
 
+float16 uint8_to_float16(uint8_t a, float_status *status)
+{
+    return uint64_to_float16_scalbn(a, 0, status);
+}
+
 float32 uint64_to_float32_scalbn(uint64_t a, int scale, float_status *status)
 {
     FloatParts pa = uint_to_float(a, scale, status);
-- 
2.25.1



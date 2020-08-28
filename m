Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A02BC433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 18:43:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46BB220737
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 18:43:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A8HfjYAZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46BB220737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBjLp-0008UQ-B4
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 14:43:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59040)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBjCn-0002ha-D7
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 14:34:29 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:38679)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBjCi-00060w-QP
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 14:34:28 -0400
Received: by mail-wm1-x342.google.com with SMTP id t14so114711wmi.3
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 11:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=xRS9Xs/A7cPVwavP2/d7CO6TOTh4dxr4Fh4pdaLz/eQ=;
 b=A8HfjYAZwLPq0tRJ5qS8TzXe1/JhbJHag5h1dm2XNuM7VjCHSnFOIgjy1ehFf3+pvg
 RQhd8DekjEFX2I9k/97I+d6nkusgG+mSY+p68Eo/H5OwUn8qHVZQSom6XurqQwLhAQkg
 /lKBMDOu+GNpsRWWTjSNhqQrbVhKa3f5P9TaIaTBpQZaOtA0ibLroXfU7uuJLPHV3NWY
 m4CGt7v0CXrwtFLSkTzg7Yb8KR4mkP4c70yK+3o3D5fn7TAlkngLmVQ6b0G1D7XHyUgx
 G7aLhRPr0cR4jOTwPaz1uTCrk9ma3FT8Y5ZBnfA6QQIkIGu50RobUT8CDMA3A263XgLr
 TmtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xRS9Xs/A7cPVwavP2/d7CO6TOTh4dxr4Fh4pdaLz/eQ=;
 b=I0CGUXWioQYtG1XcjNp8cd28vJwJJjDhxQPgSKw8C6RTcGBl2kfapKrD25/8kElpUo
 yjTPOlW98A06mgNiwQ3cNqgfUcofBc+7Zxp73yglKw7MXuxfL8UjxbTg0EK64e567GAc
 Zb2e4yZXqLmXn6cRb8H/2rC3V0iVNb6hbGPczS9iPKJN1uba5jEuheUhvoCWT7Vx/cim
 0hx+nMDXDdMwstMcscqRGrjXk9bTEp2qCw48QaH1DjtMw+cWNjvL26Mmt5Lqx4GADsPn
 blfgr2zNbf6lSHajC1NJNPKMznoKCKYIzM2AkhC7rAXCB9BmqFZGSygfOK8fte9s2bji
 SuUg==
X-Gm-Message-State: AOAM531ufjvLs7fyTZugx4Quvt9Yb5LvZa2dbWtvAjPwdxEA+ltSnptq
 Enn/Tep9QrTQ3x4riLeogl+H/A==
X-Google-Smtp-Source: ABdhPJwx/CqW1Qyw/jpFGdsdtZU00Qc5CjpLx/qkwPcUEdwLcQnoSM1q91XhViXe9Or7uZFqxoAb4g==
X-Received: by 2002:a7b:c925:: with SMTP id h5mr52680wml.28.1598639663462;
 Fri, 28 Aug 2020 11:34:23 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id s20sm356251wmh.21.2020.08.28.11.34.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 11:34:22 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 22/45] fpu: Add float16 comparison functions
Date: Fri, 28 Aug 2020 19:33:31 +0100
Message-Id: <20200828183354.27913-23-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200828183354.27913-1-peter.maydell@linaro.org>
References: <20200828183354.27913-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x342.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add comparison functions for float16 to match the existing float32
and float64 ones:

 float16_eq()
 float16_le()
 float16_lt()
 float16_unordered()
 float16_eq_quiet()
 float16_le_quiet()
 float16_lt_quiet()
 float16_unordered_quiet()

These are all just convenience wrappers around float16_compare() and
float16_compare_quiet().  We will want these for AArch23 fp16
support.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/fpu/softfloat.h | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index 659218b5c78..573fce99bc6 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -285,6 +285,47 @@ static inline float16 float16_set_sign(float16 a, int sign)
     return make_float16((float16_val(a) & 0x7fff) | (sign << 15));
 }
 
+static inline bool float16_eq(float16 a, float16 b, float_status *s)
+{
+    return float16_compare(a, b, s) == float_relation_equal;
+}
+
+static inline bool float16_le(float16 a, float16 b, float_status *s)
+{
+    return float16_compare(a, b, s) <= float_relation_equal;
+}
+
+static inline bool float16_lt(float16 a, float16 b, float_status *s)
+{
+    return float16_compare(a, b, s) < float_relation_equal;
+}
+
+static inline bool float16_unordered(float16 a, float16 b, float_status *s)
+{
+    return float16_compare(a, b, s) == float_relation_unordered;
+}
+
+static inline bool float16_eq_quiet(float16 a, float16 b, float_status *s)
+{
+    return float16_compare_quiet(a, b, s) == float_relation_equal;
+}
+
+static inline bool float16_le_quiet(float16 a, float16 b, float_status *s)
+{
+    return float16_compare_quiet(a, b, s) <= float_relation_equal;
+}
+
+static inline bool float16_lt_quiet(float16 a, float16 b, float_status *s)
+{
+    return float16_compare_quiet(a, b, s) < float_relation_equal;
+}
+
+static inline bool float16_unordered_quiet(float16 a, float16 b,
+                                           float_status *s)
+{
+    return float16_compare_quiet(a, b, s) == float_relation_unordered;
+}
+
 #define float16_zero make_float16(0)
 #define float16_half make_float16(0x3800)
 #define float16_one make_float16(0x3c00)
-- 
2.20.1



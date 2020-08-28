Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F262C433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 17:54:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14F4F20776
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 17:54:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GryS6awY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14F4F20776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBia7-0006pj-8y
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 13:54:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49158)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBiZZ-0006OA-IV
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 13:53:57 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:33040)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBiZX-00013G-T6
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 13:53:57 -0400
Received: by mail-pl1-x644.google.com with SMTP id h2so29894plr.0
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 10:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ESRQ16shKiPsdhAFOwhgeGelAes/sl5sAKot+LF0/gE=;
 b=GryS6awYUfmCDP9wUFtRSGDLduscdYTmcHUydeBW5Xyef3f1hr1Evlxz8gyglcy4W0
 RMNpMiBwcSQC7G6BIoC6ONDRKAjWP4zjKlse2zeBVY3kphLBhfstnC8Mq5qJBsC8YJ5F
 Fg/kMzq9YjMjsUcPeYlQYg67wZmENdXfM1u60PhAgOzdXvCEkokan//LH+40bTq3LCfe
 AE81gUsRugrbqTIBhPeBvytsdzV3o2u48gzdm3oohAZZUsY4S6mIcTTyQaikZWB0JHPr
 mWrrCDbiMEt6nERXPIo1j728LO0W8CoN/XU1/WZ2IZ0quJNydY3w/fIa2jOwyeHPp6BE
 sJtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ESRQ16shKiPsdhAFOwhgeGelAes/sl5sAKot+LF0/gE=;
 b=IzEJsDzDSKq4ssrlmLXUMp9i8C7snD42Xf3mtZ/pd6DhZHVyCMBZ0mvN9B6S0Wbire
 2aPKbJQIWBfJLnbGb0lmZXAHU7QZ85m51NKrwwIFgLpBapZPnzobeZETd6ykd1mns7at
 m3U8UIF8/umk9qqPa3Gzrq7f8O8HOLWWVyK2IedSxrS++snA17DUWB11f02f4Yx/oinF
 59FXNxI02QzhKgbLkQnTK+l7D1ELmq8WsRB5y11012zfTi9UxDMa0p889q9EO4hqy112
 BLSMIWvmz5qYI0gnGCPlqaXXOJT8IAKIkWSWcmpK5MY4C+g1OvnYpARhuruK2UjoaVyL
 +pbQ==
X-Gm-Message-State: AOAM531HzZflDSe/8lcpgQ1qUYVfKx/o1njwWj1wc7DpuxQdSzKU8Dvs
 oIkRt6hlrkmEYAcMXM6/xXE2Hm2Jg4mELw==
X-Google-Smtp-Source: ABdhPJzets8BgtrMeJvG/HKDl3DIFJ5CYdO0lHekHRXS602UXL9/m/Cz2sc/t7Z+8LUPp7aUeWBenw==
X-Received: by 2002:a17:902:9693:: with SMTP id n19mr44953plp.33.1598637233849; 
 Fri, 28 Aug 2020 10:53:53 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id u2sm79721pjj.57.2020.08.28.10.53.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 10:53:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] softfloat: Define comparison operations for bfloat16
Date: Fri, 28 Aug 2020 10:53:51 -0700
Message-Id: <20200828175351.435119-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x644.google.com
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
Cc: zhiwei_liu@c-sky.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These operations were missed in Zhiwei's bfloat16 implementation.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/fpu/softfloat.h | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/include/fpu/softfloat.h b/include/fpu/softfloat.h
index 1233f98014..78ad5ca738 100644
--- a/include/fpu/softfloat.h
+++ b/include/fpu/softfloat.h
@@ -479,6 +479,47 @@ static inline bfloat16 bfloat16_set_sign(bfloat16 a, int sign)
     return (a & 0x7fff) | (sign << 15);
 }
 
+static inline bool bfloat16_eq(bfloat16 a, bfloat16 b, float_status *s)
+{
+    return bfloat16_compare(a, b, s) == float_relation_equal;
+}
+
+static inline bool bfloat16_le(bfloat16 a, bfloat16 b, float_status *s)
+{
+    return bfloat16_compare(a, b, s) <= float_relation_equal;
+}
+
+static inline bool bfloat16_lt(bfloat16 a, bfloat16 b, float_status *s)
+{
+    return bfloat16_compare(a, b, s) < float_relation_equal;
+}
+
+static inline bool bfloat16_unordered(bfloat16 a, bfloat16 b, float_status *s)
+{
+    return bfloat16_compare(a, b, s) == float_relation_unordered;
+}
+
+static inline bool bfloat16_eq_quiet(bfloat16 a, bfloat16 b, float_status *s)
+{
+    return bfloat16_compare_quiet(a, b, s) == float_relation_equal;
+}
+
+static inline bool bfloat16_le_quiet(bfloat16 a, bfloat16 b, float_status *s)
+{
+    return bfloat16_compare_quiet(a, b, s) <= float_relation_equal;
+}
+
+static inline bool bfloat16_lt_quiet(bfloat16 a, bfloat16 b, float_status *s)
+{
+    return bfloat16_compare_quiet(a, b, s) < float_relation_equal;
+}
+
+static inline bool bfloat16_unordered_quiet(bfloat16 a, bfloat16 b,
+                                           float_status *s)
+{
+    return bfloat16_compare_quiet(a, b, s) == float_relation_unordered;
+}
+
 #define bfloat16_zero 0
 #define bfloat16_half 0x3f00
 #define bfloat16_one 0x3f80
-- 
2.25.1



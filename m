Return-Path: <SRS0=vx8y=AW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 315C0C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 11:15:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF95F2078B
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 11:15:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fmbfmWnY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF95F2078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juDTm-0000I2-8F
	for qemu-devel@archiver.kernel.org; Sat, 11 Jul 2020 07:15:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52798)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1juDMR-0004k1-GS
 for qemu-devel@nongnu.org; Sat, 11 Jul 2020 07:08:04 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:45161)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1juDMP-0006Oc-TQ
 for qemu-devel@nongnu.org; Sat, 11 Jul 2020 07:08:03 -0400
Received: by mail-pg1-x541.google.com with SMTP id l63so3675272pge.12
 for <qemu-devel@nongnu.org>; Sat, 11 Jul 2020 04:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=u5pNc58LSW/mVbNadM3j8yq8mljScJx0bRZxn+H2F0k=;
 b=fmbfmWnYPm2y/fn1JQiKHxhidUK6DJPFNTWOaM/KPcSeaxitzZx2bvkGJR+1a158Va
 TKu7sYYKtmFC3xz2l3YoXbogWBwoMtAiMTGCkjpOyUMrLxfob/qMz0Thsq95ly9Td2cP
 zi/6auiZ/um8+0LFLrhqh/6cdLtUORl0vjy+dXGczaaUCMjwi9iZJ9opffLuNrN/q3Nw
 MGE6AOVw+DIjaJFcHKCnmUisNVsVojOvLj9tL+AsFh8A5C5a3We29B6p+POgCE7geu2n
 r0gcwmsxyHkGhg1gzI/k9NKtvwEqExJseDgs6TWzncCvvZhOrxhQDAEpcQPi7CTTjjTl
 PqPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=u5pNc58LSW/mVbNadM3j8yq8mljScJx0bRZxn+H2F0k=;
 b=VEmt0b8X6pbFUyqgdt3Zpw0p3BY+1HqE6er9vzUHYvsOFPIOD6VLocMvhuNP1OgLS+
 kC9ax84fPdnVzLKeQ261ho5cVbqCywFog+3/8lzrYx9PoVJIKwKF8P7ovIcqStQyxTYH
 vvupK5ii0r9Kvuqm38IRuO7evLy58frG+t1u7MbhQTWnlNIz+Qr8WLRZjTf56sy2H0hJ
 gOrOTY5542sqjASBqDL53UCmw5PbuYd3D4mvj6iBgByte/kuyjJHd3xWar5IVZ2c9fd1
 42TnnuxN4nyQl5itnOncXGTXFpzRu7QLAW6QrscTxyOIu110h+BOjEPyPo04jRgvSIE3
 9xyA==
X-Gm-Message-State: AOAM532AyNNp7YVC0+cQiEAV5JX/LFiHNhSeq6HI9KpVCs+cxsevvXev
 xYrVkX3DLhrZR2G7uBlxx3KeJzG8
X-Google-Smtp-Source: ABdhPJw4T9ZgE0a8RGpJoW3AU/TpEMTukDyaZaqrUjfRsV2z9Pyf5tafwfcffyZH+//drDEfK5ciRw==
X-Received: by 2002:a63:7c5e:: with SMTP id l30mr61591493pgn.276.1594465680374; 
 Sat, 11 Jul 2020 04:08:00 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net
 ([2601:641:400:e00:19b7:f650:7bbe:a7fb])
 by smtp.gmail.com with ESMTPSA id m31sm8925826pjb.52.2020.07.11.04.07.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Jul 2020 04:07:59 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 14/22] tests/tcg/xtensa: expand madd tests
Date: Sat, 11 Jul 2020 04:06:49 -0700
Message-Id: <20200711110655.20287-15-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200711110655.20287-1-jcmvbkbc@gmail.com>
References: <20200711110655.20287-1-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=jcmvbkbc@gmail.com; helo=mail-pg1-x541.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Max Filippov <jcmvbkbc@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Test that madd doesn't do rounding after multiplication.
Test NaN propagation rules for FPU2000 and DFPU madd opcode.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
Changes v2->v3:
- add more infzero tests for FPU2000 and DFPU

 tests/tcg/xtensa/test_fp0_arith.S | 104 ++++++++++++++++++++++++++++++
 1 file changed, 104 insertions(+)

diff --git a/tests/tcg/xtensa/test_fp0_arith.S b/tests/tcg/xtensa/test_fp0_arith.S
index df870eb7a013..7eefc1da409d 100644
--- a/tests/tcg/xtensa/test_fp0_arith.S
+++ b/tests/tcg/xtensa/test_fp0_arith.S
@@ -146,6 +146,110 @@ test madd_s
              FSR_I,      FSR_I,      FSR_I,      FSR_I
 test_end
 
+test madd_s_precision
+    test_op3 madd.s, f0, f1, f2, f0, 0xbf800002, 0x3f800001, 0x3f800001, \
+        0x28800000, 0x28800000, 0x28800000, 0x28800000, \
+             FSR__,      FSR__,      FSR__,      FSR__
+test_end
+
+#if DFPU
+test madd_s_nan_dfpu
+    /* DFPU madd/msub NaN1, NaN2, NaN3 priority: NaN1, NaN3, NaN2 */
+    test_op3 madd.s, f0, f1, f2, f0, F32_QNAN(1), F32_1, F32_1, \
+        F32_QNAN(1), F32_QNAN(1), F32_QNAN(1), F32_QNAN(1), \
+              FSR__,       FSR__,       FSR__,       FSR__
+    test_op3 madd.s, f0, f1, f2, f0, F32_1, F32_QNAN(2), F32_1, \
+        F32_QNAN(2), F32_QNAN(2), F32_QNAN(2), F32_QNAN(2), \
+              FSR__,       FSR__,       FSR__,       FSR__
+    test_op3 madd.s, f0, f1, f2, f0, F32_1, F32_1, F32_QNAN(3), \
+        F32_QNAN(3), F32_QNAN(3), F32_QNAN(3), F32_QNAN(3), \
+              FSR__,       FSR__,       FSR__,       FSR__
+
+    test_op3 madd.s, f0, f1, f2, f0, F32_QNAN(1), F32_QNAN(2), F32_1, \
+        F32_QNAN(1), F32_QNAN(1), F32_QNAN(1), F32_QNAN(1), \
+              FSR__,       FSR__,       FSR__,       FSR__
+    test_op3 madd.s, f0, f1, f2, f0, F32_QNAN(1), F32_1, F32_QNAN(3), \
+        F32_QNAN(1), F32_QNAN(1), F32_QNAN(1), F32_QNAN(1), \
+              FSR__,       FSR__,       FSR__,       FSR__
+    test_op3 madd.s, f0, f1, f2, f0, F32_1, F32_QNAN(2), F32_QNAN(3), \
+        F32_QNAN(3), F32_QNAN(3), F32_QNAN(3), F32_QNAN(3), \
+              FSR__,       FSR__,       FSR__,       FSR__
+
+    test_op3 madd.s, f0, f1, f2, f0, F32_QNAN(1), F32_QNAN(2), F32_QNAN(3), \
+        F32_QNAN(1), F32_QNAN(1), F32_QNAN(1), F32_QNAN(1), \
+              FSR__,       FSR__,       FSR__,       FSR__
+
+    /* inf * 0 = default NaN */
+    test_op3 madd.s, f0, f1, f2, f0, F32_1, F32_PINF, F32_0, \
+        F32_DNAN, F32_DNAN, F32_DNAN, F32_DNAN, \
+           FSR_V,    FSR_V,    FSR_V,    FSR_V
+    /* inf * 0 + SNaN1 = QNaN1 */
+    test_op3 madd.s, f0, f1, f2, f0, F32_SNAN(1), F32_PINF, F32_0, \
+        F32_QNAN(1), F32_QNAN(1), F32_QNAN(1), F32_QNAN(1), \
+              FSR_V,       FSR_V,       FSR_V,       FSR_V
+    /* inf * 0 + QNaN1 = QNaN1 */
+    test_op3 madd.s, f0, f1, f2, f0, F32_QNAN(1), F32_PINF, F32_0, \
+        F32_QNAN(1), F32_QNAN(1), F32_QNAN(1), F32_QNAN(1), \
+              FSR_V,       FSR_V,       FSR_V,       FSR_V
+
+    /* madd/msub SNaN turns to QNaN and sets Invalid flag */
+    test_op3 madd.s, f0, f1, f2, f0, F32_SNAN(1), F32_1, F32_1, \
+        F32_QNAN(1), F32_QNAN(1), F32_QNAN(1), F32_QNAN(1), \
+              FSR_V,       FSR_V,       FSR_V,       FSR_V
+    test_op3 madd.s, f0, f1, f2, f0, F32_QNAN(1), F32_SNAN(2), F32_1, \
+        F32_QNAN(1), F32_QNAN(1), F32_QNAN(1), F32_QNAN(1), \
+              FSR_V,       FSR_V,       FSR_V,       FSR_V
+test_end
+#else
+test madd_s_nan_fpu2k
+    /* FPU2000 madd/msub NaN1, NaN2, NaN3 priority: NaN2, NaN3, NaN1 */
+    test_op3 madd.s, f0, f1, f2, f0, F32_QNAN(1), F32_1, F32_1, \
+        F32_QNAN(1), F32_QNAN(1), F32_QNAN(1), F32_QNAN(1), \
+              FSR__,       FSR__,       FSR__,       FSR__
+    test_op3 madd.s, f0, f1, f2, f0, F32_1, F32_QNAN(2), F32_1, \
+        F32_QNAN(2), F32_QNAN(2), F32_QNAN(2), F32_QNAN(2), \
+              FSR__,       FSR__,       FSR__,       FSR__
+    test_op3 madd.s, f0, f1, f2, f0, F32_1, F32_1, F32_QNAN(3), \
+        F32_QNAN(3), F32_QNAN(3), F32_QNAN(3), F32_QNAN(3), \
+              FSR__,       FSR__,       FSR__,       FSR__
+
+    test_op3 madd.s, f0, f1, f2, f0, F32_QNAN(1), F32_QNAN(2), F32_1, \
+        F32_QNAN(2), F32_QNAN(2), F32_QNAN(2), F32_QNAN(2), \
+              FSR__,       FSR__,       FSR__,       FSR__
+    test_op3 madd.s, f0, f1, f2, f0, F32_QNAN(1), F32_1, F32_QNAN(3), \
+        F32_QNAN(3), F32_QNAN(3), F32_QNAN(3), F32_QNAN(3), \
+              FSR__,       FSR__,       FSR__,       FSR__
+    test_op3 madd.s, f0, f1, f2, f0, F32_1, F32_QNAN(2), F32_QNAN(3), \
+        F32_QNAN(2), F32_QNAN(2), F32_QNAN(2), F32_QNAN(2), \
+              FSR__,       FSR__,       FSR__,       FSR__
+
+    test_op3 madd.s, f0, f1, f2, f0, F32_QNAN(1), F32_QNAN(2), F32_QNAN(3), \
+        F32_QNAN(2), F32_QNAN(2), F32_QNAN(2), F32_QNAN(2), \
+              FSR__,       FSR__,       FSR__,       FSR__
+
+    /* inf * 0 = default NaN */
+    test_op3 madd.s, f0, f1, f2, f0, F32_1, F32_PINF, F32_0, \
+        F32_DNAN, F32_DNAN, F32_DNAN, F32_DNAN, \
+           FSR__,    FSR__,    FSR__,    FSR__
+    /* inf * 0 + SNaN1 = SNaN1 */
+    test_op3 madd.s, f0, f1, f2, f0, F32_SNAN(1), F32_PINF, F32_0, \
+        F32_SNAN(1), F32_SNAN(1), F32_SNAN(1), F32_SNAN(1), \
+              FSR__,       FSR__,       FSR__,       FSR__
+    /* inf * 0 + QNaN1 = QNaN1 */
+    test_op3 madd.s, f0, f1, f2, f0, F32_QNAN(1), F32_PINF, F32_0, \
+        F32_QNAN(1), F32_QNAN(1), F32_QNAN(1), F32_QNAN(1), \
+              FSR__,       FSR__,       FSR__,       FSR__
+
+    /* madd/msub SNaN is preserved */
+    test_op3 madd.s, f0, f1, f2, f0, F32_SNAN(1), F32_1, F32_1, \
+        F32_SNAN(1), F32_SNAN(1), F32_SNAN(1), F32_SNAN(1), \
+              FSR__,       FSR__,       FSR__,       FSR__
+    test_op3 madd.s, f0, f1, f2, f0, F32_QNAN(1), F32_SNAN(2), F32_1, \
+        F32_SNAN(2), F32_SNAN(2), F32_SNAN(2), F32_SNAN(2), \
+              FSR__,       FSR__,       FSR__,       FSR__
+test_end
+#endif
+
 test msub_s
     test_op3 msub.s, f0, f1, f2, f0, 0x3f800000, 0x3f800001, 0x3f800001, \
         0xb4800000, 0xb4800000, 0xb4800000, 0xb4800001, \
-- 
2.20.1



Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9669C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:45:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7150A206F6
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:45:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mHY6U1mS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7150A206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtIoV-0007Gq-JZ
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 18:45:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48872)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1jtIS7-0002s1-U0
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 18:22:07 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:35903)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1jtIS6-00018S-6T
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 18:22:07 -0400
Received: by mail-pj1-x1042.google.com with SMTP id md7so183473pjb.1
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2020 15:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=u5pNc58LSW/mVbNadM3j8yq8mljScJx0bRZxn+H2F0k=;
 b=mHY6U1mS9rbRFMDL+X7IDXHPXs/NyvFXHDfIPougzp8EarhNupYchYurP21ceZ5P6T
 dX906iJdxBj1ImdFi/fH0T/gjhlOwXN6392qNGHhPjK37jIXBYv/hiBmnlc+MNaWhbyc
 6o/jjjzD9yJeNkhx0TUwIPIwva9s8gis1NhDxQsdZfEAS93u89/sTkPOZ4F/gl79tzWb
 BnpBWJQLMearqgn4CY2872aDPxgKcy4L26PZExUxR9aXUFGc31wQhFyxlpsHPp8Maty+
 iW2Th+m49b8dWd2J0s/zdV6ND1wmWjYeU7hTsiIh76f+iufVsQKY/0+EiJMWNN0Y5N6G
 CKaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=u5pNc58LSW/mVbNadM3j8yq8mljScJx0bRZxn+H2F0k=;
 b=djLnD7T6GmEcZCg7D9CZveidB1IdfMIQpc4TlQ6Tku0pmxlNq4d4TVzFgs7wEJ2R+N
 RQOmxifhbO9zuZIjoROPaFFJpC4wF1gYh1cBn14olDmyeFkfnV/Gtu2jVkvvZhxNrqoi
 pr+cL47z1mMyNPieTW595wGE249g5F/qXtrbM0go0Kk5A0T648X3yLo4Di1mjWHdO+Zp
 bgDBXvhq17WWjrLz1DAjrZ3anp0VuCKzbMNN9KEoyCp26S76HHH1SpabOi6JV0QHD6Xd
 E5jic9BHiB0r0q6gAB0L1Sl4UqJeOzHxghA1Kkc3JYWmgwa2Z0xILwElxdQ6wvYNPG6V
 wa1g==
X-Gm-Message-State: AOAM533MrKUv1PN26zWkVCji5x2gVwE6tPo3CFNHcL8YX/yD9zM/KvB0
 cjP5QZ68YveYf9wgGzGVRuLJ4XuL
X-Google-Smtp-Source: ABdhPJwsTOQMktfMl8jsXdlvLLnRfE//Tx7VQmyI3M0cLSMMpEualNqojc+faUtKOjVX62U9U3q6dQ==
X-Received: by 2002:a17:90a:7ac6:: with SMTP id
 b6mr11836749pjl.213.1594246924829; 
 Wed, 08 Jul 2020 15:22:04 -0700 (PDT)
Received: from octofox.cadence.com ([2601:641:400:e00:19b7:f650:7bbe:a7fb])
 by smtp.gmail.com with ESMTPSA id t73sm693517pfc.78.2020.07.08.15.22.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2020 15:22:04 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 13/21] tests/tcg/xtensa: expand madd tests
Date: Wed,  8 Jul 2020 15:20:53 -0700
Message-Id: <20200708222101.24568-14-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200708222101.24568-1-jcmvbkbc@gmail.com>
References: <20200708222101.24568-1-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=jcmvbkbc@gmail.com; helo=mail-pj1-x1042.google.com
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
Cc: Max Filippov <jcmvbkbc@gmail.com>
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



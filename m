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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 042CEC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:49:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1D75206F6
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:49:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G9KyAQMW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1D75206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtIsQ-0007Qi-Ua
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 18:49:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49046)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1jtISE-000368-L5
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 18:22:14 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431]:42297)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1jtISB-00019q-U1
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 18:22:14 -0400
Received: by mail-pf1-x431.google.com with SMTP id 1so87930pfn.9
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2020 15:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=xYpaV1GaTiVYZ9sz0Ztnms68+FSNRF9gxImePs/wc/0=;
 b=G9KyAQMWpfYGaFyM8lcyQImOvFJKbza23TFMDJMo8XwDnc1rvwYNDICfBJ8nf10BMk
 y0WR98k/9FExOn/6uldvzZ/zQ/KTmSC71ITozBl16hia6guX5bTbVGhxA5QYsyeI9sZY
 pah/eRu27m9KToQgT4G/CpHQRrxXR93mEfu2Wk9/23EECeL9zVZKPq124L3pZez+VL4M
 BtJBzDP1Lh/l7qmls0yjGU6tqqOW1SaTouYp+FH7mZhnW7SiYxLpIc+BUMV1J6nZaqUS
 QJPPcAWqPYjHvaFVtbHWZ8gAhzxIIkNCxHbkKZWpFH2FEWgnO7uALFPf6C8JHAjX0nNg
 PLNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xYpaV1GaTiVYZ9sz0Ztnms68+FSNRF9gxImePs/wc/0=;
 b=bvkXksfOkZRcB0BcERDGdC4a5S5HjxjNWfDc0Ze2YwKMYRxEbTPmdhb3YxYrIrCBhy
 UYjQBbUm5nq0TVVpbwmpSTmaVzgEUttYciCmzIJaWCmGW2vVUtb9laOiqF2A9T9UfCB6
 ehbU96vw6fzBf5Rl5IBPrQ7OrREqVYEpo1lfcWfntVkBPzUsxhu2G+vuEIaSdxlnz5D2
 Fmotcq3X5S9bvCm9kY3IPBIEnRQ/7XdjK1DmzUbxX8na52FCWWtPcps/L9kOxvNK/6us
 LvYg+exQ/k8XouYhamNg9oH4y3P918Mc0yKiHcip7+7IkvygmTwegHQcJlhX2XUh9jCy
 UYwA==
X-Gm-Message-State: AOAM531yz9hLm5yFIrdT52FZk1tiRFoCBdLfqhM/kAhZV+5rf+Z3UNmD
 qW+KSxYh2cNcGagA/SCanTv0uiM2
X-Google-Smtp-Source: ABdhPJxTbwYcUCLpdfZj6w/69IP7SVCenPTQ+koCzjQoTO3UCxI+q1fekR55PODLnTBYYJRi2kYuuQ==
X-Received: by 2002:a62:8045:: with SMTP id j66mr54312393pfd.162.1594246930377; 
 Wed, 08 Jul 2020 15:22:10 -0700 (PDT)
Received: from octofox.cadence.com ([2601:641:400:e00:19b7:f650:7bbe:a7fb])
 by smtp.gmail.com with ESMTPSA id t73sm693517pfc.78.2020.07.08.15.22.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2020 15:22:09 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 19/21] tests/tcg/xtensa: add DFP0 arithmetic tests
Date: Wed,  8 Jul 2020 15:20:59 -0700
Message-Id: <20200708222101.24568-20-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200708222101.24568-1-jcmvbkbc@gmail.com>
References: <20200708222101.24568-1-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=jcmvbkbc@gmail.com; helo=mail-pf1-x431.google.com
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

Add test for basic double precision opcode properties.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
Changes v2->v3:
- add more infzero tests for DFPU
- fix test names in test_dfp0_arith.S

 tests/tcg/xtensa/test_dfp0_arith.S | 162 +++++++++++++++++++++++++++++
 1 file changed, 162 insertions(+)
 create mode 100644 tests/tcg/xtensa/test_dfp0_arith.S

diff --git a/tests/tcg/xtensa/test_dfp0_arith.S b/tests/tcg/xtensa/test_dfp0_arith.S
new file mode 100644
index 000000000000..53bf8122d082
--- /dev/null
+++ b/tests/tcg/xtensa/test_dfp0_arith.S
@@ -0,0 +1,162 @@
+#include "macros.inc"
+#include "fpu.h"
+
+test_suite fp0_arith
+
+#if XCHAL_HAVE_DFP
+
+.macro movfp fr, v
+    movi    a2, ((\v) >> 32) & 0xffffffff
+    movi    a3, ((\v) & 0xffffffff)
+    wfrd    \fr, a2, a3
+.endm
+
+.macro check_res fr, r, sr
+    rfrd    a2, \fr
+    dump    a2
+    movi    a3, ((\r) >> 32) & 0xffffffff
+    assert  eq, a2, a3
+    rfr    a2, \fr
+    dump    a2
+    movi    a3, ((\r) & 0xffffffff)
+    assert  eq, a2, a3
+    rur     a2, fsr
+    movi    a3, \sr
+    assert  eq, a2, a3
+.endm
+
+test add_d
+    movi    a2, 1
+    wsr     a2, cpenable
+
+    /* MAX_FLOAT + MAX_FLOAT = +inf/MAX_FLOAT  */
+    test_op2 add.d, f6, f7, f8, F64_MAX, F64_MAX, \
+        F64_PINF, F64_MAX, F64_PINF, F64_MAX, \
+          FSR_OI,  FSR_OI,   FSR_OI,  FSR_OI
+test_end
+
+test add_d_inf
+    /* 1 + +inf = +inf  */
+    test_op2 add.d, f6, f7, f8, F64_1, F64_PINF, \
+        F64_PINF, F64_PINF, F64_PINF, F64_PINF, \
+           FSR__,    FSR__,    FSR__,    FSR__
+
+    /* +inf + -inf = default NaN */
+    test_op2 add.d, f0, f1, f2, F64_PINF, F64_NINF, \
+        F64_DNAN, F64_DNAN, F64_DNAN, F64_DNAN, \
+           FSR_V,    FSR_V,    FSR_V,    FSR_V
+test_end
+
+test add_d_nan_dfpu
+    /* 1 + QNaN = QNaN  */
+    test_op2 add.d, f9, f10, f11, F64_1, F64_QNAN(1), \
+        F64_QNAN(1), F64_QNAN(1), F64_QNAN(1), F64_QNAN(1), \
+              FSR__,       FSR__,       FSR__,       FSR__
+    /* 1 + SNaN = QNaN  */
+    test_op2 add.d, f12, f13, f14, F64_1, F64_SNAN(1), \
+        F64_QNAN(1), F64_QNAN(1), F64_QNAN(1), F64_QNAN(1), \
+              FSR_V,       FSR_V,       FSR_V,       FSR_V
+
+    /* SNaN1 + SNaN2 = QNaN2 */
+    test_op2 add.d, f15, f0, f1, F64_SNAN(1), F64_SNAN(2), \
+        F64_QNAN(1), F64_QNAN(1), F64_QNAN(1), F64_QNAN(1), \
+              FSR_V,       FSR_V,       FSR_V,       FSR_V
+    /* QNaN1 + SNaN2 = QNaN2 */
+    test_op2 add.d, f5, f6, f7, F64_QNAN(1), F64_SNAN(2), \
+        F64_QNAN(1), F64_QNAN(1), F64_QNAN(1), F64_QNAN(1), \
+              FSR_V,       FSR_V,       FSR_V,       FSR_V
+    /* SNaN1 + QNaN2 = QNaN2 */
+    test_op2 add.d, f8, f9, f10, F64_SNAN(1), F64_QNAN(2), \
+        F64_QNAN(1), F64_QNAN(1), F64_QNAN(1), F64_QNAN(1), \
+              FSR_V,       FSR_V,       FSR_V,       FSR_V
+test_end
+
+test sub_d
+    /* norm - norm = denorm */
+    test_op2 sub.d, f6, f7, f8, F64_MIN_NORM | 1, F64_MIN_NORM, \
+        0x00000001, 0x00000001, 0x00000001, 0x00000001, \
+             FSR__,      FSR__,      FSR__,      FSR__
+test_end
+
+test mul_d
+    test_op2 mul.d, f0, f1, f2, F64_1 | 1, F64_1 | 1, \
+        F64_1 | 2, F64_1 | 2, F64_1 | 3, F64_1 | 2, \
+            FSR_I,     FSR_I,     FSR_I,     FSR_I
+    /* MAX_FLOAT/2 * MAX_FLOAT/2 = +inf/MAX_FLOAT  */
+    test_op2 mul.d, f6, f7, f8, F64_MAX_2, F64_MAX_2, \
+        F64_PINF, F64_MAX, F64_PINF, F64_MAX, \
+          FSR_OI,  FSR_OI,   FSR_OI,  FSR_OI
+    /* min norm * min norm = 0/denorm */
+    test_op2 mul.d, f6, f7, f8, F64_MIN_NORM, F64_MIN_NORM, \
+         F64_0,  F64_0, 0x00000001,  F64_0, \
+        FSR_UI, FSR_UI,     FSR_UI, FSR_UI
+    /* inf * 0 = default NaN */
+    test_op2 mul.d, f6, f7, f8, F64_PINF, F64_0, \
+        F64_DNAN, F64_DNAN, F64_DNAN, F64_DNAN, \
+           FSR_V,    FSR_V,    FSR_V,    FSR_V
+test_end
+
+test madd_d
+    test_op3 madd.d, f0, f1, f2, f0, F64_0, F64_1 | 1, F64_1 | 1, \
+        F64_1 | 2, F64_1 | 2, F64_1 | 3, F64_1 | 2, \
+            FSR_I,     FSR_I,     FSR_I,     FSR_I
+test_end
+
+test madd_d_precision
+    test_op3 madd.d, f0, f1, f2, f0, \
+        F64_MINUS | F64_1 | 2, F64_1 | 1, F64_1 | 1, \
+        0x3970000000000000, 0x3970000000000000, 0x3970000000000000, 0x3970000000000000, \
+             FSR__,      FSR__,      FSR__,      FSR__
+test_end
+
+test madd_d_nan_dfpu
+    /* DFPU madd/msub NaN1, NaN2, NaN3 priority: NaN1, NaN3, NaN2 */
+    test_op3 madd.d, f0, f1, f2, f0, F64_QNAN(1), F64_1, F64_1, \
+        F64_QNAN(1), F64_QNAN(1), F64_QNAN(1), F64_QNAN(1), \
+              FSR__,       FSR__,       FSR__,       FSR__
+    test_op3 madd.d, f0, f1, f2, f0, F64_1, F64_QNAN(2), F64_1, \
+        F64_QNAN(2), F64_QNAN(2), F64_QNAN(2), F64_QNAN(2), \
+              FSR__,       FSR__,       FSR__,       FSR__
+    test_op3 madd.d, f0, f1, f2, f0, F64_1, F64_1, F64_QNAN(3), \
+        F64_QNAN(3), F64_QNAN(3), F64_QNAN(3), F64_QNAN(3), \
+              FSR__,       FSR__,       FSR__,       FSR__
+
+    test_op3 madd.d, f0, f1, f2, f0, F64_QNAN(1), F64_QNAN(2), F64_1, \
+        F64_QNAN(1), F64_QNAN(1), F64_QNAN(1), F64_QNAN(1), \
+              FSR__,       FSR__,       FSR__,       FSR__
+    test_op3 madd.d, f0, f1, f2, f0, F64_QNAN(1), F64_1, F64_QNAN(3), \
+        F64_QNAN(1), F64_QNAN(1), F64_QNAN(1), F64_QNAN(1), \
+              FSR__,       FSR__,       FSR__,       FSR__
+    test_op3 madd.d, f0, f1, f2, f0, F64_1, F64_QNAN(2), F64_QNAN(3), \
+        F64_QNAN(3), F64_QNAN(3), F64_QNAN(3), F64_QNAN(3), \
+              FSR__,       FSR__,       FSR__,       FSR__
+
+    test_op3 madd.d, f0, f1, f2, f0, F64_QNAN(1), F64_QNAN(2), F64_QNAN(3), \
+        F64_QNAN(1), F64_QNAN(1), F64_QNAN(1), F64_QNAN(1), \
+              FSR__,       FSR__,       FSR__,       FSR__
+
+    /* inf * 0 = default NaN */
+    test_op3 madd.d, f0, f1, f2, f0, F64_1, F64_PINF, F64_0, \
+        F64_DNAN, F64_DNAN, F64_DNAN, F64_DNAN, \
+           FSR_V,    FSR_V,    FSR_V,    FSR_V
+    /* inf * 0 + SNaN1 = QNaN1 */
+    test_op3 madd.d, f0, f1, f2, f0, F64_SNAN(1), F64_PINF, F64_0, \
+        F64_QNAN(1), F64_QNAN(1), F64_QNAN(1), F64_QNAN(1), \
+              FSR_V,       FSR_V,       FSR_V,       FSR_V
+    /* inf * 0 + QNaN1 = QNaN1 */
+    test_op3 madd.d, f0, f1, f2, f0, F64_QNAN(1), F64_PINF, F64_0, \
+        F64_QNAN(1), F64_QNAN(1), F64_QNAN(1), F64_QNAN(1), \
+              FSR_V,       FSR_V,       FSR_V,       FSR_V
+
+    /* madd/msub SNaN turns to QNaN and sets Invalid flag */
+    test_op3 madd.d, f0, f1, f2, f0, F64_SNAN(1), F64_1, F64_1, \
+        F64_QNAN(1), F64_QNAN(1), F64_QNAN(1), F64_QNAN(1), \
+              FSR_V,       FSR_V,       FSR_V,       FSR_V
+    test_op3 madd.d, f0, f1, f2, f0, F64_QNAN(1), F64_SNAN(2), F64_1, \
+        F64_QNAN(1), F64_QNAN(1), F64_QNAN(1), F64_QNAN(1), \
+              FSR_V,       FSR_V,       FSR_V,       FSR_V
+test_end
+
+#endif
+
+test_suite_end
-- 
2.20.1



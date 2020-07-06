Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E424DC433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 23:59:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACD0D20823
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 23:59:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gzr+AR+E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACD0D20823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsb0z-0003FF-1S
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 19:59:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35516)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1jsaqJ-0001Rr-E1
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 19:48:11 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535]:42807)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1jsaqH-00011f-Et
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 19:48:11 -0400
Received: by mail-pg1-x535.google.com with SMTP id m22so8750101pgv.9
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2020 16:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=aTzwKyPqSVqduvxSFfgbpZf3K6u+1T0HA/N6+Yn1e6o=;
 b=gzr+AR+EUZUd85OwEPKTSWt/JiNl7dLzrG/C7c8uEtdEmp71ImxKpwEv3yVYz8yi8w
 ImiKfePdPApDH5DqLns8ESTHhQKUNfM818k9Y7YA3AcxKU6ctKqB44dS70k0xyI3+Kts
 pC265IjC3UPl++hu1Dm2/YdDl68jcABTEBPLBvtl3tK6PbtKKVAsx/9f/v9lxi/X/msv
 Hfpy1u521WHi+LiALABLcBmrNdrd7f6EAgmVKrqoyOCl8/uv2zpkyDhu/iJsMKTKnsLd
 OJshYgof+IRFnmoYDDFLVixJk/qFCubWACH8F0J1Zpu5GtYAc5qZtEGx9Baxms/3KdZq
 /43A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=aTzwKyPqSVqduvxSFfgbpZf3K6u+1T0HA/N6+Yn1e6o=;
 b=XiaX6ICsts2+VIx3gRUk546fRpABPLG8LQ7EaUOGIE5tZfRyg3TxZIu8w7N2dXVpVf
 zyUZ0+MGhNbq0iFMc3yVmWB7I3D904uOQ6eLVL9A1g/N84vod9Aznsgo1V45xjiHEgAI
 SzjgcV5HyUsoV2wsYtUX5qnvgNFDo7aeiN71JJLDuN9HKgZapVN2lACEzcVd5e7Thhn7
 UJCBm133UXFDZfSbWgRb0efsbuFWekrGyL60KWF4V5yhJOI891lGUPv3AxGcezRfXDpd
 jmKcP9xVW6ZYlxhsOjxi+2yw+biOTOhXUC1YC6UEZ42HzcN9j+fV2Vji7S7ErNtnLDfx
 GRkg==
X-Gm-Message-State: AOAM532Jain08vZWb5RX3C+wMfD1jdFQ8iLhrnJOR+QE1mmv4wq39Q69
 ZEX8TT+zWMk77/Su1vhw6J0SEaTr
X-Google-Smtp-Source: ABdhPJyiVWuzJqCG8mf9foKP8D0PcwkzvVXiMVX+KkIS3tCbJKT3X57QP4dlTKkls4CWhLN50EjjPQ==
X-Received: by 2002:aa7:94b0:: with SMTP id a16mr21815311pfl.86.1594079287909; 
 Mon, 06 Jul 2020 16:48:07 -0700 (PDT)
Received: from octofox.cadence.com ([2601:641:400:e00:19b7:f650:7bbe:a7fb])
 by smtp.gmail.com with ESMTPSA id e15sm19647649pgt.17.2020.07.06.16.48.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2020 16:48:07 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 19/21] tests/tcg/xtensa: add DFP0 arith tests
Date: Mon,  6 Jul 2020 16:47:35 -0700
Message-Id: <20200706234737.32378-20-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200706234737.32378-1-jcmvbkbc@gmail.com>
References: <20200706234737.32378-1-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=jcmvbkbc@gmail.com; helo=mail-pg1-x535.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Cc: Max Filippov <jcmvbkbc@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add test for basic double precision opcode properties.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 tests/tcg/xtensa/test_dfp0_arith.S | 153 +++++++++++++++++++++++++++++
 1 file changed, 153 insertions(+)
 create mode 100644 tests/tcg/xtensa/test_dfp0_arith.S

diff --git a/tests/tcg/xtensa/test_dfp0_arith.S b/tests/tcg/xtensa/test_dfp0_arith.S
new file mode 100644
index 000000000000..f2c72f97938d
--- /dev/null
+++ b/tests/tcg/xtensa/test_dfp0_arith.S
@@ -0,0 +1,153 @@
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
+test sub_s
+    /* norm - norm = denorm */
+    test_op2 sub.d, f6, f7, f8, F64_MIN_NORM | 1, F64_MIN_NORM, \
+        0x00000001, 0x00000001, 0x00000001, 0x00000001, \
+             FSR__,      FSR__,      FSR__,      FSR__
+test_end
+
+test mul_s
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
+    test_op3 madd.d, f0, f1, f2, f0, F64_QNAN(1), F64_QNAN(2), F64_QNAN(3), \
+        F64_QNAN(1), F64_QNAN(1), F64_QNAN(1), F64_QNAN(1), \
+              FSR__,       FSR__,       FSR__,       FSR__
+
+    /* inf * 0 = default NaN */
+    test_op3 madd.d, f0, f1, f2, f0, F64_1, F64_PINF, F64_0, \
+        F64_DNAN, F64_DNAN, F64_DNAN, F64_DNAN, \
+           FSR_V,    FSR_V,    FSR_V,    FSR_V
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



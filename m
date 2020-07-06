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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 802E2C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 23:52:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49A2D20672
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 23:52:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CxJb/kAn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49A2D20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsauj-0001jX-Jh
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 19:52:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35438)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1jsaqE-0001Dj-8E
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 19:48:06 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:37142)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1jsaqC-0000yb-FK
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 19:48:05 -0400
Received: by mail-pl1-x641.google.com with SMTP id p1so6697581pls.4
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2020 16:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qM4gdxNsTzx8cNz2D0TAu5KAdZ5SZ1c5qf/Vo1HXIQw=;
 b=CxJb/kAnrhzffjGO49N3XwhsWkBpu+j+BEc5+nFfmFlYY2qtDCz+249O3s9TvFwPon
 JE0LMRjjeTl4CV7Ugx+tiUmzzFody6eiEeugbn3wH9e3meOeLT1BHz/DWVCk+mwz8bzx
 lqj2HrEIE2DSsR1WtKeLM7QIOsWd6dbv9mhhy8hjU50j+VkvExZ1Zploh5ZseBmLi87d
 v72zpKQcMJ6drDBF00Iq7wWeSX5g019DexoO2WUslidJhRd4qxFPcs7iJomUhslN0yti
 qJuY2NO32e5s9ZkesVF/Juy2ysVeLXwW4Tpe+gSclB5Co5hskkVavpu9XoN02o3QeLsl
 tJ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qM4gdxNsTzx8cNz2D0TAu5KAdZ5SZ1c5qf/Vo1HXIQw=;
 b=jx36nB+xuAWaRubWs1NExAHy6ccoJ1ouEr9oga9tRVVlV+f0flWPhWNDgaMEyGT+jn
 in5gna+DUv+EPi4HB/8tTBGQO3zKBQvbgyZ0WEqW8tM9tps8kDJDXGdqR9ms4/dmkXRQ
 Z+7Zjz2uXs89qayb1QgvKq+hvcRQeTyjaETo2PFfVgmQLaGFMmM3AhzeRpi/312t6nCI
 YERwhWvydosuw91HTPt+KmK0BTS9KKXHy+311mLACzPPiCGyZ9PAhUsQCCz0PGiAXytP
 WZFFL6UDWGa/4nqrBadZ1+jQijVA9vcLQ1SKGPWd7DbrGuWyvhl25bTj7IsfzA8IRXJU
 sWtg==
X-Gm-Message-State: AOAM533VAzXMpAkshLiqqv7mP8WL2pfTR+lYcAne/BwRXRHWq+/v6VuM
 pr6KSFqm8US6hqqUuUj/sdFBpJnn
X-Google-Smtp-Source: ABdhPJxEBiifpcuxAt+BEVkw/9gbZVl4AaVu9trxI62IrnjrT6jDG5ApdA/F1Ya74S9TmBOfyWEYPQ==
X-Received: by 2002:a17:90a:7483:: with SMTP id
 p3mr1528784pjk.64.1594079283039; 
 Mon, 06 Jul 2020 16:48:03 -0700 (PDT)
Received: from octofox.cadence.com ([2601:641:400:e00:19b7:f650:7bbe:a7fb])
 by smtp.gmail.com with ESMTPSA id e15sm19647649pgt.17.2020.07.06.16.48.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2020 16:48:02 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 13/21] tests/tcg/xtensa: expand madd tests
Date: Mon,  6 Jul 2020 16:47:29 -0700
Message-Id: <20200706234737.32378-14-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200706234737.32378-1-jcmvbkbc@gmail.com>
References: <20200706234737.32378-1-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=jcmvbkbc@gmail.com; helo=mail-pl1-x641.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 tests/tcg/xtensa/test_fp0_arith.S | 88 +++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/tests/tcg/xtensa/test_fp0_arith.S b/tests/tcg/xtensa/test_fp0_arith.S
index df870eb7a013..727db187a5cc 100644
--- a/tests/tcg/xtensa/test_fp0_arith.S
+++ b/tests/tcg/xtensa/test_fp0_arith.S
@@ -146,6 +146,94 @@ test madd_s
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



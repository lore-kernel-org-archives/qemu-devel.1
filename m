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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 455C8C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:47:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D09B206F6
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:47:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pr+htFYi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D09B206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtIqO-0002PB-91
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 18:47:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48964)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1jtISB-00032E-Pe
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 18:22:11 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636]:35051)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1jtISA-000196-3I
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 18:22:11 -0400
Received: by mail-pl1-x636.google.com with SMTP id x9so5107458plr.2
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2020 15:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wa+AHpqfEWhhgAfAEPD77aSGzH6coLYk43PBINkaick=;
 b=pr+htFYiDbjQeJ/ARKfk6IVACEOTAI4y+LphXq0+uyJzmgdKyi8nvcCMAui0S5v98y
 6zWtB6Hci3/uSLYhjDCXisfAZ7RssXwOBkF0va/zldcVS3+anVUYlJb/QKGXtSyG1w/q
 B2v/50toC9Qg/+Ur1+qbaq9PfbN4oo0CO+yXiKF8JqPRsWXQu1PeiTLhSt9/98pouMpa
 NvPQ6Kd3HU3kwdXyRFGs7b3w/CsQ9Cb7n8PVOYlE1T2Zmwpi8Y5q/3SR5Mv7m/z+nJcv
 b9UutvQjbH3OUJ8c6exg5pn6BUzKqITcKgqvu5s3BKSfvFc6ou+K5vZuJqchqvnwN8iu
 qopQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wa+AHpqfEWhhgAfAEPD77aSGzH6coLYk43PBINkaick=;
 b=oXSRxmgp7J00vAj+KmspenwL8KDfkZ6c3t/XMd775BabqicdMrlrpN8tpd0I1suCHb
 x/XtOrftfJs1G+qQE6K3xjr5ok4qiBB7sGGFRKLYVAuAIsWAfRaoVEH5P9jMjQTt3hXc
 qr3/TmVsHLE/w/YsVXPFcLoSkXFGq+hZtzgxzPeZFGba0KbI51zS+Ri4ZQQ56Ecsi5J5
 g4rdZnDJAHD8tJlfBv928zL1YuJR4nMbNPG053V6apVZBwjM5hai454hC6PU2fVCS29R
 Oj2h/iD7kgkE+HsNNftqKCQhHL0s+OTlw1IRAqxR0wJwV8vEVw94ng4oau+eC24xwM7L
 zUFg==
X-Gm-Message-State: AOAM5326uGnLYwNGQbih2FTs6OkJad00y6u5ywF1FDCqB5MeYRshwBvw
 1G3cutvd9/jTPoPMs6LaW2VciodD
X-Google-Smtp-Source: ABdhPJyJvfbYgusB3GZIBvjg2CjRs24TujouXE2u8HiPE+KLHeNFiz9D6l2m2n3soz/U6t+RzBUgxg==
X-Received: by 2002:a17:90a:ec13:: with SMTP id
 l19mr10350801pjy.81.1594246928634; 
 Wed, 08 Jul 2020 15:22:08 -0700 (PDT)
Received: from octofox.cadence.com ([2601:641:400:e00:19b7:f650:7bbe:a7fb])
 by smtp.gmail.com with ESMTPSA id t73sm693517pfc.78.2020.07.08.15.22.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2020 15:22:08 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 17/21] tests/tcg/xtensa: add fp0 div and sqrt tests
Date: Wed,  8 Jul 2020 15:20:57 -0700
Message-Id: <20200708222101.24568-18-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200708222101.24568-1-jcmvbkbc@gmail.com>
References: <20200708222101.24568-1-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=jcmvbkbc@gmail.com; helo=mail-pl1-x636.google.com
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

Test exact division/sqrt DFPU sequences.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 tests/tcg/xtensa/test_fp0_div.S  | 82 ++++++++++++++++++++++++++++++++
 tests/tcg/xtensa/test_fp0_sqrt.S | 76 +++++++++++++++++++++++++++++
 2 files changed, 158 insertions(+)
 create mode 100644 tests/tcg/xtensa/test_fp0_div.S
 create mode 100644 tests/tcg/xtensa/test_fp0_sqrt.S

diff --git a/tests/tcg/xtensa/test_fp0_div.S b/tests/tcg/xtensa/test_fp0_div.S
new file mode 100644
index 000000000000..c3e7ad7bb5b3
--- /dev/null
+++ b/tests/tcg/xtensa/test_fp0_div.S
@@ -0,0 +1,82 @@
+#include "macros.inc"
+#include "fpu.h"
+
+test_suite fp0_div
+
+#if XCHAL_HAVE_FP_DIV
+
+.macro  divs_seq q, a, b, r, y, y0, an, bn, e, ex
+    div0.s      \y0, \b
+    nexp01.s    \bn, \b
+    const.s     \e, 1
+    maddn.s     \e, \bn, \y0
+    mov.s       \y, \y0
+    mov.s       \ex, \b
+    nexp01.s    \an, \a
+    maddn.s     \y, \e, \y0
+    const.s     \e, 1
+    const.s     \q, 0
+    neg.s       \r, \an
+    maddn.s     \e, \bn, \y
+    maddn.s     \q, \r, \y0
+    mkdadj.s    \ex, \a
+    maddn.s     \y, \e, \y
+    maddn.s     \r, \bn, \q
+    const.s     \e, 1
+    maddn.s     \e, \bn, \y
+    maddn.s     \q, \r, \y
+    neg.s       \r, \an
+    maddn.s     \y, \e, \y
+    maddn.s     \r, \bn, \q
+    addexpm.s   \q, \ex
+    addexp.s    \y, \ex
+    divn.s      \q, \r, \y
+.endm
+
+.macro div_s fr0, fr1, fr2
+    divs_seq    \fr0, \fr1, \fr2, f9, f10, f11, f12, f13, f14, f15
+.endm
+
+.macro movfp fr, v
+    movi        a2, \v
+    wfr         \fr, a2
+.endm
+
+.macro check_res fr, r, sr
+    rfr         a2, \fr
+    dump        a2
+    movi        a3, \r
+    assert      eq, a2, a3
+    rur         a2, fsr
+    movi        a3, \sr
+    assert      eq, a2, a3
+.endm
+
+test div_s
+    movi        a2, 1
+    wsr         a2, cpenable
+
+    test_op2    div_s, f0, f1, f2, 0x40000000, 0x40400000, \
+        0x3f2aaaab, 0x3f2aaaaa, 0x3f2aaaab, 0x3f2aaaaa, \
+             FSR_I,      FSR_I,      FSR_I,      FSR_I
+    test_op2    div_s, f3, f4, f5, F32_1, F32_0, \
+        F32_PINF, F32_PINF, F32_PINF, F32_PINF, \
+           FSR_Z,    FSR_Z,    FSR_Z,    FSR_Z
+    test_op2    div_s, f6, f7, f8, F32_0, F32_0, \
+        F32_DNAN, F32_DNAN, F32_DNAN, F32_DNAN, \
+           FSR_V,    FSR_V,    FSR_V,    FSR_V
+
+    /* MAX_FLOAT / 0.5 = +inf/MAX_FLOAT  */
+    test_op2    div_s, f0, f1, f2, F32_MAX, F32_0_5, \
+        F32_PINF, F32_MAX, F32_PINF, F32_MAX, \
+          FSR_OI,  FSR_OI,   FSR_OI,  FSR_OI
+
+    /* 0.5 / MAX_FLOAT = denorm  */
+    test_op2    div_s, f0, f1, f2, F32_0_5, F32_MAX, \
+        0x00100000, 0x00100000, 0x00100001, 0x00100000, \
+            FSR_UI,     FSR_UI,     FSR_UI,     FSR_UI
+test_end
+
+#endif
+
+test_suite_end
diff --git a/tests/tcg/xtensa/test_fp0_sqrt.S b/tests/tcg/xtensa/test_fp0_sqrt.S
new file mode 100644
index 000000000000..585973dce6bc
--- /dev/null
+++ b/tests/tcg/xtensa/test_fp0_sqrt.S
@@ -0,0 +1,76 @@
+#include "macros.inc"
+#include "fpu.h"
+
+test_suite fp0_sqrt
+
+#if XCHAL_HAVE_FP_SQRT
+
+.macro  sqrt_seq r, a, y, t1, hn, h2, t5, h
+    sqrt0.s     \y, \a
+    const.s     \t1, 0
+    maddn.s     \t1, \y, \y
+    nexp01.s    \hn, \a
+    const.s     \r, 3
+    addexp.s    \hn, \r
+    maddn.s     \r, \t1, \hn
+    nexp01.s    \t1, \a
+    neg.s       \h2, \t1
+    maddn.s     \y, \r, \y
+    const.s     \r, 0
+    const.s     \t5, 0
+    const.s     \h, 0
+    maddn.s     \r, \h2, \y
+    maddn.s     \t5, \y, \hn
+    const.s     \hn, 3
+    maddn.s     \h, \hn, \y
+    maddn.s     \t1, \r, \r
+    maddn.s     \hn, \t5, \y
+    neg.s       \y, \h
+    maddn.s     \r, \t1, \y
+    maddn.s     \h, \hn, \h
+    mksadj.s    \y, \a
+    nexp01.s    \a, \a
+    maddn.s     \a, \r, \r
+    neg.s       \t1, \h
+    addexpm.s   \r, \y
+    addexp.s    \t1, \y
+    divn.s      \r, \a, \t1
+.endm
+
+.macro sqrt_s fr0, fr1
+    sqrt_seq    \fr0, \fr1, f10, f11, f12, f13, f14, f15
+.endm
+
+.macro movfp fr, v
+    movi        a2, \v
+    wfr         \fr, a2
+.endm
+
+.macro check_res fr, r, sr
+    rfr         a2, \fr
+    dump        a2
+    movi        a3, \r
+    assert      eq, a2, a3
+    rur         a2, fsr
+    movi        a3, \sr
+    assert      eq, a2, a3
+.endm
+
+test sqrt_s
+    movi        a2, 1
+    wsr         a2, cpenable
+
+    test_op1    sqrt_s, f0, f1, 0x40000000, \
+        0x3fb504f3, 0x3fb504f3, 0x3fb504f4, 0x3fb504f3, \
+             FSR_I,      FSR_I,      FSR_I,      FSR_I
+    test_op1    sqrt_s, f3, f4, F32_1, \
+        F32_1, F32_1, F32_1, F32_1, \
+        FSR__, FSR__, FSR__, FSR__
+    test_op1    sqrt_s, f6, f7, F32_MINUS | F32_1, \
+        F32_DNAN, F32_DNAN, F32_DNAN, F32_DNAN, \
+           FSR_V,    FSR_V,    FSR_V,    FSR_V
+test_end
+
+#endif
+
+test_suite_end
-- 
2.20.1



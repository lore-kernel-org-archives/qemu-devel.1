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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0F11C433E1
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 11:18:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87E122078B
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 11:18:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sgx31l7+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87E122078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juDW8-0003Ya-RJ
	for qemu-devel@archiver.kernel.org; Sat, 11 Jul 2020 07:18:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52826)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1juDMT-0004kG-1h
 for qemu-devel@nongnu.org; Sat, 11 Jul 2020 07:08:06 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:38935)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1juDMR-0006Ot-DS
 for qemu-devel@nongnu.org; Sat, 11 Jul 2020 07:08:04 -0400
Received: by mail-pg1-x543.google.com with SMTP id z5so3690666pgb.6
 for <qemu-devel@nongnu.org>; Sat, 11 Jul 2020 04:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=rzz0QASvhiLiMcKKjELZE5GUtAHuQdcLXEQeVo4joCE=;
 b=Sgx31l7+EeAk6oQqciSgUdVZvHtlIbCXoUDdBaAG2BZv1RkI+NljW7QDZRPaSv/Kzy
 Gxtoy+b95ho0P6HxgKmXn6JkZktfGc3TpbbLEznNl7Ms2sVe5dsXJaNJtGKoJgQSvAwJ
 TeN8smD4hpsnzVJHhe3Pob/W7iB03rqxOZFQp8IIVN/5ev8NLR69KsPbLcKHtKkQLoE0
 iffcHHHt2sKLwLlVhrDTQHDnwWGUh24zsjkI0RGB4htgGCNEOvZwbA7vpjBc2VThq1DA
 OHjY16ILDye5VYXdKPKjRwEumAR0Zxv0BKb1PC+fKc0X6na/mai9HZQtaZba3NS5zIuh
 sRog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rzz0QASvhiLiMcKKjELZE5GUtAHuQdcLXEQeVo4joCE=;
 b=BLxld//DghCGeSOEkkJ+LBqCFpGTTX0h6094jZLG+C4Yik1dMVCVNw+xoPoDRIvLKF
 MF+DPjQHxGOko2D64XHPOei6WxPzYlEywU+VqUtjfQIzioLRkFwFP8kMLzvtfVn5A4Kg
 uGyzwmAXqqxCKfcqCvzdxTkDWQGnleoizthhGOeF5hOJOo+5Q/tR9hda9YfWTVBzEag/
 L21t6j2aodgh4e1guHsrsXzVDANYUDzSoa7/u9v5FXzpo/Fu0RDW7UYvGC7JQX2Wc8K0
 ZsmNxyiy7Hp1RQ9RNnhPVRYWoiDcK3WOYnvNyKRappnxFXtB3sk/qjUyjdHpYRp9qWaO
 kE9g==
X-Gm-Message-State: AOAM533UOpwnrllg6qJ4R+S0CkxJc3+4gAewgUXi25qK47Pn9TotO+DX
 oxaBKaKcnJZ6d7QXu8eSQMtSkD3H
X-Google-Smtp-Source: ABdhPJwKhYWuci5jnNBvMEtbjpnrjFgEO6l1tK8//a4DKgArWO32agCCuKiLRlpqG4trhx9+VtIuTg==
X-Received: by 2002:a65:484c:: with SMTP id i12mr22248900pgs.145.1594465682089; 
 Sat, 11 Jul 2020 04:08:02 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net
 ([2601:641:400:e00:19b7:f650:7bbe:a7fb])
 by smtp.gmail.com with ESMTPSA id m31sm8925826pjb.52.2020.07.11.04.08.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Jul 2020 04:08:01 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 16/22] tests/tcg/xtensa: update test_fp1 for DFPU
Date: Sat, 11 Jul 2020 04:06:51 -0700
Message-Id: <20200711110655.20287-17-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200711110655.20287-1-jcmvbkbc@gmail.com>
References: <20200711110655.20287-1-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=jcmvbkbc@gmail.com; helo=mail-pg1-x543.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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

DFPU sets Invalid flag in FSR when at least one argument of FP
comparison opcodes is NaN, SNaN for most opcodes, any NaN for olt/ole.
Add checks for FSR and expected FSR values.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 tests/tcg/xtensa/test_fp1.S | 62 ++++++++++++++++++++-----------------
 1 file changed, 34 insertions(+), 28 deletions(-)

diff --git a/tests/tcg/xtensa/test_fp1.S b/tests/tcg/xtensa/test_fp1.S
index 6e182e5964bd..77336a3fcf2c 100644
--- a/tests/tcg/xtensa/test_fp1.S
+++ b/tests/tcg/xtensa/test_fp1.S
@@ -1,4 +1,5 @@
 #include "macros.inc"
+#include "fpu.h"
 
 test_suite fp1
 
@@ -9,7 +10,7 @@ test_suite fp1
     wfr     \fr, a2
 .endm
 
-.macro test_ord_ex op, br, fr0, fr1, v0, v1, r
+.macro test_ord_ex op, br, fr0, fr1, v0, v1, r, sr
     movi    a2, 0
     wur     a2, fsr
     movfp   \fr0, \v0
@@ -20,65 +21,70 @@ test_suite fp1
     movt    a2, a3, \br
     assert  eqi, a2, \r
     rur     a2, fsr
+#if DFPU
+    movi    a3, \sr
+    assert  eq, a2, a3
+#else
     assert  eqi, a2, 0
+#endif
 .endm
 
-.macro test_ord op, br, fr0, fr1, v0, v1, r
+.macro test_ord op, br, fr0, fr1, v0, v1, r, sr
     movi    a2, 0
     wur     a2, fcr
-    test_ord_ex \op, \br, \fr0, \fr1, \v0, \v1, \r
+    test_ord_ex \op, \br, \fr0, \fr1, \v0, \v1, \r, \sr
     movi    a2, 0x7c
     wur     a2, fcr
-    test_ord_ex \op, \br, \fr0, \fr1, \v0, \v1, \r
+    test_ord_ex \op, \br, \fr0, \fr1, \v0, \v1, \r, \sr
 .endm
 
-.macro test_ord_all op, aa, ab, ba, aPI, PIa, aN, Na, II, IN, NI
-    test_ord \op  b0,  f0,  f1, 0x3f800000, 0x3f800000, \aa
-    test_ord \op  b1,  f2,  f3, 0x3f800000, 0x3fc00000, \ab
-    test_ord \op  b2,  f4,  f5, 0x3fc00000, 0x3f800000, \ba
-    test_ord \op  b3,  f6,  f7, 0x3f800000, 0x7f800000, \aPI
-    test_ord \op  b4,  f8,  f9, 0x7f800000, 0x3f800000, \PIa
-    test_ord \op  b5, f10, f11, 0x3f800000, 0xffc00001, \aN
-    test_ord \op  b6, f12, f13, 0x3f800000, 0xff800001, \aN
-    test_ord \op  b7, f14, f15, 0x3f800000, 0x7f800001, \aN
-    test_ord \op  b8,  f0,  f1, 0x3f800000, 0x7fc00000, \aN
-    test_ord \op  b9,  f2,  f3, 0xffc00001, 0x3f800000, \Na
-    test_ord \op b10,  f4,  f5, 0xff800001, 0x3f800000, \Na
-    test_ord \op b11,  f6,  f7, 0x7f800001, 0x3f800000, \Na
-    test_ord \op b12,  f8,  f9, 0x7fc00000, 0x3f800000, \Na
-    test_ord \op b13, f10, f11, 0x7f800000, 0x7f800000, \II
-    test_ord \op b14, f12, f13, 0x7f800000, 0x7fc00000, \IN
-    test_ord \op b15, f14, f15, 0x7fc00000, 0x7f800000, \NI
+.macro test_ord_all op, aa, ab, ba, aPI, PIa, aN, Na, II, IN, NI, qnan_sr
+    test_ord \op  b0,  f0,  f1, 0x3f800000, 0x3f800000, \aa,  FSR__    /*   ord == ord */
+    test_ord \op  b1,  f2,  f3, 0x3f800000, 0x3fc00000, \ab,  FSR__    /*   ord <  ord */
+    test_ord \op  b2,  f4,  f5, 0x3fc00000, 0x3f800000, \ba,  FSR__    /*   ord >  ord */
+    test_ord \op  b3,  f6,  f7, 0x3f800000, 0x7f800000, \aPI, FSR__    /*   ord   +INF */
+    test_ord \op  b4,  f8,  f9, 0x7f800000, 0x3f800000, \PIa, FSR__    /*  +INF    ord */
+    test_ord \op  b5, f10, f11, 0x3f800000, 0xffc00001, \aN,  \qnan_sr /*   ord  -QNaN */
+    test_ord \op  b6, f12, f13, 0x3f800000, 0xff800001, \aN,  FSR_V    /*   ord  -SNaN */
+    test_ord \op  b7, f14, f15, 0x3f800000, 0x7f800001, \aN,  FSR_V    /*   ord  +SNaN */
+    test_ord \op  b8,  f0,  f1, 0x3f800000, 0x7fc00000, \aN,  \qnan_sr /*   ord  +QNaN */
+    test_ord \op  b9,  f2,  f3, 0xffc00001, 0x3f800000, \Na,  \qnan_sr /* -QNaN    ord */
+    test_ord \op b10,  f4,  f5, 0xff800001, 0x3f800000, \Na,  FSR_V    /* -SNaN    ord */
+    test_ord \op b11,  f6,  f7, 0x7f800001, 0x3f800000, \Na,  FSR_V    /* +SNaN    ord */
+    test_ord \op b12,  f8,  f9, 0x7fc00000, 0x3f800000, \Na,  \qnan_sr /* +QNaN    ord */
+    test_ord \op b13, f10, f11, 0x7f800000, 0x7f800000, \II,  FSR__    /*  +INF   +INF */
+    test_ord \op b14, f12, f13, 0x7f800000, 0x7fc00000, \IN,  \qnan_sr /*  +INF  +QNaN */
+    test_ord \op b15, f14, f15, 0x7fc00000, 0x7f800000, \NI,  \qnan_sr /* +QNaN   +INF */
 .endm
 
 test un_s
     movi    a2, 1
     wsr     a2, cpenable
-    test_ord_all un.s, 0, 0, 0, 0, 0, 1, 1, 0, 1, 1
+    test_ord_all un.s, 0, 0, 0, 0, 0, 1, 1, 0, 1, 1, FSR__
 test_end
 
 test oeq_s
-    test_ord_all oeq.s, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0
+    test_ord_all oeq.s, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, FSR__
 test_end
 
 test ueq_s
-    test_ord_all ueq.s, 1, 0, 0, 0, 0, 1, 1, 1, 1, 1
+    test_ord_all ueq.s, 1, 0, 0, 0, 0, 1, 1, 1, 1, 1, FSR__
 test_end
 
 test olt_s
-    test_ord_all olt.s, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0
+    test_ord_all olt.s, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, FSR_V
 test_end
 
 test ult_s
-    test_ord_all ult.s, 0, 1, 0, 1, 0, 1, 1, 0, 1, 1
+    test_ord_all ult.s, 0, 1, 0, 1, 0, 1, 1, 0, 1, 1, FSR__
 test_end
 
 test ole_s
-    test_ord_all ole.s, 1, 1, 0, 1, 0, 0, 0, 1, 0, 0
+    test_ord_all ole.s, 1, 1, 0, 1, 0, 0, 0, 1, 0, 0, FSR_V
 test_end
 
 test ule_s
-    test_ord_all ule.s, 1, 1, 0, 1, 0, 1, 1, 1, 1, 1
+    test_ord_all ule.s, 1, 1, 0, 1, 0, 1, 1, 1, 1, 1, FSR__
 test_end
 
 .macro test_cond op, fr0, fr1, cr, v0, v1, r
-- 
2.20.1



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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A22AC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:50:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06C9A207DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:50:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CRZhcoWt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06C9A207DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtItx-0002Dc-6U
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 18:50:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48912)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1jtISA-0002xs-1F
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 18:22:10 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:42425)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1jtIS8-00018q-CR
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 18:22:09 -0400
Received: by mail-pl1-x643.google.com with SMTP id q17so4345759pls.9
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2020 15:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=rzz0QASvhiLiMcKKjELZE5GUtAHuQdcLXEQeVo4joCE=;
 b=CRZhcoWt+2a8vaCUYStZkPgo8AGh+j5GVaDGWnYDaaU9F45hSOWDZ7hQoWdjE7xQmk
 Xu3nGkWZRb15st7hjFeS97ffL5thNuynIX++d3BR/981HrkzMB+kTwdKzmCbTA/7ZRKc
 VQ/3YJ3LSn3rKGOkmbIt6nVuYx9jl0AaL48fP54AUz6QetJhKo8UQpBc1MghDcFZy/6a
 iXzbc6XzFlnF0H0QS2x65pKC9kX/yIvtpTSufGgtoHFK03u9S7SjnEBHMt9sw/LqM8y4
 Kk3B0G0PFPFcn4/lbWumrPhsjg8ZaQBdn7aPR3K5RcTvXpPUp+tjN8pe1jEx7RHLLzz/
 JwcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rzz0QASvhiLiMcKKjELZE5GUtAHuQdcLXEQeVo4joCE=;
 b=Ns85Ivs90Alo8FQFmMfwbH38u+KbDCOHw+1flFQHWd8S48KHzeojV8iOQWAM8mwnjl
 HLuatEluIFaNQoyRHBWRw1tQtRlaswkyJatcHhd7GfIpTVEegumCo0F04r45vsNit0HM
 ISVyzAtQGyBMASAGVdw2V1e6q9qhNtUuvbpR3VDnsfnwIQSWZow7Bn2tWlQEgfZamlzd
 LiENfmEm66KMZqGSDDtKUkak88b2/P16nAUU6QJzAMMqFECiACoq+i07G8g9doI3RAVi
 G5wQp96dMgKteSLIMqUk8zJZUt/oJVYJ3n6VF7Uzc6Ccc+u78PMDrU8rtM6YMjfId9kF
 tBkA==
X-Gm-Message-State: AOAM533LLvDiYANd2rxvcj/bmV/ybKiQGqwiGsK5OkhKUpGQvTydfTQA
 X6Cpv+n5Qo8xfOArpFwH4Vy3qjOO
X-Google-Smtp-Source: ABdhPJyZ1EqK1AWL4GEwOUbIm4GMfw2djIk5PK9dba9uIXxjU5ov1NeOc5tMex0Q0kkE0ihoMRW2Rg==
X-Received: by 2002:a17:90a:780f:: with SMTP id
 w15mr11551611pjk.235.1594246926939; 
 Wed, 08 Jul 2020 15:22:06 -0700 (PDT)
Received: from octofox.cadence.com ([2601:641:400:e00:19b7:f650:7bbe:a7fb])
 by smtp.gmail.com with ESMTPSA id t73sm693517pfc.78.2020.07.08.15.22.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2020 15:22:06 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 15/21] tests/tcg/xtensa: update test_fp1 for DFPU
Date: Wed,  8 Jul 2020 15:20:55 -0700
Message-Id: <20200708222101.24568-16-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200708222101.24568-1-jcmvbkbc@gmail.com>
References: <20200708222101.24568-1-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=jcmvbkbc@gmail.com; helo=mail-pl1-x643.google.com
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



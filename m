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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA096C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:59:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 620F4206DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:59:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YNVFKM+5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 620F4206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtJ2c-0003HO-Ls
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 18:59:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48874)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1jtIS7-0002sF-V4
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 18:22:07 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:54741)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1jtIS5-00018J-Pv
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 18:22:07 -0400
Received: by mail-pj1-x1042.google.com with SMTP id mn17so177031pjb.4
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2020 15:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4jIV5omheeV0T3drxGexigxyJptxU+Y8G8xeDL3SRR8=;
 b=YNVFKM+5obgdQjXyEeXOHuR0Bd6VgNhh5680Akeo2Y6Hqpop4y/w9Lf3Uv3Yi4q6oQ
 BzBh135cnPF2lI9MhRBd2EkEEti4UzEjcmzviCDGtS3ilWg+aIvB6/f3r5gj1E5k7jYY
 S8/JC+hTlGyqp4deOr7y2uw3TGF+CATbHJCqORax9K3ZiFGbFaoS2wp2xhTKDkmx7Bo2
 EJnRuMq92fQv3LynRcQTahcIMUvHxI4iLR4uLxQZQDZ7FC3cC2oUXe5ybyrO8fwlddOL
 tWoXoJlqyrwvAKbb259mCnc9JC8x7+JCRh1gx9vhQVumPv6ynO2KRfsjMlmZFoXRT2vR
 57ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4jIV5omheeV0T3drxGexigxyJptxU+Y8G8xeDL3SRR8=;
 b=faxte2veLFCkA3xss1LI1utD8R/254o5lUM3YVlf+GqReK9oma1Ys5HIVcVx5rFZHc
 wo5pEpGtM2Yr7IY19c6zPmdSwQQu97Msbl/q5efIFfArOTUizgxVmYjYvOdDl8pBCFcf
 gsbD0o5sQhN2o7StFtd864FJi6pqImJpAbcrPcQlSFgtvcYyPw9WJeKQ6pJXF4QsKcMR
 v7o9lu/ZDCutlKlhUNC3/a9v1PZk9MfDyRHPeBbkKDxdnP6WfUuaxNTYyqF/TY0piKKo
 Rxcg3dGMoU3z3zPZyzAtnCD+0cTGDB4FHcRWjqs0xrMvyGnm3o2sKNP+z6o2tJAdFqIy
 3xZg==
X-Gm-Message-State: AOAM531naVyJ6b8dvvH9YYZ4zpcz8kAd1Er9+p3Ey5gXjY7UgCTnyeVE
 tIyyxJyQu+qZY3AYF0OYxtrSkXsS
X-Google-Smtp-Source: ABdhPJz3GgfFH7GBhOdYoV2HQH2GJmXL4c87cK1MWFTcc3LIauPlWONGE1/en7LgiB9VVX00SudL1g==
X-Received: by 2002:a17:902:ba92:: with SMTP id
 k18mr51069108pls.264.1594246924105; 
 Wed, 08 Jul 2020 15:22:04 -0700 (PDT)
Received: from octofox.cadence.com ([2601:641:400:e00:19b7:f650:7bbe:a7fb])
 by smtp.gmail.com with ESMTPSA id t73sm693517pfc.78.2020.07.08.15.22.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2020 15:22:03 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 12/21] tests/tcg/xtensa: update test_fp0_arith for DFPU
Date: Wed,  8 Jul 2020 15:20:52 -0700
Message-Id: <20200708222101.24568-13-jcmvbkbc@gmail.com>
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

DFPU arithmetic opcodes update FSR flags. Add FSR parameters and
expected FSR register values for the arithmetic tests.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 tests/tcg/xtensa/fpu.h            | 142 ++++++++++++++++++++++++
 tests/tcg/xtensa/test_fp0_arith.S | 178 ++++++++++++++----------------
 2 files changed, 223 insertions(+), 97 deletions(-)
 create mode 100644 tests/tcg/xtensa/fpu.h

diff --git a/tests/tcg/xtensa/fpu.h b/tests/tcg/xtensa/fpu.h
new file mode 100644
index 000000000000..42e321747304
--- /dev/null
+++ b/tests/tcg/xtensa/fpu.h
@@ -0,0 +1,142 @@
+#if XCHAL_HAVE_DFP || XCHAL_HAVE_FP_DIV
+#define DFPU 1
+#else
+#define DFPU 0
+#endif
+
+#define FCR_RM_NEAREST 0
+#define FCR_RM_TRUNC   1
+#define FCR_RM_CEIL    2
+#define FCR_RM_FLOOR   3
+
+#define FSR__ 0x00000000
+#define FSR_I 0x00000080
+#define FSR_U 0x00000100
+#define FSR_O 0x00000200
+#define FSR_Z 0x00000400
+#define FSR_V 0x00000800
+
+#define FSR_UI (FSR_U | FSR_I)
+#define FSR_OI (FSR_O | FSR_I)
+
+#define F32_0           0x00000000
+#define F32_0_5         0x3f000000
+#define F32_1           0x3f800000
+#define F32_MAX         0x7f7fffff
+#define F32_PINF        0x7f800000
+#define F32_NINF        0xff800000
+
+#define F32_DNAN        0x7fc00000
+#define F32_SNAN(v)     (0x7f800000 | (v))
+#define F32_QNAN(v)     (0x7fc00000 | (v))
+
+#define F32_MINUS       0x80000000
+
+#define F64_0           0x0000000000000000
+#define F64_MIN_NORM    0x0010000000000000
+#define F64_1           0x3ff0000000000000
+#define F64_MAX_2       0x7fe0000000000000
+#define F64_MAX         0x7fefffffffffffff
+#define F64_PINF        0x7ff0000000000000
+#define F64_NINF        0xfff0000000000000
+
+#define F64_DNAN        0x7ff8000000000000
+#define F64_SNAN(v)     (0x7ff0000000000000 | (v))
+#define F64_QNAN(v)     (0x7ff8000000000000 | (v))
+
+#define F64_MINUS       0x8000000000000000
+
+.macro test_op1_rm op, fr0, fr1, v0, r, sr
+    movi    a2, 0
+    wur     a2, fsr
+    movfp   \fr0, \v0
+    \op     \fr1, \fr0
+    check_res \fr1, \r, \sr
+.endm
+
+.macro test_op2_rm op, fr0, fr1, fr2, v0, v1, r, sr
+    movi    a2, 0
+    wur     a2, fsr
+    movfp   \fr0, \v0
+    movfp   \fr1, \v1
+    \op     \fr2, \fr0, \fr1
+    check_res \fr2, \r, \sr
+.endm
+
+.macro test_op3_rm op, fr0, fr1, fr2, fr3, v0, v1, v2, r, sr
+    movi    a2, 0
+    wur     a2, fsr
+    movfp   \fr0, \v0
+    movfp   \fr1, \v1
+    movfp   \fr2, \v2
+    \op     \fr0, \fr1, \fr2
+    check_res \fr3, \r, \sr
+.endm
+
+.macro test_op1_ex op, fr0, fr1, v0, rm, r, sr
+    movi    a2, \rm
+    wur     a2, fcr
+    test_op1_rm \op, \fr0, \fr1, \v0, \r, \sr
+    movi    a2, (\rm) | 0x7c
+    wur     a2, fcr
+    test_op1_rm \op, \fr0, \fr1, \v0, \r, \sr
+.endm
+
+.macro test_op2_ex op, fr0, fr1, fr2, v0, v1, rm, r, sr
+    movi    a2, \rm
+    wur     a2, fcr
+    test_op2_rm \op, \fr0, \fr1, \fr2, \v0, \v1, \r, \sr
+    movi    a2, (\rm) | 0x7c
+    wur     a2, fcr
+    test_op2_rm \op, \fr0, \fr1, \fr2, \v0, \v1, \r, \sr
+.endm
+
+.macro test_op3_ex op, fr0, fr1, fr2, fr3, v0, v1, v2, rm, r, sr
+    movi    a2, \rm
+    wur     a2, fcr
+    test_op3_rm \op, \fr0, \fr1, \fr2, \fr3, \v0, \v1, \v2, \r, \sr
+    movi    a2, (\rm) | 0x7c
+    wur     a2, fcr
+    test_op3_rm \op, \fr0, \fr1, \fr2, \fr3, \v0, \v1, \v2, \r, \sr
+.endm
+
+.macro test_op1 op, fr0, fr1, v0, r0, r1, r2, r3, sr0, sr1, sr2, sr3
+    test_op1_ex \op, \fr0, \fr1, \v0, 0, \r0, \sr0
+    test_op1_ex \op, \fr0, \fr1, \v0, 1, \r1, \sr1
+    test_op1_ex \op, \fr0, \fr1, \v0, 2, \r2, \sr2
+    test_op1_ex \op, \fr0, \fr1, \v0, 3, \r3, \sr3
+.endm
+
+.macro test_op2 op, fr0, fr1, fr2, v0, v1, r0, r1, r2, r3, sr0, sr1, sr2, sr3
+    test_op2_ex \op, \fr0, \fr1, \fr2, \v0, \v1, 0, \r0, \sr0
+    test_op2_ex \op, \fr0, \fr1, \fr2, \v0, \v1, 1, \r1, \sr1
+    test_op2_ex \op, \fr0, \fr1, \fr2, \v0, \v1, 2, \r2, \sr2
+    test_op2_ex \op, \fr0, \fr1, \fr2, \v0, \v1, 3, \r3, \sr3
+.endm
+
+.macro test_op3 op, fr0, fr1, fr2, fr3, v0, v1, v2, r0, r1, r2, r3, sr0, sr1, sr2, sr3
+    test_op3_ex \op, \fr0, \fr1, \fr2, \fr3, \v0, \v1, \v2, 0, \r0, \sr0
+    test_op3_ex \op, \fr0, \fr1, \fr2, \fr3, \v0, \v1, \v2, 1, \r1, \sr1
+    test_op3_ex \op, \fr0, \fr1, \fr2, \fr3, \v0, \v1, \v2, 2, \r2, \sr2
+    test_op3_ex \op, \fr0, \fr1, \fr2, \fr3, \v0, \v1, \v2, 3, \r3, \sr3
+.endm
+
+.macro test_op2_cpe op
+    set_vector  kernel, 2f
+    movi    a2, 0
+    wsr     a2, cpenable
+1:
+    \op     f2, f0, f1
+    test_fail
+2:
+    rsr     a2, excvaddr
+    movi    a3, 1b
+    assert  eq, a2, a3
+    rsr     a2, exccause
+    movi    a3, 32
+    assert  eq, a2, a3
+
+    set_vector  kernel, 0
+    movi    a2, 1
+    wsr     a2, cpenable
+.endm
diff --git a/tests/tcg/xtensa/test_fp0_arith.S b/tests/tcg/xtensa/test_fp0_arith.S
index 253d033a3398..df870eb7a013 100644
--- a/tests/tcg/xtensa/test_fp0_arith.S
+++ b/tests/tcg/xtensa/test_fp0_arith.S
@@ -1,4 +1,5 @@
 #include "macros.inc"
+#include "fpu.h"
 
 test_suite fp0_arith
 
@@ -9,84 +10,18 @@ test_suite fp0_arith
     wfr     \fr, a2
 .endm
 
-.macro check_res fr, r
+.macro check_res fr, r, sr
     rfr     a2, \fr
     dump    a2
     movi    a3, \r
     assert  eq, a2, a3
     rur     a2, fsr
-    assert  eqi, a2, 0
-.endm
-
-.macro test_op2_rm op, fr0, fr1, fr2, v0, v1, r
-    movi    a2, 0
-    wur     a2, fsr
-    movfp   \fr0, \v0
-    movfp   \fr1, \v1
-    \op     \fr2, \fr0, \fr1
-    check_res \fr2, \r
-.endm
-
-.macro test_op3_rm op, fr0, fr1, fr2, fr3, v0, v1, v2, r
-    movi    a2, 0
-    wur     a2, fsr
-    movfp   \fr0, \v0
-    movfp   \fr1, \v1
-    movfp   \fr2, \v2
-    \op     \fr0, \fr1, \fr2
-    check_res \fr3, \r
-.endm
-
-.macro test_op2_ex op, fr0, fr1, fr2, v0, v1, rm, r
-    movi    a2, \rm
-    wur     a2, fcr
-    test_op2_rm \op, \fr0, \fr1, \fr2, \v0, \v1, \r
-    movi    a2, (\rm) | 0x7c
-    wur     a2, fcr
-    test_op2_rm \op, \fr0, \fr1, \fr2, \v0, \v1, \r
-.endm
-
-.macro test_op3_ex op, fr0, fr1, fr2, fr3, v0, v1, v2, rm, r
-    movi    a2, \rm
-    wur     a2, fcr
-    test_op3_rm \op, \fr0, \fr1, \fr2, \fr3, \v0, \v1, \v2, \r
-    movi    a2, (\rm) | 0x7c
-    wur     a2, fcr
-    test_op3_rm \op, \fr0, \fr1, \fr2, \fr3, \v0, \v1, \v2, \r
-.endm
-
-.macro test_op2 op, fr0, fr1, fr2, v0, v1, r0, r1, r2, r3
-    test_op2_ex \op, \fr0, \fr1, \fr2, \v0, \v1, 0, \r0
-    test_op2_ex \op, \fr0, \fr1, \fr2, \v0, \v1, 1, \r1
-    test_op2_ex \op, \fr0, \fr1, \fr2, \v0, \v1, 2, \r2
-    test_op2_ex \op, \fr0, \fr1, \fr2, \v0, \v1, 3, \r3
-.endm
-
-.macro test_op3 op, fr0, fr1, fr2, fr3, v0, v1, v2, r0, r1, r2, r3
-    test_op3_ex \op, \fr0, \fr1, \fr2, \fr3, \v0, \v1, \v2, 0, \r0
-    test_op3_ex \op, \fr0, \fr1, \fr2, \fr3, \v0, \v1, \v2, 1, \r1
-    test_op3_ex \op, \fr0, \fr1, \fr2, \fr3, \v0, \v1, \v2, 2, \r2
-    test_op3_ex \op, \fr0, \fr1, \fr2, \fr3, \v0, \v1, \v2, 3, \r3
-.endm
-
-.macro test_op2_cpe op
-    set_vector  kernel, 2f
-    movi    a2, 0
-    wsr     a2, cpenable
-1:
-    \op     f2, f0, f1
-    test_fail
-2:
-    rsr     a2, excvaddr
-    movi    a3, 1b
+#if DFPU
+    movi    a3, \sr
     assert  eq, a2, a3
-    rsr     a2, exccause
-    movi    a3, 32
-    assert  eq, a2, a3
-
-    set_vector  kernel, 0
-    movi    a2, 1
-    wsr     a2, cpenable
+#else
+    assert  eqi, a2, 0
+#endif
 .endm
 
 test add_s
@@ -94,78 +29,127 @@ test add_s
     wsr     a2, cpenable
 
     test_op2 add.s, f0, f1, f2, 0x3fc00000, 0x34400000, \
-        0x3fc00002, 0x3fc00001, 0x3fc00002, 0x3fc00001
+        0x3fc00002, 0x3fc00001, 0x3fc00002, 0x3fc00001, \
+             FSR_I,      FSR_I,      FSR_I,      FSR_I
     test_op2 add.s, f3, f4, f5, 0x3fc00000, 0x34a00000, \
-        0x3fc00002, 0x3fc00002, 0x3fc00003, 0x3fc00002
+        0x3fc00002, 0x3fc00002, 0x3fc00003, 0x3fc00002, \
+             FSR_I,      FSR_I,      FSR_I,      FSR_I
 
     /* MAX_FLOAT + MAX_FLOAT = +inf/MAX_FLOAT  */
     test_op2 add.s, f6, f7, f8, 0x7f7fffff, 0x7f7fffff, \
-        0x7f800000, 0x7f7fffff, 0x7f800000, 0x7f7fffff
+        0x7f800000, 0x7f7fffff, 0x7f800000, 0x7f7fffff, \
+            FSR_OI,     FSR_OI,     FSR_OI,     FSR_OI
 test_end
 
 test add_s_inf
     /* 1 + +inf = +inf  */
     test_op2 add.s, f6, f7, f8, 0x3fc00000, 0x7f800000, \
-        0x7f800000, 0x7f800000, 0x7f800000, 0x7f800000
+        0x7f800000, 0x7f800000, 0x7f800000, 0x7f800000, \
+             FSR__,      FSR__,      FSR__,      FSR__
 
     /* +inf + -inf = default NaN */
     test_op2 add.s, f0, f1, f2, 0x7f800000, 0xff800000, \
-        0x7fc00000, 0x7fc00000, 0x7fc00000, 0x7fc00000
+        0x7fc00000, 0x7fc00000, 0x7fc00000, 0x7fc00000, \
+             FSR_V,      FSR_V,      FSR_V,      FSR_V
 test_end
 
-test add_s_nan
-    /* 1 + NaN = NaN  */
+#if DFPU
+test add_s_nan_dfpu
+    /* 1 + QNaN = QNaN  */
     test_op2 add.s, f9, f10, f11, 0x3fc00000, 0x7fc00001, \
-        0x7fc00001, 0x7fc00001, 0x7fc00001, 0x7fc00001
+        0x7fc00001, 0x7fc00001, 0x7fc00001, 0x7fc00001, \
+             FSR__,      FSR__,      FSR__,      FSR__
+    /* 1 + SNaN = QNaN  */
     test_op2 add.s, f12, f13, f14, 0x3fc00000, 0x7f800001, \
-        0x7f800001, 0x7f800001, 0x7f800001, 0x7f800001
+        0x7fc00001, 0x7fc00001, 0x7fc00001, 0x7fc00001, \
+             FSR_V,      FSR_V,      FSR_V,      FSR_V
 
-    /* NaN1 + NaN2 = NaN1 */
+    /* SNaN1 + SNaN2 = QNaN2 */
+    test_op2 add.s, f15, f0, f1, 0x7f800001, 0x7fbfffff, \
+        0x7fffffff, 0x7fffffff, 0x7fffffff, 0x7fffffff, \
+             FSR_V,      FSR_V,      FSR_V,      FSR_V
+    test_op2 add.s, f2, f3, f4, 0x7fbfffff, 0x7f800001, \
+        0x7fc00001, 0x7fc00001, 0x7fc00001, 0x7fc00001, \
+             FSR_V,      FSR_V,      FSR_V,      FSR_V
+    /* QNaN1 + SNaN2 = QNaN2 */
+    test_op2 add.s, f5, f6, f7, 0x7fc00001, 0x7fbfffff, \
+        0x7fffffff, 0x7fffffff, 0x7fffffff, 0x7fffffff, \
+             FSR_V,      FSR_V,      FSR_V,      FSR_V
+    /* SNaN1 + QNaN2 = QNaN2 */
+    test_op2 add.s, f8, f9, f10, 0x7fbfffff, 0x7fc00001, \
+        0x7fc00001, 0x7fc00001, 0x7fc00001, 0x7fc00001, \
+             FSR_V,      FSR_V,      FSR_V,      FSR_V
+test_end
+#else
+test add_s_nan_fpu2k
+    /* 1 + QNaN = QNaN  */
+    test_op2 add.s, f9, f10, f11, 0x3fc00000, 0x7fc00001, \
+        0x7fc00001, 0x7fc00001, 0x7fc00001, 0x7fc00001, \
+             FSR__,      FSR__,      FSR__,      FSR__
+    /* 1 + SNaN = SNaN  */
+    test_op2 add.s, f12, f13, f14, 0x3fc00000, 0x7f800001, \
+        0x7f800001, 0x7f800001, 0x7f800001, 0x7f800001, \
+             FSR__,      FSR__,      FSR__,      FSR__
+    /* SNaN1 + SNaN2 = SNaN1 */
     test_op2 add.s, f15, f0, f1, 0x7f800001, 0x7fbfffff, \
-        0x7f800001, 0x7f800001, 0x7f800001, 0x7f800001
+        0x7f800001, 0x7f800001, 0x7f800001, 0x7f800001, \
+             FSR__,      FSR__,      FSR__,      FSR__
     test_op2 add.s, f2, f3, f4, 0x7fbfffff, 0x7f800001, \
-        0x7fbfffff, 0x7fbfffff, 0x7fbfffff, 0x7fbfffff
+        0x7fbfffff, 0x7fbfffff, 0x7fbfffff, 0x7fbfffff, \
+             FSR__,      FSR__,      FSR__,      FSR__
+    /* QNaN1 + SNaN2 = QNaN1 */
     test_op2 add.s, f5, f6, f7, 0x7fc00001, 0x7fbfffff, \
-        0x7fc00001, 0x7fc00001, 0x7fc00001, 0x7fc00001
+        0x7fc00001, 0x7fc00001, 0x7fc00001, 0x7fc00001, \
+             FSR__,      FSR__,      FSR__,      FSR__
+    /* SNaN1 + QNaN2 = SNaN1 */
     test_op2 add.s, f8, f9, f10, 0x7fbfffff, 0x7fc00001, \
-        0x7fbfffff, 0x7fbfffff, 0x7fbfffff, 0x7fbfffff
+        0x7fbfffff, 0x7fbfffff, 0x7fbfffff, 0x7fbfffff, \
+             FSR__,      FSR__,      FSR__,      FSR__
 test_end
+#endif
 
 test sub_s
     test_op2 sub.s, f0, f1, f0, 0x3f800001, 0x33800000, \
-        0x3f800000, 0x3f800000, 0x3f800001, 0x3f800000
+        0x3f800000, 0x3f800000, 0x3f800001, 0x3f800000, \
+             FSR_I,      FSR_I,      FSR_I,      FSR_I
     test_op2 sub.s, f0, f1, f1, 0x3f800002, 0x33800000, \
-        0x3f800002, 0x3f800001, 0x3f800002, 0x3f800001
+        0x3f800002, 0x3f800001, 0x3f800002, 0x3f800001, \
+             FSR_I,      FSR_I,      FSR_I,      FSR_I
 
     /* norm - norm = denorm */
     test_op2 sub.s, f6, f7, f8, 0x00800001, 0x00800000, \
-        0x00000001, 0x00000001, 0x00000001, 0x00000001
+        0x00000001, 0x00000001, 0x00000001, 0x00000001, \
+             FSR__,      FSR__,      FSR__,      FSR__
 test_end
 
 test mul_s
     test_op2 mul.s, f0, f1, f2, 0x3f800001, 0x3f800001, \
-        0x3f800002, 0x3f800002, 0x3f800003, 0x3f800002
-
+        0x3f800002, 0x3f800002, 0x3f800003, 0x3f800002, \
+             FSR_I,      FSR_I,      FSR_I,      FSR_I
     /* MAX_FLOAT/2 * MAX_FLOAT/2 = +inf/MAX_FLOAT  */
     test_op2 mul.s, f6, f7, f8, 0x7f000000, 0x7f000000, \
-        0x7f800000, 0x7f7fffff, 0x7f800000, 0x7f7fffff
+        0x7f800000, 0x7f7fffff, 0x7f800000, 0x7f7fffff, \
+            FSR_OI,     FSR_OI,     FSR_OI,     FSR_OI
     /* min norm * min norm = 0/denorm */
     test_op2 mul.s, f6, f7, f8, 0x00800001, 0x00800000, \
-        0x00000000, 0x00000000, 0x00000001, 0x00000000
-
+        0x00000000, 0x00000000, 0x00000001, 0x00000000, \
+            FSR_UI,     FSR_UI,     FSR_UI,     FSR_UI
     /* inf * 0 = default NaN */
     test_op2 mul.s, f6, f7, f8, 0x7f800000, 0x00000000, \
-        0x7fc00000, 0x7fc00000, 0x7fc00000, 0x7fc00000
+        0x7fc00000, 0x7fc00000, 0x7fc00000, 0x7fc00000, \
+             FSR_V,      FSR_V,      FSR_V,      FSR_V
 test_end
 
 test madd_s
     test_op3 madd.s, f0, f1, f2, f0, 0, 0x3f800001, 0x3f800001, \
-        0x3f800002, 0x3f800002, 0x3f800003, 0x3f800002
+        0x3f800002, 0x3f800002, 0x3f800003, 0x3f800002, \
+             FSR_I,      FSR_I,      FSR_I,      FSR_I
 test_end
 
 test msub_s
     test_op3 msub.s, f0, f1, f2, f0, 0x3f800000, 0x3f800001, 0x3f800001, \
-        0xb4800000, 0xb4800000, 0xb4800000, 0xb4800001
+        0xb4800000, 0xb4800000, 0xb4800000, 0xb4800001, \
+             FSR_I,      FSR_I,      FSR_I,      FSR_I
 test_end
 
 #endif
-- 
2.20.1



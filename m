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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CBA9C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 23:54:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB34F2070C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 23:54:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rmm91JOg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB34F2070C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsawD-0004xJ-2M
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 19:54:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35480)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1jsaqG-0001Ir-6t
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 19:48:08 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:45191)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1jsaqD-0000zf-KP
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 19:48:07 -0400
Received: by mail-pg1-x541.google.com with SMTP id l63so19099433pge.12
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2020 16:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=643YbMqUe3cU9Y3BkZ4lZoPyP5SXzuFH+wHJ5r5v8mE=;
 b=rmm91JOgnidHWjgOeLN764ab2i8W/pWbBZbrv9howTNsAlsE3KYirgutdqfisKMGSO
 pw3zNAV7CSA92kOAxUttbU05zgY113rW73vivaUY5fW4ReUZZ3mMeEQvHI0iyoyj/eh8
 cU30BH+4ti/wvj9aZOSzvlf4ry+KHDd264gkEVivTNqsX3SnSyJCS25f4SE7wydQadoY
 5TbZXhhdi/nt5nwf8cf6Bupjy49zzSwslHLqa3RMauUrERLukw9DxPwoMnSEzihaxJUd
 IYjasdreFaqwTSCn3GArP65XXmxoWV/I4spEuW1CQntJv1P6sF8TTTL19QZC3mQixQZw
 wvmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=643YbMqUe3cU9Y3BkZ4lZoPyP5SXzuFH+wHJ5r5v8mE=;
 b=A9uNNG0rJXFZzko24abfCUFlRd4sfxUJJnZ+6B+hZCVQX2lPrWSh4qihtiVN3hqQoI
 m0oq4nmbE1UEFY0g4BCL3YVQlMl6YtJleuOkY38D9IGvOQ35WVwUi3HTkfv16joj2c3C
 pvlZK6aVhqwShygA6jbfKm02YxoELv2CSQQhF/B1d6aD8B04a9y4x3E5hx0gZt00TV87
 IPu20fzTTzraekOF+9/ft0Fv+tUZlH3PcLljzJPbZXpS6x5dTOASMmkAT8gL7o7pm70i
 QQl0FsEWgtKv+1VukNG2Ck6f9Hbd6/i7Bg+RfcRB/49zcIQNfPht7Q4H/8F3Lo2sOWt2
 T0lA==
X-Gm-Message-State: AOAM5327/kSmzHGs+apgwKNblwFPwQVyQnDRBjvjxzj1K8IUW69f0WfG
 cXzbWD7k6x5uqR5TXcu9Oh1G7sTp
X-Google-Smtp-Source: ABdhPJzDmgczfPxrqSKo3WO2nBv69eBclnHK81ZSJyNaKyK14j92GhD/5vhnhNe1VGpApi4RC6U00w==
X-Received: by 2002:a63:7f5d:: with SMTP id p29mr42021282pgn.259.1594079283825; 
 Mon, 06 Jul 2020 16:48:03 -0700 (PDT)
Received: from octofox.cadence.com ([2601:641:400:e00:19b7:f650:7bbe:a7fb])
 by smtp.gmail.com with ESMTPSA id e15sm19647649pgt.17.2020.07.06.16.48.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2020 16:48:03 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 14/21] tests/tcg/xtensa: update test_fp0_conv for DFPU
Date: Mon,  6 Jul 2020 16:47:30 -0700
Message-Id: <20200706234737.32378-15-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200706234737.32378-1-jcmvbkbc@gmail.com>
References: <20200706234737.32378-1-jcmvbkbc@gmail.com>
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

DFPU conversion opcodes update FSR flags. Add FSR parameters and
expected FSR register values for the conversion tests.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 tests/tcg/xtensa/test_fp0_conv.S | 299 ++++++++++++++++---------------
 1 file changed, 155 insertions(+), 144 deletions(-)

diff --git a/tests/tcg/xtensa/test_fp0_conv.S b/tests/tcg/xtensa/test_fp0_conv.S
index 147e3d5062df..cfee6e51790c 100644
--- a/tests/tcg/xtensa/test_fp0_conv.S
+++ b/tests/tcg/xtensa/test_fp0_conv.S
@@ -1,4 +1,5 @@
 #include "macros.inc"
+#include "fpu.h"
 
 test_suite fp0_conv
 
@@ -9,7 +10,7 @@ test_suite fp0_conv
     wfr     \fr, a2
 .endm
 
-.macro test_ftoi_ex op, r0, fr0, v, c, r
+.macro test_ftoi_ex op, r0, fr0, v, c, r, sr
     movi    a2, 0
     wur     a2, fsr
     movfp   \fr0, \v
@@ -18,20 +19,25 @@ test_suite fp0_conv
     movi    a3, \r
     assert  eq, \r0, a3
     rur     a2, fsr
+#if DFPU
+    movi    a3, \sr
+    assert  eq, a2, a3
+#else
     assert  eqi, a2, 0
+#endif
 .endm
 
-.macro test_ftoi op, r0, fr0, v, c, r
+.macro test_ftoi op, r0, fr0, v, c, r, sr
     movi    a2, 0
     wur     a2, fcr
-    test_ftoi_ex \op, \r0, \fr0, \v, \c, \r
+    test_ftoi_ex \op, \r0, \fr0, \v, \c, \r, \sr
     movi    a2, 0x7c
     wur     a2, fcr
-    test_ftoi_ex \op, \r0, \fr0, \v, \c, \r
+    test_ftoi_ex \op, \r0, \fr0, \v, \c, \r, \sr
 .endm
 
 
-.macro test_itof_ex op, fr0, ar0, v, c, r
+.macro test_itof_ex op, fr0, ar0, v, c, r, sr
     movi    a2, 0
     wur     a2, fsr
     movi    \ar0, \v
@@ -42,23 +48,28 @@ test_suite fp0_conv
     movi    a3, \r
     assert  eq, a2, a3
     rur     a2, fsr
+#if DFPU
+    movi    a3, \sr
+    assert  eq, a2, a3
+#else
     assert  eqi, a2, 0
+#endif
 .endm
 
-.macro test_itof_rm op, fr0, ar0, v, c, rm, r
+.macro test_itof_rm op, fr0, ar0, v, c, rm, r, sr
     movi    a2, \rm
     wur     a2, fcr
-    test_itof_ex \op, \fr0, \ar0, \v, \c, \r
+    test_itof_ex \op, \fr0, \ar0, \v, \c, \r, \sr
     movi    a2, (\rm) | 0x7c
     wur     a2, fcr
-    test_itof_ex \op, \fr0, \ar0, \v, \c, \r
+    test_itof_ex \op, \fr0, \ar0, \v, \c, \r, \sr
 .endm
 
-.macro test_itof op, fr0, ar0, v, c, r0, r1, r2, r3
-    test_itof_rm \op, \fr0, \ar0, \v, \c, 0, \r0
-    test_itof_rm \op, \fr0, \ar0, \v, \c, 1, \r1
-    test_itof_rm \op, \fr0, \ar0, \v, \c, 2, \r2
-    test_itof_rm \op, \fr0, \ar0, \v, \c, 3, \r3
+.macro test_itof op, fr0, ar0, v, c, r0, r1, r2, r3, sr
+    test_itof_rm \op, \fr0, \ar0, \v, \c, 0, \r0, \sr
+    test_itof_rm \op, \fr0, \ar0, \v, \c, 1, \r1, \sr
+    test_itof_rm \op, \fr0, \ar0, \v, \c, 2, \r2, \sr
+    test_itof_rm \op, \fr0, \ar0, \v, \c, 3, \r3, \sr
 .endm
 
 test round_s
@@ -66,237 +77,237 @@ test round_s
     wsr     a2, cpenable
 
     /* NaN */
-    test_ftoi round.s, a2, f0, 0xffc00001, 0, 0x7fffffff
-    test_ftoi round.s, a2, f0, 0xff800001, 0, 0x7fffffff
+    test_ftoi round.s, a2, f0, 0xffc00001, 0, 0x7fffffff, FSR_V
+    test_ftoi round.s, a2, f0, 0xff800001, 0, 0x7fffffff, FSR_V
 
     /* -inf */
-    test_ftoi round.s, a2, f0, 0xff800000, 0, 0x80000000
+    test_ftoi round.s, a2, f0, 0xff800000, 0, 0x80000000, FSR_V
 
     /* negative overflow */
-    test_ftoi round.s, a2, f0, 0xceffffff, 1, 0x80000000
-    test_ftoi round.s, a2, f0, 0xcf000000, 0, 0x80000000
-    test_ftoi round.s, a2, f0, 0xceffffff, 0, 0x80000080
+    test_ftoi round.s, a2, f0, 0xceffffff, 1, 0x80000000, FSR_V
+    test_ftoi round.s, a2, f0, 0xcf000000, 0, 0x80000000, FSR__
+    test_ftoi round.s, a2, f0, 0xceffffff, 0, 0x80000080, FSR__
 
     /* negative */
-    test_ftoi round.s, a2, f0, 0xbfa00000, 1, -2 /* -1.25 * 2 */
-    test_ftoi round.s, a2, f0, 0xbfc00000, 0, -2 /* -1.5 */
-    test_ftoi round.s, a2, f0, 0xbf800000, 1, -2 /* -1 * 2 */
-    test_ftoi round.s, a2, f0, 0xbf800000, 0, -1 /* -1 */
-    test_ftoi round.s, a2, f0, 0xbf400000, 0, -1 /* -0.75 */
-    test_ftoi round.s, a2, f0, 0xbf000000, 0, 0  /* -0.5 */
+    test_ftoi round.s, a2, f0, 0xbfa00000, 1, -2, FSR_I  /* -1.25 * 2 */
+    test_ftoi round.s, a2, f0, 0xbfc00000, 0, -2, FSR_I  /* -1.5 */
+    test_ftoi round.s, a2, f0, 0xbf800000, 1, -2, FSR__  /* -1 * 2 */
+    test_ftoi round.s, a2, f0, 0xbf800000, 0, -1, FSR__  /* -1 */
+    test_ftoi round.s, a2, f0, 0xbf400000, 0, -1, FSR_I  /* -0.75 */
+    test_ftoi round.s, a2, f0, 0xbf000000, 0,  0, FSR_I  /* -0.5 */
 
     /* positive */
-    test_ftoi round.s, a2, f0, 0x3f000000, 0, 0 /* 0.5 */
-    test_ftoi round.s, a2, f0, 0x3f400000, 0, 1 /* 0.75 */
-    test_ftoi round.s, a2, f0, 0x3f800000, 0, 1 /* 1 */
-    test_ftoi round.s, a2, f0, 0x3f800000, 1, 2 /* 1 * 2 */
-    test_ftoi round.s, a2, f0, 0x3fc00000, 0, 2 /* 1.5 */
-    test_ftoi round.s, a2, f0, 0x3fa00000, 1, 2 /* 1.25 * 2 */
+    test_ftoi round.s, a2, f0, 0x3f000000, 0, 0, FSR_I /* 0.5 */
+    test_ftoi round.s, a2, f0, 0x3f400000, 0, 1, FSR_I /* 0.75 */
+    test_ftoi round.s, a2, f0, 0x3f800000, 0, 1, FSR__ /* 1 */
+    test_ftoi round.s, a2, f0, 0x3f800000, 1, 2, FSR__ /* 1 * 2 */
+    test_ftoi round.s, a2, f0, 0x3fc00000, 0, 2, FSR_I /* 1.5 */
+    test_ftoi round.s, a2, f0, 0x3fa00000, 1, 2, FSR_I /* 1.25 * 2 */
 
     /* positive overflow */
-    test_ftoi round.s, a2, f0, 0x4effffff, 0, 0x7fffff80
-    test_ftoi round.s, a2, f0, 0x4f000000, 0, 0x7fffffff
-    test_ftoi round.s, a2, f0, 0x4effffff, 1, 0x7fffffff
+    test_ftoi round.s, a2, f0, 0x4effffff, 0, 0x7fffff80, FSR__
+    test_ftoi round.s, a2, f0, 0x4f000000, 0, 0x7fffffff, FSR_V
+    test_ftoi round.s, a2, f0, 0x4effffff, 1, 0x7fffffff, FSR_V
 
     /* +inf */
-    test_ftoi round.s, a2, f0, 0x7f800000, 0, 0x7fffffff
+    test_ftoi round.s, a2, f0, 0x7f800000, 0, 0x7fffffff, FSR_V
 
     /* NaN */
-    test_ftoi round.s, a2, f0, 0x7f800001, 0, 0x7fffffff
-    test_ftoi round.s, a2, f0, 0x7fc00000, 0, 0x7fffffff
+    test_ftoi round.s, a2, f0, 0x7f800001, 0, 0x7fffffff, FSR_V
+    test_ftoi round.s, a2, f0, 0x7fc00000, 0, 0x7fffffff, FSR_V
 test_end
 
 test trunc_s
     /* NaN */
-    test_ftoi trunc.s, a2, f0, 0xffc00001, 0, 0x7fffffff
-    test_ftoi trunc.s, a2, f0, 0xff800001, 0, 0x7fffffff
+    test_ftoi trunc.s, a2, f0, 0xffc00001, 0, 0x7fffffff, FSR_V
+    test_ftoi trunc.s, a2, f0, 0xff800001, 0, 0x7fffffff, FSR_V
 
     /* -inf */
-    test_ftoi trunc.s, a2, f0, 0xff800000, 0, 0x80000000
+    test_ftoi trunc.s, a2, f0, 0xff800000, 0, 0x80000000, FSR_V
 
     /* negative overflow */
-    test_ftoi trunc.s, a2, f0, 0xceffffff, 1, 0x80000000
-    test_ftoi trunc.s, a2, f0, 0xcf000000, 0, 0x80000000
-    test_ftoi trunc.s, a2, f0, 0xceffffff, 0, 0x80000080
+    test_ftoi trunc.s, a2, f0, 0xceffffff, 1, 0x80000000, FSR_V
+    test_ftoi trunc.s, a2, f0, 0xcf000000, 0, 0x80000000, FSR__
+    test_ftoi trunc.s, a2, f0, 0xceffffff, 0, 0x80000080, FSR__
 
     /* negative */
-    test_ftoi trunc.s, a2, f0, 0xbfa00000, 1, -2 /* -1.25 * 2 */
-    test_ftoi trunc.s, a2, f0, 0xbfc00000, 0, -1 /* -1.5 */
-    test_ftoi trunc.s, a2, f0, 0xbf800000, 1, -2 /* -1 * 2 */
-    test_ftoi trunc.s, a2, f0, 0xbf800000, 0, -1 /* -1 */
-    test_ftoi trunc.s, a2, f0, 0xbf400000, 0, 0  /* -0.75 */
-    test_ftoi trunc.s, a2, f0, 0xbf000000, 0, 0  /* -0.5 */
+    test_ftoi trunc.s, a2, f0, 0xbfa00000, 1, -2, FSR_I /* -1.25 * 2 */
+    test_ftoi trunc.s, a2, f0, 0xbfc00000, 0, -1, FSR_I /* -1.5 */
+    test_ftoi trunc.s, a2, f0, 0xbf800000, 1, -2, FSR__ /* -1 * 2 */
+    test_ftoi trunc.s, a2, f0, 0xbf800000, 0, -1, FSR__ /* -1 */
+    test_ftoi trunc.s, a2, f0, 0xbf400000, 0,  0, FSR_I /* -0.75 */
+    test_ftoi trunc.s, a2, f0, 0xbf000000, 0,  0, FSR_I /* -0.5 */
 
     /* positive */
-    test_ftoi trunc.s, a2, f0, 0x3f000000, 0, 0 /* 0.5 */
-    test_ftoi trunc.s, a2, f0, 0x3f400000, 0, 0 /* 0.75 */
-    test_ftoi trunc.s, a2, f0, 0x3f800000, 0, 1 /* 1 */
-    test_ftoi trunc.s, a2, f0, 0x3f800000, 1, 2 /* 1 * 2 */
-    test_ftoi trunc.s, a2, f0, 0x3fc00000, 0, 1 /* 1.5 */
-    test_ftoi trunc.s, a2, f0, 0x3fa00000, 1, 2 /* 1.25 * 2 */
+    test_ftoi trunc.s, a2, f0, 0x3f000000, 0, 0, FSR_I /* 0.5 */
+    test_ftoi trunc.s, a2, f0, 0x3f400000, 0, 0, FSR_I /* 0.75 */
+    test_ftoi trunc.s, a2, f0, 0x3f800000, 0, 1, FSR__ /* 1 */
+    test_ftoi trunc.s, a2, f0, 0x3f800000, 1, 2, FSR__ /* 1 * 2 */
+    test_ftoi trunc.s, a2, f0, 0x3fc00000, 0, 1, FSR_I /* 1.5 */
+    test_ftoi trunc.s, a2, f0, 0x3fa00000, 1, 2, FSR_I /* 1.25 * 2 */
 
     /* positive overflow */
-    test_ftoi trunc.s, a2, f0, 0x4effffff, 0, 0x7fffff80
-    test_ftoi trunc.s, a2, f0, 0x4f000000, 0, 0x7fffffff
-    test_ftoi trunc.s, a2, f0, 0x4effffff, 1, 0x7fffffff
+    test_ftoi trunc.s, a2, f0, 0x4effffff, 0, 0x7fffff80, FSR__
+    test_ftoi trunc.s, a2, f0, 0x4f000000, 0, 0x7fffffff, FSR_V
+    test_ftoi trunc.s, a2, f0, 0x4effffff, 1, 0x7fffffff, FSR_V
 
     /* +inf */
-    test_ftoi trunc.s, a2, f0, 0x7f800000, 0, 0x7fffffff
+    test_ftoi trunc.s, a2, f0, 0x7f800000, 0, 0x7fffffff, FSR_V
 
     /* NaN */
-    test_ftoi trunc.s, a2, f0, 0x7f800001, 0, 0x7fffffff
-    test_ftoi trunc.s, a2, f0, 0x7fc00000, 0, 0x7fffffff
+    test_ftoi trunc.s, a2, f0, 0x7f800001, 0, 0x7fffffff, FSR_V
+    test_ftoi trunc.s, a2, f0, 0x7fc00000, 0, 0x7fffffff, FSR_V
 test_end
 
 test floor_s
     /* NaN */
-    test_ftoi floor.s, a2, f0, 0xffc00001, 0, 0x7fffffff
-    test_ftoi floor.s, a2, f0, 0xff800001, 0, 0x7fffffff
+    test_ftoi floor.s, a2, f0, 0xffc00001, 0, 0x7fffffff, FSR_V
+    test_ftoi floor.s, a2, f0, 0xff800001, 0, 0x7fffffff, FSR_V
 
     /* -inf */
-    test_ftoi floor.s, a2, f0, 0xff800000, 0, 0x80000000
+    test_ftoi floor.s, a2, f0, 0xff800000, 0, 0x80000000, FSR_V
 
     /* negative overflow */
-    test_ftoi floor.s, a2, f0, 0xceffffff, 1, 0x80000000
-    test_ftoi floor.s, a2, f0, 0xcf000000, 0, 0x80000000
-    test_ftoi floor.s, a2, f0, 0xceffffff, 0, 0x80000080
+    test_ftoi floor.s, a2, f0, 0xceffffff, 1, 0x80000000, FSR_V
+    test_ftoi floor.s, a2, f0, 0xcf000000, 0, 0x80000000, FSR__
+    test_ftoi floor.s, a2, f0, 0xceffffff, 0, 0x80000080, FSR__
 
     /* negative */
-    test_ftoi floor.s, a2, f0, 0xbfa00000, 1, -3 /* -1.25 * 2 */
-    test_ftoi floor.s, a2, f0, 0xbfc00000, 0, -2 /* -1.5 */
-    test_ftoi floor.s, a2, f0, 0xbf800000, 1, -2 /* -1 * 2 */
-    test_ftoi floor.s, a2, f0, 0xbf800000, 0, -1 /* -1 */
-    test_ftoi floor.s, a2, f0, 0xbf400000, 0, -1 /* -0.75 */
-    test_ftoi floor.s, a2, f0, 0xbf000000, 0, -1 /* -0.5 */
+    test_ftoi floor.s, a2, f0, 0xbfa00000, 1, -3, FSR_I /* -1.25 * 2 */
+    test_ftoi floor.s, a2, f0, 0xbfc00000, 0, -2, FSR_I /* -1.5 */
+    test_ftoi floor.s, a2, f0, 0xbf800000, 1, -2, FSR__ /* -1 * 2 */
+    test_ftoi floor.s, a2, f0, 0xbf800000, 0, -1, FSR__ /* -1 */
+    test_ftoi floor.s, a2, f0, 0xbf400000, 0, -1, FSR_I /* -0.75 */
+    test_ftoi floor.s, a2, f0, 0xbf000000, 0, -1, FSR_I /* -0.5 */
 
     /* positive */
-    test_ftoi floor.s, a2, f0, 0x3f000000, 0, 0 /* 0.5 */
-    test_ftoi floor.s, a2, f0, 0x3f400000, 0, 0 /* 0.75 */
-    test_ftoi floor.s, a2, f0, 0x3f800000, 0, 1 /* 1 */
-    test_ftoi floor.s, a2, f0, 0x3f800000, 1, 2 /* 1 * 2 */
-    test_ftoi floor.s, a2, f0, 0x3fc00000, 0, 1 /* 1.5 */
-    test_ftoi floor.s, a2, f0, 0x3fa00000, 1, 2 /* 1.25 * 2 */
+    test_ftoi floor.s, a2, f0, 0x3f000000, 0, 0, FSR_I /* 0.5 */
+    test_ftoi floor.s, a2, f0, 0x3f400000, 0, 0, FSR_I /* 0.75 */
+    test_ftoi floor.s, a2, f0, 0x3f800000, 0, 1, FSR__ /* 1 */
+    test_ftoi floor.s, a2, f0, 0x3f800000, 1, 2, FSR__ /* 1 * 2 */
+    test_ftoi floor.s, a2, f0, 0x3fc00000, 0, 1, FSR_I /* 1.5 */
+    test_ftoi floor.s, a2, f0, 0x3fa00000, 1, 2, FSR_I /* 1.25 * 2 */
 
     /* positive overflow */
-    test_ftoi floor.s, a2, f0, 0x4effffff, 0, 0x7fffff80
-    test_ftoi floor.s, a2, f0, 0x4f000000, 0, 0x7fffffff
-    test_ftoi floor.s, a2, f0, 0x4effffff, 1, 0x7fffffff
+    test_ftoi floor.s, a2, f0, 0x4effffff, 0, 0x7fffff80, FSR__
+    test_ftoi floor.s, a2, f0, 0x4f000000, 0, 0x7fffffff, FSR_V
+    test_ftoi floor.s, a2, f0, 0x4effffff, 1, 0x7fffffff, FSR_V
 
     /* +inf */
-    test_ftoi floor.s, a2, f0, 0x7f800000, 0, 0x7fffffff
+    test_ftoi floor.s, a2, f0, 0x7f800000, 0, 0x7fffffff, FSR_V
 
     /* NaN */
-    test_ftoi floor.s, a2, f0, 0x7f800001, 0, 0x7fffffff
-    test_ftoi floor.s, a2, f0, 0x7fc00000, 0, 0x7fffffff
+    test_ftoi floor.s, a2, f0, 0x7f800001, 0, 0x7fffffff, FSR_V
+    test_ftoi floor.s, a2, f0, 0x7fc00000, 0, 0x7fffffff, FSR_V
 test_end
 
 test ceil_s
     /* NaN */
-    test_ftoi ceil.s, a2, f0, 0xffc00001, 0, 0x7fffffff
-    test_ftoi ceil.s, a2, f0, 0xff800001, 0, 0x7fffffff
+    test_ftoi ceil.s, a2, f0, 0xffc00001, 0, 0x7fffffff, FSR_V
+    test_ftoi ceil.s, a2, f0, 0xff800001, 0, 0x7fffffff, FSR_V
 
     /* -inf */
-    test_ftoi ceil.s, a2, f0, 0xff800000, 0, 0x80000000
+    test_ftoi ceil.s, a2, f0, 0xff800000, 0, 0x80000000, FSR_V
 
     /* negative overflow */
-    test_ftoi ceil.s, a2, f0, 0xceffffff, 1, 0x80000000
-    test_ftoi ceil.s, a2, f0, 0xcf000000, 0, 0x80000000
-    test_ftoi ceil.s, a2, f0, 0xceffffff, 0, 0x80000080
+    test_ftoi ceil.s, a2, f0, 0xceffffff, 1, 0x80000000, FSR_V
+    test_ftoi ceil.s, a2, f0, 0xcf000000, 0, 0x80000000, FSR__
+    test_ftoi ceil.s, a2, f0, 0xceffffff, 0, 0x80000080, FSR__
 
     /* negative */
-    test_ftoi ceil.s, a2, f0, 0xbfa00000, 1, -2 /* -1.25 * 2 */
-    test_ftoi ceil.s, a2, f0, 0xbfc00000, 0, -1 /* -1.5 */
-    test_ftoi ceil.s, a2, f0, 0xbf800000, 1, -2 /* -1 * 2 */
-    test_ftoi ceil.s, a2, f0, 0xbf800000, 0, -1 /* -1 */
-    test_ftoi ceil.s, a2, f0, 0xbf400000, 0, 0  /* -0.75 */
-    test_ftoi ceil.s, a2, f0, 0xbf000000, 0, 0  /* -0.5 */
+    test_ftoi ceil.s, a2, f0, 0xbfa00000, 1, -2, FSR_I /* -1.25 * 2 */
+    test_ftoi ceil.s, a2, f0, 0xbfc00000, 0, -1, FSR_I /* -1.5 */
+    test_ftoi ceil.s, a2, f0, 0xbf800000, 1, -2, FSR__ /* -1 * 2 */
+    test_ftoi ceil.s, a2, f0, 0xbf800000, 0, -1, FSR__ /* -1 */
+    test_ftoi ceil.s, a2, f0, 0xbf400000, 0,  0, FSR_I /* -0.75 */
+    test_ftoi ceil.s, a2, f0, 0xbf000000, 0,  0, FSR_I /* -0.5 */
 
     /* positive */
-    test_ftoi ceil.s, a2, f0, 0x3f000000, 0, 1 /* 0.5 */
-    test_ftoi ceil.s, a2, f0, 0x3f400000, 0, 1 /* 0.75 */
-    test_ftoi ceil.s, a2, f0, 0x3f800000, 0, 1 /* 1 */
-    test_ftoi ceil.s, a2, f0, 0x3f800000, 1, 2 /* 1 * 2 */
-    test_ftoi ceil.s, a2, f0, 0x3fc00000, 0, 2 /* 1.5 */
-    test_ftoi ceil.s, a2, f0, 0x3fa00000, 1, 3 /* 1.25 * 2 */
+    test_ftoi ceil.s, a2, f0, 0x3f000000, 0, 1, FSR_I /* 0.5 */
+    test_ftoi ceil.s, a2, f0, 0x3f400000, 0, 1, FSR_I /* 0.75 */
+    test_ftoi ceil.s, a2, f0, 0x3f800000, 0, 1, FSR__ /* 1 */
+    test_ftoi ceil.s, a2, f0, 0x3f800000, 1, 2, FSR__ /* 1 * 2 */
+    test_ftoi ceil.s, a2, f0, 0x3fc00000, 0, 2, FSR_I /* 1.5 */
+    test_ftoi ceil.s, a2, f0, 0x3fa00000, 1, 3, FSR_I /* 1.25 * 2 */
 
     /* positive overflow */
-    test_ftoi ceil.s, a2, f0, 0x4effffff, 0, 0x7fffff80
-    test_ftoi ceil.s, a2, f0, 0x4f000000, 0, 0x7fffffff
-    test_ftoi ceil.s, a2, f0, 0x4effffff, 1, 0x7fffffff
+    test_ftoi ceil.s, a2, f0, 0x4effffff, 0, 0x7fffff80, FSR__
+    test_ftoi ceil.s, a2, f0, 0x4f000000, 0, 0x7fffffff, FSR_V
+    test_ftoi ceil.s, a2, f0, 0x4effffff, 1, 0x7fffffff, FSR_V
 
     /* +inf */
-    test_ftoi ceil.s, a2, f0, 0x7f800000, 0, 0x7fffffff
+    test_ftoi ceil.s, a2, f0, 0x7f800000, 0, 0x7fffffff, FSR_V
 
     /* NaN */
-    test_ftoi ceil.s, a2, f0, 0x7f800001, 0, 0x7fffffff
-    test_ftoi ceil.s, a2, f0, 0x7fc00000, 0, 0x7fffffff
+    test_ftoi ceil.s, a2, f0, 0x7f800001, 0, 0x7fffffff, FSR_V
+    test_ftoi ceil.s, a2, f0, 0x7fc00000, 0, 0x7fffffff, FSR_V
 test_end
 
 test utrunc_s
     /* NaN */
-    test_ftoi utrunc.s, a2, f0, 0xffc00001, 0, 0xffffffff
-    test_ftoi utrunc.s, a2, f0, 0xff800001, 0, 0xffffffff
+    test_ftoi utrunc.s, a2, f0, 0xffc00001, 0, 0xffffffff, FSR_V
+    test_ftoi utrunc.s, a2, f0, 0xff800001, 0, 0xffffffff, FSR_V
 
     /* -inf */
-    test_ftoi utrunc.s, a2, f0, 0xff800000, 0, 0x80000000
+    test_ftoi utrunc.s, a2, f0, 0xff800000, 0, 0x80000000, FSR_V
 
     /* negative overflow */
-    test_ftoi utrunc.s, a2, f0, 0xceffffff, 1, 0x80000000
-    test_ftoi utrunc.s, a2, f0, 0xcf000000, 0, 0x80000000
-    test_ftoi utrunc.s, a2, f0, 0xceffffff, 0, 0x80000080
+    test_ftoi utrunc.s, a2, f0, 0xceffffff, 1, 0x80000000, FSR_V
+    test_ftoi utrunc.s, a2, f0, 0xcf000000, 0, 0x80000000, FSR_V
+    test_ftoi utrunc.s, a2, f0, 0xceffffff, 0, 0x80000080, FSR_V
 
     /* negative */
-    test_ftoi utrunc.s, a2, f0, 0xbfa00000, 1, -2 /* -1.25 * 2 */
-    test_ftoi utrunc.s, a2, f0, 0xbfc00000, 0, -1 /* -1.5 */
-    test_ftoi utrunc.s, a2, f0, 0xbf800000, 1, -2 /* -1 * 2 */
-    test_ftoi utrunc.s, a2, f0, 0xbf800000, 0, -1 /* -1 */
-    test_ftoi utrunc.s, a2, f0, 0xbf400000, 0, 0  /* -0.75 */
-    test_ftoi utrunc.s, a2, f0, 0xbf000000, 0, 0  /* -0.5 */
+    test_ftoi utrunc.s, a2, f0, 0xbfa00000, 1, -2, FSR_V /* -1.25 * 2 */
+    test_ftoi utrunc.s, a2, f0, 0xbfc00000, 0, -1, FSR_V /* -1.5 */
+    test_ftoi utrunc.s, a2, f0, 0xbf800000, 1, -2, FSR_V /* -1 * 2 */
+    test_ftoi utrunc.s, a2, f0, 0xbf800000, 0, -1, FSR_V /* -1 */
+    test_ftoi utrunc.s, a2, f0, 0xbf400000, 0,  0, FSR_I /* -0.75 */
+    test_ftoi utrunc.s, a2, f0, 0xbf000000, 0,  0, FSR_I /* -0.5 */
 
     /* positive */
-    test_ftoi utrunc.s, a2, f0, 0x3f000000, 0, 0 /* 0.5 */
-    test_ftoi utrunc.s, a2, f0, 0x3f400000, 0, 0 /* 0.75 */
-    test_ftoi utrunc.s, a2, f0, 0x3f800000, 0, 1 /* 1 */
-    test_ftoi utrunc.s, a2, f0, 0x3f800000, 1, 2 /* 1 * 2 */
-    test_ftoi utrunc.s, a2, f0, 0x3fc00000, 0, 1 /* 1.5 */
-    test_ftoi utrunc.s, a2, f0, 0x3fa00000, 1, 2 /* 1.25 * 2 */
+    test_ftoi utrunc.s, a2, f0, 0x3f000000, 0, 0, FSR_I /* 0.5 */
+    test_ftoi utrunc.s, a2, f0, 0x3f400000, 0, 0, FSR_I /* 0.75 */
+    test_ftoi utrunc.s, a2, f0, 0x3f800000, 0, 1, FSR__ /* 1 */
+    test_ftoi utrunc.s, a2, f0, 0x3f800000, 1, 2, FSR__ /* 1 * 2 */
+    test_ftoi utrunc.s, a2, f0, 0x3fc00000, 0, 1, FSR_I /* 1.5 */
+    test_ftoi utrunc.s, a2, f0, 0x3fa00000, 1, 2, FSR_I /* 1.25 * 2 */
 
     /* positive overflow */
-    test_ftoi utrunc.s, a2, f0, 0x4effffff, 0, 0x7fffff80
-    test_ftoi utrunc.s, a2, f0, 0x4f000000, 0, 0x80000000
-    test_ftoi utrunc.s, a2, f0, 0x4effffff, 1, 0xffffff00
-    test_ftoi utrunc.s, a2, f0, 0x4f800000, 1, 0xffffffff
+    test_ftoi utrunc.s, a2, f0, 0x4effffff, 0, 0x7fffff80, FSR__
+    test_ftoi utrunc.s, a2, f0, 0x4f000000, 0, 0x80000000, FSR__
+    test_ftoi utrunc.s, a2, f0, 0x4effffff, 1, 0xffffff00, FSR__
+    test_ftoi utrunc.s, a2, f0, 0x4f800000, 1, 0xffffffff, FSR_V
 
     /* +inf */
-    test_ftoi utrunc.s, a2, f0, 0x7f800000, 0, 0xffffffff
+    test_ftoi utrunc.s, a2, f0, 0x7f800000, 0, 0xffffffff, FSR_V
 
     /* NaN */
-    test_ftoi utrunc.s, a2, f0, 0x7f800001, 0, 0xffffffff
-    test_ftoi utrunc.s, a2, f0, 0x7fc00000, 0, 0xffffffff
+    test_ftoi utrunc.s, a2, f0, 0x7f800001, 0, 0xffffffff, FSR_V
+    test_ftoi utrunc.s, a2, f0, 0x7fc00000, 0, 0xffffffff, FSR_V
 test_end
 
 test float_s
     test_itof float.s, f0, a2, -1, 0, \
-        0xbf800000, 0xbf800000, 0xbf800000, 0xbf800000
-    test_itof float.s, f0, a2, 0, 0, 0, 0, 0, 0
+        0xbf800000, 0xbf800000, 0xbf800000, 0xbf800000, FSR__
+    test_itof float.s, f0, a2, 0, 0, 0, 0, 0, 0, FSR__
     test_itof float.s, f0, a2, 1, 1, \
-        0x3f000000, 0x3f000000, 0x3f000000, 0x3f000000
+        0x3f000000, 0x3f000000, 0x3f000000, 0x3f000000, FSR__
     test_itof float.s, f0, a2, 1, 0, \
-        0x3f800000, 0x3f800000, 0x3f800000, 0x3f800000
+        0x3f800000, 0x3f800000, 0x3f800000, 0x3f800000, FSR__
     test_itof float.s, f0, a2, 0x7fffffff, 0, \
-        0x4f000000, 0x4effffff, 0x4f000000, 0x4effffff
+        0x4f000000, 0x4effffff, 0x4f000000, 0x4effffff, FSR_I
 test_end
 
 test ufloat_s
-    test_itof ufloat.s, f0, a2, 0, 0, 0, 0, 0, 0
+    test_itof ufloat.s, f0, a2, 0, 0, 0, 0, 0, 0, FSR__
     test_itof ufloat.s, f0, a2, 1, 1, \
-        0x3f000000, 0x3f000000, 0x3f000000, 0x3f000000
+        0x3f000000, 0x3f000000, 0x3f000000, 0x3f000000, FSR__
     test_itof ufloat.s, f0, a2, 1, 0, \
-        0x3f800000, 0x3f800000, 0x3f800000, 0x3f800000
+        0x3f800000, 0x3f800000, 0x3f800000, 0x3f800000, FSR__
     test_itof ufloat.s, f0, a2, 0x7fffffff, 0, \
-        0x4f000000, 0x4effffff, 0x4f000000, 0x4effffff
+        0x4f000000, 0x4effffff, 0x4f000000, 0x4effffff, FSR_I
     test_itof ufloat.s, f0, a2, 0xffffffff, 0, \
-        0x4f800000, 0x4f7fffff, 0x4f800000, 0x4f7fffff
+        0x4f800000, 0x4f7fffff, 0x4f800000, 0x4f7fffff, FSR_I
 test_end
 
 #endif
-- 
2.20.1



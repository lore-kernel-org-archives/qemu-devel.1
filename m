Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7DA8C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 20:43:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73AF4204EC
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 20:43:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xruTINwG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73AF4204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jj7ZZ-0007wy-OR
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 16:43:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49208)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jj7Vu-0003VM-JB
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 16:39:58 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:45480)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jj7Vt-0007gq-Au
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 16:39:58 -0400
Received: by mail-pg1-x544.google.com with SMTP id n23so1487565pgb.12
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2020 13:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ChL+mQvp08NHZYyarb1xR9uQbyNLWA/IcQ/TYqhGDbM=;
 b=xruTINwGTolaWY5DT0fIhQSqySSdU3p2t4hlchwrMiVfAHn1uQEz7gWDyB8NadXW1l
 CPlY6wFAEug4d5cnyLE9Eo9uTsrnQJY31hmBi6cB8KQVDTNv76bcIAUGqgkIBlsEP9e3
 HTgY2SZLHAlSBfGJZJTXcvmXUwL7Vuha89OLhSVhyaQxdm5dd3ELyLS5qH3iGcuhgIKw
 3paNi7TWFAmR2zJWGEWaJC3llAn5bhkmtE0vyKKGPAuLF97meypRKdBxv4AqpegzNRqF
 3YCTohUt/5omVbztWAp78JRXoCPCBrHI9VnU4t5je6UBS/GckqH85f+qiMPUYraXKDXj
 88Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ChL+mQvp08NHZYyarb1xR9uQbyNLWA/IcQ/TYqhGDbM=;
 b=AkiVQrJbX66/LEISSMSZqfrpIgyAcXnWY17Tk0d0CwKnqCG19PJZW6oGlqonK1jSZn
 YcxEqq7cp+ViQV+rax/2EdojxLywLPznoOFCYZnTavOnCigW+euP0Uhe09D3leJsk6ze
 +jNxuwfxF818SOJPCybW7MhCmpKeKrYIr352TzWbkgU1LptlKV1N9thAzBVfEpTjLMnH
 QUrHFkqTMc5ohCrxFHOIS80MNwY/4/jEcdYf1cWI84xPG8WB3iqkoJK5sY3lsa8t6k7t
 fyRrjmFlK2Sm4Q1chuZJB1Vo5rlRkBk0Zs9puWFLiwspLTSyt6Y1IkkgwnJF9p7efdSg
 3X5w==
X-Gm-Message-State: AOAM531w0eQ2WvxcVSbC40aL8S67gAQDFGya63//HmGbOla+GN1neQLw
 iqlnAlRCBXgh2JEhpL6hi9hSN6JSeRs=
X-Google-Smtp-Source: ABdhPJy8kfoDKsHUcdbmCXYqbjSUQ+Xq6eCnrVHjXMJCroYLYBN4d3DkKUZOqBWf/E7OE2Ic22XpHA==
X-Received: by 2002:aa7:9636:: with SMTP id r22mr4374452pfg.254.1591821585166; 
 Wed, 10 Jun 2020 13:39:45 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id g6sm740648pfb.164.2020.06.10.13.39.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2020 13:39:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/5] fpu/softfloat: Silence 'bitwise negation of boolean
 expression' warning
Date: Wed, 10 Jun 2020 13:39:38 -0700
Message-Id: <20200610203942.887374-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200610203942.887374-1-richard.henderson@linaro.org>
References: <20200610203942.887374-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x544.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

When building with clang version 10.0.0-4ubuntu1, we get:

    CC      lm32-softmmu/fpu/softfloat.o
  fpu/softfloat.c:3365:13: error: bitwise negation of a boolean expression; did you mean logical negation? [-Werror,-Wbool-operation]
      absZ &= ~ ( ( ( roundBits ^ 0x40 ) == 0 ) & roundNearestEven );
              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  fpu/softfloat.c:3423:18: error: bitwise negation of a boolean expression; did you mean logical negation? [-Werror,-Wbool-operation]
          absZ0 &= ~ ( ( (uint64_t) ( absZ1<<1 ) == 0 ) & roundNearestEven );
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  ...

  fpu/softfloat.c:4273:18: error: bitwise negation of a boolean expression; did you mean logical negation? [-Werror,-Wbool-operation]
          zSig1 &= ~ ( ( zSig2 + zSig2 == 0 ) & roundNearestEven );
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Fix by rewriting the fishy bitwise AND of two bools as an int.

Suggested-by: Eric Blake <eblake@redhat.com>
Buglink: https://bugs.launchpad.net/bugs/1881004
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200528155420.9802-1-philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c | 33 ++++++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 6c8f2d597a..5e9746c287 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -3362,7 +3362,9 @@ static int32_t roundAndPackInt32(bool zSign, uint64_t absZ,
     }
     roundBits = absZ & 0x7F;
     absZ = ( absZ + roundIncrement )>>7;
-    absZ &= ~ ( ( ( roundBits ^ 0x40 ) == 0 ) & roundNearestEven );
+    if (!(roundBits ^ 0x40) && roundNearestEven) {
+        absZ &= ~1;
+    }
     z = absZ;
     if ( zSign ) z = - z;
     if ( ( absZ>>32 ) || ( z && ( ( z < 0 ) ^ zSign ) ) ) {
@@ -3420,7 +3422,9 @@ static int64_t roundAndPackInt64(bool zSign, uint64_t absZ0, uint64_t absZ1,
     if ( increment ) {
         ++absZ0;
         if ( absZ0 == 0 ) goto overflow;
-        absZ0 &= ~ ( ( (uint64_t) ( absZ1<<1 ) == 0 ) & roundNearestEven );
+        if (!(absZ1 << 1) && roundNearestEven) {
+            absZ0 &= ~1;
+        }
     }
     z = absZ0;
     if ( zSign ) z = - z;
@@ -3480,7 +3484,9 @@ static int64_t roundAndPackUint64(bool zSign, uint64_t absZ0,
             float_raise(float_flag_invalid, status);
             return UINT64_MAX;
         }
-        absZ0 &= ~(((uint64_t)(absZ1<<1) == 0) & roundNearestEven);
+        if (!(absZ1 << 1) && roundNearestEven) {
+            absZ0 &= ~1;
+        }
     }
 
     if (zSign && absZ0) {
@@ -3603,7 +3609,9 @@ static float32 roundAndPackFloat32(bool zSign, int zExp, uint32_t zSig,
         status->float_exception_flags |= float_flag_inexact;
     }
     zSig = ( zSig + roundIncrement )>>7;
-    zSig &= ~ ( ( ( roundBits ^ 0x40 ) == 0 ) & roundNearestEven );
+    if (!(roundBits ^ 0x40) && roundNearestEven) {
+        zSig &= ~1;
+    }
     if ( zSig == 0 ) zExp = 0;
     return packFloat32( zSign, zExp, zSig );
 
@@ -3757,7 +3765,9 @@ static float64 roundAndPackFloat64(bool zSign, int zExp, uint64_t zSig,
         status->float_exception_flags |= float_flag_inexact;
     }
     zSig = ( zSig + roundIncrement )>>10;
-    zSig &= ~ ( ( ( roundBits ^ 0x200 ) == 0 ) & roundNearestEven );
+    if (!(roundBits ^ 0x200) && roundNearestEven) {
+        zSig &= ~1;
+    }
     if ( zSig == 0 ) zExp = 0;
     return packFloat64( zSign, zExp, zSig );
 
@@ -3983,8 +3993,9 @@ floatx80 roundAndPackFloatx80(int8_t roundingPrecision, bool zSign,
             }
             if ( increment ) {
                 ++zSig0;
-                zSig0 &=
-                    ~ ( ( (uint64_t) ( zSig1<<1 ) == 0 ) & roundNearestEven );
+                if (!(zSig1 << 1) && roundNearestEven) {
+                    zSig0 &= ~1;
+                }
                 if ( (int64_t) zSig0 < 0 ) zExp = 1;
             }
             return packFloatx80( zSign, zExp, zSig0 );
@@ -4000,7 +4011,9 @@ floatx80 roundAndPackFloatx80(int8_t roundingPrecision, bool zSign,
             zSig0 = UINT64_C(0x8000000000000000);
         }
         else {
-            zSig0 &= ~ ( ( (uint64_t) ( zSig1<<1 ) == 0 ) & roundNearestEven );
+            if (!(zSig1 << 1) && roundNearestEven) {
+                zSig0 &= ~1;
+            }
         }
     }
     else {
@@ -4270,7 +4283,9 @@ static float128 roundAndPackFloat128(bool zSign, int32_t zExp,
     }
     if ( increment ) {
         add128( zSig0, zSig1, 0, 1, &zSig0, &zSig1 );
-        zSig1 &= ~ ( ( zSig2 + zSig2 == 0 ) & roundNearestEven );
+        if ((zSig2 + zSig2 == 0) && roundNearestEven) {
+            zSig1 &= ~1;
+        }
     }
     else {
         if ( ( zSig0 | zSig1 ) == 0 ) zExp = 0;
-- 
2.25.1



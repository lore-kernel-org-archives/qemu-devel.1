Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F75C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 15:55:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C734B2053B
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 15:55:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="goPW2Kf8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C734B2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeKsS-00057A-1e
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 11:55:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35368)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jeKrm-0004E3-6V
 for qemu-devel@nongnu.org; Thu, 28 May 2020 11:54:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48402
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jeKrk-0006ko-Pb
 for qemu-devel@nongnu.org; Thu, 28 May 2020 11:54:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590681283;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=NLDeMVeHTEtmE5icNkCNL/NkDU3Z/mFmRdf8dGeCEWE=;
 b=goPW2Kf8XjdgGFU/gG1lWa1p/BcSCRv+fjK7ykiJ6zXACBUuZKPYUuYjYrbn5bkeXx+TnB
 EJjBU2jF0MEaJvJdGwg7c2I8lPHgSQ3kJhfPxpT0TBHtXMDfRNkTyuDMxoQviHBsSlK2de
 aneyJVHiqd7Me3rp9nuQSVKkN06j30Q=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-3SPq8Op5PsSDrPt4F1UNRg-1; Thu, 28 May 2020 11:54:25 -0400
X-MC-Unique: 3SPq8Op5PsSDrPt4F1UNRg-1
Received: by mail-wr1-f71.google.com with SMTP id s7so6232606wrm.16
 for <qemu-devel@nongnu.org>; Thu, 28 May 2020 08:54:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=NLDeMVeHTEtmE5icNkCNL/NkDU3Z/mFmRdf8dGeCEWE=;
 b=abVymT2xn6yHXHuR8ge/p5Ho+Je2tzk5l103WwJstLLVTdlqq7V0TGpRt4uSfXZVU3
 bNARg76DROfVpUL//NGI13wiMi0KaHzaheYb65vOLZFq+d9sEHKilgFffHV8+a/ROQd5
 XCgfaPY+S5oGRBHfHw8DylusrsLKy9qDv4Oy1nC5jBn4A2zuXScXhfRDQGC2OhD5TaxY
 Mol9LPdSHQOaUL1BD1a3EFtw8KlcelamL5F38Y22Ffg0A5o/CVf73+fbRJ0Ur9TJo+hn
 hOCgFkEAt7i3PUdQ8jR1TrrEqxaueThfFb5uK8umFViz4oY2CzY4q2yMbBPWoZ7pyq7M
 2tSg==
X-Gm-Message-State: AOAM531tS6/CFqerEJIQjzr967QB790wCJtfIgNXbZ28lLUN/q62TnHV
 W/GQrhHnaoRBl2trrXTX2ZzleOtmTPyLmTu9vXYiyvVsxJ5ysT+yU0pwT3n69U3QqX3DqmgtlAT
 b4DR7ucmpbaPbSHE=
X-Received: by 2002:a1c:1f85:: with SMTP id f127mr3871034wmf.163.1590681263859; 
 Thu, 28 May 2020 08:54:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz4dWggKQVz3hX3eDgorARLdIW+Vf4BQ9ZpfNW4sVGZMx9krgAJdYlsAympr08dD+yaz5Oxqw==
X-Received: by 2002:a1c:1f85:: with SMTP id f127mr3871014wmf.163.1590681263629; 
 Thu, 28 May 2020 08:54:23 -0700 (PDT)
Received: from localhost.localdomain (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id w17sm4212680wra.71.2020.05.28.08.54.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2020 08:54:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3] fpu/softfloat: Silence 'bitwise negation of boolean
 expression' warning
Date: Thu, 28 May 2020 17:54:20 +0200
Message-Id: <20200528155420.9802-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 03:11:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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
---
v3: remove parenthesis
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
2.21.3



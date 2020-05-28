Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 897A7C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 08:13:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5390F2088E
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 08:13:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="anEjzzPt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5390F2088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeDfO-0000Lw-G1
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 04:13:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56194)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jeDee-000873-Kx
 for qemu-devel@nongnu.org; Thu, 28 May 2020 04:12:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58572
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jeDeb-0001dJ-Mv
 for qemu-devel@nongnu.org; Thu, 28 May 2020 04:12:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590653559;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ju31ucyvt6u5FE7CDEX95IS6qEEv0uK9dmPtvsPxCRo=;
 b=anEjzzPtzAzdnlKgRd1zPmIrpDmEZXWyh5vr8oBA/UnczJnaXDRLDOMQ+maOYwxni9GCzm
 3FRqX5I6ogq+J8lLQ/4LA4IZ2t5kfUl1PtqTqrGbhDVv1yNSeICeIvYnouK+JzilTFRkoE
 CBKVo0A9hBgPbfwvSz5O1jAlYGvzfbU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-309-ADd1_C5LPJeUHzZPB3ZWLw-1; Thu, 28 May 2020 04:12:35 -0400
X-MC-Unique: ADd1_C5LPJeUHzZPB3ZWLw-1
Received: by mail-wr1-f70.google.com with SMTP id a4so3085697wrp.5
 for <qemu-devel@nongnu.org>; Thu, 28 May 2020 01:12:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ju31ucyvt6u5FE7CDEX95IS6qEEv0uK9dmPtvsPxCRo=;
 b=LVMd23jeg7JXtA51IBnGPRvF24QJ7g423Z1cq3+hcc8hgX9977jWUjFtRdmiwYobWw
 dpe94wW9cSI7sYPx0BhaBsOpR7CZkhTfVRvIII0HOQ847L3sof5iWtWKsnekoPKOGMz/
 FEa8hSCVReT1h5mkWvx4BtxC8yHl9xe2uFFiOFY+Fm9fupnHpBEwRbDsX2Xfy0NqHe8V
 wHTPx1C6K/NW7/wk/2FhrVV7/GgirXLrGnb8wtzvPhBDHZ2lLZmFB2sKyS1fN1VkhLR3
 qeUnCX6xd7sC12qUx7c3rhIpm/WFXMakBWdl6aPJfVdMV1RSSmEFVIGkfSQhG1nPdcTF
 WwiQ==
X-Gm-Message-State: AOAM532oenQwPydCLkF61E/XEWnG33HeD1WUHi3vxBQjFnHtCfUqVHop
 oZ2dKVp+1APngjckJm+fyyj3j4tRZlM4HlitduRZyKTK9IUKwGttwVR8mrpRcexCAztbKeXLo6x
 fW075YBmCMRwoL38=
X-Received: by 2002:a1c:e355:: with SMTP id a82mr2148550wmh.1.1590653551855;
 Thu, 28 May 2020 01:12:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw0Xu712Xjjz9lzrr3rE5OZifZ1IOIerxfXCrjsQX+lsP0cHwtSFd9aEwlo6/M00pfR5HvLhA==
X-Received: by 2002:a1c:e355:: with SMTP id a82mr2148511wmh.1.1590653551489;
 Thu, 28 May 2020 01:12:31 -0700 (PDT)
Received: from localhost.localdomain (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id z6sm5064638wrh.79.2020.05.28.01.12.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2020 01:12:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] fpu/softfloat: Silent 'bitwise negation of a boolean
 expression' warning
Date: Thu, 28 May 2020 10:12:28 +0200
Message-Id: <20200528081228.7716-1-philmd@redhat.com>
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
 Toni Wilen <twilen@winuae.net>,
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
            !
fpu/softfloat.c:3423:18: error: bitwise negation of a boolean expression; did you mean logical negation? [-Werror,-Wbool-operation]
        absZ0 &= ~ ( ( (uint64_t) ( absZ1<<1 ) == 0 ) & roundNearestEven );
                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                 !
fpu/softfloat.c:3483:18: error: bitwise negation of a boolean expression; did you mean logical negation? [-Werror,-Wbool-operation]
        absZ0 &= ~(((uint64_t)(absZ1<<1) == 0) & roundNearestEven);
                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                 !
fpu/softfloat.c:3606:13: error: bitwise negation of a boolean expression; did you mean logical negation? [-Werror,-Wbool-operation]
    zSig &= ~ ( ( ( roundBits ^ 0x40 ) == 0 ) & roundNearestEven );
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
            !
fpu/softfloat.c:3760:13: error: bitwise negation of a boolean expression; did you mean logical negation? [-Werror,-Wbool-operation]
    zSig &= ~ ( ( ( roundBits ^ 0x200 ) == 0 ) & roundNearestEven );
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
            !
fpu/softfloat.c:3987:21: error: bitwise negation of a boolean expression; did you mean logical negation? [-Werror,-Wbool-operation]
                    ~ ( ( (uint64_t) ( zSig1<<1 ) == 0 ) & roundNearestEven );
                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                    !
fpu/softfloat.c:4003:22: error: bitwise negation of a boolean expression; did you mean logical negation? [-Werror,-Wbool-operation]
            zSig0 &= ~ ( ( (uint64_t) ( zSig1<<1 ) == 0 ) & roundNearestEven );
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                     !
fpu/softfloat.c:4273:18: error: bitwise negation of a boolean expression; did you mean logical negation? [-Werror,-Wbool-operation]
        zSig1 &= ~ ( ( zSig2 + zSig2 == 0 ) & roundNearestEven );
                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                 !

Fix by rewriting the fishy bitwise AND of two bools as an int.

Cc: Toni Wilen <twilen@winuae.net>
Suggested-by: Eric Blake <eblake@redhat.com>
Buglink: https://bugs.launchpad.net/bugs/1881004
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 fpu/softfloat.c | 33 ++++++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 6c8f2d597a..0dd57eddd7 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -3362,7 +3362,9 @@ static int32_t roundAndPackInt32(bool zSign, uint64_t absZ,
     }
     roundBits = absZ & 0x7F;
     absZ = ( absZ + roundIncrement )>>7;
-    absZ &= ~ ( ( ( roundBits ^ 0x40 ) == 0 ) & roundNearestEven );
+    if (((roundBits ^ 0x40) == 0) && roundNearestEven) {
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
+        if (((absZ1 << 1) == 0) && roundNearestEven) {
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
+        if (((absZ1 << 1) == 0) && roundNearestEven) {
+            absZ0 &= ~1;
+        }
     }
 
     if (zSign && absZ0) {
@@ -3603,7 +3609,9 @@ static float32 roundAndPackFloat32(bool zSign, int zExp, uint32_t zSig,
         status->float_exception_flags |= float_flag_inexact;
     }
     zSig = ( zSig + roundIncrement )>>7;
-    zSig &= ~ ( ( ( roundBits ^ 0x40 ) == 0 ) & roundNearestEven );
+    if (((roundBits ^ 0x40) == 0) && roundNearestEven) {
+        zSig &= ~1;
+    }
     if ( zSig == 0 ) zExp = 0;
     return packFloat32( zSign, zExp, zSig );
 
@@ -3757,7 +3765,9 @@ static float64 roundAndPackFloat64(bool zSign, int zExp, uint64_t zSig,
         status->float_exception_flags |= float_flag_inexact;
     }
     zSig = ( zSig + roundIncrement )>>10;
-    zSig &= ~ ( ( ( roundBits ^ 0x200 ) == 0 ) & roundNearestEven );
+    if (((roundBits ^ 0x200) == 0) && roundNearestEven) {
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
+                if (((zSig1 << 1) == 0) && roundNearestEven) {
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
+            if (((zSig1 << 1) == 0) && roundNearestEven) {
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



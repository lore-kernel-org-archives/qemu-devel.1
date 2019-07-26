Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D7BDC7618F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 17:57:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F15BE21842
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 17:57:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x8oCBcnW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F15BE21842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr4Sp-0003Mk-46
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 13:57:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58884)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hr4NT-0005Hw-Vc
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:51:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hr4NO-0000ks-Qd
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:51:32 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:43351)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hr4NH-0000Jy-Jj
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:51:30 -0400
Received: by mail-pf1-x444.google.com with SMTP id i189so24859263pfg.10
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 10:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=BzmSmsqkudBY73N0i3QRkWoRxzKdjm/eJVgoMLfj3Sc=;
 b=x8oCBcnWbkKY7zCfEztHeVfrYPzRfIa3WgR5nfpNI1fmX4DNoyWWLNSE6eleo3P68z
 cOmnQhdQREWFxj2tZfxMlK8dsssaACi19p+kdF2IGY8XZoErdV/4C6xYs1ZCeod9cSyE
 Z0wttuNKaRAyWDYv7n18vI5RJ1nKX1ml6tPtRk/FCx8wqC3DBeIw0x8bRznMTyZSn8Av
 Kbz9JKt1dma195s6P8MAY151vyhmAL2Vzf8vlVXzxNGZ9Nfxc5WiGUiT5rWe0Nqj9GNM
 tb9xo4GnQi/YQHz22xxCRwbzWNGMEFelk51hZEW1DmuLsN3mSAhzcdDzjjnSsexnJzJu
 F6Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=BzmSmsqkudBY73N0i3QRkWoRxzKdjm/eJVgoMLfj3Sc=;
 b=Owe4Cc7YGr3ysfKOisv4CTaTIoJvkPDdyx1TeQu/7LcyZeLE7UqondYdLOmmKXRSKI
 zfCFlf6CuxcbEi1iZHZJyqJ8m1apB7vpaokTkPdfxeCQ4d60PnLdMvMLV1eg22RD4gCQ
 Za/t68vpcZjMBl6jxpWc0WCmshJvUfQxq/gc4V8cCBZxk/9h5k+lf3NlBHfsPeDHuH+D
 8eXEV2HnTeQnZUpq4Uju4HeDzES+Oc65VNz7gnoSdv77D0V8SgaAbsyHUr4Lmi1xdS9j
 VbSlzVREHKDjPC/saY+xzCp+8JgrW0Mlb1AhCZQ0bn3H5UaXQTgAnOoKW8NqEoYbwwwU
 D4dQ==
X-Gm-Message-State: APjAAAURv98ni3Vk6uY3rDb+sRb7wH6B/b0bbg/0yh5x+pTxoD2OyQ/W
 AWVGDIypgZWmp9uDsb+wok4VwlOUxIw=
X-Google-Smtp-Source: APXvYqwN+44aiQHbpiYeGpN+Ilm/kccpKUADqo6LMEP4BC0tuGOdxaAD3CTXLwwUeCgvXVoiCwILyw==
X-Received: by 2002:aa7:989a:: with SMTP id r26mr11675570pfl.232.1564163477012; 
 Fri, 26 Jul 2019 10:51:17 -0700 (PDT)
Received: from localhost.localdomain (97-126-117-207.tukw.qwest.net.
 [97.126.117.207])
 by smtp.gmail.com with ESMTPSA id o24sm104287919pfp.135.2019.07.26.10.51.15
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 26 Jul 2019 10:51:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 26 Jul 2019 10:50:01 -0700
Message-Id: <20190726175032.6769-37-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190726175032.6769-1-richard.henderson@linaro.org>
References: <20190726175032.6769-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: [Qemu-devel] [PATCH 36/67] target/arm: Convert PLI, PLD, PLDW
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c       | 37 +++++++++++++++++++-----------------
 target/arm/a32-uncond.decode | 10 ++++++++++
 2 files changed, 30 insertions(+), 17 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 1d07caa62a..5366741d7b 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -10147,6 +10147,26 @@ static bool trans_SETEND(DisasContext *s, arg_SETEND *a)
     return true;
 }
 
+/*
+ * Preload instructions
+ * All are nops, contingent on the appropriate arch level.
+ */
+
+static bool trans_PLD(DisasContext *s, arg_PLD *a)
+{
+    return ENABLE_ARCH_5TE;
+}
+
+static bool trans_PLDW(DisasContext *s, arg_PLD *a)
+{
+    return arm_dc_feature(s, ARM_FEATURE_V7MP);
+}
+
+static bool trans_PLI(DisasContext *s, arg_PLD *a)
+{
+    return ENABLE_ARCH_7;
+}
+
 /*
  * Legacy decoder.
  */
@@ -10207,23 +10227,6 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
             }
             return;
         }
-        if (((insn & 0x0f30f000) == 0x0510f000) ||
-            ((insn & 0x0f30f010) == 0x0710f000)) {
-            if ((insn & (1 << 22)) == 0) {
-                /* PLDW; v7MP */
-                if (!arm_dc_feature(s, ARM_FEATURE_V7MP)) {
-                    goto illegal_op;
-                }
-            }
-            /* Otherwise PLD; v5TE+ */
-            ARCH(5TE);
-            return;
-        }
-        if (((insn & 0x0f70f000) == 0x0450f000) ||
-            ((insn & 0x0f70f010) == 0x0650f000)) {
-            ARCH(7);
-            return; /* PLI; V7 */
-        }
         if (((insn & 0x0f700000) == 0x04100000) ||
             ((insn & 0x0f700010) == 0x06100000)) {
             if (!arm_dc_feature(s, ARM_FEATURE_V7MP)) {
diff --git a/target/arm/a32-uncond.decode b/target/arm/a32-uncond.decode
index d5ed48f0fd..aed381cb8e 100644
--- a/target/arm/a32-uncond.decode
+++ b/target/arm/a32-uncond.decode
@@ -54,3 +54,13 @@ SB               1111 0101 0111 1111 1111 0000 0111 0000
 
 # Set Endianness
 SETEND           1111 0001 0000 0001 0000 00 E:1 0 0000 0000  &setend
+
+# Preload instructions
+
+PLD              1111 0101 -101 ---- 1111 ---- ---- ----    # (imm, lit) 5te
+PLDW             1111 0101 -001 ---- 1111 ---- ---- ----    # (imm, lit) 7mp
+PLI              1111 0100 -101 ---- 1111 ---- ---- ----    # (imm, lit) 7
+
+PLD              1111 0111 -101 ---- 1111 ----- -- 0 ----   # (register) 5te
+PLDW             1111 0111 -001 ---- 1111 ----- -- 0 ----   # (register) 7mp
+PLI              1111 0110 -101 ---- 1111 ----- -- 0 ----   # (register) 7
-- 
2.17.1



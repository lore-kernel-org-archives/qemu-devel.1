Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0146BC433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 16:20:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C143C206A3
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 16:20:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ApKufer1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C143C206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsrLK-0000Ih-WF
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 12:20:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42390)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hsrG7-0005uW-8e
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:15:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hsrG6-0004A0-1m
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:15:23 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:53508)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hsrG5-00047H-Q6
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:15:21 -0400
Received: by mail-wm1-x344.google.com with SMTP id x15so61472968wmj.3
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 09:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=TwsNXkTsHTv8y1ITkoQ5QIXyXHIc1coCol9uilfBzDM=;
 b=ApKufer1ZmNFvz+1aMwTxRKO9pQL6ZDR3EM5lxC6cKVhXLgL10LatRlQGd+EOt+pL0
 Vfq6Y3DikqFLXLa4LOuvxZQSI4NEL1U2tG8odekY24u/s7SZ8jZYaitFdKiH7mvGlLYI
 d2tSWlgoY21T0+CXJiEosDttlzv24VDzJElrNv3TaOBOtstJzL0CqW3rnboNH8Q+XB0V
 zQ2zr9LPan0SOg0jRtVzuBkasLOBnoWrL2BKqvaAyo/Aq4qtRGB+ct2ue9Z3UR+ECg9k
 /yZ5THI5hlQvy7zCTPob5jLgsCa/JWIDKAGNtkGd2+EBJuggayHrZ+czjqiu8DpECMf0
 bKyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=TwsNXkTsHTv8y1ITkoQ5QIXyXHIc1coCol9uilfBzDM=;
 b=LK7rgTfoKCKhXAR/CSlxw5Ud0WgPkOCUZhSE/p1jQ2XfNpOh8/UWpcm7Rtm6GqEm3o
 3TnH7DMenElTDucuHyFozmigZ7leRXgfZHI58bTqP5mZt9SKHeXTNuNWNaVYo/URsWiu
 c608W7scABT5G/WXShA7Wo6FSfv2YUiqKkEEX2D0nEUWWb8wc5MT4arj5D27IaTOOknk
 7ExXwcNgFC2rs1xl5GaiDkTPZL5pmJY+stSM1XCONCLqP0ToGqu26QB4j9ZVA0UKuOXL
 QAB9Mf+L6umti3nSmlG7iClhQBDv/ECS1rCW5l3UqzSJb2rimrkUDfvobS+d2UZQBofF
 XVSA==
X-Gm-Message-State: APjAAAUpk3qhTt8qFsxQolH6cklOLULGeWxdzEviX070/1AAGAqkTAEi
 +i2zbZG3YJZhSQYKfpeozbVBXw==
X-Google-Smtp-Source: APXvYqwlsnN3B64lkx7YjD8MjHOEzJBHHB263RewdHibl9X2zGzGIj8+FhBugarytxweyWBP60SG1w==
X-Received: by 2002:a1c:7e14:: with SMTP id z20mr108780131wmc.83.1564589717279; 
 Wed, 31 Jul 2019 09:15:17 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id t63sm62639657wmt.6.2019.07.31.09.15.13
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 31 Jul 2019 09:15:14 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 6FCE71FFB5;
 Wed, 31 Jul 2019 17:07:22 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 31 Jul 2019 17:06:56 +0100
Message-Id: <20190731160719.11396-32-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190731160719.11396-1-alex.bennee@linaro.org>
References: <20190731160719.11396-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: [Qemu-devel] [PATCH v4 31/54] target/arm: fetch code with
 translator_ld
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
Cc: Peter Maydell <peter.maydell@linaro.org>, aaron@os.amperecomputing.com,
 cota@braap.org, "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 bobby.prani@gmail.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Now the arm_ld*_code functions are only used at translate time we can
just pass down to translator_ld functions.

Signed-off-by: Emilio G. Cota <cota@braap.org>
[AJB: convert from plugin_insn_append to translator_ld]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v4
  - use translator_ld like the rest of them
---
 target/arm/arm_ldst.h | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/target/arm/arm_ldst.h b/target/arm/arm_ldst.h
index 5e0ac8bef06..45edb108f6a 100644
--- a/target/arm/arm_ldst.h
+++ b/target/arm/arm_ldst.h
@@ -20,25 +20,20 @@
 #ifndef ARM_LDST_H
 #define ARM_LDST_H
 
-#include "exec/cpu_ldst.h"
+#include "exec/translator.h"
 #include "qemu/bswap.h"
 
 /* Load an instruction and return it in the standard little-endian order */
 static inline uint32_t arm_ldl_code(CPUARMState *env, target_ulong addr,
                                     bool sctlr_b)
 {
-    uint32_t insn = cpu_ldl_code(env, addr);
-    if (bswap_code(sctlr_b)) {
-        return bswap32(insn);
-    }
-    return insn;
+    return translator_ldl_swap(env, addr, bswap_code(sctlr_b));
 }
 
 /* Ditto, for a halfword (Thumb) instruction */
 static inline uint16_t arm_lduw_code(CPUARMState *env, target_ulong addr,
                                      bool sctlr_b)
 {
-    uint16_t insn;
 #ifndef CONFIG_USER_ONLY
     /* In big-endian (BE32) mode, adjacent Thumb instructions have been swapped
        within each word.  Undo that now.  */
@@ -46,11 +41,7 @@ static inline uint16_t arm_lduw_code(CPUARMState *env, target_ulong addr,
         addr ^= 2;
     }
 #endif
-    insn = cpu_lduw_code(env, addr);
-    if (bswap_code(sctlr_b)) {
-        return bswap16(insn);
-    }
-    return insn;
+    return translator_lduw_swap(env, addr, bswap_code(sctlr_b));
 }
 
 #endif
-- 
2.20.1



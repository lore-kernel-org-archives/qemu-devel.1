Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4854C4CEC9
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 18:43:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B696A2054F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 18:43:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sEdv/bdE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B696A2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAIS8-0005P5-8j
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 14:43:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33885)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iAIPd-000398-B1
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 14:41:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iAIPc-0000C5-6A
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 14:41:17 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:39674)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iAIPb-0000Aw-Uh
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 14:41:16 -0400
Received: by mail-wm1-x344.google.com with SMTP id v17so4334316wml.4
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 11:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=W2mrxFhentklW247RlP8yuKtv3QDjoQaHxNcDuVxHu8=;
 b=sEdv/bdEj1RASfFSB9kSovIL85YdolI70YY8ADkQdfMcxaHvUExpRgk8voHX4kYCY8
 /iRSLlElzTIZ5fU8f868DTMheXJZ5pl9on7U3+j8nI87C+we6vVRaUw9+jvv4J0KtJ1D
 pDOVHG7vr0DherArlD0a1VTCOI1jIDIMUkSd5jWNSzsLnApL2gMlhO9ZuO8BWFi3hLC3
 oqBxcq5N+P4pZU5hrDYIkTBSmpzLXUmN8fbJjzaRmvMVoqpmlh4/Rff71yVL0rAcEG1J
 /TlCVZv8B8RwskASnrYjsY9Qok8NXXrs6IxZfhMda+7Lt1I/f1EL29pj3BFYYAn8tjKo
 EN+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=W2mrxFhentklW247RlP8yuKtv3QDjoQaHxNcDuVxHu8=;
 b=ovm2GhwkmedhvJ4UpvR91KXdrnrb5NsnynkCsXSc8e8y9BemX6whYlzVpWp0f89WOR
 CLvpjHrgJQH18C30ODp/YI6FgE2WAnxFsj1is/0rTYiMk0U6COP088OwLut5skQpANd3
 vPGpNDym7Mkxp8An2zaI0OF4DBxdlubeAkKwUcbvezYdXG4nBmZqjyXBkmuCHofkSZbX
 JAxrc7L6AwwSPJdlrazaRhnAV2aiTMg/lCSWf9J1AVR54OAWKQ8XNDmjUJwQqJuAFZJR
 p94y2TXO5Xl2ml7aX15rU6JpdnOlwC3ak2PdPIMG7bCeR5yMJ2ViX/FYY5hPPWQ3l9lZ
 eZKQ==
X-Gm-Message-State: APjAAAXDC/+ZMY1oUtNbzcego0gkQG4cDEk7C+mOvswqBVlkoMuypAJa
 F81VTcdnuyr0QLMa0xMXc3sloLldYB0=
X-Google-Smtp-Source: APXvYqzpsH+qTk9XuY3I6UAgUgHKKG5CMq/QcOeDEf5uBsZ2JsEbQx9PlFO/vEGiD+zdOUT7puOldQ==
X-Received: by 2002:a1c:1981:: with SMTP id 123mr4519852wmz.88.1568745674754; 
 Tue, 17 Sep 2019 11:41:14 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id x15sm2297663wmc.16.2019.09.17.11.41.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Sep 2019 11:41:11 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C11AD1FF91;
 Tue, 17 Sep 2019 19:41:09 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Tue, 17 Sep 2019 19:41:04 +0100
Message-Id: <20190917184109.12564-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190917184109.12564-1-alex.bennee@linaro.org>
References: <20190917184109.12564-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: [Qemu-devel] [PATCH v1 4/9] target/ppc: fix signal delivery for
 ppc64abi32
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
Cc: Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We were incorrectly using the 64-bit AIX ABI instead of the 32-bit
SYSV ABI for setting NIP for the signal handler.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

---
v2
  - change to wording
---
 linux-user/ppc/signal.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/linux-user/ppc/signal.c b/linux-user/ppc/signal.c
index 619a56950df..5b82af6cb62 100644
--- a/linux-user/ppc/signal.c
+++ b/linux-user/ppc/signal.c
@@ -501,7 +501,9 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
     int i, err = 0;
 #if defined(TARGET_PPC64)
     struct target_sigcontext *sc = 0;
+#if !defined(TARGET_ABI32)
     struct image_info *image = ((TaskState *)thread_cpu->opaque)->info;
+#endif
 #endif
 
     rt_sf_addr = get_sigframe(ka, env, sizeof(*rt_sf));
@@ -557,7 +559,7 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
     env->gpr[5] = (target_ulong) h2g(&rt_sf->uc);
     env->gpr[6] = (target_ulong) h2g(rt_sf);
 
-#if defined(TARGET_PPC64)
+#if defined(TARGET_PPC64) && !defined(TARGET_ABI32)
     if (get_ppc64_abi(image) < 2) {
         /* ELFv1 PPC64 function pointers are pointers to OPD entries. */
         struct target_func_ptr *handler =
-- 
2.20.1



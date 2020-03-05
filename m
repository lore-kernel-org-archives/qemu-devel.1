Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 930F4C3F2D1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 16:48:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C70D20637
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 16:48:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x8iV2hyd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C70D20637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9tfI-0005c2-Dm
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 11:48:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59264)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j9tP9-0003YS-ID
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 11:31:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j9tP8-0002MN-G3
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 11:31:23 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:32898)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j9tP7-0002Is-9F
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 11:31:22 -0500
Received: by mail-wr1-x42d.google.com with SMTP id x7so7821839wrr.0
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2020 08:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=g0YUytWq4vRm1t30VeqE3UA29+mSL//Cjkgt5k66VTA=;
 b=x8iV2hydGzpeJ4kzI3VUJKaG9+ffGLgpAmVlq93+a0E//8p61SwZlpkniqi6yb8E+n
 vPDGg6EmHddn3/AO9y7dXVVYSJTJHJfb1Uy+4Cr9S+lFe5AhFA4cVbs8zIfeyvGi5c1w
 cRkiogeFN8AeHhBBHOFjM3BaHh3+ju/8nG2grclY0d+o126x0Cxn77gHmtRErRPh5i26
 we2lAkJamcUwDUsWD14q/WnIIpT8fOGZ9U1MlFrfkwJSHep2WX/u+gaDfHN8LlllIxgN
 9geo9NUce87iQhg6CBNPebPZcNpktP8RkPTWUibP3xQT0xx59yvmUUrWt4FtqnC0zV+Y
 mlvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=g0YUytWq4vRm1t30VeqE3UA29+mSL//Cjkgt5k66VTA=;
 b=kfdlrszye2BK8p+fKZvTKenfw/iHU5nWIlMZIhQ9/Nwy2BOQXLsFu7R1wtf7we7GHm
 NCn3QB8Kz90D+eHqkNFRFfPyXif/SvgGfNVYfieW2pbbdn1rxuoDm9JKBbBAorIsS0F8
 EV30Goie9gty6mZ7pu+zDyo7ec1zEC1Db0zzsDNfNfYfLfhS1wpcM6c13rmM4qKlpcxf
 +HPBMrbg9RkqorRPqqyicdSmuBqy12rGfM88W6/Vd0DO7uJDqSGdXwD0b070l/gGPOB5
 qDK82d5k5bRKfDMHTWxuSXgM4MFGXKnnbEHvnrsXBW7zxeJIH4vfcsuDO9371JHw6RQq
 qUxA==
X-Gm-Message-State: ANhLgQ0vmGPo6zjZflTTJBT99czaj0rFq5HEOYLvIHW3kQU41iKnQ2iT
 jtB6yt7NUm0C90gCcnpHUPhJ0qgSdnewDw==
X-Google-Smtp-Source: ADFU+vuCYd9KioTfnwM+MYjRTZWneo55vGLDTE5uGYydMbF/6G7RL97eJBFNKnr9zEmSpWzhto0Wwg==
X-Received: by 2002:adf:eece:: with SMTP id a14mr10861738wrp.311.1583425879905; 
 Thu, 05 Mar 2020 08:31:19 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w22sm10310729wmk.34.2020.03.05.08.31.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2020 08:31:19 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/37] target/arm: Add HCR_EL2 bit definitions from ARMv8.6
Date: Thu,  5 Mar 2020 16:30:39 +0000
Message-Id: <20200305163100.22912-17-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200305163100.22912-1-peter.maydell@linaro.org>
References: <20200305163100.22912-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42d
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200229012811.24129-3-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 0b84742b66a..0ae07a72e43 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1410,6 +1410,7 @@ static inline void xpsr_write(CPUARMState *env, uint32_t val, uint32_t mask)
 #define HCR_TERR      (1ULL << 36)
 #define HCR_TEA       (1ULL << 37)
 #define HCR_MIOCNCE   (1ULL << 38)
+/* RES0 bit 39 */
 #define HCR_APK       (1ULL << 40)
 #define HCR_API       (1ULL << 41)
 #define HCR_NV        (1ULL << 42)
@@ -1418,13 +1419,19 @@ static inline void xpsr_write(CPUARMState *env, uint32_t val, uint32_t mask)
 #define HCR_NV2       (1ULL << 45)
 #define HCR_FWB       (1ULL << 46)
 #define HCR_FIEN      (1ULL << 47)
+/* RES0 bit 48 */
 #define HCR_TID4      (1ULL << 49)
 #define HCR_TICAB     (1ULL << 50)
+#define HCR_AMVOFFEN  (1ULL << 51)
 #define HCR_TOCU      (1ULL << 52)
+#define HCR_ENSCXT    (1ULL << 53)
 #define HCR_TTLBIS    (1ULL << 54)
 #define HCR_TTLBOS    (1ULL << 55)
 #define HCR_ATA       (1ULL << 56)
 #define HCR_DCT       (1ULL << 57)
+#define HCR_TID5      (1ULL << 58)
+#define HCR_TWEDEN    (1ULL << 59)
+#define HCR_TWEDEL    MAKE_64BIT_MASK(60, 4)
 
 #define SCR_NS                (1U << 0)
 #define SCR_IRQ               (1U << 1)
-- 
2.20.1



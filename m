Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AA4FC4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 16:38:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2570A20663
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 16:38:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l2X4mcWi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2570A20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK3Mk-0005Vi-K7
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 12:38:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37226)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iK2qS-0004j7-Vs
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:05:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iK2qR-0007vc-SH
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:05:16 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:54977)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iK2qR-0007ub-MA
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:05:15 -0400
Received: by mail-wm1-x330.google.com with SMTP id p7so17868212wmp.4
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 09:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=IPPpRDvS1khlTKhQXpsP8betxpNnecGFCTfAvZZmBYI=;
 b=l2X4mcWiQwjJTESJQHgOwNf2zaN90pCzSndilgEohpgxa8rRca0IFuTfQqHaXl9+k0
 pVFWTBB+5JQGE/5GckgitcniQsWk3aJ/3nghEXWqVXxEyQ8qUi5kSuUg1/hwRqejiE3Q
 pYmtauaLMr2FhPsxdSzdkGwI+XQ7Fl26Jt0vajhQTS9KIN3O2LoqMGw8xMXWxPpwmOmL
 aPuVcuNVw9fAUWz9gVrafzH6XXbdqwYff3tyuheboIarr5lYMfjQBxjNvcmIr1jCW3I0
 oX6DN1UPYnw1W3B0vtW2UcTXjvA22Yw6jP7xDHKVQwir/g2VNSnClAEQC4rGq0iqIvMJ
 ks+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=IPPpRDvS1khlTKhQXpsP8betxpNnecGFCTfAvZZmBYI=;
 b=UHP73vbtKKlEaQlVLGK7YjW0mtUjldAWSE0jbqwKL78mYg8S5xpXiJX7YfcyusYxpn
 CD1t7Zw8r2x8fqxF2easiK922tsi0W/BN5pb58de5CopCoe5DdZrWquPw+xjaR0vnWz3
 nV6P28SnSs6sqP7OLQg7Mz+/xDVO4xLzHbVFfEKbJI0QnrsKSP9WPM8EY6vAsnSPzZiG
 OyXDk7g+o4bcsQ2/EHe6xuTviBVrEqW0JpN9GdW/hZlwOgPejpPgRemrb64am21QAXlc
 OFBrQ9UXxehx9AjsqEPjwi8GGSm+VVdOQRDpy+77eSFBYiVD3ZAfT6CdSwwelojsPvFE
 037g==
X-Gm-Message-State: APjAAAVWnt1QD4Nk2RzFt2hUYazZT2Wv69dPPgipJKDbPfM7BmcuI4u8
 Ey8fRexogEVzr7y/wyeHKHACNLR2x+UGig==
X-Google-Smtp-Source: APXvYqyFgIVgUen3cre5YfGrNB1JbNo4c5P/EkNvmxC/nlIpJdYR/+H0TMbpwCXCwfy2H9c1Dre1PA==
X-Received: by 2002:a05:600c:2201:: with SMTP id
 z1mr16076270wml.169.1571069113709; 
 Mon, 14 Oct 2019 09:05:13 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 5sm18029779wrk.86.2019.10.14.09.05.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 09:05:12 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 40/68] aspeed/wdt: Check correct register for clock source
Date: Mon, 14 Oct 2019 17:03:36 +0100
Message-Id: <20191014160404.19553-41-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191014160404.19553-1-peter.maydell@linaro.org>
References: <20191014160404.19553-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::330
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

From: Amithash Prasad <amithash@fb.com>

When WDT_RESTART is written, the data is not the contents
of the WDT_CTRL register. Hence ensure we are looking at
WDT_CTRL to check if bit WDT_CTRL_1MHZ_CLK is set or not.

Signed-off-by: Amithash Prasad <amithash@fb.com>
Reviewed-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
Message-id: 20190925143248.10000-2-clg@kaod.org
[clg: improved Suject prefix ]
Signed-off-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/watchdog/wdt_aspeed.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/watchdog/wdt_aspeed.c b/hw/watchdog/wdt_aspeed.c
index 9b932134172..f710036535d 100644
--- a/hw/watchdog/wdt_aspeed.c
+++ b/hw/watchdog/wdt_aspeed.c
@@ -140,7 +140,7 @@ static void aspeed_wdt_write(void *opaque, hwaddr offset, uint64_t data,
     case WDT_RESTART:
         if ((data & 0xFFFF) == WDT_RESTART_MAGIC) {
             s->regs[WDT_STATUS] = s->regs[WDT_RELOAD_VALUE];
-            aspeed_wdt_reload(s, !(data & WDT_CTRL_1MHZ_CLK));
+            aspeed_wdt_reload(s, !(s->regs[WDT_CTRL] & WDT_CTRL_1MHZ_CLK));
         }
         break;
     case WDT_CTRL:
-- 
2.20.1



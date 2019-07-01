Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C3FC5B578
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 02:47:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEDEE21479
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 02:47:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BcKv3pdK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEDEE21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hi8Vk-00059u-MQ
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 22:27:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58855)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hi4Z1-00058v-8U
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 18:14:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hi4Z0-0003mR-74
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 18:14:19 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41720)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hi4Z0-0003m0-0P
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 18:14:18 -0400
Received: by mail-wr1-f66.google.com with SMTP id c2so15466177wrm.8
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 15:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=SM8mY+R0SiuBOfCMBxDLwmP2jvWXg+rVriH+MW5T7NQ=;
 b=BcKv3pdK6VP3YAvICZ3IjFWl8q1SUNfgZVufEMve5wV23Y9aKngp7BhjFG3Lfwflji
 vXaGU0aO3uJnFcAWRygMdhXJ2ZePDe53efT/3XN0Gyh7T8rx8CrV0auXxalGzoJBw4/A
 c65cRGaNitO2d9kW75cz8dkPys7TAN6z8VE1OMAqSUs3x/wPrnp/a/q7JVd9T+zJ5PFi
 jmi86rSre0NHaa2KEhF9dPRNvMwxDsM9WjptMZA2SCkSE0UgeS1xGz/O/vUV2V6dOXPQ
 j0dpacPdzSyBERnahO2v4ZVbmXGnG0hQzm6s6ZtqwNJY8p7GR3pFkhYoDV4Yn2TnmlUP
 VXSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=SM8mY+R0SiuBOfCMBxDLwmP2jvWXg+rVriH+MW5T7NQ=;
 b=C8eP99jhMev0rUeJzXjc2IV2LbLpnKoqer7wdYe7Zy57+PHXaVAEbgSg8tzhiMGPB0
 0kldTxoIw3jORbNq52wLdxUvzgsP39BfENolcsqKvznyLUeSdG42EHcT6rkXdoX5rKon
 FRsSMAyrQrqhfu7oyqmVFEwamjdFlJCmNl4xI8vmOTX4m8l7XyZvjZOKcC7Ar2vXvsUG
 FAExM3ZzaRDmgBU9ZIvin/4AtpOn4kX8zNzsLHv5khmrpi7C3f5V/tJeNVwPBmNX9fUY
 08ddBes0usyUttWZIB8IWZtrbXKErHWVCrwTfvRYoDI5/LmDqPIriToObCsxVCGkjAW2
 G/Fg==
X-Gm-Message-State: APjAAAWrxXxKui2m54gR2Q5r+pEgwkLrI9lj1r2sPnXLGBXCRDGt0S+V
 uimN+HyVhw4aNqhiU9a14yK34PpPDwjBzA==
X-Google-Smtp-Source: APXvYqxKgF3m5Olw4flHXvWP4Bn+sryjaKJzfiMfXIOtoIT+qhRcBaYZhuPwFrzbfEsEiq/7UC+pzA==
X-Received: by 2002:adf:dc09:: with SMTP id t9mr1952549wri.69.1561999204945;
 Mon, 01 Jul 2019 09:40:04 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id o6sm26573508wra.27.2019.07.01.09.40.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 01 Jul 2019 09:40:04 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon,  1 Jul 2019 17:39:15 +0100
Message-Id: <20190701163943.22313-19-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190701163943.22313-1-peter.maydell@linaro.org>
References: <20190701163943.22313-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.66
Subject: [Qemu-devel] [PULL 18/46] aspeed/timer: Ensure positive muldiv delta
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

From: Christian Svensson <bluecmd@google.com>

If the host decrements the counter register that results in a negative
delta. This is then passed to muldiv64 which only handles unsigned
numbers resulting in bogus results.

This fix ensures the delta being operated on is positive.

Test case: kexec a kernel using aspeed_timer and it will freeze on the
second bootup when the kernel initializes the timer. With this patch
that no longer happens and the timer appears to run OK.

Signed-off-by: Christian Svensson <bluecmd@google.com>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Joel Stanley <joel@jms.id.au>
Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
Message-id: 20190618165311.27066-12-clg@kaod.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/timer/aspeed_timer.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/timer/aspeed_timer.c b/hw/timer/aspeed_timer.c
index 745eb8608b5..29cc5e80708 100644
--- a/hw/timer/aspeed_timer.c
+++ b/hw/timer/aspeed_timer.c
@@ -275,7 +275,11 @@ static void aspeed_timer_set_value(AspeedTimerCtrlState *s, int timer, int reg,
             int64_t delta = (int64_t) value - (int64_t) calculate_ticks(t, now);
             uint32_t rate = calculate_rate(t);
 
-            t->start += muldiv64(delta, NANOSECONDS_PER_SECOND, rate);
+            if (delta >= 0) {
+                t->start += muldiv64(delta, NANOSECONDS_PER_SECOND, rate);
+            } else {
+                t->start -= muldiv64(-delta, NANOSECONDS_PER_SECOND, rate);
+            }
             aspeed_timer_mod(t);
         }
         break;
-- 
2.20.1



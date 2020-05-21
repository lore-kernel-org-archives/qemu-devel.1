Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC86DC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 19:25:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9000E207D3
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 19:25:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tflTDjYp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9000E207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbqod-0003TK-QE
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 15:25:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38080)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jbqgF-0002aH-SU
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:16:35 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:34794)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jbqgE-0000S0-Uc
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:16:35 -0400
Received: by mail-wr1-x443.google.com with SMTP id g12so6565549wrw.1
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 12:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=d4s6zDnREhAoNMbKHlnL2nJicHbk/umExwSYklWFs54=;
 b=tflTDjYpC52AKWnAhfxxCXbmepuYlmubnTqxirCXniltCnkuvbrTBEzcofqu01ZBn8
 oJ9UCAQWo0ZQTtsOskxs4Ud1E/A9ThHiXL7yMY3cSByenZBUm2t5jhj89Iu5RtvYvz9Z
 45ND27B/IjrzJ7zYs7NVJM6ne4lrE1rlc/A10CK68cTNdoEO2wJ/sZGlCzfc+2zjPYrL
 l+dPCkYMSJtiTC0ILFgXpNDjzNSbeIAXr7pkFrS2dzmVGQizdYxMETcE5l/X26uVUgbF
 2RlLaJ8oRKHugoo1jNBJY2XiP0Kpza9aaxlJFcpCrwRJJOy6/N/q3cY+w+bbOgxv82eL
 Eb2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=d4s6zDnREhAoNMbKHlnL2nJicHbk/umExwSYklWFs54=;
 b=r2S4Y9B6bZSjv4sv6es5ez5JaPMKyje6aNrWgLysOVaPPVszvZbbbgSSV484EuU42Q
 6LyeOEvEM7+JCxREoUoOvbpmapAlu1bElvf36eTj6xxlnUMzFiYQiiMQt/O3191ZlrE6
 f2/93h3vvS8UvhAQNt5/0U56Y6H3rZJxEY71Ra6JgiLHsRxteGB+qtrFaLk3DtHtD9H9
 hVeKfUmMDdcW8+I/H/xij1ubD5F4uNB3VOcI5OM4HZ3F6pbntQ/Sjk60jl1EySIIIV7b
 jeO7tNp+L5OduupWu5HB5JqV5nPHUYDkkAr1PcjLIXVvCSuufII0Tqm0wRLv3Km+R8l5
 bOtQ==
X-Gm-Message-State: AOAM531+3N2rTZA75lGTUJFULHB6iCW0D/zyKvYVal1gVxYHrRVPS6J/
 OW1nCniSshgKCVHz/UXxBlj2m7dw384rKg==
X-Google-Smtp-Source: ABdhPJz5UfHtihmnw1Da25Tyw6WCCGcgOd7bOtBZos9NhSl4d0nFEJ7NxcJTVbNeVE2mpFBz7GdY4w==
X-Received: by 2002:a5d:530a:: with SMTP id e10mr75209wrv.303.1590088593322;
 Thu, 21 May 2020 12:16:33 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id z124sm7335100wmg.20.2020.05.21.12.16.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 12:16:32 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 17/29] hw/arm/fsl-imx6ul: Connect watchdog interrupts
Date: Thu, 21 May 2020 20:15:58 +0100
Message-Id: <20200521191610.10941-18-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200521191610.10941-1-peter.maydell@linaro.org>
References: <20200521191610.10941-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Guenter Roeck <linux@roeck-us.net>

With this commit, the watchdog on mcimx6ul-evk is fully operational,
including pretimeout support.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Message-id: 20200517162135.110364-7-linux@roeck-us.net
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/fsl-imx6ul.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/arm/fsl-imx6ul.c b/hw/arm/fsl-imx6ul.c
index 56dfd7cecc9..3ecb212da6f 100644
--- a/hw/arm/fsl-imx6ul.c
+++ b/hw/arm/fsl-imx6ul.c
@@ -531,12 +531,22 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
             FSL_IMX6UL_WDOG2_ADDR,
             FSL_IMX6UL_WDOG3_ADDR,
         };
+        static const int FSL_IMX6UL_WDOGn_IRQ[FSL_IMX6UL_NUM_WDTS] = {
+            FSL_IMX6UL_WDOG1_IRQ,
+            FSL_IMX6UL_WDOG2_IRQ,
+            FSL_IMX6UL_WDOG3_IRQ,
+        };
 
+        object_property_set_bool(OBJECT(&s->wdt[i]), true, "pretimeout-support",
+                                 &error_abort);
         object_property_set_bool(OBJECT(&s->wdt[i]), true, "realized",
                                  &error_abort);
 
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->wdt[i]), 0,
                         FSL_IMX6UL_WDOGn_ADDR[i]);
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->wdt[i]), 0,
+                           qdev_get_gpio_in(DEVICE(&s->a7mpcore),
+                                            FSL_IMX6UL_WDOGn_IRQ[i]));
     }
 
     /*
-- 
2.20.1



Return-Path: <SRS0=EQsI=67=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26899C433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2020 16:25:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E22A120671
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2020 16:25:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JvsdHi6I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E22A120671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaM6V-0004JG-4n
	for qemu-devel@archiver.kernel.org; Sun, 17 May 2020 12:25:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53978)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1jaM2x-00067k-LU
 for qemu-devel@nongnu.org; Sun, 17 May 2020 12:21:51 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:43854)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1jaM2x-0006kz-1n
 for qemu-devel@nongnu.org; Sun, 17 May 2020 12:21:51 -0400
Received: by mail-pl1-x642.google.com with SMTP id k22so3132287pls.10
 for <qemu-devel@nongnu.org>; Sun, 17 May 2020 09:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4lD5GzG4THY7RSM3UIT5UAYwbOgIMfAJ6oMe0gsRLeI=;
 b=JvsdHi6IeAI9NlzYuVI1Vy72bfHxYauO2cQRb0jF/508NM3jvubzqHBgEpEF3BSk0y
 NuvtMcAvKIIXK0c47+W8PUND42UkLNaAvqENaGxcAblfmc2LSBJUg0ul1L3ieF2gA2IZ
 f9oUbGLLCpL8KLfJu2MbgiT0WPnypjpIW779S+Oeww2dN7d9Wt497tAnjq5EwlzWJAPX
 nyY//PHCEgEAT7r52ggtcWRrOgvdjzZj/QAuZNyw035ZZ7IlhrBaJZ5lDF5pGNAzyqa5
 APlxxhW9buiBjH742WAwDn+PQK6yVTA6Xw9Gal7hCZk20pmW9sQV+6j635hD3OtAUBan
 pI1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=4lD5GzG4THY7RSM3UIT5UAYwbOgIMfAJ6oMe0gsRLeI=;
 b=ZzxhH5QLtT30ixol9Q1ZVpWGQ3nOhhSUz9I8oHOcfha0gqrRQC3Gerb00v1yLe3lg0
 Jipcc2d2sg/2OYd6yImPM2exjwIwPhb8trS827He1dSyf+HM5uJyZHXN6UWgQFxjkX5G
 NZ4w36UlNVTJp8SnU45KB4+xjRGZ8GkbQ1nhryhnxGtFSDCljXYp05at9KNKiz/jY3zT
 Pj7x8fpKL9sqSfaNL+HtbH36LGBdiEUzBFCvuTyH12HAw7XxFcUn468E5DuBsceL67Rs
 +qTgFenyCpJMtpT3nfSmv2pX/+PW94am7bMpXfbAc7yYl0uo2RgX3WiteG1rmg7smJi7
 gWqw==
X-Gm-Message-State: AOAM530SSbLIw27TZIuctkm8f12KF3XBkrF1vCLLNFq8RYJkV6m4HUAb
 i4R7KsV7SA+NlDpXrDZ/srt0A8m5
X-Google-Smtp-Source: ABdhPJzW4kj8hTXHnMR+474zsgLOnIQSmnw2eW9VyvMxXZRqjlmgpKLm9Um9tsUNiC6OS5TLEZC0/A==
X-Received: by 2002:a17:902:262:: with SMTP id
 89mr11659730plc.251.1589732509830; 
 Sun, 17 May 2020 09:21:49 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id p5sm1515543pju.7.2020.05.17.09.21.49
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 17 May 2020 09:21:49 -0700 (PDT)
From: Guenter Roeck <linux@roeck-us.net>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 6/8] hw/arm/fsl-imx6ul: Connect watchdog interrupts
Date: Sun, 17 May 2020 09:21:33 -0700
Message-Id: <20200517162135.110364-7-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200517162135.110364-1-linux@roeck-us.net>
References: <20200517162135.110364-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=groeck7@gmail.com; helo=mail-pl1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
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
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>,
 Peter Chubb <peter.chubb@nicta.com.au>, qemu-devel@nongnu.org,
 Guenter Roeck <linux@roeck-us.net>,
 Jean-Christophe Dubois <jcd@tribudubois.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

With this commit, the watchdog on mcimx6ul-evk is fully operational,
including pretimeout support.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v3: Added Philippe's Reviewed-by: tag
v2: No change

 hw/arm/fsl-imx6ul.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/arm/fsl-imx6ul.c b/hw/arm/fsl-imx6ul.c
index 56dfd7cecc..3ecb212da6 100644
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
2.17.1



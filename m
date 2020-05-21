Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63CB6C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 19:23:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 349BB207D3
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 19:23:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lgzIKUk9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 349BB207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbqmn-0007jZ-DL
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 15:23:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38074)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jbqgE-0002Y2-Sc
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:16:34 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:33001)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jbqgD-0000Rt-U8
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:16:34 -0400
Received: by mail-wr1-x443.google.com with SMTP id l11so7810610wru.0
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 12:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=/CQUeNZzF81fMUMrjQ9fUpjLOhXLi7IijeH4uibvu5Q=;
 b=lgzIKUk9suiMCZmJ0wPZddNvVbgPVdpgeHuGqhL3KqfLR8A1dLY0+zySKARbPS4v9w
 W+LNsJ2PA5Gdua9HrA9sMaqiHL8sWRP701iJK8BKiyUGu3ZquRzAr9UIdMQrLhtCY54p
 MRN3lT//d4fx1HGaRwa161GCHv07CadzxNZ6xL1m5Q54IYmqSHDil26JDOc+8mZKR13L
 FtQSDcYd+2Um+dHtbckAPPX87R6PwuonnKxrblAcjcXCUGp9Hjy5Trwl1cxliuXsceA7
 mOTuF3mUQ6VSI9CzkDp8mvJvKxMV6NH8rPbIpCH0zlpPsZoJdATv6BcjBT53Ga6FfesR
 pYwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/CQUeNZzF81fMUMrjQ9fUpjLOhXLi7IijeH4uibvu5Q=;
 b=lkdw7PU7/sY6UThPw/emSixgTSsgiE6gHPSCpxk8oHT1YNpjAH9Tb3c8BqA6e5H94V
 GPUOUveWjMKkaZyJhniSXNXgXPPilcO3vOMyA9IsivsHn2Ozgoii5gVaOx5bk5J/OGTV
 PfJoU6IgbybtaFoILm9f7H5wj5Sh2ES1BgLQu/Zd6pxlYmE4SDpZbpW7zgA2pQPQu/6X
 CYo+UdUQ36eZEwSXnC9XUbTc+QI/qAN0Hp+rmgxIs+5S72Je2d/56vUJWVHGChaihSs8
 tKKWFT1Ict/lqbTIyk+eJBChMbrSdmOLzBpi8jnvsuQyzrK6VTARiZqspXyDRKZFxpLH
 qrBQ==
X-Gm-Message-State: AOAM5331Kcq92Pj+PPcUOzOU94SAUgOGKowCA/GJEmnxFMwLGizQgp/4
 6jChAlyJBDIHRLbfdgGFZw+exWXy7s74sw==
X-Google-Smtp-Source: ABdhPJyUIZzNj1wwpoUz3TXHfMScyd9iFdY97GjHou1QLvh3gavYI0ZqPqtIa9u7zh4/w/JBnmz13Q==
X-Received: by 2002:a05:6000:ce:: with SMTP id q14mr94570wrx.105.1590088592237; 
 Thu, 21 May 2020 12:16:32 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id z124sm7335100wmg.20.2020.05.21.12.16.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 12:16:31 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/29] hw/arm/fsl-imx6: Connect watchdog interrupts
Date: Thu, 21 May 2020 20:15:57 +0100
Message-Id: <20200521191610.10941-17-peter.maydell@linaro.org>
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

With this patch applied, the watchdog in the sabrelite emulation
is fully operational, including pretimeout support.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Message-id: 20200517162135.110364-6-linux@roeck-us.net
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/fsl-imx6.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/arm/fsl-imx6.c b/hw/arm/fsl-imx6.c
index 13f1bf23a6c..f58c85aa8ce 100644
--- a/hw/arm/fsl-imx6.c
+++ b/hw/arm/fsl-imx6.c
@@ -433,11 +433,20 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
             FSL_IMX6_WDOG1_ADDR,
             FSL_IMX6_WDOG2_ADDR,
         };
+        static const int FSL_IMX6_WDOGn_IRQ[FSL_IMX6_NUM_WDTS] = {
+            FSL_IMX6_WDOG1_IRQ,
+            FSL_IMX6_WDOG2_IRQ,
+        };
 
+        object_property_set_bool(OBJECT(&s->wdt[i]), true, "pretimeout-support",
+                                 &error_abort);
         object_property_set_bool(OBJECT(&s->wdt[i]), true, "realized",
                                  &error_abort);
 
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->wdt[i]), 0, FSL_IMX6_WDOGn_ADDR[i]);
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->wdt[i]), 0,
+                           qdev_get_gpio_in(DEVICE(&s->a9mpcore),
+                                            FSL_IMX6_WDOGn_IRQ[i]));
     }
 
     /* ROM memory */
-- 
2.20.1



Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D92AC433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 15:04:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1963020679
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 15:04:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FHv1hnt4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1963020679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgUwh-00039q-Az
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 11:04:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35748)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1jgUlP-0007V5-KA; Wed, 03 Jun 2020 10:53:07 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:41110)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1jgUlO-0000XT-OF; Wed, 03 Jun 2020 10:53:07 -0400
Received: by mail-pf1-x443.google.com with SMTP id 64so1755875pfg.8;
 Wed, 03 Jun 2020 07:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ZOFbPO8NF0Qt4pG213J4v1h/uFGzFUhLJULtgTQw8KA=;
 b=FHv1hnt4ZS4Y4rmRV1IDn8cKMySJHpNxxKmvFTfXnyjGXrgWsbvASSV+9bAgmTs0wL
 uxQXLTyDxZeZeHEv3v+bFP5SeMJCDvUYF2DxuChwqTC72oUd5fOv7dPPHyx6T6PLpwbe
 VgIb9I267EJcQF4rsqXf1o0aMEjRg0rQvfJPDDIFEl3OWRqWr3yyHsECP58J2H42hz0t
 SOzXpLH2bKdlDTWM8JkE4Yto9RM1s5BR4qHjv2jJKHXnozGqNc359Yt34IoNkmr3V3+k
 swsaI45DlaX2tvuJPTrY8fKn3giyD4elDLRoPHrmAlZgjnQVKv3YSPHAK6oV1u//m3ec
 zYZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=ZOFbPO8NF0Qt4pG213J4v1h/uFGzFUhLJULtgTQw8KA=;
 b=UMEaBknKkZsujRZWp2vyR0jWQocvV3seeBoPIfq0t+vKxPo6xWOBIwcKZ3ZMq6dA1I
 ZEo7hu2lcKjydtziMgwdRi0C+CSl6fmleN5UfeqjS9DzsGgiklUwbfhicFcGy5siV4lb
 UGa+ZS0CdqNJq19kHq1ZWUbM4R+45UzWIABZ3oTJHzmfq7YR3nBiaXZ0tBTadmL0qGJs
 SSa7w4Y/C9xrZiE/3fIcIB5ZXb1ppqMacbfTmxR1yM7l4TP4lPsC6rzklixSX/Asv606
 x99tmTzLeSoX9y4+ZRbG99CbTKW5foVcZ9cBaaSlAgeBIDO3gjfCC7UX4vMzTxIUP6CS
 gaPw==
X-Gm-Message-State: AOAM533ul15S8SYX+GUARVSQWDdj3TaAzCMZYScjiYTzrKvZqYnczo0j
 NpYO1AiWStFLvGRwM/M1gxk=
X-Google-Smtp-Source: ABdhPJwv+jGbLoBGvUGrS3dUV5BKN9DIaqcekDo5k672cRM1hMaaM3bJpo8VLBeZe2Q5/RUY8aFi5Q==
X-Received: by 2002:a17:90a:8815:: with SMTP id
 s21mr53173pjn.154.1591195985044; 
 Wed, 03 Jun 2020 07:53:05 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id m2sm2827173pjk.52.2020.06.03.07.53.04
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 03 Jun 2020 07:53:04 -0700 (PDT)
From: Guenter Roeck <linux@roeck-us.net>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 2/2] hw: arm: Set vendor property for IMX SDHCI emulations
Date: Wed,  3 Jun 2020 07:52:58 -0700
Message-Id: <20200603145258.195920-3-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200603145258.195920-1-linux@roeck-us.net>
References: <20200603145258.195920-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=groeck7@gmail.com; helo=mail-pf1-x443.google.com
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
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, qemu-devel@nongnu.org,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Guenter Roeck <linux@roeck-us.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Set vendor property to IMX to enable IMX specific functionality
in sdhci code.

Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Added missing error checks
    Added Philippe's Tested-by: tag

 hw/arm/fsl-imx25.c  | 6 ++++++
 hw/arm/fsl-imx6.c   | 6 ++++++
 hw/arm/fsl-imx6ul.c | 2 ++
 hw/arm/fsl-imx7.c   | 2 ++
 4 files changed, 16 insertions(+)

diff --git a/hw/arm/fsl-imx25.c b/hw/arm/fsl-imx25.c
index cdaa79c26b..a853ffcc00 100644
--- a/hw/arm/fsl-imx25.c
+++ b/hw/arm/fsl-imx25.c
@@ -274,6 +274,12 @@ static void fsl_imx25_realize(DeviceState *dev, Error **errp)
                                  &err);
         object_property_set_uint(OBJECT(&s->esdhc[i]), IMX25_ESDHC_CAPABILITIES,
                                  "capareg", &err);
+        object_property_set_uint(OBJECT(&s->esdhc[i]), SDHCI_VENDOR_IMX,
+                                 "vendor", &err);
+        if (err) {
+            error_propagate(errp, err);
+            return;
+        }
         object_property_set_bool(OBJECT(&s->esdhc[i]), true, "realized", &err);
         if (err) {
             error_propagate(errp, err);
diff --git a/hw/arm/fsl-imx6.c b/hw/arm/fsl-imx6.c
index f58c85aa8c..29677cfd59 100644
--- a/hw/arm/fsl-imx6.c
+++ b/hw/arm/fsl-imx6.c
@@ -350,6 +350,12 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
                                  &err);
         object_property_set_uint(OBJECT(&s->esdhc[i]), IMX6_ESDHC_CAPABILITIES,
                                  "capareg", &err);
+        object_property_set_uint(OBJECT(&s->esdhc[i]), SDHCI_VENDOR_IMX,
+                                 "vendor", &err);
+        if (err) {
+            error_propagate(errp, err);
+            return;
+        }
         object_property_set_bool(OBJECT(&s->esdhc[i]), true, "realized", &err);
         if (err) {
             error_propagate(errp, err);
diff --git a/hw/arm/fsl-imx6ul.c b/hw/arm/fsl-imx6ul.c
index 3ecb212da6..ce1462927c 100644
--- a/hw/arm/fsl-imx6ul.c
+++ b/hw/arm/fsl-imx6ul.c
@@ -505,6 +505,8 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
             FSL_IMX6UL_USDHC2_IRQ,
         };
 
+        object_property_set_uint(OBJECT(&s->usdhc[i]), SDHCI_VENDOR_IMX,
+                                        "vendor", &error_abort);
         object_property_set_bool(OBJECT(&s->usdhc[i]), true, "realized",
                                  &error_abort);
 
diff --git a/hw/arm/fsl-imx7.c b/hw/arm/fsl-imx7.c
index 89c3b64c06..dbf16b2814 100644
--- a/hw/arm/fsl-imx7.c
+++ b/hw/arm/fsl-imx7.c
@@ -416,6 +416,8 @@ static void fsl_imx7_realize(DeviceState *dev, Error **errp)
             FSL_IMX7_USDHC3_IRQ,
         };
 
+        object_property_set_uint(OBJECT(&s->usdhc[i]), SDHCI_VENDOR_IMX,
+                                 "vendor", &error_abort);
         object_property_set_bool(OBJECT(&s->usdhc[i]), true, "realized",
                                  &error_abort);
 
-- 
2.17.1



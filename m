Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED297C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 10:10:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2A9F20663
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 10:10:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IHWBa6ta"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2A9F20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jl8Y1-0002Kq-0L
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 06:10:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51098)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jl8LX-0007nh-PT
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 05:57:35 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:35067)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jl8LV-00044Y-OC
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 05:57:35 -0400
Received: by mail-wm1-x336.google.com with SMTP id q25so2423512wmj.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 02:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=PdJexom001mVS7cB10KTRHWOONdiZp92Yv5aLA2F8AU=;
 b=IHWBa6tavyQPIhy1zI3OCwILd+Uf9V9EL3QvZ7F1EcgGcR/7rOKGQKG4UhSaik92WH
 MAnPap8xpV75TssnjunDr3U66fJL+7qNIZVUZpQNPgV9YPa1LobKWTvkdShwaA5j+GHW
 liUHDJfzNcmBMZHgPYszfIkco3h2zpZNL7P8d9+qTHSQiCzmEUBkBbj+bDM7ZMZCod1M
 rds/rRRPrWL/HDC7qMVShR55zBHR72ipN7NsjgSIIKVzLUftmQp563QLK6RCXSVdakkF
 nhxQ4HDTE0/K3XGEfkkg3dEWpoGrdN/3mNYHNj9eWpKs66tC46afXPnqZ694VhCLPMf0
 mrOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=PdJexom001mVS7cB10KTRHWOONdiZp92Yv5aLA2F8AU=;
 b=Tfvo8cSMCGATw/2B2q2s1A+8Kdghx4CNWbCt6nY6Wx5k2tsTVG43n7Kvup8HPpfZQm
 No11+0atkPVdXcxdOlH9SMP3acB0JyNAhTrAjGvRFAWqHWYVhSEmZTc+AP8ZNtmXySEL
 Zdaf1ia3rc2pEOepGN03htD134ZJUlFj8lPXJ+aa31wKbD/TX33P/7LiwzbecNZ9YfSh
 EGZWvT/MrsMXDwSlr0R3arISmnl4RHjRAomCkBZ6xtvUd5V4n60qhG0Eaek+wFtD54sV
 NuQOV6eFa3XtgmjBaVeqKbhgLFA05YOq56KTz5nnXkZmCNtVx5IWJwn3LCSs3HejPTXc
 SRUg==
X-Gm-Message-State: AOAM530TjpZ+GcKyA2RthSI1OoB4+PmhkqzgaswJiQEISXkDgaRYqdJ/
 WfRBp4DfqT7Q/GWeUFScON+cqEZv5D4vHw==
X-Google-Smtp-Source: ABdhPJwXsiDt5spNmSIlDCHJgQpfvamc7HFZqr6nsWcdoVITqKphN1iGjdxxpVKhKwYNISQiR8Vtow==
X-Received: by 2002:a1c:6244:: with SMTP id w65mr2344149wmb.82.1592301452060; 
 Tue, 16 Jun 2020 02:57:32 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id z12sm31090851wrg.9.2020.06.16.02.57.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2020 02:57:31 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 23/23] hw: arm: Set vendor property for IMX SDHCI emulations
Date: Tue, 16 Jun 2020 10:57:02 +0100
Message-Id: <20200616095702.25848-24-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200616095702.25848-1-peter.maydell@linaro.org>
References: <20200616095702.25848-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

Set vendor property to IMX to enable IMX specific functionality
in sdhci code.

Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20200603145258.195920-3-linux@roeck-us.net
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/fsl-imx25.c  | 6 ++++++
 hw/arm/fsl-imx6.c   | 6 ++++++
 hw/arm/fsl-imx6ul.c | 2 ++
 hw/arm/fsl-imx7.c   | 2 ++
 4 files changed, 16 insertions(+)

diff --git a/hw/arm/fsl-imx25.c b/hw/arm/fsl-imx25.c
index cdaa79c26bd..a853ffcc006 100644
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
index f58c85aa8ce..29677cfd59d 100644
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
index 3ecb212da6f..ce1462927cd 100644
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
index 89c3b64c066..dbf16b2814a 100644
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
2.20.1



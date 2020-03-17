Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C87C10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 11:42:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C2A42051A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 11:42:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="waWSWnlb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C2A42051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEAcH-0003fo-P0
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 07:42:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43450)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jEAaV-0000N0-30
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:40:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jEAaU-00028T-4g
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:40:46 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:36849)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jEAaT-00020B-UV
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:40:46 -0400
Received: by mail-wr1-x434.google.com with SMTP id s5so25250840wrg.3
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 04:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=ABVKs1NpmHYOQoqLi66UN8zfxPP2JlZOHPOmwWjZRfw=;
 b=waWSWnlbyM99S8t4YzMXJ0QdH3oSzKY5rJWTkeTX1L6SvIQ6jfYMTb6xSuzhkAJoma
 1JN9k6N/vnyPGVxZIA38OdIHShjibNkTH0khywEtKCYkZI+8NIOf0T3Q5hMfJ8D8+5QG
 khYaTbxC23ONNLx7qfOxmp32nw/+ucBM0ov/KfkftG3vXLndC+aimt6/l8GNR7aaZGE+
 9PaYb+5PPQ9Xm0vNBRc+71Of2Jw+VfPoaytrKgYA+C/gCisRiTKR0YhzN7D4aoIGyS92
 gLTAwsex8nRuUpdzLxRWk5XzO0PYPwLmw3a0ve/kBhmX2Ux91rW79tH8sRNaME9YEqUN
 KH6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ABVKs1NpmHYOQoqLi66UN8zfxPP2JlZOHPOmwWjZRfw=;
 b=n/3vwFAPGoiIqu/mW6PFGGozayj+n4RkyLpzVoBpo2QJOfoJ+xzhXIr1agzzUb+vUw
 2nWcDzj+vLJRYbiD1I1iHJwLItHtY3k/0eKtYAWvMb4Jz33YSLaihLZE3P5lYe33ZgO2
 w52AFgJBLFFPreBgqtqutf3ZdcSiGdtaSWe+PJRzeEFO5LroDnsm+NeFmYc4+iVNuQrZ
 011qLQLU19M22b+w8M8WiVG8vZ8hKJ09+9YUw9GKD8+pGnkqCVWXBubS+akddkHXyHj4
 MjHMvHiumtziuZhKyTpAtQKH4K5DH5fUiH9+32O6L8OjuTS7VdXUm8YL6T8yH1QxxsGf
 FmUA==
X-Gm-Message-State: ANhLgQ01Yl5X9R0wFoGTXelG06fA/0S4oRlL79FXbH3/VGuUyTpeBb85
 nrpoTlu/cdONxfPIgcU+Mgh3N0AQrFABUw==
X-Google-Smtp-Source: ADFU+vsrzYgk6anChAHbStN9ZTUkH+u3eFdkcWfWJDNbHXqN8+4fSaQLyI4ssYk/OeGWYTkynBvTGg==
X-Received: by 2002:adf:a117:: with SMTP id o23mr5992040wro.219.1584445244607; 
 Tue, 17 Mar 2020 04:40:44 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id a186sm3577443wmh.33.2020.03.17.04.40.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2020 04:40:43 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/11] hw/arm/fsl-imx6ul: Fix USB interrupt numbers
Date: Tue, 17 Mar 2020 11:40:30 +0000
Message-Id: <20200317114039.26914-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200317114039.26914-1-peter.maydell@linaro.org>
References: <20200317114039.26914-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::434
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

USB1 and USB2 interrupt numbers were swapped. USB_PHY2 interrupt number
is 45. That didn't really matter up to now since the interrupts were not
used, but it needs to be fixed to be able to wire up the USB controllers.

Fixes: 31cbf933f0e ("i.MX6UL: Add i.MX6UL SOC")
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Message-id: 20200313014551.12554-3-linux@roeck-us.net
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/fsl-imx6ul.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/hw/arm/fsl-imx6ul.h b/include/hw/arm/fsl-imx6ul.h
index eda389aec7d..5a420785b95 100644
--- a/include/hw/arm/fsl-imx6ul.h
+++ b/include/hw/arm/fsl-imx6ul.h
@@ -241,10 +241,10 @@ enum FslIMX6ULIRQs {
     FSL_IMX6UL_UART7_IRQ    = 39,
     FSL_IMX6UL_UART8_IRQ    = 40,
 
-    FSL_IMX6UL_USB1_IRQ     = 42,
-    FSL_IMX6UL_USB2_IRQ     = 43,
+    FSL_IMX6UL_USB1_IRQ     = 43,
+    FSL_IMX6UL_USB2_IRQ     = 42,
     FSL_IMX6UL_USB_PHY1_IRQ = 44,
-    FSL_IMX6UL_USB_PHY2_IRQ = 44,
+    FSL_IMX6UL_USB_PHY2_IRQ = 45,
 
     FSL_IMX6UL_CAAM_JQ2_IRQ = 46,
     FSL_IMX6UL_CAAM_ERR_IRQ = 47,
-- 
2.20.1



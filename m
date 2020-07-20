Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA2BC433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 13:01:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C94DE207FC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 13:01:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pqFF4y8r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C94DE207FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxVQC-0002HH-Uf
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 09:01:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55870)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jxVLU-0002d9-IY
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 08:56:40 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:35430)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jxVLS-0007K1-No
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 08:56:40 -0400
Received: by mail-wm1-x32e.google.com with SMTP id l2so25113136wmf.0
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2020 05:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=/Qnf6IlQrDPLH/pkVSmr5xzm83LBS6FFFF/CTFBek8g=;
 b=pqFF4y8rG5Vq+nRbEG55pG7cz0N1nbAlVwto+6yIx7670BaJJctppqRFI2zZQDp+pq
 IjlvIE/cuaymq3rBYiI18EwDSoJWgnjFeQLVwaK+I1vTI8CZXNehp+ZUYd2rvC0i+xG7
 ZtCKF6sCKM5IkSHn2jVuMXR+gjjf1eKImpCdUZTlg7t2Yx4yWB0hLmRM4E2vRKdrQsrS
 WK6VOjR97xaYPxget+rlYPj/IUg+6jlwtRJ/TvnWWdTqPQIiJ5LdbXlEkJbib9AhpzQc
 Yi77g43Rc1LIW9yLN8VXpwcYO0T1CTFZSGynowk58fTkdFbeLK1tChYGnDt+E6VB5EIM
 qbKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/Qnf6IlQrDPLH/pkVSmr5xzm83LBS6FFFF/CTFBek8g=;
 b=hn65XCDmVnBKb6jXp6ZEbkFWB3/mC1/0bgSX2tvw/YsezCeG+3p1+7KpjrYPE14rl2
 uWMo2RYZzSba6Dn+/k91/M2diRPR0ZSXP2jkB7Ir2ei+JoMWpDgBFlRnRJVVETWr9G0u
 frtzHuJHcoJarfWMzOykgGIUWCvJ3ebmLvUKiMFcovaaJZffnc2c/WFlUgzmCChWHkeQ
 8je6M0DwCWPRfrsql+ysFhD0s5Fb3+9nNeTg0D1MZyPrS5pvimfWQCIGQDiemAKlvD7E
 sUNQ+wGfxkFo0Jm2KLShyhPC6cJxDhQBLoJD5qwivmTHEUeM48vH9ROafUsLTqqzDVCm
 nUJw==
X-Gm-Message-State: AOAM530mWM35euuKFuvRKUS657WbVAy+lMNLY9/F50E9L8pEK+bin33c
 bg15rge0M8oPtZEIWwOqx6SnBJFiiEhVNg==
X-Google-Smtp-Source: ABdhPJxwcLLRjT8x64EQZNWucbVPDiljf64/9AEws0McFI8cEuTeQ1XZuI4aNnz73uVWAPIgTNSIew==
X-Received: by 2002:a1c:6308:: with SMTP id x8mr22325336wmb.92.1595249797086; 
 Mon, 20 Jul 2020 05:56:37 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id p29sm34025403wmi.43.2020.07.20.05.56.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2020 05:56:36 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/12] docs/system: Briefly document gumstix boards
Date: Mon, 20 Jul 2020 13:56:20 +0100
Message-Id: <20200720125621.13460-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200720125621.13460-1-peter.maydell@linaro.org>
References: <20200720125621.13460-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add skeletal documentation of the gumstix boards
('connex' and 'verdex').

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20200713175746.5936-4-peter.maydell@linaro.org
---
 docs/system/arm/gumstix.rst | 21 +++++++++++++++++++++
 docs/system/target-arm.rst  |  1 +
 MAINTAINERS                 |  1 +
 3 files changed, 23 insertions(+)
 create mode 100644 docs/system/arm/gumstix.rst

diff --git a/docs/system/arm/gumstix.rst b/docs/system/arm/gumstix.rst
new file mode 100644
index 00000000000..cb373139dcb
--- /dev/null
+++ b/docs/system/arm/gumstix.rst
@@ -0,0 +1,21 @@
+Gumstix Connex and Verdex (``connex``, ``verdex``)
+==================================================
+
+These machines model the Gumstix Connex and Verdex boards.
+The Connex has a PXA255 CPU and the Verdex has a PXA270.
+
+Implemented devices:
+
+ * NOR flash
+ * SMC91C111 ethernet
+ * Interrupt controller
+ * DMA
+ * Timer
+ * GPIO
+ * MMC/SD card
+ * Fast infra-red communications port (FIR)
+ * LCD controller
+ * Synchronous serial ports (SPI)
+ * PCMCIA interface
+ * I2C
+ * I2S
diff --git a/docs/system/target-arm.rst b/docs/system/target-arm.rst
index 376c18f0b17..163ab915592 100644
--- a/docs/system/target-arm.rst
+++ b/docs/system/target-arm.rst
@@ -84,6 +84,7 @@ undocumented; you can get a complete list by running
    arm/aspeed
    arm/digic
    arm/musicpal
+   arm/gumstix
    arm/nseries
    arm/orangepi
    arm/palm
diff --git a/MAINTAINERS b/MAINTAINERS
index 6973b68975b..935ccb3ab31 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -652,6 +652,7 @@ R: Philippe Mathieu-Daudé <f4bug@amsat.org>
 L: qemu-arm@nongnu.org
 S: Odd Fixes
 F: hw/arm/gumstix.c
+F: docs/system/arm/gumstix.rst
 
 i.MX25 PDK
 M: Peter Maydell <peter.maydell@linaro.org>
-- 
2.20.1



Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 242C6C5B578
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 02:15:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6B82206A3
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 02:15:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dTYZuzRq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6B82206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hi8Kp-0003FF-0N
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 22:15:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55415)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hi4MF-0004EF-9J
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 18:01:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hi4MD-00007B-Ir
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 18:01:07 -0400
Received: from mail-wm1-f44.google.com ([209.85.128.44]:40145)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hi4MD-00005C-9E
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 18:01:05 -0400
Received: by mail-wm1-f44.google.com with SMTP id v19so1068524wmj.5
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 15:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=FU2Y0liu1lAY21ffJv7mbpvtLv+zwcB4gkTn/owodzc=;
 b=dTYZuzRqznkL1JWXiXhXsfzH6vrFZSAfYuUAxXz14yzh+XhdihHx+yiIemFyuvKftu
 /uXJx/Bzq2Aa1hr+hFIUDh9KNXSqu7R/0BpJrXB1uVLAR+Xmr3DO2KJ3b9GA3b/s7cjY
 kczeZT2svdsUWUs9wN8b0rmT8u5sJ5N3f0Z4zMXK37F81BT8u/wglyW/9Gjv/AUF8u08
 zhWmISA25oWJ5HLtleVC+Tlr+Eyxy7neAOgzVlSiRRemVuB14zLotZFBL075zLv3Q/hZ
 YQj6fjBu4YUiZbi5Yj7CAWb/HlPQ1Hz3TTFAt1WCzF1SVktUC7ayCcyPBtaVZzE4xj5b
 bYgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=FU2Y0liu1lAY21ffJv7mbpvtLv+zwcB4gkTn/owodzc=;
 b=DQiZhyQo5bZy5V4Tmp8jnKv1Mr8LY18BFr9tYhRVQKFIEZ8iTpHVjsmaav40XfA9ao
 L+/oLoZtg5kFKK+IXA4z2JGh46sgQZyi1qtjyuhHlJNgfYrHRRdnkrZuVvMmiruXEXf1
 JTpCk7hjA7PmlaUJyHZxRc1bGseaJaskF32x6uuXgrFPN936XnZc7oSV6dyPUWQKPCGs
 fbixyLYISpueKKLFn5abeXnerjFz6MkPkaB9EhW8e4b8i+rhwM8fY8/QkrDyoDqRiZSE
 ufAc7mHBGE70CFJZfq7Qn1lj/HKEqAROD6Q7c8fxoyeV8zTUBCmMXutGD6y6yTfC2mx5
 228w==
X-Gm-Message-State: APjAAAU8cYJd9dskPsH1P8WcKtnMAc+WZHGQ0GWv8Ff8z6yehKzGPGii
 T5ImJscxw3ocZH+5Fbi0ngksn8fwT/kAoA==
X-Google-Smtp-Source: APXvYqxqJE48jegwRpLdka4IArNOqs/boilwqQAw4ipEBofAAVhLQw5EesHmbTfm9PPKm/rVSqDkCA==
X-Received: by 2002:a1c:700b:: with SMTP id l11mr132471wmc.106.1561999189993; 
 Mon, 01 Jul 2019 09:39:49 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id o6sm26573508wra.27.2019.07.01.09.39.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 01 Jul 2019 09:39:49 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon,  1 Jul 2019 17:39:02 +0100
Message-Id: <20190701163943.22313-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190701163943.22313-1-peter.maydell@linaro.org>
References: <20190701163943.22313-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.44
Subject: [Qemu-devel] [PULL 05/46] i.mx7d: Add no-op/unimplemented PCIE PHY
 IP block
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

From: Andrey Smirnov <andrew.smirnov@gmail.com>

Add no-op/unimplemented PCIE PHY IP block. Needed by new kernels to
use PCIE.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/fsl-imx7.h | 3 +++
 hw/arm/fsl-imx7.c         | 5 +++++
 2 files changed, 8 insertions(+)

diff --git a/include/hw/arm/fsl-imx7.h b/include/hw/arm/fsl-imx7.h
index dcd73603c33..09f4f33f6e5 100644
--- a/include/hw/arm/fsl-imx7.h
+++ b/include/hw/arm/fsl-imx7.h
@@ -125,6 +125,9 @@ enum FslIMX7MemoryMap {
     FSL_IMX7_ADC2_ADDR            = 0x30620000,
     FSL_IMX7_ADCn_SIZE            = 0x1000,
 
+    FSL_IMX7_PCIE_PHY_ADDR        = 0x306D0000,
+    FSL_IMX7_PCIE_PHY_SIZE        = 0x10000,
+
     FSL_IMX7_GPC_ADDR             = 0x303A0000,
 
     FSL_IMX7_I2C1_ADDR            = 0x30A20000,
diff --git a/hw/arm/fsl-imx7.c b/hw/arm/fsl-imx7.c
index 803fe94c034..2eddf3f25c6 100644
--- a/hw/arm/fsl-imx7.c
+++ b/hw/arm/fsl-imx7.c
@@ -532,6 +532,11 @@ static void fsl_imx7_realize(DeviceState *dev, Error **errp)
      */
     create_unimplemented_device("dma-apbh", FSL_IMX7_DMA_APBH_ADDR,
                                 FSL_IMX7_DMA_APBH_SIZE);
+    /*
+     * PCIe PHY
+     */
+    create_unimplemented_device("pcie-phy", FSL_IMX7_PCIE_PHY_ADDR,
+                                FSL_IMX7_PCIE_PHY_SIZE);
 }
 
 static void fsl_imx7_class_init(ObjectClass *oc, void *data)
-- 
2.20.1



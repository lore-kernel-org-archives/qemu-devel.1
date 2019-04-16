Return-Path: <SRS0=xvb4=SS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7571C10F0E
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 01:43:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AE2C2073F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 01:43:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pHhsinVG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AE2C2073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57842 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGD8U-0000ff-PE
	for qemu-devel@archiver.kernel.org; Mon, 15 Apr 2019 21:43:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44015)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1hGD4R-0006SC-M3
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 21:39:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1hGD4Q-0007o3-Oy
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 21:39:35 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f]:38635)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <andrew.smirnov@gmail.com>)
	id 1hGD4O-0007mL-HX; Mon, 15 Apr 2019 21:39:32 -0400
Received: by mail-pl1-x62f.google.com with SMTP id f36so9478408plb.5;
	Mon, 15 Apr 2019 18:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=apAWNpdsoKze6QgfaW5xAIkNAJRGaK2WIkM9N7G5qZw=;
	b=pHhsinVGlxUPde6+a7KgisNBWZZ09bGNeGC+YxR0cW+cIVs7xj6aKMPlTWFxFmtuWo
	euItAaFr8oocO7F4b5Jej5GXdwL1+ustQiaksZiImt/Hb+spGrcBzd8cI25tEiY/Vulf
	9vFMAIS41eHb9WeZlHLNbOrUiOlmohd0ly1fASvjO+Nm8KT1tE/OTXxWE5ijuXaaM15n
	bj3VxkbwKiNDXObrTW48s2/s0pmtvr2vSCK628dsAX4afdJXWUqnERYHJ4dLQg/CiKRC
	OiraUz0sW4k5gPoW7vP6K6lvBQEji8CUzl+MdwKozIF77eKae2V3JobcRqtqYXyRABHX
	Ck1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=apAWNpdsoKze6QgfaW5xAIkNAJRGaK2WIkM9N7G5qZw=;
	b=bD0o6AGx6Wpy1PtVHsW2KPnicHOdTjAM/t8gd72T+QKMhCd2ETdhInSeYGXjo5+DwQ
	6H4DPTj2j3WX14UGCigHh+Cv4HJtRhDrkF0BVWfRvfCXO9UoVep7LbMKqy/T8Cnaf/mo
	kkYJm7wTJ13DQl6vIcu/ggrxoqsaTAIAGds7/u/S5+hYOemoJjvFQ8S6O7cgQr4vZOrq
	6L9gtjhp4EUywcC65wsgBoYqmN7VoM9qmvqXcE6wRO6Q34UBEool/xBophKNEDHxrO4P
	XR3ZmBlMBxHTt1LOmgVIvEW9TMc4H+n7aQ4hFXbNDni8n6Hu3BXlkLdvWdZyntWlmYY0
	IsMA==
X-Gm-Message-State: APjAAAVKMJpF67ou9qYendA9ly5u9iYq9giUKdKfnX+ykyWhs6gr9AcL
	9dd3ZCjpAOJa7tvNN74cdqRwGMcC
X-Google-Smtp-Source: APXvYqzaV9QHFAJXO6kpH23qZFmWuGoLzesrD0Nbjia1vI1hj2CQ5fOQXah7bp1CJLnXogXcZUPopA==
X-Received: by 2002:a17:902:2e83:: with SMTP id
	r3mr78978640plb.153.1555378771333; 
	Mon, 15 Apr 2019 18:39:31 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net.
	[24.22.235.96]) by smtp.gmail.com with ESMTPSA id
	v20sm74710362pfn.116.2019.04.15.18.39.30
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 15 Apr 2019 18:39:30 -0700 (PDT)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: qemu-arm@nongnu.org
Date: Mon, 15 Apr 2019 18:38:59 -0700
Message-Id: <20190416013902.4941-3-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190416013902.4941-1-andrew.smirnov@gmail.com>
References: <20190416013902.4941-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::62f
Subject: [Qemu-devel] [PATCH 2/5] i.mx7d: Add no-op/unimplemented PCIE PHY
 IP block
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>,
	Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
	"Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190416013859.3QvMRbWbgFhmD8Tx2ZvA7vWuaW99Lz1g8aJ3kZMaFE0@z>

Add no-op/unimplemented PCIE PHY IP block. Needed by new kernels to
use PCIE.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
---
 include/hw/arm/fsl-imx7.h | 3 +++
 hw/arm/fsl-imx7.c         | 5 +++++
 2 files changed, 8 insertions(+)

diff --git a/include/hw/arm/fsl-imx7.h b/include/hw/arm/fsl-imx7.h
index aae4f860fc..3efa697adc 100644
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
index 1abfa5910c..813fb55ca9 100644
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



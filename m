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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67EBCC10F0E
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 01:42:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 318142073F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 01:42:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B0Uvp4MH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 318142073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57836 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGD7Q-0008UR-EU
	for qemu-devel@archiver.kernel.org; Mon, 15 Apr 2019 21:42:40 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44004)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1hGD4R-0006Rx-DI
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 21:39:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1hGD4Q-0007nt-F7
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 21:39:35 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429]:41511)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <andrew.smirnov@gmail.com>)
	id 1hGD4O-0007lw-8r; Mon, 15 Apr 2019 21:39:32 -0400
Received: by mail-pf1-x429.google.com with SMTP id 188so9522595pfd.8;
	Mon, 15 Apr 2019 18:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=mAOovaqXC3eW8KbfZy9zueBheQL2BmRbn3rOTUCb8bM=;
	b=B0Uvp4MHidxmn1CzZFKEJJmu4P3IKq9j7g4bQ9NfDvTQGhTH/jPqfshiIeaeUX9Vkx
	+QsC1YuvANTEV8L68r/KYog2U++BHuwDBlNzIkB50aAsegzF5UGtYZU+Ocr8QY8EF9My
	ju7UujWCCbmteXtaLN7uNyZVSz90lkoX5gIaYm4vqhQI39W5A+MovgQQzqKZQksIKaaq
	KundtRgSryWIwDH7nz67YtbdWLiAiziW7axYA0pU4R5v4AC8Z6ZCG0Jd8Vpqs0ijsrkt
	PdhanK/zVwCEMnBdyyVDnJcvu+cL4hjaW1KqSO8gbNKKvWGosvGEn8OXi6R+34Dlj0Ra
	OjYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=mAOovaqXC3eW8KbfZy9zueBheQL2BmRbn3rOTUCb8bM=;
	b=fzypunVzdEtdm+atPWpy+Tpacz3xLntmU6zdkvq9vRrReBjc+vGIo94AJlSDH9ASlH
	uGSCk4f+z3L0SzbRlR6tFlY7mJs4inRfyVB4ZNLZjYnRpZZJeIg87dsqcUcjXk4drrj7
	72Gby5YmZzoGwhl+FYub1v9rfYK71kqO5qv9VDFMqbLWgO6DnHluZZizb/BMf2A/RqnY
	/sBbyN8rG8vHOYTzKUZZu8M8lfAhdgsH9FwxsoxAxVaefTII4X1ldEhMNYLl2IvzSUus
	qfzX/iEDiQB3NVD6cTwEEP4uF6KzDrWnJpaE7kimm5ffQlJh63v4rGbZ7miUJNMQRiwN
	9VWg==
X-Gm-Message-State: APjAAAVs6UlmGu4A7XRxbdmDSDNOxrGMe28g1ZekY/o/ao4K/dVcwBpE
	R2kgWtCxkooFph1VEnPZZ8jClw7S
X-Google-Smtp-Source: APXvYqxGQ5MeveRCKpiggKVn95hjJ5QhRSTQmnigJQZEKd7EX1rz0BxywhIlXXPWzwu4ST2vnThQKA==
X-Received: by 2002:a63:115c:: with SMTP id 28mr44654575pgr.270.1555378770144; 
	Mon, 15 Apr 2019 18:39:30 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net.
	[24.22.235.96]) by smtp.gmail.com with ESMTPSA id
	v20sm74710362pfn.116.2019.04.15.18.39.29
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 15 Apr 2019 18:39:29 -0700 (PDT)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: qemu-arm@nongnu.org
Date: Mon, 15 Apr 2019 18:38:58 -0700
Message-Id: <20190416013902.4941-2-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190416013902.4941-1-andrew.smirnov@gmail.com>
References: <20190416013902.4941-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::429
Subject: [Qemu-devel] [PATCH 1/5] i.mx7d: Add no-op/unimplemented APBH DMA
 module
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
Message-ID: <20190416013858.pmeaRm2sqLSkGqJhUGuLLTnhTZDxq67IcofvHPW_2A8@z>

Instantiate no-op APBH DMA module. Needed to boot latest Linux kernel.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
---
 include/hw/arm/fsl-imx7.h | 3 +++
 hw/arm/fsl-imx7.c         | 6 ++++++
 2 files changed, 9 insertions(+)

diff --git a/include/hw/arm/fsl-imx7.h b/include/hw/arm/fsl-imx7.h
index d848262bfd..aae4f860fc 100644
--- a/include/hw/arm/fsl-imx7.h
+++ b/include/hw/arm/fsl-imx7.h
@@ -179,6 +179,9 @@ enum FslIMX7MemoryMap {
     FSL_IMX7_PCIE_REG_SIZE        = 16 * 1024,
 
     FSL_IMX7_GPR_ADDR             = 0x30340000,
+
+    FSL_IMX7_DMA_APBH_ADDR        = 0x33000000,
+    FSL_IMX7_DMA_APBH_SIZE        = 0x2000,
 };
 
 enum FslIMX7IRQs {
diff --git a/hw/arm/fsl-imx7.c b/hw/arm/fsl-imx7.c
index 7663ad6861..1abfa5910c 100644
--- a/hw/arm/fsl-imx7.c
+++ b/hw/arm/fsl-imx7.c
@@ -526,6 +526,12 @@ static void fsl_imx7_realize(DeviceState *dev, Error **errp)
      */
     create_unimplemented_device("lcdif", FSL_IMX7_LCDIF_ADDR,
                                 FSL_IMX7_LCDIF_SIZE);
+
+    /*
+     * DMA APBH
+     */
+    create_unimplemented_device("dma-apbh", FSL_IMX7_DMA_APBH_ADDR,
+                                FSL_IMX7_DMA_APBH_SIZE);
 }
 
 static void fsl_imx7_class_init(ObjectClass *oc, void *data)
-- 
2.20.1



Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1924C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 14:21:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BBD2205CB
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 14:21:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R6hKd2cQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BBD2205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juzKd-0006Cq-Nl
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 10:21:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35028)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1juzAo-0004xD-Qa
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 10:11:14 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:36028)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1juzAn-0006cH-5W
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 10:11:14 -0400
Received: by mail-wm1-x329.google.com with SMTP id 17so13300898wmo.1
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 07:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=YOh9GxnhU6vhYDRmyns4fut70z8Xj0qJIqLDkwhxP5o=;
 b=R6hKd2cQL8ycNYwlWaFRQSRFn/2dSE5OaT+BkP/yKQ4FhmXFJl4GU8/WskNDXbIddG
 0WZCSdD1B2bAcMLC+1AcaC88957vuBT2X4QNGCjYvUu+RkqO+J7y49FsTlb9txoxKAkx
 ie5m4RcZLuK0QlTI2pqcmRGKVHt+DFUmX5t1A/JPkfWOwsEDqi4yMhszn9esMnDrLzZ1
 RpVdp6NS6m7FR4dTPBgl38NBkubNsVWnoknfVXiwf5bq05E9Y3wFfazVNDcvHsgv14y9
 KPsKWhM8uKjrS+3s5NRhtTvpB2AHIYYxZEBCnx1e2RfMAUaOBEE2Ujd3LHjlhKy5EA1z
 vA+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=YOh9GxnhU6vhYDRmyns4fut70z8Xj0qJIqLDkwhxP5o=;
 b=UnJeBbAvr58VTzNHTQBY7jjmnvJvKdD7udhyvZK8n5uuH65HtORW04miMeoL3dUe4r
 RuJFg6eg4fnwQ9RLIz2X2kpfv3/sETehdfPwgUyM5ymA8aQqnI/Q0tnkugVm8ES14h+V
 E6cTBUS7NjPPR1tPHtzXPfo+Geald/0REzubEBbtV14ZMXlfZD+erDIjHIkLuWB2U/wy
 5yqGHoG7dne12HbI97deG6FaHnCbH1ivp/qFGsQLHbQuSfu7enqvVnu2Hg2SkvB6grA9
 bPozCYip1Itrnc36R8a1/fbRT94YJpie2rFDVW722vGr5RjmVIEuutOJcDoCBwYnZGFf
 Caqg==
X-Gm-Message-State: AOAM532ugV464cJdcmlgzut653GFu9/XP7NNo/9NLvHGgeZgjKVleP5P
 /Er4snTpX5eEobKm/9x0xUkynt0k3mXsTw==
X-Google-Smtp-Source: ABdhPJy9EpTnc1uqzi5FBvg8S6xdM5ppNmYi3gV9+7pA30VOHcnMpMLCUR1KPyaHNxgfPg9pSYfbyA==
X-Received: by 2002:a1c:408b:: with SMTP id n133mr173078wma.88.1594649471473; 
 Mon, 13 Jul 2020 07:11:11 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id c136sm24031297wmd.10.2020.07.13.07.11.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2020 07:11:10 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/25] Add the ability to change the FEC PHY MDIO device number
 on i.MX6 processor
Date: Mon, 13 Jul 2020 15:10:43 +0100
Message-Id: <20200713141104.5139-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200713141104.5139-1-peter.maydell@linaro.org>
References: <20200713141104.5139-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

From: Jean-Christophe Dubois <jcd@tribudubois.net>

Signed-off-by: Jean-Christophe Dubois <jcd@tribudubois.net>
Message-id: 05a64e83eb1c0c865ac077b22c599425c024c02c.1593806826.git.jcd@tribudubois.net
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
[PMM: updated for object_property_set_uint() argument reordering]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/fsl-imx6.h | 1 +
 hw/arm/fsl-imx6.c         | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/include/hw/arm/fsl-imx6.h b/include/hw/arm/fsl-imx6.h
index 1ebd7513246..162fe99375d 100644
--- a/include/hw/arm/fsl-imx6.h
+++ b/include/hw/arm/fsl-imx6.h
@@ -73,6 +73,7 @@ typedef struct FslIMX6State {
     MemoryRegion   caam;
     MemoryRegion   ocram;
     MemoryRegion   ocram_alias;
+    uint32_t       phy_num;
 } FslIMX6State;
 
 
diff --git a/hw/arm/fsl-imx6.c b/hw/arm/fsl-imx6.c
index 0bc9f0b60d1..00dafe3f62d 100644
--- a/hw/arm/fsl-imx6.c
+++ b/hw/arm/fsl-imx6.c
@@ -377,6 +377,7 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
                                             spi_table[i].irq));
     }
 
+    object_property_set_uint(OBJECT(&s->eth), "phy-num", s->phy_num, &err);
     qdev_set_nic_properties(DEVICE(&s->eth), &nd_table[0]);
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->eth), errp)) {
         return;
@@ -449,10 +450,16 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
                                 &s->ocram_alias);
 }
 
+static Property fsl_imx6_properties[] = {
+    DEFINE_PROP_UINT32("fec-phy-num", FslIMX6State, phy_num, 0),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 static void fsl_imx6_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
+    device_class_set_props(dc, fsl_imx6_properties);
     dc->realize = fsl_imx6_realize;
     dc->desc = "i.MX6 SOC";
     /* Reason: Uses serial_hd() in the realize() function */
-- 
2.20.1



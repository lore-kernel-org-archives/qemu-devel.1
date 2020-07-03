Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20774C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 16:57:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1239208C7
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 16:57:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dOawTcEU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1239208C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrP0W-0001n2-5D
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 12:57:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49874)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrOx3-0004S6-DI
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 12:54:13 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:43466)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrOx1-0005dq-Nn
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 12:54:13 -0400
Received: by mail-wr1-x42f.google.com with SMTP id j4so30986269wrp.10
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 09:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=V7NsJejd61OpIth+3pGg1pvBG9TXuRoNl2pNDC28re4=;
 b=dOawTcEUOANfu1qkRi1pyjIWUyRD9xe1ObNVFhhbxKA/VNye68sEpIm0WhMLGcMsq/
 xKCP2Z+HgJA4E18ejo6avqO2MedLGxzpgTuaxSP6hxkaDJbeB4tXbEcJZb6ufiWtbzqo
 7JJnlrdoaPLX7pfNrQQFqoQRHx2XAZgVkNUY83lVfNo3xhYf//2aQRYqdK4WFGZrWPj7
 2SCnGfqDCXVX13FpF0QvHwfJEhoWlgK8uXk7XTat0WaPrfPoQ+QMYgd5UzSFat6Az9lN
 AwvcaW/GlONsR5tBU/1Hddy3SUUvHd662YJWP3zpiq31DZC5G2c9LRKb5mJD4W9edI3T
 gDEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=V7NsJejd61OpIth+3pGg1pvBG9TXuRoNl2pNDC28re4=;
 b=APPrQA+bwfOOOCyYldOIaMRwe5kq0A000BlCdpRuIjCJ0R4LaIVl31r72vyfsFYzsh
 a8d2/VmICcTOaglhwC3B/bCVHa5DR19ooeSnFuWz5WlE0iMOLbGsMcJprQ6kSmyn/069
 pqV9nORQ/HokRvGRhpWaE6J1zTN8ZQeQXtY/YVhJR+FTVZEEtQUQeelBMph2yc0XNI0L
 Gzhx9PJzVtCXNY71Hl7s9QruJ1WsYfUDbCtxCSAl5COq7Dka4dVXa+ZwKDxeEa0I3TTD
 nWu00AEY1b9nPSeL+jk5UOSQQr0b196Z6/lOyJPHJSVaQJDX31DZ+69KkFLG/5321iJb
 Ew0g==
X-Gm-Message-State: AOAM5301zgdO+MnAWceavt6cSevPxIwO7UdggbQ+9z/lQ9H89Kf+VyJV
 rv4Nlfra1gjl7YhYzFjGBJQtWqJgfeRzGg==
X-Google-Smtp-Source: ABdhPJyVcUoDyECklhCvHVvkq5FBfv2kbLP5yXdMmtKj4GMoh+vBqDhMZZSwLZhG+Gjtdyk90QY/Tw==
X-Received: by 2002:a5d:68cc:: with SMTP id p12mr37212242wrw.111.1593795249550; 
 Fri, 03 Jul 2020 09:54:09 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id j15sm5574224wrx.69.2020.07.03.09.54.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2020 09:54:08 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/34] Add the ability to select a different PHY for each
 i.MX6UL FEC interface
Date: Fri,  3 Jul 2020 17:53:33 +0100
Message-Id: <20200703165405.17672-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200703165405.17672-1-peter.maydell@linaro.org>
References: <20200703165405.17672-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
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

From: Jean-Christophe Dubois <jcd@tribudubois.net>

Add properties to the i.MX6UL processor to be able to select a
particular PHY on the MDIO bus for each FEC device.

Signed-off-by: Jean-Christophe Dubois <jcd@tribudubois.net>
Message-id: ea1d604198b6b73ea6521676e45bacfc597aba53.1593296112.git.jcd@tribudubois.net
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/fsl-imx6ul.h |  2 ++
 hw/arm/fsl-imx6ul.c         | 10 ++++++++++
 2 files changed, 12 insertions(+)

diff --git a/include/hw/arm/fsl-imx6ul.h b/include/hw/arm/fsl-imx6ul.h
index 37c89cc5f92..fcbaf3dc861 100644
--- a/include/hw/arm/fsl-imx6ul.h
+++ b/include/hw/arm/fsl-imx6ul.h
@@ -87,6 +87,8 @@ typedef struct FslIMX6ULState {
     MemoryRegion       caam;
     MemoryRegion       ocram;
     MemoryRegion       ocram_alias;
+
+    uint32_t           phy_num[FSL_IMX6UL_NUM_ETHS];
 } FslIMX6ULState;
 
 enum FslIMX6ULMemoryMap {
diff --git a/hw/arm/fsl-imx6ul.c b/hw/arm/fsl-imx6ul.c
index 6446034711e..51b2f256ec8 100644
--- a/hw/arm/fsl-imx6ul.c
+++ b/hw/arm/fsl-imx6ul.c
@@ -427,6 +427,9 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
             FSL_IMX6UL_ENET2_TIMER_IRQ,
         };
 
+        object_property_set_uint(OBJECT(&s->eth[i]),
+                                 s->phy_num[i],
+                                 "phy-num", &error_abort);
         object_property_set_uint(OBJECT(&s->eth[i]),
                                  FSL_IMX6UL_ETH_NUM_TX_RINGS,
                                  "tx-ring-num", &error_abort);
@@ -607,10 +610,17 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
                                 FSL_IMX6UL_OCRAM_ALIAS_ADDR, &s->ocram_alias);
 }
 
+static Property fsl_imx6ul_properties[] = {
+    DEFINE_PROP_UINT32("fec1-phy-num", FslIMX6ULState, phy_num[0], 0),
+    DEFINE_PROP_UINT32("fec2-phy-num", FslIMX6ULState, phy_num[1], 1),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 static void fsl_imx6ul_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
+    device_class_set_props(dc, fsl_imx6ul_properties);
     dc->realize = fsl_imx6ul_realize;
     dc->desc = "i.MX6UL SOC";
     /* Reason: Uses serial_hds and nd_table in realize() directly */
-- 
2.20.1



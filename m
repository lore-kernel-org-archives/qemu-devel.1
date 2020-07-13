Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A13FC433E3
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 14:15:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4756A2072D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 14:15:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PShCYGXD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4756A2072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juzF2-0004fP-Dt
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 10:15:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35046)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1juzAp-0004zW-VD
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 10:11:16 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:36158)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1juzAo-0006cR-3B
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 10:11:15 -0400
Received: by mail-wr1-x435.google.com with SMTP id k6so16723469wrn.3
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 07:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=RzzTi1vl63SYp8xuPkUqRyWvZtfbVvsWqfUHoMVTTxM=;
 b=PShCYGXDP+htZ1DaXV95r2hSl8PsUl9Z3XZME/N/Y00WZ4ILzXmhM4/dpJG+fg5bwq
 vsdUC/By+75Fw7EXeFcxdskK0Yi7WLabsl3eLbiYIILvSHxz4an2lx+r0+Cuj3M004Z0
 pl+WK3MprVTsXGcVkAIzVAKJAmRG9v6Q1bS/5pScxLgaZXTJ+QFBFZR1b06lp/dZQoNp
 RjhXr74ydXTrK/4/PccmUy8YqoEPHuP3SVUrnJ9q5nn6zIbaKuZVQhf/wzjw01+XGyuO
 XgAYuXrV4KQUaMaw4Ksz9eYvmQAT3wDfPQCRhp89OajdfGKLUtdU3g433lNoGQ8mofgv
 cGmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=RzzTi1vl63SYp8xuPkUqRyWvZtfbVvsWqfUHoMVTTxM=;
 b=CbuykkwBjmlkP9SysU7kwT0+vIQnJ7QdQQEoqURZaFlhZTJIZe3hx+skhWc7+llcUc
 RCQXKjx6Q4RE3ED9hsQv7qlar2n2hK+Rx5omWdPm77dXZNw7yX1uqJyeVGwbEVIsB1cz
 7XAX8pe9UPMHRUB5p6wFEy069cpY/pTzyHgXbN31tmjJwgcCriZJ+VKI1GwF27XeuQFj
 evsNjcz29gnVzMQ/DiCvtnD3RqH3vWYjo3WISF/LTGSADMEorkE54/OTMTKldSmHZyRa
 GhnXhe4cjxIsZMJLlAWbLvwPcB3Q+mSA/4Q0AU9gosYWlLdh6SVHddmEGqnBYjhMcXFc
 ICpw==
X-Gm-Message-State: AOAM5306gGtn8PdCFQAqrYXycXluiRdcLc5qNnbGmetfCCTHCDLeZtVq
 Slp7aUUnxh/6M/P+lv4JUjN/scHjXwJ40g==
X-Google-Smtp-Source: ABdhPJyVKqcciNLpmU4wurTYDhEhbn18yXpSxJfZyhVpAXYI4IFgTfTPGz0+qmhlvDrjRQ4wObuG8A==
X-Received: by 2002:adf:82e1:: with SMTP id 88mr58318650wrc.376.1594649472502; 
 Mon, 13 Jul 2020 07:11:12 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id c136sm24031297wmd.10.2020.07.13.07.11.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2020 07:11:11 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/25] Add the ability to change the FEC PHY MDIO devices
 numbers on i.MX7 processor
Date: Mon, 13 Jul 2020 15:10:44 +0100
Message-Id: <20200713141104.5139-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200713141104.5139-1-peter.maydell@linaro.org>
References: <20200713141104.5139-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
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
Message-id: c850187322be9930e47c8b234c385a7d0da245cb.1593806826.git.jcd@tribudubois.net
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
[PMM: updated for object_property_set_uint() argument reordering]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/fsl-imx7.h | 1 +
 hw/arm/fsl-imx7.c         | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/include/hw/arm/fsl-imx7.h b/include/hw/arm/fsl-imx7.h
index da977f9ffb4..ad889237077 100644
--- a/include/hw/arm/fsl-imx7.h
+++ b/include/hw/arm/fsl-imx7.h
@@ -81,6 +81,7 @@ typedef struct FslIMX7State {
     IMX7GPRState       gpr;
     ChipideaState      usb[FSL_IMX7_NUM_USBS];
     DesignwarePCIEHost pcie;
+    uint32_t           phy_num[FSL_IMX7_NUM_ETHS];
 } FslIMX7State;
 
 enum FslIMX7MemoryMap {
diff --git a/hw/arm/fsl-imx7.c b/hw/arm/fsl-imx7.c
index fad637d3288..2ff2cab9246 100644
--- a/hw/arm/fsl-imx7.c
+++ b/hw/arm/fsl-imx7.c
@@ -363,6 +363,8 @@ static void fsl_imx7_realize(DeviceState *dev, Error **errp)
             FSL_IMX7_ENET2_ADDR,
         };
 
+        object_property_set_uint(OBJECT(&s->eth[i]), "phy-num",
+                                 s->phy_num[i], &error_abort);
         object_property_set_uint(OBJECT(&s->eth[i]), "tx-ring-num",
                                  FSL_IMX7_ETH_NUM_TX_RINGS, &error_abort);
         qdev_set_nic_properties(DEVICE(&s->eth[i]), &nd_table[i]);
@@ -550,10 +552,17 @@ static void fsl_imx7_realize(DeviceState *dev, Error **errp)
                                 FSL_IMX7_PCIE_PHY_SIZE);
 }
 
+static Property fsl_imx7_properties[] = {
+    DEFINE_PROP_UINT32("fec1-phy-num", FslIMX7State, phy_num[0], 0),
+    DEFINE_PROP_UINT32("fec2-phy-num", FslIMX7State, phy_num[1], 1),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 static void fsl_imx7_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
+    device_class_set_props(dc, fsl_imx7_properties);
     dc->realize = fsl_imx7_realize;
 
     /* Reason: Uses serial_hds and nd_table in realize() directly */
-- 
2.20.1



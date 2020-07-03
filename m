Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47D1EC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 16:55:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1773F208C7
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 16:55:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tW4eUXgl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1773F208C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrOy4-0006H8-B3
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 12:55:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49880)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrOx3-0004Sk-Qj
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 12:54:13 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:35270)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrOx2-0005e2-B1
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 12:54:13 -0400
Received: by mail-wm1-x344.google.com with SMTP id l2so33240435wmf.0
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 09:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=tVDQEPi+TS63vgwsfA18+eSs84y3JoHZ/7TtH2x5MrM=;
 b=tW4eUXglfEFCNyUou4Nboc2Ti5A+uELaeV5qx/R8yn2comBfaofNIibICAJmvhhmyo
 jnRDm2kUJFICcSwUCwklaF5zev2+MuCYPQYnaQlnDWXcTv2ciNpnvw1edki0nr/WdDp1
 BQl/WVlIaVqW8rcyKZ9fz96yFior8RVPsq39fTOcwCBiPPjEzU0qosrLTCPykOzkkA2e
 iZqp3COzIxnMYBAvEpbwvWoi3x3BjoPJBilSQrlmqXzkbv9ZvvErHVXwl+GcbSpg/1Go
 Y8ahuOFy0UVU9VwVEaNt7GFHi/7YyvO3IoxFOl97ULWqz7gRSNqEZxuyGIgFIh7HYE/j
 w6Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tVDQEPi+TS63vgwsfA18+eSs84y3JoHZ/7TtH2x5MrM=;
 b=qNx6XMN9YrsbEpTOFRsffXIwf3kLU9AzIhZFUMr+Mdj7hkP69F2wFTaWoy250Ss7XN
 fhn2n534b3Nw6uVaTVP6QrtgQhIbE0wumMNFg7ZP95lV35K8UtRtyiD7fz6Z2HJciNmx
 rzr1yHLFAZ3C2yegfJCftRBIhHzoN5Q7CMFCE2aEsU4RyaQJeZlcJ8gEteAOa9BcWPrL
 9Zy9/E3IWzawTUbC5HtuoXFkcRmp9JhZpZbMgAQIafEps5YV0rPOZP0PARB5oApD3m/3
 6eB6o0JENMFrruemypEsw3W/dUde3i8VlPeGa1Qh9sddr9zZmknPPLt+ZlVJUmNXHpei
 RwCw==
X-Gm-Message-State: AOAM533kHsrN+9uLQhyQtZ1hhYdovSh7ddsKif63Cwadxl/DlDrcNF0D
 sXM4TK/wgDir29B8le/s3FVIM67ng3L/yA==
X-Google-Smtp-Source: ABdhPJzlaf+vW8q699l/uzSc6nDUqFuTQ7jNUnkmhc2Sncaoi4kb5DLp/HAsGWd85Kr+QRcR+hM4HQ==
X-Received: by 2002:a1c:3dc3:: with SMTP id k186mr39359357wma.66.1593795250638; 
 Fri, 03 Jul 2020 09:54:10 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id j15sm5574224wrx.69.2020.07.03.09.54.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2020 09:54:09 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/34] Select MDIO device 2 and 1 as PHY devices for i.MX6UL
 EVK board.
Date: Fri,  3 Jul 2020 17:53:34 +0100
Message-Id: <20200703165405.17672-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200703165405.17672-1-peter.maydell@linaro.org>
References: <20200703165405.17672-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x344.google.com
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

The i.MX6UL EVK 14x14 board uses:
- PHY 2 for FEC 1
- PHY 1 for FEC 2

Signed-off-by: Jean-Christophe Dubois <jcd@tribudubois.net>
Message-id: fb41992126c091a71d76ab3d1898959091f60583.1593296112.git.jcd@tribudubois.net
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/mcimx6ul-evk.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/arm/mcimx6ul-evk.c b/hw/arm/mcimx6ul-evk.c
index 2f845cedfce..9033d3f8f38 100644
--- a/hw/arm/mcimx6ul-evk.c
+++ b/hw/arm/mcimx6ul-evk.c
@@ -40,6 +40,8 @@ static void mcimx6ul_evk_init(MachineState *machine)
 
     s = FSL_IMX6UL(object_new(TYPE_FSL_IMX6UL));
     object_property_add_child(OBJECT(machine), "soc", OBJECT(s));
+    object_property_set_uint(OBJECT(s), 2, "fec1-phy-num", &error_fatal);
+    object_property_set_uint(OBJECT(s), 1, "fec2-phy-num", &error_fatal);
     qdev_realize(DEVICE(s), NULL, &error_fatal);
 
     memory_region_add_subregion(get_system_memory(), FSL_IMX6UL_MMDC_ADDR,
-- 
2.20.1



Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04A81C4363C
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 14:27:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B6C620739
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 14:27:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YDQ3vaem"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B6C620739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQWtG-0005lY-63
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 10:27:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38144)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kQWrw-0004BJ-SB
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 10:26:08 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:34314)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kQWrt-0005yA-Gu
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 10:26:08 -0400
Received: by mail-wr1-x444.google.com with SMTP id i1so721129wro.1
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2020 07:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=TbWCRJ0BVkq6j07LdMSc/WFxA1HsyjcaL+7Jf66AQ7w=;
 b=YDQ3vaem4ICMjOVnbiqey4nL89QKVk13emEsRvcQQm/ut4obgmVAuMCOjHwq1NI3e+
 SmCjxybbevPAq2Z6+xNMXeeAt4xoAjb9Z4yfHnyrpu0KUdI1vpNKG/dE+H8sChe6wijY
 gqzP4idO++OcAa9++aEvDKOzywADrwIqWW7sX4nGfVPcu7uff7GkcL7L4TmOtsaBVNzB
 4F94I7G2UWmqJFDCI8AjzJYi9L9yZyGL1hPOgjAZ2WYoI7I8l7yTs/9O+zc+ZQMdTnFV
 9ftkFj2pG/6tYCZga5VRufxr+pnpayVEBpzB68wOfCM6t0cyBkGFpvITm4UNGamveilr
 CN2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=TbWCRJ0BVkq6j07LdMSc/WFxA1HsyjcaL+7Jf66AQ7w=;
 b=Ypiq6poSzQ/ikdJortlPanPjBwJrot5/iLiP4SWio4Whw1Aw+2l4qLNlYxagebkFfi
 5Cd9ZT3WhVuv1HlmsRRQMORdIAvVjyTpvbuEgNW2XLn4qRHy1FRy9BvFyiVcZNkuCjbL
 AxteSCRrUHXPniIdD5FS7htQkSjgTBCqaULRIpCP3ztswU/fkC0RANnK3x6k8rHQcSk6
 h9cJ1WcPC++tYGBCIVxW0xhHuoPAPezHj2niX2RbO7JwI96k5DnCDlf2kkO0EixeKVnU
 WyrbSeo7380HhlcJKV0nQD+uj0uKECzKSGmdNzf8UyLuPdqKnUD2Qy045rETmBooemlJ
 W+WA==
X-Gm-Message-State: AOAM532lHA205mHv7qXvfUzR3AfgRa8YPZ4GKmjxrAC4my8TXn1lzR2p
 mHfx7UqGjYRBjVW1L+G2yWSPQxnckBFUFxcS
X-Google-Smtp-Source: ABdhPJzLE6wM4Bw79RbfLk7iclCb7xJ+uXH8Y0xvdosuzPhItjg0aaAJhBhNaYkRzOihfCpYBWEUnQ==
X-Received: by 2002:a5d:4c52:: with SMTP id n18mr9396386wrt.267.1602167163710; 
 Thu, 08 Oct 2020 07:26:03 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id j1sm7905104wrc.28.2020.10.08.07.26.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2020 07:26:03 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/12] hw/arm/sbsa-ref : Fix SMMUv3 Initialisation
Date: Thu,  8 Oct 2020 15:25:48 +0100
Message-Id: <20201008142557.9845-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201008142557.9845-1-peter.maydell@linaro.org>
References: <20201008142557.9845-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x444.google.com
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

From: Graeme Gregory <graeme@nuviainc.com>

SMMUv3 has an error in a previous patch where an i was transposed to a 1
meaning interrupts would not have been correctly assigned to the SMMUv3
instance.

Fixes: 48ba18e6d3f3 ("hw/arm/sbsa-ref: Simplify by moving the gic in the machine state")
Signed-off-by: Graeme Gregory <graeme@nuviainc.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Message-id: 20201007100732.4103790-2-graeme@nuviainc.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/sbsa-ref.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index 9c3a893bedf..65e64883b51 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -525,7 +525,7 @@ static void create_smmu(const SBSAMachineState *sms, PCIBus *bus)
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
     for (i = 0; i < NUM_SMMU_IRQS; i++) {
         sysbus_connect_irq(SYS_BUS_DEVICE(dev), i,
-                           qdev_get_gpio_in(sms->gic, irq + 1));
+                           qdev_get_gpio_in(sms->gic, irq + i));
     }
 }
 
-- 
2.20.1



Return-Path: <SRS0=TdIk=BN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 672A9C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 19:43:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF8DD22C9F
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 19:43:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sYIT0E1+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF8DD22C9F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2gMY-00035T-0T
	for qemu-devel@archiver.kernel.org; Mon, 03 Aug 2020 15:43:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39624)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k2gDz-0001cY-H4
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 15:34:19 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:37276)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k2gDx-0003ah-Pp
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 15:34:19 -0400
Received: by mail-wr1-x443.google.com with SMTP id y3so35261622wrl.4
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2020 12:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=gk3VwwKe4KQ5WfGGFSh7CZcjxUAI5pDxJotIx+KqNXY=;
 b=sYIT0E1+lBCt9kzzyCy2Grgbf+N0dU3+CeFOPnFlYbOG27PzQpKqQJrI9rwTCZwAPC
 ZcpvXb8eS1cfpUQubearTPCrUkvxA6HwITFzbdm/GY2U+Fx/GyJYfectWGR3WtdE1Ka9
 Z2gY7+bAwm5wc//rPrehI5r06V/t+byDcubzIZyI7SYfiWWyKA93swmEfmabOL6d58iI
 ZqGQpTEox9BXS0u8uWS16jlpJeqGVGO9LoEeVeOt6VnTvM0II2TRv/cWn299ferNAJLo
 dZD4dSXuSrqnaodxJsDgaLj5wudeaEyWs6AMfsDDrkFJwdzWWdkCBzuXlk1NvtBQB7F9
 2WXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=gk3VwwKe4KQ5WfGGFSh7CZcjxUAI5pDxJotIx+KqNXY=;
 b=kfGFCuh7h1+Y5AqFUF6SRR00w3h4NM0qYjDvfAQVGJ0Ayva1hszgbAZ25mdrtx1PRj
 K6ptHYWD4zyh16quwFZiE0fdMxg8Hph3zYAxWPnX9k4FQ33ryqrpQ/eJKqS4Yps3cf9x
 ULG0tZZd1d90to5Ue34BGlwJcmaG+iFMq2danwQ3F40zi+V8ixjHXjBfVpBMQoPM/Qmc
 Plgerm0/Dr3f6IGu2qpNz5CyvxxCoVAJquf3tv9mX6+L+XwG5qkgPexHi5BE1sz9Zep1
 Vk6NWmZ9BtwA20kKSuSWsSR39Zk2qvqoS57BJgtu3o09H3ycWSljfgk3U0amGeGZo1/6
 Kcog==
X-Gm-Message-State: AOAM5304TAxEtq8o7zEYKn+8GbnXJ2fAqa/EBcgtw7hJnOMsKblI3x31
 r75pmMn6kVwGg/qWcAnn2mhwcjkAQq5DCg==
X-Google-Smtp-Source: ABdhPJzQmSwTkc/fDz9YzqQiJMOocg+14DVWn/ioBXehRVVe7rgkcnmBTpj0Vshy7uIQNh15QsQkrQ==
X-Received: by 2002:adf:83c5:: with SMTP id 63mr16001028wre.321.1596483255542; 
 Mon, 03 Aug 2020 12:34:15 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id r206sm985565wma.6.2020.08.03.12.34.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2020 12:34:14 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 7/8] hw/arm/nrf51_soc: Set system_clock_scale
Date: Mon,  3 Aug 2020 20:33:58 +0100
Message-Id: <20200803193359.12936-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200803193359.12936-1-peter.maydell@linaro.org>
References: <20200803193359.12936-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x443.google.com
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

The nrf51 SoC model wasn't setting the system_clock_scale
global.which meant that if guest code used the systick timer in "use
the processor clock" mode it would hang because time never advances.

Set the global to match the documented CPU clock speed for this SoC.

This SoC in fact doesn't have a SysTick timer (which is the only thing
currently that cares about the system_clock_scale), because it's
a configurable option in the Cortex-M0. However our Cortex-M0 and
thus our nrf51 and our micro:bit board do provide a SysTick, so
we ought to provide a functional one rather than a broken one.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20200727193458.31250-1-peter.maydell@linaro.org
---
 hw/arm/nrf51_soc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/arm/nrf51_soc.c b/hw/arm/nrf51_soc.c
index 45e6cc97d70..e15981e019f 100644
--- a/hw/arm/nrf51_soc.c
+++ b/hw/arm/nrf51_soc.c
@@ -32,6 +32,9 @@
 
 #define BASE_TO_IRQ(base) ((base >> 12) & 0x1F)
 
+/* HCLK (the main CPU clock) on this SoC is always 16MHz */
+#define HCLK_FRQ 16000000
+
 static uint64_t clock_read(void *opaque, hwaddr addr, unsigned int size)
 {
     qemu_log_mask(LOG_UNIMP, "%s: 0x%" HWADDR_PRIx " [%u]\n",
@@ -65,6 +68,8 @@ static void nrf51_soc_realize(DeviceState *dev_soc, Error **errp)
         return;
     }
 
+    system_clock_scale = NANOSECONDS_PER_SECOND / HCLK_FRQ;
+
     object_property_set_link(OBJECT(&s->cpu), "memory", OBJECT(&s->container),
                              &error_abort);
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->cpu), errp)) {
-- 
2.20.1



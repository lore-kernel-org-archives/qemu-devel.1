Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7CB3C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 15:49:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CD742076E
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 15:49:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F0P5DqSR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CD742076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kS050-0001py-It
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 11:49:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56734)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kRzqG-0006qa-OC
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 11:34:28 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:46363)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kRzqE-0007IN-R7
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 11:34:28 -0400
Received: by mail-wr1-x441.google.com with SMTP id n6so19391282wrm.13
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 08:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NE3BHoZcVo5rUaArzOLXnKqyeyPe9cLG2NZvnHPubpg=;
 b=F0P5DqSRbWzz8LAZgY3uK7HBoazadBF6IlWYEaqn1g0simBrisdG45SWpVgDBnrJYD
 W6rwu6CQCGPbENBwQu9NGBUnFrtValWsVAss410TC9hJrS+1y6bMG1VaYrY7co18lvy7
 jXjy/wZnKlg0J5MaAg/MvYhuQ3eOjxSSYKD7a6+a6U2EjYufIpGZ7CeIDa4RbyScd1ry
 wFF3v5mMRGow0DdJVctXs087rluuEwFeJiMqMrbvJLqKjStuhc4CuWGwseRWwk+lmz7H
 yC7n8wkKaJiyJ2PMpcOM61FPUkdM2FXadGDQe1yZfoVA9+QNoRGX8iOj+nQFVvp6iCPl
 Z9ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NE3BHoZcVo5rUaArzOLXnKqyeyPe9cLG2NZvnHPubpg=;
 b=gNzpN/75b5cD8lxdIYw28TQZgtTOOHF/dEBQjlKxjFLLvJe8P2DFXynt0VsiBj7szO
 Ae9MQEWeShqJKrBiQRL2BiI865vA1guTpUKHRxJzmSgE2bb+JLhAu4F38/j6J2fAbNsy
 K83IvDJcoYw0/krf+7kHA73yuTYabIVcuJFmsHzNux3IXLrZnZiRHoE/0IQcb2rR0OXK
 KTjZ6UWAhfy7BuLitIilfBXOcOZEqHrUDfNjlsx8HE2iAZkHdj7KwLWWOceTb+hfHJaY
 FY81impLaTKnd1N5X1x+i7xmuJ/elOiscO3ID+tLenBn2g6lHqJnAw+qa9SJcijiHHCf
 AcHA==
X-Gm-Message-State: AOAM531OOeSb51y6RAAGnS3HjzY9tvxefVmqERXJBLjWzWPUFpFsD7+n
 XOPN0hSGQPyuWDzZwONDF0yUfAPcm+3KetF2
X-Google-Smtp-Source: ABdhPJygOpxOuyh0+ui0t3KAejL6l1An+uv8bVDY8/G5lKdL68i7ANWu5zyWx6XZvLVpJ4QCS5MXtw==
X-Received: by 2002:adf:e38f:: with SMTP id e15mr30571623wrm.294.1602516865536; 
 Mon, 12 Oct 2020 08:34:25 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y10sm19675284wrq.73.2020.10.12.08.34.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2020 08:34:24 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH for-5.1] hw/arm/nrf51_soc: Set system_clock_scale
Date: Mon, 12 Oct 2020 16:33:36 +0100
Message-Id: <20201012153408.9747-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201012153408.9747-1-peter.maydell@linaro.org>
References: <20201012153408.9747-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x441.google.com
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
Cc: Richard Henderson <richard.henderson@linaro.org>
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
---
Tested with 'make check'/'make check-acceptance' only.

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



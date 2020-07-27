Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8230C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 19:35:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 818A62074F
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 19:35:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zAlJbFq1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 818A62074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k08ub-00087f-Pn
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 15:35:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45978)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k08tt-0007Hf-5C
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 15:35:05 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:55831)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k08tr-0002fv-9f
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 15:35:04 -0400
Received: by mail-wm1-x341.google.com with SMTP id 9so15154670wmj.5
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2020 12:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=NE3BHoZcVo5rUaArzOLXnKqyeyPe9cLG2NZvnHPubpg=;
 b=zAlJbFq1ISIbewRaV9wsUZv89IstyJ0SLvWEn3/zVTko8JK3eoRdv2sl5JwXPNqfUP
 KH7Qqjfsn0eIgvPz7bSWZI5ab+xpXqqIRAHTAyIu7x+Kg6+lOf/uSOa24jF766/zxxHq
 OrMsBETtG/sEYT+ykW2jfShJ6PQHlghcb+NAQEcNjf7d4C+ySyp0jq5mRWqQV02wapBQ
 Yxq94HBkvoTdQuvJZA/CGhO8+PxrhT19kiky6z3jNQ1uR2Y/IjU6P0bBqjG8aimcOkcD
 CcCgjp6NAhgkyqKHVXC40LcxMEPfp95y1Xk1MhbI8tf8Xn6pDqOwGtpG/7yHugi5+2VI
 inbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=NE3BHoZcVo5rUaArzOLXnKqyeyPe9cLG2NZvnHPubpg=;
 b=QxQ7Kbjng1PXsiH+mAjgtSJLEl9Uo1IGZO5JS4yGyNyRlppOMw7Q0mAYUvKcy0aoR6
 VHKkAJKBqedqu1lEtFgqM2AnXce/3dBmSUmUake7NkOn3JQF1+gmGgG2ZROlr+C5myO6
 OGxNV9zW3XIbL7MIKvJiBTS/DbGBgdIb5qOVYKgYgMZ1+99Q6RNAYYWHVpz1VBMyEiNh
 RHy7PDrOipdzVnHvE1GJkcW0XrDa/lNuCFQjVrdBVkL7hlAtlUgzLyHqsMOGeUk6N3xF
 /ZQf4CCOOgWD7tNdsL0bMzPx/og6DOF1IKpKSWFdnVanNWbBQvA3b1Z3scLl/31k3utT
 fuqA==
X-Gm-Message-State: AOAM532Ja/cCuSq32YQzX/4VTiuCn/LR1/hw7i0JnXIHcvErk1+8FjwN
 dcbgL0bjZk9ubvUiM/CfVpEa5g==
X-Google-Smtp-Source: ABdhPJztLGsOUEIt08sjyX/zLBm6VdNly9fPWFNFHsVZoS1e16pCRXH6U7Uh2jDMHiXc3R0TH8ni/g==
X-Received: by 2002:a1c:de85:: with SMTP id v127mr739995wmg.156.1595878501555; 
 Mon, 27 Jul 2020 12:35:01 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id g7sm13860319wrv.82.2020.07.27.12.34.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2020 12:34:59 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH for-5.1] hw/arm/nrf51_soc: Set system_clock_scale
Date: Mon, 27 Jul 2020 20:34:58 +0100
Message-Id: <20200727193458.31250-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x341.google.com
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
Cc: Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
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



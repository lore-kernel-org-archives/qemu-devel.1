Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BA8DC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 12:04:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34F1C20771
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 12:04:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S7cgaYV7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34F1C20771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnhfO-0003fM-Ag
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 08:04:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44394)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jnhHH-0003Xs-V5
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 07:39:47 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:43800)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jnhHG-0003P8-AQ
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 07:39:47 -0400
Received: by mail-wr1-x434.google.com with SMTP id l10so20171743wrr.10
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 04:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=/vPwTiNjsUuSz4xxL6SaRORcPSapebKMLMVKI6DJOgo=;
 b=S7cgaYV7JfVKEMdrUCz9dL8U//ENhEze6PdXWT7DuyWTKe7KXHWeNNPoM4kmqKLqD9
 NvCO7IgotPlxkwFUvRUl2nJ9BS7veAtmWqA1b/a939kLfxrsT7LADc3zYO7BUkPfEMUv
 dH73fwqjuq346OjCn9HwFktYxVAW0bELWt/L7csMTi244AFOTSdfFY6mEJ1qc77IkjEq
 Kotob/neEfEZNCVRERnin8mI1LJjzCRs6VRyyd9rB+viLCxPceet/Pf/PQqKW7/C6bSP
 bCekpLs6oA+NAgnmiLv46VrKtrcHGIPlhdyONdmm/HmRZcdj9nbxlnydmEFYtLP0cQ2a
 qjnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/vPwTiNjsUuSz4xxL6SaRORcPSapebKMLMVKI6DJOgo=;
 b=HI0VnwUqwkBU9iK/MA9xwJBbZAvsuGQg2xTMfQ6KYspmM60B8zEMqARibwg3VytBcc
 SDke8Xs51Hs5Pc9pMcqwdYEMfoYIOJagsOiqG1jhjoCmkbg94+Aw34s1AYDJXGewDepi
 N5UcIst8JOLHZbRLHcv3DQ5pdqoCaxxRHl+k17GF0UQn32D5tPuVHBM6c1oPh+o79e1J
 RWnYr9xNccFVmd0hWPU3BsIKHTYo5kZvh4FVprw3+wgbeMId/4xjpYhNMLGpespPrDBd
 Bjro0Ehhsp8FRMMOmVLl6Sy3Lxy/L5czWrOOcbhm4Tet7htLDQUg6AIBxlMbsfYCkq5a
 EHRg==
X-Gm-Message-State: AOAM5304KaK4iTt7oJqPVsa4nKE8m4Bz9Kbl50kO2vjClYavpm4jQj6n
 kMNe6LcwgW4xOT6mnlNrURNa60fSmUya4w==
X-Google-Smtp-Source: ABdhPJwd/dWcX0+dq9yu0WXDpIo5KIfFytG0rxXOY4vo/oKOU7FIIbpsnlAyI6707CNKFBDY6yteEw==
X-Received: by 2002:a5d:554b:: with SMTP id g11mr24882992wrw.260.1592912384633; 
 Tue, 23 Jun 2020 04:39:44 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id m10sm4022177wru.4.2020.06.23.04.39.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2020 04:39:44 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 33/42] hw/arm/mps2: Add CMSDK APB watchdog device
Date: Tue, 23 Jun 2020 12:38:55 +0100
Message-Id: <20200623113904.28805-34-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200623113904.28805-1-peter.maydell@linaro.org>
References: <20200623113904.28805-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
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

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

We already model the CMSDK APB watchdog device, let's use it!

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20200617072539.32686-9-f4bug@amsat.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/mps2.c  | 7 +++++++
 hw/arm/Kconfig | 1 +
 2 files changed, 8 insertions(+)

diff --git a/hw/arm/mps2.c b/hw/arm/mps2.c
index 4fe5cc8622f..f7bef20b405 100644
--- a/hw/arm/mps2.c
+++ b/hw/arm/mps2.c
@@ -312,6 +312,13 @@ static void mps2_common_init(MachineState *machine)
     sysbus_connect_irq(SYS_BUS_DEVICE(&mms->dualtimer), 0,
                        qdev_get_gpio_in(armv7m, 10));
     sysbus_mmio_map(SYS_BUS_DEVICE(&mms->dualtimer), 0, 0x40002000);
+    object_initialize_child(OBJECT(mms), "watchdog", &mms->watchdog,
+                            TYPE_CMSDK_APB_WATCHDOG);
+    qdev_prop_set_uint32(DEVICE(&mms->watchdog), "wdogclk-frq", SYSCLK_FRQ);
+    sysbus_realize(SYS_BUS_DEVICE(&mms->watchdog), &error_fatal);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&mms->watchdog), 0,
+                       qdev_get_gpio_in_named(armv7m, "NMI", 0));
+    sysbus_mmio_map(SYS_BUS_DEVICE(&mms->watchdog), 0, 0x40008000);
 
     /* FPGA APB subsystem */
     object_initialize_child(OBJECT(mms), "scc", &mms->scc, TYPE_MPS2_SCC);
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 9afa6eee799..5c8f689b3dd 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -405,6 +405,7 @@ config MPS2
     select PL080    # DMA controller
     select SPLIT_IRQ
     select UNIMP
+    select CMSDK_APB_WATCHDOG
 
 config FSL_IMX7
     bool
-- 
2.20.1



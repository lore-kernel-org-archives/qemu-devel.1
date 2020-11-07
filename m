Return-Path: <SRS0=ex3l=EN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6970DC388F9
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Nov 2020 19:39:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA2592087E
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Nov 2020 19:39:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pVsUNLkf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA2592087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbU3f-0004Bf-U9
	for qemu-devel@archiver.kernel.org; Sat, 07 Nov 2020 14:39:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57714)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kbTyd-0007k1-HZ; Sat, 07 Nov 2020 14:34:19 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:36982)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kbTyc-0008Li-46; Sat, 07 Nov 2020 14:34:19 -0500
Received: by mail-wr1-x434.google.com with SMTP id w1so4712593wrm.4;
 Sat, 07 Nov 2020 11:34:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=XNu7ZLoR4xU4f3L7jkcDncHCuG1GeetmfTtko2ZN1QU=;
 b=pVsUNLkfg3ETSv26S7xdy5P1KiYSFW9gqn7RnSa44oSwLOwj2xN2Z1ed77ziicCr7a
 iAFn2FkYCWHi8PmvupwrEuq+sGxBNCN1o8jRGgh8FnrvzXXs7LlRqCIHtJZTP3xKrzf3
 LBpqwrcIQKOspxdT3HCbsZhYxT2p+2U5k29tg9AQAs/wRL8Oluz9QxgzBedABLXfLVg/
 6k1NUurusdVxSVNA10LycOtBpf1jDr7xsItho8YpoyYzfXtbdMksU/b6CG73q/1RHCVH
 kCdruiXlF6UeLne9wO7HKZsqXxs7w1fsPlzsrM0zs7gPuvJFtOa8NYMnsulS/HePJF1h
 BwIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=XNu7ZLoR4xU4f3L7jkcDncHCuG1GeetmfTtko2ZN1QU=;
 b=fX6YXV97nl6gCR7s3JjAqJ5lw+5c9l7Uk9avW2vHpAJBNwgrYZhPh+gY3WhKFK/2QE
 eJTmPxh/fbCEwINOSyOvkKAenbZ//1xmPuMSwxBI9+nJQU4wWNCYSpsS0S/HLsS971xD
 wo9qXskBRSwd9GJCHlm3GyhmU2rHbaZS/b5V+gdtccgJz+XhXX6Pfruz892KcTBqWmKA
 w2dD3KLu/p9kwn8vVauPznJWdR1StC3M6JmtET5c+PoyGgzd2SP4SNaXNt8phMeiu69J
 p0zOMbcEmGEI2nFkYiDZcrFFpriNS51kkt8odxTnp5FvT/vyOOY/gbbcMa9w15XF5qar
 E6/A==
X-Gm-Message-State: AOAM5327LRD1R7EIq+KzQ/hBGxejaKTgfiaYk5xpK6EVPjwoTtPI4I6H
 RhzXyGEKZHeRxb6KezqRLI1SWb/kRH4=
X-Google-Smtp-Source: ABdhPJzvkDp+mjeqT4GT5wqb/KVZZJTOQ0gSumlUXAk/bg73muGuPzITWu4o7Q9AM36Y+gwUsYdbGA==
X-Received: by 2002:adf:906b:: with SMTP id h98mr9223066wrh.310.1604777656184; 
 Sat, 07 Nov 2020 11:34:16 -0800 (PST)
Received: from localhost.localdomain (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id n67sm7153864wmf.25.2020.11.07.11.34.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2020 11:34:15 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.2 2/5] hw/misc/stm32f2xx_syscfg: Remove extraneous IRQ
Date: Sat,  7 Nov 2020 20:34:00 +0100
Message-Id: <20201107193403.436146-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201107193403.436146-1-f4bug@amsat.org>
References: <20201107193403.436146-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x434.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-arm@nongnu.org, Jan Kiszka <jan.kiszka@web.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The system configuration controller (SYSCFG) doesn't have
any output IRQ (and the INTC input #71 belongs to the UART6).
Remove the invalid code.

Fixes: db635521a02 ("stm32f205: Add the stm32f205 SoC")
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/misc/stm32f2xx_syscfg.h | 2 --
 hw/arm/stm32f205_soc.c             | 1 -
 hw/misc/stm32f2xx_syscfg.c         | 2 --
 3 files changed, 5 deletions(-)

diff --git a/include/hw/misc/stm32f2xx_syscfg.h b/include/hw/misc/stm32f2xx_syscfg.h
index 57a98c533db..8595a3b31b0 100644
--- a/include/hw/misc/stm32f2xx_syscfg.h
+++ b/include/hw/misc/stm32f2xx_syscfg.h
@@ -53,8 +53,6 @@ struct STM32F2XXSyscfgState {
     uint32_t syscfg_exticr3;
     uint32_t syscfg_exticr4;
     uint32_t syscfg_cmpcr;
-
-    qemu_irq irq;
 };
 
 #endif /* HW_STM32F2XX_SYSCFG_H */
diff --git a/hw/arm/stm32f205_soc.c b/hw/arm/stm32f205_soc.c
index a4f3344db25..9cd41bf56da 100644
--- a/hw/arm/stm32f205_soc.c
+++ b/hw/arm/stm32f205_soc.c
@@ -117,7 +117,6 @@ static void stm32f205_soc_realize(DeviceState *dev_soc, Error **errp)
     }
     busdev = SYS_BUS_DEVICE(dev);
     sysbus_mmio_map(busdev, 0, 0x40013800);
-    sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(armv7m, 71));
 
     /* Attach UART (uses USART registers) and USART controllers */
     for (i = 0; i < STM_NUM_USARTS; i++) {
diff --git a/hw/misc/stm32f2xx_syscfg.c b/hw/misc/stm32f2xx_syscfg.c
index aa59b435498..04c22c28502 100644
--- a/hw/misc/stm32f2xx_syscfg.c
+++ b/hw/misc/stm32f2xx_syscfg.c
@@ -133,8 +133,6 @@ static void stm32f2xx_syscfg_init(Object *obj)
 {
     STM32F2XXSyscfgState *s = STM32F2XX_SYSCFG(obj);
 
-    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq);
-
     memory_region_init_io(&s->mmio, obj, &stm32f2xx_syscfg_ops, s,
                           TYPE_STM32F2XX_SYSCFG, 0x400);
     sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
-- 
2.26.2



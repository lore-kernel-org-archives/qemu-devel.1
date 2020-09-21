Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58B20C43463
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 03:57:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C154E207D8
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 03:57:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Go1ncPH9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C154E207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKCxc-0000lW-SY
	for qemu-devel@archiver.kernel.org; Sun, 20 Sep 2020 23:57:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55230)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kKCt3-0004X6-L4; Sun, 20 Sep 2020 23:53:09 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:39650)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kKCt2-00032D-23; Sun, 20 Sep 2020 23:53:09 -0400
Received: by mail-wm1-x344.google.com with SMTP id b79so11040670wmb.4;
 Sun, 20 Sep 2020 20:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Pkq0sHrTv5/xZaj/954kaRSp726GwaYvD8ODlxKHlR0=;
 b=Go1ncPH9NLXvTxnZqohu+W7MLcTROVQi7HIKJkmLom6YO3MuX9HIJL0Wuai1L2ym5s
 BlV/C0iVBI6uJxXn0ua4CKeV3mXBJKlG0R5cLsfkGW7r3Sak3uJiRfWzxGrRhmNcoSTZ
 XUtCC0T/8L2TvErqS+tFcy+cI1KjA/ePGKwwmBtvDxwGz5iY++ftoK/WHvQEu2+GR1R9
 CVwZKG/8vnlTnFu36Ra0xb4nLuA1ApLKY/qq4KZDmzu13FFTys6be0M53HHWiyvw/qYl
 I+MXP++AOOA5cG8BXW2jWEmTq8sqX1LG1NsMZZFBvHEUDGvv7sPTv7x82Bl4DaRsEqkJ
 OGoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=Pkq0sHrTv5/xZaj/954kaRSp726GwaYvD8ODlxKHlR0=;
 b=Q2zDT+OZMBSXKmqKloA54WgMriaTJGxS/iWu8T2XGEyqVFf7Iyirf08CM9subpnKQF
 BWxl2xwY9tiwrkApIOmdYY7yN7Pe/wMqu0oltm+7c22DewZDJSkqg99lhyvPIbvVdKLO
 8mXeCP7cmv4+x62WwWrfGBYcchZte50342pvzBw2kYBWQ4cs05iSdGUaAOwAXE0+yljW
 RILNTbTxqwa2GcXcP1NY0DabR1vBMBeg/1JzyGaU29jt/fT3kGHbt+nT8psA3Y/Inpb2
 ue96qkRFUOLTeV1xQCWNchmb2ju/7vxFeMI+cYGWRBDmNE/yImSzqE2tHBw/1H0+XFRs
 JAlQ==
X-Gm-Message-State: AOAM5306TyAKh3Zppr1gaMZKR+2PsLisFyExL0Wa7Nf26o07LOAo1XNu
 VBXJJUw6B2vf+XV+CQJxDR4X5N9GL+A=
X-Google-Smtp-Source: ABdhPJwcgXuVOaOuuO2VfzfWjyr5YfxIrtxfuIFAtSTjOnFZH52u/dx0jkbB/nFFlMU1jcX8I0Ei0A==
X-Received: by 2002:a1c:9885:: with SMTP id a127mr27720249wme.8.1600660386222; 
 Sun, 20 Sep 2020 20:53:06 -0700 (PDT)
Received: from localhost.localdomain (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id a17sm19633754wra.24.2020.09.20.20.53.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Sep 2020 20:53:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 5/5] hw/arm/bcm2835_peripherals: Correctly wire the
 SYS_timer IRQs
Date: Mon, 21 Sep 2020 05:52:57 +0200
Message-Id: <20200921035257.434532-6-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200921035257.434532-1-f4bug@amsat.org>
References: <20200921035257.434532-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Paul Zimmerman <pauldzim@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The SYS_timer is not directly wired to the ARM core, but to the
SoC (peripheral) interrupt controller.

Fixes: 0e5bbd74064 ("hw/arm/bcm2835_peripherals: Use the SYS_timer")
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/bcm2835_peripherals.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
index 15c5c72e465..48909a43c32 100644
--- a/hw/arm/bcm2835_peripherals.c
+++ b/hw/arm/bcm2835_peripherals.c
@@ -171,8 +171,17 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
     memory_region_add_subregion(&s->peri_mr, ST_OFFSET,
                 sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->systmr), 0));
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->systmr), 0,
-        qdev_get_gpio_in_named(DEVICE(&s->ic), BCM2835_IC_ARM_IRQ,
-                               INTERRUPT_ARM_TIMER));
+        qdev_get_gpio_in_named(DEVICE(&s->ic), BCM2835_IC_GPU_IRQ,
+                               INTERRUPT_TIMER0));
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->systmr), 1,
+        qdev_get_gpio_in_named(DEVICE(&s->ic), BCM2835_IC_GPU_IRQ,
+                               INTERRUPT_TIMER1));
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->systmr), 2,
+        qdev_get_gpio_in_named(DEVICE(&s->ic), BCM2835_IC_GPU_IRQ,
+                               INTERRUPT_TIMER2));
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->systmr), 3,
+        qdev_get_gpio_in_named(DEVICE(&s->ic), BCM2835_IC_GPU_IRQ,
+                               INTERRUPT_TIMER3));
 
     /* UART0 */
     qdev_prop_set_chr(DEVICE(&s->uart0), "chardev", serial_hd(0));
-- 
2.26.2



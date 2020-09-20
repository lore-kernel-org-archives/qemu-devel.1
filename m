Return-Path: <SRS0=9ZvH=C5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A503C43463
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2020 18:06:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5E67207EA
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2020 18:06:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U0PK9Eik"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5E67207EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kK3jA-0001RL-2v
	for qemu-devel@archiver.kernel.org; Sun, 20 Sep 2020 14:06:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51164)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kK3bj-0001xg-UN; Sun, 20 Sep 2020 13:58:40 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:36593)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kK3bi-00031X-HP; Sun, 20 Sep 2020 13:58:39 -0400
Received: by mail-wr1-x442.google.com with SMTP id z1so10451821wrt.3;
 Sun, 20 Sep 2020 10:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1xZK1vadig9h9dP7jrIfkZesoIogtY0XRXYELyLBf2M=;
 b=U0PK9Eik3JEvu0Sum1qSEdY4uHVbNBMFh9FnCQbiFUIgbVQfR2DoRTPxDOCYKBSEnw
 k8AkxkWBAiSTC9AKlEEFmhwwdxU/hxnykVbmd+q/52OPW1nuhd/Q116cPu8gxJxcDeOC
 MsBfa14wpz74rSFOLk5uD1JuQXz37PPCxYZF5dMHG1+Kuxm+n3xex4W3JT88IpylEZs+
 IikRLob4iz4H7HbKsYpgmLVde4rq5N6sF8WJIy1EAJi/Xds1HVQllCuzY60F6iDpxLox
 PnKN9kJ57t/friTdyywiZZqNCEa0HhjHIhxiR05pa7/rNaBwSdqydsAC7rTIRmMOF1Jn
 +0RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=1xZK1vadig9h9dP7jrIfkZesoIogtY0XRXYELyLBf2M=;
 b=HBEgr9RdKK1YotlTkBh0UPI+BujreYzAqrGmorfi2HvR8r7gkgA0BoFEXfXcbInDyR
 lWqsjs8qq/YFxRMdxg9d/+Zd96VYNrN8GEA/vfFY/B3ZGfvxfEVeUT7IiQ5ERdoF5Q04
 db7WKHM7Uqdf/bW75X2TEKBG3CEYkVmYiQeT4O11c53PMHbh9NzqkN8BVm55tHQUQGyf
 TsbOtSIf6sTCWkonb5tUJIW4KgBqiqPLxBQrJB5VQTI3M5ES6pUAYoxG0a2LSgkFMVBF
 naJSjnAkLRtHoXYuoOUHjF0sIlw4TH0KWTOKFhZDAFfnVEC4ZIHLB5lg/2aNXfUXYpBA
 K5OA==
X-Gm-Message-State: AOAM53172siuuaYiEaZbcfBWTVDtSdoUL2JLObxEiNga/AKy2rR28Wg3
 QsZ0g621TsdBb+K56ru45coSZNRy4PI=
X-Google-Smtp-Source: ABdhPJwvPUpT893V2jMyyuv+t4itMljSkWTehXE8WAQqLoahv8TFm0MNZCnJR7ExWJlXV0eqspoZdw==
X-Received: by 2002:adf:f2d0:: with SMTP id d16mr46647540wrp.332.1600624716675; 
 Sun, 20 Sep 2020 10:58:36 -0700 (PDT)
Received: from localhost.localdomain (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id u66sm15675781wme.12.2020.09.20.10.58.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Sep 2020 10:58:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 7/7] hw/arm/bcm2835_peripherals: Correctly wire the SYS_timer
 IRQs
Date: Sun, 20 Sep 2020 19:58:25 +0200
Message-Id: <20200920175825.417680-8-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200920175825.417680-1-f4bug@amsat.org>
References: <20200920175825.417680-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
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
SoC interrupt controller.

Fixes: 0e5bbd74064 ("hw/arm/bcm2835_peripherals: Use the SYS_timer")
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/bcm2835_peripherals.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
index 4e6c678aa99..d1a1ff0676e 100644
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



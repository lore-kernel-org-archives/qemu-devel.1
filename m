Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4A31C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 16:02:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42F1E20936
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 16:02:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XxyYz/OR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42F1E20936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUu5u-0002uX-2M
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 12:02:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37356)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUu0l-0004Rf-5w
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 11:57:19 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:35238)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUu0j-0003s2-16
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 11:57:18 -0400
Received: by mail-wr1-x441.google.com with SMTP id n15so2807650wrq.2
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 08:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=umDgoaAFU65XIcuyABXPoBx1y8XfLewihbQF8KPdG0g=;
 b=XxyYz/ORAgoz7GvGylkg9QgB5BWZoGUaiO6fWRYuXA8vx0dEO2DOw6Eo4FYQMCpkUi
 WhCU/e9k7hnA9J8mfG4y/MkjIAX19CPHBGQOwd8chMa0K8tra69OICCEFhjdCa4EXsod
 YIxe/LWefGRoqnIFxYrFAh8f1aL1bQMJZM07jEAWmaz9K7KxM2B++4abC0lNOFItXJiR
 yNgSO1BPdTphpjWsQo6AWqqxhhsK6m2j6oj2kMsAu0V1E3KTHBBwfkt5zQp5w0n2TVYc
 bfpfMzrqI7m2Sk2Z+YQQ1gZ+RUYD6HCM6MjJ4f22gJCSTyxbjYnteQZjwPPeIhrNKhbN
 D8MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=umDgoaAFU65XIcuyABXPoBx1y8XfLewihbQF8KPdG0g=;
 b=CIt+txHSo4OyKncu9uRGyGjVhCsOaSjlbHlcKUPs9j3QTCKk90M8tYBy8JROkduq43
 bjKOj1MwptoScT5q/6u0fGdHEFvlg0MYAe2vY9/C+rzfbC+IcftNO7Wy4trnsbBRi1N5
 siA6yF5I3HXabYWziceiI6ezNATEGmELEtls2jQXxBQ8pAwimKjYeEMTH9yCnCaJy/Tk
 C1E34FGYperkm28UTAxcchU9Iu6UnlO0SnBFaUtRBcE27yAWEuT2Whiq3MBNhSvEwYnT
 a3RUTK6POGOca87+8HskrrlUDi5X614NhT2aJmx3lYOyI2rKaDKhwJC9ezU0e8zH55Gd
 cDUA==
X-Gm-Message-State: AOAM533ent2axyLribeoSzZWGdDQuMHDQEXhLbGxwcda9BgXpk2PQEkw
 9NAlLPTA+Uo5cOdq8J6Fi1hAjv6isgK/qg==
X-Google-Smtp-Source: ABdhPJwRPX+CToeLCAGA5Jf4jv8hswaZ3FgHR+cepZIo/LYJ+ZyknaHRaxi8yAMO8k3sFKIgvuhyvQ==
X-Received: by 2002:a5d:5604:: with SMTP id l4mr4149863wrv.140.1603209435303; 
 Tue, 20 Oct 2020 08:57:15 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id v6sm3780205wrp.69.2020.10.20.08.57.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2020 08:57:14 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/41] hw/arm/bcm2835_peripherals: Correctly wire the SYS_timer
 IRQs
Date: Tue, 20 Oct 2020 16:56:23 +0100
Message-Id: <20201020155656.8045-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201020155656.8045-1-peter.maydell@linaro.org>
References: <20201020155656.8045-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

The SYS_timer is not directly wired to the ARM core, but to the
SoC (peripheral) interrupt controller.

Fixes: 0e5bbd74064 ("hw/arm/bcm2835_peripherals: Use the SYS_timer")
Reviewed-by: Luc Michel <luc.michel@greensocs.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20201010203709.3116542-5-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
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
2.20.1



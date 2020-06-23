Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47BA0C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 12:10:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D551C20842
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 12:10:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t2hG5wLJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D551C20842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnhl7-0003Vd-Ug
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 08:10:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44444)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jnhHL-0003bG-Uo
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 07:39:53 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:37593)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jnhHJ-0003Ri-QL
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 07:39:51 -0400
Received: by mail-wm1-x329.google.com with SMTP id y20so2860316wmi.2
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 04:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=tymhxqXyDEbTmZSCGO7IT18a7NBET9izMcg9/EiMo9E=;
 b=t2hG5wLJmwiFTv1+8/9HxuTVTuSw4TFMViTVZsuP3FQ06IV/GQMnfku0xpeQFhKcv3
 KePEoPpMx8BXp9LkOnGeGP5tI85KBAFgxTq2uoxg8XHNIOtbFjnzC1/XoIxozuDNb42/
 LEWE+DjFh7AlJycaG3rGxG3FRijbCgDck9JInmyfsh+fGs43DhLqwtZZhMFzgJviZgcw
 1DuTgaXbnm+LWPI2rEPieTqkbaNIUEi85wVrkvuFvOzGO3bUe9SMnuz+gBjVLree6jHX
 Sq1SOplAwJl54KBZxkNrZOmeZG5+ahxs+D898RAJWS+lB/JqCfDFebm1hzcH17lmEq1Q
 uqNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tymhxqXyDEbTmZSCGO7IT18a7NBET9izMcg9/EiMo9E=;
 b=YjqJgFc6hbwQfB9IDrVAJY7CoacotVmHNUz7VrQIbaAANiS/qqcXtKG2WxzvVPovqQ
 QZ8sHR3Apa3LTCBc+Hbc+Ij3oT++nYNcIfcJs7NSGlXI/6PeLWrwdM4vlVn+mTT9DZe3
 stiLybN613My9tHAePFA8hAhNGkNx8XjxQdV5fv3O9vDZMwq7YmW/muaLaTe7BqxYj3A
 lRgKg5/dEuO7ndqWA34U0tsDuqV2rjKov52xoKh7DhJKWWPviaAIt/HGD0iNSwo9wkMI
 mA+eGC/bfK0TsPczW37NBGyVzc9QI6scBR+9xOGfzwOSzPauZgVHgRUvT3UbG4GiQJtw
 SdjQ==
X-Gm-Message-State: AOAM531RqNp2EKtJkRpkDfHVJA/JgT2rg/080ZVcQCJawLhrVK3wraOg
 EPl160YeaRd3WlSzoUmUB7EvaUUudBDPgw==
X-Google-Smtp-Source: ABdhPJxzlJjKAbo6zi/DzFBbfcdCVbcBltvlY//tPm/iANFqS/zlz2/9hqhs8LOTRTueeJLpPAzUOw==
X-Received: by 2002:a05:600c:410f:: with SMTP id
 j15mr535731wmi.128.1592912387885; 
 Tue, 23 Jun 2020 04:39:47 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id m10sm4022177wru.4.2020.06.23.04.39.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2020 04:39:46 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 36/42] hw/arm/mps2: Add SPI devices
Date: Tue, 23 Jun 2020 12:38:58 +0100
Message-Id: <20200623113904.28805-37-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200623113904.28805-1-peter.maydell@linaro.org>
References: <20200623113904.28805-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

From 'Application Note AN385', chapter 3.9, SPI:

  The SMM implements five PL022 SPI modules.

Two pairs of modules share the same OR-gated IRQ.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20200617072539.32686-12-f4bug@amsat.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/mps2.c  | 24 ++++++++++++++++++++++++
 hw/arm/Kconfig |  6 +++---
 2 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/hw/arm/mps2.c b/hw/arm/mps2.c
index e1061232254..daa26f68d79 100644
--- a/hw/arm/mps2.c
+++ b/hw/arm/mps2.c
@@ -39,6 +39,7 @@
 #include "hw/timer/cmsdk-apb-dualtimer.h"
 #include "hw/misc/mps2-scc.h"
 #include "hw/misc/mps2-fpgaio.h"
+#include "hw/ssi/pl022.h"
 #include "hw/net/lan9118.h"
 #include "net/net.h"
 #include "hw/watchdog/cmsdk-apb-watchdog.h"
@@ -341,6 +342,29 @@ static void mps2_common_init(MachineState *machine)
     qdev_prop_set_uint32(DEVICE(&mms->fpgaio), "prescale-clk", 25000000);
     sysbus_realize(SYS_BUS_DEVICE(&mms->fpgaio), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(&mms->fpgaio), 0, 0x40028000);
+    sysbus_create_simple(TYPE_PL022, 0x40025000,        /* External ADC */
+                         qdev_get_gpio_in(armv7m, 22));
+    for (i = 0; i < 2; i++) {
+        static const int spi_irqno[] = {11, 24};
+        static const hwaddr spibase[] = {0x40020000,    /* APB */
+                                         0x40021000,    /* LCD */
+                                         0x40026000,    /* Shield0 */
+                                         0x40027000};   /* Shield1 */
+        DeviceState *orgate_dev;
+        Object *orgate;
+        int j;
+
+        orgate = object_new(TYPE_OR_IRQ);
+        object_property_set_int(orgate, 2, "num-lines", &error_fatal);
+        orgate_dev = DEVICE(orgate);
+        qdev_realize(orgate_dev, NULL, &error_fatal);
+        qdev_connect_gpio_out(orgate_dev, 0,
+                              qdev_get_gpio_in(armv7m, spi_irqno[i]));
+        for (j = 0; j < 2; j++) {
+            sysbus_create_simple(TYPE_PL022, spibase[2 * i + j],
+                                 qdev_get_gpio_in(orgate_dev, j));
+        }
+    }
 
     /* In hardware this is a LAN9220; the LAN9118 is software compatible
      * except that it doesn't support the checksum-offload feature.
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 5c8f689b3dd..90ed584e7ac 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -59,7 +59,7 @@ config HIGHBANK
     select ARM_TIMER # sp804
     select ARM_V7M
     select PL011 # UART
-    select PL022 # Serial port
+    select PL022 # SPI
     select PL031 # RTC
     select PL061 # GPIO
     select PL310 # cache controller
@@ -222,7 +222,7 @@ config STELLARIS
     select CMSDK_APB_WATCHDOG
     select I2C
     select PL011 # UART
-    select PL022 # Serial port
+    select PL022 # SPI
     select PL061 # GPIO
     select SSD0303 # OLED display
     select SSD0323 # OLED display
@@ -401,7 +401,7 @@ config MPS2
     select MPS2_FPGAIO
     select MPS2_SCC
     select OR_IRQ
-    select PL022    # Serial port
+    select PL022    # SPI
     select PL080    # DMA controller
     select SPLIT_IRQ
     select UNIMP
-- 
2.20.1



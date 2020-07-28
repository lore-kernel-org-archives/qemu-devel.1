Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD929C433EC
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 10:39:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A09520786
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 10:39:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hc9j+Sdm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A09520786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0N1E-0006yR-LQ
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 06:39:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53602)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k0MzZ-0004lr-Iw
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 06:37:53 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:54971)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k0MzX-0002lw-3g
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 06:37:53 -0400
Received: by mail-wm1-x342.google.com with SMTP id d190so204799wmd.4
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2020 03:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=K3mgJCwncdqIipiYAU+wCrFh9fTPvR4OlTHmlok7qrM=;
 b=Hc9j+SdmnOO9Yaf2c4ihvxVxBuQIhB7CHYtOAbMj1VJLNlJTx2rL3DReli7UFIxIaZ
 QkKH1I38JhE3+Sqe/K2wUU8qRCN3EyKMzB0wRqFnjm2NTCA+0qOkwD+qBA2PAm6FcMtt
 mHVS9roCEh3Rvbxb4soAAj9GOJZU/G86iJY26JuYic+tm7VqiUwtEzgAmnuxZRior7+E
 O0PIFDKe/UCHMUmc20SbH8KNxGaqP2Llaie8ci2+XMn6bILBzHZOXbD+HmQtHsHU2cPy
 /ZAafJG1W/R9F3f8YFz/N3Ob1hqDFukA8xih65RfeMg0s1l0zuJNbmpoPqutv4lz6zVz
 gF9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=K3mgJCwncdqIipiYAU+wCrFh9fTPvR4OlTHmlok7qrM=;
 b=qaK/9Iw3Lbmac/hZRTPIeQRxvEn4FDwEJVsawdgM+8HoYZCQe7yFgLqlYztcCc0P9S
 wF1J1KbFZsd5M1j/lKWerDUoLyGn+ejSF+dmJZ7hiUFt8Mz0Ov5xelY2OCIEisbFW1A0
 oh8gvnvuCZIxoZNDw9TYAWp4YkniphML1P0xynzz/zbcoQ69GHVXCRkLrAHmlsm5lKmR
 wepVXvD0XBr0zByD/ZbdiXfeQpwhHVQylIcaBDiooBtD0JpulbbOOcVb+F8o8zE9eHZZ
 kEubMrJcy/xj62GzmjXiTozqVmowLGQr+n/OjSCvohXp2Ly71KPO/Eh7b9FPOLD/SzpE
 +KrA==
X-Gm-Message-State: AOAM532toeeJYO/HLE8K61VDnT3bxaWK3HG/94glQkOFnmas2vHr/L6P
 QlmwQzpKEywp+K8pNjruADoIgA==
X-Google-Smtp-Source: ABdhPJwMVbKHpRie44qNkpjUr4qDDsGjIUX/LdMua/Al2EivDnbEMzeKdeov7bCT9FvM7adOFiPJrg==
X-Received: by 2002:a1c:dc02:: with SMTP id t2mr3391892wmg.55.1595932669892;
 Tue, 28 Jul 2020 03:37:49 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w16sm18634657wrg.95.2020.07.28.03.37.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2020 03:37:49 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH for-5.1? 3/3] msf2-soc, stellaris: Don't wire up SYSRESETREQ
Date: Tue, 28 Jul 2020 11:37:44 +0100
Message-Id: <20200728103744.6909-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200728103744.6909-1-peter.maydell@linaro.org>
References: <20200728103744.6909-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x342.google.com
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

The MSF2 SoC model and the Stellaris board code both wire
SYSRESETREQ up to a function that just invokes
    qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
This is now the default action that the NVIC does if the line is
not connected, so we can delete the handling code.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/msf2-soc.c  | 11 -----------
 hw/arm/stellaris.c | 12 ------------
 2 files changed, 23 deletions(-)

diff --git a/hw/arm/msf2-soc.c b/hw/arm/msf2-soc.c
index 33ea7df342c..d2c29e82d13 100644
--- a/hw/arm/msf2-soc.c
+++ b/hw/arm/msf2-soc.c
@@ -30,7 +30,6 @@
 #include "hw/irq.h"
 #include "hw/arm/msf2-soc.h"
 #include "hw/misc/unimp.h"
-#include "sysemu/runstate.h"
 #include "sysemu/sysemu.h"
 
 #define MSF2_TIMER_BASE       0x40004000
@@ -59,13 +58,6 @@ static const int spi_irq[MSF2_NUM_SPIS] = { 2, 3 };
 static const int uart_irq[MSF2_NUM_UARTS] = { 10, 11 };
 static const int timer_irq[MSF2_NUM_TIMERS] = { 14, 15 };
 
-static void do_sys_reset(void *opaque, int n, int level)
-{
-    if (level) {
-        qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
-    }
-}
-
 static void m2sxxx_soc_initfn(Object *obj)
 {
     MSF2State *s = MSF2_SOC(obj);
@@ -130,9 +122,6 @@ static void m2sxxx_soc_realize(DeviceState *dev_soc, Error **errp)
         return;
     }
 
-    qdev_connect_gpio_out_named(DEVICE(&s->armv7m.nvic), "SYSRESETREQ", 0,
-                                qemu_allocate_irq(&do_sys_reset, NULL, 0));
-
     system_clock_scale = NANOSECONDS_PER_SECOND / s->m3clk;
 
     for (i = 0; i < MSF2_NUM_UARTS; i++) {
diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
index 28eb15c76ca..5f9d0801807 100644
--- a/hw/arm/stellaris.c
+++ b/hw/arm/stellaris.c
@@ -18,7 +18,6 @@
 #include "hw/boards.h"
 #include "qemu/log.h"
 #include "exec/address-spaces.h"
-#include "sysemu/runstate.h"
 #include "sysemu/sysemu.h"
 #include "hw/arm/armv7m.h"
 #include "hw/char/pl011.h"
@@ -1206,14 +1205,6 @@ static void stellaris_adc_init(Object *obj)
     qdev_init_gpio_in(dev, stellaris_adc_trigger, 1);
 }
 
-static
-void do_sys_reset(void *opaque, int n, int level)
-{
-    if (level) {
-        qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
-    }
-}
-
 /* Board init.  */
 static stellaris_board_info stellaris_boards[] = {
   { "LM3S811EVB",
@@ -1317,9 +1308,6 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
     /* This will exit with an error if the user passed us a bad cpu_type */
     sysbus_realize_and_unref(SYS_BUS_DEVICE(nvic), &error_fatal);
 
-    qdev_connect_gpio_out_named(nvic, "SYSRESETREQ", 0,
-                                qemu_allocate_irq(&do_sys_reset, NULL, 0));
-
     if (board->dc1 & (1 << 16)) {
         dev = sysbus_create_varargs(TYPE_STELLARIS_ADC, 0x40038000,
                                     qdev_get_gpio_in(nvic, 14),
-- 
2.20.1



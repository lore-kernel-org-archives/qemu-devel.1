Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6468EC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 18:38:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F70620738
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 18:38:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DpbGME5n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F70620738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnRKW-0002hF-Dn
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 14:38:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43340)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jnRHH-0005Vh-05; Mon, 22 Jun 2020 14:34:43 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:35020)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jnRHE-00081i-MI; Mon, 22 Jun 2020 14:34:42 -0400
Received: by mail-wm1-x343.google.com with SMTP id g21so564103wmg.0;
 Mon, 22 Jun 2020 11:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=3xCUhA3m+rl5DAQvYGnBc4oXR1NerNsp6itkxzvGcTI=;
 b=DpbGME5nbeoFgV0xX+uQuwfsx1a9n/WtL6oC3xDCuIyzIZRRIdPE2UpGGq5G6vqz59
 BTxUyM7I0p873ozHX0nlz3anp+UkFCCjz8gnAzfX06Bo4xHHf/kW+LrJ/QCgF3THirw1
 SKceUktRArO/VyiXmuWWF5H4WtiGM65H7DnrZMv8imNxEGtippRxnKBcSOXf4m066ssw
 /NiHgAeypU9gXWO08fZ8+t209vHx5bxRt7JXTQSm/h5TfgAySMIPSq3f9NOpEGjBwIiJ
 JYITyvkLdKGsy7wbTDRj8Nuf8mTdciAGA2G7XSvQB3tm2YRtVKD2Fqh9esBJsYc6vRCf
 FEbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=3xCUhA3m+rl5DAQvYGnBc4oXR1NerNsp6itkxzvGcTI=;
 b=nz4xOdXLCTbN1lw/Lc1O0ZQo0lSz0V7skc2CcKY/JMoy/AKV9K0tVTJv9phyNJu9jh
 7S8yD6CVMIJsOR5PI1WFarUYFaVaKtINURCMsAUqk0r4SCka9pWHWaW8Jj3ZdQLsZKL5
 Hs+PgtWliII+OoAMyLKrw88igySF+VGm9A1vhiLVpwn0trCm7IfEbJ+QkLDfh761ScpY
 1JKA5QxJh2DWGoz9mskwpcBTbPzxW41Ze0MUypGoqdaP5Nqhvxph1/+74w0Awbmd1Ugy
 1opsfGkDLOOyKuag06lAcrNXCzj6GA/Vezm/9xTDnPbaT682tHosI9X+72uxupdR+4gP
 BBfA==
X-Gm-Message-State: AOAM5334oh9Np92xgjkB+yZvfLeXb4lZrXiLhE7yoXONkgVeKYd5SenB
 keVi+D9zyLScC3cRr4HUKLzp0IUs
X-Google-Smtp-Source: ABdhPJzGHSVGYDBHOC+5YPF6833y75cARs28MLjhhBcteYnk6BnIHXGuZs3rhS+wkUzRdsvJJLQUOw==
X-Received: by 2002:a1c:64d5:: with SMTP id
 y204mr20692515wmb.131.1592850878658; 
 Mon, 22 Jun 2020 11:34:38 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id h29sm20286161wrc.78.2020.06.22.11.34.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2020 11:34:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 6/9] hw/misc/pca9552: Trace GPIO High/Low events
Date: Mon, 22 Jun 2020 20:34:25 +0200
Message-Id: <20200622183428.12255-7-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200622183428.12255-1-f4bug@amsat.org>
References: <20200622183428.12255-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 Corey Minyard <cminyard@mvista.com>, Andrew Jeffery <andrew@aj.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add a trivial representation of the PCA9552 GPIOs.

Example booting obmc-phosphor-image:

  $ qemu-system-arm -M witherspoon-bmc -trace pca955x_gpio_status
  1592689902.327837:pca955x_gpio_status pca-unspecified GPIOs 0-15 [*...............]
  1592689902.329934:pca955x_gpio_status pca-unspecified GPIOs 0-15 [**..............]
  1592689902.330717:pca955x_gpio_status pca-unspecified GPIOs 0-15 [***.............]
  1592689902.331431:pca955x_gpio_status pca-unspecified GPIOs 0-15 [****............]
  1592689902.332163:pca955x_gpio_status pca-unspecified GPIOs 0-15 [****.........*..]
  1592689902.332888:pca955x_gpio_status pca-unspecified GPIOs 0-15 [****.........**.]
  1592689902.333629:pca955x_gpio_status pca-unspecified GPIOs 0-15 [****.........***]
  1592690032.793289:pca955x_gpio_status pca-unspecified GPIOs 0-15 [****.........*.*]
  1592690033.303163:pca955x_gpio_status pca-unspecified GPIOs 0-15 [****.........***]
  1592690033.812962:pca955x_gpio_status pca-unspecified GPIOs 0-15 [****.........*.*]
  1592690034.323234:pca955x_gpio_status pca-unspecified GPIOs 0-15 [****.........***]
  1592690034.832922:pca955x_gpio_status pca-unspecified GPIOs 0-15 [****.........*.*]

We notice the GPIO #14 (front-power LED) starts to blink.

This LED is described in the witherspoon device-tree [*]:

  front-power {
      retain-state-shutdown;
      default-state = "keep";
      gpios = <&pca0 14 GPIO_ACTIVE_LOW>;
  };

[*] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/aspeed-bmc-opp-witherspoon.dts?id=b1f9be9392f0#n140

Suggested-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/misc/pca9552.c    | 39 +++++++++++++++++++++++++++++++++++++++
 hw/misc/trace-events |  3 +++
 2 files changed, 42 insertions(+)

diff --git a/hw/misc/pca9552.c b/hw/misc/pca9552.c
index d6d84c6451..13f5ed0da4 100644
--- a/hw/misc/pca9552.c
+++ b/hw/misc/pca9552.c
@@ -13,12 +13,14 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
+#include "qemu/bitops.h"
 #include "hw/qdev-properties.h"
 #include "hw/misc/pca9552.h"
 #include "hw/misc/pca9552_regs.h"
 #include "migration/vmstate.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
+#include "trace.h"
 
 typedef struct PCA955xClass {
     /*< private >*/
@@ -49,6 +51,39 @@ static uint8_t pca955x_pin_get_config(PCA955xState *s, int pin)
     return extract32(s->regs[reg], shift, 2);
 }
 
+/* Return INPUT status (bit #N belongs to GPIO #N) */
+static uint16_t pca955x_pins_get_status(PCA955xState *s)
+{
+    return (s->regs[PCA9552_INPUT1] << 8) | s->regs[PCA9552_INPUT0];
+}
+
+static void pca955x_display_pins_status(PCA955xState *s,
+                                        uint16_t previous_pins_status)
+{
+    PCA955xClass *k = PCA955X_GET_CLASS(s);
+    uint16_t pins_status, pins_changed;
+    int i;
+
+    pins_status = pca955x_pins_get_status(s);
+    pins_changed = previous_pins_status ^ pins_status;
+    if (!pins_changed) {
+        return;
+    }
+    if (trace_event_get_state_backends(TRACE_PCA955X_GPIO_STATUS)) {
+        char *buf = g_newa(char, k->pin_count + 1);
+
+        for (i = 0; i < k->pin_count; i++) {
+            if (extract32(pins_status, i, 1)) {
+                buf[i] = '*';
+            } else {
+                buf[i] = '.';
+            }
+        }
+        buf[i] = '\0';
+        trace_pca955x_gpio_status(s->description, buf);
+    }
+}
+
 static void pca955x_update_pin_input(PCA955xState *s)
 {
     PCA955xClass *k = PCA955X_GET_CLASS(s);
@@ -98,6 +133,8 @@ static uint8_t pca955x_read(PCA955xState *s, uint8_t reg)
 
 static void pca955x_write(PCA955xState *s, uint8_t reg, uint8_t data)
 {
+    uint16_t pins_status;
+
     switch (reg) {
     case PCA9552_PSC0:
     case PCA9552_PWM0:
@@ -110,8 +147,10 @@ static void pca955x_write(PCA955xState *s, uint8_t reg, uint8_t data)
     case PCA9552_LS1:
     case PCA9552_LS2:
     case PCA9552_LS3:
+        pins_status = pca955x_pins_get_status(s);
         s->regs[reg] = data;
         pca955x_update_pin_input(s);
+        pca955x_display_pins_status(s, pins_status);
         break;
 
     case PCA9552_INPUT0:
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index 5561746866..9282c60dd9 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -206,3 +206,6 @@ via1_rtc_cmd_pram_sect_write(int sector, int offset, int addr, int value) "secto
 # grlib_ahb_apb_pnp.c
 grlib_ahb_pnp_read(uint64_t addr, uint32_t value) "AHB PnP read addr:0x%03"PRIx64" data:0x%08x"
 grlib_apb_pnp_read(uint64_t addr, uint32_t value) "APB PnP read addr:0x%03"PRIx64" data:0x%08x"
+
+# pca9552.c
+pca955x_gpio_status(const char *description, const char *buf) "%s GPIOs 0-15 [%s]"
-- 
2.21.3



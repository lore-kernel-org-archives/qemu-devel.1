Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83CC4C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 15:20:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5078D20773
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 15:20:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iryO9eF9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5078D20773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joq9E-0002Tz-HX
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 11:20:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35468)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joq3x-00021f-N7
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 11:14:45 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:44776)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joq3q-0006GO-LV
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 11:14:45 -0400
Received: by mail-wr1-x444.google.com with SMTP id b6so9837189wrs.11
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2020 08:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=NAVH5y7iWpRw66JxeAnEE7mguU/FzOf8PzQCxUY5S0o=;
 b=iryO9eF9WC5BuHf5JIEB980xDud3lSmurQ/PHj4rSK+1R4O/rf4aQNogVcIKF5QYq0
 0MQNcxmMSTsAl1c5DcYPn5BwaoNxnvRQrVBh2FfKJwfz0RE4EVoETX0Cgox6/d5Ulaqq
 GP4oEyT+WfvjHYcmJufkpRRv63gCY1f7m5UJqBMC2Zl3zy2rfiChL1fL47f1/BTZDp1F
 M27fu5lCXbp9f9fPrkoopRFKPFA0z9vmyiFzRM0OQzQ8znMoDojL5Xv4xshLvPQ6NMv+
 MtGtS4TyUE8O8LmS1NthGf9ybUAiSsRyBUruHxeT0RifO2RD5caIKXwEPDZAu2zIsS3P
 9OYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NAVH5y7iWpRw66JxeAnEE7mguU/FzOf8PzQCxUY5S0o=;
 b=CBDiDlkyxXM1s8rt4wbBMIIJWrEBG2CUv/C8ifbN/nUAP3tHWy7GPszGA8NXYDAF2E
 rdBVWkrrs9gcXVGFAypjv5gIDbLVCdMLm16wuGnO7xVPpR79mQCRvieV1GS5S/oamZfn
 7U6nYXRBxi/rhMfTncEsNg088xISQhC/WLyWUbRhandIlOkm3rER19X2k/nHTOJUtla/
 4A/TOOR/cXB+uHApj66ZjKG72YlDyixkmmfC4Wmz338G8HtEi3cVxnYXgKzwB/HR/RRy
 SCDBRaRkLP5aT1x3FQ2VTtFVRKA78d3hFjbmoVbsexxmK7D56J8c3OK8pzZuI0OTFmDL
 5nzg==
X-Gm-Message-State: AOAM530q+4aGrDQFwQaAp9c54IM5VoP3gc6tvYZyuMBGtDylkbbPbNhs
 9uwQpm5iWLErpzofjhairI5ZbOmp/tiZEg==
X-Google-Smtp-Source: ABdhPJxd/4VmNXEoVwl8m/RpvpfsYOMzhSl7JqCitiaMNRCpBmeKKpgZC3YTcc8k8uVd4jFtla3pBg==
X-Received: by 2002:a5d:4a45:: with SMTP id v5mr4309953wrs.228.1593184476975; 
 Fri, 26 Jun 2020 08:14:36 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w13sm37838852wrr.67.2020.06.26.08.14.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2020 08:14:36 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/57] hw/misc/pca9552: Trace GPIO High/Low events
Date: Fri, 26 Jun 2020 16:13:36 +0100
Message-Id: <20200626151424.30117-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200626151424.30117-1-peter.maydell@linaro.org>
References: <20200626151424.30117-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x444.google.com
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
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Cédric Le Goater <clg@kaod.org>
Message-id: 20200623072723.6324-7-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/misc/pca9552.c    | 39 +++++++++++++++++++++++++++++++++++++++
 hw/misc/trace-events |  3 +++
 2 files changed, 42 insertions(+)

diff --git a/hw/misc/pca9552.c b/hw/misc/pca9552.c
index 2cc52b02057..41f8ad213dd 100644
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
index 68a6d9f2ab8..bd7bd37ea8d 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -209,3 +209,6 @@ via1_adb_poll(uint8_t data, const char *vadbint, int status, int index, int size
 # grlib_ahb_apb_pnp.c
 grlib_ahb_pnp_read(uint64_t addr, uint32_t value) "AHB PnP read addr:0x%03"PRIx64" data:0x%08x"
 grlib_apb_pnp_read(uint64_t addr, uint32_t value) "APB PnP read addr:0x%03"PRIx64" data:0x%08x"
+
+# pca9552.c
+pca955x_gpio_status(const char *description, const char *buf) "%s GPIOs 0-15 [%s]"
-- 
2.20.1



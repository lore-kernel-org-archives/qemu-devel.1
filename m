Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E633C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 22:14:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 898DB20878
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 22:14:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hs55KhvK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 898DB20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXAlM-0002Nz-Kf
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 18:14:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40146)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kXAdp-0000GL-1h; Mon, 26 Oct 2020 18:07:01 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630]:36714)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kXAdn-0005nm-5g; Mon, 26 Oct 2020 18:07:00 -0400
Received: by mail-ej1-x630.google.com with SMTP id w27so16107396ejb.3;
 Mon, 26 Oct 2020 15:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=oZ59K3EUFY4um2tzgzmnbro06kh/DapJGr61n3bGzJU=;
 b=hs55KhvKDi4acDEDW1Tmk98gdFW6cYfhLJBI4NLLJG1xfLWBSJxQ0g4gdepB3K4pIz
 FwKo5HQx0Mqd0vF+jJ/LjjSJe3gv4JAMShsMnG8YCJSaBfjTJwpsVi3Gb6wl86GjuAWQ
 8+RhkaC5U9Mxut9UXgPlCHA7cHala162JyT2yrKXHoJFFrKUgSmxN/Nu+RXUbsoreaus
 ZD3+8S0z4h1DyD3gJ+W3763W+te2fcWfqmhN/2TiE4YTaSo19AhSnItS6drAI1sCbeCi
 BnJKcpiqU13Y/8xMbJNPBXV5J7PF2OSAhkgw54pbT9M/G2Iu7QY2LYY5GQd9c/+qIteU
 s5NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=oZ59K3EUFY4um2tzgzmnbro06kh/DapJGr61n3bGzJU=;
 b=JIW8yI6n8T7BQ/4Wg4elWrZLlwOomjOt/9V9mBQP32u/mdG0yFrfvOASher9FkXu8T
 rNpqVBAbaO+5qcBR7odzJDXy2U7mIRLGdZbFEUoT251K+YOrLvyqgXgP995oUMxYYMip
 wNqCDFRfmTdrTbAbMaQUQBdlHvdu11QqYHqlrVnygXT8O4NBoVr6zepODY2EIYeMX7Xo
 KXHCot0SV7BcQWs+GjcynRLDBvSBoCc0WCTGmbTbY1w8vbkAdXCDkk9Q4xymieBM/LBB
 f3oJ3ANbG/WwzVztevl0M55EKRwJTSQE1ZMvaNmYpepzx7EPSULSSOpLppxTJhryZZSk
 vg7A==
X-Gm-Message-State: AOAM530weRfaAViIyuWlZZWbmzlLdEFPR9p60mQGyxj2BnTaavQgacTp
 n39IunqSSgi0zuUYS8v6W+LM5+dDYKs=
X-Google-Smtp-Source: ABdhPJzi+Xn6EHR1mnORqwvxk/3IbGO9WdS6dc6tM7syNjnepocKBXGThx96c7EO9sxvo4NKyms4tg==
X-Received: by 2002:a17:906:802:: with SMTP id
 e2mr17454358ejd.294.1603750016997; 
 Mon, 26 Oct 2020 15:06:56 -0700 (PDT)
Received: from x1w.redhat.com (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id c14sm5869102edy.13.2020.10.26.15.06.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2020 15:06:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PULL 5/7] hw/misc/mps2-fpgaio: Use the LED device
Date: Mon, 26 Oct 2020 23:06:22 +0100
Message-Id: <20201026220624.60878-6-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201026220624.60878-1-f4bug@amsat.org>
References: <20201026220624.60878-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x630.google.com
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
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Andrew Jeffery <andrew@aj.id.au>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>,
 Paolo Bonzini <pbonzini@redhat.com>, Luc Michel <luc.michel@greensocs.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Per the 'ARM MPS2 and MPS2+ FPGA Prototyping Boards Technical
Reference Manual' (100112_0200_07_en):

  2.1  Overview of the MPS2 and MPS2+ hardware

       The MPS2 and MPS2+ FPGA Prototyping Boards contain the
       following components and interfaces:

       * User switches and user LEDs:

         - Two green LEDs and two push buttons that connect to
           the FPGA.
         - Eight green LEDs and one 8-way dip switch that connect
           to the MCC.

Add the 2 LEDs connected to the FPGA.

This replaces the 'mps2_fpgaio_leds' trace events by the generic
'led_set_intensity' event.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Luc Michel <luc.michel@greensocs.com>
Message-Id: <20200912134041.946260-6-f4bug@amsat.org>
---
 include/hw/misc/mps2-fpgaio.h |  2 ++
 hw/misc/mps2-fpgaio.c         | 23 ++++++++++++++++++-----
 hw/misc/Kconfig               |  1 +
 hw/misc/trace-events          |  1 -
 4 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/include/hw/misc/mps2-fpgaio.h b/include/hw/misc/mps2-fpgaio.h
index 80f9227aa66..a010fdb2b6d 100644
--- a/include/hw/misc/mps2-fpgaio.h
+++ b/include/hw/misc/mps2-fpgaio.h
@@ -22,6 +22,7 @@
 #define MPS2_FPGAIO_H
 
 #include "hw/sysbus.h"
+#include "hw/misc/led.h"
 #include "qom/object.h"
 
 #define TYPE_MPS2_FPGAIO "mps2-fpgaio"
@@ -33,6 +34,7 @@ struct MPS2FPGAIO {
 
     /*< public >*/
     MemoryRegion iomem;
+    LEDState *led[2];
 
     uint32_t led0;
     uint32_t prescale;
diff --git a/hw/misc/mps2-fpgaio.c b/hw/misc/mps2-fpgaio.c
index 2f3fbeef348..6af0e8f837a 100644
--- a/hw/misc/mps2-fpgaio.c
+++ b/hw/misc/mps2-fpgaio.c
@@ -24,6 +24,7 @@
 #include "migration/vmstate.h"
 #include "hw/registerfields.h"
 #include "hw/misc/mps2-fpgaio.h"
+#include "hw/misc/led.h"
 #include "hw/qdev-properties.h"
 #include "qemu/timer.h"
 
@@ -176,12 +177,9 @@ static void mps2_fpgaio_write(void *opaque, hwaddr offset, uint64_t value,
 
     switch (offset) {
     case A_LED0:
-        /* LED bits [1:0] control board LEDs. We don't currently have
-         * a mechanism for displaying this graphically, so use a trace event.
-         */
-        trace_mps2_fpgaio_leds(value & 0x02 ? '*' : '.',
-                               value & 0x01 ? '*' : '.');
         s->led0 = value & 0x3;
+        led_set_state(s->led[0], value & 0x01);
+        led_set_state(s->led[1], value & 0x02);
         break;
     case A_PRESCALE:
         resync_counter(s);
@@ -239,6 +237,10 @@ static void mps2_fpgaio_reset(DeviceState *dev)
     s->counter = 0;
     s->pscntr = 0;
     s->pscntr_sync_ticks = now;
+
+    for (size_t i = 0; i < ARRAY_SIZE(s->led); i++) {
+        device_cold_reset(DEVICE(s->led[i]));
+    }
 }
 
 static void mps2_fpgaio_init(Object *obj)
@@ -251,6 +253,16 @@ static void mps2_fpgaio_init(Object *obj)
     sysbus_init_mmio(sbd, &s->iomem);
 }
 
+static void mps2_fpgaio_realize(DeviceState *dev, Error **errp)
+{
+    MPS2FPGAIO *s = MPS2_FPGAIO(dev);
+
+    s->led[0] = led_create_simple(OBJECT(dev), GPIO_POLARITY_ACTIVE_HIGH,
+                                  LED_COLOR_GREEN, "USERLED0");
+    s->led[1] = led_create_simple(OBJECT(dev), GPIO_POLARITY_ACTIVE_HIGH,
+                                  LED_COLOR_GREEN, "USERLED1");
+}
+
 static bool mps2_fpgaio_counters_needed(void *opaque)
 {
     /* Currently vmstate.c insists all subsections have a 'needed' function */
@@ -299,6 +311,7 @@ static void mps2_fpgaio_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->vmsd = &mps2_fpgaio_vmstate;
+    dc->realize = mps2_fpgaio_realize;
     dc->reset = mps2_fpgaio_reset;
     device_class_set_props(dc, mps2_fpgaio_properties);
 }
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index e4d059591ad..7e9a8a443a5 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -93,6 +93,7 @@ config MIPS_ITU
 
 config MPS2_FPGAIO
     bool
+    select LED
 
 config MPS2_SCC
     bool
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index 6bf7ce863fb..52e637bf4c3 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -92,7 +92,6 @@ mps2_scc_cfg_read(unsigned function, unsigned device, uint32_t value) "MPS2 SCC
 mps2_fpgaio_read(uint64_t offset, uint64_t data, unsigned size) "MPS2 FPGAIO read: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u"
 mps2_fpgaio_write(uint64_t offset, uint64_t data, unsigned size) "MPS2 FPGAIO write: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u"
 mps2_fpgaio_reset(void) "MPS2 FPGAIO: reset"
-mps2_fpgaio_leds(char led1, char led0) "MPS2 FPGAIO LEDs: %c%c"
 
 # msf2-sysreg.c
 msf2_sysreg_write(uint64_t offset, uint32_t val, uint32_t prev) "msf2-sysreg write: addr 0x%08" PRIx64 " data 0x%" PRIx32 " prev 0x%" PRIx32
-- 
2.26.2



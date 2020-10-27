Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57CC6C388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 12:45:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEEAE218AC
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 12:45:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hD3oZslg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEEAE218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXOLp-0002EF-MU
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 08:45:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52662)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kXNQ8-00029r-QR
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 07:45:44 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:46825)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kXNQ1-0004pr-BL
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 07:45:44 -0400
Received: by mail-wr1-x441.google.com with SMTP id n6so1491911wrm.13
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 04:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=9r3Qqc8MEyeZ3w8VA5gDxlqhC0ADvU6O9MruFoZbYqQ=;
 b=hD3oZslgh2OiFcox3ct/tRQuamtlYI+jgiLsYfeWq57vyQVtuZvOZ1XL1oeL5chV6u
 Yc7p7qx3xFspcufbWG9RERL/o+/oD2SZHbPmG3ZQbKCJZb2zgFK52dpesMH///wDQnjs
 kqeb1juIRf91x7tymAbwPaV/aabBadg+4oHh8ywnVQH9Ri4NY63JhavGuVacH4FiP5PL
 V+yP8MAeLTwBqDA0UbyKX7BgMsARkdiym9E8ZPXk4AF8f09VWtk+TPK6DXeFY+SrlXSj
 0NjPSKhNESjSkuNIzipJZIpZCTJhfl33Rp0Ve6ftq3Wikd2101/v1GM/S4W2ALIK1TVA
 6KvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9r3Qqc8MEyeZ3w8VA5gDxlqhC0ADvU6O9MruFoZbYqQ=;
 b=F60ShVabmbWKA2cg3qHkH4nvaaFaH8/bb9tAHoKUkT9rGwRTyGjrOX3MBbt7SPY96U
 eiBKl6lnSnPIN9ovPoc45OeCmNG8sx/dKGS1K4DpqnZuJsPVkExSmKZZKFFh5dantMNv
 V5U/cPb01ZhadpTiQVs7AcwdjeIB60Y10mTdclT3QbgyGYrrLPJ1EYxABs+P+uL/RDd+
 mkXhAUQu6mtfnWB0WfqQRBHvjNUnXtaqhDJytMmp5nzcZT6EQQ8S8KqVbljEuJNnjI7d
 6RW5MFFKzz6O4/6DYToqSr8YRtFL932R3Lx9jsW6LaX4ef0W/K7N9ahRE/MU0ccw8bWQ
 GVMg==
X-Gm-Message-State: AOAM531hG+gR1EFV4vLY+TVrqPRpmYmAth71R8wteSE/b/ns5A6TXl3o
 aet+9IZvt2m6zVojsBn4quWHgOhK3NYSew==
X-Google-Smtp-Source: ABdhPJzfvjB4MlVR9OcNAk+SPdBl5uwGddB8Ft+QWVtGqxEgi+hOzSnrYm0MmawDEY5wo+ECsBpyWQ==
X-Received: by 2002:a5d:6407:: with SMTP id z7mr2561370wru.271.1603799135150; 
 Tue, 27 Oct 2020 04:45:35 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 32sm1712203wro.31.2020.10.27.04.45.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2020 04:45:34 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 43/48] hw/char/pl011: add a clock input
Date: Tue, 27 Oct 2020 11:44:33 +0000
Message-Id: <20201027114438.17662-44-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201027114438.17662-1-peter.maydell@linaro.org>
References: <20201027114438.17662-1-peter.maydell@linaro.org>
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

From: Luc Michel <luc@lmichel.fr>

Add a clock input to the PL011 UART so we can compute the current baud
rate and trace it. This is intended for developers who wish to use QEMU
to e.g. debug their firmware or to figure out the baud rate configured
by an unknown/closed source binary.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Luc Michel <luc@lmichel.fr>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/char/pl011.h |  1 +
 hw/char/pl011.c         | 45 +++++++++++++++++++++++++++++++++++++++++
 hw/char/trace-events    |  1 +
 3 files changed, 47 insertions(+)

diff --git a/include/hw/char/pl011.h b/include/hw/char/pl011.h
index a91ea50e11b..33e5e5317b8 100644
--- a/include/hw/char/pl011.h
+++ b/include/hw/char/pl011.h
@@ -49,6 +49,7 @@ struct PL011State {
     int read_trigger;
     CharBackend chr;
     qemu_irq irq[6];
+    Clock *clk;
     const unsigned char *id;
 };
 
diff --git a/hw/char/pl011.c b/hw/char/pl011.c
index 13e784f9d90..ede16c781c9 100644
--- a/hw/char/pl011.c
+++ b/hw/char/pl011.c
@@ -22,6 +22,7 @@
 #include "hw/char/pl011.h"
 #include "hw/irq.h"
 #include "hw/sysbus.h"
+#include "hw/qdev-clock.h"
 #include "migration/vmstate.h"
 #include "chardev/char-fe.h"
 #include "qemu/log.h"
@@ -169,6 +170,25 @@ static void pl011_set_read_trigger(PL011State *s)
         s->read_trigger = 1;
 }
 
+static unsigned int pl011_get_baudrate(const PL011State *s)
+{
+    uint64_t clk;
+
+    if (s->fbrd == 0) {
+        return 0;
+    }
+
+    clk = clock_get_hz(s->clk);
+    return (clk / ((s->ibrd << 6) + s->fbrd)) << 2;
+}
+
+static void pl011_trace_baudrate_change(const PL011State *s)
+{
+    trace_pl011_baudrate_change(pl011_get_baudrate(s),
+                                clock_get_hz(s->clk),
+                                s->ibrd, s->fbrd);
+}
+
 static void pl011_write(void *opaque, hwaddr offset,
                         uint64_t value, unsigned size)
 {
@@ -198,9 +218,11 @@ static void pl011_write(void *opaque, hwaddr offset,
         break;
     case 9: /* UARTIBRD */
         s->ibrd = value;
+        pl011_trace_baudrate_change(s);
         break;
     case 10: /* UARTFBRD */
         s->fbrd = value;
+        pl011_trace_baudrate_change(s);
         break;
     case 11: /* UARTLCR_H */
         /* Reset the FIFO state on FIFO enable or disable */
@@ -286,12 +308,29 @@ static void pl011_event(void *opaque, QEMUChrEvent event)
         pl011_put_fifo(opaque, 0x400);
 }
 
+static void pl011_clock_update(void *opaque)
+{
+    PL011State *s = PL011(opaque);
+
+    pl011_trace_baudrate_change(s);
+}
+
 static const MemoryRegionOps pl011_ops = {
     .read = pl011_read,
     .write = pl011_write,
     .endianness = DEVICE_NATIVE_ENDIAN,
 };
 
+static const VMStateDescription vmstate_pl011_clock = {
+    .name = "pl011/clock",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_CLOCK(clk, PL011State),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static const VMStateDescription vmstate_pl011 = {
     .name = "pl011",
     .version_id = 2,
@@ -314,6 +353,10 @@ static const VMStateDescription vmstate_pl011 = {
         VMSTATE_INT32(read_count, PL011State),
         VMSTATE_INT32(read_trigger, PL011State),
         VMSTATE_END_OF_LIST()
+    },
+    .subsections = (const VMStateDescription * []) {
+        &vmstate_pl011_clock,
+        NULL
     }
 };
 
@@ -334,6 +377,8 @@ static void pl011_init(Object *obj)
         sysbus_init_irq(sbd, &s->irq[i]);
     }
 
+    s->clk = qdev_init_clock_in(DEVICE(obj), "clk", pl011_clock_update, s);
+
     s->read_trigger = 1;
     s->ifl = 0x12;
     s->cr = 0x300;
diff --git a/hw/char/trace-events b/hw/char/trace-events
index 609df10fed4..81026f66127 100644
--- a/hw/char/trace-events
+++ b/hw/char/trace-events
@@ -65,6 +65,7 @@ pl011_write(uint32_t addr, uint32_t value) "addr 0x%08x value 0x%08x"
 pl011_can_receive(uint32_t lcr, int read_count, int r) "LCR 0x%08x read_count %d returning %d"
 pl011_put_fifo(uint32_t c, int read_count) "new char 0x%x read_count now %d"
 pl011_put_fifo_full(void) "FIFO now full, RXFF set"
+pl011_baudrate_change(unsigned int baudrate, uint64_t clock, uint32_t ibrd, uint32_t fbrd) "new baudrate %u (clk: %" PRIu64 "hz, ibrd: %" PRIu32 ", fbrd: %" PRIu32 ")"
 
 # cmsdk-apb-uart.c
 cmsdk_apb_uart_read(uint64_t offset, uint64_t data, unsigned size) "CMSDK APB UART read: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u"
-- 
2.20.1



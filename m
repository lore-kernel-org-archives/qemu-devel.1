Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2B08C433E1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 13:06:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9967822DFA
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 13:06:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gbj3uSta"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9967822DFA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3fbc-0006RX-NH
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 09:06:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43796)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k3fYl-00024E-5y
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 09:03:51 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:45862)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k3fYj-00075v-7N
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 09:03:50 -0400
Received: by mail-wr1-x42e.google.com with SMTP id z18so40361056wrm.12
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2020 06:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=VKIjvjXxKAYQqyFjcIUepKDvVOUEUs0KY6aFq2gyyVA=;
 b=gbj3uStao4kU5RsxlA4SV8e9NFbI0t8nO4s3NRVwAzuG6ezqHr7WxMaLlrW17O61AL
 GMfKMtHb9PXCXWGlNnZSVmOyGE/mqYIjNji9JrG2zPzdi9PWuLSOLromXQf7pr84cszX
 n8kEDCVCameEYBHAQ4WXkNumz7PaL9KIPW7NWFJ04cx9TG7q5OkIsKC4rNPaX9TriXdi
 DTD92D4typv02jwj/CNSeFvbHVHBUdpai61Qt8zABqsALP9qdNsdV4bcgnFmjLbzrp0y
 BfbFaAzxxHjcxQ4prX9WTR3ZAsnYAoQGgBWL9PLuqw5HCKo4HnXp1XKE56n4t60xDFUM
 k3sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=VKIjvjXxKAYQqyFjcIUepKDvVOUEUs0KY6aFq2gyyVA=;
 b=hP5/BiRpXnFv4a0TrLCGSc92n1d1ZXJnzq3Nr5pZrFPSsYCeFHfSO7hBTff6I/VB05
 +0/6v50WyTnFX6cALsijWj+bCYxtmv9b8WMMorxlOPNJek3S1brRfS2qk1/5pBn5tCm0
 Ckg+xV5aOSrrmkcSy8M5kbb9AJNwbrhIhFhYiaGZ7a20D//q3jHOqTzRC4okCNMB5RTw
 JGVSkqaqcTdS2GTtxHY5R1iedH7Su+PHbAk1e4lin32xasLcJksbm4DcLXTKcNcZMzWx
 XFbvXh2yMKD5j/48LWmeJuyrUWLUaxjbvP1PKenrJRYWZ8hKVz5WmJlrMfCml75Mbwi0
 4jNA==
X-Gm-Message-State: AOAM5317HdWinHulTsbM+bw1V9g3UK5kmKTw2QplcyYyyy92l78QKkbV
 aB9c4jT5d8kYEo6o7QkF4BH7TlDB
X-Google-Smtp-Source: ABdhPJybIO4Z+Ee+scM4SpveWUiz8MskSKIB9XhUuufJDnpgrElvvAz7WKaH0LtWxFWGyMHGJJYoWQ==
X-Received: by 2002:adf:ca06:: with SMTP id o6mr7049091wrh.181.1596719027514; 
 Thu, 06 Aug 2020 06:03:47 -0700 (PDT)
Received: from localhost.localdomain (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id e16sm6409113wrx.30.2020.08.06.06.03.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2020 06:03:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.2 4/4] hw/char/serial: Use the Clock API to feed the
 UART reference clock
Date: Thu,  6 Aug 2020 15:03:40 +0200
Message-Id: <20200806130340.17316-5-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200806130340.17316-1-f4bug@amsat.org>
References: <20200806130340.17316-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x42e.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Damien Hedde <damien.hedde@greensocs.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In the same chipset, UARTs can be clocked at different rate, or the
input clock can be changed at runtime. The Clock API allow us to
propagate such clock rate change to the device.
Let the SerialState have its reference input clock (called 'rclk')
and if not clock is connected to the device, use the currently provided
frequency, to not modify the current code behavior.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/char/serial.h |  3 +++
 hw/char/serial.c         | 35 ++++++++++++++++++++++++++++-------
 2 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/include/hw/char/serial.h b/include/hw/char/serial.h
index 75c71adfd2..1c7a4df2ab 100644
--- a/include/hw/char/serial.h
+++ b/include/hw/char/serial.h
@@ -31,8 +31,10 @@
 #include "qemu/fifo8.h"
 #include "chardev/char.h"
 #include "hw/sysbus.h"
+#include "hw/clock.h"
 
 #define UART_FIFO_LENGTH    16      /* 16550A Fifo Length */
+#define UART_CLOCK_DIVISOR  16      /* baudrate is input clock / 16 */
 
 typedef struct SerialState {
     DeviceState parent;
@@ -57,6 +59,7 @@ typedef struct SerialState {
     qemu_irq irq;
     CharBackend chr;
     int last_break_enable;
+    Clock *rclk; /* ReceiverClock */
     uint32_t baudbase;
     uint32_t tsr_retry;
     guint watch_tag;
diff --git a/hw/char/serial.c b/hw/char/serial.c
index 2ddc73f255..701c670fd5 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -35,6 +35,7 @@
 #include "qemu/error-report.h"
 #include "trace.h"
 #include "hw/qdev-properties.h"
+#include "hw/qdev-clock.h"
 
 #define UART_LCR_DLAB	0x80	/* Divisor latch access bit */
 
@@ -921,10 +922,36 @@ static int serial_be_change(void *opaque)
     return 0;
 }
 
+/* Change the main reference oscillator frequency. */
+void serial_set_frequency(SerialState *s, uint32_t frequency)
+{
+    s->baudbase = frequency;
+    serial_update_parameters(s);
+}
+
+static void serial_rclk_update(void *opaque)
+{
+    SerialState *s = opaque;
+
+    serial_set_frequency(s, clock_get_hz(s->rclk) / UART_CLOCK_DIVISOR);
+}
+
+static void serial_init(Object *obj)
+{
+    SerialState *s = SERIAL(obj);
+
+    s->rclk = qdev_init_clock_in(DEVICE(obj), "rclk", serial_rclk_update, s);
+}
+
 static void serial_realize(DeviceState *dev, Error **errp)
 {
     SerialState *s = SERIAL(dev);
 
+    /* initialize the frequency in case the clock remains unconnected */
+    if (!clock_get(s->rclk)) {
+        clock_set_hz(s->rclk, s->baudbase);
+    }
+
     s->modem_status_poll = timer_new_ns(QEMU_CLOCK_VIRTUAL, (QEMUTimerCB *) serial_update_msl, s);
 
     s->fifo_timeout_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, (QEMUTimerCB *) fifo_timeout_int, s);
@@ -955,13 +982,6 @@ static void serial_unrealize(DeviceState *dev)
     qemu_unregister_reset(serial_reset, s);
 }
 
-/* Change the main reference oscillator frequency. */
-void serial_set_frequency(SerialState *s, uint32_t frequency)
-{
-    s->baudbase = frequency;
-    serial_update_parameters(s);
-}
-
 const MemoryRegionOps serial_io_ops = {
     .read = serial_ioport_read,
     .write = serial_ioport_write,
@@ -994,6 +1014,7 @@ static const TypeInfo serial_info = {
     .name = TYPE_SERIAL,
     .parent = TYPE_DEVICE,
     .instance_size = sizeof(SerialState),
+    .instance_init = serial_init,
     .class_init = serial_class_init,
 };
 
-- 
2.21.3



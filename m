Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13FDFC4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 17:43:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7C59222C6
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 17:43:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zf4hUEyt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7C59222C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDXnb-00020O-AI
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 13:43:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58837)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iDXgC-0004Nm-Q5
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 13:35:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iDXgB-0002qt-5M
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 13:35:48 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33788)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iDXgA-0002qV-Tm; Thu, 26 Sep 2019 13:35:47 -0400
Received: by mail-wr1-f66.google.com with SMTP id b9so3740463wrs.0;
 Thu, 26 Sep 2019 10:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0nYrEyIE8Ksn++8Q6sjUUjo6us9YPYxfJ0rmZNlZ6VA=;
 b=Zf4hUEytuT66Vk8Q/kLrnqWhVUdYRPo5txTb0r2vrCAptQk/xn1csbclZAYGxstLYP
 YLwqU5rG0W+Ww2cBreX8g5mYQjnOaSpCCMiwtoJIYVawHVI+XX/ntBfjt/790Uvli0Zp
 dHaYgYYhqWCS31UiNzTAVDH0N0x+UdopVoNa6cX6xvwAVJv2BUB2gZu4tK2q0e7IJ+Q4
 lFdEv6Kzyu4Os4ttvuqEcwoXhg4PWE81f4pvhng0sLcYzH77Djdom9qF8rsFhv/1BpCp
 hFA5ky1wXzqvxG+ozWVBGkpoaXRjL/eUQiL6OLfQXFjPk/zEKgl0DP2biBge+tbxb3g4
 WqQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=0nYrEyIE8Ksn++8Q6sjUUjo6us9YPYxfJ0rmZNlZ6VA=;
 b=lbWvouvlMx8sAJOGrcJOdKcVhK112fBEsBZEF7s/m4UotAMxEKEoiHOY9SdbkwMHF5
 X6YfgWi8a16RXxg+bNebh1zzqlWGbdhBt/VKjKSdygtlOWnWHMmyYAVLd6acQZ+CSmMp
 V/s2x8YZj5S23i6oKVwpURAXygifcD/FeKmTR1VT0iWcwPqcZg5LAVhZA+/L36bG5BMq
 xxTLi3zJ1di+daB3Xodwo9+Q+K1sw4WgN5vzg8EeHdpuYfTyXGdT8go203wgeAu1MCac
 L103OX9cH9waR9VPd3fpd5bjSWE/B5jqugTvQtot8dQG89IEBu0E/rYFDPNvXSBrHS+L
 jDWA==
X-Gm-Message-State: APjAAAVQL1BSqSShk7Ls30UAnn18SZdscYMK7IE0s6VJSTHXgpvqDlL4
 2ak+Tsm83LjhdaE7/8o0+nZFTaP1ioo=
X-Google-Smtp-Source: APXvYqxxaLT1w5lIln4IJ9CMskeEmmTd7HqbS80bDrPUp0A3ZHMbm7PhjTcOw2DxraJwYG8kbIwETA==
X-Received: by 2002:a5d:5642:: with SMTP id j2mr3980873wrw.345.1569519285785; 
 Thu, 26 Sep 2019 10:34:45 -0700 (PDT)
Received: from x1w.redhat.com (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id b186sm9918980wmd.16.2019.09.26.10.34.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2019 10:34:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 06/19] hw/char/bcm2835_aux: Add trace events
Date: Thu, 26 Sep 2019 19:34:14 +0200
Message-Id: <20190926173428.10713-7-f4bug@amsat.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190926173428.10713-1-f4bug@amsat.org>
References: <20190926173428.10713-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.66
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
 =?UTF-8?q?Zolt=C3=A1n=20Baldaszti?= <bztemail@gmail.com>,
 Laurent Bonnans <laurent.bonnans@here.com>,
 Esteban Bosse <estebanbosse@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org, Clement Deschamps <clement.deschamps@antfield.fr>,
 Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Cheng Xiang <ext-cheng.xiang@here.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Pekka Enberg <penberg@iki.fi>, Guenter Roeck <linux@roeck-us.net>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The BCM2835 AUX UART is compatible with the 16650 model, when
the registers belong the the 16650 block, use its trace events,
else use bcm2835_aux_read/write.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/char/bcm2835_aux.c | 55 +++++++++++++++++++++++++++++++------------
 hw/char/trace-events  |  4 ++++
 2 files changed, 44 insertions(+), 15 deletions(-)

diff --git a/hw/char/bcm2835_aux.c b/hw/char/bcm2835_aux.c
index a6fc1bf152..b26a255630 100644
--- a/hw/char/bcm2835_aux.c
+++ b/hw/char/bcm2835_aux.c
@@ -27,6 +27,7 @@
 #include "migration/vmstate.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
+#include "trace.h"
 
 #define AUX_IRQ         0x0
 #define AUX_ENABLES     0x4
@@ -62,17 +63,24 @@ static void bcm2835_aux_update(BCM2835AuxState *s)
     qemu_set_irq(s->irq, s->iir != 0);
 }
 
+static bool is_16650(hwaddr offset)
+{
+    return offset >= AUX_MU_IO_REG && offset < AUX_MU_CNTL_REG;
+}
+
 static uint64_t bcm2835_aux_read(void *opaque, hwaddr offset, unsigned size)
 {
     BCM2835AuxState *s = opaque;
-    uint32_t c, res;
+    uint32_t c, res = 0;
 
     switch (offset) {
     case AUX_IRQ:
-        return s->iir != 0;
+        res = s->iir != 0;
+        break;
 
     case AUX_ENABLES:
-        return 1; /* mini UART permanently enabled */
+        res = 1; /* mini UART permanently enabled */
+        break;
 
     case AUX_MU_IO_REG:
         /* "DLAB bit set means access baudrate register" is NYI */
@@ -85,11 +93,13 @@ static uint64_t bcm2835_aux_read(void *opaque, hwaddr offset, unsigned size)
         }
         qemu_chr_fe_accept_input(&s->chr);
         bcm2835_aux_update(s);
-        return c;
+        res = c;
+        break;
 
     case AUX_MU_IER_REG:
         /* "DLAB bit set means access baudrate register" is NYI */
-        return 0xc0 | s->ier; /* FIFO enables always read 1 */
+        res = 0xc0 | s->ier; /* FIFO enables always read 1 */
+        break;
 
     case AUX_MU_IIR_REG:
         res = 0xc0; /* FIFO enables */
@@ -105,33 +115,34 @@ static uint64_t bcm2835_aux_read(void *opaque, hwaddr offset, unsigned size)
         if (s->iir == 0) {
             res |= 0x1;
         }
-        return res;
+        break;
 
     case AUX_MU_LCR_REG:
         qemu_log_mask(LOG_UNIMP, "%s: AUX_MU_LCR_REG unsupported\n", __func__);
-        return 0;
+        break;
 
     case AUX_MU_MCR_REG:
         qemu_log_mask(LOG_UNIMP, "%s: AUX_MU_MCR_REG unsupported\n", __func__);
-        return 0;
+        break;
 
     case AUX_MU_LSR_REG:
         res = 0x60; /* tx idle, empty */
         if (s->read_count != 0) {
             res |= 0x1;
         }
-        return res;
+        break;
 
     case AUX_MU_MSR_REG:
         qemu_log_mask(LOG_UNIMP, "%s: AUX_MU_MSR_REG unsupported\n", __func__);
-        return 0;
+        break;
 
     case AUX_MU_SCRATCH:
         qemu_log_mask(LOG_UNIMP, "%s: AUX_MU_SCRATCH unsupported\n", __func__);
-        return 0;
+        break;
 
     case AUX_MU_CNTL_REG:
-        return 0x3; /* tx, rx enabled */
+        res = 0x3; /* tx, rx enabled */
+        break;
 
     case AUX_MU_STAT_REG:
         res = 0x30e; /* space in the output buffer, empty tx fifo, idle tx/rx */
@@ -140,17 +151,25 @@ static uint64_t bcm2835_aux_read(void *opaque, hwaddr offset, unsigned size)
             assert(s->read_count < BCM2835_AUX_RX_FIFO_LEN);
             res |= ((uint32_t)s->read_count) << 16; /* rx fifo fill level */
         }
-        return res;
+        break;
 
     case AUX_MU_BAUD_REG:
         qemu_log_mask(LOG_UNIMP, "%s: AUX_MU_BAUD_REG unsupported\n", __func__);
-        return 0;
+        break;
 
     default:
         qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset %"HWADDR_PRIx"\n",
                       __func__, offset);
-        return 0;
+        break;
     }
+
+    if (is_16650(offset)) {
+        trace_serial_ioport_read((offset & 0x1f) >> 2, res);
+    } else {
+        trace_bcm2835_aux_read(offset, res);
+    }
+
+    return res;
 }
 
 static void bcm2835_aux_write(void *opaque, hwaddr offset, uint64_t value,
@@ -159,6 +178,12 @@ static void bcm2835_aux_write(void *opaque, hwaddr offset, uint64_t value,
     BCM2835AuxState *s = opaque;
     unsigned char ch;
 
+    if (is_16650(offset)) {
+        trace_serial_ioport_write((offset & 0x1f) >> 2, value);
+    } else {
+        trace_bcm2835_aux_write(offset, value);
+    }
+
     switch (offset) {
     case AUX_ENABLES:
         if (value != 1) {
diff --git a/hw/char/trace-events b/hw/char/trace-events
index 2ce7f2f998..a7d477ab1e 100644
--- a/hw/char/trace-events
+++ b/hw/char/trace-events
@@ -1,5 +1,9 @@
 # See docs/devel/tracing.txt for syntax documentation.
 
+# bcm2835_aux.c
+bcm2835_aux_read(uint64_t addr, uint32_t value) "read addr 0x%"PRIx64" value 0x%x"
+bcm2835_aux_write(uint64_t addr, uint32_t value) "read addr 0x%"PRIx64" value 0x%x"
+
 # parallel.c
 parallel_ioport_read(const char *desc, uint16_t addr, uint8_t value) "read [%s] addr 0x%02x val 0x%02x"
 parallel_ioport_write(const char *desc, uint16_t addr, uint8_t value) "write [%s] addr 0x%02x val 0x%02x"
-- 
2.20.1



Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20471C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 13:05:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A5102310B
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 13:05:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OxntN/fr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A5102310B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3faC-0003g5-Ru
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 09:05:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43778)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k3fYj-00021C-LN
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 09:03:49 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:55265)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k3fYh-00075h-Vl
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 09:03:49 -0400
Received: by mail-wm1-x32f.google.com with SMTP id d190so8762232wmd.4
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2020 06:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=jHazVKWFQG1I08UcXdjElA+M/Buk1PGFWVHhWqdyCtk=;
 b=OxntN/frcBHNx9b5cwy3rKuCoSvXn51ubG8pstgF3YXZuBtISYwHoOLiVeUBGgse/q
 +cGh5xQ+lBm/yyw0Mh8BkfXuZYGn7E2cSQCvgBu83fTVGZFpEHG98dZerhGHYOANbUBR
 I4vfAPhkC9nowWg+qNOi0/7Jx6NANhTxkdOF/oCYYDmIHgOBpBDDoPx0GrAoWhLpd/iw
 v9avX52qYp5vR32Gl4R9tSP27xTYk87kQo0wK5tmdPv79b1V5TJi26mnsWTNGe5RJOg+
 qMaH2z0c9oASXiCNBhUCQY0k9/JWjJGOy8EMcYTmG0gY+kexfzuT0biV4sG6p7pMftgL
 EtZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=jHazVKWFQG1I08UcXdjElA+M/Buk1PGFWVHhWqdyCtk=;
 b=bhhWetnnKszTDiDbuRS9Vk8Z4k1176x+WQORKrBLQByPmakYbSLruM5WqXXZndWgg6
 JDRebNKLsCaaAyhVL6CbE1kd9tynk1PIst4Gh0lGTUWvLLBq5fu6vvEkNdxCy0+RmL8d
 cN2QdBIunvpwftxt9X29abzJRBUPDposGuF6eTzwC9fpJy/cq5rU65aMO8PdcwTg1Nd1
 x90V3ae1GlrG7fdv2KRB3X6SGgY8JZTUuYza7zxC3ZfuIuJCTt2KESiKz4LDWOW+SR0V
 HiVnCMYQNkf3QV3vCuDvrNEKCQYKVfXQskFeJuh2G+6l2HLtCWIC+GGripLV/7BAJxwd
 6l1A==
X-Gm-Message-State: AOAM530grizzBzW45AAmPndvvqWyNsOXReltkTwuxwiTHOHfvBUrIR8i
 aMgKgyvUhNcEugzAFmzdZCF6KtZ+
X-Google-Smtp-Source: ABdhPJxir/XrswmUGJUuuDpyr1NHomRH+s47nQon2K/yUgSexWCGRkT30fVaZb2nEi2s8QZq93TxMg==
X-Received: by 2002:a7b:c4d3:: with SMTP id g19mr7657522wmk.29.1596719025811; 
 Thu, 06 Aug 2020 06:03:45 -0700 (PDT)
Received: from localhost.localdomain (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id e16sm6409113wrx.30.2020.08.06.06.03.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2020 06:03:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.2 3/4] hw/char/serial: Let SerialState have an 'id' field
Date: Thu,  6 Aug 2020 15:03:39 +0200
Message-Id: <20200806130340.17316-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200806130340.17316-1-f4bug@amsat.org>
References: <20200806130340.17316-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x32f.google.com
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

When a SoC has multiple UARTs (some configured differently),
it is hard to associate events to their UART.

To be able to distinct trace events between various instances,
add an 'id' field. Update the trace format accordingly.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/char/serial.h | 1 +
 hw/char/serial.c         | 7 ++++---
 hw/char/trace-events     | 6 +++---
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/include/hw/char/serial.h b/include/hw/char/serial.h
index 81d7ba1917..75c71adfd2 100644
--- a/include/hw/char/serial.h
+++ b/include/hw/char/serial.h
@@ -75,6 +75,7 @@ typedef struct SerialState {
     uint64_t char_transmit_time;    /* time to transmit a char in ticks */
     int poll_msl;
 
+    uint8_t id;
     QEMUTimer *modem_status_poll;
     MemoryRegion io;
 } SerialState;
diff --git a/hw/char/serial.c b/hw/char/serial.c
index 758a3aa49b..2ddc73f255 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -177,7 +177,7 @@ static void serial_update_parameters(SerialState *s)
     ssp.stop_bits = stop_bits;
     s->char_transmit_time =  (NANOSECONDS_PER_SECOND / speed) * frame_size;
     qemu_chr_fe_ioctl(&s->chr, CHR_IOCTL_SERIAL_SET_PARAMS, &ssp);
-    trace_serial_update_parameters(speed, parity, data_bits, stop_bits);
+    trace_serial_update_parameters(s->id, speed, parity, data_bits, stop_bits);
 }
 
 static void serial_update_msl(SerialState *s)
@@ -333,7 +333,7 @@ static void serial_ioport_write(void *opaque, hwaddr addr, uint64_t val,
     SerialState *s = opaque;
 
     addr &= 7;
-    trace_serial_ioport_write(addr, val);
+    trace_serial_ioport_write(s->id, addr, val);
     switch(addr) {
     default:
     case 0:
@@ -550,7 +550,7 @@ static uint64_t serial_ioport_read(void *opaque, hwaddr addr, unsigned size)
         ret = s->scr;
         break;
     }
-    trace_serial_ioport_read(addr, ret);
+    trace_serial_ioport_read(s->id, addr, ret);
     return ret;
 }
 
@@ -973,6 +973,7 @@ const MemoryRegionOps serial_io_ops = {
 };
 
 static Property serial_properties[] = {
+    DEFINE_PROP_UINT8("id", SerialState, id, 0),
     DEFINE_PROP_CHR("chardev", SerialState, chr),
     DEFINE_PROP_UINT32("baudbase", SerialState, baudbase, 115200),
     DEFINE_PROP_END_OF_LIST(),
diff --git a/hw/char/trace-events b/hw/char/trace-events
index 85e39d9d62..04a6fb4a15 100644
--- a/hw/char/trace-events
+++ b/hw/char/trace-events
@@ -5,9 +5,9 @@ parallel_ioport_read(const char *desc, uint16_t addr, uint8_t value) "read [%s]
 parallel_ioport_write(const char *desc, uint16_t addr, uint8_t value) "write [%s] addr 0x%02x val 0x%02x"
 
 # serial.c
-serial_ioport_read(uint16_t addr, uint8_t value) "read addr 0x%02x val 0x%02x"
-serial_ioport_write(uint16_t addr, uint8_t value) "write addr 0x%02x val 0x%02x"
-serial_update_parameters(uint64_t baudrate, char parity, int data_bits, int stop_bits) "baudrate=%"PRIu64" parity='%c' data=%d stop=%d"
+serial_ioport_read(uint8_t id, uint16_t addr, uint8_t value) "id#%u read addr 0x%02x val 0x%02x"
+serial_ioport_write(uint8_t id, uint16_t addr, uint8_t value) "id#%u write addr 0x%02x val 0x%02x"
+serial_update_parameters(uint8_t id, uint64_t baudrate, char parity, int data_bits, int stop_bits) "id#%u baudrate=%"PRIu64" parity=%c data=%d stop=%d"
 
 # virtio-serial-bus.c
 virtio_serial_send_control_event(unsigned int port, uint16_t event, uint16_t value) "port %u, event %u, value %u"
-- 
2.21.3



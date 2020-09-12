Return-Path: <SRS0=E5X6=CV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 266C1C43461
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 11:45:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B261721548
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 11:45:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gv8ltJMU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B261721548
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kH3y4-00086C-QB
	for qemu-devel@archiver.kernel.org; Sat, 12 Sep 2020 07:45:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53584)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kH3tm-0001SF-Cd; Sat, 12 Sep 2020 07:40:54 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:41087)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kH3tk-0000UK-Rs; Sat, 12 Sep 2020 07:40:54 -0400
Received: by mail-wr1-x42c.google.com with SMTP id w5so13892229wrp.8;
 Sat, 12 Sep 2020 04:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=35kCXBDtnMec8kuPKS3wvw6fy2OiC9y7NvX9kclUQjI=;
 b=gv8ltJMU8gV6Y02r9nk0SvAUp9rw6fxRnmqomBT/gBt0StIou5U9UK+PfPcV8xPE2q
 C5l7mnNwx1J4ny1HQKlUvipYxK60P7LUN2o224YZ/kF4Q7UBtWVAFOZ25NTbbUa99X6s
 ZesuLFPAKVHbpx14Qj/+jRKC5PBBxAQSwoXXLihY+KDqWeLLvo8lazZFG9x6qSwJft2o
 z6rt2Xi9jU+kLH8QG8OuUR2cTbPZtLZI6P30lThSf3baw9iAUsD2wTLFLyHkB5UT3L/g
 R5IbnF+crqkf0K2h5LfI88N6esfxxbyC9oh1g63VDB7zCr7PWJzcA1ZzPigFOh4vO5cd
 ix5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=35kCXBDtnMec8kuPKS3wvw6fy2OiC9y7NvX9kclUQjI=;
 b=KDdz5/lEjNqbf42m6EtaAOu6xJnI6FmpjaqBMiE1l/vSX2cdXZVjQRoRVyDI7y0p5a
 +7dg1QX42EvhLMf+KsolZMg1PQ52rkKSANIDScpq/5hKjPKbO7sRdS/EbvePtzsMphGE
 WcT9RP2apPXpOZo1ct4TwrL41tXz/9iAGKCu+zIvdKfDhrC5Kz8H4XE78tlpoN64k8vc
 WfwHzH5ie3b7P/i/BrX3SndCjt/8suX59CmoHUnE/0XSqNPlABqHOAdXNZ9Mwv/BVOeM
 3x488yZtM+XWgt93/r9HVQP2GPMOtXfZOYJdclaE50fpbR1qqVSbDtsw5rm5fBDlP2vp
 ouwA==
X-Gm-Message-State: AOAM533veYwpNhReRJxBZsExQWbJgWBkgweSje7Zk3l9cO0I95eAdYKh
 sZjraabecjz00Fm2SvWOBGE=
X-Google-Smtp-Source: ABdhPJxMSZRTKYXxVtJ45ZoIyzmkLQCLLNdSmvGlRtXypDArkBdhgPKu5akuYxeiwaiZpCTfpzW6VA==
X-Received: by 2002:a05:6000:12c3:: with SMTP id
 l3mr6864624wrx.164.1599910851330; 
 Sat, 12 Sep 2020 04:40:51 -0700 (PDT)
Received: from localhost.localdomain (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id h6sm9373895wmb.22.2020.09.12.04.40.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2020 04:40:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: Paolo Bonzini <pbonzini@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 7/7] hw/char/serial: Let SerialState have an 'id' field
Date: Sat, 12 Sep 2020 13:40:40 +0200
Message-Id: <20200912114040.918464-8-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200912114040.918464-1-f4bug@amsat.org>
References: <20200912114040.918464-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x42c.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
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
Cc: qemu-trivial@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When a SoC has multiple UARTs (some configured differently),
it is hard to associate events to their UART.

To be able to distinct trace events between various instances,
add an 'id' field. Update the trace format accordingly.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/char/serial.h   | 1 +
 hw/char/serial-pci-multi.c | 1 +
 hw/char/serial.c           | 7 ++++---
 hw/char/trace-events       | 6 +++---
 4 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/include/hw/char/serial.h b/include/hw/char/serial.h
index 09845721384..a0aaa319a93 100644
--- a/include/hw/char/serial.h
+++ b/include/hw/char/serial.h
@@ -76,6 +76,7 @@ struct SerialState {
     uint64_t char_transmit_time;    /* time to transmit a char in ticks */
     int poll_msl;
 
+    uint8_t id;
     QEMUTimer *modem_status_poll;
     MemoryRegion io;
 };
diff --git a/hw/char/serial-pci-multi.c b/hw/char/serial-pci-multi.c
index 2cf3e441773..53e0c6e25c0 100644
--- a/hw/char/serial-pci-multi.c
+++ b/hw/char/serial-pci-multi.c
@@ -105,6 +105,7 @@ static void multi_serial_pci_realize(PCIDevice *dev, Error **errp)
 
     for (i = 0; i < nports; i++) {
         s = pci->state + i;
+        qdev_prop_set_uint8(s, "id", i);
         if (!qdev_realize(DEVICE(s), NULL, errp)) {
             multi_serial_pci_exit(dev);
             return;
diff --git a/hw/char/serial.c b/hw/char/serial.c
index ade89fadb44..e5a6b939f13 100644
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
 
     assert(size == 1 && addr < 8);
-    trace_serial_write(addr, val);
+    trace_serial_write(s->id, addr, val);
     switch(addr) {
     default:
     case 0:
@@ -550,7 +550,7 @@ static uint64_t serial_ioport_read(void *opaque, hwaddr addr, unsigned size)
         ret = s->scr;
         break;
     }
-    trace_serial_read(addr, ret);
+    trace_serial_read(s->id, addr, ret);
     return ret;
 }
 
@@ -1013,6 +1013,7 @@ static const TypeInfo serial_io_info = {
 };
 
 static Property serial_properties[] = {
+    DEFINE_PROP_UINT8("id", SerialState, id, 0),
     DEFINE_PROP_CHR("chardev", SerialState, chr),
     DEFINE_PROP_UINT32("baudbase", SerialState, baudbase, 115200),
     DEFINE_PROP_BOOL("wakeup", SerialState, wakeup, false),
diff --git a/hw/char/trace-events b/hw/char/trace-events
index 609df10fed4..45b8eaab655 100644
--- a/hw/char/trace-events
+++ b/hw/char/trace-events
@@ -5,9 +5,9 @@ parallel_ioport_read(const char *desc, uint16_t addr, uint8_t value) "read [%s]
 parallel_ioport_write(const char *desc, uint16_t addr, uint8_t value) "write [%s] addr 0x%02x val 0x%02x"
 
 # serial.c
-serial_read(uint16_t addr, uint8_t value) "read addr 0x%02x val 0x%02x"
-serial_write(uint16_t addr, uint8_t value) "write addr 0x%02x val 0x%02x"
-serial_update_parameters(uint64_t baudrate, char parity, int data_bits, int stop_bits) "baudrate=%"PRIu64" parity='%c' data=%d stop=%d"
+serial_read(uint8_t id, uint8_t addr, uint8_t value) "id#%u read addr 0x%x val 0x%02x"
+serial_write(uint8_t id, uint8_t addr, uint8_t value) "id#%u write addr 0x%x val 0x%02x"
+serial_update_parameters(uint8_t id, uint64_t baudrate, char parity, int data_bits, int stop_bits) "id#%u baudrate=%"PRIu64" parity=%c data=%d stop=%d"
 
 # virtio-serial-bus.c
 virtio_serial_send_control_event(unsigned int port, uint16_t event, uint16_t value) "port %u, event %u, value %u"
-- 
2.26.2



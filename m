Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32E65C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 16:40:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1601204EA
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 16:40:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VHg+ziTN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1601204EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6cl4-0005i8-4a
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 12:40:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46608)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k6cjw-0004Jw-HZ
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 12:39:36 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:54590)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k6cjv-0002Ku-1w
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 12:39:36 -0400
Received: by mail-wm1-x343.google.com with SMTP id d190so7976414wmd.4
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2020 09:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0dlRp7G2rkzZ9KDPViPaK9mH4rIwxMLs+qxgigKBCp8=;
 b=VHg+ziTNXZz1jQ++4vGHYMj93us0h/267iBBSq7VQuFFuegT2RqEF8PWEHv/uu69Z1
 9DSyIKHbXgkOdnFcPX91UygwLXHIYQQdrvG25tR9O+91e4/qDUrDlbmkcuRqDSVNu1NU
 OLQiWj3moO6w49Bo9e1Q5KhrfcQqoMZeKx9CSShxSKsnDWyqlH9Tknyl3IpKsL2RYoHk
 oIjREVc0vZHh7M9Y7mw1BVuFRXG++esjIkYb+/duYuwY4uOGxQDSrsiOQCqt6pXjB1Bn
 f7jj1vKanOfHlvMcO8Gf7JnaiUep2jT7Gd/Q1sG2zLY9MlGwrBXLQViibQ/j6SOe93H6
 0NVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=0dlRp7G2rkzZ9KDPViPaK9mH4rIwxMLs+qxgigKBCp8=;
 b=MtyPNRlJlhRyGRt0LEvw/qBczz2NfZla6z/tyCfa4kL5JWKqoVcTOpbeZeE2Khn6pE
 br3xDb+Gx51tKWN37SOKlFW9LompKRP/Jj6CQNLNrN1aT02hz8kcCdNmD7K1Ap5E6wKg
 tJ8nc19zY5XQT5m0bSNCI+/oaJjJumfr3z+nN0n09RF2pnTHcEue8F1HsyuZ6c+Qffvw
 zp6AjvBs9jZnfyNsMPIFKVZNaeDJutXHN/EOvfcsIaAtInEn0JRmCgW4Y+v6xHGw9Dga
 181Fum0WjIyLmqZDUEXo2Gfq/mcRgb3BXnZ1SFOTuI/RfP74BRDg6VDw9rLjEomS02wF
 3ArA==
X-Gm-Message-State: AOAM532Kgqiaa/6MOzgssmeVgOz6Xg92uWM9i3+CI+UCLLbfkXY1d54R
 vhZqFHtwgzjiUTKqrCprQot8Qnzi3d0=
X-Google-Smtp-Source: ABdhPJxMiq7fs9hAKHJ0llIiVOoq2yqbOO7j5Qx9Z121H+Xwgs9sVoiQ4Am5VHRcyF/pFWnnyqYSew==
X-Received: by 2002:a1c:4e10:: with SMTP id g16mr3055081wmh.146.1597423173515; 
 Fri, 14 Aug 2020 09:39:33 -0700 (PDT)
Received: from localhost.localdomain (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id p14sm18417178wrg.96.2020.08.14.09.39.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2020 09:39:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 5/5] hw/char/avr_usart: Trace baudrate changes
Date: Fri, 14 Aug 2020 18:39:24 +0200
Message-Id: <20200814163924.11662-6-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200814163924.11662-1-f4bug@amsat.org>
References: <20200814163924.11662-1-f4bug@amsat.org>
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
Cc: Sarah Harris <S.E.Harris@kent.ac.uk>, Thomas Huth <huth@tuxfamily.org>,
 Joaquin de Andres <me@xcancerberox.com.ar>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Michael Rolnik <mrolnik@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add a trace event to track baudrate changes.

Example when running the FreeRTOS acceptance test [1]:

  $ qemu-system-avr -machine arduino-mega-2560-v3 -bios demo.elf -trace avr\*
  2546@1597415281.399619:avr_usart_update_baudrate baudrate 0x0019 (38461 bauds)
  2546@1597415281.400029:avr_usart_update_baudrate baudrate 0x0019 (38461 bauds)

Which confirm the definition from the test [2]:

  #define mainCOM_TEST_BAUD_RATE        ( ( unsigned long ) 38400 )

[1] tests/acceptance/machine_avr6.py
[2] https://github.com/seharris/qemu-avr-tests/blob/9c0c24da1b1/free-rtos/Demo/AVR_ATMega2560_GCC/main.c#L80

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/char/avr_usart.c  | 13 +++++++++++++
 hw/char/trace-events |  3 +++
 2 files changed, 16 insertions(+)

diff --git a/hw/char/avr_usart.c b/hw/char/avr_usart.c
index 4a43492082..176158a96b 100644
--- a/hw/char/avr_usart.c
+++ b/hw/char/avr_usart.c
@@ -25,6 +25,7 @@
 #include "hw/irq.h"
 #include "hw/qdev-clock.h"
 #include "hw/qdev-properties.h"
+#include "trace.h"
 
 /* Offsets of registers. */
 #define USART_DR   0x06
@@ -56,6 +57,8 @@
 #define USART_CSRC_CSZ1   (1 << 2)
 #define USART_CSRC_CSZ0   (1 << 1)
 
+#define USART_CLOCK_DIVISOR  16      /* baudrate is input clock / 16 */
+
 static int avr_usart_can_receive(void *opaque)
 {
     AVRUsartState *usart = opaque;
@@ -120,6 +123,14 @@ static void update_char_mask(AVRUsartState *usart)
     }
 }
 
+static void avr_usart_update_baudrate(AVRUsartState *s)
+{
+    unsigned baudrate = (clock_get_hz(s->clkin) / USART_CLOCK_DIVISOR)
+                        / (((s->brrh << 8) | s->brrl) + 1);
+
+    trace_avr_usart_update_baudrate((s->brrh << 8) | s->brrl, baudrate);
+}
+
 static void avr_usart_reset(DeviceState *dev)
 {
     AVRUsartState *usart = AVR_USART(dev);
@@ -269,9 +280,11 @@ static void avr_usart_write(void *opaque, hwaddr addr, uint64_t value,
         break;
     case USART_BRRL:
         usart->brrl = value;
+        avr_usart_update_baudrate(usart);
         break;
     case USART_BRRH:
         usart->brrh = value & 0b00001111;
+        avr_usart_update_baudrate(usart);
         break;
     default:
         qemu_log_mask(
diff --git a/hw/char/trace-events b/hw/char/trace-events
index d20eafd56f..b92cecbfaa 100644
--- a/hw/char/trace-events
+++ b/hw/char/trace-events
@@ -100,3 +100,6 @@ exynos_uart_rx_timeout(uint32_t channel, uint32_t stat, uint32_t intsp) "UART%d:
 
 # hw/char/cadence_uart.c
 cadence_uart_baudrate(unsigned baudrate) "baudrate %u"
+
+# avr_usart.c
+avr_usart_update_baudrate(uint16_t regval, unsigned baudrate) "baudrate 0x%04x (%u bauds)"
-- 
2.21.3



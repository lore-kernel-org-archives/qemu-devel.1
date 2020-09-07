Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DA4BC43461
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 01:57:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC7CE20796
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 01:57:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ATpKEDrJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC7CE20796
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kF6P0-0007lM-Qc
	for qemu-devel@archiver.kernel.org; Sun, 06 Sep 2020 21:57:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59798)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kF6Nk-00061i-1G; Sun, 06 Sep 2020 21:55:44 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:41857)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kF6Ni-0007Ij-GG; Sun, 06 Sep 2020 21:55:43 -0400
Received: by mail-wr1-x443.google.com with SMTP id w5so14073618wrp.8;
 Sun, 06 Sep 2020 18:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=JF7kT9Jakz5MXZ7s85w029ixb/+6fikTUFTZrRv4yoU=;
 b=ATpKEDrJ7K9awH1N2zYTl4yBM9vwgdywoDL8jJwFb0map4kJ1wW5Z6SzgmkBLz6Di1
 4+J89Zkp0QYSl/r/M91ckYgeDfnshUAdYUAwDZ3jkVqeaC5CbtrEPPKLwoHihsv1pcmG
 /tyiLuSpV9SCW9XFjVC1ifDvER1j9gedYUd1vK1QWQQd4onN5NYyUXPI2KEj/go04Yhp
 Zr4ScnsbSukE3j4I63uUQDzIW1OJlr7uwAlYA0kUv7ChD/LtZbe1m1F/jpYDX6ESedGO
 IOu21GsUwvi4leEM8WIe359yXNL2rInLotpGuyvnwuKHnGyQ7xGMCL0gsnLrsUJsCRX9
 EmEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=JF7kT9Jakz5MXZ7s85w029ixb/+6fikTUFTZrRv4yoU=;
 b=SaL2epDMLbMH9lxA9jrmyp18KQcN05ZMmyMh5myK5LMe5IuYjfDqKlczerMFS/oDFR
 fVz8cQLWWqs0dLPdt3UdaD6VP5Ku7cMR7PlFGAIEFbks/56aTDNnX3EWNubTV24ulb+i
 fHhbHphWn4p3DZeisWM/hyxprBPsdunG06YiabKlOUO9eyP4CXLjLlLo2Yn4F/vxg5bQ
 Wolw8peyTVTp2NCCSes9ffAroyNpbCYoWvc+TG9VriqysPd4cJoh9qzrLhvufgC4ZY6m
 7mtsw6d1WwVmL4eSISpXSGLNESOdDlT6kYT2Ws93rpotNUSgM9+K4n06ToGCx8xAaYbY
 6EGg==
X-Gm-Message-State: AOAM5319pFsUpiYwZDYpJOC5J3G0pnXARzdqHteMs/UeZk6cEnkfIbFw
 ZlPkgpgSffaBPqokObHAkIkOgt7zQh0=
X-Google-Smtp-Source: ABdhPJxdbJIbUhDSxyWa3OoBkrlsOphRHXMZU37nN6v0gCouNh4gRK5/N8Tw4mT/s7687uE4t+h37Q==
X-Received: by 2002:adf:dfd1:: with SMTP id q17mr21031760wrn.347.1599443740620; 
 Sun, 06 Sep 2020 18:55:40 -0700 (PDT)
Received: from localhost.localdomain (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id b84sm29377773wmd.0.2020.09.06.18.55.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Sep 2020 18:55:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/7] hw/char/serial: Replace commented DPRINTF() by trace event
Date: Mon,  7 Sep 2020 03:55:30 +0200
Message-Id: <20200907015535.827885-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200907015535.827885-1-f4bug@amsat.org>
References: <20200907015535.827885-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-trivial@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Convert the old debug PRINTF() call to display the UART
baudrate to a trace event.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/char/serial.c     | 4 +---
 hw/char/trace-events | 1 +
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/char/serial.c b/hw/char/serial.c
index a855ef66ea2..fb41337b661 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -187,9 +187,7 @@ static void serial_update_parameters(SerialState *s)
     ssp.stop_bits = stop_bits;
     s->char_transmit_time =  (NANOSECONDS_PER_SECOND / speed) * frame_size;
     qemu_chr_fe_ioctl(&s->chr, CHR_IOCTL_SERIAL_SET_PARAMS, &ssp);
-
-    DPRINTF("speed=%.2f parity=%c data=%d stop=%d\n",
-           speed, parity, data_bits, stop_bits);
+    trace_serial_update_parameters(speed, parity, data_bits, stop_bits);
 }
 
 static void serial_update_msl(SerialState *s)
diff --git a/hw/char/trace-events b/hw/char/trace-events
index d20eafd56f8..85e39d9d62b 100644
--- a/hw/char/trace-events
+++ b/hw/char/trace-events
@@ -7,6 +7,7 @@ parallel_ioport_write(const char *desc, uint16_t addr, uint8_t value) "write [%s
 # serial.c
 serial_ioport_read(uint16_t addr, uint8_t value) "read addr 0x%02x val 0x%02x"
 serial_ioport_write(uint16_t addr, uint8_t value) "write addr 0x%02x val 0x%02x"
+serial_update_parameters(uint64_t baudrate, char parity, int data_bits, int stop_bits) "baudrate=%"PRIu64" parity='%c' data=%d stop=%d"
 
 # virtio-serial-bus.c
 virtio_serial_send_control_event(unsigned int port, uint16_t event, uint16_t value) "port %u, event %u, value %u"
-- 
2.26.2



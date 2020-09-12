Return-Path: <SRS0=E5X6=CV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A6C0C43461
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 11:42:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34F3421548
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 11:42:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O8YRdEkX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34F3421548
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kH3v8-0003XC-5D
	for qemu-devel@archiver.kernel.org; Sat, 12 Sep 2020 07:42:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53528)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kH3th-0001Pf-8f; Sat, 12 Sep 2020 07:40:49 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:34009)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kH3tf-0000TA-Ce; Sat, 12 Sep 2020 07:40:48 -0400
Received: by mail-wm1-x341.google.com with SMTP id l15so2759774wmh.1;
 Sat, 12 Sep 2020 04:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=cjPhR7IkpYLtqYuSQXOeOWy0Y3FOG5E14Z0Rs7drrRo=;
 b=O8YRdEkXWNjoNtmpWnTI2O2/pyOgp4edHqysBRyDq66zwFGdaLEgaWPxzgr0uOH9cG
 T0+fOtFD+A2UsnZRVIRIbatk2XInbyhECywtGy++xp5BcyteRzuyxEUzags0mVik4Y8F
 gphqz1dPLcWyNn8XtBYMvJ/z2343OFeMxI0JJ4bPp3CtU2zLvtqSGXL2fb2rW82fHSAG
 PcGl5XbsbBRqhby59hWsI4q5QkBw0d/Xu11t1+sJGQw4ZxgnLNTZ/+xsMS9XF5w4qX4m
 grYvjL9x48G+7RbvTtmC1u8gnMuTPFcTSbpVDhcmewf9kdUFsIsmHpdEJuClS0f2YZaj
 k3ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=cjPhR7IkpYLtqYuSQXOeOWy0Y3FOG5E14Z0Rs7drrRo=;
 b=KEDH8sTrzwbs/nFpyaGTlL6SafHk/pYGqmKJ3NkljnzOB8Rx4+v3GdZGa0C8hmCUic
 t2JRSa0PQeS0yP9AGtoNsw9H2sot+EL8+APk+3tMH/cybvV3zNGNC4bsFd6MVQqbFhY9
 IhJotHJ9oih4NTmUadvC4p1g/iE0kMvxZH0KnJc9s3vaSWTnsg6G7w+wjX5JYy23bR4+
 iliYSLki3jouzJTVXiq8Eae9cotw6I1nFMBnKxc0iEkl/T13vsdk/L0WUTuQNoLTJevy
 IK+GPvd9hIqhEM3jWkL7k0/gWS/rxnoYF/LPQgWoPgiiKw2mjiiVwEMZnshjSmYUPF+O
 GfBw==
X-Gm-Message-State: AOAM532oAVlwBIHDkPog96a4+1E5ZO69fFd687HY2mfdWCG0bqT6/Uqo
 PNYGJTtOTIokPpWBOhNCoZ8=
X-Google-Smtp-Source: ABdhPJzTIhb57qOmta0EIxYkO2MBw9vnBPaze/OsjXLZv8ICZW8A9vFz+LOvR9ZIVc1l4wcW6KR+Ug==
X-Received: by 2002:a1c:7c13:: with SMTP id x19mr6751152wmc.45.1599910845264; 
 Sat, 12 Sep 2020 04:40:45 -0700 (PDT)
Received: from localhost.localdomain (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id h6sm9373895wmb.22.2020.09.12.04.40.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2020 04:40:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: Paolo Bonzini <pbonzini@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 2/7] hw/char/serial: Replace commented DPRINTF() by trace
 event
Date: Sat, 12 Sep 2020 13:40:35 +0200
Message-Id: <20200912114040.918464-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200912114040.918464-1-f4bug@amsat.org>
References: <20200912114040.918464-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
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
index 2442a9f7d5f..17304bef26d 100644
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



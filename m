Return-Path: <SRS0=E5X6=CV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F97CC433E2
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 11:42:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B607821548
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 11:42:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pj5cC+Ky"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B607821548
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kH3v1-0003Dk-Fa
	for qemu-devel@archiver.kernel.org; Sat, 12 Sep 2020 07:42:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53548)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kH3tj-0001QQ-8B; Sat, 12 Sep 2020 07:40:51 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:52438)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kH3th-0000Td-Bx; Sat, 12 Sep 2020 07:40:50 -0400
Received: by mail-wm1-x342.google.com with SMTP id q9so6613180wmj.2;
 Sat, 12 Sep 2020 04:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+zuqPSYAeaFQaEt/7hHxldynFjZI77037Thg6Y4y1PE=;
 b=pj5cC+KyXZRxRJdjHTAAGqGXL7FvZBP4iU0KEHTCv2TY+QGyZORynKaR0Kp0MjqD/V
 JHLE+2U/vv3Dl8wDJUbf1Ajro3ZQ1YfD7KV0uTpNkmE/RU6RVvSy9GRUAS8WiBpP+FtM
 o1zsDKBfhPgGU97ggAcs+Of/4/Y/+CvclSy7aFbuWCHk1pv9xmnOr1pCYmwqsl4wJ8Rq
 K00Ah7lBlg7mpoGwi1174q0qcI2KCfBJQ3tbviKeJf/yZrW86mS4w1XNcxuMaWJibgDQ
 45PqfwWnabHd3UaHiqW24czF8kKKYOgb3kBGdPuj+HgGmY4/OsLb9CEz4RPaq5gor3zv
 yU5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=+zuqPSYAeaFQaEt/7hHxldynFjZI77037Thg6Y4y1PE=;
 b=rU4/oCx5j9/tbKLgfVhZogXbTafNb9xr4dTpFqiEzjiqGz9xeAeO3So51WtfRfOq6z
 kmR4kC50ZCcolF0B1VyQMNCCdJ4kJtMGp4G4SNIV7pleVPfZ20KefnRYqghFhq/odMyl
 fZxfP/iTavnYqq+euV4539Rei7YZviAjhFrP60xUyq+Kk9AAO2Q4skdaQl+GvGh3PwEb
 1R9dznxHfK9zbdVzpCE5hkYFBMFM3a8e3TxAcqvd29AfwHJXkzXO+o0NVaxlzCOltdlY
 AhJP63LA/mM5U52amJO8TkzIOkU+O5y0zYhljpPsKGwHok1isJptmHI5EVYtSzjWc+hY
 oV6w==
X-Gm-Message-State: AOAM532rNKP1zlSx96hjEWVDItTJrlo3U8abxcvn1Cem1G23w0VFfBV/
 62kahKLQ7f0+skB97uaPqz4=
X-Google-Smtp-Source: ABdhPJyIVvexm0+D6gC6t70mYlf81cymW5MRpW+tSOOPZeTfaTCCfSQdtwF4twsnDGssGduqi43IRg==
X-Received: by 2002:a1c:4e02:: with SMTP id g2mr6253397wmh.3.1599910847737;
 Sat, 12 Sep 2020 04:40:47 -0700 (PDT)
Received: from localhost.localdomain (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id h6sm9373895wmb.22.2020.09.12.04.40.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2020 04:40:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: Paolo Bonzini <pbonzini@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 4/7] hw/char/serial: Rename I/O read/write trace events
Date: Sat, 12 Sep 2020 13:40:37 +0200
Message-Id: <20200912114040.918464-5-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200912114040.918464-1-f4bug@amsat.org>
References: <20200912114040.918464-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
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

The serial_mm_read/write() handlers from the TYPE_SERIAL_MM device
call the serial_ioport_read/write() handlers with shifted offset.

When looking at the trace events from this MMIO device, it is
confusing to read the accesses as I/O. Simplify using generic
trace event names which make sense the various uses.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/char/serial.c     | 4 ++--
 hw/char/trace-events | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/char/serial.c b/hw/char/serial.c
index 1e70294f28a..ade4adfd526 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -333,7 +333,7 @@ static void serial_ioport_write(void *opaque, hwaddr addr, uint64_t val,
     SerialState *s = opaque;
 
     assert(size == 1 && addr < 8);
-    trace_serial_ioport_write(addr, val);
+    trace_serial_write(addr, val);
     switch(addr) {
     default:
     case 0:
@@ -550,7 +550,7 @@ static uint64_t serial_ioport_read(void *opaque, hwaddr addr, unsigned size)
         ret = s->scr;
         break;
     }
-    trace_serial_ioport_read(addr, ret);
+    trace_serial_read(addr, ret);
     return ret;
 }
 
diff --git a/hw/char/trace-events b/hw/char/trace-events
index 17304bef26d..609df10fed4 100644
--- a/hw/char/trace-events
+++ b/hw/char/trace-events
@@ -5,8 +5,8 @@ parallel_ioport_read(const char *desc, uint16_t addr, uint8_t value) "read [%s]
 parallel_ioport_write(const char *desc, uint16_t addr, uint8_t value) "write [%s] addr 0x%02x val 0x%02x"
 
 # serial.c
-serial_ioport_read(uint16_t addr, uint8_t value) "read addr 0x%02x val 0x%02x"
-serial_ioport_write(uint16_t addr, uint8_t value) "write addr 0x%02x val 0x%02x"
+serial_read(uint16_t addr, uint8_t value) "read addr 0x%02x val 0x%02x"
+serial_write(uint16_t addr, uint8_t value) "write addr 0x%02x val 0x%02x"
 serial_update_parameters(uint64_t baudrate, char parity, int data_bits, int stop_bits) "baudrate=%"PRIu64" parity='%c' data=%d stop=%d"
 
 # virtio-serial-bus.c
-- 
2.26.2



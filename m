Return-Path: <SRS0=E5X6=CV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF1BAC43461
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 11:44:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F31921548
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 11:44:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TsZpsrhJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F31921548
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kH3wx-0006AH-IO
	for qemu-devel@archiver.kernel.org; Sat, 12 Sep 2020 07:44:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53542)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kH3ti-0001QG-0B; Sat, 12 Sep 2020 07:40:51 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:51459)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kH3tg-0000TP-7L; Sat, 12 Sep 2020 07:40:49 -0400
Received: by mail-wm1-x342.google.com with SMTP id w2so6619965wmi.1;
 Sat, 12 Sep 2020 04:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ziCw1jrdbRRxzZUuAacPeDfn99gOs6JW3cbKwKy/6Wo=;
 b=TsZpsrhJ3RhWZIJyw16+9bzFXZyg5ncW7kck6EcoSZ8ZhUz4o7YPT5TIxK0ptSMD5l
 SjOf5qYNqjBiXqm9tO+JcJNKnM6aWwOXsmjBWl0UojGAkKBRiEXmKUgGyeBtNKOFyxFk
 DRkY0E+mCjaHTuAxPrEQ36yecUFEPEhSf+jTJOwqp9Snq1apB1f7C4f5WWqltDdrXVxb
 Hk81uwkLK/tSwiKWUcoHAEFrRcogiFZsbv7RSwzY2UgvRoZCtaMJ8aP+ZsNyPbVNEomc
 C6bhAgrYPoyhgqeEdNwlDMDKuLraXuhqBCZBnY7h+dj3Uy2RUGMzEuOerPsqf5gV7Ugc
 anSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=ziCw1jrdbRRxzZUuAacPeDfn99gOs6JW3cbKwKy/6Wo=;
 b=tAne9t0eXm86QUjwkeym7jXw6ofYK2W95188hXoDUxRGXApdxvjbsM6W+yFyaO1waD
 fHuiTn9WW2Vk09gnRDbOdKDcQfTgRWGDGqno/3rgUhOSrAu0B1ApRvVT0AtA0b8XAGLy
 nKeWFO93WnjDmbm3U47l4yDzyA+Bj9aN8j92A0FGQ834whNWPGswExejbXjnd3MwP8pC
 5YoMSDnF1EAFmAZqElUoEitsktC+h2mtzw30RFYDusDx7MvaMVjupXtzs65CGVZAw//O
 8oLlhTAIwFjwgH9/y3EKTN+75orKeir2ngTwkYIPTMpTjvAWzjmZyqFR+nAL6wG/+0Fn
 ASXQ==
X-Gm-Message-State: AOAM5326BqWXHNjXnaTZoyun3Yhw8qPuiHhRJMiIByyDbm4c9i0k3iJY
 GNr2BKckTrjntcxUS4VskGQ=
X-Google-Smtp-Source: ABdhPJxvI/WOGV6Fo61vJPY+cPr8BV3k0ADGPI8FRgkd1nBBH18I4hf3/vqIJeD+D6P1uXdpjYpIgQ==
X-Received: by 2002:a1c:c2c6:: with SMTP id s189mr1791879wmf.146.1599910846444; 
 Sat, 12 Sep 2020 04:40:46 -0700 (PDT)
Received: from localhost.localdomain (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id h6sm9373895wmb.22.2020.09.12.04.40.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2020 04:40:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: Paolo Bonzini <pbonzini@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 3/7] hw/char/serial: Remove old DEBUG_SERIAL commented code
Date: Sat, 12 Sep 2020 13:40:36 +0200
Message-Id: <20200912114040.918464-4-f4bug@amsat.org>
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

All useful DPRINTF() calls have been converted to trace
events.  Remove a pointless one in the IOEventHandler,
and drop the DEBUG_SERIAL ifdef'ry.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/char/serial.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/hw/char/serial.c b/hw/char/serial.c
index fb41337b661..1e70294f28a 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -36,8 +36,6 @@
 #include "trace.h"
 #include "hw/qdev-properties.h"
 
-//#define DEBUG_SERIAL
-
 #define UART_LCR_DLAB	0x80	/* Divisor latch access bit */
 
 #define UART_IER_MSI	0x08	/* Enable Modem status interrupt */
@@ -102,14 +100,6 @@
 
 #define MAX_XMIT_RETRY      4
 
-#ifdef DEBUG_SERIAL
-#define DPRINTF(fmt, ...) \
-do { fprintf(stderr, "serial: " fmt , ## __VA_ARGS__); } while (0)
-#else
-#define DPRINTF(fmt, ...) \
-do {} while (0)
-#endif
-
 static void serial_receive1(void *opaque, const uint8_t *buf, int size);
 static void serial_xmit(SerialState *s);
 
@@ -636,7 +626,6 @@ static void serial_receive1(void *opaque, const uint8_t *buf, int size)
 static void serial_event(void *opaque, QEMUChrEvent event)
 {
     SerialState *s = opaque;
-    DPRINTF("event %x\n", event);
     if (event == CHR_EVENT_BREAK)
         serial_receive_break(s);
 }
-- 
2.26.2



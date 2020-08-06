Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D144C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 13:05:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32C02206B5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 13:05:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dP7xjfYY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32C02206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3faD-0003gt-8g
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 09:05:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43776)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k3fYj-00020z-IQ
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 09:03:49 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:34926)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k3fYi-00075f-29
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 09:03:49 -0400
Received: by mail-wr1-x434.google.com with SMTP id f1so43384799wro.2
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2020 06:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5MyJt4saRNOH+wyZ/PYBkEhqoYePEqFCcALpsJUGNbo=;
 b=dP7xjfYYT2X081rx02yrllcPZZKmM8Zcb4kmIqwXlwUoJ9txzNh93JFg5uC3a0wGO6
 f79jDzGsCI5/ieC++aAiwfOHYyjfypz8MnAK7hny3oGNsunzcS2u4GiifPjCeftKdaOh
 6BzkbLIfn2SsTZUe2XgWHAEqFV6N32WxFcZpxU1sOJi4mrdGFur5w1ncpegPT+tq33/0
 jxTTRbWSWZc4QzCfuAFqVDeMY4F8hOw5aaK2EaV2ixwCaKQES3euCQ2NRBHmfUTAUSie
 trmIJsD1veNMC0JmllqIkKxszFrW2++qdQXEHXWlMA6hxpY3HmniZlItIZrjknWTm+GD
 ZPaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=5MyJt4saRNOH+wyZ/PYBkEhqoYePEqFCcALpsJUGNbo=;
 b=geyhuL2ZmpvoOofIfbejsr329LkSEG1I2nQPfPjht32YmCugiatoqgv4cB9sH5k2D0
 zF+z2o5r/V3BzB+sjRDpzjbLKPWKgovldk1WmZNfuDuOC9gd1y7cfK3nPfNQndJLIfj1
 ErlpCz2ZB2zAT6jw9IhRAQcHiJgR3JUWrXvMUJ+BMtg801FqZam35SGeKSjtN0eQqQj4
 ZGyPv8p6wK9ABJDz12+W5+FM1577SY2vIetCDK1VTP/m3FfRT5BMV4yLWiZcexj3mOI5
 dFp1WgKV8szeAu/TftOweiv/FTySjLdKVaInquvge1+Yq0iJR99dhPSTT2N3VivDZL0P
 f0ig==
X-Gm-Message-State: AOAM531Lwuehnq4rp9t0r8LfzTPZk0VT4W/ZeL5MNEzAmdVVOWzIQyqO
 DFuXfCZkAutIT2eJS2yjFi4zetZP
X-Google-Smtp-Source: ABdhPJwZsWhlDzTpVb/LMW/RsMjOZcjFewMMoRexCAZ2wW8m+gXxAH/Fmw341YKtp+1s5t9nly9/iw==
X-Received: by 2002:adf:e98c:: with SMTP id h12mr7197919wrm.3.1596719024786;
 Thu, 06 Aug 2020 06:03:44 -0700 (PDT)
Received: from localhost.localdomain (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id e16sm6409113wrx.30.2020.08.06.06.03.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2020 06:03:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.2 2/4] hw/char/serial: Remove old DEBUG_SERIAL commented
 code
Date: Thu,  6 Aug 2020 15:03:38 +0200
Message-Id: <20200806130340.17316-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200806130340.17316-1-f4bug@amsat.org>
References: <20200806130340.17316-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x434.google.com
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

All useful DPRINTF() calls have been converted to trace
events.  Remove a pointless one in the IOEventHandler,
and drop the DEBUG_SERIAL ifdef'ry.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/char/serial.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/hw/char/serial.c b/hw/char/serial.c
index 3e903d5fad..758a3aa49b 100644
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
2.21.3



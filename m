Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4386C433E2
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 01:58:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50E012075A
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 01:58:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZAKXwIlc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50E012075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kF6Qa-000309-EW
	for qemu-devel@archiver.kernel.org; Sun, 06 Sep 2020 21:58:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59862)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kF6Np-0006F1-AP; Sun, 06 Sep 2020 21:55:49 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:53845)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kF6Nm-0007Ll-Oa; Sun, 06 Sep 2020 21:55:48 -0400
Received: by mail-wm1-x341.google.com with SMTP id x23so2943843wmi.3;
 Sun, 06 Sep 2020 18:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ziCw1jrdbRRxzZUuAacPeDfn99gOs6JW3cbKwKy/6Wo=;
 b=ZAKXwIlcheRQ7uF37G0Dw/DfnyfX5wqZKGp1+82B+xSifzGM6ZyoVOImVmIi4Rpc4q
 RLKMsl7/hnNTi0WhrtNcucLt0F/WQNWJbD0P4RpyiGFAtGswN2Eya/MBpN59KOZbFN2/
 p830v0NIPzfSaniixt1aM6PCSEl/bdp0p9N/ytv2nLHb0qYUmzL+zhwIeh1ru/TPR3t/
 yAjXd1MajOZ4DC4q8nFMkMXJQQxsKBzvDVCo1kZCSFaPN+OrqV4yFLX1Y1z4I/+5iWPJ
 kHsoNK5qP4nW5/nD5ZqzVdzQo6PYSTtyMr5Q/x/L5NrZwEx/coQH+2clx9c3VE2XrMWa
 v8KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=ziCw1jrdbRRxzZUuAacPeDfn99gOs6JW3cbKwKy/6Wo=;
 b=GWpQKoGgktMz4coMInEGyuIX93paISNoPpxZC9NdpdtZyTfvU6i6eelFweo1eQBMxZ
 ysyzgeV1dN1LPPxYWQg3JIBlGAOHBiK9C/t6nR9vWVMfLchCYXVQIPbDTh4Uo/Ls2Cos
 1D2KvdR2obNo2ewE7wnIw9nK0sT3F34Y3eNbb6+THxNFehgqu/yBmqqJot9j5lvfiGd7
 dgLi5DFeR86fjZxrP9bgstLDw4Ob4hP0X1FXt+6le38Oo4VqlvwviX/klikzciQycmbf
 GcFvWz+QtrgQfXtPyS7YG3rgKr/yumsIP9ojsEi1AcLVfrpOPg/x5TTaRiNtcfUMPL26
 n2fg==
X-Gm-Message-State: AOAM533BKlF0zOTl1h6uMeDIjG8iXp/qtSp2I7S8+9/Lw5uUphG7sTIh
 uUL+CiQXfcpQWHcRHWAI/tPN+7HhMvw=
X-Google-Smtp-Source: ABdhPJwNPzGEimfV5QOVz6vrgn92szWy9wM++PUUZin7MUiYC/kpwkBNb+m+g9zmFtBocHxJClDB3A==
X-Received: by 2002:a05:600c:2317:: with SMTP id
 23mr19335637wmo.183.1599443741827; 
 Sun, 06 Sep 2020 18:55:41 -0700 (PDT)
Received: from localhost.localdomain (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id b84sm29377773wmd.0.2020.09.06.18.55.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Sep 2020 18:55:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/7] hw/char/serial: Remove old DEBUG_SERIAL commented code
Date: Mon,  7 Sep 2020 03:55:31 +0200
Message-Id: <20200907015535.827885-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200907015535.827885-1-f4bug@amsat.org>
References: <20200907015535.827885-1-f4bug@amsat.org>
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-trivial@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
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



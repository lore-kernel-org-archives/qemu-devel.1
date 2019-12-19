Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 198C2C2D0C1
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 18:59:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7FBC206EC
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 18:59:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DOOoXp7w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7FBC206EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ii10m-0007tG-Hh
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 13:59:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39372)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ii0td-00070L-BC
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 13:51:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ii0tc-0007cm-0Q
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 13:51:37 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:53867)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ii0tb-0007Xp-PD; Thu, 19 Dec 2019 13:51:35 -0500
Received: by mail-wm1-x343.google.com with SMTP id m24so6507350wmc.3;
 Thu, 19 Dec 2019 10:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=jIg+33KeWZZoVU4KTC1Qs/cBS+U2tDHwXFCUA5+HzbM=;
 b=DOOoXp7wOhfRVuo831S05oCEi09rbGM+mhvGwoAW9kVI0AW+Oi4238dlMdG1HOQLPi
 fv1sR8UjxVUOg9aff+Rn+lxEEBAqc4IWv8QwbdkXnkjj1xZMT8iYSKrthF2l7zzOTr+f
 kSuwqJcEKaudzWgZISsd9EjkoaD+uKrDdGo54li47kwOPP/+gvfVHoNifBXg9VmFaeUm
 wIqWtyMYSnb/S/bYWWX3fNHNxI1dnDqTD5KQhO61QRvJOZmWmqYvUwrVYoBqSmnmQ/tw
 Ltilcsgh3Db1J+pjsZg4GO1nShWstMrzDDMz/AbdPwCOLkQgcINIA0f1COTK23QyDxzg
 mwow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=jIg+33KeWZZoVU4KTC1Qs/cBS+U2tDHwXFCUA5+HzbM=;
 b=g6rH1vb0qUz2V/LctLMY0bRjoukLHEKNrHaJ5/wLhWJ8MuOxvwZ+jhR2yDn3FBFFf9
 jZgEDXd69zznrvo4Z8Flrx0xTOhh/dftH8xmWMes3uVprBFqi3AWIz/dMOqpPaqgnax3
 +zo4yTfyv9CjtrPS+4ZHBk06kcdo8UPK58ugH2GaEObtn6SaupRLMHthjVKm/h0iS4T7
 Eqv2a+6L5J1zM1fjK/bl+kUhWGl2QszMZkr6CQqnQiCS6jU+tzUuX+rm+Tv15uDOhruy
 dORsHThzVzmBkeA1FjVAV1pgJH5Urbfjat7HYUWGJtnABkXff61myXZj8TsWBDa3wjZr
 kdHw==
X-Gm-Message-State: APjAAAXXO31ZbwhRw2O7PQ2k958YCFObxARqlVSTJdPEnGkvH/cKntAh
 22H4gY1KGRjy466RmVvvKAWc3pSm
X-Google-Smtp-Source: APXvYqx4/zuBzYIXCe0BcvOfXwN1MN94M8leEwqrgzY3pRbmv0q7FlOQyPpkYLKO5pfpunluWXKUUA==
X-Received: by 2002:a1c:4b09:: with SMTP id y9mr12136089wma.103.1576781494368; 
 Thu, 19 Dec 2019 10:51:34 -0800 (PST)
Received: from x1w.redhat.com (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id b67sm7435494wmc.38.2019.12.19.10.51.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2019 10:51:33 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org,
	Niek Linnenbank <nieklinnenbank@gmail.com>
Subject: [PATCH 04/13] hw/timer/allwinner: Move definitions from header to
 source
Date: Thu, 19 Dec 2019 19:51:18 +0100
Message-Id: <20191219185127.24388-5-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191219185127.24388-1-f4bug@amsat.org>
References: <20191219185127.24388-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: Beniamino Galvani <b.galvani@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These definitions are only used in the implementation, thus don't
need to be exported. Move them in the source file.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/timer/allwinner-a10-pit.h | 28 --------------------------
 hw/timer/allwinner-a10-pit.c         | 30 ++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+), 28 deletions(-)

diff --git a/include/hw/timer/allwinner-a10-pit.h b/include/hw/timer/allwinner-a10-pit.h
index e4a644add9..c28ee5ca47 100644
--- a/include/hw/timer/allwinner-a10-pit.h
+++ b/include/hw/timer/allwinner-a10-pit.h
@@ -5,37 +5,9 @@
 #include "hw/sysbus.h"
 
 #define TYPE_AW_A10_PIT "allwinner-A10-timer"
-#define AW_A10_PIT(obj) OBJECT_CHECK(AwA10PITState, (obj), TYPE_AW_A10_PIT)
 
 #define AW_PIT_TIMER_MAX        6
 
-#define AW_A10_PIT_TIMER_NR    6
-
-#define AW_A10_PIT_TIMER_IRQ_EN    0
-#define AW_A10_PIT_TIMER_IRQ_ST    0x4
-
-#define AW_A10_PIT_TIMER_CONTROL   0x0
-#define AW_A10_PIT_TIMER_EN        0x1
-#define AW_A10_PIT_TIMER_RELOAD    0x2
-#define AW_A10_PIT_TIMER_MODE      0x80
-
-#define AW_A10_PIT_TIMER_INTERVAL  0x4
-#define AW_A10_PIT_TIMER_COUNT     0x8
-#define AW_A10_PIT_WDOG_CONTROL    0x90
-#define AW_A10_PIT_WDOG_MODE       0x94
-
-#define AW_A10_PIT_COUNT_CTL       0xa0
-#define AW_A10_PIT_COUNT_RL_EN     0x2
-#define AW_A10_PIT_COUNT_CLR_EN    0x1
-#define AW_A10_PIT_COUNT_LO        0xa4
-#define AW_A10_PIT_COUNT_HI        0xa8
-
-#define AW_A10_PIT_TIMER_BASE      0x10
-#define AW_A10_PIT_TIMER_BASE_END  \
-    (AW_A10_PIT_TIMER_BASE * AW_A10_PIT_TIMER_NR + AW_A10_PIT_TIMER_COUNT)
-
-#define AW_A10_PIT_DEFAULT_CLOCK   0x4
-
 typedef struct AwA10PITState AwA10PITState;
 
 typedef struct AwA10TimerContext {
diff --git a/hw/timer/allwinner-a10-pit.c b/hw/timer/allwinner-a10-pit.c
index b31a0bcd43..00f7cc492d 100644
--- a/hw/timer/allwinner-a10-pit.c
+++ b/hw/timer/allwinner-a10-pit.c
@@ -24,6 +24,36 @@
 #include "qemu/log.h"
 #include "qemu/module.h"
 
+#define AW_A10_PIT_TIMER_NR         6
+
+#define AW_A10_PIT_TIMER_IRQ_EN     0
+#define AW_A10_PIT_TIMER_IRQ_ST     0x4
+
+#define AW_A10_PIT_TIMER_CONTROL    0x0
+#define AW_A10_PIT_TIMER_EN         0x1
+#define AW_A10_PIT_TIMER_RELOAD     0x2
+#define AW_A10_PIT_TIMER_MODE       0x80
+
+#define AW_A10_PIT_TIMER_INTERVAL   0x4
+#define AW_A10_PIT_TIMER_COUNT      0x8
+#define AW_A10_PIT_WDOG_CONTROL     0x90
+#define AW_A10_PIT_WDOG_MODE        0x94
+
+#define AW_A10_PIT_COUNT_CTL        0xa0
+#define AW_A10_PIT_COUNT_RL_EN      0x2
+#define AW_A10_PIT_COUNT_CLR_EN     0x1
+#define AW_A10_PIT_COUNT_LO         0xa4
+#define AW_A10_PIT_COUNT_HI         0xa8
+
+#define AW_A10_PIT_TIMER_BASE       0x10
+#define AW_A10_PIT_TIMER_BASE_END   \
+    (AW_A10_PIT_TIMER_BASE * AW_A10_PIT_TIMER_NR + AW_A10_PIT_TIMER_COUNT)
+
+#define AW_A10_PIT_DEFAULT_CLOCK    0x4
+
+#define AW_A10_PIT(obj) \
+    OBJECT_CHECK(AwA10PITState, (obj), TYPE_AW_A10_PIT)
+
 static void a10_pit_update_irq(AwA10PITState *s)
 {
     int i;
-- 
2.21.0



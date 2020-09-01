Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADB94C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 10:44:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69CCD206FA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 10:44:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q7YmGjHf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69CCD206FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD3mY-00035v-FK
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 06:44:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57552)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kD3kR-0008MQ-QJ; Tue, 01 Sep 2020 06:42:43 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:33973)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kD3kP-00024W-M0; Tue, 01 Sep 2020 06:42:43 -0400
Received: by mail-wm1-x341.google.com with SMTP id c19so679320wmd.1;
 Tue, 01 Sep 2020 03:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=fqHTEPlAjV9bvBkHlzkr+R6J+o6iCqiuHYjcb5bwgeI=;
 b=q7YmGjHfJ1jHHFk7ho5O78GGMi5CDWGeRX6lG0mOAkHD7+r2TAU5O4bFLJ9lPrxJob
 8GcLl5JHVEWbr0qDkxtTjtGim1VffAmgiS4k4P7tMUJ/Di6qtiKvj8KdSmzkwykHXe9k
 W9hORW0EUHyd4EMHc4g0I+WznXuOC4WSmfGxhfaVBZPEsAoKDeT6i9//p87A2bhMCQUM
 6MpUFcaBzT4WVD1Lv5OXUBqMvSfjRmzuG6t19ngd1AR5krTotVRQNOA2SxoMmpQEXDj6
 0loiU0pXbaTPXrD3uKl0HqDzVg5f9H2W4CDbHv7V+4lpvNETZbrLmz9Ez9sUkDIfTavv
 rOhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=fqHTEPlAjV9bvBkHlzkr+R6J+o6iCqiuHYjcb5bwgeI=;
 b=lvr8mwCpS4KY2v7v64X1+0BkM6AoSkly3q97OoG3t8OEe0v6GM+4a+KWtZwIfEWyVP
 QnD93sv7EzOjD11xFDDw1JGryjnhKCLNgfhsE2BQmHq3PgdRgQEjPeiuueKlT+Givmsy
 BGoPfTjeA8LjGbq4snl/PvvqQpRCO9lWbUZ3xLaLMMSDxmOvbaSODfvVYyehmZ7Y+kwH
 xjifDjP1xO9zS0PnGpszogCuvexu0xX4ms5Y+u8vuWRV0TKG84MEiBwq6A9tadr9tiVP
 SCFGckZj1PS3SM8GNpbIJz+l5lltqzoy4tFivDZzUgglh+BO4DbP8qOqAX9rAnJuJcoQ
 Zzlw==
X-Gm-Message-State: AOAM532OphNEugdiRUqkCJt12PmyZOPM5HDinLUPy2moH+rnTaVze1PG
 STQcn4UwH0hdUISPxe4ChzJbrdYq6q8=
X-Google-Smtp-Source: ABdhPJy+IJY8M8CU8l8ULDDy1r5oSLd42U7S0454oTBxLt8sggJQZChyv6i9K8neGTvtBU+4cEpMVg==
X-Received: by 2002:a1c:6083:: with SMTP id u125mr1122066wmb.161.1598956959216; 
 Tue, 01 Sep 2020 03:42:39 -0700 (PDT)
Received: from localhost.localdomain (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id l8sm1693217wrx.22.2020.09.01.03.42.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2020 03:42:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] hw/gpio/max7310: Replace disabled printf() by
 qemu_log_mask(UNIMP)
Date: Tue,  1 Sep 2020 12:42:34 +0200
Message-Id: <20200901104234.92159-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200901104234.92159-1-f4bug@amsat.org>
References: <20200901104234.92159-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
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
Cc: qemu-trivial@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Replace disabled printf() by qemu_log_mask(UNIMP).

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/gpio/max7310.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/hw/gpio/max7310.c b/hw/gpio/max7310.c
index 7f5de189acf..c58a1996418 100644
--- a/hw/gpio/max7310.c
+++ b/hw/gpio/max7310.c
@@ -11,6 +11,7 @@
 #include "hw/i2c/i2c.h"
 #include "hw/irq.h"
 #include "migration/vmstate.h"
+#include "qemu/log.h"
 #include "qemu/module.h"
 
 #define TYPE_MAX7310 "max7310"
@@ -69,9 +70,8 @@ static uint8_t max7310_rx(I2CSlave *i2c)
         return 0xff;
 
     default:
-#ifdef VERBOSE
-        printf("%s: unknown register %02x\n", __func__, s->command);
-#endif
+        qemu_log_mask(LOG_UNIMP, "%s: Unsupported register 0x02%" PRIx8 "\n",
+                      __func__, s->command);
         break;
     }
     return 0xff;
@@ -123,9 +123,8 @@ static int max7310_tx(I2CSlave *i2c, uint8_t data)
     case 0x00:	/* Input port - ignore writes */
         break;
     default:
-#ifdef VERBOSE
-        printf("%s: unknown register %02x\n", __func__, s->command);
-#endif
+        qemu_log_mask(LOG_UNIMP, "%s: Unsupported register 0x02%" PRIx8 "\n",
+                      __func__, s->command);
         return 1;
     }
 
-- 
2.26.2



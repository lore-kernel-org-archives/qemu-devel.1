Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D74DC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 09:53:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BB3C2070A
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 09:53:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ry5THoXj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BB3C2070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jacSP-0004h2-K3
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 05:53:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55302)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jacRO-00033z-Ps; Mon, 18 May 2020 05:52:14 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:40989)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jacRO-00017O-3N; Mon, 18 May 2020 05:52:10 -0400
Received: by mail-wr1-x444.google.com with SMTP id h17so11020789wrc.8;
 Mon, 18 May 2020 02:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=jz9Gxel1PVIdl5iYkRkenVOs1Gr8Smmd1Imlbqeyfjo=;
 b=ry5THoXj09szFfkYga5A8TR+8fC/TmryUJVMe6iigmu9ZtX5hqfOlKpZcLYsPwDkG7
 exbkpD2aEoE2W2R6isWGOenK9YrUskKFQumNcdVpbsTIZicWrHOkgiOfXjWeiOrg0EHm
 WLD91QP0rJ28vYZa9YeyzmFJlFW4BuaJ7xT/ii3glR7SleQCCxdb5/72LLvona2BIfwY
 U/6DiSZnsokFKQI+cxQhJS4B2EGTFcKwpi8hKnnyYi+ZrDcFOUrOlKPgflxA+Pbs2wGT
 212mHhAa5yZYqxXNw9vOahHI1WL7gsV5t0lJh+4OXmqtRCwT38/Z7NFTfPil5pRf0XT8
 FBfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=jz9Gxel1PVIdl5iYkRkenVOs1Gr8Smmd1Imlbqeyfjo=;
 b=bKuVJO0+1Sr9EdHQN13zCh2KU63LyfIibi3ewNqygCTDmIoAzZsqdUaUjmB8RH44TD
 Y/B7RYPkEjDFKFireXkXm3LthrUiqhnYZrDt/pxSQSxWm0SbrEwAKTx7Vs+nzv+zMCzN
 eSxhYTqDdjuLGqL8+NKeZXzLIhhiHlXJIkxJFvn3eIAZm6ID3yQFUttkDTamo7A2nOct
 FbjUVRar6yU0U9LxgUnQrQtqjRpz745n4muI2px+6doOR0wnBxLzodsvLbjeCWjcOp7G
 3k/M/CK6yx5EuVIQp/Asuvq7pZ0fGs/AhE8QvrIZ4vHIGhYRtq3HYYd/4W/Fy4PS4gFz
 mTvQ==
X-Gm-Message-State: AOAM532Y6km/ADVFldPJyVhXfYLtVnmRu0DSJJWoNjKyAYWG8baHD7yL
 vbws+yZwrfNeczBuxTmfw8gaan6y5ek=
X-Google-Smtp-Source: ABdhPJyymC4+daFFmr1JHZFeYlROKCA3/pXO3GF1KBYqJi4dVmOJYSFbLVBvdgh8887kqWd7CrZhYw==
X-Received: by 2002:a5d:4312:: with SMTP id h18mr18783564wrq.393.1589795528254; 
 Mon, 18 May 2020 02:52:08 -0700 (PDT)
Received: from x1w.redhat.com (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id r9sm5453542wra.52.2020.05.18.02.52.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2020 02:52:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/4] hw/arm/pxa2xx: Replace hw_error() by qemu_log_mask()
Date: Mon, 18 May 2020 11:52:01 +0200
Message-Id: <20200518095203.1013-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200518095203.1013-1-f4bug@amsat.org>
References: <20200518095203.1013-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

hw_error() calls exit(). This a bit overkill when we can log
the accesses as unimplemented or guest error.

When fuzzing the devices, we don't want the whole process to
exit. Replace some hw_error() calls by qemu_log_mask().

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/pxa2xx_gpio.c    |  7 ++++---
 hw/display/pxa2xx_lcd.c |  8 +++++---
 hw/dma/pxa2xx_dma.c     | 14 +++++++++-----
 3 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/hw/arm/pxa2xx_gpio.c b/hw/arm/pxa2xx_gpio.c
index f8df3cc227..a01db54a51 100644
--- a/hw/arm/pxa2xx_gpio.c
+++ b/hw/arm/pxa2xx_gpio.c
@@ -9,7 +9,6 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "hw/hw.h"
 #include "hw/irq.h"
 #include "hw/qdev-properties.h"
 #include "hw/sysbus.h"
@@ -199,7 +198,8 @@ static uint64_t pxa2xx_gpio_read(void *opaque, hwaddr offset,
         return s->status[bank];
 
     default:
-        hw_error("%s: Bad offset " REG_FMT "\n", __func__, offset);
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%" HWADDR_PRIX "\n",
+                      __func__, offset);
     }
 
     return 0;
@@ -252,7 +252,8 @@ static void pxa2xx_gpio_write(void *opaque, hwaddr offset,
         break;
 
     default:
-        hw_error("%s: Bad offset " REG_FMT "\n", __func__, offset);
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%" HWADDR_PRIX "\n",
+                      __func__, offset);
     }
 }
 
diff --git a/hw/display/pxa2xx_lcd.c b/hw/display/pxa2xx_lcd.c
index 464e93161a..d5f2e82a4e 100644
--- a/hw/display/pxa2xx_lcd.c
+++ b/hw/display/pxa2xx_lcd.c
@@ -11,7 +11,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/hw.h"
+#include "qemu/log.h"
 #include "hw/irq.h"
 #include "migration/vmstate.h"
 #include "ui/console.h"
@@ -407,7 +407,8 @@ static uint64_t pxa2xx_lcdc_read(void *opaque, hwaddr offset,
 
     default:
     fail:
-        hw_error("%s: Bad offset " REG_FMT "\n", __func__, offset);
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%" HWADDR_PRIX "\n",
+                      __func__, offset);
     }
 
     return 0;
@@ -562,7 +563,8 @@ static void pxa2xx_lcdc_write(void *opaque, hwaddr offset,
 
     default:
     fail:
-        hw_error("%s: Bad offset " REG_FMT "\n", __func__, offset);
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%" HWADDR_PRIX "\n",
+                      __func__, offset);
     }
 }
 
diff --git a/hw/dma/pxa2xx_dma.c b/hw/dma/pxa2xx_dma.c
index 88ed4b6ff1..8a2eeb32bc 100644
--- a/hw/dma/pxa2xx_dma.c
+++ b/hw/dma/pxa2xx_dma.c
@@ -9,6 +9,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/log.h"
 #include "hw/hw.h"
 #include "hw/irq.h"
 #include "hw/qdev-properties.h"
@@ -268,7 +269,8 @@ static uint64_t pxa2xx_dma_read(void *opaque, hwaddr offset,
     unsigned int channel;
 
     if (size != 4) {
-        hw_error("%s: Bad access width\n", __func__);
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad access width %u\n",
+                      __func__, size);
         return 5;
     }
 
@@ -315,8 +317,8 @@ static uint64_t pxa2xx_dma_read(void *opaque, hwaddr offset,
             return s->chan[channel].cmd;
         }
     }
-
-    hw_error("%s: Bad offset 0x" TARGET_FMT_plx "\n", __func__, offset);
+    qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%" HWADDR_PRIX "\n",
+                  __func__, offset);
     return 7;
 }
 
@@ -327,7 +329,8 @@ static void pxa2xx_dma_write(void *opaque, hwaddr offset,
     unsigned int channel;
 
     if (size != 4) {
-        hw_error("%s: Bad access width\n", __func__);
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad access width %u\n",
+                      __func__, size);
         return;
     }
 
@@ -420,7 +423,8 @@ static void pxa2xx_dma_write(void *opaque, hwaddr offset,
             break;
         }
     fail:
-        hw_error("%s: Bad offset " TARGET_FMT_plx "\n", __func__, offset);
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%" HWADDR_PRIX "\n",
+                      __func__, offset);
     }
 }
 
-- 
2.21.3



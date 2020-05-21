Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74385C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 19:27:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 122D0207D3
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 19:27:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wZpnMc2b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 122D0207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbqqS-0008Sk-99
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 15:27:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38110)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jbqgK-0002m5-OH
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:16:40 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:42182)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jbqgJ-0000SX-Gy
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:16:40 -0400
Received: by mail-wr1-x441.google.com with SMTP id s8so7744747wrt.9
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 12:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=P9KCQG/WS9GdDGHqO3MaEt12NQUl4WXAVUVOE7KRnPs=;
 b=wZpnMc2byuMVHZNKWjRinyea4nLfOfujfXhtk+o9ZuosQYyCYk1RRKTRpO2KXLA1Bf
 LNr8zFYL/8n9MlvZPIpUhlzmiD+2JI2LpZqed3YkDj+X4t+78jgT+MCv5L+XUxaELbua
 VTufdJ8yUbS95mRmbFFt3dT9RS2oULmAWZ8kCByttdSdk5ZDSu0dOvUSWAePpz1q0xaX
 cyqVBV+3gh3DOM9uGIqfBoRm1T1n/XYl9Jnqw2XJKKgHUbFrvVBUeWneZIB4FNwC36P+
 za0kbBGTPrfBM0QrVCscAHuOPNtc3ppKH7CnsMzIH3H7Eb606JALN6sM12wL3Zm6puDW
 sbNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=P9KCQG/WS9GdDGHqO3MaEt12NQUl4WXAVUVOE7KRnPs=;
 b=gjoarppEph9ZR7JzgNccngX/7NNf0Ob/qw9qqg08PTxKga7T5uf6326muRzfxPVWD8
 odLgJupf6WY59oO1IfdkGc43Pg9ebJ+p8jum4nDPXaaDikfJdkh7Dvuiz5+CkaCtN85y
 tx/UKcbjcuIA9JNo7TZydOwK803qnpLvnBek4+lUXZLX5fhnKSYb1odSgFEtXRDg1Ru9
 DZ8ZV2B5AJwrJwazxzJUFWvIeWtnYLBjKM6PUCq8D8gjAJTYZWoQOsan9N7+DJm6KzkT
 e7Fooh6jLteq8HER5eoquEEcgk4qCe1QWb5dcBbZ5mpj1d88qE2Q8N77ZxhIq+SUlP1/
 9iKQ==
X-Gm-Message-State: AOAM530T4s4n/HRpAk0qGxSOYX+RecS/GVZJ0mjeEvb5SblasKilzEJh
 6L7pfzAK3th1nGmbqy0g4h9AQejNwXMNiA==
X-Google-Smtp-Source: ABdhPJxaycj6EF0n1dQ4lPeBK60seLzfuT+oAy6OTfzOcH+GB4r7sA7Hb92WIODDu+a+ZfVC9BcWOQ==
X-Received: by 2002:adf:fb08:: with SMTP id c8mr71268wrr.421.1590088597852;
 Thu, 21 May 2020 12:16:37 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id z124sm7335100wmg.20.2020.05.21.12.16.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 12:16:37 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 21/29] hw/arm/pxa2xx: Replace hw_error() by qemu_log_mask()
Date: Thu, 21 May 2020 20:16:02 +0100
Message-Id: <20200521191610.10941-22-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200521191610.10941-1-peter.maydell@linaro.org>
References: <20200521191610.10941-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

hw_error() calls exit(). This a bit overkill when we can log
the accesses as unimplemented or guest error.

When fuzzing the devices, we don't want the whole process to
exit. Replace some hw_error() calls by qemu_log_mask().

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 20200518140309.5220-3-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/pxa2xx_gpio.c    |  7 ++++---
 hw/display/pxa2xx_lcd.c |  8 +++++---
 hw/dma/pxa2xx_dma.c     | 14 +++++++++-----
 3 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/hw/arm/pxa2xx_gpio.c b/hw/arm/pxa2xx_gpio.c
index f8df3cc2279..a01db54a518 100644
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
index 464e93161a2..d5f2e82a4ec 100644
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
index 88ed4b6ff1f..8a2eeb32bc3 100644
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
2.20.1



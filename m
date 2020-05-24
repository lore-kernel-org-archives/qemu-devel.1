Return-Path: <SRS0=Dt9u=7G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2D29C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2020 16:46:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B80D62065F
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2020 16:46:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mBeidOkf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B80D62065F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jctlE-0002fH-Vx
	for qemu-devel@archiver.kernel.org; Sun, 24 May 2020 12:46:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53860)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jctkQ-0001ve-NA; Sun, 24 May 2020 12:45:14 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:46672)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jctkP-0006bg-5B; Sun, 24 May 2020 12:45:14 -0400
Received: by mail-wr1-x441.google.com with SMTP id x6so1425438wrm.13;
 Sun, 24 May 2020 09:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=wI8dCrsMkXEY+JNiQUJR4Y0BM65XvUZSpfaLli4P94Y=;
 b=mBeidOkftPDrOyik0MCIj1wQUtofEw4/9SCT0ecl59aqZLTanjnVoViyRo8I7voh/z
 BNcx4JgIXSi6TfmHYHhTnV8FxdRbQVkll/k3TfaIv9k0NvWBoyBK81St7AiKbsxcEhHT
 cGR0eyd0Si7AyOXaI3G/Vwij85l7ybGI/rL2CSf69J71x6UReNMMmtXqxQb3bfiQBhqR
 NuceizPacxZi4/Hn1jEUerrsEJllV0laPwdZrbguate45PGgHpWZONkGVXqPzhv7lO32
 CgxQLTgy4F78T1yrlOzwerkDrzO6/fyjPusLTQZCok+nQefM6WSCn0beWUKlzf4swc7A
 UFDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=wI8dCrsMkXEY+JNiQUJR4Y0BM65XvUZSpfaLli4P94Y=;
 b=cUV1nQRWtNhKilZHzSbEYMkZXPCSxCUqwMikRiVWGXbcVjAdtFb3qRNC2m2A63swHT
 nHhkgN8w364On7C+fxBTUW2PrKK4AmUzXTYQoiPDyE0imTspYVYQ/UUHughCaQhlfylM
 UXA8g+liRtE5UVolL4tHQukJGc3POp8DVV5XbZI0dOXcUnsZRRgzAiwIMZgZWUd8Wbkn
 Ej7X5WFouSmGwrAwlUNkEfEJIJaxBxhjhWHkeGacb7XOn2p9xwE7OMr0+27AOBwKTOB9
 RpQfWKGblEMRF/gc+g4C7ZbIVVAzXKjXmXESXHk6P8KHXgL7oe8tfeYBECKK2q0q4goC
 gEAw==
X-Gm-Message-State: AOAM532SkMYvS7yW6/pm3TYVU5/DkIJU5QCMM95YHBOEQs0EC5Em7MZT
 D1kDN8JUPmsRuYjaXCMkFYoaQ0ZAE4g=
X-Google-Smtp-Source: ABdhPJzpSESA7dbgKfVoB3Azcaa+rTd6+5ARd38GfTZ63YxfcBB4jiQsaRjof41NMeCgzTjW50At2g==
X-Received: by 2002:a5d:67d2:: with SMTP id n18mr8633350wrw.65.1590338710923; 
 Sun, 24 May 2020 09:45:10 -0700 (PDT)
Received: from localhost.localdomain (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id y207sm16918972wmd.7.2020.05.24.09.45.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 May 2020 09:45:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] hw/unicore32/puv3: Use qemu_log_mask(ERROR) instead of debug
 printf()
Date: Sun, 24 May 2020 18:45:03 +0200
Message-Id: <20200524164503.11944-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
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
Cc: qemu-trivial@nongnu.org, Guan Xuetao <gxt@mprc.pku.edu.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Replace some debug printf() calls by qemu_log_mask(LOG_GUEST_ERROR).

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/dma/puv3_dma.c   |  9 +++++++--
 hw/gpio/puv3_gpio.c | 15 +++++++++++----
 hw/intc/puv3_intc.c |  9 +++++++--
 hw/misc/puv3_pm.c   |  9 +++++++--
 hw/timer/puv3_ost.c |  9 +++++++--
 hw/unicore32/puv3.c |  2 --
 6 files changed, 39 insertions(+), 14 deletions(-)

diff --git a/hw/dma/puv3_dma.c b/hw/dma/puv3_dma.c
index 5488d388a9..7fa979180f 100644
--- a/hw/dma/puv3_dma.c
+++ b/hw/dma/puv3_dma.c
@@ -15,6 +15,7 @@
 #undef DEBUG_PUV3
 #include "hw/unicore32/puv3.h"
 #include "qemu/module.h"
+#include "qemu/log.h"
 
 #define PUV3_DMA_CH_NR          (6)
 #define PUV3_DMA_CH_MASK        (0xff)
@@ -43,7 +44,9 @@ static uint64_t puv3_dma_read(void *opaque, hwaddr offset,
         ret = s->reg_CFG[PUV3_DMA_CH(offset)];
         break;
     default:
-        DPRINTF("Bad offset 0x%x\n", offset);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Bad read offset 0x%"HWADDR_PRIx"\n",
+                      __func__, offset);
     }
     DPRINTF("offset 0x%x, value 0x%x\n", offset, ret);
 
@@ -62,7 +65,9 @@ static void puv3_dma_write(void *opaque, hwaddr offset,
         s->reg_CFG[PUV3_DMA_CH(offset)] = value;
         break;
     default:
-        DPRINTF("Bad offset 0x%x\n", offset);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Bad write offset 0x%"HWADDR_PRIx"\n",
+                      __func__, offset);
     }
     DPRINTF("offset 0x%x, value 0x%x\n", offset, value);
 }
diff --git a/hw/gpio/puv3_gpio.c b/hw/gpio/puv3_gpio.c
index d19e342514..7362b6715f 100644
--- a/hw/gpio/puv3_gpio.c
+++ b/hw/gpio/puv3_gpio.c
@@ -15,6 +15,7 @@
 #undef DEBUG_PUV3
 #include "hw/unicore32/puv3.h"
 #include "qemu/module.h"
+#include "qemu/log.h"
 
 #define TYPE_PUV3_GPIO "puv3_gpio"
 #define PUV3_GPIO(obj) OBJECT_CHECK(PUV3GPIOState, (obj), TYPE_PUV3_GPIO)
@@ -47,7 +48,9 @@ static uint64_t puv3_gpio_read(void *opaque, hwaddr offset,
         ret = s->reg_GPIR;
         break;
     default:
-        DPRINTF("Bad offset 0x%x\n", offset);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Bad read offset 0x%"HWADDR_PRIx"\n",
+                      __func__, offset);
     }
     DPRINTF("offset 0x%x, value 0x%x\n", offset, ret);
 
@@ -68,14 +71,16 @@ static void puv3_gpio_write(void *opaque, hwaddr offset,
         if (s->reg_GPDR & value) {
             s->reg_GPLR |= value;
         } else {
-            DPRINTF("Write gpio input port error!");
+            qemu_log_mask(LOG_GUEST_ERROR, "%s: Write gpio input port\n",
+                          __func__);
         }
         break;
     case 0x0c:
         if (s->reg_GPDR & value) {
             s->reg_GPLR &= ~value;
         } else {
-            DPRINTF("Write gpio input port error!");
+            qemu_log_mask(LOG_GUEST_ERROR, "%s: Write gpio input port\n",
+                          __func__);
         }
         break;
     case 0x10: /* GRER */
@@ -86,7 +91,9 @@ static void puv3_gpio_write(void *opaque, hwaddr offset,
         s->reg_GPIR = value;
         break;
     default:
-        DPRINTF("Bad offset 0x%x\n", offset);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Bad write offset 0x%"HWADDR_PRIx"\n",
+                      __func__, offset);
     }
 }
 
diff --git a/hw/intc/puv3_intc.c b/hw/intc/puv3_intc.c
index e018955ce8..090d4839d1 100644
--- a/hw/intc/puv3_intc.c
+++ b/hw/intc/puv3_intc.c
@@ -16,6 +16,7 @@
 #undef DEBUG_PUV3
 #include "hw/unicore32/puv3.h"
 #include "qemu/module.h"
+#include "qemu/log.h"
 
 #define TYPE_PUV3_INTC "puv3_intc"
 #define PUV3_INTC(obj) OBJECT_CHECK(PUV3INTCState, (obj), TYPE_PUV3_INTC)
@@ -68,7 +69,9 @@ static uint64_t puv3_intc_read(void *opaque, hwaddr offset,
         ret = s->reg_ICPR; /* the same value with ICPR */
         break;
     default:
-        DPRINTF("Bad offset %x\n", (int)offset);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Bad read offset 0x%"HWADDR_PRIx"\n",
+                      __func__, offset);
     }
     DPRINTF("offset 0x%x, value 0x%x\n", offset, ret);
     return ret;
@@ -88,7 +91,9 @@ static void puv3_intc_write(void *opaque, hwaddr offset,
         s->reg_ICMR = value;
         break;
     default:
-        DPRINTF("Bad offset 0x%x\n", (int)offset);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Bad write offset 0x%"HWADDR_PRIx"\n",
+                      __func__, offset);
         return;
     }
     puv3_intc_update(s);
diff --git a/hw/misc/puv3_pm.c b/hw/misc/puv3_pm.c
index c213500d9c..8989d363cd 100644
--- a/hw/misc/puv3_pm.c
+++ b/hw/misc/puv3_pm.c
@@ -15,6 +15,7 @@
 #undef DEBUG_PUV3
 #include "hw/unicore32/puv3.h"
 #include "qemu/module.h"
+#include "qemu/log.h"
 
 #define TYPE_PUV3_PM "puv3_pm"
 #define PUV3_PM(obj) OBJECT_CHECK(PUV3PMState, (obj), TYPE_PUV3_PM)
@@ -73,7 +74,9 @@ static uint64_t puv3_pm_read(void *opaque, hwaddr offset,
         ret = 0x7;
         break;
     default:
-        DPRINTF("Bad offset 0x%x\n", offset);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Bad read offset 0x%"HWADDR_PRIx"\n",
+                      __func__, offset);
     }
     DPRINTF("offset 0x%x, value 0x%x\n", offset, ret);
 
@@ -105,7 +108,9 @@ static void puv3_pm_write(void *opaque, hwaddr offset,
     case 0x38:
         break;
     default:
-        DPRINTF("Bad offset 0x%x\n", offset);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Bad write offset 0x%"HWADDR_PRIx"\n",
+                      __func__, offset);
     }
     DPRINTF("offset 0x%x, value 0x%x\n", offset, value);
 }
diff --git a/hw/timer/puv3_ost.c b/hw/timer/puv3_ost.c
index 697519593b..f76b0bb1ca 100644
--- a/hw/timer/puv3_ost.c
+++ b/hw/timer/puv3_ost.c
@@ -14,6 +14,7 @@
 #include "hw/irq.h"
 #include "hw/ptimer.h"
 #include "qemu/module.h"
+#include "qemu/log.h"
 
 #undef DEBUG_PUV3
 #include "hw/unicore32/puv3.h"
@@ -52,7 +53,9 @@ static uint64_t puv3_ost_read(void *opaque, hwaddr offset,
         ret = s->reg_OIER;
         break;
     default:
-        DPRINTF("Bad offset %x\n", (int)offset);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Bad read offset 0x%"HWADDR_PRIx"\n",
+                      __func__, offset);
     }
     DPRINTF("offset 0x%x, value 0x%x\n", offset, ret);
     return ret;
@@ -88,7 +91,9 @@ static void puv3_ost_write(void *opaque, hwaddr offset,
         s->reg_OIER = value;
         break;
     default:
-        DPRINTF("Bad offset %x\n", (int)offset);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Bad write offset 0x%"HWADDR_PRIx"\n",
+                      __func__, offset);
     }
 }
 
diff --git a/hw/unicore32/puv3.c b/hw/unicore32/puv3.c
index 7f9c0238fe..eacacb4249 100644
--- a/hw/unicore32/puv3.c
+++ b/hw/unicore32/puv3.c
@@ -16,8 +16,6 @@
 #include "hw/boards.h"
 #include "hw/loader.h"
 #include "sysemu/qtest.h"
-
-#undef DEBUG_PUV3
 #include "hw/unicore32/puv3.h"
 #include "hw/input/i8042.h"
 #include "hw/irq.h"
-- 
2.21.3



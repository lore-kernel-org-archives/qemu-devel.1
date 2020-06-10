Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 188ACC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 13:18:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE2A8206F4
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 13:18:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE2A8206F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jj0cL-0001Dh-W3
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 09:18:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45174)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jj0Us-0007ny-KO; Wed, 10 Jun 2020 09:10:26 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:60589)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1jj0Uo-0003aw-CQ; Wed, 10 Jun 2020 09:10:26 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1M1HmE-1jlkJp45fe-002ney; Wed, 10 Jun 2020 15:10:16 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL v2 04/16] hw/unicore32/puv3: Use qemu_log_mask(ERROR) instead
 of debug printf()
Date: Wed, 10 Jun 2020 15:09:59 +0200
Message-Id: <20200610131011.1941209-5-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200610131011.1941209-1-laurent@vivier.eu>
References: <20200610131011.1941209-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:udKSw+ayb4qkPch96FQ6c6Qp0+yPcNEDmVG1mO6qGqHvNr+A+0a
 gGlGEAMM0eKPx//uH1NfBlWtO7eoGnErH/jf1ha2tjBSdQ6zcAUfh/Ju69dQoc5ABHMw2vb
 XZVsWR5KqPG5mp3FdiufXuOBWs4pi77/qsiLCuah8ZgjtkfFKBvoHPxjTXltXvCLcCGcBHs
 taYTiUmndP0+EO4wfFPGQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kyXEb8IGuek=:sz3n+Bf06uKaEJai1sf5au
 RcjCICKWQ6TTgp84BNJwPwg5KJTL/SJeArgYelBoz7M9kgdfrGnKw0/t97jhc4XyUsvWJxHc8
 Zi8wbCXfx4tw2R/F51uJ7RM6jtxTDJFi7G1Sm+MBdlMNH6Ccd3gfTpWYciTnM5L9JvezBf/Xr
 G3dqZWsRplRC9QQIuVbAzOvE06kuD89NZrLI2To6sw/hrTEbJqzd3ohdXTtORfUJFuE+5oNcr
 9RobuRrgO89Ubp6If426XJ4TZc2qW1aSV2WyWtgWQAO5Aox8990cbPnbfwfxLNotN6uqB0bca
 NOPn4dNSRkYIhzXXNNaRHbiwEHv0fd/oUpVsi/cWEum09euglCMN2Ndo09wSvgrwMBPdBZXv+
 W/7Vb//Y6h8GEnkYDpEbrx6+XGDGh0MRLTfUOjiE3bE0oFI4dYrDxkg39mSRsi1TcYmffsOdA
 POyU3vadnyLXHr42BgJ/zfC8VuXWnNv2aiGDmKAUMRa0Lg3Q66JHqzlCuVhLs9H8vW1sVf8US
 kccjdhOR/982pQ024M9JB8iRVZqRBajSqYpPTLwtJcnU9AEleCTCXx6992u5fY4xX2bDsN4zi
 9qXm4/8PqqOQs/dNz7W5s0hFKbCxQBVtrbsxSvssHEixG1SM3O/1MXkRXJgq3neEajUluUF3j
 ddwMgHLytGD0XBHTX3Szs0JwdUD/TK+Ry/+eQqGRapPEmxbZVgqSA04BAPlNpYREYuCVgYuu7
 Kw9RgvtiUT7M9qzQnaTNJ/85hRflRmPc8nDAJYQIZplz6WN1vhEcq+43nSbKueMPABcs6q6AR
 FD0cfYjHpG3BdLcCxSLVmAYY+u1bGzbV1eXvhOyRCC/uBm7R6w0Ra2Z3U6Lr3tnFslgdHmj
Received-SPF: none client-ip=212.227.126.135; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/10 08:14:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-trivial@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Replace some debug printf() calls by qemu_log_mask(LOG_GUEST_ERROR).

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20200524164503.11944-1-f4bug@amsat.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/dma/puv3_dma.c   |  9 +++++++--
 hw/gpio/puv3_gpio.c | 15 +++++++++++----
 hw/intc/puv3_intc.c |  9 +++++++--
 hw/misc/puv3_pm.c   |  9 +++++++--
 hw/timer/puv3_ost.c |  9 +++++++--
 hw/unicore32/puv3.c |  2 --
 6 files changed, 39 insertions(+), 14 deletions(-)

diff --git a/hw/dma/puv3_dma.c b/hw/dma/puv3_dma.c
index 5488d388a962..7fa979180f3a 100644
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
index d19e3425140e..7362b6715f20 100644
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
index e018955ce8cb..090d4839d103 100644
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
index c213500d9c3c..8989d363cd0a 100644
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
index 697519593bb5..f76b0bb1cac7 100644
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
index 7f9c0238fe0f..eacacb4249bd 100644
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
2.26.2



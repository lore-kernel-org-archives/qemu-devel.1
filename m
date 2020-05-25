Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7CDBC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 11:43:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E92E20723
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 11:43:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BSgbtOM2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E92E20723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdBVw-0008B7-F9
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 07:43:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59910)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdBU3-0005b7-MX; Mon, 25 May 2020 07:41:31 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:43640)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdBU2-00043U-Do; Mon, 25 May 2020 07:41:31 -0400
Received: by mail-wr1-x443.google.com with SMTP id i15so16752849wrx.10;
 Mon, 25 May 2020 04:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qMBsY0ZOgJppHVE8tuHKmerA5axchfe522twEzYD9JA=;
 b=BSgbtOM2DSQ8XfOVGRR2dsKrEwhAbdZaM9yG1ZQTuvOSWUSXYcsF3TzOFUMLfXCD8H
 Yzj1HLpaOqg6fWfKpvvIMULZVhuvhxrvR6yHFXb7mASB0bktFRtLs1IANffAASWXmGvb
 nve8A4ApbxczEwgquW7pNmbjQwg2SSOVKe/wddyr1W/AvtyF0jkK4wi+XUrNpPPpJ5zW
 ajucPvdEm4+1PA78YPlBAl/n8V+zdU5Xrdrt3/Rc60hL0gjksLHeUCjddLlTvfDXIliA
 OvPDQzCInq4Imb4nxLJyRbwAWkt6TgVEOeWCwvzhCxjHc9Vuq4952IzVjhI1Bgs1gzhY
 5PLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=qMBsY0ZOgJppHVE8tuHKmerA5axchfe522twEzYD9JA=;
 b=fuBDvyi3pMgr9zB/Fc5wB4v2Ko3TRFocqiFCqpYfqC05Mlr1kVO9madK74ja5fXz38
 cMYDexfAZXXY3isPncRqjk4UVLGRy4GIbXbQ0bvB977jMxobqhlahhGWlckglcz3kUG8
 d8ygj/mqsiLUojipG8Wmo2YS3iEq4lVh7L/PnvK4NmYYLFxW+mM+ngVKK53ouslbZGuK
 jcbdfAVv3g8lWmf9MdgAAz1ezS2CO136NGuqmpBBwU72UmAnaiSvM9K7UkLI0+D7IrrX
 p6zAtXumwgUjNV6bWnb2JV3YU9DjOASZFR9WNmkoRyqec/xEGIwlzPEyjo0fSX8qxMa/
 xPkQ==
X-Gm-Message-State: AOAM531+7o8BjdUBWqUFX0OLr6wNIMPkz8Ugt6HTVbQy1a9c5M9WGmx6
 pEm4YO6NSHumYCw7w0iYC2cHTqZ3eg8=
X-Google-Smtp-Source: ABdhPJwmCBA3LS/rqiVo0G85upMsGoBEK281/e1QJS2P0gBR7LChAeNfZZGF2FzxYRU70gdTdqGK+w==
X-Received: by 2002:a05:6000:146:: with SMTP id
 r6mr15550002wrx.9.1590406888080; 
 Mon, 25 May 2020 04:41:28 -0700 (PDT)
Received: from localhost.localdomain (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id b132sm4936159wmh.3.2020.05.25.04.41.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2020 04:41:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] hw/arm/pxa2xx: Replace printf() call by qemu_log_mask()
Date: Mon, 25 May 2020 13:41:23 +0200
Message-Id: <20200525114123.21317-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200525114123.21317-1-f4bug@amsat.org>
References: <20200525114123.21317-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
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
Cc: qemu-trivial@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Replace printf() calls by qemu_log_mask(), which is disabled
by default. This avoid flooding the terminal when fuzzing the
device.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/pxa2xx.c         | 66 ++++++++++++++++++++++++++++++-----------
 hw/display/pxa2xx_lcd.c | 26 ++++++++--------
 2 files changed, 63 insertions(+), 29 deletions(-)

diff --git a/hw/arm/pxa2xx.c b/hw/arm/pxa2xx.c
index 336c9bad4a..e649f8930c 100644
--- a/hw/arm/pxa2xx.c
+++ b/hw/arm/pxa2xx.c
@@ -26,6 +26,7 @@
 #include "sysemu/blockdev.h"
 #include "sysemu/qtest.h"
 #include "qemu/cutils.h"
+#include "qemu/log.h"
 
 static struct {
     hwaddr io_base;
@@ -112,7 +113,9 @@ static uint64_t pxa2xx_pm_read(void *opaque, hwaddr addr,
         return s->pm_regs[addr >> 2];
     default:
     fail:
-        printf("%s: Bad register " REG_FMT "\n", __func__, addr);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Bad read offset 0x%"HWADDR_PRIx"\n",
+                      __func__, addr);
         break;
     }
     return 0;
@@ -143,8 +146,9 @@ static void pxa2xx_pm_write(void *opaque, hwaddr addr,
             s->pm_regs[addr >> 2] = value;
             break;
         }
-
-        printf("%s: Bad register " REG_FMT "\n", __func__, addr);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Bad write offset 0x%"HWADDR_PRIx"\n",
+                      __func__, addr);
         break;
     }
 }
@@ -185,7 +189,9 @@ static uint64_t pxa2xx_cm_read(void *opaque, hwaddr addr,
         return s->cm_regs[CCCR >> 2] | (3 << 28);
 
     default:
-        printf("%s: Bad register " REG_FMT "\n", __func__, addr);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Bad read offset 0x%"HWADDR_PRIx"\n",
+                      __func__, addr);
         break;
     }
     return 0;
@@ -210,7 +216,9 @@ static void pxa2xx_cm_write(void *opaque, hwaddr addr,
         break;
 
     default:
-        printf("%s: Bad register " REG_FMT "\n", __func__, addr);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Bad write offset 0x%"HWADDR_PRIx"\n",
+                      __func__, addr);
         break;
     }
 }
@@ -415,7 +423,9 @@ static uint64_t pxa2xx_mm_read(void *opaque, hwaddr addr,
             return s->mm_regs[addr >> 2];
         /* fall through */
     default:
-        printf("%s: Bad register " REG_FMT "\n", __func__, addr);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Bad read offset 0x%"HWADDR_PRIx"\n",
+                      __func__, addr);
         break;
     }
     return 0;
@@ -434,7 +444,9 @@ static void pxa2xx_mm_write(void *opaque, hwaddr addr,
         }
 
     default:
-        printf("%s: Bad register " REG_FMT "\n", __func__, addr);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Bad write offset 0x%"HWADDR_PRIx"\n",
+                      __func__, addr);
         break;
     }
 }
@@ -641,7 +653,9 @@ static uint64_t pxa2xx_ssp_read(void *opaque, hwaddr addr,
     case SSACD:
         return s->ssacd;
     default:
-        printf("%s: Bad register " REG_FMT "\n", __func__, addr);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Bad read offset 0x%"HWADDR_PRIx"\n",
+                      __func__, addr);
         break;
     }
     return 0;
@@ -733,7 +747,9 @@ static void pxa2xx_ssp_write(void *opaque, hwaddr addr,
         break;
 
     default:
-        printf("%s: Bad register " REG_FMT "\n", __func__, addr);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Bad write offset 0x%"HWADDR_PRIx"\n",
+                      __func__, addr);
         break;
     }
 }
@@ -995,7 +1011,9 @@ static uint64_t pxa2xx_rtc_read(void *opaque, hwaddr addr,
         else
             return s->last_swcr;
     default:
-        printf("%s: Bad register " REG_FMT "\n", __func__, addr);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Bad read offset 0x%"HWADDR_PRIx"\n",
+                      __func__, addr);
         break;
     }
     return 0;
@@ -1101,7 +1119,9 @@ static void pxa2xx_rtc_write(void *opaque, hwaddr addr,
         break;
 
     default:
-        printf("%s: Bad register " REG_FMT "\n", __func__, addr);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Bad write offset 0x%"HWADDR_PRIx"\n",
+                      __func__, addr);
     }
 }
 
@@ -1354,7 +1374,9 @@ static uint64_t pxa2xx_i2c_read(void *opaque, hwaddr addr,
             s->ibmr = 0;
         return s->ibmr;
     default:
-        printf("%s: Bad register " REG_FMT "\n", __func__, addr);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Bad read offset 0x%"HWADDR_PRIx"\n",
+                      __func__, addr);
         break;
     }
     return 0;
@@ -1427,7 +1449,9 @@ static void pxa2xx_i2c_write(void *opaque, hwaddr addr,
         break;
 
     default:
-        printf("%s: Bad register " REG_FMT "\n", __func__, addr);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Bad write offset 0x%"HWADDR_PRIx"\n",
+                      __func__, addr);
     }
 }
 
@@ -1628,7 +1652,9 @@ static uint64_t pxa2xx_i2s_read(void *opaque, hwaddr addr,
         }
         return 0;
     default:
-        printf("%s: Bad register " REG_FMT "\n", __func__, addr);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Bad read offset 0x%"HWADDR_PRIx"\n",
+                      __func__, addr);
         break;
     }
     return 0;
@@ -1685,7 +1711,9 @@ static void pxa2xx_i2s_write(void *opaque, hwaddr addr,
         }
         break;
     default:
-        printf("%s: Bad register " REG_FMT "\n", __func__, addr);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Bad write offset 0x%"HWADDR_PRIx"\n",
+                      __func__, addr);
     }
 }
 
@@ -1870,7 +1898,9 @@ static uint64_t pxa2xx_fir_read(void *opaque, hwaddr addr,
     case ICFOR:
         return s->rx_len;
     default:
-        printf("%s: Bad register " REG_FMT "\n", __func__, addr);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Bad read offset 0x%"HWADDR_PRIx"\n",
+                      __func__, addr);
         break;
     }
     return 0;
@@ -1922,7 +1952,9 @@ static void pxa2xx_fir_write(void *opaque, hwaddr addr,
     case ICFOR:
         break;
     default:
-        printf("%s: Bad register " REG_FMT "\n", __func__, addr);
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Bad write offset 0x%"HWADDR_PRIx"\n",
+                      __func__, addr);
     }
 }
 
diff --git a/hw/display/pxa2xx_lcd.c b/hw/display/pxa2xx_lcd.c
index d5f2e82a4e..ff90104b80 100644
--- a/hw/display/pxa2xx_lcd.c
+++ b/hw/display/pxa2xx_lcd.c
@@ -426,9 +426,10 @@ static void pxa2xx_lcdc_write(void *opaque, hwaddr offset,
         if ((s->control[0] & LCCR0_ENB) && !(value & LCCR0_ENB))
             s->status[0] |= LCSR0_QD;
 
-        if (!(s->control[0] & LCCR0_LCDT) && (value & LCCR0_LCDT))
-            printf("%s: internal frame buffer unsupported\n", __func__);
-
+        if (!(s->control[0] & LCCR0_LCDT) && (value & LCCR0_LCDT)) {
+            qemu_log_mask(LOG_UNIMP,
+                          "%s: internal frame buffer unsupported\n", __func__);
+        }
         if ((s->control[3] & LCCR3_API) &&
                 (value & LCCR0_ENB) && !(value & LCCR0_LCDT))
             s->status[0] |= LCSR0_ABC;
@@ -462,9 +463,9 @@ static void pxa2xx_lcdc_write(void *opaque, hwaddr offset,
         break;
 
     case OVL1C1:
-        if (!(s->ovl1c[0] & OVLC1_EN) && (value & OVLC1_EN))
-            printf("%s: Overlay 1 not supported\n", __func__);
-
+        if (!(s->ovl1c[0] & OVLC1_EN) && (value & OVLC1_EN)) {
+            qemu_log_mask(LOG_UNIMP, "%s: Overlay 1 not supported\n", __func__);
+        }
         s->ovl1c[0] = value & 0x80ffffff;
         s->dma_ch[1].up = (value & OVLC1_EN) || (s->control[0] & LCCR0_SDS);
         break;
@@ -474,9 +475,9 @@ static void pxa2xx_lcdc_write(void *opaque, hwaddr offset,
         break;
 
     case OVL2C1:
-        if (!(s->ovl2c[0] & OVLC1_EN) && (value & OVLC1_EN))
-            printf("%s: Overlay 2 not supported\n", __func__);
-
+        if (!(s->ovl2c[0] & OVLC1_EN) && (value & OVLC1_EN)) {
+            qemu_log_mask(LOG_UNIMP, "%s: Overlay 2 not supported\n", __func__);
+        }
         s->ovl2c[0] = value & 0x80ffffff;
         s->dma_ch[2].up = !!(value & OVLC1_EN);
         s->dma_ch[3].up = !!(value & OVLC1_EN);
@@ -488,9 +489,10 @@ static void pxa2xx_lcdc_write(void *opaque, hwaddr offset,
         break;
 
     case CCR:
-        if (!(s->ccr & CCR_CEN) && (value & CCR_CEN))
-            printf("%s: Hardware cursor unimplemented\n", __func__);
-
+        if (!(s->ccr & CCR_CEN) && (value & CCR_CEN)) {
+            qemu_log_mask(LOG_UNIMP,
+                          "%s: Hardware cursor unimplemented\n", __func__);
+        }
         s->ccr = value & 0x81ffffe7;
         s->dma_ch[5].up = !!(value & CCR_CEN);
         break;
-- 
2.21.3



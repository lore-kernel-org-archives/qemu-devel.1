Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB88C4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 17:08:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9DE12133F
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 17:08:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LGrWquzi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9DE12133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK3pQ-0000l6-Gc
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 13:08:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37538)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iK2qy-0005eA-Ec
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:05:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iK2qw-0008IR-Ru
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:05:48 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:39957)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iK2qw-0008Hm-L2
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:05:46 -0400
Received: by mail-wm1-x331.google.com with SMTP id b24so17302371wmj.5
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 09:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=Ww7uD8nZKum3eksZ+bUCguC3h68kQcYmu1GSBn+62iQ=;
 b=LGrWquzi7bZaZCLybKH82ppX4I5vqUD6k6qMEbCZB88T7o2iots1smC8t4Uc2XRMPn
 JRsG0rxIyQCDNQTa0/oQ7no01iL5mXt2Yw4pQ46pLgyv59EGKD8TPdkWl/3188pfB57y
 lrKDgAOysAh0ibb1PIgCwMBGPpe6BMaya1/aLYLDxQTxJ9qvNrlQ0E0widSoS5ZQdGyX
 dTUthy7OO+Sv9CnYLkgDV7ZDKFsX0VmUp8ls22yTnNZnKvGsxxN5IEKAPncnH7xMQVde
 E4xewUccZK5mspw28TuZv3HWfG+WfDEgz45wUVnX9xYiHO05xsIaVkDD/Et4u6o5QFME
 ZSZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Ww7uD8nZKum3eksZ+bUCguC3h68kQcYmu1GSBn+62iQ=;
 b=Auz8dnQiysY4qN+jqRStqC/xaY5mgNfJtLzQnyo0Pa7fVoTbdn2yWXO+pncMsLZh6+
 V5gjb9v0Pjg7jGiLqYqZ7aQ1ZOsdBTePX6iHJuy8TLG8UInXoHU2sixk2Ayn/mmQ9Dk2
 Ol79v1QpEnGFkglqN2Szc+EaLFQANMD3jGCnMCuAJ2NR7n3AHhWLOrTHBLcFAnEG3BKJ
 tcruSLHSzmBe4CPCArxuUPOIj0VI/SOIdlOFpICk5ZpJ1gIKOIuwQmulE2Wuou/Wyr6+
 SsBHBmzHapSmKH0RO9Bgar24Pp2HUqxP3KThzvmJ+JZBUCr93EI8pB5Y9zDLE/LoFpvw
 gzfg==
X-Gm-Message-State: APjAAAX7LZOnJudRyWBbvvuqTI3xco6yHMcJPIelXpKDpbRE1hjnaEgD
 sIG44ZFY7dN/330Qcenx8C3gkGiCiGqgEw==
X-Google-Smtp-Source: APXvYqxaWBChWSQGOOwVRF5Xk05G6N4LVbdwhdxKcncNU4Ss/hz1idinC3kZMhQ7lLbXto3TbyJbkA==
X-Received: by 2002:a7b:c444:: with SMTP id l4mr15808387wmi.49.1571069145121; 
 Mon, 14 Oct 2019 09:05:45 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 5sm18029779wrk.86.2019.10.14.09.05.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 09:05:43 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 64/68] hw/arm/bcm2835_peripherals: Improve logging
Date: Mon, 14 Oct 2019 17:04:00 +0100
Message-Id: <20191014160404.19553-65-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191014160404.19553-1-peter.maydell@linaro.org>
References: <20191014160404.19553-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::331
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

Various logging improvements as once:
- Use 0x prefix for hex numbers
- Display value written during write accesses
- Move some logs from GUEST_ERROR to UNIMP

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Cleber Rosa <crosa@redhat.com>
Message-id: 20190926173428.10713-3-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/char/bcm2835_aux.c      |  5 +++--
 hw/dma/bcm2835_dma.c       |  8 ++++----
 hw/intc/bcm2836_control.c  |  7 ++++---
 hw/misc/bcm2835_mbox.c     |  7 ++++---
 hw/misc/bcm2835_property.c | 16 ++++++++++------
 5 files changed, 25 insertions(+), 18 deletions(-)

diff --git a/hw/char/bcm2835_aux.c b/hw/char/bcm2835_aux.c
index 3f855196e3a..a6fc1bf152b 100644
--- a/hw/char/bcm2835_aux.c
+++ b/hw/char/bcm2835_aux.c
@@ -162,8 +162,9 @@ static void bcm2835_aux_write(void *opaque, hwaddr offset, uint64_t value,
     switch (offset) {
     case AUX_ENABLES:
         if (value != 1) {
-            qemu_log_mask(LOG_UNIMP, "%s: unsupported attempt to enable SPI "
-                          "or disable UART\n", __func__);
+            qemu_log_mask(LOG_UNIMP, "%s: unsupported attempt to enable SPI"
+                                     " or disable UART: 0x%"PRIx64"\n",
+                          __func__, value);
         }
         break;
 
diff --git a/hw/dma/bcm2835_dma.c b/hw/dma/bcm2835_dma.c
index 192bd377a00..6acc2b644ec 100644
--- a/hw/dma/bcm2835_dma.c
+++ b/hw/dma/bcm2835_dma.c
@@ -180,7 +180,7 @@ static uint64_t bcm2835_dma_read(BCM2835DMAState *s, hwaddr offset,
         res = ch->debug;
         break;
     default:
-        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset %"HWADDR_PRIx"\n",
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%"HWADDR_PRIx"\n",
                       __func__, offset);
         break;
     }
@@ -228,7 +228,7 @@ static void bcm2835_dma_write(BCM2835DMAState *s, hwaddr offset,
         ch->debug = value;
         break;
     default:
-        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset %"HWADDR_PRIx"\n",
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%"HWADDR_PRIx"\n",
                       __func__, offset);
         break;
     }
@@ -247,7 +247,7 @@ static uint64_t bcm2835_dma0_read(void *opaque, hwaddr offset, unsigned size)
         case BCM2708_DMA_ENABLE:
             return s->enable;
         default:
-            qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset %"HWADDR_PRIx"\n",
+            qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%"HWADDR_PRIx"\n",
                           __func__, offset);
             return 0;
         }
@@ -274,7 +274,7 @@ static void bcm2835_dma0_write(void *opaque, hwaddr offset, uint64_t value,
             s->enable = (value & 0xffff);
             break;
         default:
-            qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset %"HWADDR_PRIx"\n",
+            qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%"HWADDR_PRIx"\n",
                           __func__, offset);
         }
     }
diff --git a/hw/intc/bcm2836_control.c b/hw/intc/bcm2836_control.c
index 04229b8a17e..61f884ff9e7 100644
--- a/hw/intc/bcm2836_control.c
+++ b/hw/intc/bcm2836_control.c
@@ -264,7 +264,7 @@ static uint64_t bcm2836_control_read(void *opaque, hwaddr offset, unsigned size)
     } else if (offset >= REG_MBOX0_RDCLR && offset < REG_LIMIT) {
         return s->mailboxes[(offset - REG_MBOX0_RDCLR) >> 2];
     } else {
-        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset %"HWADDR_PRIx"\n",
+        qemu_log_mask(LOG_UNIMP, "%s: Unsupported offset 0x%"HWADDR_PRIx"\n",
                       __func__, offset);
         return 0;
     }
@@ -293,8 +293,9 @@ static void bcm2836_control_write(void *opaque, hwaddr offset,
     } else if (offset >= REG_MBOX0_RDCLR && offset < REG_LIMIT) {
         s->mailboxes[(offset - REG_MBOX0_RDCLR) >> 2] &= ~val;
     } else {
-        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset %"HWADDR_PRIx"\n",
-                      __func__, offset);
+        qemu_log_mask(LOG_UNIMP, "%s: Unsupported offset 0x%"HWADDR_PRIx
+                                 " value 0x%"PRIx64"\n",
+                      __func__, offset, val);
         return;
     }
 
diff --git a/hw/misc/bcm2835_mbox.c b/hw/misc/bcm2835_mbox.c
index 79bad116311..7690b9afaf8 100644
--- a/hw/misc/bcm2835_mbox.c
+++ b/hw/misc/bcm2835_mbox.c
@@ -176,7 +176,7 @@ static uint64_t bcm2835_mbox_read(void *opaque, hwaddr offset, unsigned size)
         break;
 
     default:
-        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset %"HWADDR_PRIx"\n",
+        qemu_log_mask(LOG_UNIMP, "%s: Unsupported offset 0x%"HWADDR_PRIx"\n",
                       __func__, offset);
         return 0;
     }
@@ -228,8 +228,9 @@ static void bcm2835_mbox_write(void *opaque, hwaddr offset,
         break;
 
     default:
-        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset %"HWADDR_PRIx"\n",
-                      __func__, offset);
+        qemu_log_mask(LOG_UNIMP, "%s: Unsupported offset 0x%"HWADDR_PRIx
+                                 " value 0x%"PRIx64"\n",
+                      __func__, offset, value);
         return;
     }
 
diff --git a/hw/misc/bcm2835_property.c b/hw/misc/bcm2835_property.c
index d86d510572a..0a1a3eb5d92 100644
--- a/hw/misc/bcm2835_property.c
+++ b/hw/misc/bcm2835_property.c
@@ -56,7 +56,8 @@ static void bcm2835_property_mbox_push(BCM2835PropertyState *s, uint32_t value)
             break;
         case 0x00010001: /* Get board model */
             qemu_log_mask(LOG_UNIMP,
-                          "bcm2835_property: %x get board model NYI\n", tag);
+                          "bcm2835_property: 0x%08x get board model NYI\n",
+                          tag);
             resplen = 4;
             break;
         case 0x00010002: /* Get board revision */
@@ -69,7 +70,8 @@ static void bcm2835_property_mbox_push(BCM2835PropertyState *s, uint32_t value)
             break;
         case 0x00010004: /* Get board serial */
             qemu_log_mask(LOG_UNIMP,
-                          "bcm2835_property: %x get board serial NYI\n", tag);
+                          "bcm2835_property: 0x%08x get board serial NYI\n",
+                          tag);
             resplen = 8;
             break;
         case 0x00010005: /* Get ARM memory */
@@ -104,7 +106,8 @@ static void bcm2835_property_mbox_push(BCM2835PropertyState *s, uint32_t value)
 
         case 0x00038001: /* Set clock state */
             qemu_log_mask(LOG_UNIMP,
-                          "bcm2835_property: %x set clock state NYI\n", tag);
+                          "bcm2835_property: 0x%08x set clock state NYI\n",
+                          tag);
             resplen = 8;
             break;
 
@@ -129,7 +132,8 @@ static void bcm2835_property_mbox_push(BCM2835PropertyState *s, uint32_t value)
         case 0x00038004: /* Set max clock rate */
         case 0x00038007: /* Set min clock rate */
             qemu_log_mask(LOG_UNIMP,
-                          "bcm2835_property: %x set clock rates NYI\n", tag);
+                          "bcm2835_property: 0x%08x set clock rate NYI\n",
+                          tag);
             resplen = 8;
             break;
 
@@ -274,8 +278,8 @@ static void bcm2835_property_mbox_push(BCM2835PropertyState *s, uint32_t value)
             break;
 
         default:
-            qemu_log_mask(LOG_GUEST_ERROR,
-                          "bcm2835_property: unhandled tag %08x\n", tag);
+            qemu_log_mask(LOG_UNIMP,
+                          "bcm2835_property: unhandled tag 0x%08x\n", tag);
             break;
         }
 
-- 
2.20.1



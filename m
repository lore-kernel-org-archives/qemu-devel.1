Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F253AC5B578
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 23:07:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69E2A20B7C
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 23:07:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C2olxWY4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69E2A20B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hi5OX-0006mb-Kn
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 19:07:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33283)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hi3cD-00040z-Rn
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 17:13:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hi3cB-00011F-NU
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 17:13:33 -0400
Received: from mail-wm1-f46.google.com ([209.85.128.46]:37192)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hi3c9-0000yu-JV
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 17:13:29 -0400
Received: by mail-wm1-f46.google.com with SMTP id f17so996371wme.2
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 14:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=5GuL1wde7cGfVlpJxuRJAQdP3IMbXq3IqGGP+UBMbD4=;
 b=C2olxWY4u4LzEd0U8iTgCmdCSrkRUhX7sYoDyorstGXOUPseIQKqaOhrlRM61CGifZ
 Lk5b/8E4JF3LTRVcsvjHVHaUC18hTHFGqqal7ZjuD0EOWDTqrrakTIFJ1gpET+SP4seO
 QrihmhP0TeywuTw/asHcpjU3C2BqvlABoisq4y8BkgRQFx9hLHbgxblmnFRdFT2aY2u8
 zm5WylSqryZDOY4O4aYeT0pRXdVaN+P+2IQKPws2rBu29yn51d6H3JSkLmEzjm04SHca
 s9t4RSlLZpvVy9WnP0FGyzFNWj9uiaV7jcqhVJKdL4J/D3+KsLXVirXbEeb5lquYdh1E
 5vng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5GuL1wde7cGfVlpJxuRJAQdP3IMbXq3IqGGP+UBMbD4=;
 b=oEBx1sB2ukPfrUto7BaxOrvpV+WclBFIIyqvNuzX1fdtrI+1tEEYyQvuew68qr0ta1
 0ojuKiCzm3xdZlW/YZF6Ny+D2iQBHP4+fXN2Cly0MYcinvoTlXRbuOKVEiVHT81thNbp
 7IPWdxQ6vJdRvrhPLXfmC3S8StHH4tcK2bo3S6h6bMoHP1s0K+FLR9qJDxyYhQV9iSVl
 Wij1cnCqrtChTUZWbwJ8DT3LU1qqc8SyiKL1M+hXuBk3d14sEIwJae2JfEckxwbxPngd
 azZiXcmn+4w0t/0xQfgAkiJfJPH/JCmY+qrJGRl2J3f2n5x9xvz1npSlGVWSvP6C1EJt
 x/Wg==
X-Gm-Message-State: APjAAAXLYu494BhXjLRv8X404maA6zQIShjanXeIIHR6GSDNammOFHw2
 xRbynwlYL0ed9T86wY9UFWYL4IOecynS8Q==
X-Google-Smtp-Source: APXvYqwipFEgNV3Tx5O9q5iQaCc0ixaJqgA9uPxGkkijlYvLGxk0r0zWUJTwSR5r32YEjnzI1LWIAw==
X-Received: by 2002:a1c:751a:: with SMTP id o26mr118393wmc.13.1561999210984;
 Mon, 01 Jul 2019 09:40:10 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id o6sm26573508wra.27.2019.07.01.09.40.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 01 Jul 2019 09:40:10 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon,  1 Jul 2019 17:39:21 +0100
Message-Id: <20190701163943.22313-25-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190701163943.22313-1-peter.maydell@linaro.org>
References: <20190701163943.22313-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.46
Subject: [Qemu-devel] [PULL 24/46] aspeed: vic: Add support for legacy
 register interface
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

From: Andrew Jeffery <andrew@aj.id.au>

The legacy interface only supported up to 32 IRQs, which became
restrictive around the AST2400 generation. QEMU support for the SoCs
started with the AST2400 along with an effort to reimplement and
upstream drivers for Linux, so up until this point the consumers of the
QEMU ASPEED support only required the 64 IRQ register interface.

In an effort to support older BMC firmware, add support for the 32 IRQ
interface.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Joel Stanley <joel@jms.id.au>
Message-id: 20190618165311.27066-22-clg@kaod.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/aspeed_vic.c | 105 ++++++++++++++++++++++++++-----------------
 1 file changed, 63 insertions(+), 42 deletions(-)

diff --git a/hw/intc/aspeed_vic.c b/hw/intc/aspeed_vic.c
index 927638d5322..266a309f3b4 100644
--- a/hw/intc/aspeed_vic.c
+++ b/hw/intc/aspeed_vic.c
@@ -104,54 +104,63 @@ static void aspeed_vic_set_irq(void *opaque, int irq, int level)
 
 static uint64_t aspeed_vic_read(void *opaque, hwaddr offset, unsigned size)
 {
-    uint64_t val;
-    const bool high = !!(offset & 0x4);
-    hwaddr n_offset = (offset & ~0x4);
     AspeedVICState *s = (AspeedVICState *)opaque;
+    hwaddr n_offset;
+    uint64_t val;
+    bool high;
 
     if (offset < AVIC_NEW_BASE_OFFSET) {
-        qemu_log_mask(LOG_UNIMP, "%s: Ignoring read from legacy registers "
-                      "at 0x%" HWADDR_PRIx "[%u]\n", __func__, offset, size);
-        return 0;
+        high = false;
+        n_offset = offset;
+    } else {
+        high = !!(offset & 0x4);
+        n_offset = (offset & ~0x4);
     }
 
-    n_offset -= AVIC_NEW_BASE_OFFSET;
-
     switch (n_offset) {
-    case 0x0: /* IRQ Status */
+    case 0x80: /* IRQ Status */
+    case 0x00:
         val = s->raw & ~s->select & s->enable;
         break;
-    case 0x08: /* FIQ Status */
+    case 0x88: /* FIQ Status */
+    case 0x04:
         val = s->raw & s->select & s->enable;
         break;
-    case 0x10: /* Raw Interrupt Status */
+    case 0x90: /* Raw Interrupt Status */
+    case 0x08:
         val = s->raw;
         break;
-    case 0x18: /* Interrupt Selection */
+    case 0x98: /* Interrupt Selection */
+    case 0x0c:
         val = s->select;
         break;
-    case 0x20: /* Interrupt Enable */
+    case 0xa0: /* Interrupt Enable */
+    case 0x10:
         val = s->enable;
         break;
-    case 0x30: /* Software Interrupt */
+    case 0xb0: /* Software Interrupt */
+    case 0x18:
         val = s->trigger;
         break;
-    case 0x40: /* Interrupt Sensitivity */
+    case 0xc0: /* Interrupt Sensitivity */
+    case 0x24:
         val = s->sense;
         break;
-    case 0x48: /* Interrupt Both Edge Trigger Control */
+    case 0xc8: /* Interrupt Both Edge Trigger Control */
+    case 0x28:
         val = s->dual_edge;
         break;
-    case 0x50: /* Interrupt Event */
+    case 0xd0: /* Interrupt Event */
+    case 0x2c:
         val = s->event;
         break;
-    case 0x60: /* Edge Triggered Interrupt Status */
+    case 0xe0: /* Edge Triggered Interrupt Status */
         val = s->raw & ~s->sense;
         break;
         /* Illegal */
-    case 0x28: /* Interrupt Enable Clear */
-    case 0x38: /* Software Interrupt Clear */
-    case 0x58: /* Edge Triggered Interrupt Clear */
+    case 0xa8: /* Interrupt Enable Clear */
+    case 0xb8: /* Software Interrupt Clear */
+    case 0xd8: /* Edge Triggered Interrupt Clear */
         qemu_log_mask(LOG_GUEST_ERROR,
                       "%s: Read of write-only register with offset 0x%"
                       HWADDR_PRIx "\n", __func__, offset);
@@ -166,6 +175,8 @@ static uint64_t aspeed_vic_read(void *opaque, hwaddr offset, unsigned size)
     }
     if (high) {
         val = extract64(val, 32, 19);
+    } else {
+        val = extract64(val, 0, 32);
     }
     trace_aspeed_vic_read(offset, size, val);
     return val;
@@ -174,19 +185,18 @@ static uint64_t aspeed_vic_read(void *opaque, hwaddr offset, unsigned size)
 static void aspeed_vic_write(void *opaque, hwaddr offset, uint64_t data,
                              unsigned size)
 {
-    const bool high = !!(offset & 0x4);
-    hwaddr n_offset = (offset & ~0x4);
     AspeedVICState *s = (AspeedVICState *)opaque;
+    hwaddr n_offset;
+    bool high;
 
     if (offset < AVIC_NEW_BASE_OFFSET) {
-        qemu_log_mask(LOG_UNIMP,
-                      "%s: Ignoring write to legacy registers at 0x%"
-                      HWADDR_PRIx "[%u] <- 0x%" PRIx64 "\n", __func__, offset,
-                      size, data);
-        return;
+        high = false;
+        n_offset = offset;
+    } else {
+        high = !!(offset & 0x4);
+        n_offset = (offset & ~0x4);
     }
 
-    n_offset -= AVIC_NEW_BASE_OFFSET;
     trace_aspeed_vic_write(offset, size, data);
 
     /* Given we have members using separate enable/clear registers, deposit64()
@@ -201,7 +211,8 @@ static void aspeed_vic_write(void *opaque, hwaddr offset, uint64_t data,
     }
 
     switch (n_offset) {
-    case 0x18: /* Interrupt Selection */
+    case 0x98: /* Interrupt Selection */
+    case 0x0c:
         /* Register has deposit64() semantics - overwrite requested 32 bits */
         if (high) {
             s->select &= AVIC_L_MASK;
@@ -210,21 +221,25 @@ static void aspeed_vic_write(void *opaque, hwaddr offset, uint64_t data,
         }
         s->select |= data;
         break;
-    case 0x20: /* Interrupt Enable */
+    case 0xa0: /* Interrupt Enable */
+    case 0x10:
         s->enable |= data;
         break;
-    case 0x28: /* Interrupt Enable Clear */
+    case 0xa8: /* Interrupt Enable Clear */
+    case 0x14:
         s->enable &= ~data;
         break;
-    case 0x30: /* Software Interrupt */
+    case 0xb0: /* Software Interrupt */
+    case 0x18:
         qemu_log_mask(LOG_UNIMP, "%s: Software interrupts unavailable. "
                       "IRQs requested: 0x%016" PRIx64 "\n", __func__, data);
         break;
-    case 0x38: /* Software Interrupt Clear */
+    case 0xb8: /* Software Interrupt Clear */
+    case 0x1c:
         qemu_log_mask(LOG_UNIMP, "%s: Software interrupts unavailable. "
                       "IRQs to be cleared: 0x%016" PRIx64 "\n", __func__, data);
         break;
-    case 0x50: /* Interrupt Event */
+    case 0xd0: /* Interrupt Event */
         /* Register has deposit64() semantics - overwrite the top four valid
          * IRQ bits, as only the top four IRQs (GPIOs) can change their event
          * type */
@@ -236,15 +251,21 @@ static void aspeed_vic_write(void *opaque, hwaddr offset, uint64_t data,
                           "Ignoring invalid write to interrupt event register");
         }
         break;
-    case 0x58: /* Edge Triggered Interrupt Clear */
+    case 0xd8: /* Edge Triggered Interrupt Clear */
+    case 0x38:
         s->raw &= ~(data & ~s->sense);
         break;
-    case 0x00: /* IRQ Status */
-    case 0x08: /* FIQ Status */
-    case 0x10: /* Raw Interrupt Status */
-    case 0x40: /* Interrupt Sensitivity */
-    case 0x48: /* Interrupt Both Edge Trigger Control */
-    case 0x60: /* Edge Triggered Interrupt Status */
+    case 0x80: /* IRQ Status */
+    case 0x00:
+    case 0x88: /* FIQ Status */
+    case 0x04:
+    case 0x90: /* Raw Interrupt Status */
+    case 0x08:
+    case 0xc0: /* Interrupt Sensitivity */
+    case 0x24:
+    case 0xc8: /* Interrupt Both Edge Trigger Control */
+    case 0x28:
+    case 0xe0: /* Edge Triggered Interrupt Status */
         qemu_log_mask(LOG_GUEST_ERROR,
                       "%s: Write of read-only register with offset 0x%"
                       HWADDR_PRIx "\n", __func__, offset);
-- 
2.20.1



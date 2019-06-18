Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00563C31E5B
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 17:42:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D52F520863
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 17:42:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D52F520863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60628 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdI8G-0005S9-Pk
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 13:42:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33041)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <clg@kaod.org>) id 1hdHP2-0001dc-4T
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 12:56:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1hdHP0-0006sP-6b
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 12:56:12 -0400
Received: from 6.mo3.mail-out.ovh.net ([188.165.43.173]:35610)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1hdHOv-0006Ts-FZ
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 12:56:06 -0400
Received: from player157.ha.ovh.net (unknown [10.109.160.46])
 by mo3.mail-out.ovh.net (Postfix) with ESMTP id B6EE121A5F8
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2019 18:55:52 +0200 (CEST)
Received: from kaod.org (lfbn-1-10649-41.w90-89.abo.wanadoo.fr [90.89.235.41])
 (Authenticated sender: clg@kaod.org)
 by player157.ha.ovh.net (Postfix) with ESMTPSA id 41C826EB55AD;
 Tue, 18 Jun 2019 16:55:46 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 18 Jun 2019 18:53:11 +0200
Message-Id: <20190618165311.27066-22-clg@kaod.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190618165311.27066-1-clg@kaod.org>
References: <20190618165311.27066-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 1700108861473458961
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrtddtgdejkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 188.165.43.173
Subject: [Qemu-devel] [PATCH v2 21/21] aspeed: vic: Add support for legacy
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
Cc: Andrew Jeffery <andrew@aj.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>
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
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/intc/aspeed_vic.c | 105 ++++++++++++++++++++++++++-----------------
 1 file changed, 63 insertions(+), 42 deletions(-)

diff --git a/hw/intc/aspeed_vic.c b/hw/intc/aspeed_vic.c
index 927638d5322a..266a309f3b47 100644
--- a/hw/intc/aspeed_vic.c
+++ b/hw/intc/aspeed_vic.c
@@ -104,54 +104,63 @@ static void aspeed_vic_set_irq(void *opaque, int ir=
q, int level)
=20
 static uint64_t aspeed_vic_read(void *opaque, hwaddr offset, unsigned si=
ze)
 {
-    uint64_t val;
-    const bool high =3D !!(offset & 0x4);
-    hwaddr n_offset =3D (offset & ~0x4);
     AspeedVICState *s =3D (AspeedVICState *)opaque;
+    hwaddr n_offset;
+    uint64_t val;
+    bool high;
=20
     if (offset < AVIC_NEW_BASE_OFFSET) {
-        qemu_log_mask(LOG_UNIMP, "%s: Ignoring read from legacy register=
s "
-                      "at 0x%" HWADDR_PRIx "[%u]\n", __func__, offset, s=
ize);
-        return 0;
+        high =3D false;
+        n_offset =3D offset;
+    } else {
+        high =3D !!(offset & 0x4);
+        n_offset =3D (offset & ~0x4);
     }
=20
-    n_offset -=3D AVIC_NEW_BASE_OFFSET;
-
     switch (n_offset) {
-    case 0x0: /* IRQ Status */
+    case 0x80: /* IRQ Status */
+    case 0x00:
         val =3D s->raw & ~s->select & s->enable;
         break;
-    case 0x08: /* FIQ Status */
+    case 0x88: /* FIQ Status */
+    case 0x04:
         val =3D s->raw & s->select & s->enable;
         break;
-    case 0x10: /* Raw Interrupt Status */
+    case 0x90: /* Raw Interrupt Status */
+    case 0x08:
         val =3D s->raw;
         break;
-    case 0x18: /* Interrupt Selection */
+    case 0x98: /* Interrupt Selection */
+    case 0x0c:
         val =3D s->select;
         break;
-    case 0x20: /* Interrupt Enable */
+    case 0xa0: /* Interrupt Enable */
+    case 0x10:
         val =3D s->enable;
         break;
-    case 0x30: /* Software Interrupt */
+    case 0xb0: /* Software Interrupt */
+    case 0x18:
         val =3D s->trigger;
         break;
-    case 0x40: /* Interrupt Sensitivity */
+    case 0xc0: /* Interrupt Sensitivity */
+    case 0x24:
         val =3D s->sense;
         break;
-    case 0x48: /* Interrupt Both Edge Trigger Control */
+    case 0xc8: /* Interrupt Both Edge Trigger Control */
+    case 0x28:
         val =3D s->dual_edge;
         break;
-    case 0x50: /* Interrupt Event */
+    case 0xd0: /* Interrupt Event */
+    case 0x2c:
         val =3D s->event;
         break;
-    case 0x60: /* Edge Triggered Interrupt Status */
+    case 0xe0: /* Edge Triggered Interrupt Status */
         val =3D s->raw & ~s->sense;
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
@@ -166,6 +175,8 @@ static uint64_t aspeed_vic_read(void *opaque, hwaddr =
offset, unsigned size)
     }
     if (high) {
         val =3D extract64(val, 32, 19);
+    } else {
+        val =3D extract64(val, 0, 32);
     }
     trace_aspeed_vic_read(offset, size, val);
     return val;
@@ -174,19 +185,18 @@ static uint64_t aspeed_vic_read(void *opaque, hwadd=
r offset, unsigned size)
 static void aspeed_vic_write(void *opaque, hwaddr offset, uint64_t data,
                              unsigned size)
 {
-    const bool high =3D !!(offset & 0x4);
-    hwaddr n_offset =3D (offset & ~0x4);
     AspeedVICState *s =3D (AspeedVICState *)opaque;
+    hwaddr n_offset;
+    bool high;
=20
     if (offset < AVIC_NEW_BASE_OFFSET) {
-        qemu_log_mask(LOG_UNIMP,
-                      "%s: Ignoring write to legacy registers at 0x%"
-                      HWADDR_PRIx "[%u] <- 0x%" PRIx64 "\n", __func__, o=
ffset,
-                      size, data);
-        return;
+        high =3D false;
+        n_offset =3D offset;
+    } else {
+        high =3D !!(offset & 0x4);
+        n_offset =3D (offset & ~0x4);
     }
=20
-    n_offset -=3D AVIC_NEW_BASE_OFFSET;
     trace_aspeed_vic_write(offset, size, data);
=20
     /* Given we have members using separate enable/clear registers, depo=
sit64()
@@ -201,7 +211,8 @@ static void aspeed_vic_write(void *opaque, hwaddr off=
set, uint64_t data,
     }
=20
     switch (n_offset) {
-    case 0x18: /* Interrupt Selection */
+    case 0x98: /* Interrupt Selection */
+    case 0x0c:
         /* Register has deposit64() semantics - overwrite requested 32 b=
its */
         if (high) {
             s->select &=3D AVIC_L_MASK;
@@ -210,21 +221,25 @@ static void aspeed_vic_write(void *opaque, hwaddr o=
ffset, uint64_t data,
         }
         s->select |=3D data;
         break;
-    case 0x20: /* Interrupt Enable */
+    case 0xa0: /* Interrupt Enable */
+    case 0x10:
         s->enable |=3D data;
         break;
-    case 0x28: /* Interrupt Enable Clear */
+    case 0xa8: /* Interrupt Enable Clear */
+    case 0x14:
         s->enable &=3D ~data;
         break;
-    case 0x30: /* Software Interrupt */
+    case 0xb0: /* Software Interrupt */
+    case 0x18:
         qemu_log_mask(LOG_UNIMP, "%s: Software interrupts unavailable. "
                       "IRQs requested: 0x%016" PRIx64 "\n", __func__, da=
ta);
         break;
-    case 0x38: /* Software Interrupt Clear */
+    case 0xb8: /* Software Interrupt Clear */
+    case 0x1c:
         qemu_log_mask(LOG_UNIMP, "%s: Software interrupts unavailable. "
                       "IRQs to be cleared: 0x%016" PRIx64 "\n", __func__=
, data);
         break;
-    case 0x50: /* Interrupt Event */
+    case 0xd0: /* Interrupt Event */
         /* Register has deposit64() semantics - overwrite the top four v=
alid
          * IRQ bits, as only the top four IRQs (GPIOs) can change their =
event
          * type */
@@ -236,15 +251,21 @@ static void aspeed_vic_write(void *opaque, hwaddr o=
ffset, uint64_t data,
                           "Ignoring invalid write to interrupt event reg=
ister");
         }
         break;
-    case 0x58: /* Edge Triggered Interrupt Clear */
+    case 0xd8: /* Edge Triggered Interrupt Clear */
+    case 0x38:
         s->raw &=3D ~(data & ~s->sense);
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
--=20
2.21.0



Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5361CC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 14:02:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D401205ED
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 14:02:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D401205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGk83-0007qa-96
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 10:02:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53434)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <geert@linux-m68k.org>) id 1jGk3W-0000Lz-6l
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 09:57:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <geert@linux-m68k.org>) id 1jGk3V-0006Zu-3f
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 09:57:22 -0400
Received: from michel.telenet-ops.be ([2a02:1800:110:4::f00:18]:48840)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <geert@linux-m68k.org>)
 id 1jGk3U-0006YF-TH
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 09:57:21 -0400
Received: from ramsan ([84.195.182.253]) by michel.telenet-ops.be with bizsmtp
 id JDwu2200M5USYZQ06Dwu4g; Tue, 24 Mar 2020 14:57:19 +0100
Received: from rox.of.borg ([192.168.97.57]) by ramsan with esmtp (Exim 4.90_1)
 (envelope-from <geert@linux-m68k.org>)
 id 1jGk34-0006Oc-Ga; Tue, 24 Mar 2020 14:56:54 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
 (envelope-from <geert@linux-m68k.org>)
 id 1jGk34-0001kW-Ey; Tue, 24 Mar 2020 14:56:54 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Harish Jenny K N <harish_kandiga@mentor.com>,
 Eugeniu Rosca <erosca@de.adit-jv.com>
Subject: [PATCH v6 1/8] ARM: integrator: impd1: Use GPIO_LOOKUP() helper macro
Date: Tue, 24 Mar 2020 14:56:46 +0100
Message-Id: <20200324135653.6676-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200324135328.5796-1-geert+renesas@glider.be>
References: <20200324135328.5796-1-geert+renesas@glider.be>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 2a02:1800:110:4::f00:18
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Geert Uytterhoeven <geert+renesas@glider.be>, linux-doc@vger.kernel.org,
 Marc Zyngier <marc.zyngier@arm.com>, Magnus Damm <magnus.damm@gmail.com>,
 Christoffer Dall <christoffer.dall@arm.com>, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, Alexander Graf <graf@amazon.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Phil Reid <preid@electromag.com.au>,
 linux-arm-kernel@lists.infradead.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

impd1_probe() fills in the GPIO lookup table by manually populating an
array of gpiod_lookup structures.  Use the existing GPIO_LOOKUP() helper
macro instead, to relax a dependency on the gpiod_lookup structure's
member names.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-arm-kernel@lists.infradead.org
---
While this patch is a dependency for "[PATCH v6 4/8] gpiolib: Add
support for GPIO lookup by line name", it can be applied independently.
But an Acked-by would be nice, too.

Cover letter and full series at
https://lore.kernel.org/r/20200324135328.5796-1-geert+renesas@glider.be/

v6:
  - New.
---
 arch/arm/mach-integrator/impd1.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-integrator/impd1.c b/arch/arm/mach-integrator/impd1.c
index 1ecbea5331d6ed8b..6f875ded841924d8 100644
--- a/arch/arm/mach-integrator/impd1.c
+++ b/arch/arm/mach-integrator/impd1.c
@@ -410,13 +410,10 @@ static int __ref impd1_probe(struct lm_device *dev)
 			 * 5 = Key lower right
 			 */
 			/* We need the two MMCI GPIO entries */
-			lookup->table[0].chip_label = chipname;
-			lookup->table[0].chip_hwnum = 3;
-			lookup->table[0].con_id = "wp";
-			lookup->table[1].chip_label = chipname;
-			lookup->table[1].chip_hwnum = 4;
-			lookup->table[1].con_id = "cd";
-			lookup->table[1].flags = GPIO_ACTIVE_LOW;
+			lookup->table[0] = (struct gpiod_lookup)
+				GPIO_LOOKUP(chipname, 3, "wp", 0);
+			lookup->table[1] = (struct gpiod_lookup)
+				GPIO_LOOKUP(chipname, 4, "cd", GPIO_ACTIVE_LOW);
 			gpiod_add_lookup_table(lookup);
 		}
 
-- 
2.17.1



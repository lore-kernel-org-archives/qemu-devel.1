Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BAEEC47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 14:55:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D08EC20643
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 14:55:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D08EC20643
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY9qT-0003Dw-Pp
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 10:55:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34488)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <geert@linux-m68k.org>)
 id 1jY9nu-0004wj-Ln
 for qemu-devel@nongnu.org; Mon, 11 May 2020 10:53:17 -0400
Received: from andre.telenet-ops.be ([2a02:1800:120:4::f00:15]:36894)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <geert@linux-m68k.org>)
 id 1jY9ns-0000dV-JW
 for qemu-devel@nongnu.org; Mon, 11 May 2020 10:53:14 -0400
Received: from ramsan ([IPv6:2a02:1810:ac12:ed60:702c:fb99:3097:2049])
 by andre.telenet-ops.be with bizsmtp
 id dSsy220060GoAb601Ssy9H; Mon, 11 May 2020 16:53:08 +0200
Received: from rox.of.borg ([192.168.97.57]) by ramsan with esmtp (Exim 4.90_1)
 (envelope-from <geert@linux-m68k.org>)
 id 1jY9ne-00082e-2B; Mon, 11 May 2020 16:52:58 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
 (envelope-from <geert@linux-m68k.org>)
 id 1jY9ne-0005zT-0R; Mon, 11 May 2020 16:52:58 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Harish Jenny K N <harish_kandiga@mentor.com>,
 Eugeniu Rosca <erosca@de.adit-jv.com>
Subject: [PATCH v7 2/6] mfd: sm501: Use GPIO_LOOKUP_IDX() helper macro
Date: Mon, 11 May 2020 16:52:53 +0200
Message-Id: <20200511145257.22970-3-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200511145257.22970-1-geert+renesas@glider.be>
References: <20200511145257.22970-1-geert+renesas@glider.be>
Received-SPF: none client-ip=2a02:1800:120:4::f00:15;
 envelope-from=geert@linux-m68k.org; helo=andre.telenet-ops.be
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_LOW=-0.7,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Geert Uytterhoeven <geert+renesas@glider.be>, linux-doc@vger.kernel.org,
 Marc Zyngier <marc.zyngier@arm.com>, Magnus Damm <magnus.damm@gmail.com>,
 Christoffer Dall <christoffer.dall@arm.com>, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
 Alexander Graf <graf@amazon.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Phil Reid <preid@electromag.com.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

i801_add_mux() fills in the GPIO lookup table by manually populating an
array of gpiod_lookup structures.  Use the existing GPIO_LOOKUP_IDX()
helper macro instead, to relax a dependency on the gpiod_lookup
structure's member names.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Lee Jones <lee.jones@linaro.org>
---
v7:
  - Add Acked-by,

v6:
  - New.
---
 drivers/mfd/sm501.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/mfd/sm501.c b/drivers/mfd/sm501.c
index e49787e6bb93e5c8..ccd62b963952814e 100644
--- a/drivers/mfd/sm501.c
+++ b/drivers/mfd/sm501.c
@@ -1145,22 +1145,14 @@ static int sm501_register_gpio_i2c_instance(struct sm501_devdata *sm,
 		return -ENOMEM;
 
 	lookup->dev_id = "i2c-gpio";
-	if (iic->pin_sda < 32)
-		lookup->table[0].chip_label = "SM501-LOW";
-	else
-		lookup->table[0].chip_label = "SM501-HIGH";
-	lookup->table[0].chip_hwnum = iic->pin_sda % 32;
-	lookup->table[0].con_id = NULL;
-	lookup->table[0].idx = 0;
-	lookup->table[0].flags = GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN;
-	if (iic->pin_scl < 32)
-		lookup->table[1].chip_label = "SM501-LOW";
-	else
-		lookup->table[1].chip_label = "SM501-HIGH";
-	lookup->table[1].chip_hwnum = iic->pin_scl % 32;
-	lookup->table[1].con_id = NULL;
-	lookup->table[1].idx = 1;
-	lookup->table[1].flags = GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN;
+	lookup->table[0] = (struct gpiod_lookup)
+		GPIO_LOOKUP_IDX(iic->pin_sda < 32 ? "SM501-LOW" : "SM501-HIGH",
+				iic->pin_sda % 32, NULL, 0,
+				GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN);
+	lookup->table[1] = (struct gpiod_lookup)
+		GPIO_LOOKUP_IDX(iic->pin_scl < 32 ? "SM501-LOW" : "SM501-HIGH",
+				iic->pin_scl % 32, NULL, 1,
+				GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN);
 	gpiod_add_lookup_table(lookup);
 
 	icd = dev_get_platdata(&pdev->dev);
-- 
2.17.1



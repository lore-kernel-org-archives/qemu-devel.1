Return-Path: <SRS0=Byls=54=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 403BEC2BB85
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2020 22:37:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09F54206E5
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2020 22:37:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cX9rTLk2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09F54206E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jNlEc-0007eb-4d
	for qemu-devel@archiver.kernel.org; Sun, 12 Apr 2020 18:37:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47199)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNlDV-0005Gd-DE
 for qemu-devel@nongnu.org; Sun, 12 Apr 2020 18:36:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNlDU-00025e-B3
 for qemu-devel@nongnu.org; Sun, 12 Apr 2020 18:36:41 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:54668)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNlDU-000250-4f; Sun, 12 Apr 2020 18:36:40 -0400
Received: by mail-wm1-x334.google.com with SMTP id h2so7913129wmb.4;
 Sun, 12 Apr 2020 15:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=VnSS2TQOtgiol91KdSBROLvPE94j7ZxN6xXY/l64ecg=;
 b=cX9rTLk2CkjoGxHpklWN5Vy/Qp3XH7ATVVGbVAajQzFz91HJa5m6rIPaJOyW6WQQVU
 wRfjkdeTNh2QFxv8NNTSZL9Zv/lmsYgn3X2/XGv6n3vvvTkjNdtHOmQeFRWtXr05ZSvr
 NYi7MriXVp3pYJnIMzNk1g/A+EJEqnnt31q4yQ+rVO6LgmjJjbKEGiyb82l2CgDBbY+7
 Y/kmQ0spa5Xe57L797fhlbvjZO1zZZDowIl/nch2FGgCGBt6xKWYQoruA8hPLvJLZOlJ
 BG0GUzugNraWsg47zMWBKRgY8wOCW/hNASUvADGRFTjxJNG/QM89heg2r1VqDkJUd3BS
 6xVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=VnSS2TQOtgiol91KdSBROLvPE94j7ZxN6xXY/l64ecg=;
 b=t2aYUtbaeRE5u1H7yxh+TJu8t4YUB62lm5OU6aK7Hq+d3OZTB0vTWzRcjH6oxDc6uE
 Q14ZLpjLJGhZ/FGN5gog2qSCJsg4jhUrv9iMbMKRo5k0/jsrRNSj/g8fmA/Q/q8V5b/V
 ldL9eNkS3X6pSs3IvdUN+I/+yMq7eFTYoFaE0Gl4R4ZBIIgmk0eoWG+oRQ4h4+z/3bnZ
 Xig45BPyQ81R5e8H3EqiFQMalBAZEdkOGTUxuUVQf9qE0HE0vPR43BMS/KVHJ+3f0caC
 47s7TnNPIWtRBXaKJBFvYrjXD9O4do4HqeuLTsPSvvAG9sEetmwhge5f+HSrI+0HHKmz
 yZ7A==
X-Gm-Message-State: AGi0Pub9KPTbNGfyGq/UC+TZYzJxBeapE802z3JR1XsoW67sX5TQosq4
 y2lelIPJH01qjnrvGfu36UiDhUU7e5ECEQ==
X-Google-Smtp-Source: APiQypIKXCqNMjtmIpB7hHSHlw/qYAI0+ttXO+kHxlf/WQwZBGsagrQWrlGHj6ZZCZc7k9iZrC6Kbg==
X-Received: by 2002:a1c:3c08:: with SMTP id j8mr13489689wma.30.1586730998917; 
 Sun, 12 Apr 2020 15:36:38 -0700 (PDT)
Received: from localhost.localdomain (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id d13sm12563559wrv.34.2020.04.12.15.36.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Apr 2020 15:36:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.1 v3 04/24] hw/arm/aspeed_ast2600: Simplify use of Error*
Date: Mon, 13 Apr 2020 00:35:59 +0200
Message-Id: <20200412223619.11284-5-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200412223619.11284-1-f4bug@amsat.org>
References: <20200412223619.11284-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::334
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jeff Cody <codyprime@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Xie Changlong <xiechanglong.d@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Beniamino Galvani <b.galvani@gmail.com>, qemu-arm@nongnu.org,
 Peter Chubb <peter.chubb@nicta.com.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 David Gibson <david@gibson.dropbear.id.au>, Kevin Wolf <kwolf@redhat.com>,
 qemu-riscv@nongnu.org, Andrew Jeffery <andrew@aj.id.au>,
 Wen Congyang <wencongyang2@huawei.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-ppc@nongnu.org,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Coccinelle reported:

  $ spatch ... --timeout 60 --sp-file \
    scripts/coccinelle/simplify-init-realize-error_propagate.cocci
  HANDLING: ./hw/arm/aspeed_ast2600.c
  >>> possible moves from aspeed_soc_ast2600_init() to aspeed_soc_ast2600_realize() in ./hw/arm/aspeed_ast2600.c:243

While reviewing we notice we don't need two different Error*,
drop the one less used.

Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
v3: Indented 'return'.
---
 hw/arm/aspeed_ast2600.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
index 1a869e09b9..a860ab6a35 100644
--- a/hw/arm/aspeed_ast2600.c
+++ b/hw/arm/aspeed_ast2600.c
@@ -245,7 +245,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
     int i;
     AspeedSoCState *s = ASPEED_SOC(dev);
     AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
-    Error *err = NULL, *local_err = NULL;
+    Error *err = NULL;
     qemu_irq irq;
 
     /* IO space */
@@ -418,9 +418,12 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
             return;
         }
         object_property_set_int(OBJECT(&s->spi[i]), 1, "num-cs", &err);
+        if (err) {
+            error_propagate(errp, err);
+            return;
+        }
         object_property_set_bool(OBJECT(&s->spi[i]), true, "realized",
-                                 &local_err);
-        error_propagate(&err, local_err);
+                                 &err);
         if (err) {
             error_propagate(errp, err);
             return;
@@ -472,12 +475,15 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
         qdev_set_nic_properties(DEVICE(&s->ftgmac100[i]), &nd_table[i]);
         object_property_set_bool(OBJECT(&s->ftgmac100[i]), true, "aspeed",
                                  &err);
-        object_property_set_bool(OBJECT(&s->ftgmac100[i]), true, "realized",
-                                 &local_err);
-        error_propagate(&err, local_err);
         if (err) {
             error_propagate(errp, err);
-           return;
+            return;
+        }
+        object_property_set_bool(OBJECT(&s->ftgmac100[i]), true, "realized",
+                                 &err);
+        if (err) {
+            error_propagate(errp, err);
+            return;
         }
         sysbus_mmio_map(SYS_BUS_DEVICE(&s->ftgmac100[i]), 0,
                         sc->memmap[ASPEED_ETH1 + i]);
-- 
2.21.1



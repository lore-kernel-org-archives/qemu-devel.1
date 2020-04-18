Return-Path: <SRS0=r7Ry=6C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD5D3C2BB1D
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2020 00:26:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E79C20857
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2020 00:26:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IGHcIA1X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E79C20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPbJk-0000tb-NJ
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 20:26:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44782)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marek.vasut@gmail.com>) id 1jPbJ5-0000St-UN
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 20:26:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marek.vasut@gmail.com>) id 1jPbJ4-0002fl-MB
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 20:26:03 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:43728)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marek.vasut@gmail.com>)
 id 1jPbJ4-0002b2-G6
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 20:26:02 -0400
Received: by mail-wr1-x443.google.com with SMTP id i10so4950521wrv.10
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2020 17:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=+0rfodSuYelFon6nO4YCwpcqpjutW/YJ7CYyGJckGZs=;
 b=IGHcIA1XjS3zpeO88Yusx6IDWhMxrtU66N6TuHXWWFflIaj9ZNz9x/ltsHYVyDiSvg
 Org89V4FEPp6/pNes7MIzjBP+9lgoBeBWXxi3VZN8inmraFVdtf2nLzy3oFs19U62Gh0
 fkuR43evLaG5vM0ex9cO9eVa/qVU1pIFXZocSGlYUbB4dZ+UtWYcInKOlNiWinYV6eFt
 9QgNvCG17HwVaV4mP7kA6aHbAyWY22crTFP1JpWwtCBiAbPGWnMJYXqJ4Cez5j1oQaW/
 adkzc2HtThA4gnt1yqfU00ujcriKt/R6NkSmjs+hLSehqZtjF9TfJSO47viTnDSmxnvy
 Is2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=+0rfodSuYelFon6nO4YCwpcqpjutW/YJ7CYyGJckGZs=;
 b=EyiFLd3ckJas2pLkmuwsia5pqKUkPvkIz+yMpacRrHW+krD77Co+vYNLHwexiKzTCj
 hD9A736uV1YOWk2V14CTWDQ2tWj/BXNPdRDQ0UPGJt2c0koS5VpyH00iJ2KoARlDpM6+
 0hmwQOPw/EzQpDhgBwnRg7d14ooLOiB/HCvd/4gIw9Vz05qFhOLZdduny/3YaK2XAqNY
 Iibdpnhie7YFZY3G2ixMSblCycBLO3iHmLZnI/TfmpQ3OrbPLgwlyjhkbWALiFTA/tme
 e2cumk6iaZAjoGmRZSxKB9S020Mzihv7PxXLLff4zkN6ZIvInAVPgKjMuxS43e8ADz14
 dEMA==
X-Gm-Message-State: AGi0PuY5dXSLp3ZALSRHxKDZA5MY4L64lFTpdozKHnuUeYtq0HNQ0f6v
 LIbIavAFHxAWwZYjRqQpPHvShtW0
X-Google-Smtp-Source: APiQypL19PZG2C+sMfCUMr9qK07SjReX0zc/RXyuwgIDEvRndU4jwYaFKZcRHKgIikazBJUmVDGL/w==
X-Received: by 2002:adf:9022:: with SMTP id h31mr6330140wrh.223.1587169560051; 
 Fri, 17 Apr 2020 17:26:00 -0700 (PDT)
Received: from desktop.lan (ip-86-49-35-8.net.upcbroadband.cz. [86.49.35.8])
 by smtp.gmail.com with ESMTPSA id r17sm23006957wrn.43.2020.04.17.17.25.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2020 17:25:58 -0700 (PDT)
From: Marek Vasut <marek.vasut@gmail.com>
X-Google-Original-From: Marek Vasut <marek.vasut+renesas@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] net: tulip: Set PCI revision to match dec21143
Date: Sat, 18 Apr 2020 02:25:52 +0200
Message-Id: <20200418002552.343480-1-marek.vasut+renesas@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Prasad J Pandit <pjp@fedoraproject.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Sven Schnelle <svens@stackframe.org>,
 Marek Vasut <marek.vasut+renesas@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The tulip driver claims to emulate dec21143 and it does not emulate dec21142.
The dec21142 and dec21143 can be discerned by the PCI revision register,
where dec21142 reports value < 0x20 and dec21143 value >= 0x20. E.g. the
U-Boot 'tulip' driver also only supports dec21143 and verifies that the
PCI revision ID is >= 0x20, otherwise refuses to operate such a card.

This patch sets the PCI revision ID to 0x20 to match the dec21143 and
thus also permits e.g. U-Boot to work with the tulip emulation.

Fixes: 34ea023d4b95 ("net: add tulip (dec21143) driver")
Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Prasad J Pandit <pjp@fedoraproject.org>
Cc: Sven Schnelle <svens@stackframe.org>
---
 hw/net/tulip.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/net/tulip.c b/hw/net/tulip.c
index 1295f51d07..ffb6c2479a 100644
--- a/hw/net/tulip.c
+++ b/hw/net/tulip.c
@@ -962,6 +962,8 @@ static void pci_tulip_realize(PCIDevice *pci_dev, Error **errp)
 
     pci_conf = s->dev.config;
     pci_conf[PCI_INTERRUPT_PIN] = 1; /* interrupt pin A */
+    /* Anything with revision < 0x20 is DC21142, anything >= 0x20 is DC21143 */
+    pci_conf[PCI_REVISION_ID] = 0x20;
 
     s->eeprom = eeprom93xx_new(&pci_dev->qdev, 64);
     tulip_fill_eeprom(s);
-- 
2.25.1



Return-Path: <SRS0=twQi=CO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B993C43461
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2020 21:25:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79A6C2072D
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2020 21:24:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LstX07pa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79A6C2072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEfgA-0002Xu-Ga
	for qemu-devel@archiver.kernel.org; Sat, 05 Sep 2020 17:24:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34918)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kEffb-0001vr-AJ; Sat, 05 Sep 2020 17:24:23 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:34986)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kEffZ-0007po-Iy; Sat, 05 Sep 2020 17:24:22 -0400
Received: by mail-wm1-x343.google.com with SMTP id o21so9842031wmc.0;
 Sat, 05 Sep 2020 14:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=BdDznY8S0BQXDdPB7zGIQilI2U7UILqzIY71jz2SzvM=;
 b=LstX07paRhFsI70d4HZwovde+TW4Lqgmpk7v7nRJTck5Supygg0OmNz7eXjIelHYI+
 L2UXNT4j1hN7RdJQ7Bav5Msuw2TkqTLWC5Id24uwdLoGa+x0yro8XRNgJ+OpHwpLOT2u
 C+eaGG0N9yLMzJMDCC1IdudFgn3VVpvBrcMUmzFIUyPoeOAzIJK95rghHBbtRAxnMi4c
 GMz11D0dzPlRj1L0hSpjOCa2dQ1ZGBtT2r47HCabv+OJxq89ZYkeBhGZAnsO20Lu3LI7
 02EuK5c0zobVb3CPdocxm6IzUvfJL/1uykY4TzBuexEyUp73PXCixNNlA7T6j8UD4aTM
 TFQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=BdDznY8S0BQXDdPB7zGIQilI2U7UILqzIY71jz2SzvM=;
 b=I9DIAZyWryOMTYvW+glq/Mgmykv4eZ8h6JpVHM/8TemHoyTeZsb1hB/E6Q6ePyL0xf
 rTF+aKtuV7L/qXnt8nnKp0USx+gIqjAZVFIoNRXW5hmZkoD1tVFuei66bCG3mZ19XZDd
 hcmo2CBSZbzObwoMWZEPs3dQLRHDGcHMRH0CQPuQlF0OJkhMtMwmCEMFzoz/+jrZbw9P
 Em6BKDt2YKuRVW3GJRUWIyDN+Y2hFH9Tt7y/qMvyHyEtDH7Y5K1+6TxamtGYujOkdg4Y
 M37XqRIYg0npB/eUdoB4oTh560DTo7un0smyNz9FU51jYTe/L6kbk7t3sd0lTGHfF5Cl
 FNWw==
X-Gm-Message-State: AOAM533KDmDRuQu2BVjN6U/m/fjT2LeNRPfKCPA8Jkx6YvUYuXld/NTd
 FgPglT6Aqftoz9/gj0B27S1xsMg1o+4=
X-Google-Smtp-Source: ABdhPJxkYoNqFhr/jEjadq0ljg+WXnCU7/4kK7WccjyldCnY9NJOMA+2wLRRuXxjVcgDXUxvqRXycA==
X-Received: by 2002:a05:600c:2053:: with SMTP id
 p19mr13412672wmg.50.1599341058390; 
 Sat, 05 Sep 2020 14:24:18 -0700 (PDT)
Received: from localhost.localdomain (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id q186sm20629903wma.45.2020.09.05.14.24.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Sep 2020 14:24:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] hw/arm/aspeed: Map the UART5 device unconditionally
Date: Sat,  5 Sep 2020 23:24:15 +0200
Message-Id: <20200905212415.760452-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-arm@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The UART5 is present on the machine regardless there is a
character device connected to it. Map it unconditionally.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/aspeed_ast2600.c | 8 +++-----
 hw/arm/aspeed_soc.c     | 8 +++-----
 2 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
index 9d95e421435..1450bde7cf2 100644
--- a/hw/arm/aspeed_ast2600.c
+++ b/hw/arm/aspeed_ast2600.c
@@ -325,11 +325,9 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
     }
 
     /* UART - attach an 8250 to the IO space as our UART5 */
-    if (serial_hd(0)) {
-        qemu_irq uart5 = aspeed_soc_get_irq(s, ASPEED_DEV_UART5);
-        serial_mm_init(get_system_memory(), sc->memmap[ASPEED_DEV_UART5], 2,
-                       uart5, 38400, serial_hd(0), DEVICE_LITTLE_ENDIAN);
-    }
+    serial_mm_init(get_system_memory(), sc->memmap[ASPEED_DEV_UART5], 2,
+                   aspeed_soc_get_irq(s, ASPEED_DEV_UART5),
+                   38400, serial_hd(0), DEVICE_LITTLE_ENDIAN);
 
     /* I2C */
     object_property_set_link(OBJECT(&s->i2c), "dram", OBJECT(s->dram_mr),
diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
index 35be126db6f..7eefd54ac07 100644
--- a/hw/arm/aspeed_soc.c
+++ b/hw/arm/aspeed_soc.c
@@ -283,11 +283,9 @@ static void aspeed_soc_realize(DeviceState *dev, Error **errp)
     }
 
     /* UART - attach an 8250 to the IO space as our UART5 */
-    if (serial_hd(0)) {
-        qemu_irq uart5 = aspeed_soc_get_irq(s, ASPEED_DEV_UART5);
-        serial_mm_init(get_system_memory(), sc->memmap[ASPEED_DEV_UART5], 2,
-                       uart5, 38400, serial_hd(0), DEVICE_LITTLE_ENDIAN);
-    }
+    serial_mm_init(get_system_memory(), sc->memmap[ASPEED_DEV_UART5], 2,
+                   aspeed_soc_get_irq(s, ASPEED_DEV_UART5), 38400,
+                   serial_hd(0), DEVICE_LITTLE_ENDIAN);
 
     /* I2C */
     object_property_set_link(OBJECT(&s->i2c), "dram", OBJECT(s->dram_mr),
-- 
2.26.2



Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07669C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 07:37:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5EB620853
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 07:37:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lHF9QjPA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5EB620853
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlSd2-0002ot-2z
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 03:37:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41044)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jlSSI-0004iG-4l; Wed, 17 Jun 2020 03:25:54 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:41830)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jlSSG-0002bD-HN; Wed, 17 Jun 2020 03:25:53 -0400
Received: by mail-wr1-x442.google.com with SMTP id j10so1137608wrw.8;
 Wed, 17 Jun 2020 00:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=r/YRzT9yihQX0CYaeW9uQbX0lprIdEmCq4Q/T1MB1VU=;
 b=lHF9QjPAh0LtDK4SjcbyzSkCcmeu6hbKOtj2YJzuYRefMOoQUPeIwHBQGu0r+Z+uky
 lE8c+G/ylXWPM0+HwBTtAv9twviw+VEf0mYxOQRKIG5t4UEi9scQQ1yMA8nVEDrmzrWQ
 qNw5/L5eVhN2eS7R0gzp6sjFgoMhSWCWpgvqOPHW6P7EoCtN67wvJ7bPXKePPmfI+vUT
 A23CiSIOx/LZZ18AIls6sLv8JNqMF6fRYBUeSeyMy9YpjMg+esZnERzg/QEz+uNvd0Qe
 QVNV9QvdEpnBqmeVMPn6YXxoNNA1eRtWNwMsJ1mFqT9aD2ojJ5esdexCZeB6+USqh1Ix
 zv1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=r/YRzT9yihQX0CYaeW9uQbX0lprIdEmCq4Q/T1MB1VU=;
 b=Y+Rb6PoN3xSi1C/X8+ApwIQyTndEaJwjrYnGRlrBQ719lbJvAOknloxFagZ4vBzZDU
 iCr1c/p7HcZrrEhkBQ8LagKeFcIa6yFPVzFiqBx18ULsGlPrl96hg2aN0sd6eVt44jAw
 UNdRKDvTkbNlnUdBm4BOmT4mWGHOi/RSxVKp4vHb6XixcwQQpn38RKQW7LpxPtIFw6hq
 FnjPowgULBSXaLG407EcG0VIKnX6U5tHdGu2+W9CwICHotCrhPbelO8QIZrkMCK1thmN
 VzZgkf8w/Dr2vs/uQP/wSoExk+ECpDy/Qp2Y32FX3N3ySEDKQ6ZI2H9dii4LDRj3ZAm4
 3yMw==
X-Gm-Message-State: AOAM530902bf/Ldqo4/L12sokpNHMahvxgp4LXJ3yymdSmuBZfbOLKDJ
 MwikPcCrmb3vWKe83L8hIb4Y50kG
X-Google-Smtp-Source: ABdhPJwnUAN4eyb24OQlQ1PQheNH2pVX5XSDjBaYmRG1jNG/32oFxMvyaqPoxlDrUKkS0GK9qQd0Yg==
X-Received: by 2002:a5d:5489:: with SMTP id h9mr6781818wrv.125.1592378750490; 
 Wed, 17 Jun 2020 00:25:50 -0700 (PDT)
Received: from localhost.localdomain (93.red-83-59-160.dynamicip.rima-tde.net.
 [83.59.160.93])
 by smtp.gmail.com with ESMTPSA id j5sm32894781wrq.39.2020.06.17.00.25.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 00:25:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 08/14] hw/arm/mps2: Add CMSDK APB watchdog device
Date: Wed, 17 Jun 2020 09:25:33 +0200
Message-Id: <20200617072539.32686-9-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200617072539.32686-1-f4bug@amsat.org>
References: <20200617072539.32686-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Esteban Bosse <estebanbosse@gmail.com>,
 Joaquin de Andres <me@xcancerberox.com.ar>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We already model the CMSDK APB watchdog device, let's use it!

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
v2: Use existing TYPE_CMSDK_APB_WATCHDOG (pm215)
---
 hw/arm/mps2.c  | 7 +++++++
 hw/arm/Kconfig | 1 +
 2 files changed, 8 insertions(+)

diff --git a/hw/arm/mps2.c b/hw/arm/mps2.c
index 4fe5cc8622..f7bef20b40 100644
--- a/hw/arm/mps2.c
+++ b/hw/arm/mps2.c
@@ -312,6 +312,13 @@ static void mps2_common_init(MachineState *machine)
     sysbus_connect_irq(SYS_BUS_DEVICE(&mms->dualtimer), 0,
                        qdev_get_gpio_in(armv7m, 10));
     sysbus_mmio_map(SYS_BUS_DEVICE(&mms->dualtimer), 0, 0x40002000);
+    object_initialize_child(OBJECT(mms), "watchdog", &mms->watchdog,
+                            TYPE_CMSDK_APB_WATCHDOG);
+    qdev_prop_set_uint32(DEVICE(&mms->watchdog), "wdogclk-frq", SYSCLK_FRQ);
+    sysbus_realize(SYS_BUS_DEVICE(&mms->watchdog), &error_fatal);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&mms->watchdog), 0,
+                       qdev_get_gpio_in_named(armv7m, "NMI", 0));
+    sysbus_mmio_map(SYS_BUS_DEVICE(&mms->watchdog), 0, 0x40008000);
 
     /* FPGA APB subsystem */
     object_initialize_child(OBJECT(mms), "scc", &mms->scc, TYPE_MPS2_SCC);
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 9afa6eee79..5c8f689b3d 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -405,6 +405,7 @@ config MPS2
     select PL080    # DMA controller
     select SPLIT_IRQ
     select UNIMP
+    select CMSDK_APB_WATCHDOG
 
 config FSL_IMX7
     bool
-- 
2.21.3



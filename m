Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A19C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 07:34:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B7FE2082F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 07:34:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FmnJML5Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B7FE2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlSaU-000874-Nb
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 03:34:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41114)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jlSSM-0004uH-Rj; Wed, 17 Jun 2020 03:25:58 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:39863)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jlSSL-0002cF-80; Wed, 17 Jun 2020 03:25:58 -0400
Received: by mail-wm1-x344.google.com with SMTP id t194so839813wmt.4;
 Wed, 17 Jun 2020 00:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Xsx3rVy21mly30ECAO4zqqbSeNtihiVFwXLty9S11BE=;
 b=FmnJML5YCRErbI42yssQwWNRybu4/4kqZCImUOTsGw33xtHtQ+Rby5AY7QEucT6Y2E
 Wcf1ZxSzahKDDh++BD6N2BIPgrHk0nqjrrl9NLclCM443sepKJgHwjuXo8AGuQZ46vuc
 DTTVQZl2aiAeOK619/+Ec1J4ZjdT8pbbNmpYGxfVvi0/RJJ07DBxsSSJffeYi1/FK2rt
 xX0Lcp3CUUODyCfvAxCmA1SKetye5MILF1DiRRCV2BSue8k2sZIU3Qoop/g30zc1gZa8
 y//yq68hSHg2+jNQG8tjLPKKpxTLluRoF4xugEYp4qX7VkV0VVFiYiiXgo3CIyBwB9zj
 D44A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=Xsx3rVy21mly30ECAO4zqqbSeNtihiVFwXLty9S11BE=;
 b=CibrR2tvLRy8GeuOgGO/easpz1gOWlKkICibNjV6wF4eusffkIiqnYWiCx67Yo4yp0
 lXz0IuBxp5rAabGzCUm/bX42PaK5oNxPHbTicbfAs92a/bddjZq6/kNqT6gMMO1l9mUf
 CMHtKX2IfBkecQoBkokIpX5k5amMYfjuvp4h97XKFGtr+/1Ib1yYVGXVaVGJiVYzvwhS
 tPRY2AVJW2MJj/iqU2i2PP+Ppsvjjwdw94vmAlYEnG2SQB0h3fuMDJ4fYNkiJJ19xBiK
 sYUp+YWR4hM3lIrskfL0lUdSgcxAsXXDuEOX2wUWEZ5/ASnnGcVbPaf3YlrnXTksnV2b
 aW7w==
X-Gm-Message-State: AOAM531IPcxh3Kbj1WgUDCcbDxvRXXNPsQ6oZ7Ehbu6pPQYS0iuorbvN
 ffTyUlIOH0LKchdYtcxinE46WnRp
X-Google-Smtp-Source: ABdhPJzRV0KpfpqO2fN3+g+fRWn9aDkWPaO4SsOrMdCn3ImbHhLIlxY+RDRoJ1ATS4flteR5bn8IIg==
X-Received: by 2002:a1c:1d49:: with SMTP id d70mr7140003wmd.49.1592378754981; 
 Wed, 17 Jun 2020 00:25:54 -0700 (PDT)
Received: from localhost.localdomain (93.red-83-59-160.dynamicip.rima-tde.net.
 [83.59.160.93])
 by smtp.gmail.com with ESMTPSA id j5sm32894781wrq.39.2020.06.17.00.25.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 00:25:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 12/14] hw/arm/mps2: Add I2C devices
Date: Wed, 17 Jun 2020 09:25:37 +0200
Message-Id: <20200617072539.32686-13-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200617072539.32686-1-f4bug@amsat.org>
References: <20200617072539.32686-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
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

From 'Application Note AN385', chapter 3.14:

  The SMM implements a simple SBCon interface based on I2C.

There are 4 SBCon interfaces on the FPGA APB subsystem.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/mps2.c  | 8 ++++++++
 hw/arm/Kconfig | 1 +
 2 files changed, 9 insertions(+)

diff --git a/hw/arm/mps2.c b/hw/arm/mps2.c
index daa26f68d7..2f6acbf2c2 100644
--- a/hw/arm/mps2.c
+++ b/hw/arm/mps2.c
@@ -40,6 +40,7 @@
 #include "hw/misc/mps2-scc.h"
 #include "hw/misc/mps2-fpgaio.h"
 #include "hw/ssi/pl022.h"
+#include "hw/i2c/arm_sbcon_i2c.h"
 #include "hw/net/lan9118.h"
 #include "net/net.h"
 #include "hw/watchdog/cmsdk-apb-watchdog.h"
@@ -365,6 +366,13 @@ static void mps2_common_init(MachineState *machine)
                                  qdev_get_gpio_in(orgate_dev, j));
         }
     }
+    for (i = 0; i < 4; i++) {
+        static const hwaddr i2cbase[] = {0x40022000,    /* Touch */
+                                         0x40023000,    /* Audio */
+                                         0x40029000,    /* Shield0 */
+                                         0x4002a000};   /* Shield1 */
+        sysbus_create_simple(TYPE_ARM_SBCON_I2C, i2cbase[i], NULL);
+    }
 
     /* In hardware this is a LAN9220; the LAN9118 is software compatible
      * except that it doesn't support the checksum-offload feature.
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 90ed584e7a..4a224a6351 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -406,6 +406,7 @@ config MPS2
     select SPLIT_IRQ
     select UNIMP
     select CMSDK_APB_WATCHDOG
+    select VERSATILE_I2C
 
 config FSL_IMX7
     bool
-- 
2.21.3



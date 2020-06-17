Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6786BC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 05:58:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30841207DD
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 05:58:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JYlWuSrZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30841207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlR5F-0004ny-EW
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 01:58:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49818)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jlQzo-0002uI-PZ; Wed, 17 Jun 2020 01:52:24 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:52148)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jlQzn-0004Te-7q; Wed, 17 Jun 2020 01:52:24 -0400
Received: by mail-wm1-x343.google.com with SMTP id b82so603405wmb.1;
 Tue, 16 Jun 2020 22:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=xBt1JdUtXnVHDFLzLhbnDdhHBrdVurpC1i/gmVlTBm8=;
 b=JYlWuSrZ3RFNBDkWMAs8yqAf/eUDHyl9+PB9pWPMpQOWTlR4aPS/eFKVjwLVeGJgcj
 b8vCjriROPsAoaj3Ii+02qzKhQVW7hze0WXe++Q3wO4CXg+H1aqbXCtowglztOyUUFUT
 btsMOvLnc8B//AZwAFeRwMVwI2dhFMvVlp/ic6rmNBtSg96sVyBZy11qVt/hIIhsBuH2
 bKukVN5IeCWqpr2WrwILtlgFoBRuMlIVXkhGk7lx+lLoT4wCNlDQtZkYm9rCGfPag2fX
 z+X/2ag/5xdppdqDPdwnpwVLWaG5oN1oUYj+lL17cLKNg6oZWI3FzlEiFH1wY/b/gmzw
 qSBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=xBt1JdUtXnVHDFLzLhbnDdhHBrdVurpC1i/gmVlTBm8=;
 b=M4tv0n/t6xMiH7xiLpdBArdK4N6NQ/EMVa13PeN0hY3sbiLlpRcQW6kx0jwqpwAmNv
 WhnHkvBqYUZ9aNVNTdtN62x2aEG3I9rJm+m4EhXkPcV0XaCPudBFpzlfY4NnR52ZuSas
 6ITpq12m9Gy9au1XAE723znlG8Hd89tuXDioRGOXkYAgYGI3Hl5FG6mIAQeYMVe9GM0x
 Y+5h6AKI4BW7gs0LHr0oZI7FAlGntkCIVdphh8blGrlvnIweSS5/2ANWTubgu+t7Ysta
 97Ii8QrtIdQoc0Vm4bPUqoqZTYXr96guoIYiO2dk+QopVQgJBM05zuaRlU2cJDy5KFUL
 iO2Q==
X-Gm-Message-State: AOAM532DuSTwu1U+az74Yuy/1qGtcn+bPC+SPe0oL+2RXuEz7fNol+4m
 n15CyEpjT8ZWEjgf+5QkfgasccmP
X-Google-Smtp-Source: ABdhPJyVtLftZkZP6ukO8IyvUx6MjKmfKzfS+bJ8R0p4D9fxUM8Sknx5Ii/Igoq/oCWLS8j47BFcOA==
X-Received: by 2002:a1c:de82:: with SMTP id v124mr6768495wmg.89.1592373141262; 
 Tue, 16 Jun 2020 22:52:21 -0700 (PDT)
Received: from localhost.localdomain (93.red-83-59-160.dynamicip.rima-tde.net.
 [83.59.160.93])
 by smtp.gmail.com with ESMTPSA id d28sm3000809wrc.50.2020.06.16.22.52.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2020 22:52:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 12/14] hw/arm/mps2: Add I2C devices
Date: Wed, 17 Jun 2020 07:52:03 +0200
Message-Id: <20200617055205.3576-13-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200617055205.3576-1-f4bug@amsat.org>
References: <20200617055205.3576-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Joaquin de Andres <me@xcancerberox.com.ar>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Esteban Bosse <estebanbosse@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From 'Application Note AN385', chapter 3.14:

  The SMM implements a simple SBCon interface based on I2C.

There are 4 SBCon interfaces on the FPGA APB subsystem.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/mps2.c | 8 ++++++++
 1 file changed, 8 insertions(+)

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
-- 
2.21.3



Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4827C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 12:14:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A10FE20707
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 12:14:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l7x1X+3u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A10FE20707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnhp1-0002NU-Te
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 08:14:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44492)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jnhHP-0003cn-NX
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 07:39:55 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:44535)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jnhHL-0003Ry-KL
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 07:39:55 -0400
Received: by mail-wr1-x441.google.com with SMTP id b6so20156126wrs.11
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 04:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=swhhCaK6kxauy4YGZJwdC+yBpgGMM2M8opxL74decBA=;
 b=l7x1X+3uGkmgX2K8X8/wowcoZQvLw6kPgmNMncTL6L0yFisptKqfpoXFLqNKMRVdPV
 NAUTbD9lgmDzdMp5Jqiceny4p0td90ntmO8mBUr411V5S4R+gGWzLFAtF+/CcOpEY6wC
 qr3+bOVtFdwER0Xm8A6uhnhwh8MREwuALP6+gmRHlCBKY4QJgvcrc4RSwOjRmfSiq4zg
 35xp8Hz0z9Szx+EnValLVk7rEMTJ4tGh5J/f+FNvyu/JHumyTxfX1174mdaFE/tjpiIH
 NTF50QVpObOtKPC5NBSbcrJ/RG72sZFg8Z5c7ndx9OmGZhjbO+5s3ifyXSUFSmdD0MnH
 HElg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=swhhCaK6kxauy4YGZJwdC+yBpgGMM2M8opxL74decBA=;
 b=VjMuXNNchIf/uOaE5/VWLrWlQlo2Aq9HjAk86ux+jj4rQpYa2A0qsCnhj6AOFrF5TM
 oTczv7l64UqAKqp0B5Wa4+dkbU4PeC+HF9obKCg3u+pEWIXx6KOce1MKw30cZOKUTZeu
 zJcVQEfxouLRo0JXEZa8z5P14fo+8d7CdxGSi3bOXxAjZFJtcyI8pGd78LrwKlNqa/06
 0vSgtosMqVMXoJrpHxDQTpjA52KnONRoLiAnH0A/LWEtekDHgIkgYVoS7QgDfAigTtNW
 Y80fmnsNdfLraP2kH4qeHXm+Ev14R1Rtc+BTQsxt6SnFXt3lb44OH/N2yel2gVTlZACb
 I0Kg==
X-Gm-Message-State: AOAM530L37NhjjMaw3UXBhqgxxkajnoazDEpJai2HQH63F4LXCw/8g2e
 ciNlld5PpNvEm2mKRZS+W+sGnwORC2exhw==
X-Google-Smtp-Source: ABdhPJy5SJZooIZhlw0sRND4Sf1pwmy8dPT/dTvw3xehuAoGdLGgheOAfCC+ZW+tg5wGtzurPGVNXg==
X-Received: by 2002:a5d:4c8a:: with SMTP id z10mr8616783wrs.384.1592912389127; 
 Tue, 23 Jun 2020 04:39:49 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id m10sm4022177wru.4.2020.06.23.04.39.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2020 04:39:48 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 37/42] hw/arm/mps2: Add I2C devices
Date: Tue, 23 Jun 2020 12:38:59 +0100
Message-Id: <20200623113904.28805-38-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200623113904.28805-1-peter.maydell@linaro.org>
References: <20200623113904.28805-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

From 'Application Note AN385', chapter 3.14:

  The SMM implements a simple SBCon interface based on I2C.

There are 4 SBCon interfaces on the FPGA APB subsystem.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20200617072539.32686-13-f4bug@amsat.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/mps2.c  | 8 ++++++++
 hw/arm/Kconfig | 1 +
 2 files changed, 9 insertions(+)

diff --git a/hw/arm/mps2.c b/hw/arm/mps2.c
index daa26f68d79..2f6acbf2c21 100644
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
index 90ed584e7ac..4a224a6351a 100644
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
2.20.1



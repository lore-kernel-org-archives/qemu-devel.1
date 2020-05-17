Return-Path: <SRS0=EQsI=67=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AB56C433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2020 16:22:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A3CB20809
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2020 16:22:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pRVwVT/U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A3CB20809
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaM3p-0007fu-CW
	for qemu-devel@archiver.kernel.org; Sun, 17 May 2020 12:22:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53958)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1jaM2r-000623-JO
 for qemu-devel@nongnu.org; Sun, 17 May 2020 12:21:45 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:40548)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1jaM2q-0006kI-Hu
 for qemu-devel@nongnu.org; Sun, 17 May 2020 12:21:45 -0400
Received: by mail-pj1-x1043.google.com with SMTP id ci23so295576pjb.5
 for <qemu-devel@nongnu.org>; Sun, 17 May 2020 09:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=IKqSsLhQC2QhDVU4F5SnGseXmbR5yG/zUVktutymlAA=;
 b=pRVwVT/UIu66NLNKgJ1Uc8pOmlU3Jva7b6yje6lRz4QraVwOuCbMFzixR1NundotIo
 1QxdPB1ACr5ANxZdpbx5ilbnJUKsH1rhDokltV+JrxCKuALCgiissD0YZxpG1YhehePc
 tGETJndJHJUjdEKf6iWOosVB3yVF8N8JprgA+rFQraB+Nv4R3A7kI7JMu9QxRjkg//N0
 8NIJ/EC08bTUBt4vYeawQhWQ9oNovxBcF63gpjd+9T6t7J4Ii/Z5fJQc/sDJ6PieyLjV
 Fv2EtlKAJMrdOTs8KVBtTEuKN85IPvOFRNA3JVsRy8X9+ZO4FwOY/vFC5YaRiVUk6B7F
 DYmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=IKqSsLhQC2QhDVU4F5SnGseXmbR5yG/zUVktutymlAA=;
 b=Y6D66jVIJUzvepW37XD0GIlL9fFNqEgTTuWhdUPZEW7hDIOYcf+4wgpgwDghVKpeh6
 KmUIEzlA+l/vjqNqRX6+x9YPUOQQ4LrFPZpR7KzaiiRxgmjQYU8zcsJpgFh/l/y3zKJK
 pTsLXs5w/lJgkZP8DWXH1/2ZJewupR7mrkxxdVFNR88N7JXqqb9iNpbnMj71ajaJ34t2
 Qiarbd9sDUfSHm8Ve+CDRVcRODBw9YFvN7RZeFadBoOmRMppC4AHWOcJZ2J0F8+8cjUE
 Dwm8bsCH+zCeNWWwQDaTaO+ojWXEPUV9MVAdyuYSsTd27N2rmtPdEbvtKlk4eyHmPiws
 Wr4Q==
X-Gm-Message-State: AOAM5315NUownrbJN+LpHF3R1dlqRQ+5m/jGEZSXVx5PWeCPr88HDObD
 uIQtlhQJ3o7lSJQ02ntTeGA=
X-Google-Smtp-Source: ABdhPJxpInwON3cuq1M1xsmqbVKCruLFL/9C4Lh759yg1fzt5SjDmBpjEbYODtuQuZX6XtSaVDXCdg==
X-Received: by 2002:a17:902:930c:: with SMTP id
 bc12mr12637537plb.255.1589732503248; 
 Sun, 17 May 2020 09:21:43 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id h3sm577799pjk.10.2020.05.17.09.21.42
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 17 May 2020 09:21:42 -0700 (PDT)
From: Guenter Roeck <linux@roeck-us.net>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 1/8] hw: Move i.MX watchdog driver to hw/watchdog
Date: Sun, 17 May 2020 09:21:28 -0700
Message-Id: <20200517162135.110364-2-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200517162135.110364-1-linux@roeck-us.net>
References: <20200517162135.110364-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=groeck7@gmail.com; helo=mail-pj1-x1043.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>,
 Peter Chubb <peter.chubb@nicta.com.au>, qemu-devel@nongnu.org,
 Guenter Roeck <linux@roeck-us.net>,
 Jean-Christophe Dubois <jcd@tribudubois.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In preparation for a full implementation, move i.MX watchdog driver
from hw/misc to hw/watchdog. While at it, add the watchdog files
to MAINTAINERS.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v3: No change
v2: Instead of auto-selecting WDT_IMX2 if IMX is enabled, select it 
    explicitly for each emulation using it.
    In Makefile, fix CONFIG_WDT_IMX -> CONFIG_WDT_IMX2
    Added Philippe's Reviewed-by: tag

 MAINTAINERS                                         | 2 ++
 hw/arm/Kconfig                                      | 3 +++
 hw/misc/Makefile.objs                               | 1 -
 hw/watchdog/Kconfig                                 | 3 +++
 hw/watchdog/Makefile.objs                           | 1 +
 hw/{misc/imx2_wdt.c => watchdog/wdt_imx2.c}         | 2 +-
 include/hw/arm/fsl-imx6.h                           | 2 +-
 include/hw/arm/fsl-imx6ul.h                         | 2 +-
 include/hw/arm/fsl-imx7.h                           | 2 +-
 include/hw/{misc/imx2_wdt.h => watchdog/wdt_imx2.h} | 0
 10 files changed, 13 insertions(+), 5 deletions(-)
 rename hw/{misc/imx2_wdt.c => watchdog/wdt_imx2.c} (98%)
 rename include/hw/{misc/imx2_wdt.h => watchdog/wdt_imx2.h} (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8aa8efaf1d..998eb5053c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -631,8 +631,10 @@ S: Odd Fixes
 F: hw/arm/fsl-imx25.c
 F: hw/arm/imx25_pdk.c
 F: hw/misc/imx25_ccm.c
+F: hw/watchdog/wdt_imx2.c
 F: include/hw/arm/fsl-imx25.h
 F: include/hw/misc/imx25_ccm.h
+F: include/hw/watchdog/wdt_imx2.h
 
 i.MX31 (kzm)
 M: Peter Chubb <peter.chubb@nicta.com.au>
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 188419dc1e..adf401e827 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -374,6 +374,7 @@ config FSL_IMX6
     select IMX_FEC
     select IMX_I2C
     select IMX_USBPHY
+    select WDT_IMX2
     select SDHCI
 
 config ASPEED_SOC
@@ -411,6 +412,7 @@ config FSL_IMX7
     select IMX
     select IMX_FEC
     select IMX_I2C
+    select WDT_IMX2
     select PCI_EXPRESS_DESIGNWARE
     select SDHCI
     select UNIMP
@@ -424,6 +426,7 @@ config FSL_IMX6UL
     select IMX
     select IMX_FEC
     select IMX_I2C
+    select WDT_IMX2
     select SDHCI
     select UNIMP
 
diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
index 68aae2eabb..b25181b711 100644
--- a/hw/misc/Makefile.objs
+++ b/hw/misc/Makefile.objs
@@ -44,7 +44,6 @@ common-obj-$(CONFIG_IMX) += imx6_ccm.o
 common-obj-$(CONFIG_IMX) += imx6ul_ccm.o
 obj-$(CONFIG_IMX) += imx6_src.o
 common-obj-$(CONFIG_IMX) += imx7_ccm.o
-common-obj-$(CONFIG_IMX) += imx2_wdt.o
 common-obj-$(CONFIG_IMX) += imx7_snvs.o
 common-obj-$(CONFIG_IMX) += imx7_gpr.o
 common-obj-$(CONFIG_IMX) += imx_rngc.o
diff --git a/hw/watchdog/Kconfig b/hw/watchdog/Kconfig
index 2118d897c9..293209b291 100644
--- a/hw/watchdog/Kconfig
+++ b/hw/watchdog/Kconfig
@@ -14,3 +14,6 @@ config WDT_IB700
 
 config WDT_DIAG288
     bool
+
+config WDT_IMX2
+    bool
diff --git a/hw/watchdog/Makefile.objs b/hw/watchdog/Makefile.objs
index 3f536d1cad..631b711d86 100644
--- a/hw/watchdog/Makefile.objs
+++ b/hw/watchdog/Makefile.objs
@@ -4,3 +4,4 @@ common-obj-$(CONFIG_WDT_IB6300ESB) += wdt_i6300esb.o
 common-obj-$(CONFIG_WDT_IB700) += wdt_ib700.o
 common-obj-$(CONFIG_WDT_DIAG288) += wdt_diag288.o
 common-obj-$(CONFIG_ASPEED_SOC) += wdt_aspeed.o
+common-obj-$(CONFIG_WDT_IMX2) += wdt_imx2.o
diff --git a/hw/misc/imx2_wdt.c b/hw/watchdog/wdt_imx2.c
similarity index 98%
rename from hw/misc/imx2_wdt.c
rename to hw/watchdog/wdt_imx2.c
index 2aedfe803a..ad1ef02e9e 100644
--- a/hw/misc/imx2_wdt.c
+++ b/hw/watchdog/wdt_imx2.c
@@ -14,7 +14,7 @@
 #include "qemu/module.h"
 #include "sysemu/watchdog.h"
 
-#include "hw/misc/imx2_wdt.h"
+#include "hw/watchdog/wdt_imx2.h"
 
 #define IMX2_WDT_WCR_WDA    BIT(5)      /* -> External Reset WDOG_B */
 #define IMX2_WDT_WCR_SRS    BIT(4)      /* -> Software Reset Signal */
diff --git a/include/hw/arm/fsl-imx6.h b/include/hw/arm/fsl-imx6.h
index 973bcb72f7..1ebd751324 100644
--- a/include/hw/arm/fsl-imx6.h
+++ b/include/hw/arm/fsl-imx6.h
@@ -21,7 +21,7 @@
 #include "hw/cpu/a9mpcore.h"
 #include "hw/misc/imx6_ccm.h"
 #include "hw/misc/imx6_src.h"
-#include "hw/misc/imx2_wdt.h"
+#include "hw/watchdog/wdt_imx2.h"
 #include "hw/char/imx_serial.h"
 #include "hw/timer/imx_gpt.h"
 #include "hw/timer/imx_epit.h"
diff --git a/include/hw/arm/fsl-imx6ul.h b/include/hw/arm/fsl-imx6ul.h
index 1a0bab8daa..37c89cc5f9 100644
--- a/include/hw/arm/fsl-imx6ul.h
+++ b/include/hw/arm/fsl-imx6ul.h
@@ -24,7 +24,7 @@
 #include "hw/misc/imx7_snvs.h"
 #include "hw/misc/imx7_gpr.h"
 #include "hw/intc/imx_gpcv2.h"
-#include "hw/misc/imx2_wdt.h"
+#include "hw/watchdog/wdt_imx2.h"
 #include "hw/gpio/imx_gpio.h"
 #include "hw/char/imx_serial.h"
 #include "hw/timer/imx_gpt.h"
diff --git a/include/hw/arm/fsl-imx7.h b/include/hw/arm/fsl-imx7.h
index 706aef2e7e..3a0041c4c2 100644
--- a/include/hw/arm/fsl-imx7.h
+++ b/include/hw/arm/fsl-imx7.h
@@ -26,7 +26,7 @@
 #include "hw/misc/imx7_snvs.h"
 #include "hw/misc/imx7_gpr.h"
 #include "hw/misc/imx6_src.h"
-#include "hw/misc/imx2_wdt.h"
+#include "hw/watchdog/wdt_imx2.h"
 #include "hw/gpio/imx_gpio.h"
 #include "hw/char/imx_serial.h"
 #include "hw/timer/imx_gpt.h"
diff --git a/include/hw/misc/imx2_wdt.h b/include/hw/watchdog/wdt_imx2.h
similarity index 100%
rename from include/hw/misc/imx2_wdt.h
rename to include/hw/watchdog/wdt_imx2.h
-- 
2.17.1



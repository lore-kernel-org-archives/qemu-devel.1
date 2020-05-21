Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA53C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 19:24:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99636207D3
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 19:24:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IZ7vj/w1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99636207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbqnZ-0000lz-OA
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 15:24:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38048)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jbqgA-0002Mt-Fn
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:16:30 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:37538)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jbqg9-0000RK-1u
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:16:30 -0400
Received: by mail-wm1-x341.google.com with SMTP id z72so7561857wmc.2
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 12:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=DvN+yAsNtscyCciNcKwAxqrn3APcppH5Qh8vMf7lyFw=;
 b=IZ7vj/w1UL3YoaIRIbPUB4mFylEAAKI6W14C4BA49qkDqsRBsbJQxmRxGUI+ZVON1u
 g+OqSoFXIrGIl+yXWDT1U/YqUIvd1zslAYCpR2i+PgmkcaezKYHrP7JuJ49bJkoIv/4E
 nFwwdcq5HoSuewhffWdjKoY2jx8P08E66erTszjzJu3aD5bKcpGmXoaErFXzCTUNcNIC
 52Rj1Kx797FKV5ZhZdVLYNd4KNRWTTR6rJfV3UlZNyWTxHUvYB0w/RF5Dbko1tfCeg8V
 QkWb4JozP3Mk20V8FJQgAJQ/hMu5G8x0vd0EVavXV/v+bPPJQH3KeDLwP3lpEGmkjb2l
 ZlOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=DvN+yAsNtscyCciNcKwAxqrn3APcppH5Qh8vMf7lyFw=;
 b=gjzgk1uA5uTKUtwHefkfkJEcI1ZhssQiXnRBVHhFKf3ciQh+v1tP9ZpA4t5Ggwsn82
 hC/LI18NiqMkjiwVlmdaUZqQ/yp5u0JoIgpjn+AB9txvs/5AnDR4Ihs4GKq8RkgzFLdh
 cLDPHeRS7H4OE0k7WS7Z5L2pKgY5AfruQJltdkZUg6nREFaOmDJ9mrmQ0VsK6XY+PTmJ
 Fo+TBS5z1xzCpXl20E16JCR5ILqaHkMlM2qgYkHZCwR+mEocmfUXj30322q6PFmSHsDk
 UiD9hsmbp4hEpl7Vn0E8OS4xnUGRl44hJmtYi3w3T/NQX6qPuuLZzqHa/kTJav0Y6+t0
 1CGQ==
X-Gm-Message-State: AOAM533Zpqn5kl2XdjhclnAYE/aL2L3TB+/Ld2O54XFGmKRpnb7u21e4
 wudASF9+ZrOD/vI8gSpiZsAX5iBdJL/dJg==
X-Google-Smtp-Source: ABdhPJzFcepXl9ef9QFDKFln+wh0JQOj7awwNzItEPraV18UXIknNVxkI8glRHyy1QHqEMGJ9MOhaQ==
X-Received: by 2002:a1c:6506:: with SMTP id z6mr10589311wmb.104.1590088587304; 
 Thu, 21 May 2020 12:16:27 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id z124sm7335100wmg.20.2020.05.21.12.16.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 12:16:26 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/29] hw: Move i.MX watchdog driver to hw/watchdog
Date: Thu, 21 May 2020 20:15:53 +0100
Message-Id: <20200521191610.10941-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200521191610.10941-1-peter.maydell@linaro.org>
References: <20200521191610.10941-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Guenter Roeck <linux@roeck-us.net>

In preparation for a full implementation, move i.MX watchdog driver
from hw/misc to hw/watchdog. While at it, add the watchdog files
to MAINTAINERS.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Message-id: 20200517162135.110364-2-linux@roeck-us.net
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/fsl-imx6.h                           | 2 +-
 include/hw/arm/fsl-imx6ul.h                         | 2 +-
 include/hw/arm/fsl-imx7.h                           | 2 +-
 include/hw/{misc/imx2_wdt.h => watchdog/wdt_imx2.h} | 0
 hw/{misc/imx2_wdt.c => watchdog/wdt_imx2.c}         | 2 +-
 MAINTAINERS                                         | 2 ++
 hw/arm/Kconfig                                      | 3 +++
 hw/misc/Makefile.objs                               | 1 -
 hw/watchdog/Kconfig                                 | 3 +++
 hw/watchdog/Makefile.objs                           | 1 +
 10 files changed, 13 insertions(+), 5 deletions(-)
 rename include/hw/{misc/imx2_wdt.h => watchdog/wdt_imx2.h} (100%)
 rename hw/{misc/imx2_wdt.c => watchdog/wdt_imx2.c} (98%)

diff --git a/include/hw/arm/fsl-imx6.h b/include/hw/arm/fsl-imx6.h
index 973bcb72f7f..1ebd7513246 100644
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
index 1a0bab8daaf..37c89cc5f92 100644
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
index 706aef2e7e0..3a0041c4c26 100644
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
diff --git a/hw/misc/imx2_wdt.c b/hw/watchdog/wdt_imx2.c
similarity index 98%
rename from hw/misc/imx2_wdt.c
rename to hw/watchdog/wdt_imx2.c
index 2aedfe803a4..ad1ef02e9e7 100644
--- a/hw/misc/imx2_wdt.c
+++ b/hw/watchdog/wdt_imx2.c
@@ -14,7 +14,7 @@
 #include "qemu/module.h"
 #include "sysemu/watchdog.h"
 
-#include "hw/misc/imx2_wdt.h"
+#include "hw/watchdog/wdt_imx2.h"
 
 #define IMX2_WDT_WCR_WDA    BIT(5)      /* -> External Reset WDOG_B */
 #define IMX2_WDT_WCR_SRS    BIT(4)      /* -> Software Reset Signal */
diff --git a/MAINTAINERS b/MAINTAINERS
index 023f48d3eaa..3690f313c3b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -633,8 +633,10 @@ S: Odd Fixes
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
index 53641725371..3d05dc8538c 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -375,6 +375,7 @@ config FSL_IMX6
     select IMX_FEC
     select IMX_I2C
     select IMX_USBPHY
+    select WDT_IMX2
     select SDHCI
 
 config ASPEED_SOC
@@ -412,6 +413,7 @@ config FSL_IMX7
     select IMX
     select IMX_FEC
     select IMX_I2C
+    select WDT_IMX2
     select PCI_EXPRESS_DESIGNWARE
     select SDHCI
     select UNIMP
@@ -425,6 +427,7 @@ config FSL_IMX6UL
     select IMX
     select IMX_FEC
     select IMX_I2C
+    select WDT_IMX2
     select SDHCI
     select UNIMP
 
diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
index 68aae2eabbc..b25181b7113 100644
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
index 2118d897c93..293209b291d 100644
--- a/hw/watchdog/Kconfig
+++ b/hw/watchdog/Kconfig
@@ -14,3 +14,6 @@ config WDT_IB700
 
 config WDT_DIAG288
     bool
+
+config WDT_IMX2
+    bool
diff --git a/hw/watchdog/Makefile.objs b/hw/watchdog/Makefile.objs
index 3f536d1cad8..631b711d868 100644
--- a/hw/watchdog/Makefile.objs
+++ b/hw/watchdog/Makefile.objs
@@ -4,3 +4,4 @@ common-obj-$(CONFIG_WDT_IB6300ESB) += wdt_i6300esb.o
 common-obj-$(CONFIG_WDT_IB700) += wdt_ib700.o
 common-obj-$(CONFIG_WDT_DIAG288) += wdt_diag288.o
 common-obj-$(CONFIG_ASPEED_SOC) += wdt_aspeed.o
+common-obj-$(CONFIG_WDT_IMX2) += wdt_imx2.o
-- 
2.20.1



Return-Path: <SRS0=i8Yf=47=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F7A5C0044D
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 17:28:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DAD120782
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 17:28:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dbGR7lsQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DAD120782
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDAaU-000143-Hg
	for qemu-devel@archiver.kernel.org; Sat, 14 Mar 2020 13:28:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42919)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groeck7@gmail.com>) id 1jDAZb-0007ph-3F
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 13:27:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groeck7@gmail.com>) id 1jDAZZ-0005HN-QS
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 13:27:43 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:34855)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <groeck7@gmail.com>)
 id 1jDAZZ-0005Ck-L2; Sat, 14 Mar 2020 13:27:41 -0400
Received: by mail-pj1-x1041.google.com with SMTP id mq3so6013306pjb.0;
 Sat, 14 Mar 2020 10:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=c8+NrFQrAejVqIlPEDdLPF0zMrwlZfTWj58V1G1hCUA=;
 b=dbGR7lsQPCDshwtJzx3Drr6UAo6Y2pGWsFHRrTfhNI66LFd27ReqQXyEobLrLjWUm+
 awxge4BdHKq5ABtwOqJy/BBSM6Q+Z4Bl/5kZiw1mKWhkMdVdqy6mGfKD4TuLA+bcTlFl
 3okIeaC2QO8w3friQaZYtVyFRZ3flegwzLf/Ys7jfa2+PBZYBTMn7OPL+Uwbp0TDI7dD
 HvvNth4GzwT+3qeRw87ZFoF/G8e9xC9+whumuwRxNz0dyLunnzWGojYX6SVWCx2sHgT8
 7U9ZvDRpZRYRMvoM7qM5OFUVOjF/2yv3ldPk4Z2QMZ+jJ/AucctIpV+APX4hPrwFBORX
 jUFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=c8+NrFQrAejVqIlPEDdLPF0zMrwlZfTWj58V1G1hCUA=;
 b=XC/sLKbilfvZcGB+jQrW2Nrd778hHJ0oqpgEvUlpGJ0uZv11qbxFTfZjc/rXS52tdC
 ERkJMA6ai/VTERVb9MS3DMUci/noK+ef5Tcr+0i8ku5q58SLHNz4vU0/L5JFr2hPUXuB
 f8gDa9QeUMblUfa4vS8JXFUQupE4o8QkFxCkPCu2gU4G2odXZTL93Ax/R1I/g6ySTFE7
 /bvtvAvSdIHXBJP8tZCYKlIQqNm+SpCZ57LdLIowlAjVaS0X2+NYEH6AKhuZTWxgXhKb
 jsFhHPcr29E5zas5RrLln9bGy0t6T8r1JR2u3UKLO0p0Qe5/YChQKVN2mA+Qp8/8F0CE
 8yyw==
X-Gm-Message-State: ANhLgQ1JgVIG8mjFGmzYlXQi8NqV36FOACv40iV00uLfVNpEr1DYckXx
 8FgJUmqCWfuU97bI3HGffCo=
X-Google-Smtp-Source: ADFU+vvyws8tljqxmR2rM/DH5asTs/OyQlrZu/48h3C0kWgirMsDQG/NEMI9aICeH/IStgMpIOai4g==
X-Received: by 2002:a17:90a:21ac:: with SMTP id
 q41mr16370472pjc.41.1584206860560; 
 Sat, 14 Mar 2020 10:27:40 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id 31sm5067556pgt.2.2020.03.14.10.27.39
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sat, 14 Mar 2020 10:27:40 -0700 (PDT)
From: Guenter Roeck <linux@roeck-us.net>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 1/8] hw: Move i.MX watchdog driver to hw/watchdog
Date: Sat, 14 Mar 2020 10:27:29 -0700
Message-Id: <20200314172736.24528-2-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200314172736.24528-1-linux@roeck-us.net>
References: <20200314172736.24528-1-linux@roeck-us.net>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1041
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
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, qemu-devel@nongnu.org,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm@nongnu.org,
 Peter Chubb <peter.chubb@nicta.com.au>, Guenter Roeck <linux@roeck-us.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In preparation for a full implementation, move i.MX watchdog driver
from hw/misc to hw/watchdog. While at it, add the watchdog files
to MAINTAINERS.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 MAINTAINERS                                         | 2 ++
 hw/misc/Makefile.objs                               | 1 -
 hw/watchdog/Kconfig                                 | 5 +++++
 hw/watchdog/Makefile.objs                           | 1 +
 hw/{misc/imx2_wdt.c => watchdog/wdt_imx2.c}         | 2 +-
 include/hw/arm/fsl-imx6.h                           | 2 +-
 include/hw/arm/fsl-imx6ul.h                         | 2 +-
 include/hw/arm/fsl-imx7.h                           | 2 +-
 include/hw/{misc/imx2_wdt.h => watchdog/wdt_imx2.h} | 0
 9 files changed, 12 insertions(+), 5 deletions(-)
 rename hw/{misc/imx2_wdt.c => watchdog/wdt_imx2.c} (98%)
 rename include/hw/{misc/imx2_wdt.h => watchdog/wdt_imx2.h} (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 32867bc636..d1197014e8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -603,8 +603,10 @@ S: Odd Fixes
 F: hw/arm/fsl-imx25.c
 F: hw/arm/imx25_pdk.c
 F: hw/misc/imx25_ccm.c
+F: hw/watchdog/wdt_imx2.c
 F: include/hw/arm/fsl-imx25.h
 F: include/hw/misc/imx25_ccm.h
+F: include/hw/watchdog/wdt_imx2.h
 
 i.MX31 (kzm)
 M: Peter Chubb <peter.chubb@nicta.com.au>
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
index 2118d897c9..2c225b4b17 100644
--- a/hw/watchdog/Kconfig
+++ b/hw/watchdog/Kconfig
@@ -14,3 +14,8 @@ config WDT_IB700
 
 config WDT_DIAG288
     bool
+
+config WDT_IMX2
+    bool
+    default y
+    depends on IMX
diff --git a/hw/watchdog/Makefile.objs b/hw/watchdog/Makefile.objs
index 3f536d1cad..dd9b37f642 100644
--- a/hw/watchdog/Makefile.objs
+++ b/hw/watchdog/Makefile.objs
@@ -4,3 +4,4 @@ common-obj-$(CONFIG_WDT_IB6300ESB) += wdt_i6300esb.o
 common-obj-$(CONFIG_WDT_IB700) += wdt_ib700.o
 common-obj-$(CONFIG_WDT_DIAG288) += wdt_diag288.o
 common-obj-$(CONFIG_ASPEED_SOC) += wdt_aspeed.o
+common-obj-$(CONFIG_WDT_IMX) += wdt_imx2.o
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
index 60eadccb42..5b02dc1f4b 100644
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
index eda389aec7..91c746918a 100644
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



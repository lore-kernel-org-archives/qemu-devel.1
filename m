Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F69FC33CA1
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 22:07:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59ACB217F4
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 22:07:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B/yOlAbp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59ACB217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itfD8-0000uy-13
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 17:07:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51087)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1itf6t-0001fB-RN
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 17:01:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1itf6s-0005vH-Ei
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 17:01:27 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:46735)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1itf6s-0005ue-8a
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 17:01:26 -0500
Received: by mail-wr1-x442.google.com with SMTP id z7so1046137wrl.13
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2020 14:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+NnvBu9orDWG1N7gHYUnC7PSiKSlzB6OsFAWh9OHuuI=;
 b=B/yOlAbpya950w4hDwRav24Kuu5/ovEVhJgwpLG4033HlWBcEcCXLigfZ23mvGsmLn
 fQvceftHFPol+3QyMmrIn8viqvtDZT06aiQwwF98mc/GLUftO5pZ0X8fQ5mrhCLvJVTe
 vknnul7YaldMUcz2bqq3etXcQY3O9a5zBImJRMbtfmdFXP4HS8QXNWvdXsNrpMWTptyN
 AazeE5M5sr5JAsNMM6CxjiZWlnEUQAa+YtupILYyHBAU+3VHZJaloZW/6nrcgnvgSXlX
 HLBJ1McxEQRwiFuusqYrtahBT9iSHImyy31XjrQvRUF4vUgORqMKscgxbCI7gL+X8u6o
 vn5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=+NnvBu9orDWG1N7gHYUnC7PSiKSlzB6OsFAWh9OHuuI=;
 b=EH98yfl3k6/rEgW8BBuqafv7IiqCBgjypuQAl18MGOnkA4nfT2LxqmbtF5CaJ5yUvQ
 SvMZbriL7EZ1cPkmVzZxgFTmwcbDa9HLgkTSi1CTHW2sTnrZcFcW0Qw/gCdf1JfNr0YB
 ZD7kfekuVg31q9u00lEjKf0zx39Pz8fOMb20wVD+sTVP6KaoKjbIpBDF/MsxhUPi6hu9
 uOxxscuY84C4oieMuS1WWS8Q4KFve8WthatixCDDx/q4B9yXOBB1OmB2hNDvT3EmNMnY
 DicIpiy5tn/tTciCJU2IoScDdh23hV+uJZupx5jFha4Lc8oAz2cRGcO2HiUexlDHN3tm
 Mnsw==
X-Gm-Message-State: APjAAAVU2yJ3G6vIeqosvz2Oxekh1gmNQBfH6innyrxinO035PcxHYdW
 3F1OIZsXhlg/+PxgWL5dh405i+qA
X-Google-Smtp-Source: APXvYqx9DHbVcMJX04dGQhygF68sNrinUKq8XskGWtp8cyszLS+v/0b8yC4AWGEgyMQRkWTxwoFu6Q==
X-Received: by 2002:a5d:670a:: with SMTP id o10mr1466295wru.227.1579557685014; 
 Mon, 20 Jan 2020 14:01:25 -0800 (PST)
Received: from x1w.redhat.com (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id f1sm904341wmc.45.2020.01.20.14.01.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2020 14:01:24 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 11/18] hw/misc: Rename avr_mask -> atmel_power
Date: Mon, 20 Jan 2020 23:01:00 +0100
Message-Id: <20200120220107.17825-12-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200120220107.17825-1-f4bug@amsat.org>
References: <20200120220107.17825-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: Sarah Harris <S.E.Harris@kent.ac.uk>, Michael Rolnik <mrolnik@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

AVR is the architecture, Atmel the manufacturer.

Suggested-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
!squash
---
 include/hw/misc/{avr_mask.h => atmel_power.h} | 10 +++++-----
 hw/avr/sample.c                               |  2 +-
 hw/misc/{avr_mask.c => atmel_power.c}         |  4 ++--
 MAINTAINERS                                   |  4 ++--
 hw/avr/Kconfig                                |  2 +-
 hw/misc/Kconfig                               |  2 +-
 hw/misc/Makefile.objs                         |  2 +-
 7 files changed, 13 insertions(+), 13 deletions(-)
 rename include/hw/misc/{avr_mask.h => atmel_power.h} (89%)
 rename hw/misc/{avr_mask.c => atmel_power.c} (97%)

diff --git a/include/hw/misc/avr_mask.h b/include/hw/misc/atmel_power.h
similarity index 89%
rename from include/hw/misc/avr_mask.h
rename to include/hw/misc/atmel_power.h
index 5f95e1081d..5366e9693f 100644
--- a/include/hw/misc/avr_mask.h
+++ b/include/hw/misc/atmel_power.h
@@ -1,5 +1,5 @@
 /*
- * AVR Power Reduction
+ * Atmel AVR Power Reduction Management
  *
  * Copyright (c) 2019 Michael Rolnik
  *
@@ -22,14 +22,14 @@
  * THE SOFTWARE.
  */
 
-#ifndef HW_avr_mask_H
-#define HW_avr_mask_H
+#ifndef HW_MISC_ATMEL_POWER_H
+#define HW_MISC_ATMEL_POWER_H
 
 #include "hw/sysbus.h"
 #include "hw/hw.h"
 
 
-#define TYPE_AVR_MASK "avr-mask"
+#define TYPE_AVR_MASK "atmel-power"
 #define AVR_MASK(obj) OBJECT_CHECK(AVRMaskState, (obj), TYPE_AVR_MASK)
 
 typedef struct {
@@ -43,4 +43,4 @@ typedef struct {
     qemu_irq irq[8];
 } AVRMaskState;
 
-#endif /* HW_avr_mask_H */
+#endif /* HW_MISC_ATMEL_POWER_H */
diff --git a/hw/avr/sample.c b/hw/avr/sample.c
index 19e9f56f3b..19b8c067e5 100644
--- a/hw/avr/sample.c
+++ b/hw/avr/sample.c
@@ -46,7 +46,7 @@
 #include "include/hw/sysbus.h"
 #include "include/hw/char/atmel_usart.h"
 #include "include/hw/timer/atmel_timer16.h"
-#include "include/hw/misc/avr_mask.h"
+#include "include/hw/misc/atmel_power.h"
 #include "elf.h"
 #include "hw/misc/unimp.h"
 
diff --git a/hw/misc/avr_mask.c b/hw/misc/atmel_power.c
similarity index 97%
rename from hw/misc/avr_mask.c
rename to hw/misc/atmel_power.c
index 3af82ed9c1..adab729f66 100644
--- a/hw/misc/avr_mask.c
+++ b/hw/misc/atmel_power.c
@@ -1,5 +1,5 @@
 /*
- * AVR Power Reduction
+ * Atmel AVR Power Reduction Management
  *
  * Copyright (c) 2019 Michael Rolnik
  *
@@ -23,7 +23,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/misc/avr_mask.h"
+#include "hw/misc/atmel_power.h"
 #include "qemu/log.h"
 #include "hw/qdev-properties.h"
 #include "hw/irq.h"
diff --git a/MAINTAINERS b/MAINTAINERS
index a98d164bc1..60634cebf4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -900,8 +900,8 @@ F: hw/char/atmel_usart.c
 F: include/hw/char/atmel_usart.h
 F: hw/timer/atmel_timer16.c
 F: include/hw/timer/atmel_timer16.h
-F: hw/misc/avr_mask.c
-F: include/hw/misc/avr_mask.h
+F: hw/misc/atmel_power.c
+F: include/hw/misc/atmel_power.h
 F: tests/acceptance/machine_avr6.py
 
 CRIS Machines
diff --git a/hw/avr/Kconfig b/hw/avr/Kconfig
index 45c7025f09..516b89c849 100644
--- a/hw/avr/Kconfig
+++ b/hw/avr/Kconfig
@@ -2,5 +2,5 @@ config AVR_SAMPLE
     bool
     select ATMEL_TIMER16
     select ATMEL_USART
-    select AVR_MASK
+    select ATMEL_POWER
     select UNIMP
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 74a1e9a241..3a3c32e1b0 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -131,7 +131,7 @@ config MAC_VIA
     select MOS6522
     select ADB
 
-config AVR_MASK
+config ATMEL_POWER
     bool
 
 source macio/Kconfig
diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
index bbf17f651b..e605964f4b 100644
--- a/hw/misc/Makefile.objs
+++ b/hw/misc/Makefile.objs
@@ -86,4 +86,4 @@ obj-$(CONFIG_MAC_VIA) += mac_via.o
 
 common-obj-$(CONFIG_GRLIB) += grlib_ahb_apb_pnp.o
 
-obj-$(CONFIG_AVR_MASK) += avr_mask.o
+obj-$(CONFIG_ATMEL_POWER) += atmel_power.o
-- 
2.21.1



Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E354EC33CAA
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 22:09:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF3B4217F4
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 22:09:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oaa+o8Ns"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF3B4217F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itfEy-0003Gp-9P
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 17:09:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51062)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1itf6s-0001dL-IK
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 17:01:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1itf6q-0005u1-Me
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 17:01:26 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:43756)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1itf6q-0005rw-FJ
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 17:01:24 -0500
Received: by mail-wr1-x444.google.com with SMTP id d16so1073871wre.10
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2020 14:01:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=UQvT/CeiP8OEft2xfUgYX9Y5aK54LLaIy+QVL2zdo+8=;
 b=oaa+o8Nswmhagm5864ATtzY2QJbB3+4IUQYShVvp2Wsr1R14h8pMAKYCFQte4NnJ/D
 8vZRwn5GH7y5SxpC8n5UJuGL7FUyXvjmUNMoLsxysa8wWgi8Zx/7Sl+IJEm28gNS2zbs
 ISx90/TM+NxDsqfWeLV4y325/yltSEYtr1c51w6jpaLuZxIzNWhaHcdatXhammY9woFE
 THfzd83oocBAr1xWrmn0k8APDDo0B9XOvZOr7HpWQM8QafyXEfD/NJ5bkhTeu7PgpO27
 SbjYD6Qh2wwg4Erq6hZwUfQFIglSDGhRoGfFD8hHd9eWKE0/cQKarQphCVPFcI/zggOB
 aRYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=UQvT/CeiP8OEft2xfUgYX9Y5aK54LLaIy+QVL2zdo+8=;
 b=KTCkkiTSxDoBhfd+vY12yAWDyHzDXxzb4o0EVCpYTxeMIzUkwuA22CIk1gemiZcJod
 huk8LEygJeEm4HHdsgZjT3p+xKbjNWfbL9jbDwQivg+2fzPnsdStKX/jTSkkEyj72Uba
 Jv0XVZTHjUritA/mP52ma2vD30J4cRtqrH9hpP7M+s2lfrHC1AxqymLSzgmMVNnxgsGX
 6zfKIcPZ+4nMp6dDzdqYR0/V+iod7bRFp+eYNRyX94uhzFhNp8ylWAhIXhpgqc8RPxXx
 rmlfc5CNzODurLn4d7exlsscFsiWyNrYwxsLhVu1vD+zK1ujBMQqqgFOV8KahsBtB/z3
 LePQ==
X-Gm-Message-State: APjAAAVqJBiFhODEQq39wsoTxlzUHviXuBNaRn1+twqLE7pt9yTntNVN
 zL9ptTd1boaPI90YT43o/c2cQNOg
X-Google-Smtp-Source: APXvYqwWkKG5iMqxgBUDwspeB/VIXbC+IqZloAHW8Joz2Oz4JhvrDl+MU16MgnK0Zr3M/lnCr1F43Q==
X-Received: by 2002:adf:f411:: with SMTP id g17mr1433147wro.89.1579557682235; 
 Mon, 20 Jan 2020 14:01:22 -0800 (PST)
Received: from x1w.redhat.com (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id f1sm904341wmc.45.2020.01.20.14.01.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2020 14:01:21 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 09/18] hw/char: Rename avr_usart -> atmel_usart
Date: Mon, 20 Jan 2020 23:00:58 +0100
Message-Id: <20200120220107.17825-10-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200120220107.17825-1-f4bug@amsat.org>
References: <20200120220107.17825-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: Sarah Harris <S.E.Harris@kent.ac.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Michael Rolnik <mrolnik@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
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
 include/hw/char/{avr_usart.h => atmel_usart.h} | 10 +++++-----
 hw/avr/sample.c                                |  2 +-
 hw/char/{avr_usart.c => atmel_usart.c}         |  4 ++--
 MAINTAINERS                                    |  4 ++--
 hw/avr/Kconfig                                 |  2 +-
 hw/char/Kconfig                                |  2 +-
 hw/char/Makefile.objs                          |  2 +-
 7 files changed, 13 insertions(+), 13 deletions(-)
 rename include/hw/char/{avr_usart.h => atmel_usart.h} (93%)
 rename hw/char/{avr_usart.c => atmel_usart.c} (99%)

diff --git a/include/hw/char/avr_usart.h b/include/hw/char/atmel_usart.h
similarity index 93%
rename from include/hw/char/avr_usart.h
rename to include/hw/char/atmel_usart.h
index 467e97e8c0..fd35feac60 100644
--- a/include/hw/char/avr_usart.h
+++ b/include/hw/char/atmel_usart.h
@@ -1,5 +1,5 @@
 /*
- * AVR USART
+ * Atmel AVR USART
  *
  * Copyright (c) 2018 University of Kent
  * Author: Sarah Harris
@@ -19,8 +19,8 @@
  * <http://www.gnu.org/licenses/lgpl-2.1.html>
  */
 
-#ifndef HW_AVR_USART_H
-#define HW_AVR_USART_H
+#ifndef HW_CHAR_ATMEL_USART_H
+#define HW_CHAR_ATMEL_USART_H
 
 #include "hw/sysbus.h"
 #include "chardev/char-fe.h"
@@ -56,7 +56,7 @@
 #define USART_CSRC_CSZ1   (1 << 2)
 #define USART_CSRC_CSZ0   (1 << 1)
 
-#define TYPE_AVR_USART "avr-usart"
+#define TYPE_AVR_USART "atmel-usart"
 #define AVR_USART(obj) \
     OBJECT_CHECK(AVRUsartState, (obj), TYPE_AVR_USART)
 
@@ -90,4 +90,4 @@ typedef struct {
     qemu_irq dre_irq;
 } AVRUsartState;
 
-#endif /* HW_AVR_USART_H */
+#endif /* HW_CHAR_ATMEL_USART_H */
diff --git a/hw/avr/sample.c b/hw/avr/sample.c
index 95094a8d6c..ca67c11233 100644
--- a/hw/avr/sample.c
+++ b/hw/avr/sample.c
@@ -44,7 +44,7 @@
 #include "qemu/error-report.h"
 #include "exec/address-spaces.h"
 #include "include/hw/sysbus.h"
-#include "include/hw/char/avr_usart.h"
+#include "include/hw/char/atmel_usart.h"
 #include "include/hw/timer/avr_timer16.h"
 #include "include/hw/misc/avr_mask.h"
 #include "elf.h"
diff --git a/hw/char/avr_usart.c b/hw/char/atmel_usart.c
similarity index 99%
rename from hw/char/avr_usart.c
rename to hw/char/atmel_usart.c
index becdb87847..a7004c212a 100644
--- a/hw/char/avr_usart.c
+++ b/hw/char/atmel_usart.c
@@ -1,5 +1,5 @@
 /*
- * AVR USART
+ * Atmel AVR USART
  *
  * Copyright (c) 2018 University of Kent
  * Author: Sarah Harris
@@ -20,7 +20,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/char/avr_usart.h"
+#include "hw/char/atmel_usart.h"
 #include "qemu/log.h"
 #include "hw/irq.h"
 #include "hw/qdev-properties.h"
diff --git a/MAINTAINERS b/MAINTAINERS
index 4998fee99a..f2e01a6d16 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -896,8 +896,8 @@ M: Michael Rolnik <mrolnik@gmail.com>
 R: Sarah Harris <S.E.Harris@kent.ac.uk>
 S: Maintained
 F: hw/avr/
-F: hw/char/avr_usart.c
-F: include/hw/char/avr_usart.h
+F: hw/char/atmel_usart.c
+F: include/hw/char/atmel_usart.h
 F: hw/timer/avr_timer16.c
 F: include/hw/timer/avr_timer16.h
 F: hw/misc/avr_mask.c
diff --git a/hw/avr/Kconfig b/hw/avr/Kconfig
index 92aa1e6afb..8084a73176 100644
--- a/hw/avr/Kconfig
+++ b/hw/avr/Kconfig
@@ -1,6 +1,6 @@
 config AVR_SAMPLE
     bool
     select AVR_TIMER16
-    select AVR_USART
+    select ATMEL_USART
     select AVR_MASK
     select UNIMP
diff --git a/hw/char/Kconfig b/hw/char/Kconfig
index 331b20983f..5a27681884 100644
--- a/hw/char/Kconfig
+++ b/hw/char/Kconfig
@@ -47,5 +47,5 @@ config SCLPCONSOLE
 config TERMINAL3270
     bool
 
-config AVR_USART
+config ATMEL_USART
     bool
diff --git a/hw/char/Makefile.objs b/hw/char/Makefile.objs
index f05c1f5667..c23ad3b4a7 100644
--- a/hw/char/Makefile.objs
+++ b/hw/char/Makefile.objs
@@ -21,7 +21,7 @@ obj-$(CONFIG_PSERIES) += spapr_vty.o
 obj-$(CONFIG_DIGIC) += digic-uart.o
 obj-$(CONFIG_STM32F2XX_USART) += stm32f2xx_usart.o
 obj-$(CONFIG_RASPI) += bcm2835_aux.o
-common-obj-$(CONFIG_AVR_USART) += avr_usart.o
+common-obj-$(CONFIG_ATMEL_USART) += atmel_usart.o
 
 common-obj-$(CONFIG_CMSDK_APB_UART) += cmsdk-apb-uart.o
 common-obj-$(CONFIG_ETRAXFS) += etraxfs_ser.o
-- 
2.21.1



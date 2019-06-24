Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A8FC4646B
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 22:09:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 936F420663
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 22:09:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lD2uCuKH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 936F420663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54908 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfX93-0004mn-NT
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 18:09:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54667)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1hfX1L-0007jI-SH
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 18:01:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1hfX1J-000317-KK
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 18:01:03 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:51412)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1hfX1J-000301-DW
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 18:01:01 -0400
Received: by mail-wm1-x344.google.com with SMTP id 207so790029wma.1
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2019 15:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=CqzSg8zo4MBdOpl0X3dMGpLIXRC6uXRJAn0bBo9bK7c=;
 b=lD2uCuKH6chTdQVqVYa/7gU6DU14+ItN7EFSol7TEDN5rO+vqbLXdpHW7BoHg1MTnW
 PCW8KAE7KbTsPebxBMFkHADiwGEKFztXyVMtCWG0LBJARhUNT+nP9V8zKJKJwpFvYvjf
 g+DNj89z6BN5kja8kZjIdag2kHgeAYVf4NY4/NlLuuDxdIhwADMnPnhw8WyY6Nm2oHU8
 f4fxB2KyCQyE0tABv1IzGZxQnwQbWd0+AVu3ZJ+4TiACFbkDypXcQD/JEy2L/wSocEJk
 GBzk+ACCgKcUzKx43a2LOfxxbW3WUpiCtza45ihjLL6wVL6Z370jLc3psEyQPIk0qK43
 pSUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=CqzSg8zo4MBdOpl0X3dMGpLIXRC6uXRJAn0bBo9bK7c=;
 b=gwaNA/2ai+Jtt+hB3cs2oj9iC1xeYB07H5KjNZSdZOj8RLpJYyx13A104IJFX5ih83
 L4p7LjjBSW5fnjBU33nTsQC4P7bG1GYRntn+UnvV9IKwfqIbv8RvO2RShyEl86pw6bW9
 jH1rulnugOofDbGdKcGeImwwe5dkHR1TfJES2XCcMCdpJWBDKXMQPrBGt4lMCLCKUDly
 cnpBojcxTEmBxWnwfFH5Seis3ZmEUWZPenWb7UCixCCgsgxOSyL1x58JZ7qFDyBjt6VC
 wkUIEsDN/9ssfrDqsWgHaCXYYiQ3+sOpNecf+tZ9D0fjgddNHZFkASfgyRhxPZsgIQNm
 inOw==
X-Gm-Message-State: APjAAAUAzqrqonFk2F5p0QjGN5niC1cMUmhyfz0rmmo7BbPCY4OHieq0
 wCLnslcN9lnZ5WlqQdUa4d9AIaPC
X-Google-Smtp-Source: APXvYqwuMeLCbGnHCLv7mdvBTdf2xDLPmRx3jG1weTHJx1B1pyh5zL6VLj+uC6drsZpAB/zldQ1GZA==
X-Received: by 2002:a7b:cd84:: with SMTP id y4mr17403808wmj.79.1561413660101; 
 Mon, 24 Jun 2019 15:01:00 -0700 (PDT)
Received: from x1.local (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id z126sm1118612wmb.32.2019.06.24.15.00.58
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 24 Jun 2019 15:00:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Date: Tue, 25 Jun 2019 00:00:48 +0200
Message-Id: <20190624220056.25861-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190624220056.25861-1-f4bug@amsat.org>
References: <20190624220056.25861-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: [Qemu-devel] [PATCH 1/9] hw/misc: Move the 'empty_slot' device to
 hw/misc/
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
 Aleksandar Rikalo <arikalo@wavecomp.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/empty_slot.h        |  7 -------
 include/hw/misc/empty_slot.h   | 32 ++++++++++++++++++++++++++++++++
 hw/mips/mips_malta.c           |  2 +-
 hw/{core => misc}/empty_slot.c |  2 +-
 hw/sparc/sun4m.c               |  2 +-
 hw/core/Makefile.objs          |  1 -
 hw/misc/Makefile.objs          |  1 +
 7 files changed, 36 insertions(+), 11 deletions(-)
 delete mode 100644 include/hw/empty_slot.h
 create mode 100644 include/hw/misc/empty_slot.h
 rename hw/{core => misc}/empty_slot.c (98%)

diff --git a/include/hw/empty_slot.h b/include/hw/empty_slot.h
deleted file mode 100644
index 123a9f8989..0000000000
--- a/include/hw/empty_slot.h
+++ /dev/null
@@ -1,7 +0,0 @@
-#ifndef HW_EMPTY_SLOT_H
-#define HW_EMPTY_SLOT_H
-
-/* empty_slot.c */
-void empty_slot_init(hwaddr addr, uint64_t slot_size);
-
-#endif
diff --git a/include/hw/misc/empty_slot.h b/include/hw/misc/empty_slot.h
new file mode 100644
index 0000000000..46483f24c3
--- /dev/null
+++ b/include/hw/misc/empty_slot.h
@@ -0,0 +1,32 @@
+/*
+ * QEMU Empty Slot
+ *
+ * The empty_slot device emulates known to a bus but not connected devices.
+ *
+ * Copyright (c) 2010 Artyom Tarasenko
+ *
+ * This code is licensed under the GNU GPL v2 or (at your option) any later
+ * version.
+ */
+
+#ifndef HW_EMPTY_SLOT_H
+#define HW_EMPTY_SLOT_H
+
+/**
+ * empty_slot_init: create and map a RAZ/WI device
+ * @base: base address of the device's MMIO region
+ * @size: size of the device's MMIO region
+ *
+ * This utility function creates and maps an instance of empty slot,
+ * which is a dummy device which simply read as zero, and ignore writes.
+ * An empty slot sit on a bus, and no bus errors are generated when it is
+ * accessed.
+ * Guest accesses can be traced, using the '-trace empty_slot\*' command
+ * line argument.
+ * The device is mapped at priority -10000, which means that you can
+ * use it to cover a large region and then map other devices on top of it
+ * if necessary.
+ */
+void empty_slot_init(hwaddr addr, uint64_t slot_size);
+
+#endif
diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index 37ec89b07e..7008be2e5b 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -53,7 +53,7 @@
 #include "sysemu/qtest.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
-#include "hw/empty_slot.h"
+#include "hw/misc/empty_slot.h"
 #include "sysemu/kvm.h"
 #include "hw/semihosting/semihost.h"
 #include "hw/mips/cps.h"
diff --git a/hw/core/empty_slot.c b/hw/misc/empty_slot.c
similarity index 98%
rename from hw/core/empty_slot.c
rename to hw/misc/empty_slot.c
index c694532046..0adf7a26dc 100644
--- a/hw/core/empty_slot.c
+++ b/hw/misc/empty_slot.c
@@ -13,7 +13,7 @@
 #include "hw/hw.h"
 #include "hw/sysbus.h"
 #include "qemu/module.h"
-#include "hw/empty_slot.h"
+#include "hw/misc/empty_slot.h"
 
 //#define DEBUG_EMPTY_SLOT
 
diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index 7e4f61fc3e..cc85598d5b 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -41,7 +41,7 @@
 #include "hw/nvram/chrp_nvram.h"
 #include "hw/nvram/fw_cfg.h"
 #include "hw/char/escc.h"
-#include "hw/empty_slot.h"
+#include "hw/misc/empty_slot.h"
 #include "hw/loader.h"
 #include "elf.h"
 #include "trace.h"
diff --git a/hw/core/Makefile.objs b/hw/core/Makefile.objs
index a799c83815..5122a28a3b 100644
--- a/hw/core/Makefile.objs
+++ b/hw/core/Makefile.objs
@@ -8,7 +8,6 @@ common-obj-y += irq.o
 common-obj-y += hotplug.o
 common-obj-$(CONFIG_SOFTMMU) += nmi.o
 
-common-obj-$(CONFIG_EMPTY_SLOT) += empty_slot.o
 common-obj-$(CONFIG_XILINX_AXI) += stream.o
 common-obj-$(CONFIG_PTIMER) += ptimer.o
 common-obj-$(CONFIG_SOFTMMU) += sysbus.o
diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
index 77b9df9796..8ed900f9f5 100644
--- a/hw/misc/Makefile.objs
+++ b/hw/misc/Makefile.objs
@@ -10,6 +10,7 @@ common-obj-$(CONFIG_EDU) += edu.o
 common-obj-$(CONFIG_PCA9552) += pca9552.o
 
 common-obj-y += unimp.o
+common-obj-$(CONFIG_EMPTY_SLOT) += empty_slot.o
 common-obj-$(CONFIG_FW_CFG_DMA) += vmcoreinfo.o
 
 # ARM devices
-- 
2.19.1



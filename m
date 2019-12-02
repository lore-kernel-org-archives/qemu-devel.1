Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DA1BC432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 21:42:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54C2F206F0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 21:42:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rgGZ9TSu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54C2F206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibtSw-0007mr-Tm
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 16:42:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38242)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1ibsxc-0002e3-Qy
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 16:10:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1ibsxQ-0000h5-Q9
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 16:10:19 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:51721)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1ibsxM-0000YW-Jq; Mon, 02 Dec 2019 16:10:09 -0500
Received: by mail-wm1-x343.google.com with SMTP id g206so842231wme.1;
 Mon, 02 Dec 2019 13:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=AgPJ0iFJ+07Qrw6Zp/uHV5hRBVIzjEeNp0NWpzIpFCg=;
 b=rgGZ9TSu23Brs9CWi1uIQPcIbNmWeZcN/XhCELuSS2DL2iCh23d1NIEAaKqMbOGgOr
 bfwleHIBxy6v0TxJt1nLLwfFWshKFgnNr3o6glgpKWZ1oVERhdyadmzDf/BcstzKRVej
 iqB+EGR01Dsme50rkNuGO7i9HhFilODj08WIQH06Sw95oSu6I++jH4DDdsPdnJG7JE2Z
 JQwHOI2LGmgVp++FOEUV8kQBYy2PtVpUnMB1KReteWREc9M8yf7FPYEAUudrNy/xOHPH
 pZWSeIxeuR67xVPbdpWbX13WqEDiHcy4aPTLEof5571p7UjE43IwC2cQl2AYUIKv7+dR
 pgww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=AgPJ0iFJ+07Qrw6Zp/uHV5hRBVIzjEeNp0NWpzIpFCg=;
 b=K1aqZI8rKogup5Jt3rCyye8u1GaWUl5yrrxtQrZgnPmVSHG9iDpSKUfKjxjyI44rKa
 7HfiSfKAvPzU8191zwGWY670sk9rjaGPXn4yrliCM7T8mBYqc7Yxil5T2TnrPRPBJm6R
 RJCVpvO6tTPwHFKQgy6Q8PhoRlqkc9/WwNzdJiSIyIowB5jVgiEdWRdcReu4rnzpg/VR
 FJXD5//2KYq3nMesDWmMvVNT+x5riMaipOfF/p776rcF6NPNgQe8e5cFTGlq+vsNyuc3
 vpK18lwe+WOo4Xe3Ihj2J/YPG/biEvD04YglTsY33FdXODOejIjpe1M0b/AfGmo8j2pb
 YcDw==
X-Gm-Message-State: APjAAAXn96YHcHukpXDujDG+XrXtZrZQx8mCLUzytjvvkC9yfcUcq603
 zYwgTNxZSfF8QGxZlZkUw2T+aNW9
X-Google-Smtp-Source: APXvYqw6rG3hbLOmq69AFvJQVLQvvQcyMToopuC6AXQD8ZPprAb/qasF0hNcORuNguocsSz5Yfnm9Q==
X-Received: by 2002:a7b:cb0b:: with SMTP id u11mr22335109wmj.64.1575320998608; 
 Mon, 02 Dec 2019 13:09:58 -0800 (PST)
Received: from pavilion.home ([2a02:a456:6be8:1:8edc:d4ff:fe8b:18b7])
 by smtp.gmail.com with ESMTPSA id f1sm770859wrp.93.2019.12.02.13.09.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2019 13:09:58 -0800 (PST)
From: Niek Linnenbank <nieklinnenbank@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 02/10] hw: arm: add Xunlong Orange Pi PC machine
Date: Mon,  2 Dec 2019 22:09:39 +0100
Message-Id: <20191202210947.3603-3-nieklinnenbank@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191202210947.3603-1-nieklinnenbank@gmail.com>
References: <20191202210947.3603-1-nieklinnenbank@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
X-Mailman-Approved-At: Mon, 02 Dec 2019 16:38:22 -0500
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
Cc: b.galvani@gmail.com, peter.maydell@linaro.org,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The Xunlong Orange Pi PC is an Allwinner H3 System on Chip
based embedded computer with mainline support in both U-Boot
and Linux. The board comes with a Quad Core Cortex A7 @ 1.3GHz,
512MB RAM, 100Mbit ethernet, USB, SD/MMC, USB, HDMI and
various other I/O. This commit add support for the Xunlong
Orange Pi PC machine.

Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>
---
 MAINTAINERS          |  1 +
 hw/arm/Makefile.objs |  2 +-
 hw/arm/orangepi.c    | 90 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 92 insertions(+), 1 deletion(-)
 create mode 100644 hw/arm/orangepi.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 29c9936037..42c913d6cb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -485,6 +485,7 @@ L: qemu-arm@nongnu.org
 S: Maintained
 F: hw/*/allwinner-h3*
 F: include/hw/*/allwinner-h3*
+F: hw/arm/orangepi.c
 
 ARM PrimeCell and CMSDK devices
 M: Peter Maydell <peter.maydell@linaro.org>
diff --git a/hw/arm/Makefile.objs b/hw/arm/Makefile.objs
index 956e496052..8d5ea453d5 100644
--- a/hw/arm/Makefile.objs
+++ b/hw/arm/Makefile.objs
@@ -34,7 +34,7 @@ obj-$(CONFIG_DIGIC) += digic.o
 obj-$(CONFIG_OMAP) += omap1.o omap2.o
 obj-$(CONFIG_STRONGARM) += strongarm.o
 obj-$(CONFIG_ALLWINNER_A10) += allwinner-a10.o cubieboard.o
-obj-$(CONFIG_ALLWINNER_H3) += allwinner-h3.o
+obj-$(CONFIG_ALLWINNER_H3) += allwinner-h3.o orangepi.o
 obj-$(CONFIG_RASPI) += bcm2835_peripherals.o bcm2836.o raspi.o
 obj-$(CONFIG_STM32F205_SOC) += stm32f205_soc.o
 obj-$(CONFIG_XLNX_ZYNQMP_ARM) += xlnx-zynqmp.o xlnx-zcu102.o
diff --git a/hw/arm/orangepi.c b/hw/arm/orangepi.c
new file mode 100644
index 0000000000..5ef2735f81
--- /dev/null
+++ b/hw/arm/orangepi.c
@@ -0,0 +1,90 @@
+/*
+ * Orange Pi emulation
+ *
+ * Copyright (C) 2019 Niek Linnenbank <nieklinnenbank@gmail.com>
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "exec/address-spaces.h"
+#include "qapi/error.h"
+#include "cpu.h"
+#include "hw/sysbus.h"
+#include "hw/boards.h"
+#include "hw/qdev-properties.h"
+#include "hw/arm/allwinner-h3.h"
+
+static struct arm_boot_info orangepi_binfo = {
+    .loader_start = AW_H3_SDRAM_BASE,
+    .board_id = -1,
+};
+
+typedef struct OrangePiState {
+    AwH3State *h3;
+    MemoryRegion sdram;
+} OrangePiState;
+
+static void orangepi_init(MachineState *machine)
+{
+    OrangePiState *s = g_new(OrangePiState, 1);
+    Error *err = NULL;
+
+    s->h3 = AW_H3(object_new(TYPE_AW_H3));
+
+    /* Setup timer properties */
+    object_property_set_int(OBJECT(&s->h3->timer), 32768, "clk0-freq", &err);
+    if (err != NULL) {
+        error_reportf_err(err, "Couldn't set clk0 frequency: ");
+        exit(1);
+    }
+
+    object_property_set_int(OBJECT(&s->h3->timer), 24000000, "clk1-freq",
+                            &err);
+    if (err != NULL) {
+        error_reportf_err(err, "Couldn't set clk1 frequency: ");
+        exit(1);
+    }
+
+    /* Mark H3 object realized */
+    object_property_set_bool(OBJECT(s->h3), true, "realized", &err);
+    if (err != NULL) {
+        error_reportf_err(err, "Couldn't realize Allwinner H3: ");
+        exit(1);
+    }
+
+    /* RAM */
+    memory_region_allocate_system_memory(&s->sdram, NULL, "orangepi.ram",
+                                         machine->ram_size);
+    memory_region_add_subregion(get_system_memory(), AW_H3_SDRAM_BASE,
+                                &s->sdram);
+
+    /* Load target kernel */
+    orangepi_binfo.ram_size = machine->ram_size;
+    orangepi_binfo.nb_cpus  = AW_H3_NUM_CPUS;
+    arm_load_kernel(ARM_CPU(first_cpu), machine, &orangepi_binfo);
+}
+
+static void orangepi_machine_init(MachineClass *mc)
+{
+    mc->desc = "Orange Pi PC";
+    mc->init = orangepi_init;
+    mc->units_per_default_bus = 1;
+    mc->min_cpus = AW_H3_NUM_CPUS;
+    mc->max_cpus = AW_H3_NUM_CPUS;
+    mc->default_cpus = AW_H3_NUM_CPUS;
+    mc->ignore_memory_transaction_failures = true;
+}
+
+DEFINE_MACHINE("orangepi", orangepi_machine_init)
-- 
2.17.1



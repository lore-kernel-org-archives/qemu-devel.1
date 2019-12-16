Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCB75C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 23:37:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5B9C20CC7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 23:37:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GjXqTY/i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5B9C20CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igzva-0008As-BG
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 18:37:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50162)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1igzuD-0006aD-Ae
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 18:36:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1igzuB-0002cs-P5
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 18:36:01 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:40621)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1igzuB-0002bL-Iq; Mon, 16 Dec 2019 18:35:59 -0500
Received: by mail-wm1-x341.google.com with SMTP id t14so1089529wmi.5;
 Mon, 16 Dec 2019 15:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=56k1gd9w0pzweQ0pdSRVAAe2bI3hcno8MwlnwkRM6ZM=;
 b=GjXqTY/ih7teLgDrI7tdcAfP6FdrS/tg4tyIQlG+Va8lA0ejPhApBtoeU7Gn17L/DB
 UAMECp1O8NZ4JyWBXK7AA6ucMHnLQLyLgJHnXICECNzNefL55Ix1u/hfhYxubxrNVRbs
 OBzczXp1m697AplJg7C9lcmCWEuwgVMxtE9BYVdHO5nIrDjn+6LwCBZ5o0mPQAP5nnJy
 eEd0ozY8kCoY4xrSbc1EFgR7+9RMpcChZZ5e5Nf5PdbapjP0b5OAHvSlPCT5Rsv20hmF
 CQveeZsttOomZ2miOnTGp6io2+ne51SNSp0MIdn6NaqztQWnRA2QnP12n4czglYhhGaA
 hV+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=56k1gd9w0pzweQ0pdSRVAAe2bI3hcno8MwlnwkRM6ZM=;
 b=QvEuTV494i6AZdQC9PFKHENb+gotnQEpBxncHNpXXQbdn99Q/9GBOHiPmzrDXZ6j9l
 17reOF3ps3ldrxgeXDwlh8g2M/CkFduZvE1aGSun8E8MzWhneNuCE3dDY64e04gW2RQR
 oxduiPkvlAiyD1kk4fBQRwYffK/LF6hnUzk/NfBazQKmdwISSzIe9cYgMknBJD9UcgNJ
 OziW/RuHekQ7X/2OaTneEUDV3vwjmQZM0xwM+MQlNWf5fO0fuw5RBjV45x0+3udf1lqC
 hwvxQORjkBtQ7i9PYyn7HN+oKxXAKG+WACB+95sYMzt9mbUeUDtYYgOq2dCwrcjzgeT1
 jqrw==
X-Gm-Message-State: APjAAAXxMv1JhxBWVRBuXW51QrSFjwmDc2Tq+RhC9O4tvQ3mDZ315g9M
 dKWOZg2LTK1bMZdCczl09nVm+k2u
X-Google-Smtp-Source: APXvYqxHJsDUECQUP0Q50PY96e8rOKZaO8x7NBoR98Xby9ML67U+rg2/PncZ+/L4+lLM0glmJzXfvA==
X-Received: by 2002:a7b:c114:: with SMTP id w20mr1660722wmi.151.1576539358199; 
 Mon, 16 Dec 2019 15:35:58 -0800 (PST)
Received: from pavilion.home ([2a02:a456:6be8:1:8edc:d4ff:fe8b:18b7])
 by smtp.gmail.com with ESMTPSA id z83sm984501wmg.2.2019.12.16.15.35.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2019 15:35:57 -0800 (PST)
From: Niek Linnenbank <nieklinnenbank@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 02/10] hw: arm: add Xunlong Orange Pi PC machine
Date: Tue, 17 Dec 2019 00:35:11 +0100
Message-Id: <20191216233519.29030-3-nieklinnenbank@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191216233519.29030-1-nieklinnenbank@gmail.com>
References: <20191216233519.29030-1-nieklinnenbank@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: peter.maydell@linaro.org, Niek Linnenbank <nieklinnenbank@gmail.com>,
 qemu-arm@nongnu.org, philmd@redhat.com
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
Tested-by: KONRAD Frederic <frederic.konrad@adacore.com>
---
 hw/arm/orangepi.c    | 101 +++++++++++++++++++++++++++++++++++++++++++
 MAINTAINERS          |   1 +
 hw/arm/Makefile.objs |   2 +-
 3 files changed, 103 insertions(+), 1 deletion(-)
 create mode 100644 hw/arm/orangepi.c

diff --git a/hw/arm/orangepi.c b/hw/arm/orangepi.c
new file mode 100644
index 0000000000..62cefc8c06
--- /dev/null
+++ b/hw/arm/orangepi.c
@@ -0,0 +1,101 @@
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
+
+    /* Only allow Cortex-A7 for this board */
+    if (strcmp(machine->cpu_type, ARM_CPU_TYPE_NAME("cortex-a7")) != 0) {
+        error_report("This board can only be used with cortex-a7 CPU");
+        exit(1);
+    }
+
+    s->h3 = AW_H3(object_new(TYPE_AW_H3));
+
+    /* Setup timer properties */
+    object_property_set_int(OBJECT(&s->h3->timer), 32768, "clk0-freq",
+                            &error_abort);
+    if (error_abort != NULL) {
+        error_reportf_err(error_abort, "Couldn't set clk0 frequency: ");
+        exit(1);
+    }
+
+    object_property_set_int(OBJECT(&s->h3->timer), 24000000, "clk1-freq",
+                            &error_abort);
+    if (error_abort != NULL) {
+        error_reportf_err(error_abort, "Couldn't set clk1 frequency: ");
+        exit(1);
+    }
+
+    /* Mark H3 object realized */
+    object_property_set_bool(OBJECT(s->h3), true, "realized", &error_abort);
+    if (error_abort != NULL) {
+        error_reportf_err(error_abort, "Couldn't realize Allwinner H3: ");
+        exit(1);
+    }
+
+    /* RAM */
+    if (machine->ram_size > 1 * GiB) {
+        error_report("Requested ram size is too large for this machine: "
+                     "maximum is 1GB");
+        exit(1);
+    }
+    memory_region_allocate_system_memory(&s->sdram, NULL, "orangepi.ram",
+                                         machine->ram_size);
+    memory_region_add_subregion(get_system_memory(), s->h3->memmap[AW_H3_SDRAM],
+                                &s->sdram);
+
+    /* Load target kernel */
+    orangepi_binfo.loader_start = s->h3->memmap[AW_H3_SDRAM];
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
+    mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a7");
+}
+
+DEFINE_MACHINE("orangepi-pc", orangepi_machine_init)
diff --git a/MAINTAINERS b/MAINTAINERS
index aae1a049b4..db682e49ca 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -486,6 +486,7 @@ L: qemu-arm@nongnu.org
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
-- 
2.17.1



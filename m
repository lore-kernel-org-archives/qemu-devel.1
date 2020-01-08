Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EDF6C282DD
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 20:03:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 072BE20705
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 20:03:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OiIhZB3M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 072BE20705
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipHXz-0003Oe-6K
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 15:03:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35315)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1ipHVR-0001Hd-AC
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 15:00:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1ipHVP-0002UC-Dh
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 15:00:41 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:38821)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1ipHVP-0002TA-6s; Wed, 08 Jan 2020 15:00:39 -0500
Received: by mail-wr1-x444.google.com with SMTP id y17so4776445wrh.5;
 Wed, 08 Jan 2020 12:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=wEwUmWS5JaObqwEn2QUlic12SeuUFGYPKWTbzt7a8is=;
 b=OiIhZB3M1LbJHhT/QCM5LtlbgsyrknA5Pin/taANT3QVc1Mc3udbaZNtUOKIBxC2M9
 3DOrt6vwyUPlo0RmvqRY75cw+BG1yFhUAMP3SHHwI2CrGKFrxrdsIesCPCP3oLyG6i6m
 O/By4itoVpP8uFyZkDy5avi0q1/P+CiOS3YpNkqxTdsYpJn21SEaqvXDk86aijwibxl7
 6gV5ZY0AnOjet3P7G/Urs/ta+1sQmgx3rjukB5q03o9GO4JBx5GQd5aKExf8V982HsdH
 NDYp3FG9wX1BXChZs3HgU0EJwxWMD5AmktScBhaFuod5yGmuStcnil1gdb0zYk1Dq4kN
 WGzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=wEwUmWS5JaObqwEn2QUlic12SeuUFGYPKWTbzt7a8is=;
 b=AaBUaPn7d5Q9le9MNjZywSqXT7QUJkQVV/0F6XDduU7k3uUZrN2k4FQsxRV1Ngv6EG
 VVQ2T2xyhf1MWyToqXGDtxFkpo2OWdjg1Z3Hsashc6JA+DIp5/RcIxSIC6g2BXHi5NTx
 IkNosMk1aoAPrRo8ot4ahrG38RfLWULDkAf2pOSGAG9R44xJfO2f93UJEaT8pODiH3Uc
 38HvsUCOaUXlrJ2W3pPfuTsJTo82HlJZedAMV4sxqfOq6Qm/E4TsNcD2jPVH87LL/cx1
 fpN8/TYnF6iQB576lMs0qMinGSV2vFR0sHN3IMmFtZ88idpwbhYCCLXN6sApYEIQQgpn
 QPkw==
X-Gm-Message-State: APjAAAVzIim1J+usw2ePzGXTTAhiEB3L4k3NhcTtD+oS9xIEjJROId0b
 oIOA/5MvLXMLHu9lwdlgkhP96DME
X-Google-Smtp-Source: APXvYqxw6yrRvj1Tep0WUKQPa1bmsBlWr9lBui0EcGpSwHn0ALHrKaGfJzdOycoezSINfH6yIZn8Gw==
X-Received: by 2002:adf:e2cf:: with SMTP id d15mr6501600wrj.225.1578513636924; 
 Wed, 08 Jan 2020 12:00:36 -0800 (PST)
Received: from pavilion.home ([2a02:a456:6be8:1:8edc:d4ff:fe8b:18b7])
 by smtp.gmail.com with ESMTPSA id u18sm4970099wrt.26.2020.01.08.12.00.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2020 12:00:36 -0800 (PST)
From: Niek Linnenbank <nieklinnenbank@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 02/17] hw/arm: add Xunlong Orange Pi PC machine
Date: Wed,  8 Jan 2020 21:00:05 +0100
Message-Id: <20200108200020.4745-3-nieklinnenbank@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200108200020.4745-1-nieklinnenbank@gmail.com>
References: <20200108200020.4745-1-nieklinnenbank@gmail.com>
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
 hw/arm/orangepi.c    | 93 ++++++++++++++++++++++++++++++++++++++++++++
 MAINTAINERS          |  1 +
 hw/arm/Makefile.objs |  2 +-
 3 files changed, 95 insertions(+), 1 deletion(-)
 create mode 100644 hw/arm/orangepi.c

diff --git a/hw/arm/orangepi.c b/hw/arm/orangepi.c
new file mode 100644
index 0000000000..051184f14f
--- /dev/null
+++ b/hw/arm/orangepi.c
@@ -0,0 +1,93 @@
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
+#include "sysemu/sysemu.h"
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
+    object_property_set_int(OBJECT(s->h3), 32768, "clk0-freq",
+                            &error_abort);
+    object_property_set_int(OBJECT(s->h3), 24000000, "clk1-freq",
+                            &error_abort);
+
+    /* Mark H3 object realized */
+    object_property_set_bool(OBJECT(s->h3), true, "realized", &error_abort);
+
+    /* SDRAM */
+    if (machine->ram_size != 1 * GiB) {
+        error_report("Requested ram size is not supported for this machine: "
+                     "restricted to 1GiB");
+        exit(1);
+    }
+    memory_region_allocate_system_memory(&s->sdram, NULL, "sdram",
+                                         machine->ram_size);
+    memory_region_add_subregion(get_system_memory(), s->h3->memmap[AW_H3_SDRAM],
+                                &s->sdram);
+
+    /* Load target kernel or start using BootROM */
+    if (bios_name) {
+        error_report("BIOS not supported for this machine");
+        exit(1);
+    }
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
+    mc->min_cpus = AW_H3_NUM_CPUS;
+    mc->max_cpus = AW_H3_NUM_CPUS;
+    mc->default_cpus = AW_H3_NUM_CPUS;
+    mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a7");
+    mc->default_ram_size = 1 * GiB;
+}
+
+DEFINE_MACHINE("orangepi-pc", orangepi_machine_init)
diff --git a/MAINTAINERS b/MAINTAINERS
index dc2d7991bf..6e1b92b5fa 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -487,6 +487,7 @@ L: qemu-arm@nongnu.org
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



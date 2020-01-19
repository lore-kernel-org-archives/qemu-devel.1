Return-Path: <SRS0=UCRd=3I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35177C32771
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2020 00:55:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED4EE2467C
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2020 00:55:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tpYhXtGS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED4EE2467C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isysH-00047j-8n
	for qemu-devel@archiver.kernel.org; Sat, 18 Jan 2020 19:55:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46838)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1isyoD-0006v3-4W
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 19:51:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1isyo9-0008Iv-4S
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 19:51:21 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:39292)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1isyo8-0008IV-UO; Sat, 18 Jan 2020 19:51:17 -0500
Received: by mail-wm1-x344.google.com with SMTP id 20so11193925wmj.4;
 Sat, 18 Jan 2020 16:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ZOrlrdoaDbbU1sYz+9Op9dsE9K8ocbeL+jVWJxJU1ss=;
 b=tpYhXtGS9gwPjUhkDBuAkK/tH4hzvFgjkYv8j2IPR8LD+/TfjJbMfrkNCIeBdsC7m6
 +Te/6Ivg/tawSSCaHy36X9McxQImAe6h4KVmoWcMtDX+irM6hwMg3JEmD7gJKAEcS7/4
 WZQu2MuABXdK8V7PPy33EU6o9V1hVdQlaL1XGcOwVBSpb5lxC8B65XN5sD++2lCnATRD
 RPZQjQpHjwsV/0QiKWbQJJmJwATk5HhUvnHURQf27n6ejBbsDi1TjwMyxKIEG18bmLz+
 e59nvlvzDynTbsI9Ifg2FcETJd02EPR5apHt0ZEvxTrlFpV4vLL2nEyb2XsX2u9PoDh2
 aLRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZOrlrdoaDbbU1sYz+9Op9dsE9K8ocbeL+jVWJxJU1ss=;
 b=ZSIiA8XklB+8yDHMs7x4s79FEeZESk0nxoGFjhe/X38mmJv/AhNffo288y86UQZMc2
 +fLP5oc20VyJbV6MeSK9qcQKDD39qsNS3j+Q7UElM+JP9nUP4iCYezATH/qhHPQdSlyD
 tSWJtEpUsBhkl2vVwXNnatMWSxsK+s/K61aQNeVgJypVQ/j2SK55UMwr6Wx1uV7CQu84
 i+weHtRz3UjPGzyz4lQ8gk90cAAwAbbLN3SyDFRQSatg1TuteaPKAtMGzePaLwAPddwx
 qfRqWifVoWraFp4nUX3OO5f8aDlkV9BdwwJm9ofDlLFu73ySXipqNUccbOehdLsQhuwv
 rMjQ==
X-Gm-Message-State: APjAAAUVq1ogFX8rx++spUfKjdGhNP6viJYt7Bv2ovsKdA6ZduM6AB7M
 L3j9vwXfqUCdOzAFT7VorjPPY4gwalA=
X-Google-Smtp-Source: APXvYqxs8RPI8G/F9XXQtrUSAT9u4Qm2PH2jgjzitPtv9f6omWQfMfan1GhkcuhSefhuiH6pFGmVeA==
X-Received: by 2002:a05:600c:146:: with SMTP id
 w6mr12417524wmm.180.1579395075759; 
 Sat, 18 Jan 2020 16:51:15 -0800 (PST)
Received: from pavilion.home ([2a02:a456:6be8:1:8edc:d4ff:fe8b:18b7])
 by smtp.gmail.com with ESMTPSA id h2sm41763568wrv.66.2020.01.18.16.51.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Jan 2020 16:51:15 -0800 (PST)
From: Niek Linnenbank <nieklinnenbank@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 02/20] hw/arm: add Xunlong Orange Pi PC machine
Date: Sun, 19 Jan 2020 01:50:44 +0100
Message-Id: <20200119005102.3847-3-nieklinnenbank@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200119005102.3847-1-nieklinnenbank@gmail.com>
References: <20200119005102.3847-1-nieklinnenbank@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org, jasowang@redhat.com,
 b.galvani@gmail.com, Niek Linnenbank <nieklinnenbank@gmail.com>,
 qemu-arm@nongnu.org, imammedo@redhat.com, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The Xunlong Orange Pi PC is an Allwinner H3 System on Chip
based embedded computer with mainline support in both U-Boot
and Linux. The board comes with a Quad Core Cortex A7 @ 1.3GHz,
1GiB RAM, 100Mbit ethernet, USB, SD/MMC, USB, HDMI and
various other I/O. This commit add support for the Xunlong
Orange Pi PC machine.

Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>
Tested-by: KONRAD Frederic <frederic.konrad@adacore.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/arm/orangepi.c    | 93 ++++++++++++++++++++++++++++++++++++++++++++
 MAINTAINERS          |  1 +
 hw/arm/Makefile.objs |  2 +-
 3 files changed, 95 insertions(+), 1 deletion(-)
 create mode 100644 hw/arm/orangepi.c

diff --git a/hw/arm/orangepi.c b/hw/arm/orangepi.c
new file mode 100644
index 0000000000..866f5f7cd6
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
+#include "qemu/units.h"
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
+    .nb_cpus = AW_H3_NUM_CPUS,
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
+    /* BIOS is not supported by this board */
+    if (bios_name) {
+        error_report("BIOS not supported for this machine");
+        exit(1);
+    }
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
+    object_property_set_int(OBJECT(s->h3), 24 * 1000 * 1000, "clk1-freq",
+                            &error_abort);
+
+    /* Mark H3 object realized */
+    object_property_set_bool(OBJECT(s->h3), true, "realized", &error_abort);
+
+    /* SDRAM */
+    if (machine->ram_size != 1 * GiB) {
+        error_report("This machine can only be used with 1GiB of RAM");
+        exit(1);
+    }
+    memory_region_allocate_system_memory(&s->sdram, NULL, "sdram",
+                                         machine->ram_size);
+    memory_region_add_subregion(get_system_memory(), s->h3->memmap[AW_H3_SDRAM],
+                                &s->sdram);
+
+    orangepi_binfo.loader_start = s->h3->memmap[AW_H3_SDRAM];
+    orangepi_binfo.ram_size = machine->ram_size;
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
index 225582704d..e99797eec9 100644
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
index ae577e875f..534a6a119e 100644
--- a/hw/arm/Makefile.objs
+++ b/hw/arm/Makefile.objs
@@ -35,7 +35,7 @@ obj-$(CONFIG_DIGIC) += digic.o
 obj-$(CONFIG_OMAP) += omap1.o omap2.o
 obj-$(CONFIG_STRONGARM) += strongarm.o
 obj-$(CONFIG_ALLWINNER_A10) += allwinner-a10.o cubieboard.o
-obj-$(CONFIG_ALLWINNER_H3) += allwinner-h3.o
+obj-$(CONFIG_ALLWINNER_H3) += allwinner-h3.o orangepi.o
 obj-$(CONFIG_RASPI) += bcm2835_peripherals.o bcm2836.o raspi.o
 obj-$(CONFIG_STM32F205_SOC) += stm32f205_soc.o
 obj-$(CONFIG_STM32F405_SOC) += stm32f405_soc.o
-- 
2.17.1



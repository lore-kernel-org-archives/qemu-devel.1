Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40284C10DCE
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 21:34:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D189208C3
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 21:34:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QLLXvMMD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D189208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBmVo-0003cJ-59
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 17:34:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53224)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1jBmU5-0000ZF-9a
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 17:32:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1jBmU3-000854-Ja
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 17:32:17 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:33281)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1jBmU3-00083S-CM; Tue, 10 Mar 2020 17:32:15 -0400
Received: by mail-wm1-x344.google.com with SMTP id r7so1711947wmg.0;
 Tue, 10 Mar 2020 14:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=EYESvQKR6+bdGUWiimfuvI4qx8oJxk2o+hyf6M3zJvM=;
 b=QLLXvMMD9ZiaYOCZw9vOGfemp9xz2KRtV2+xNtHhi+ftfLxo280uegwUcKnHY235rU
 Du5gGGv+Z8dovAWLAIQfEF3VeIwfcPxsxZ8rPVsDM5Ef15+VZHYFgKgPMd1M003RzNkH
 uDjO1SFF2tKeeWRzMAwN4q8MQQg4+gIg1r7T73bqqKsgnvNK39PjwKAvD+zxOK4YkNAk
 IEdhDYaoi0IbR/WvP7j0F3lc8X8Lwp8qtgZ28IqBu3YLTBbiRo+AT4gtItozqEjuM/PL
 5rU9JYkQZKlqupAQ1xkkzU8CBEIoL3syAU8eMtBuJ5H39dHovvHdIRpZKMadOnBdfp2E
 blvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=EYESvQKR6+bdGUWiimfuvI4qx8oJxk2o+hyf6M3zJvM=;
 b=K9Ftb8hsBqrDPGyn4RaijKgQkLwoje5P6gwjyoMSYXV3G0wP87aM5h7CSLEP0EfvFy
 Hd0IIC33SKhRLU2HxKKqNG0ViLageDAdGeEDsYCZYWRASBcGC+hcPV/W7QKzfIzALSfl
 SHvTARexXAN8ipPC7DP5Osu0SVvPR6DH7jPZqz0AGo9jkZ7XVCgP143UamRGX5Ixpj65
 uFEY6SdkypY5Q8t3dSOSPrqGJbkcLhRGa7fBc7xe6gTwpzyTHO/Tmnrs8dwh6V169Isj
 bk4SyYNIJiO08R9FrQlW5GlgB9KHcU2xD2k+1cQfeE/uC8tkhda6rfKQ84Mue6xzbbaC
 qtHA==
X-Gm-Message-State: ANhLgQ3H37g+iWSH+EJar7fiBPxAh/HEGBgcsVvxXDNxHje4lRk0q9kz
 LIEIbvLnK03G7RJIqLxZlt2D5CNF
X-Google-Smtp-Source: ADFU+vuT3Dps0gHbKVrW/uVauAJEfYJBBdxXfmi2SMIFoqMPp4owEULQe74dlJsie5MucYJKe2WjHw==
X-Received: by 2002:a1c:4054:: with SMTP id n81mr3822827wma.114.1583875932855; 
 Tue, 10 Mar 2020 14:32:12 -0700 (PDT)
Received: from pavilion.home ([2a02:a456:6be8:1:8edc:d4ff:fe8b:18b7])
 by smtp.gmail.com with ESMTPSA id 2sm32803580wrf.79.2020.03.10.14.32.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2020 14:32:12 -0700 (PDT)
From: Niek Linnenbank <nieklinnenbank@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 02/18] hw/arm: add Xunlong Orange Pi PC machine
Date: Tue, 10 Mar 2020 22:31:47 +0100
Message-Id: <20200310213203.18730-3-nieklinnenbank@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200310213203.18730-1-nieklinnenbank@gmail.com>
References: <20200310213203.18730-1-nieklinnenbank@gmail.com>
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
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Acked-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/arm/orangepi.c    | 92 ++++++++++++++++++++++++++++++++++++++++++++
 MAINTAINERS          |  1 +
 hw/arm/Makefile.objs |  2 +-
 3 files changed, 94 insertions(+), 1 deletion(-)
 create mode 100644 hw/arm/orangepi.c

diff --git a/hw/arm/orangepi.c b/hw/arm/orangepi.c
new file mode 100644
index 0000000000..3fcec1944e
--- /dev/null
+++ b/hw/arm/orangepi.c
@@ -0,0 +1,92 @@
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
+static void orangepi_init(MachineState *machine)
+{
+    AwH3State *h3;
+
+    /* BIOS is not supported by this board */
+    if (bios_name) {
+        error_report("BIOS not supported for this machine");
+        exit(1);
+    }
+
+    /* This board has fixed size RAM */
+    if (machine->ram_size != 1 * GiB) {
+        error_report("This machine can only be used with 1GiB of RAM");
+        exit(1);
+    }
+
+    /* Only allow Cortex-A7 for this board */
+    if (strcmp(machine->cpu_type, ARM_CPU_TYPE_NAME("cortex-a7")) != 0) {
+        error_report("This board can only be used with cortex-a7 CPU");
+        exit(1);
+    }
+
+    h3 = AW_H3(object_new(TYPE_AW_H3));
+    object_property_add_child(OBJECT(machine), "soc", OBJECT(h3),
+                              &error_abort);
+    object_unref(OBJECT(h3));
+
+    /* Setup timer properties */
+    object_property_set_int(OBJECT(h3), 32768, "clk0-freq",
+                            &error_abort);
+    object_property_set_int(OBJECT(h3), 24 * 1000 * 1000, "clk1-freq",
+                            &error_abort);
+
+    /* Mark H3 object realized */
+    object_property_set_bool(OBJECT(h3), true, "realized", &error_abort);
+
+    /* SDRAM */
+    memory_region_add_subregion(get_system_memory(), h3->memmap[AW_H3_SDRAM],
+                                machine->ram);
+
+    orangepi_binfo.loader_start = h3->memmap[AW_H3_SDRAM];
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
+    mc->default_ram_id = "orangepi.ram";
+}
+
+DEFINE_MACHINE("orangepi-pc", orangepi_machine_init)
diff --git a/MAINTAINERS b/MAINTAINERS
index 4730fe2b95..53040ceab3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -497,6 +497,7 @@ L: qemu-arm@nongnu.org
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



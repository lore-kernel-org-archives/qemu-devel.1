Return-Path: <SRS0=x6Qc=45=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 639F4C1975A
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 16:50:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DAE9206F1
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2020 16:50:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NV1HsJGV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DAE9206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCR2Z-0002x5-9G
	for qemu-devel@archiver.kernel.org; Thu, 12 Mar 2020 12:50:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35676)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jCQxU-0008SX-6c
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:45:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jCQxS-00058h-KM
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:45:20 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:34662)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jCQxS-00058M-Ch
 for qemu-devel@nongnu.org; Thu, 12 Mar 2020 12:45:18 -0400
Received: by mail-wr1-x435.google.com with SMTP id z15so8381451wrl.1
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2020 09:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=Cf67v8iVsz5NRtg3LDjbFwVL498OUf7DASE7uAfE+tc=;
 b=NV1HsJGVCAE1YYBz2pr9M3laJAvNxmT5WCPkDfueCz4YoDLvVqunp3dgRH4bgdaGXL
 svrRSTm6dOh9CMRFnVenxd6tUwDCyVeYjGEnhmQ8iFdlKarYYFE2Gkf1J54APuRnXx26
 o1zEGZ609MaiphRRtapn2+BrkQK3dS4+EOaheNELsz3ho+IxHfyUf72nNfaFO0bk958Z
 FZmK/HzBzlsHPbl+VJUy6eTgKVBpGMEpm7oH7pk1ne4ZFB7JqUqcEJGXDps68yq2DXV5
 L8sKn1fvU9BQkvmO0CzHcDU/D+oKTVg5Cr8eg1IbHxjGiK89GwJt+DVZmcNAMULhqmlM
 h2iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Cf67v8iVsz5NRtg3LDjbFwVL498OUf7DASE7uAfE+tc=;
 b=S6ZATKhOUtwpwKv9Zori6r/3qxD1ve9RXBWA8/wIJRKQZfvuZpl0t+k36ofYhAaEDQ
 Jhpj7GWO2CWC+tYGJkxzPSgnBP/8Bmuwbu/QlufOs135g5HyLI44Cl1DNrXEHf8SiVju
 6bCn+Vs1eWWabBnN555m8Xv/yXsl1FZoPeytUKmJP+p6Hzb2h8ZNAoCI/lSIxTycrpXt
 gJsovgUt5yYTKrIifvgpwCOnSQnUQORTL6WAHUo3W4/1iMWWoseUiFURbo6T5LCOHnum
 NNG9Mw3Tyv4GyWQoXYwxAqR7GRonhv0tes+XYqN2m8Jf0XV7TmgO2/OSmk3Rr1y6DNK+
 L5Eg==
X-Gm-Message-State: ANhLgQ0mqRFjMeO8OjDr/XxDUFAXuYq93bOxiEnCFcTGzCpbSIpZaHcM
 wwUi0kf+CQ0AGu7KnpuyAghCU1NofoNvQQ==
X-Google-Smtp-Source: ADFU+vv6jVu35zgMSjnG5HnvxDAu2t2NnB4H2uJiJvmN8yGv/37pY9PVwWsAgbhaREzGkNxhdXfAhw==
X-Received: by 2002:a5d:6a0e:: with SMTP id m14mr12079819wru.202.1584031517072; 
 Thu, 12 Mar 2020 09:45:17 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id j15sm36838640wrp.85.2020.03.12.09.45.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2020 09:45:16 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/36] hw/arm: add Xunlong Orange Pi PC machine
Date: Thu, 12 Mar 2020 16:44:36 +0000
Message-Id: <20200312164459.25924-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200312164459.25924-1-peter.maydell@linaro.org>
References: <20200312164459.25924-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::435
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

From: Niek Linnenbank <nieklinnenbank@gmail.com>

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
Message-id: 20200311221854.30370-3-nieklinnenbank@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/Makefile.objs |  2 +-
 hw/arm/orangepi.c    | 92 ++++++++++++++++++++++++++++++++++++++++++++
 MAINTAINERS          |  1 +
 3 files changed, 94 insertions(+), 1 deletion(-)
 create mode 100644 hw/arm/orangepi.c

diff --git a/hw/arm/Makefile.objs b/hw/arm/Makefile.objs
index ae577e875fd..534a6a119e5 100644
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
diff --git a/hw/arm/orangepi.c b/hw/arm/orangepi.c
new file mode 100644
index 00000000000..3fcec1944e8
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
index 3efa8e53ec8..d7a26d7171e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -498,6 +498,7 @@ L: qemu-arm@nongnu.org
 S: Maintained
 F: hw/*/allwinner-h3*
 F: include/hw/*/allwinner-h3*
+F: hw/arm/orangepi.c
 
 ARM PrimeCell and CMSDK devices
 M: Peter Maydell <peter.maydell@linaro.org>
-- 
2.20.1



Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D978C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 20:40:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D55620748
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 20:40:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CiKLOUH5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D55620748
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbrzQ-0008DZ-BF
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 16:40:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38768)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <349TGXgsKCqQLWOMRRIQSIRKSSKPI.GSQUIQY-HIZIPRSRKRY.SVK@flex--hskinnemoen.bounces.google.com>)
 id 1jbqlj-00065U-6B
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:22:15 -0400
Received: from mail-yb1-xb49.google.com ([2607:f8b0:4864:20::b49]:37544)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <349TGXgsKCqQLWOMRRIQSIRKSSKPI.GSQUIQY-HIZIPRSRKRY.SVK@flex--hskinnemoen.bounces.google.com>)
 id 1jbqlh-0001kn-8o
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:22:14 -0400
Received: by mail-yb1-xb49.google.com with SMTP id k15so6562433ybt.4
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 12:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=xMGRhvcpHFv1QAcVJfZqU8UBbv51GbImWdKk3rmPosU=;
 b=CiKLOUH5OW6Fv2kdOUkNZtvpH8DJMhkdVBnjOC9cQOi2Xo5rl0xFmeSJDt8BF8AlU2
 kfqAswGf1B5bsZf9xuRmQ7qQqNn6kYj3gbglg20iMBJXfPaM9TYj41sKRMRGHx6XLWEn
 xwtX5k28N87zJoNEX3TBqONPCFeCkeKbVi6AzFxzUL7MfX09mXM2N0aiCCS2ti2Bu77g
 Ctk238cD4fobl4QRNZGb0qXTBmkkHxMRsBN4mh56Rmrllz7qpg/AkIRZPUlifio9QRKl
 PAvVMjj32VidsdimISCjNfXnKaJilnedc0S/8XnrRHHQwinuGTngPqtTkNAxcu80mTLM
 tLwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=xMGRhvcpHFv1QAcVJfZqU8UBbv51GbImWdKk3rmPosU=;
 b=n8W0jQC9mxlbSMAIu76O4zihLbiHvi/FIIDwTHwy4h9Shx2ioaCQELFyrWu/0JeYVn
 khUYliwSq1DEzPrmJJnF69XYXMfQh7I3DmSknW71IFyX0z6MsLRmEV+rRgjJ7T5QK8zw
 lLYVdgC5cvbpXECrkgbBo3FJWoj9TMTm8aAWN/j1IeRvxHNeTVsXD0X/00WSsIxLOjHM
 C6eBt8khB0P6nO5yKsx2XUYEqDk3XtK01Kid+nzpXfffKHiNuPzduJ1TrAVTSzdRipi3
 Ss7hGqi4OqA0lYqbenl4jjSCzrbwYtiU9odtTjnlMuh3KFjsn4lcct2y37tZul4fIV6g
 PyZw==
X-Gm-Message-State: AOAM533b/k+hkPF2O8wQ45CpEW5jwbsOCSxRkZXvXeSJgU5owv8L48X/
 A6LBK/+9sxI3a2gqNItZ7ftkTIxd0P29vi0pGw==
X-Google-Smtp-Source: ABdhPJw28IAqGD3HABshoEGk5WtlFfEIadsMeTcW4jcjFjI/iXYDbqX9jt4KH+Icyi3AKwK8XQbslq2lREiUCVbwzw==
X-Received: by 2002:a25:cc55:: with SMTP id l82mr7384851ybf.313.1590088931249; 
 Thu, 21 May 2020 12:22:11 -0700 (PDT)
Date: Thu, 21 May 2020 12:21:33 -0700
In-Reply-To: <20200521192133.127559-1-hskinnemoen@google.com>
Message-Id: <20200521192133.127559-7-hskinnemoen@google.com>
Mime-Version: 1.0
References: <20200521192133.127559-1-hskinnemoen@google.com>
X-Mailer: git-send-email 2.27.0.rc0.183.gde8f92d652-goog
Subject: [PATCH 6/6] hw/arm: Add two NPCM7xx-based machines
From: Havard Skinnemoen <hskinnemoen@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Avi.Fishman@nuvoton.com, 
 kfting@nuvoton.com, Havard Skinnemoen <hskinnemoen@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b49;
 envelope-from=349TGXgsKCqQLWOMRRIQSIRKSSKPI.GSQUIQY-HIZIPRSRKRY.SVK@flex--hskinnemoen.bounces.google.com;
 helo=mail-yb1-xb49.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=_AUTOLEARN
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 21 May 2020 16:37:55 -0400
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

This adds two new machines:

  - npcm750-evb: Nuvoton NPCM750 Evaluation Board.
  - quanta-gsj: A board with a NPCM730 chip.

They rely on the NPCM7xx SoC device to do the heavy lifting. They are
almost completely identical at the moment, apart from the SoC type,
which currently only changes the reset contents of one register
(GCR.MDLR), but they might grow apart a bit more as more functionality
is added.

Both machines can boot the Linux kernel into /bin/sh.

Reviewed-by: Tyrone Ting <kfting@nuvoton.com>
Signed-off-by: Havard Skinnemoen <hskinnemoen@google.com>
---
 hw/arm/Makefile.objs     |   2 +-
 hw/arm/npcm7xx_boards.c  | 108 +++++++++++++++++++++++++++++++++++++++
 include/hw/arm/npcm7xx.h |  19 +++++++
 3 files changed, 128 insertions(+), 1 deletion(-)
 create mode 100644 hw/arm/npcm7xx_boards.c

diff --git a/hw/arm/Makefile.objs b/hw/arm/Makefile.objs
index 13d163a599..c333548ce1 100644
--- a/hw/arm/Makefile.objs
+++ b/hw/arm/Makefile.objs
@@ -41,7 +41,7 @@ obj-$(CONFIG_STM32F205_SOC) += stm32f205_soc.o
 obj-$(CONFIG_STM32F405_SOC) += stm32f405_soc.o
 obj-$(CONFIG_XLNX_ZYNQMP_ARM) += xlnx-zynqmp.o xlnx-zcu102.o
 obj-$(CONFIG_XLNX_VERSAL) += xlnx-versal.o xlnx-versal-virt.o
-obj-$(CONFIG_NPCM7XX) += npcm7xx.o
+obj-$(CONFIG_NPCM7XX) += npcm7xx.o npcm7xx_boards.o
 obj-$(CONFIG_FSL_IMX25) += fsl-imx25.o imx25_pdk.o
 obj-$(CONFIG_FSL_IMX31) += fsl-imx31.o kzm.o
 obj-$(CONFIG_FSL_IMX6) += fsl-imx6.o
diff --git a/hw/arm/npcm7xx_boards.c b/hw/arm/npcm7xx_boards.c
new file mode 100644
index 0000000000..b89819f6e2
--- /dev/null
+++ b/hw/arm/npcm7xx_boards.c
@@ -0,0 +1,108 @@
+/*
+ * Machine definitions for boards featuring an NPCM7xx SoC.
+ *
+ * Copyright 2020 Google LLC
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ */
+
+#include "qemu/osdep.h"
+
+#include "hw/arm/boot.h"
+#include "hw/arm/npcm7xx.h"
+#include "hw/core/cpu.h"
+#include "qapi/error.h"
+#include "qemu/units.h"
+
+static struct arm_boot_info npcm7xx_binfo = {
+    .loader_start       = NPCM7XX_LOADER_START,
+    .smp_loader_start   = NPCM7XX_SMP_LOADER_START,
+    .smp_bootreg_addr   = NPCM7XX_SMP_BOOTREG_ADDR,
+    .gic_cpu_if_addr    = NPCM7XX_GIC_CPU_IF_ADDR,
+    .write_secondary_boot = npcm7xx_write_secondary_boot,
+    .board_id           = -1,
+};
+
+static void npcm7xx_machine_init(MachineState *machine)
+{
+    NPCM7xxMachineClass *nmc = NPCM7XX_MACHINE_GET_CLASS(machine);
+    NPCM7xxState *soc;
+
+    soc = NPCM7XX(object_new_with_props(nmc->soc_type, OBJECT(machine), "soc",
+                                        &error_abort, NULL));
+    object_property_set_int(OBJECT(soc), machine->smp.cpus, "num-cpus",
+                            &error_abort);
+    object_property_set_link(OBJECT(soc), OBJECT(machine->ram), "dram",
+                             &error_abort);
+    object_property_set_bool(OBJECT(soc), true, "realized", &error_abort);
+
+    npcm7xx_binfo.ram_size = machine->ram_size;
+    npcm7xx_binfo.nb_cpus = machine->smp.cpus;
+
+    arm_load_kernel(soc->cpu[0], machine, &npcm7xx_binfo);
+}
+
+static void npcm7xx_machine_class_init(ObjectClass *oc, void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+
+    mc->init            = npcm7xx_machine_init;
+    mc->max_cpus        = NPCM7XX_MAX_NUM_CPUS;
+    mc->default_cpus    = NPCM7XX_MAX_NUM_CPUS;
+    mc->no_floppy       = 1;
+    mc->no_cdrom        = 1;
+    mc->no_parallel     = 1;
+    mc->default_ram_id  = "ram";
+}
+
+/*
+ * Schematics:
+ * https://github.com/Nuvoton-Israel/nuvoton-info/blob/master/npcm7xx-poleg/evaluation-board/board_deliverables/NPCM750x_EB_ver.A1.1_COMPLETE.pdf
+ */
+static void npcm750_evb_machine_class_init(ObjectClass *oc, void *data)
+{
+    NPCM7xxMachineClass *nmc = NPCM7XX_MACHINE_CLASS(oc);
+    MachineClass *mc = MACHINE_CLASS(oc);
+
+    mc->desc            = "Nuvoton NPCM750 Evaluation Board (Cortex A9)";
+    nmc->soc_type       = TYPE_NPCM750;
+    mc->default_ram_size = 512 * MiB;
+};
+
+static void gsj_machine_class_init(ObjectClass *oc, void *data)
+{
+    NPCM7xxMachineClass *nmc = NPCM7XX_MACHINE_CLASS(oc);
+    MachineClass *mc = MACHINE_CLASS(oc);
+
+    mc->desc            = "Quanta GSJ (Cortex A9)";
+    nmc->soc_type       = TYPE_NPCM730;
+    mc->default_ram_size = 512 * MiB;
+};
+
+static const TypeInfo npcm7xx_machine_types[] = {
+    {
+        .name           = TYPE_NPCM7XX_MACHINE,
+        .parent         = TYPE_MACHINE,
+        .instance_size  = sizeof(NPCM7xxMachine),
+        .class_size     = sizeof(NPCM7xxMachineClass),
+        .class_init     = npcm7xx_machine_class_init,
+        .abstract       = true,
+    }, {
+        .name           = MACHINE_TYPE_NAME("npcm750-evb"),
+        .parent         = TYPE_NPCM7XX_MACHINE,
+        .class_init     = npcm750_evb_machine_class_init,
+    }, {
+        .name           = MACHINE_TYPE_NAME("quanta-gsj"),
+        .parent         = TYPE_NPCM7XX_MACHINE,
+        .class_init     = gsj_machine_class_init,
+    },
+};
+
+DEFINE_TYPES(npcm7xx_machine_types)
diff --git a/include/hw/arm/npcm7xx.h b/include/hw/arm/npcm7xx.h
index 0a8798dd24..c1a108e89a 100644
--- a/include/hw/arm/npcm7xx.h
+++ b/include/hw/arm/npcm7xx.h
@@ -30,6 +30,25 @@
 #define NPCM7XX_SMP_BOOTREG_ADDR        (0xF080013C)  /* GCR.SCRPAD */
 #define NPCM7XX_GIC_CPU_IF_ADDR         (0xF03FE100)  /* GIC within A9 */
 
+typedef struct NPCM7xxMachine {
+    MachineState        parent;
+} NPCM7xxMachine;
+
+#define TYPE_NPCM7XX_MACHINE MACHINE_TYPE_NAME("npcm7xx")
+#define NPCM7XX_MACHINE(obj)                                            \
+    OBJECT_CHECK(NPCM7xxMachine, (obj), TYPE_NPCM7XX_MACHINE)
+
+typedef struct NPCM7xxMachineClass {
+    MachineClass        parent;
+
+    const char          *soc_type;
+} NPCM7xxMachineClass;
+
+#define NPCM7XX_MACHINE_CLASS(klass)                                    \
+    OBJECT_CLASS_CHECK(NPCM7xxMachineClass, (klass), TYPE_NPCM7XX_MACHINE)
+#define NPCM7XX_MACHINE_GET_CLASS(obj)                                  \
+    OBJECT_GET_CLASS(NPCM7xxMachineClass, (obj), TYPE_NPCM7XX_MACHINE)
+
 typedef struct NPCM7xxState {
     DeviceState         parent;
 
-- 
2.27.0.rc0.183.gde8f92d652-goog



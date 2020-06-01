Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3611AC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 16:24:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E51AC206C3
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 16:24:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r6Wf/8EY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E51AC206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfnEN-0008Mm-7E
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 12:24:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50952)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jfn5Y-0005Tl-Sx
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 12:15:00 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:38121)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jfn5X-0001XV-LL
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 12:15:00 -0400
Received: by mail-wm1-x344.google.com with SMTP id f185so91399wmf.3
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2020 09:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=RWdudFnYi0EUSMbnOj3UHoO35ptoSzGdI/tJkRX1nw8=;
 b=r6Wf/8EY9Luxf6B8WKIgqElxzWm5aqquJiEyKEaSAv4F6J03dWmjk98l8CrgK9gJ+p
 10+QmunAOVAISmZ9q+MNpk0TBUlbUVg9RFPKhcwyZP28ysIdwurtlFM9LD9kFv7Gdxv8
 PQa6W8R4yjfq6AjavM7o510tUoq/TL+C2J9FMO9ajx86+anPB/LFdkHmvWlaBdpDMkQq
 YVFkoC+MfiwPBIWj3Wt9h6yEVmPla3iAVYuhIZO9fC43ZYkhLfyFwCV9SjlJcG6mShdT
 bG2y7jUHp0CBguG9L5XIfbHCO4f320pyXtM09WhIJyqY3U2hLSYlxN3068K3RxJfIC9E
 dq1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=RWdudFnYi0EUSMbnOj3UHoO35ptoSzGdI/tJkRX1nw8=;
 b=PCa8/pmTCcO4K/yZL3pdehijRZPnG/XY6G+11I4Dn/lCXpAzP7wFPXwzWW3SMLCdEl
 JF9+zqfNyToB7avYxom1klFkEhVpzOTwhF/1Uhp1E++/qw+PAI+qBuEik6zvkBCsuR/s
 5xTG9ywMSZfj484AVJbqQYrF4SOSrkZmwwDxNwVcY6l5gnlF5eZoGLkGiZOcmEKvFOSj
 5ShD1xXJb8eqkZmXKZL9XHUEdq0fuspnukSZ03VBIZMnBXOfOKvPZufuXQDVoZICw8VO
 AX0e3tbh/WOWmsDM8aX1l+L1SNq5xEuz3KCXhCXW0VxvTbgGH1oyMY7H936aeZVIq4cb
 oYCQ==
X-Gm-Message-State: AOAM530tqhFQPrvc7q5fuT4lLeXwyPMdm7LfU9DpE1opgKBdX7nIrTSL
 iVMk62yZRIBASD6vuuJuvlI=
X-Google-Smtp-Source: ABdhPJx1QqnsgsSyopoZc9LyyuPHSK3VVOI2xr1cppW9cxXo+MIpNaVH4NRcHZqIz1wYEFBjsfhOBQ==
X-Received: by 2002:a1c:9d09:: with SMTP id g9mr84056wme.31.1591028098209;
 Mon, 01 Jun 2020 09:14:58 -0700 (PDT)
Received: from localhost.localdomain (43.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.43])
 by smtp.gmail.com with ESMTPSA id a6sm21309896wrn.38.2020.06.01.09.14.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 09:14:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org,
 Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PATCH 10/12] hw/rx: Add RX GDB simulator
Date: Mon,  1 Jun 2020 18:14:39 +0200
Message-Id: <20200601161441.8086-11-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200601161441.8086-1-f4bug@amsat.org>
References: <20200601161441.8086-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Yoshinori Sato <ysato@users.sourceforge.jp>

Add the RX machine internally simulated in GDB.

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
[PMD: Use TYPE_RX62N_CPU, use #define for RX62N_NR_TMR/CMT/SCI,
 renamed CPU -> MCU, device -> microcontroller]
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200224141923.82118-18-ysato@users.sourceforge.jp>
[PMD: Split of MCU, rename gdbsim, Add gdbsim-r5f562n7/r5f562n8]
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 default-configs/rx-softmmu.mak |   1 +
 include/hw/rx/rx62n.h          |   4 +
 hw/rx/rx-gdbsim.c              | 198 +++++++++++++++++++++++++++++++++
 hw/rx/Kconfig                  |   4 +
 hw/rx/Makefile.objs            |   1 +
 5 files changed, 208 insertions(+)
 create mode 100644 hw/rx/rx-gdbsim.c

diff --git a/default-configs/rx-softmmu.mak b/default-configs/rx-softmmu.mak
index 7c4eb2c1a0..df2b4e4f42 100644
--- a/default-configs/rx-softmmu.mak
+++ b/default-configs/rx-softmmu.mak
@@ -1,2 +1,3 @@
 # Default configuration for rx-softmmu
 
+CONFIG_RX_GDBSIM=y
diff --git a/include/hw/rx/rx62n.h b/include/hw/rx/rx62n.h
index 0421cd6d4d..121caedbe9 100644
--- a/include/hw/rx/rx62n.h
+++ b/include/hw/rx/rx62n.h
@@ -37,6 +37,10 @@
 #define TYPE_R5F562N7_MCU "r5f562n7-mcu"
 #define TYPE_R5F562N8_MCU "r5f562n8-mcu"
 
+#define EXT_CS_BASE         0x01000000
+#define VECTOR_TABLE_BASE   0xffffff80
+#define RX62N_CFLASH_BASE   0xfff80000
+
 #define RX62N_NR_TMR    2
 #define RX62N_NR_CMT    2
 #define RX62N_NR_SCI    6
diff --git a/hw/rx/rx-gdbsim.c b/hw/rx/rx-gdbsim.c
new file mode 100644
index 0000000000..01751790ed
--- /dev/null
+++ b/hw/rx/rx-gdbsim.c
@@ -0,0 +1,198 @@
+/*
+ * RX QEMU GDB simulator
+ *
+ * Copyright (c) 2019 Yoshinori Sato
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/error-report.h"
+#include "qapi/error.h"
+#include "qemu-common.h"
+#include "cpu.h"
+#include "hw/hw.h"
+#include "hw/sysbus.h"
+#include "hw/loader.h"
+#include "hw/rx/rx62n.h"
+#include "sysemu/sysemu.h"
+#include "sysemu/qtest.h"
+#include "sysemu/device_tree.h"
+#include "hw/boards.h"
+
+/* Same address of GDB integrated simulator */
+#define SDRAM_BASE  EXT_CS_BASE
+
+typedef struct RxGdbSimMachineClass {
+    /*< private >*/
+    MachineClass parent_class;
+    /*< public >*/
+    const char *mcu_name;
+    uint32_t xtal_freq_hz;
+} RxGdbSimMachineClass;
+
+typedef struct RxGdbSimMachineState {
+    /*< private >*/
+    MachineState parent_obj;
+    /*< public >*/
+    RX62NState mcu;
+} RxGdbSimMachineState;
+
+#define TYPE_RX_GDBSIM_MACHINE MACHINE_TYPE_NAME("rx62n-common")
+
+#define RX_GDBSIM_MACHINE(obj) \
+    OBJECT_CHECK(RxGdbSimMachineState, (obj), TYPE_RX_GDBSIM_MACHINE)
+
+#define RX_GDBSIM_MACHINE_CLASS(klass) \
+    OBJECT_CLASS_CHECK(RxGdbSimMachineClass, (klass), TYPE_RX_GDBSIM_MACHINE)
+#define RX_GDBSIM_MACHINE_GET_CLASS(obj) \
+    OBJECT_GET_CLASS(RxGdbSimMachineClass, (obj), TYPE_RX_GDBSIM_MACHINE)
+
+static void rx_load_image(RXCPU *cpu, const char *filename,
+                          uint32_t start, uint32_t size)
+{
+    static uint32_t extable[32];
+    long kernel_size;
+    int i;
+
+    kernel_size = load_image_targphys(filename, start, size);
+    if (kernel_size < 0) {
+        fprintf(stderr, "qemu: could not load kernel '%s'\n", filename);
+        exit(1);
+    }
+    cpu->env.pc = start;
+
+    /* setup exception trap trampoline */
+    /* linux kernel only works little-endian mode */
+    for (i = 0; i < ARRAY_SIZE(extable); i++) {
+        extable[i] = cpu_to_le32(0x10 + i * 4);
+    }
+    rom_add_blob_fixed("extable", extable, sizeof(extable), VECTOR_TABLE_BASE);
+}
+
+static void rx_gdbsim_init(MachineState *machine)
+{
+    MachineClass *mc = MACHINE_GET_CLASS(machine);
+    RxGdbSimMachineState *s = RX_GDBSIM_MACHINE(machine);
+    RxGdbSimMachineClass *rxc = RX_GDBSIM_MACHINE_GET_CLASS(machine);
+    MemoryRegion *sysmem = get_system_memory();
+    const char *kernel_filename = machine->kernel_filename;
+    const char *dtb_filename = machine->dtb;
+
+    if (machine->ram_size < mc->default_ram_size) {
+        error_report("Invalid RAM size, should be more than %" PRIi64 " Bytes",
+                     mc->default_ram_size);
+    }
+
+    /* Allocate memory space */
+    memory_region_add_subregion(sysmem, SDRAM_BASE, machine->ram);
+
+    /* Initialize MCU */
+    object_initialize_child(OBJECT(machine), "mcu", &s->mcu,
+                            sizeof(RX62NState), rxc->mcu_name,
+                            &error_fatal, NULL);
+    object_property_set_link(OBJECT(&s->mcu), OBJECT(sysmem),
+                             "main-bus", &error_abort);
+    object_property_set_uint(OBJECT(&s->mcu), rxc->xtal_freq_hz,
+                             "xtal-frequency-hz", &error_abort);
+    object_property_set_bool(OBJECT(&s->mcu), kernel_filename != NULL,
+                             "load-kernel", &error_abort);
+    object_property_set_bool(OBJECT(&s->mcu), true, "realized", &error_abort);
+
+    /* Load kernel and dtb */
+    if (kernel_filename) {
+        ram_addr_t kernel_offset;
+
+        /*
+         * The kernel image is loaded into
+         * the latter half of the SDRAM space.
+         */
+        kernel_offset = machine->ram_size / 2;
+        rx_load_image(RXCPU(first_cpu), kernel_filename,
+                      SDRAM_BASE + kernel_offset, kernel_offset);
+        if (dtb_filename) {
+            ram_addr_t dtb_offset;
+            int dtb_size;
+            void *dtb;
+
+            dtb = load_device_tree(dtb_filename, &dtb_size);
+            if (dtb == NULL) {
+                error_report("Couldn't open dtb file %s", dtb_filename);
+                exit(1);
+            }
+            if (machine->kernel_cmdline &&
+                qemu_fdt_setprop_string(dtb, "/chosen", "bootargs",
+                                        machine->kernel_cmdline) < 0) {
+                error_report("Couldn't set /chosen/bootargs");
+                exit(1);
+            }
+            /* DTB is located at the end of SDRAM space. */
+            dtb_offset = machine->ram_size - dtb_size;
+            rom_add_blob_fixed("dtb", dtb, dtb_size,
+                               SDRAM_BASE + dtb_offset);
+            /* Set dtb address to R1 */
+            RXCPU(first_cpu)->env.regs[1] = SDRAM_BASE + dtb_offset;
+        }
+    }
+}
+
+static void rx_gdbsim_class_init(ObjectClass *oc, void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+
+    mc->init = rx_gdbsim_init;
+    mc->default_cpu_type = TYPE_RX62N_CPU;
+    mc->default_ram_size = 16 * MiB;
+    mc->default_ram_id = "ext-sdram";
+}
+
+static void rx62n7_class_init(ObjectClass *oc, void *data)
+{
+    RxGdbSimMachineClass *rxc = RX_GDBSIM_MACHINE_CLASS(oc);
+    MachineClass *mc = MACHINE_CLASS(oc);
+
+    rxc->mcu_name = TYPE_R5F562N7_MCU;
+    rxc->xtal_freq_hz = 12 * 1000 * 1000;
+    mc->desc = "gdb simulator (R5F562N7 MCU and external RAM)";
+};
+
+static void rx62n8_class_init(ObjectClass *oc, void *data)
+{
+    RxGdbSimMachineClass *rxc = RX_GDBSIM_MACHINE_CLASS(oc);
+    MachineClass *mc = MACHINE_CLASS(oc);
+
+    rxc->mcu_name = TYPE_R5F562N8_MCU;
+    rxc->xtal_freq_hz = 12 * 1000 * 1000;
+    mc->desc = "gdb simulator (R5F562N8 MCU and external RAM)";
+};
+
+static const TypeInfo rx_gdbsim_types[] = {
+    {
+        .name           = MACHINE_TYPE_NAME("gdbsim-r5f562n7"),
+        .parent         = TYPE_RX_GDBSIM_MACHINE,
+        .class_init     = rx62n7_class_init,
+    }, {
+        .name           = MACHINE_TYPE_NAME("gdbsim-r5f562n8"),
+        .parent         = TYPE_RX_GDBSIM_MACHINE,
+        .class_init     = rx62n8_class_init,
+    }, {
+        .name           = TYPE_RX_GDBSIM_MACHINE,
+        .parent         = TYPE_MACHINE,
+        .instance_size  = sizeof(RxGdbSimMachineState),
+        .class_size     = sizeof(RxGdbSimMachineClass),
+        .class_init     = rx_gdbsim_class_init,
+        .abstract       = true,
+     }
+};
+
+DEFINE_TYPES(rx_gdbsim_types)
diff --git a/hw/rx/Kconfig b/hw/rx/Kconfig
index e7b1c59516..2b297c5a6a 100644
--- a/hw/rx/Kconfig
+++ b/hw/rx/Kconfig
@@ -4,3 +4,7 @@ config RX62N_MCU
     select RENESAS_TMR
     select RENESAS_CMT
     select RENESAS_SCI
+
+config RX_GDBSIM
+    bool
+    select RX62N_MCU
diff --git a/hw/rx/Makefile.objs b/hw/rx/Makefile.objs
index fe19ee7984..4ef6b9e5b1 100644
--- a/hw/rx/Makefile.objs
+++ b/hw/rx/Makefile.objs
@@ -1 +1,2 @@
 obj-$(CONFIG_RX62N_MCU) += rx62n.o
+obj-$(CONFIG_RX_GDBSIM) += rx-gdbsim.o
-- 
2.21.3



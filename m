Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD21BC4363D
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 21:03:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51D0620759
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 21:03:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UFzQHOPQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51D0620759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNjGD-0000ag-7l
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 17:03:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38036)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cupertinomiranda@gmail.com>)
 id 1kNj0A-0003Tq-36
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 16:47:02 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:44210)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cupertinomiranda@gmail.com>)
 id 1kNj01-0006UU-88
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 16:47:01 -0400
Received: by mail-wr1-x443.google.com with SMTP id s12so3244863wrw.11
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2020 13:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2m2QIN27HwhTmB66/ss8RaiC9gI8ni4SCkFU9KWqeNo=;
 b=UFzQHOPQ5WxvDit+/js3Yd7J0IpFtp9PA5SasVnOTab5Ue2C3pMfAgVdFOXq4OpKX5
 QUh82CkNN3mtyTKB+gc/nU4D1dxLzSEV+by4p03l3MyY8PxwxoUoeh/Br0kUp0Jo9zRR
 I/k44yuvt1WioMObvFG3AYsegEaecFk6exc9oJdR9/eHAfY5OXgAWmUcaRf6VDNL1Phd
 atjaO6uYzCeyo6R3Fupf3CmgWblw2WNfnrTAwIVJBNbA7iYJkB3sQBw9f9qo1TfA7KdE
 QEOGN9y1WGj642MMN+n17RR4Crz+qLGOTbNnHVdCPNf31Ra+doNYQmHka8kcusY7XCs6
 etmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2m2QIN27HwhTmB66/ss8RaiC9gI8ni4SCkFU9KWqeNo=;
 b=k645hYjh7M9by7BBtNsEDGbcvLkXAwAVbjXCsyFCunwO3+vsLAv8BWaWYu9Gf9FyXJ
 Gxmao7VieUiGYVmKx5NHx0IivGeJXrgglokI66EkdkNzVXo0YsmDKgWu6cdvFqv7PkhI
 kX1csu5GtKtq4al2aqR0PJ5+lUlqyTe9X2xD33dc4agZ7vcSnlK/FzngVwU9lesTZNPu
 0JDj5kS8f1kb2k0X7WKygnDoQaxOWnyFHZPFzRKHzlJ4yPz7QcW6c/0e1kX+AgGw8Rde
 HRmsBQ8lKtU8jo338KOkg2zleA/TcJQDMEaG36PWB+Rm0yNpFfiLbnJXWqvcl8DMvAWw
 O4/Q==
X-Gm-Message-State: AOAM532E8wg8pPxNtC4B4fF4M+rBRSQYLl/7u3hM5BOI3mCqFclqrUvb
 9p8yHkYtceV+fk7h80nuhaC7frgL1eMRBA==
X-Google-Smtp-Source: ABdhPJyw83X7NnFT5KoTBMjkfYAz7jmp1uL2S3uCWnd5gByXoZUn18J5sopJZ5PtY0w7ds246pK1zA==
X-Received: by 2002:adf:91a4:: with SMTP id 33mr5355005wri.170.1601498810397; 
 Wed, 30 Sep 2020 13:46:50 -0700 (PDT)
Received: from cmiranda-laptop.localdomain ([188.251.240.167])
 by smtp.gmail.com with ESMTPSA id v204sm5310764wmg.20.2020.09.30.13.46.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2020 13:46:49 -0700 (PDT)
From: cupertinomiranda@gmail.com
To: qemu-devel@nongnu.org
Subject: [PATCH 12/14] arc: Add Synopsys ARC emulation boards
Date: Wed, 30 Sep 2020 21:46:02 +0100
Message-Id: <20200930204604.20663-13-cupertinomiranda@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200930204604.20663-1-cupertinomiranda@gmail.com>
References: <20200930204604.20663-1-cupertinomiranda@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=cupertinomiranda@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Claudiu Zissulescu <claziss@gmail.com>,
 Cupertino Miranda <cupertinomiranda@gmail.com>,
 Shahab Vahedi <shahab.vahedi@gmail.com>, Shahab Vahedi <shahab@synopsys.com>,
 Cupertino Miranda <cmiranda@synopsys.com>, linux-snps-arc@lists.infradead.org,
 Claudiu Zissulescu <claziss@synopsys.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Claudiu Zissulescu <claziss@synopsys.com>

Add the Synopsys ARC boards, arc_sim for testing, sim-hs main emulation
board using standard UART and nsim which includes a Synopsys ARC specific
UART implementation.

Signed-off-by: Claudiu Zissulescu <claziss@synopsys.com>
---
 hw/arc/Makefile.objs      |  21 +++
 hw/arc/arc_sim.c          | 143 ++++++++++++++++++++
 hw/arc/arc_uart.c         | 267 ++++++++++++++++++++++++++++++++++++++
 hw/arc/board-hsdk.c       | 107 +++++++++++++++
 hw/arc/boot.c             |  95 ++++++++++++++
 hw/arc/boot.h             |  21 +++
 hw/arc/meson.build        |  13 ++
 hw/arc/nsim.c             |  86 ++++++++++++
 hw/arc/pic_cpu.c          | 111 ++++++++++++++++
 hw/arc/sample.c           |  77 +++++++++++
 hw/arc/sim-hs.c           | 107 +++++++++++++++
 include/hw/arc/arc_uart.h |  43 ++++++
 include/hw/arc/cpudevs.h  |  10 ++
 13 files changed, 1101 insertions(+)
 create mode 100644 hw/arc/Makefile.objs
 create mode 100644 hw/arc/arc_sim.c
 create mode 100644 hw/arc/arc_uart.c
 create mode 100644 hw/arc/board-hsdk.c
 create mode 100644 hw/arc/boot.c
 create mode 100644 hw/arc/boot.h
 create mode 100644 hw/arc/meson.build
 create mode 100644 hw/arc/nsim.c
 create mode 100644 hw/arc/pic_cpu.c
 create mode 100644 hw/arc/sample.c
 create mode 100644 hw/arc/sim-hs.c
 create mode 100644 include/hw/arc/arc_uart.h
 create mode 100644 include/hw/arc/cpudevs.h

diff --git a/hw/arc/Makefile.objs b/hw/arc/Makefile.objs
new file mode 100644
index 0000000000..28d7766cd9
--- /dev/null
+++ b/hw/arc/Makefile.objs
@@ -0,0 +1,21 @@
+#
+#  QEMU ARC CPU
+#
+#  Copyright (c) 2019
+#
+#  This library is free software; you can redistribute it and/or
+#  modify it under the terms of the GNU Lesser General Public
+#  License as published by the Free Software Foundation; either
+#  version 2.1 of the License, or (at your option) any later version.
+#
+#  This library is distributed in the hope that it will be useful,
+#  but WITHOUT ANY WARRANTY; without even the implied warranty of
+#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+#  Lesser General Public License for more details.
+#
+#  You should have received a copy of the GNU Lesser General Public
+#  License along with this library; if not, see
+#  http://www.gnu.org/licenses/lgpl-2.1.html
+#
+
+obj-y   = arc_sim.o arc_uart.o sample.o pic_cpu.o boot.o board-hsdk.o sim-hs.o nsim.o
diff --git a/hw/arc/arc_sim.c b/hw/arc/arc_sim.c
new file mode 100644
index 0000000000..8020a03d85
--- /dev/null
+++ b/hw/arc/arc_sim.c
@@ -0,0 +1,143 @@
+/*
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "cpu.h"
+#include "hw/hw.h"
+#include "hw/boards.h"
+#include "elf.h"
+#include "hw/char/serial.h"
+#include "net/net.h"
+#include "hw/loader.h"
+#include "exec/memory.h"
+#include "exec/address-spaces.h"
+#include "sysemu/reset.h"
+#include "sysemu/runstate.h"
+#include "sysemu/sysemu.h"
+#include "hw/sysbus.h"
+#include "hw/arc/cpudevs.h"
+#include "boot.h"
+
+static void arc_sim_net_init(MemoryRegion *address_space,
+                             hwaddr base,
+                             hwaddr descriptors,
+                             qemu_irq irq, NICInfo *nd)
+{
+    DeviceState *dev;
+    SysBusDevice *s;
+
+    dev = qdev_new("open_eth");
+    qdev_set_nic_properties(dev, nd);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+
+    s = SYS_BUS_DEVICE(dev);
+    sysbus_connect_irq(s, 0, irq);
+    memory_region_add_subregion(address_space, base,
+                                sysbus_mmio_get_region(s, 0));
+    memory_region_add_subregion(address_space, descriptors,
+                                sysbus_mmio_get_region(s, 1));
+}
+
+static uint64_t arc_io_read(void *opaque, hwaddr addr, unsigned size)
+{
+    return 0;
+}
+
+static void arc_io_write(void *opaque, hwaddr addr,
+                         uint64_t val, unsigned size)
+{
+    switch (addr) {
+    case 0x08: /* board reset. */
+        qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
+        break;
+    default:
+        break;
+    }
+}
+
+static const MemoryRegionOps arc_io_ops = {
+    .read = arc_io_read,
+    .write = arc_io_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+};
+
+static void arc_sim_init(MachineState *machine)
+{
+    static struct arc_boot_info boot_info;
+    unsigned int smp_cpus = machine->smp.cpus;
+    ram_addr_t ram_base = 0;
+    ram_addr_t ram_size = machine->ram_size;
+    ARCCPU *cpu = NULL;
+    MemoryRegion *ram, *system_io;
+    int n;
+
+    boot_info.ram_start = ram_base;
+    boot_info.ram_size = ram_size;
+    boot_info.kernel_filename = machine->kernel_filename;
+
+    for (n = 0; n < smp_cpus; n++) {
+        cpu = ARC_CPU(object_new(machine->cpu_type));
+        if (cpu == NULL) {
+            fprintf(stderr, "Unable to find CPU definition!\n");
+            exit(1);
+        }
+
+        /* Set the initial CPU properties. */
+        object_property_set_uint(OBJECT(cpu), "freq_hz", 1000000, &error_fatal);
+        object_property_set_bool(OBJECT(cpu), "rtc-opt", true, &error_fatal);
+        object_property_set_bool(OBJECT(cpu), "realized", true, &error_fatal);
+
+        /* Initialize internal devices. */
+        cpu_arc_pic_init(cpu);
+        cpu_arc_clock_init(cpu);
+
+        qemu_register_reset(arc_cpu_reset, cpu);
+    }
+
+    ram = g_new(MemoryRegion, 1);
+    memory_region_init_ram(ram, NULL, "arc.ram", ram_size, &error_fatal);
+    memory_region_add_subregion(get_system_memory(), ram_base, ram);
+
+    system_io = g_new(MemoryRegion, 1);
+    memory_region_init_io(system_io, NULL, &arc_io_ops, NULL, "arc.io",
+                           1024);
+    memory_region_add_subregion(get_system_memory(), 0xf0000000, system_io);
+
+    serial_mm_init(get_system_memory(), 0x90000000, 2, cpu->env.irq[20],
+                   115200, serial_hd(0), DEVICE_NATIVE_ENDIAN);
+
+    if (nd_table[0].used) {
+        arc_sim_net_init(get_system_memory(), 0x92000000,
+                         0x92000400, cpu->env.irq[4], nd_table);
+    }
+
+    arc_load_kernel(cpu, &boot_info);
+}
+
+static void arc_sim_machine_init(MachineClass *mc)
+{
+    mc->desc = "ARCxx simulation";
+    mc->init = arc_sim_init;
+    mc->max_cpus = 1;
+    mc->is_default = false;
+    mc->default_cpu_type = ARC_CPU_TYPE_NAME("archs");
+}
+
+DEFINE_MACHINE("arc-sim", arc_sim_machine_init)
+
+
+/*-*-indent-tabs-mode:nil;tab-width:4;indent-line-function:'insert-tab'-*-*/
+/* vim: set ts=4 sw=4 et: */
diff --git a/hw/arc/arc_uart.c b/hw/arc/arc_uart.c
new file mode 100644
index 0000000000..ec7aad37be
--- /dev/null
+++ b/hw/arc/arc_uart.c
@@ -0,0 +1,267 @@
+/*
+ * ARC UART model for QEMU
+ * Copyright (c) 2019 Synopsys Inc.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "hw/sysbus.h"
+#include "chardev/char.h"
+#include "chardev/char-fe.h"
+#include "hw/hw.h"
+#include "hw/irq.h"
+#include "hw/arc/arc_uart.h"
+#include "qemu/log.h"
+
+#ifndef ARC_UART_ERR_DEBUG
+#define ARC_UART_ERR_DEBUG 0
+#endif
+
+#define DB_PRINT_L(lvl, fmt, args...)                \
+    do {                                             \
+        if (ARC_UART_ERR_DEBUG >= lvl) {             \
+            qemu_log("%s: " fmt, __func__, ## args); \
+        }                                            \
+    } while (0)
+
+#define DB_PRINT(fmt, args...) DB_PRINT_L(1, fmt, ## args)
+
+enum {
+    ARC_UART_REG_ID0    = 0x00,
+    ARC_UART_REG_ID1    = 0x04,
+    ARC_UART_REG_ID2    = 0x08,
+    ARC_UART_REG_ID3    = 0x0c,
+    ARC_UART_REG_DATA   = 0x10,
+    ARC_UART_REG_STATUS = 0x14,
+    ARC_UART_REG_BAUDL  = 0x18,
+    ARC_UART_REG_BAUDH  = 0x1c,
+    ARC_UART_REG_MAX    = 0x20
+};
+
+/*
+ * Bit definitions of STATUS register:
+ *
+ * UART_TXEMPTY      Transmit FIFO Empty, thus char can be written into
+ * UART_TX_IE        Transmit Interrupt Enable
+ * UART_RXEMPTY      Receive FIFO Empty: No char receivede
+ * UART_RX_FULL1     Receive FIFO has space for 1 char (tot space=4)
+ * UART_RX_FULL      Receive FIFO full
+ * UART_RX_IE        Receive Interrupt Enable
+ * UART_OVERFLOW_ERR OverFlow Err: Char recv but RXFULL still set
+ * UART_RX_FERR      Frame Error: Stop Bit not detected
+ */
+#define UART_TXEMPTY      (1 << 7)
+#define UART_TX_IE        (1 << 6)
+#define UART_RXEMPTY      (1 << 5)
+#define UART_RX_FULL1     (1 << 4)
+#define UART_RX_FULL      (1 << 3)
+#define UART_RX_IE        (1 << 2)
+#define UART_OVERFLOW_ERR (1 << 1)
+#define UART_RX_FERR      (1 << 0)
+
+static void arc_uart_update_irq(const ARC_UART_State *s)
+{
+    int cond = 0;
+
+    if ((s->rx_ie && s->rx_fifo_len) || s->tx_ie) {
+        cond = 1;
+    }
+
+    if (cond) {
+        qemu_irq_raise(s->irq);
+    } else {
+        qemu_irq_lower(s->irq);
+    }
+}
+
+static uint32_t arc_status_get(const ARC_UART_State *s)
+{
+    uint32_t status = UART_TXEMPTY;
+
+    if (!s->rx_fifo_len) {
+        status |= UART_RXEMPTY;
+    }
+
+    if (s->rx_ie) {
+        status |= UART_RX_IE;
+    }
+
+    if (s->tx_ie) {
+        status |= UART_TX_IE;
+    }
+
+    if (s->rx_fifo_len == sizeof(s->rx_fifo)) {
+        status |= UART_RX_FULL;
+    }
+
+    if (s->rx_fifo_len == (sizeof(s->rx_fifo) - 1)) {
+        status |= UART_RX_FULL1;
+    }
+
+    return status;
+}
+
+static void arc_status_set(ARC_UART_State *s, char value)
+{
+    if (value & UART_TX_IE) {
+        s->tx_ie = true;
+    } else {
+        s->tx_ie = false;
+    }
+
+    /*
+     * Tx IRQ is active if (TXIE && TXEMPTY), but since in QEMU we
+     * transmit data immediately TXEMPTY is permanently set, thus
+     * for TX IRQ state we need to check TXIE only which we do here.
+     */
+    arc_uart_update_irq(s);
+
+    if (value & UART_RX_IE) {
+        s->rx_ie = true;
+    } else {
+        s->rx_ie = false;
+    }
+}
+
+static uint64_t arc_uart_read(void *opaque, hwaddr addr, unsigned size)
+{
+    ARC_UART_State *s = opaque;
+    uint32_t c;
+
+    DB_PRINT("Read reg with offset 0x%02x\n", (unsigned int)addr);
+
+    switch (addr) {
+    case ARC_UART_REG_ID0:
+    case ARC_UART_REG_ID1:
+    case ARC_UART_REG_ID2:
+    case ARC_UART_REG_ID3:
+        return 0;
+    case ARC_UART_REG_DATA:
+        c = s->rx_fifo[0];
+        memmove(s->rx_fifo, s->rx_fifo + 1, s->rx_fifo_len - 1);
+        s->rx_fifo_len--;
+        qemu_chr_fe_accept_input(&s->chr);
+        arc_uart_update_irq(s);
+        DB_PRINT("Read char: %c\n", c);
+        return c;
+    case ARC_UART_REG_STATUS:
+        return arc_status_get(s);
+    case ARC_UART_REG_BAUDL:
+        return s->baud & 0xff;
+    case ARC_UART_REG_BAUDH:
+        return s->baud >> 8;
+    default:
+        break;
+    }
+
+    hw_error("%s@%d: Wrong register with offset 0x%02x is used!\n",
+             __func__, __LINE__, (unsigned int)addr);
+    return 0;
+}
+
+static void arc_uart_write(void *opaque, hwaddr addr,
+                           uint64_t value, unsigned size)
+{
+    ARC_UART_State *s = opaque;
+    unsigned char ch = value;
+
+    DB_PRINT("Write value 0x%02x to reg with offset 0x%02x\n",
+             ch, (unsigned int)addr);
+
+    switch (addr) {
+    case ARC_UART_REG_ID0:
+    case ARC_UART_REG_ID1:
+    case ARC_UART_REG_ID2:
+    case ARC_UART_REG_ID3:
+        break;
+    case ARC_UART_REG_DATA:
+        DB_PRINT("Write char: %c\n", ch);
+        qemu_chr_fe_write(&s->chr, &ch, 1);
+        break;
+    case ARC_UART_REG_STATUS:
+        arc_status_set(s, ch);
+        break;
+    case ARC_UART_REG_BAUDL:
+        s->baud = (s->baud & 0xff00) + value;
+        break;
+    case ARC_UART_REG_BAUDH:
+        s->baud = (s->baud & 0xff) + (value << 8);
+        break;
+    default:
+        hw_error("%s@%d: Wrong register with offset 0x%02x is used!\n",
+                 __func__, __LINE__, (unsigned int)addr);
+    }
+}
+
+static const MemoryRegionOps arc_uart_ops = {
+    .read = arc_uart_read,
+    .write = arc_uart_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 1
+    }
+};
+
+static void uart_rx(void *opaque, const uint8_t *buf, int size)
+{
+    ARC_UART_State *s = opaque;
+
+    /* Got a byte.  */
+    if (s->rx_fifo_len >= sizeof(s->rx_fifo)) {
+        DB_PRINT("Rx FIFO is full dropping the chars\n");
+        return;
+    }
+    s->rx_fifo[s->rx_fifo_len++] = *buf;
+
+    arc_uart_update_irq(s);
+}
+
+static int uart_can_rx(void *opaque)
+{
+    ARC_UART_State *s = opaque;
+
+    return s->rx_fifo_len < sizeof(s->rx_fifo);
+}
+
+static void uart_event(void *opaque, QEMUChrEvent event)
+{
+}
+
+static int uart_be_change(void *opaque)
+{
+    ARC_UART_State *s = opaque;
+
+    qemu_chr_fe_set_handlers(&s->chr, uart_can_rx, uart_rx, uart_event,
+                             uart_be_change, s, NULL, true);
+    return 0;
+}
+
+ARC_UART_State *arc_uart_create(MemoryRegion *address_space, hwaddr base,
+                                Chardev *chr, qemu_irq irq)
+{
+    ARC_UART_State *s = g_malloc0(sizeof(ARC_UART_State));
+
+    DB_PRINT("Create ARC UART\n");
+
+    s->irq = irq;
+    qemu_chr_fe_init(&s->chr, chr, &error_abort);
+    qemu_chr_fe_set_handlers(&s->chr, uart_can_rx, uart_rx, uart_event,
+                             uart_be_change, s, NULL, true);
+    memory_region_init_io(&s->mmio, NULL, &arc_uart_ops, s,
+                          TYPE_ARC_UART, ARC_UART_REG_MAX);
+    memory_region_add_subregion(address_space, base, &s->mmio);
+    return s;
+}
+
+
+/*-*-indent-tabs-mode:nil;tab-width:4;indent-line-function:'insert-tab'-*-*/
+/* vim: set ts=4 sw=4 et: */
diff --git a/hw/arc/board-hsdk.c b/hw/arc/board-hsdk.c
new file mode 100644
index 0000000000..5440a73c2f
--- /dev/null
+++ b/hw/arc/board-hsdk.c
@@ -0,0 +1,107 @@
+/*
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "boot.h"
+#include "hw/boards.h"
+#include "hw/char/serial.h"
+#include "exec/address-spaces.h"
+#include "sysemu/reset.h"
+#include "sysemu/sysemu.h"
+#include "hw/arc/cpudevs.h"
+#include "hw/sysbus.h"
+
+#define HSDK_RAM_BASE      0x80000000
+#define HSDK_RAM_SIZE      0x80000000
+#define HSDK_IO_BASE       0xf0000000
+#define HSDK_IO_SIZE       0x10000000
+#define HSDK_UART0_OFFSET  0x5000
+#define HSDK_UART0_IRQ     30
+
+/* VirtIO */
+#define HSDK_VIRTIO_NUMBER 5
+#define HSDK_VIRTIO_OFFSET 0x100000
+#define HSDK_VIRTIO_BASE   (HSDK_IO_BASE + HSDK_VIRTIO_OFFSET)
+#define HSDK_VIRTIO_SIZE   0x1000
+#define HSDK_VIRTIO_IRQ    31
+
+static void hsdk_init(MachineState *machine)
+{
+    static struct arc_boot_info boot_info;
+    unsigned int smp_cpus = machine->smp.cpus;
+    MemoryRegion *system_memory = get_system_memory();
+    MemoryRegion *system_ram;
+    MemoryRegion *system_io;
+    ARCCPU *cpu = NULL;
+    int n;
+
+    boot_info.ram_start = HSDK_RAM_BASE;
+    boot_info.ram_size = HSDK_RAM_SIZE;
+    boot_info.kernel_filename = machine->kernel_filename;
+    boot_info.kernel_cmdline = machine->kernel_cmdline;
+
+    for (n = 0; n < smp_cpus; n++) {
+        cpu = ARC_CPU(cpu_create("archs-" TYPE_ARC_CPU));
+        if (cpu == NULL) {
+            fprintf(stderr, "Unable to find CPU definition!\n");
+            exit(1);
+        }
+
+       /* Initialize internal devices. */
+        cpu_arc_pic_init(cpu);
+        cpu_arc_clock_init(cpu);
+
+        qemu_register_reset(arc_cpu_reset, cpu);
+    }
+
+    /* Init system DDR */
+    system_ram = g_new(MemoryRegion, 1);
+    memory_region_init_ram(system_ram, NULL, "arc.ram", HSDK_RAM_SIZE,
+                           &error_fatal);
+    memory_region_add_subregion(system_memory, HSDK_RAM_BASE, system_ram);
+
+    /* Init IO area */
+    system_io = g_new(MemoryRegion, 1);
+    memory_region_init_io(system_io, NULL, NULL, NULL, "arc.io",
+                          HSDK_IO_SIZE);
+    memory_region_add_subregion(system_memory, HSDK_IO_BASE, system_io);
+
+    serial_mm_init(system_io, HSDK_UART0_OFFSET, 2,
+                   cpu->env.irq[HSDK_UART0_IRQ], 115200, serial_hd(0),
+                   DEVICE_NATIVE_ENDIAN);
+
+    for (n = 0; n < HSDK_VIRTIO_NUMBER; n++) {
+        sysbus_create_simple("virtio-mmio",
+                             HSDK_VIRTIO_BASE + HSDK_VIRTIO_SIZE * n,
+                             cpu->env.irq[HSDK_VIRTIO_IRQ + n]);
+    }
+
+    arc_load_kernel(cpu, &boot_info);
+}
+
+static void hsdk_machine_init(MachineClass *mc)
+{
+    mc->desc = "ARC HSDK Emulator";
+    mc->init = hsdk_init;
+    mc->max_cpus = 1;
+    mc->is_default = false;
+}
+
+DEFINE_MACHINE("hsdk", hsdk_machine_init)
+
+
+/*-*-indent-tabs-mode:nil;tab-width:4;indent-line-function:'insert-tab'-*-*/
+/* vim: set ts=4 sw=4 et: */
diff --git a/hw/arc/boot.c b/hw/arc/boot.c
new file mode 100644
index 0000000000..95ba3a7a56
--- /dev/null
+++ b/hw/arc/boot.c
@@ -0,0 +1,95 @@
+/*
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "boot.h"
+#include "elf.h"
+#include "hw/loader.h"
+#include "qemu/error-report.h"
+#include "qemu/units.h"
+
+void arc_cpu_reset(void *opaque)
+{
+    ARCCPU *cpu = opaque;
+    CPUARCState *env = &cpu->env;
+    const struct arc_boot_info *info = env->boot_info;
+
+    cpu_reset(CPU(cpu));
+
+    /*
+     * Right before start CPU gets reset wiping out everything
+     * but PC which we set on Elf load.
+     *
+     * And if we still want to pass something like U-Boot data
+     * via CPU registers we have to do it here.
+     */
+
+    if (info->kernel_cmdline && strlen(info->kernel_cmdline)) {
+        /*
+         * Load "cmdline" far enough from the kernel image.
+         * Round by MAX page size for ARC - 16 KiB.
+         */
+        hwaddr cmdline_addr = info->ram_start +
+            QEMU_ALIGN_UP(info->ram_size / 2, 16 * KiB);
+        cpu_physical_memory_write(cmdline_addr, info->kernel_cmdline,
+                                  strlen(info->kernel_cmdline));
+
+        /* We're passing "cmdline" */
+        cpu->env.r[0] = ARC_UBOOT_CMDLINE;
+        cpu->env.r[2] = cmdline_addr;
+    }
+}
+
+
+void arc_load_kernel(ARCCPU *cpu, struct arc_boot_info *info)
+{
+    hwaddr entry;
+    int elf_machine, kernel_size;
+
+    if (!info->kernel_filename) {
+        error_report("missing kernel file");
+        exit(EXIT_FAILURE);
+    }
+
+    elf_machine = cpu->env.family > 2 ? EM_ARC_COMPACT2 : EM_ARC_COMPACT;
+    kernel_size = load_elf(info->kernel_filename, NULL, NULL, NULL,
+                           &entry, NULL, NULL, NULL, ARC_ENDIANNESS_LE,
+                           elf_machine, 1, 0);
+
+    if (kernel_size < 0) {
+        int is_linux;
+
+        kernel_size = load_uimage(info->kernel_filename, &entry, NULL,
+                                  &is_linux, NULL, NULL);
+        if (!is_linux) {
+            error_report("Wrong U-Boot image, only Linux kernel is supported");
+            exit(EXIT_FAILURE);
+        }
+    }
+
+    if (kernel_size < 0) {
+        error_report("No kernel image found");
+        exit(EXIT_FAILURE);
+    }
+
+    cpu->env.boot_info = info;
+
+    /* Set CPU's PC to point to the entry-point */
+    cpu->env.pc = entry;
+}
+
+
+/*-*-indent-tabs-mode:nil;tab-width:4;indent-line-function:'insert-tab'-*-*/
+/* vim: set ts=4 sw=4 et: */
diff --git a/hw/arc/boot.h b/hw/arc/boot.h
new file mode 100644
index 0000000000..e46aa16fc6
--- /dev/null
+++ b/hw/arc/boot.h
@@ -0,0 +1,21 @@
+#ifndef ARC_BOOT_H
+#define ARC_BOOT_H
+
+#include "hw/hw.h"
+#include "cpu.h"
+
+struct arc_boot_info {
+    hwaddr ram_start;
+    uint64_t ram_size;
+    const char *kernel_filename;
+    const char *kernel_cmdline;
+};
+
+void arc_cpu_reset(void *opaque);
+void arc_load_kernel(ARCCPU *cpu, struct arc_boot_info *boot_info);
+
+#endif /* ARC_BOOT_H */
+
+
+/*-*-indent-tabs-mode:nil;tab-width:4;indent-line-function:'insert-tab'-*-*/
+/* vim: set ts=4 sw=4 et: */
diff --git a/hw/arc/meson.build b/hw/arc/meson.build
new file mode 100644
index 0000000000..6a587307a4
--- /dev/null
+++ b/hw/arc/meson.build
@@ -0,0 +1,13 @@
+arc_ss = ss.source_set()
+arc_ss.add(files(
+  'arc_sim.c',
+  'arc_uart.c',
+  'sample.c',
+  'pic_cpu.c',
+  'boot.c',
+  'board-hsdk.c',
+  'sim-hs.c',
+  'nsim.c',
+))
+
+hw_arch += {'arc': arc_ss}
diff --git a/hw/arc/nsim.c b/hw/arc/nsim.c
new file mode 100644
index 0000000000..810b0efa1d
--- /dev/null
+++ b/hw/arc/nsim.c
@@ -0,0 +1,86 @@
+/*
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "boot.h"
+#include "sysemu/reset.h"
+#include "sysemu/sysemu.h"
+#include "hw/boards.h"
+#include "hw/char/serial.h"
+#include "exec/address-spaces.h"
+#include "hw/arc/arc_uart.h"
+#include "hw/arc/cpudevs.h"
+#include "hw/sysbus.h"
+
+#define NSIM_RAM_BASE        0x80000000
+#define NSIM_RAM_SIZE        0x40000000
+#define NSIM_ARC_UART_OFFSET 0xc0fc1000
+
+static void nsim_init(MachineState *machine)
+{
+    static struct arc_boot_info boot_info;
+    unsigned int smp_cpus = machine->smp.cpus;
+    MemoryRegion *system_memory = get_system_memory();
+    MemoryRegion *system_ram;
+    ARCCPU *cpu = NULL;
+    int n;
+
+    boot_info.ram_start = NSIM_RAM_BASE;
+    boot_info.ram_size = NSIM_RAM_SIZE;
+    boot_info.kernel_filename = machine->kernel_filename;
+    boot_info.kernel_cmdline = machine->kernel_cmdline;
+
+    for (n = 0; n < smp_cpus; n++) {
+        cpu = ARC_CPU (cpu_create("archs-" TYPE_ARC_CPU));
+        if (cpu == NULL) {
+            fprintf(stderr, "Unable to find CPU definition!\n");
+            exit(1);
+        }
+
+       /* Initialize internal devices. */
+        cpu_arc_pic_init(cpu);
+        cpu_arc_clock_init(cpu);
+
+        qemu_register_reset(arc_cpu_reset, cpu);
+    }
+
+    /* Init system DDR */
+    system_ram = g_new(MemoryRegion, 1);
+    memory_region_init_ram(system_ram, NULL, "arc.ram", NSIM_RAM_SIZE,
+                           &error_fatal);
+    memory_region_add_subregion(system_memory, NSIM_RAM_BASE, system_ram);
+
+    /* Init ARC UART */
+    arc_uart_create(get_system_memory(), NSIM_ARC_UART_OFFSET,
+                    serial_hd(0), cpu->env.irq[24]);
+
+    arc_load_kernel(cpu, &boot_info);
+}
+
+static void nsim_machine_init(MachineClass *mc)
+{
+    mc->desc = "ARC nSIM";
+    mc->init = nsim_init;
+    mc->max_cpus = 1;
+    mc->is_default = false;
+}
+
+DEFINE_MACHINE("nsim", nsim_machine_init)
+
+
+/*-*-indent-tabs-mode:nil;tab-width:4;indent-line-function:'insert-tab'-*-*/
+/* vim: set ts=4 sw=4 et: */
diff --git a/hw/arc/pic_cpu.c b/hw/arc/pic_cpu.c
new file mode 100644
index 0000000000..0a29a2f803
--- /dev/null
+++ b/hw/arc/pic_cpu.c
@@ -0,0 +1,111 @@
+/*
+ * ARC Programmable Interrupt Controller support.
+ *
+ * Copyright (c) 2019
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "cpu.h"
+#include "hw/hw.h"
+#include "hw/irq.h"
+#include "qemu/log.h"
+#include "hw/arc/cpudevs.h"
+
+/*
+ * ARC pic handler
+ */
+static void arc_pic_cpu_handler(void *opaque, int irq, int level)
+{
+    ARCCPU *cpu = (ARCCPU *) opaque;
+    CPUState *cs = CPU(cpu);
+    CPUARCState *env = &cpu->env;
+    int i;
+    bool clear = false;
+    uint32_t irq_bit;
+
+    /* Assert if this handler is called in a system without interrupts. */
+    assert(cpu->cfg.has_interrupts);
+
+    /* Assert if the IRQ is not within the cpu configuration bounds. */
+    assert(irq >= 16 && irq < (cpu->cfg.number_of_interrupts + 15));
+
+    irq_bit = 1 << env->irq_bank[irq].priority;
+    if (level) {
+        /*
+         * An interrupt is enabled, update irq_priority_pendig and rise
+         * the qemu interrupt line.
+         */
+        env->irq_bank[irq].pending = 1;
+        qatomic_or(&env->irq_priority_pending, irq_bit);
+        cpu_interrupt(cs, CPU_INTERRUPT_HARD);
+    } else {
+        env->irq_bank[irq].pending = 0;
+
+        /*
+         * First, check if we still have any pending interrupt at the
+         * given priority.
+         */
+        clear = true;
+        for (i = 16; i < cpu->cfg.number_of_interrupts; i++) {
+            if (env->irq_bank[i].pending
+                && env->irq_bank[i].priority == env->irq_bank[irq].priority) {
+                clear = false;
+                break;
+            }
+        }
+
+        /* If not, update (clear) irq_priority_pending. */
+        if (clear) {
+            qatomic_and(&env->irq_priority_pending, ~irq_bit);
+        }
+
+        /*
+         * If we don't have any pending priority, lower the qemu irq
+         * line. N.B. we can also check more here like IE bit, but we
+         * need to add a cpu_interrupt call when we enable the
+         * interrupts (e.g., sleep, seti).
+         */
+        if (!env->irq_priority_pending) {
+            cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
+        }
+    }
+    qemu_log_mask(CPU_LOG_INT,
+                  "[IRQ] level = %d, clear = %d, irq = %d, priority = %d, "
+                  "pending = %08x, pc = %08x\n",
+                  level, clear, irq, env->irq_bank[irq].priority,
+                  env->irq_priority_pending, env->pc);
+}
+
+/*
+ * ARC PIC initialization helper
+ */
+void cpu_arc_pic_init(ARCCPU *cpu)
+{
+    CPUARCState *env = &cpu->env;
+    int i;
+    qemu_irq *qi;
+
+    qi = qemu_allocate_irqs(arc_pic_cpu_handler, cpu,
+                            16 + cpu->cfg.number_of_interrupts);
+
+    for (i = 0; i < cpu->cfg.number_of_interrupts; i++) {
+        env->irq[16 + i] = qi[16 + i];
+    }
+}
+
+
+/*-*-indent-tabs-mode:nil;tab-width:4;indent-line-function:'insert-tab'-*-*/
+/* vim: set ts=4 sw=4 et: */
diff --git a/hw/arc/sample.c b/hw/arc/sample.c
new file mode 100644
index 0000000000..0ecc11cf15
--- /dev/null
+++ b/hw/arc/sample.c
@@ -0,0 +1,77 @@
+/*
+ * QEMU ARC CPU
+ *
+ * Copyright (c) 2016 Michael Rolnik
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see
+ * http://www.gnu.org/licenses/lgpl-2.1.html
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qemu-common.h"
+#include "cpu.h"
+#include "hw/hw.h"
+#include "sysemu/sysemu.h"
+#include "sysemu/qtest.h"
+#include "ui/console.h"
+#include "hw/boards.h"
+#include "hw/loader.h"
+#include "qemu/error-report.h"
+#include "exec/address-spaces.h"
+#include "include/hw/sysbus.h"
+
+#define SIZE_RAM 0x00020000
+
+static void sample_init(MachineState *machine)
+{
+    MemoryRegion *ram;
+
+    ARCCPU *cpu_arc ATTRIBUTE_UNUSED;
+
+    ram = g_new(MemoryRegion, 1);
+
+    cpu_arc = ARC_CPU(cpu_create("archs-" TYPE_ARC_CPU));
+
+    memory_region_init_ram(ram, NULL, "ram", SIZE_RAM, &error_fatal);
+    memory_region_add_subregion(get_system_memory(), PHYS_BASE_RAM, ram);
+
+    char const *firmware = NULL;
+    char const *filename;
+
+    if (machine->firmware) {
+        firmware = machine->firmware;
+    }
+
+    filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, firmware);
+    if (!filename) {
+        error_report("Could not find flash image file '%s'", firmware);
+        exit(1);
+    }
+
+    load_image_targphys(filename, PHYS_BASE_RAM + 0x100, SIZE_RAM);
+}
+
+static void sample_machine_init(MachineClass *mc)
+{
+    mc->desc = "ARC sample/example board";
+    mc->init = sample_init;
+    mc->is_default = false;
+}
+
+DEFINE_MACHINE("sample", sample_machine_init)
+
+
+/*-*-indent-tabs-mode:nil;tab-width:4;indent-line-function:'insert-tab'-*-*/
+/* vim: set ts=4 sw=4 et: */
diff --git a/hw/arc/sim-hs.c b/hw/arc/sim-hs.c
new file mode 100644
index 0000000000..93cd9e3826
--- /dev/null
+++ b/hw/arc/sim-hs.c
@@ -0,0 +1,107 @@
+/*
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "boot.h"
+#include "hw/boards.h"
+#include "hw/char/serial.h"
+#include "exec/address-spaces.h"
+#include "sysemu/reset.h"
+#include "sysemu/sysemu.h"
+#include "hw/arc/cpudevs.h"
+#include "hw/sysbus.h"
+
+#define SIMHS_RAM_BASE      0x80000000
+#define SIMHS_RAM_SIZE      0x80000000
+#define SIMHS_IO_BASE       0xf0000000
+#define SIMHS_IO_SIZE       0x10000000
+#define SIMHS_UART0_OFFSET  0x0
+#define SIMHS_UART0_IRQ     24
+
+/* VirtIO */
+#define SIMHS_VIRTIO_NUMBER 5
+#define SIMHS_VIRTIO_OFFSET 0x100000
+#define SIMHS_VIRTIO_BASE   (SIMHS_IO_BASE + SIMHS_VIRTIO_OFFSET)
+#define SIMHS_VIRTIO_SIZE   0x2000
+#define SIMHS_VIRTIO_IRQ    31
+
+static void simhs_init(MachineState *machine)
+{
+    static struct arc_boot_info boot_info;
+    unsigned int smp_cpus = machine->smp.cpus;
+    MemoryRegion *system_memory = get_system_memory();
+    MemoryRegion *system_ram;
+    MemoryRegion *system_io;
+    ARCCPU *cpu = NULL;
+    int n;
+
+    boot_info.ram_start = SIMHS_RAM_BASE;
+    boot_info.ram_size = SIMHS_RAM_SIZE;
+    boot_info.kernel_filename = machine->kernel_filename;
+    boot_info.kernel_cmdline = machine->kernel_cmdline;
+
+    for (n = 0; n < smp_cpus; n++) {
+        cpu = ARC_CPU(cpu_create("archs-" TYPE_ARC_CPU));
+        if (cpu == NULL) {
+            fprintf(stderr, "Unable to find CPU definition!\n");
+            exit(1);
+        }
+
+       /* Initialize internal devices. */
+        cpu_arc_pic_init(cpu);
+        cpu_arc_clock_init(cpu);
+
+        qemu_register_reset(arc_cpu_reset, cpu);
+    }
+
+    /* Init system DDR */
+    system_ram = g_new(MemoryRegion, 1);
+    memory_region_init_ram(system_ram, NULL, "arc.ram", SIMHS_RAM_SIZE,
+                           &error_fatal);
+    memory_region_add_subregion(system_memory, SIMHS_RAM_BASE, system_ram);
+
+    /* Init IO area */
+    system_io = g_new(MemoryRegion, 1);
+    memory_region_init_io(system_io, NULL, NULL, NULL, "arc.io",
+                          SIMHS_IO_SIZE);
+    memory_region_add_subregion(system_memory, SIMHS_IO_BASE, system_io);
+
+    serial_mm_init(system_io, SIMHS_UART0_OFFSET, 2,
+                   cpu->env.irq[SIMHS_UART0_IRQ], 115200, serial_hd(0),
+                   DEVICE_NATIVE_ENDIAN);
+
+    for (n = 0; n < SIMHS_VIRTIO_NUMBER; n++) {
+        sysbus_create_simple("virtio-mmio",
+                             SIMHS_VIRTIO_BASE + SIMHS_VIRTIO_SIZE * n,
+                             cpu->env.irq[SIMHS_VIRTIO_IRQ + n]);
+    }
+
+    arc_load_kernel(cpu, &boot_info);
+}
+
+static void simhs_machine_init(MachineClass *mc)
+{
+    mc->desc = "ARC HS Simulator";
+    mc->init = simhs_init;
+    mc->max_cpus = 1;
+    mc->is_default = true;
+}
+
+DEFINE_MACHINE("simhs", simhs_machine_init)
+
+
+/*-*-indent-tabs-mode:nil;tab-width:4;indent-line-function:'insert-tab'-*-*/
+/* vim: set ts=4 sw=4 et: */
diff --git a/include/hw/arc/arc_uart.h b/include/hw/arc/arc_uart.h
new file mode 100644
index 0000000000..305f93d134
--- /dev/null
+++ b/include/hw/arc/arc_uart.h
@@ -0,0 +1,43 @@
+/*
+ * ARC UART model for QEMU
+ * Copyright (c) 2020 Synopsys Inc.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef ARC_UART_H
+#define ARC_UART_H
+
+#include "hw/sysbus.h"
+#include "chardev/char-fe.h"
+
+#define TYPE_ARC_UART "arc-uart"
+#define ARC_UART(obj) OBJECT_CHECK(ARC_UART_State, (obj), TYPE_ARC_UART)
+
+#define ARC_UART_RX_FIFO_LEN 4
+
+typedef struct ARC_UART_State {
+    /*< private >*/
+    SysBusDevice parent_obj;
+
+    /*< public >*/
+    MemoryRegion mmio;
+    CharBackend chr;
+    qemu_irq irq;
+    bool rx_ie, tx_ie;
+
+    uint8_t rx_fifo[ARC_UART_RX_FIFO_LEN];
+    unsigned int rx_fifo_len;
+    uint32_t baud;
+} ARC_UART_State;
+
+ARC_UART_State *arc_uart_create(MemoryRegion *address_space, hwaddr base,
+    Chardev *chr, qemu_irq irq);
+
+#endif
diff --git a/include/hw/arc/cpudevs.h b/include/hw/arc/cpudevs.h
new file mode 100644
index 0000000000..52f7eaf9f4
--- /dev/null
+++ b/include/hw/arc/cpudevs.h
@@ -0,0 +1,10 @@
+#ifndef HW_ARC_CPUDEVS_H
+#define HW_ARC_CPUDEVS_H
+
+/* Timer service routines.  */
+extern void cpu_arc_clock_init(ARCCPU *);
+
+/* PIC service routines. */
+extern void cpu_arc_pic_init(ARCCPU *);
+
+#endif /* !HW_ARC_CPUDEVS_H */
-- 
2.20.1



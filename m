Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 898BEC0650E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 09:36:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5280C21882
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 09:36:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5280C21882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hibh7-0007BT-CC
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 05:36:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51773)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <palmer@dabbelt.com>) id 1hiaqA-0006WP-M5
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 04:42:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1hiaq5-0008EI-OB
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 04:42:10 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37166)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1hiaq5-00087c-A3
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 04:42:05 -0400
Received: by mail-lf1-f67.google.com with SMTP id d11so1169209lfb.4
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2019 01:42:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=AjHoyr0UySwycrqVbGqhPd/G36L+Az+7aEEjVYksGCg=;
 b=mW6x5ATz0veBlOZKcKYVEVrfJ4mftC1Dt9SJpYIWQoW+WL6zF9EGQl9w8i3XxHbdwy
 67yqOpOS4K3j4qvgmid8Xy7jvAvxY28b23qUVqa8K8FZk5/WIGF0k5gRVgSDfPaxXSpu
 aXuFVmDIoiG5uiI0G5XrbmVEyI+DJYoYBma7jFODRyU+K3Q7n0yg/tbjtbF8gMYYff0b
 q1Zt3QsASf+ApGQJsc1JvwfjLOpXKcq457enRnnULiWcWidj4prHBG1c3v29+/WA3V45
 MLMFXWAHyk/n4RuUyYUokn4XYquxcbTXATm83ysjtsh6tq/WR+hYiORwD3MUM3XBfTTE
 YcHA==
X-Gm-Message-State: APjAAAWOP0FTBTPZ8lOJtXRAorYV2M1+ON4Zyrg13bXWB5fzvsY0JMUq
 eHJ+5EOCYv8IlTIEOeyIRTD1tO5vsEHSdw==
X-Google-Smtp-Source: APXvYqwKMP44TfJLUtVSGHPB3IPJ9Vl88EhRm6s72Hl1O+B2FiNh+nSrdoQ3OM0tAXU09N/2igxfeQ==
X-Received: by 2002:a19:490d:: with SMTP id w13mr16929343lfa.58.1562143323039; 
 Wed, 03 Jul 2019 01:42:03 -0700 (PDT)
Received: from localhost ([134.17.27.127])
 by smtp.gmail.com with ESMTPSA id v17sm369889ljg.36.2019.07.03.01.42.02
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 03 Jul 2019 01:42:02 -0700 (PDT)
Date: Wed,  3 Jul 2019 01:40:46 -0700
Message-Id: <20190703084048.6980-31-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190703084048.6980-1-palmer@sifive.com>
References: <20190703084048.6980-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.167.67
Subject: [Qemu-devel] [PULL 30/32] hw/riscv: Split out the boot functions
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
Cc: Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Palmer Dabbelt <palmer@sifive.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alistair Francis <alistair.francis@wdc.com>

Split the common RISC-V boot functions into a seperate file. This allows
us to share the common code.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
Tested-by: Bin Meng <bmeng.cn@gmail.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 hw/riscv/Makefile.objs  |  1 +
 hw/riscv/boot.c         | 69 +++++++++++++++++++++++++++++++++++++++++
 hw/riscv/sifive_e.c     | 17 ++--------
 hw/riscv/sifive_u.c     | 17 ++--------
 hw/riscv/spike.c        | 21 +++----------
 hw/riscv/virt.c         | 51 +++---------------------------
 include/hw/riscv/boot.h | 27 ++++++++++++++++
 7 files changed, 110 insertions(+), 93 deletions(-)
 create mode 100644 hw/riscv/boot.c
 create mode 100644 include/hw/riscv/boot.h

diff --git a/hw/riscv/Makefile.objs b/hw/riscv/Makefile.objs
index a65027304a2c..eb9d4f9ffc9e 100644
--- a/hw/riscv/Makefile.objs
+++ b/hw/riscv/Makefile.objs
@@ -1,3 +1,4 @@
+obj-y += boot.o
 obj-$(CONFIG_SPIKE) += riscv_htif.o
 obj-$(CONFIG_HART) += riscv_hart.o
 obj-$(CONFIG_SIFIVE_E) += sifive_e.o
diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
new file mode 100644
index 000000000000..0c8e72e455d7
--- /dev/null
+++ b/hw/riscv/boot.c
@@ -0,0 +1,69 @@
+/*
+ * QEMU RISC-V Boot Helper
+ *
+ * Copyright (c) 2017 SiFive, Inc.
+ * Copyright (c) 2019 Alistair Francis <alistair.francis@wdc.com>
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
+#include "qemu/units.h"
+#include "qemu/error-report.h"
+#include "exec/cpu-defs.h"
+#include "hw/loader.h"
+#include "hw/riscv/boot.h"
+#include "elf.h"
+
+target_ulong riscv_load_kernel(const char *kernel_filename)
+{
+    uint64_t kernel_entry, kernel_high;
+
+    if (load_elf(kernel_filename, NULL, NULL, NULL,
+                 &kernel_entry, NULL, &kernel_high, 0, EM_RISCV, 1, 0) < 0) {
+        error_report("could not load kernel '%s'", kernel_filename);
+        exit(1);
+    }
+
+    return kernel_entry;
+}
+
+hwaddr riscv_load_initrd(const char *filename, uint64_t mem_size,
+                         uint64_t kernel_entry, hwaddr *start)
+{
+    int size;
+
+    /*
+     * We want to put the initrd far enough into RAM that when the
+     * kernel is uncompressed it will not clobber the initrd. However
+     * on boards without much RAM we must ensure that we still leave
+     * enough room for a decent sized initrd, and on boards with large
+     * amounts of RAM we must avoid the initrd being so far up in RAM
+     * that it is outside lowmem and inaccessible to the kernel.
+     * So for boards with less  than 256MB of RAM we put the initrd
+     * halfway into RAM, and for boards with 256MB of RAM or more we put
+     * the initrd at 128MB.
+     */
+    *start = kernel_entry + MIN(mem_size / 2, 128 * MiB);
+
+    size = load_ramdisk(filename, *start, mem_size - *start);
+    if (size == -1) {
+        size = load_image_targphys(filename, *start, mem_size - *start);
+        if (size == -1) {
+            error_report("could not load ramdisk '%s'", filename);
+            exit(1);
+        }
+    }
+
+    return *start + size;
+}
diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
index a5b4086da36d..d27f626529fe 100644
--- a/hw/riscv/sifive_e.c
+++ b/hw/riscv/sifive_e.c
@@ -44,10 +44,10 @@
 #include "hw/riscv/sifive_prci.h"
 #include "hw/riscv/sifive_uart.h"
 #include "hw/riscv/sifive_e.h"
+#include "hw/riscv/boot.h"
 #include "chardev/char.h"
 #include "sysemu/arch_init.h"
 #include "exec/address-spaces.h"
-#include "elf.h"
 
 static const struct MemmapEntry {
     hwaddr base;
@@ -74,19 +74,6 @@ static const struct MemmapEntry {
     [SIFIVE_E_DTIM] =     { 0x80000000,     0x4000 }
 };
 
-static target_ulong load_kernel(const char *kernel_filename)
-{
-    uint64_t kernel_entry, kernel_high;
-
-    if (load_elf(kernel_filename, NULL, NULL, NULL,
-                 &kernel_entry, NULL, &kernel_high,
-                 0, EM_RISCV, 1, 0) < 0) {
-        error_report("could not load kernel '%s'", kernel_filename);
-        exit(1);
-    }
-    return kernel_entry;
-}
-
 static void sifive_mmio_emulate(MemoryRegion *parent, const char *name,
                              uintptr_t offset, uintptr_t length)
 {
@@ -131,7 +118,7 @@ static void riscv_sifive_e_init(MachineState *machine)
                           memmap[SIFIVE_E_MROM].base, &address_space_memory);
 
     if (machine->kernel_filename) {
-        load_kernel(machine->kernel_filename);
+        riscv_load_kernel(machine->kernel_filename);
     }
 }
 
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index a416d5d08b4d..f6b9c12e6094 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -41,11 +41,11 @@
 #include "hw/riscv/sifive_uart.h"
 #include "hw/riscv/sifive_prci.h"
 #include "hw/riscv/sifive_u.h"
+#include "hw/riscv/boot.h"
 #include "chardev/char.h"
 #include "sysemu/arch_init.h"
 #include "sysemu/device_tree.h"
 #include "exec/address-spaces.h"
-#include "elf.h"
 
 #include <libfdt.h>
 
@@ -65,19 +65,6 @@ static const struct MemmapEntry {
 
 #define GEM_REVISION        0x10070109
 
-static target_ulong load_kernel(const char *kernel_filename)
-{
-    uint64_t kernel_entry, kernel_high;
-
-    if (load_elf(kernel_filename, NULL, NULL, NULL,
-                 &kernel_entry, NULL, &kernel_high,
-                 0, EM_RISCV, 1, 0) < 0) {
-        error_report("could not load kernel '%s'", kernel_filename);
-        exit(1);
-    }
-    return kernel_entry;
-}
-
 static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
     uint64_t mem_size, const char *cmdline)
 {
@@ -283,7 +270,7 @@ static void riscv_sifive_u_init(MachineState *machine)
     create_fdt(s, memmap, machine->ram_size, machine->kernel_cmdline);
 
     if (machine->kernel_filename) {
-        load_kernel(machine->kernel_filename);
+        riscv_load_kernel(machine->kernel_filename);
     }
 
     /* reset vector */
diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index 5b33d4be3bbc..e68be00a5fe8 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -36,12 +36,12 @@
 #include "hw/riscv/riscv_hart.h"
 #include "hw/riscv/sifive_clint.h"
 #include "hw/riscv/spike.h"
+#include "hw/riscv/boot.h"
 #include "chardev/char.h"
 #include "sysemu/arch_init.h"
 #include "sysemu/device_tree.h"
 #include "sysemu/qtest.h"
 #include "exec/address-spaces.h"
-#include "elf.h"
 
 #include <libfdt.h>
 
@@ -54,19 +54,6 @@ static const struct MemmapEntry {
     [SPIKE_DRAM] =     { 0x80000000,        0x0 },
 };
 
-static target_ulong load_kernel(const char *kernel_filename)
-{
-    uint64_t kernel_entry, kernel_high;
-
-    if (load_elf_ram_sym(kernel_filename, NULL, NULL, NULL,
-            &kernel_entry, NULL, &kernel_high, 0, EM_RISCV, 1, 0,
-            NULL, true, htif_symbol_callback) < 0) {
-        error_report("could not load kernel '%s'", kernel_filename);
-        exit(1);
-    }
-    return kernel_entry;
-}
-
 static void create_fdt(SpikeState *s, const struct MemmapEntry *memmap,
     uint64_t mem_size, const char *cmdline)
 {
@@ -199,7 +186,7 @@ static void spike_board_init(MachineState *machine)
                                 mask_rom);
 
     if (machine->kernel_filename) {
-        load_kernel(machine->kernel_filename);
+        riscv_load_kernel(machine->kernel_filename);
     }
 
     /* reset vector */
@@ -287,7 +274,7 @@ static void spike_v1_10_0_board_init(MachineState *machine)
                                 mask_rom);
 
     if (machine->kernel_filename) {
-        load_kernel(machine->kernel_filename);
+        riscv_load_kernel(machine->kernel_filename);
     }
 
     /* reset vector */
@@ -372,7 +359,7 @@ static void spike_v1_09_1_board_init(MachineState *machine)
                                 mask_rom);
 
     if (machine->kernel_filename) {
-        load_kernel(machine->kernel_filename);
+        riscv_load_kernel(machine->kernel_filename);
     }
 
     /* reset vector */
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 28d96daf8c5b..485aefa99523 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -34,13 +34,13 @@
 #include "hw/riscv/sifive_clint.h"
 #include "hw/riscv/sifive_test.h"
 #include "hw/riscv/virt.h"
+#include "hw/riscv/boot.h"
 #include "chardev/char.h"
 #include "sysemu/arch_init.h"
 #include "sysemu/device_tree.h"
 #include "exec/address-spaces.h"
 #include "hw/pci/pci.h"
 #include "hw/pci-host/gpex.h"
-#include "elf.h"
 
 #include <libfdt.h>
 
@@ -61,47 +61,6 @@ static const struct MemmapEntry {
     [VIRT_PCIE_ECAM] =   { 0x30000000,    0x10000000 },
 };
 
-static target_ulong load_kernel(const char *kernel_filename)
-{
-    uint64_t kernel_entry, kernel_high;
-
-    if (load_elf(kernel_filename, NULL, NULL, NULL,
-                 &kernel_entry, NULL, &kernel_high,
-                 0, EM_RISCV, 1, 0) < 0) {
-        error_report("could not load kernel '%s'", kernel_filename);
-        exit(1);
-    }
-    return kernel_entry;
-}
-
-static hwaddr load_initrd(const char *filename, uint64_t mem_size,
-                          uint64_t kernel_entry, hwaddr *start)
-{
-    int size;
-
-    /* We want to put the initrd far enough into RAM that when the
-     * kernel is uncompressed it will not clobber the initrd. However
-     * on boards without much RAM we must ensure that we still leave
-     * enough room for a decent sized initrd, and on boards with large
-     * amounts of RAM we must avoid the initrd being so far up in RAM
-     * that it is outside lowmem and inaccessible to the kernel.
-     * So for boards with less  than 256MB of RAM we put the initrd
-     * halfway into RAM, and for boards with 256MB of RAM or more we put
-     * the initrd at 128MB.
-     */
-    *start = kernel_entry + MIN(mem_size / 2, 128 * MiB);
-
-    size = load_ramdisk(filename, *start, mem_size - *start);
-    if (size == -1) {
-        size = load_image_targphys(filename, *start, mem_size - *start);
-        if (size == -1) {
-            error_report("could not load ramdisk '%s'", filename);
-            exit(1);
-        }
-    }
-    return *start + size;
-}
-
 static void create_pcie_irq_map(void *fdt, char *nodename,
                                 uint32_t plic_phandle)
 {
@@ -440,13 +399,13 @@ static void riscv_virt_board_init(MachineState *machine)
                                 mask_rom);
 
     if (machine->kernel_filename) {
-        uint64_t kernel_entry = load_kernel(machine->kernel_filename);
+        uint64_t kernel_entry = riscv_load_kernel(machine->kernel_filename);
 
         if (machine->initrd_filename) {
             hwaddr start;
-            hwaddr end = load_initrd(machine->initrd_filename,
-                                     machine->ram_size, kernel_entry,
-                                     &start);
+            hwaddr end = riscv_load_initrd(machine->initrd_filename,
+                                           machine->ram_size, kernel_entry,
+                                           &start);
             qemu_fdt_setprop_cell(fdt, "/chosen",
                                   "linux,initrd-start", start);
             qemu_fdt_setprop_cell(fdt, "/chosen", "linux,initrd-end",
diff --git a/include/hw/riscv/boot.h b/include/hw/riscv/boot.h
new file mode 100644
index 000000000000..f84fd6c2df5e
--- /dev/null
+++ b/include/hw/riscv/boot.h
@@ -0,0 +1,27 @@
+/*
+ * QEMU RISC-V Boot Helper
+ *
+ * Copyright (c) 2017 SiFive, Inc.
+ * Copyright (c) 2019 Alistair Francis <alistair.francis@wdc.com>
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
+#ifndef RISCV_BOOT_H
+#define RISCV_BOOT_H
+
+target_ulong riscv_load_kernel(const char *kernel_filename);
+hwaddr riscv_load_initrd(const char *filename, uint64_t mem_size,
+                         uint64_t kernel_entry, hwaddr *start);
+
+#endif /* RISCV_BOOT_H */
-- 
2.21.0



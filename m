Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A861C31E5B
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 00:53:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 280C920863
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 00:53:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="J9pfJe1E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 280C920863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34352 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdOqp-0001Ce-Fp
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 20:53:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48430)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <prvs=066539cd8=alistair.francis@wdc.com>)
 id 1hdOox-0007iJ-CO
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 20:51:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=066539cd8=alistair.francis@wdc.com>)
 id 1hdOf2-0003ZS-63
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 20:41:14 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:29342)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=066539cd8=alistair.francis@wdc.com>)
 id 1hdOf1-0003Y4-S9; Tue, 18 Jun 2019 20:41:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1560904872; x=1592440872;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=gPn0VXQeyWsEn1cr/JyvIlrvIC+AFRrBK70ZUfnNR/c=;
 b=J9pfJe1Ez3FWkac/KE+zOXy14s1I3s709DBBcPC9MhF682tiQPmu9G2t
 ZOUpGLcIF5S5z6OMWuM9hc7oDrqlQsCtISisKoQub+vDgn89EFjMj3eu8
 f9lXpQG04aPXXX5uJ6ODwLrMQhPVWyX476rPGJrW1VVIFsTf1hWQGM0ui
 DkDosaMELldlq5lJtRFZRRbcsPLTadI3AgXgeqsO37gp0b4I7G8l9od5f
 UHfGIFLle1xk2YtneMyxN+1NZoR8utfZl+n4jhjwfe1nVoEMlPKJDhFaL
 RUp5lTnl0KntSlRBiUPe1MBPuC2/3JUK1AOK8aZBzIFiL6Yc629UZgLwu w==;
X-IronPort-AV: E=Sophos;i="5.63,390,1557158400"; d="scan'208";a="110901043"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 19 Jun 2019 08:41:09 +0800
IronPort-SDR: Bk5g1UYzk4sZBUn2Ch482QMc4U5CRUZi6T2Su9euv1pGS8STZvjO6TfHa9ir3fj0RRfAcWetId
 P4zz+jDujiew4z0UI5eUm4AHGBd35mfseCX7DWiAZ8HgDs1ZhQoPFXXq/YLeu6kfGmMsdXuLvZ
 0N2hhMb9/riIdqVzBz5DOvXXqreGBhZAnDqFXFkIfkOEirV4TKQBWS04pp0GifWVPeLrpvQHUB
 kQ2SWdni2RO6sCYDkAxqGa4Ea9F3HCYz8rFuf33YAtZOVjBx1EiIZtoHkD0QyBejhBRVmyNMI7
 6dD2UjCHVxk8qNhYVTRL/nSZ
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP; 18 Jun 2019 17:40:37 -0700
IronPort-SDR: yGZZ2XR/DQ9ZtWZppazB6GTTbWanSWsjaQVx/R7onN82PmAemZEFzJmtihaB3rRE5jgGxkajYc
 d2TKvoaT6dE9xB0kFA366PvxxqydddzGqvoH80oF/kF8iKgMZszeG6rEcvCtgtqTqamx3CC6N6
 1ue6OlCEyP9fgZDs4FtN3dkjO28s9DxiJW4YTJwY5l3yjAOXVBgdIgCpxhKt03nCidpIXA9J4t
 GGhwJ3CxXSEUg22o85FSffheOWaPPpp444W7vy2Ynq1h6tUxMlYFM9CM5JcMSL64k1SUVkuBIO
 5v0=
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.140])
 by uls-op-cesaip02.wdc.com with ESMTP; 18 Jun 2019 17:41:08 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Date: Tue, 18 Jun 2019 17:38:47 -0700
Message-Id: <b511243b947debd710ea225699a4d7e312568da8.1560904640.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1560904640.git.alistair.francis@wdc.com>
References: <cover.1560904640.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 216.71.154.42
Subject: [Qemu-devel] [RFC v1 1/5] hw/riscv: Split out the boot functions
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
Cc: alistair23@gmail.com, palmer@sifive.com, alistair.francis@wdc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Split the common RISC-V boot functions into a seperate file. This allows
us to share the common code.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
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
index a65027304a..eb9d4f9ffc 100644
--- a/hw/riscv/Makefile.objs
+++ b/hw/riscv/Makefile.objs
@@ -1,3 +1,4 @@
+obj-y += boot.o
 obj-$(CONFIG_SPIKE) += riscv_htif.o
 obj-$(CONFIG_HART) += riscv_hart.o
 obj-$(CONFIG_SIFIVE_E) += sifive_e.o
diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
new file mode 100644
index 0000000000..62f94aaf8a
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
+                 &kernel_entry, NULL, &kernel_high,
+                 0, EM_RISCV, 1, 0) < 0) {
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
+    /* We want to put the initrd far enough into RAM that when the
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
index 80ac56fa7d..9d58ae362b 100644
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
index 5ecc47cea3..1b9281bd4a 100644
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
@@ -280,7 +267,7 @@ static void riscv_sifive_u_init(MachineState *machine)
     create_fdt(s, memmap, machine->ram_size, machine->kernel_cmdline);
 
     if (machine->kernel_filename) {
-        load_kernel(machine->kernel_filename);
+        riscv_load_kernel(machine->kernel_filename);
     }
 
     /* reset vector */
diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index 5b33d4be3b..e68be00a5f 100644
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
index 84d94d0c42..5f8c11471b 100644
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
@@ -422,13 +381,13 @@ static void riscv_virt_board_init(MachineState *machine)
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
index 0000000000..f84fd6c2df
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
2.22.0



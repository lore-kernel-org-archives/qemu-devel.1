Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5881C43613
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 22:23:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 707B5215EA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 22:23:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 707B5215EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42300 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdiyu-0003Ky-Ng
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 18:23:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35960)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <laurent@vivier.eu>) id 1hdiwp-0001em-Lw
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 18:20:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1hdiwn-0007hh-6A
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 18:20:55 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:43695)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1hdiwm-0007eZ-Q8; Wed, 19 Jun 2019 18:20:53 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1M5PyX-1hf5qZ36bF-001O2j; Thu, 20 Jun 2019 00:20:03 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Thu, 20 Jun 2019 00:19:33 +0200
Message-Id: <20190619221933.1981-11-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190619221933.1981-1-laurent@vivier.eu>
References: <20190619221933.1981-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:No/fqpF9v4hDpNCLU7PHkIbyIPvUbxKVP+5PRi4Pr1T/F+cP4PA
 eBV1JirIyWFQ+NtCx7vUBXuFa6Y32gNaEvjaB6xc7YD0YaIDeSYAVOvt3lkaC1Iad9u5KsN
 tXY6bxDsXx+AG/oQTJnd7XlwzyNi8r2bPlCytyOSyOugf8CoX3RKBxeSye3EpaE2BYB81Cu
 MLDUNjTXCuph+hCJJiQdQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:X0uZW6F1Y6U=:PLcSX3592P8N5h1Oti21/8
 TjxPripXRy2tbuPaw3JqBhcF+oK5tJyxFtBkToQvc0HoewoM7FIBkWBNoYWv+IqVB9BtsFB3N
 8fu7keR1t0DRZKqKX4clEM3kL9wuCARvFF7gNPzAXK/D8Zo8kApVjxRPxnmZsDHStAGNDXScq
 gXVfxFps8izEgdOtq74LfyUbhBSDs/mClYSsJbLEG98nc8z9PBbyi3boL+JBx4kF/xRBioBkq
 JTsKNFnAWmX+iz5/8WO7guBjRWEtcZQ/MAYdf0zNCPpGzXzjznrT1OXUrdiJWF0Omq1GyfT4E
 vs3KYV54DZ78ow3CYGs1+FRaFrK03zLIWRgyXxig1mbM5MVyyt80x2uZ63fo83ykLUwEG4gu3
 dMz0Uxrvl8q012eNn7nwY5iZwYu6hftg5ygp8DjHSWJFk7f6KMrE1DsHhW4m8NIfhata/rH5S
 qtqNyt5EbkxbKNP80h137XbA7qY7ThetqNUv3Msxa9B5fTyWkjm/5+y6q8m1HDO2VmCpfA3GO
 r+0O7IvEE1VdY7flaEB5jb5TZd7Jh5Q2qYFFvd3cGjgBLv94Ee6V1OFvG4o5ZKjNgU/+3Wz4U
 Kvd6DVVir8J5PmAoqDW30s3lKhswl1e4AXVb2+46K0nWl5mDB92XJOqL6fIvCbwsVjnimVKcq
 yFbsJe+FFwkX+x/K4JKaegbvwtIV8BvKAMr+AjkfGov1LlcR8VkzN3AoEjIjVo7eQpEZnjoZR
 EO6x5QDEsX87lCCglgk1NeSomkEnt+WImHyTdg==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.130
Subject: [Qemu-devel] [PATCH v8 10/10] hw/m68k: define Macintosh Quadra 800
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Thomas Huth <huth@tuxfamily.org>,
 Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If you want to test the machine, it doesn't yet boot a MacROM, but you can
boot a linux kernel from the command line.

You can install your own disk using debian-installer with:

    ./qemu-system-m68k \
    -M q800 \
    -serial none -serial mon:stdio \
    -m 1000M -drive file=m68k.qcow2,format=qcow2 \
    -net nic,model=dp83932,addr=09:00:07:12:34:57 \
    -append "console=ttyS0 vga=off" \
    -kernel vmlinux-4.15.0-2-m68k \
    -initrd initrd.gz \
    -drive file=debian-9.0-m68k-NETINST-1.iso \
    -drive file=m68k.qcow2,format=qcow2 \
    -nographic

If you use a graphic adapter instead of "-nographic", you can use "-g" to set the
size of the display (I use "-g 1600x800x24").

Co-developed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 MAINTAINERS                      |  14 ++
 default-configs/m68k-softmmu.mak |   1 +
 hw/m68k/Kconfig                  |  12 +
 hw/m68k/Makefile.objs            |   1 +
 hw/m68k/bootinfo.h               | 114 ++++++++++
 hw/m68k/q800.c                   | 377 +++++++++++++++++++++++++++++++
 6 files changed, 519 insertions(+)
 create mode 100644 hw/m68k/bootinfo.h
 create mode 100644 hw/m68k/q800.c

diff --git a/MAINTAINERS b/MAINTAINERS
index d32c5c2313..aa00525d37 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -902,6 +902,20 @@ F: hw/char/mcf_uart.c
 F: hw/net/mcf_fec.c
 F: include/hw/m68k/mcf*.h
 
+q800
+M: Laurent Vivier <laurent@vivier.eu>
+S: Maintained
+F: hw/block/swim.c
+F: hw/m68k/bootinfo.h
+F: hw/display/macfb.c
+F: hw/m68k/q800.c
+F: hw/misc/mac_via.c
+F: hw/nubus/*
+F: include/hw/block/swim.h
+F: include/hw/display/macfb.h
+F: include/hw/misc/mac_via.h
+F: include/hw/nubus/*
+
 MicroBlaze Machines
 -------------------
 petalogix_s3adsp1800
diff --git a/default-configs/m68k-softmmu.mak b/default-configs/m68k-softmmu.mak
index 4049a8f2ba..0fbae017ca 100644
--- a/default-configs/m68k-softmmu.mak
+++ b/default-configs/m68k-softmmu.mak
@@ -6,3 +6,4 @@ CONFIG_SEMIHOSTING=y
 #
 CONFIG_AN5206=y
 CONFIG_MCF5208=y
+CONFIG_Q800=y
diff --git a/hw/m68k/Kconfig b/hw/m68k/Kconfig
index 49ef0b3f6d..ffa8e48fd8 100644
--- a/hw/m68k/Kconfig
+++ b/hw/m68k/Kconfig
@@ -7,3 +7,15 @@ config MCF5208
     bool
     select COLDFIRE
     select PTIMER
+
+config Q800
+    bool
+    select FRAMEBUFFER
+    select ADB
+    select MAC_VIA
+    select ESCC
+    select ESP
+    select MACFB
+    select NUBUS
+    select DP8393X
+    select SWIM
diff --git a/hw/m68k/Makefile.objs b/hw/m68k/Makefile.objs
index 482f8477b4..cfd13fae53 100644
--- a/hw/m68k/Makefile.objs
+++ b/hw/m68k/Makefile.objs
@@ -1,2 +1,3 @@
 obj-$(CONFIG_AN5206) += an5206.o mcf5206.o
 obj-$(CONFIG_MCF5208) += mcf5208.o mcf_intc.o
+obj-$(CONFIG_Q800) += q800.o
diff --git a/hw/m68k/bootinfo.h b/hw/m68k/bootinfo.h
new file mode 100644
index 0000000000..5f8ded2686
--- /dev/null
+++ b/hw/m68k/bootinfo.h
@@ -0,0 +1,114 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note
+ *
+ * Bootinfo tags from linux bootinfo.h and bootinfo-mac.h:
+ * This is an easily parsable and extendable structure containing all
+ * information to be passed from the bootstrap to the kernel
+ *
+ * This structure is copied right after the kernel by the bootstrap
+ * routine.
+ */
+
+#ifndef HW_M68K_BOOTINFO_H
+#define HW_M68K_BOOTINFO_H
+struct bi_record {
+    uint16_t tag;        /* tag ID */
+    uint16_t size;       /* size of record */
+    uint32_t data[0];    /* data */
+};
+
+/* machine independent tags */
+
+#define BI_LAST         0x0000 /* last record */
+#define BI_MACHTYPE     0x0001 /* machine type (u_long) */
+#define BI_CPUTYPE      0x0002 /* cpu type (u_long) */
+#define BI_FPUTYPE      0x0003 /* fpu type (u_long) */
+#define BI_MMUTYPE      0x0004 /* mmu type (u_long) */
+#define BI_MEMCHUNK     0x0005 /* memory chunk address and size */
+                               /* (struct mem_info) */
+#define BI_RAMDISK      0x0006 /* ramdisk address and size */
+                               /* (struct mem_info) */
+#define BI_COMMAND_LINE 0x0007 /* kernel command line parameters */
+                               /* (string) */
+
+/*  Macintosh-specific tags (all u_long) */
+
+#define BI_MAC_MODEL    0x8000  /* Mac Gestalt ID (model type) */
+#define BI_MAC_VADDR    0x8001  /* Mac video base address */
+#define BI_MAC_VDEPTH   0x8002  /* Mac video depth */
+#define BI_MAC_VROW     0x8003  /* Mac video rowbytes */
+#define BI_MAC_VDIM     0x8004  /* Mac video dimensions */
+#define BI_MAC_VLOGICAL 0x8005  /* Mac video logical base */
+#define BI_MAC_SCCBASE  0x8006  /* Mac SCC base address */
+#define BI_MAC_BTIME    0x8007  /* Mac boot time */
+#define BI_MAC_GMTBIAS  0x8008  /* Mac GMT timezone offset */
+#define BI_MAC_MEMSIZE  0x8009  /* Mac RAM size (sanity check) */
+#define BI_MAC_CPUID    0x800a  /* Mac CPU type (sanity check) */
+#define BI_MAC_ROMBASE  0x800b  /* Mac system ROM base address */
+
+/*  Macintosh hardware profile data */
+
+#define BI_MAC_VIA1BASE 0x8010  /* Mac VIA1 base address (always present) */
+#define BI_MAC_VIA2BASE 0x8011  /* Mac VIA2 base address (type varies) */
+#define BI_MAC_VIA2TYPE 0x8012  /* Mac VIA2 type (VIA, RBV, OSS) */
+#define BI_MAC_ADBTYPE  0x8013  /* Mac ADB interface type */
+#define BI_MAC_ASCBASE  0x8014  /* Mac Apple Sound Chip base address */
+#define BI_MAC_SCSI5380 0x8015  /* Mac NCR 5380 SCSI (base address, multi) */
+#define BI_MAC_SCSIDMA  0x8016  /* Mac SCSI DMA (base address) */
+#define BI_MAC_SCSI5396 0x8017  /* Mac NCR 53C96 SCSI (base address, multi) */
+#define BI_MAC_IDETYPE  0x8018  /* Mac IDE interface type */
+#define BI_MAC_IDEBASE  0x8019  /* Mac IDE interface base address */
+#define BI_MAC_NUBUS    0x801a  /* Mac Nubus type (none, regular, pseudo) */
+#define BI_MAC_SLOTMASK 0x801b  /* Mac Nubus slots present */
+#define BI_MAC_SCCTYPE  0x801c  /* Mac SCC serial type (normal, IOP) */
+#define BI_MAC_ETHTYPE  0x801d  /* Mac builtin ethernet type (Sonic, MACE */
+#define BI_MAC_ETHBASE  0x801e  /* Mac builtin ethernet base address */
+#define BI_MAC_PMU      0x801f  /* Mac power management / poweroff hardware */
+#define BI_MAC_IOP_SWIM 0x8020  /* Mac SWIM floppy IOP */
+#define BI_MAC_IOP_ADB  0x8021  /* Mac ADB IOP */
+
+#define BOOTINFO0(as, base, id) \
+    do { \
+        stw_phys(as, base, id); \
+        base += 2; \
+        stw_phys(as, base, sizeof(struct bi_record)); \
+        base += 2; \
+    } while (0)
+
+#define BOOTINFO1(as, base, id, value) \
+    do { \
+        stw_phys(as, base, id); \
+        base += 2; \
+        stw_phys(as, base, sizeof(struct bi_record) + 4); \
+        base += 2; \
+        stl_phys(as, base, value); \
+        base += 4; \
+    } while (0)
+
+#define BOOTINFO2(as, base, id, value1, value2) \
+    do { \
+        stw_phys(as, base, id); \
+        base += 2; \
+        stw_phys(as, base, sizeof(struct bi_record) + 8); \
+        base += 2; \
+        stl_phys(as, base, value1); \
+        base += 4; \
+        stl_phys(as, base, value2); \
+        base += 4; \
+    } while (0)
+
+#define BOOTINFOSTR(as, base, id, string) \
+    do { \
+        int i; \
+        stw_phys(as, base, id); \
+        base += 2; \
+        stw_phys(as, base, \
+                 (sizeof(struct bi_record) + strlen(string) + 2) & ~1); \
+        base += 2; \
+        for (i = 0; string[i]; i++) { \
+            stb_phys(as, base++, string[i]); \
+        } \
+        stb_phys(as, base++, 0); \
+        base = (parameters_base + 1) & ~1; \
+    } while (0)
+#endif
diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
new file mode 100644
index 0000000000..ca37fb7d31
--- /dev/null
+++ b/hw/m68k/q800.c
@@ -0,0 +1,377 @@
+/*
+ * QEMU Motorla 680x0 Macintosh hardware System Emulator
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+#include "sysemu/sysemu.h"
+#include "cpu.h"
+#include "hw/hw.h"
+#include "hw/boards.h"
+#include "elf.h"
+#include "hw/loader.h"
+#include "ui/console.h"
+#include "exec/address-spaces.h"
+#include "hw/char/escc.h"
+#include "hw/sysbus.h"
+#include "hw/scsi/esp.h"
+#include "bootinfo.h"
+#include "hw/misc/mac_via.h"
+#include "hw/input/adb.h"
+#include "hw/nubus/mac-nubus-bridge.h"
+#include "hw/display/macfb.h"
+#include "hw/block/swim.h"
+#include "net/net.h"
+#include "qapi/error.h"
+#include "sysemu/qtest.h"
+
+#define MACROM_ADDR     0x40000000
+#define MACROM_SIZE     0x00100000
+
+#define MACROM_FILENAME "MacROM.bin"
+
+#define Q800_MACHINE_ID 35
+#define Q800_CPU_ID (1 << 2)
+#define Q800_FPU_ID (1 << 2)
+#define Q800_MMU_ID (1 << 2)
+
+#define MACH_MAC        3
+#define Q800_MAC_CPU_ID 2
+
+#define VIA_BASE              0x50f00000
+#define SONIC_PROM_BASE       0x50f08000
+#define SONIC_BASE            0x50f0a000
+#define SCC_BASE              0x50f0c020
+#define ESP_BASE              0x50f10000
+#define ESP_PDMA              0x50f10100
+#define ASC_BASE              0x50F14000
+#define SWIM_BASE             0x50F1E000
+#define NUBUS_SUPER_SLOT_BASE 0x60000000
+#define NUBUS_SLOT_BASE       0xf0000000
+
+/* the video base, whereas it a Nubus address,
+ * is needed by the kernel to have early display and
+ * thus provided by the bootloader
+ */
+#define VIDEO_BASE            0xf9001000
+
+#define MAC_CLOCK  3686418
+
+/*
+ * The GLUE (General Logic Unit) is an Apple custom integrated circuit chip
+ * that performs a variety of functions (RAM management, clock generation, ...).
+ * The GLUE chip receives interrupt requests from various devices,
+ * assign priority to each, and asserts one or more interrupt line to the
+ * CPU.
+ */
+
+typedef struct {
+    M68kCPU *cpu;
+    uint8_t ipr;
+} GLUEState;
+
+static void GLUE_set_irq(void *opaque, int irq, int level)
+{
+    GLUEState *s = opaque;
+    int i;
+
+    if (level) {
+        s->ipr |= 1 << irq;
+    } else {
+        s->ipr &= ~(1 << irq);
+    }
+
+    for (i = 7; i >= 0; i--) {
+        if ((s->ipr >> i) & 1) {
+            m68k_set_irq_level(s->cpu, i + 1, i + 25);
+            return;
+        }
+    }
+    m68k_set_irq_level(s->cpu, 0, 0);
+}
+
+static void main_cpu_reset(void *opaque)
+{
+    M68kCPU *cpu = opaque;
+    CPUState *cs = CPU(cpu);
+
+    cpu_reset(cs);
+    cpu->env.aregs[7] = ldl_phys(cs->as, 0);
+    cpu->env.pc = ldl_phys(cs->as, 4);
+}
+
+static void q800_init(MachineState *machine)
+{
+    M68kCPU *cpu = NULL;
+    int linux_boot;
+    int32_t kernel_size;
+    uint64_t elf_entry;
+    char *filename;
+    int bios_size;
+    ram_addr_t initrd_base;
+    int32_t initrd_size;
+    MemoryRegion *rom;
+    MemoryRegion *ram;
+    ram_addr_t ram_size = machine->ram_size;
+    const char *kernel_filename = machine->kernel_filename;
+    const char *initrd_filename = machine->initrd_filename;
+    const char *kernel_cmdline = machine->kernel_cmdline;
+    hwaddr parameters_base;
+    CPUState *cs;
+    DeviceState *dev;
+    DeviceState *via_dev;
+    SysBusESPState *sysbus_esp;
+    ESPState *esp;
+    SysBusDevice *sysbus;
+    BusState *adb_bus;
+    NubusBus *nubus;
+    GLUEState *irq;
+    qemu_irq *pic;
+
+    linux_boot = (kernel_filename != NULL);
+
+    /* init CPUs */
+    cpu = M68K_CPU(cpu_create(machine->cpu_type));
+    qemu_register_reset(main_cpu_reset, cpu);
+
+    ram = g_malloc(sizeof(*ram));
+    memory_region_init_ram(ram, NULL, "m68k_mac.ram", ram_size, &error_abort);
+    memory_region_add_subregion(get_system_memory(), 0, ram);
+
+    /* IRQ Glue */
+
+    irq = g_new0(GLUEState, 1);
+    irq->cpu = cpu;
+    pic = qemu_allocate_irqs(GLUE_set_irq, irq, 8);
+
+    /* VIA */
+
+    via_dev = qdev_create(NULL, TYPE_MAC_VIA);
+    qdev_init_nofail(via_dev);
+    sysbus = SYS_BUS_DEVICE(via_dev);
+    sysbus_mmio_map(sysbus, 0, VIA_BASE);
+    qdev_connect_gpio_out_named(DEVICE(sysbus), "irq", 0, pic[0]);
+    qdev_connect_gpio_out_named(DEVICE(sysbus), "irq", 1, pic[1]);
+
+
+    adb_bus = qdev_get_child_bus(via_dev, "adb.0");
+    dev = qdev_create(adb_bus, TYPE_ADB_KEYBOARD);
+    qdev_init_nofail(dev);
+    dev = qdev_create(adb_bus, TYPE_ADB_MOUSE);
+    qdev_init_nofail(dev);
+
+    /* MACSONIC */
+
+    if (nb_nics > 1) {
+        error_report("q800 can only have one ethernet interface");
+        exit(1);
+    }
+
+    qemu_check_nic_model(&nd_table[0], "dp83932");
+
+    /* MacSonic driver needs an Apple MAC address
+     * Valid prefix are:
+     * 00:05:02 Apple
+     * 00:80:19 Dayna Communications, Inc.
+     * 00:A0:40 Apple
+     * 08:00:07 Apple
+     * (Q800 use the last one)
+     */
+    nd_table[0].macaddr.a[0] = 0x08;
+    nd_table[0].macaddr.a[1] = 0x00;
+    nd_table[0].macaddr.a[2] = 0x07;
+
+    dev = qdev_create(NULL, "dp8393x");
+    qdev_set_nic_properties(dev, &nd_table[0]);
+    qdev_prop_set_uint8(dev, "it_shift", 2);
+    qdev_prop_set_bit(dev, "big_endian", true);
+    qdev_prop_set_ptr(dev, "dma_mr", get_system_memory());
+    qdev_init_nofail(dev);
+    sysbus = SYS_BUS_DEVICE(dev);
+    sysbus_mmio_map(sysbus, 0, SONIC_BASE);
+    sysbus_mmio_map(sysbus, 1, SONIC_PROM_BASE);
+    sysbus_connect_irq(sysbus, 0, pic[2]);
+
+    /* SCC */
+
+    dev = qdev_create(NULL, TYPE_ESCC);
+    qdev_prop_set_uint32(dev, "disabled", 0);
+    qdev_prop_set_uint32(dev, "frequency", MAC_CLOCK);
+    qdev_prop_set_uint32(dev, "it_shift", 1);
+    qdev_prop_set_bit(dev, "bit_swap", true);
+    qdev_prop_set_chr(dev, "chrA", serial_hd(0));
+    qdev_prop_set_chr(dev, "chrB", serial_hd(1));
+    qdev_prop_set_uint32(dev, "chnBtype", 0);
+    qdev_prop_set_uint32(dev, "chnAtype", 0);
+    qdev_init_nofail(dev);
+    sysbus = SYS_BUS_DEVICE(dev);
+    sysbus_connect_irq(sysbus, 0, pic[3]);
+    sysbus_connect_irq(sysbus, 1, pic[3]);
+    sysbus_mmio_map(sysbus, 0, SCC_BASE);
+
+    /* SCSI */
+
+    dev = qdev_create(NULL, TYPE_ESP);
+    sysbus_esp = ESP_STATE(dev);
+    esp = &sysbus_esp->esp;
+    esp->dma_memory_read = NULL;
+    esp->dma_memory_write = NULL;
+    esp->dma_opaque = NULL;
+    sysbus_esp->it_shift = 4;
+    esp->dma_enabled = 1;
+    qdev_init_nofail(dev);
+
+    sysbus = SYS_BUS_DEVICE(dev);
+    sysbus_connect_irq(sysbus, 0, qdev_get_gpio_in_named(via_dev,
+                                                         "via2-irq",
+                                                         VIA2_IRQ_SCSI_BIT));
+    sysbus_connect_irq(sysbus, 1,
+                       qdev_get_gpio_in_named(via_dev, "via2-irq",
+                                              VIA2_IRQ_SCSI_DATA_BIT));
+    sysbus_mmio_map(sysbus, 0, ESP_BASE);
+    sysbus_mmio_map(sysbus, 1, ESP_PDMA);
+
+    scsi_bus_legacy_handle_cmdline(&esp->bus);
+
+    /* SWIM floppy controller */
+
+    dev = qdev_create(NULL, TYPE_SWIM);
+    qdev_init_nofail(dev);
+    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, SWIM_BASE);
+
+    /* NuBus */
+
+    dev = qdev_create(NULL, TYPE_MAC_NUBUS_BRIDGE);
+    qdev_init_nofail(dev);
+    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, NUBUS_SUPER_SLOT_BASE);
+    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 1, NUBUS_SLOT_BASE);
+
+    nubus = MAC_NUBUS_BRIDGE(dev)->bus;
+
+    /* framebuffer in nubus slot #9 */
+
+    dev = qdev_create(BUS(nubus), TYPE_NUBUS_MACFB);
+    qdev_prop_set_uint32(dev, "width", graphic_width);
+    qdev_prop_set_uint32(dev, "height", graphic_height);
+    qdev_prop_set_uint8(dev, "depth", graphic_depth);
+    qdev_init_nofail(dev);
+
+    cs = CPU(cpu);
+    if (linux_boot) {
+        uint64_t high;
+        kernel_size = load_elf(kernel_filename, NULL, NULL, NULL,
+                               &elf_entry, NULL, &high, 1,
+                               EM_68K, 0, 0);
+        if (kernel_size < 0) {
+            error_report("could not load kernel '%s'", kernel_filename);
+            exit(1);
+        }
+        stl_phys(cs->as, 4, elf_entry); /* reset initial PC */
+        parameters_base = (high + 1) & ~1;
+
+        BOOTINFO1(cs->as, parameters_base, BI_MACHTYPE, MACH_MAC);
+        BOOTINFO1(cs->as, parameters_base, BI_FPUTYPE, Q800_FPU_ID);
+        BOOTINFO1(cs->as, parameters_base, BI_MMUTYPE, Q800_MMU_ID);
+        BOOTINFO1(cs->as, parameters_base, BI_CPUTYPE, Q800_CPU_ID);
+        BOOTINFO1(cs->as, parameters_base, BI_MAC_CPUID, Q800_MAC_CPU_ID);
+        BOOTINFO1(cs->as, parameters_base, BI_MAC_MODEL, Q800_MACHINE_ID);
+        BOOTINFO1(cs->as, parameters_base,
+                  BI_MAC_MEMSIZE, ram_size >> 20); /* in MB */
+        BOOTINFO2(cs->as, parameters_base, BI_MEMCHUNK, 0, ram_size);
+        BOOTINFO1(cs->as, parameters_base, BI_MAC_VADDR, VIDEO_BASE);
+        BOOTINFO1(cs->as, parameters_base, BI_MAC_VDEPTH, graphic_depth);
+        BOOTINFO1(cs->as, parameters_base, BI_MAC_VDIM,
+                  (graphic_height << 16) | graphic_width);
+        BOOTINFO1(cs->as, parameters_base, BI_MAC_VROW,
+                  (graphic_width * graphic_depth + 7) / 8);
+        BOOTINFO1(cs->as, parameters_base, BI_MAC_SCCBASE, SCC_BASE);
+
+        if (kernel_cmdline) {
+            BOOTINFOSTR(cs->as, parameters_base, BI_COMMAND_LINE,
+                        kernel_cmdline);
+        }
+
+        /* load initrd */
+        if (initrd_filename) {
+            initrd_size = get_image_size(initrd_filename);
+            if (initrd_size < 0) {
+                error_report("could not load initial ram disk '%s'",
+                             initrd_filename);
+                exit(1);
+            }
+
+            initrd_base = (ram_size - initrd_size) & TARGET_PAGE_MASK;
+            load_image_targphys(initrd_filename, initrd_base,
+                                ram_size - initrd_base);
+            BOOTINFO2(cs->as, parameters_base, BI_RAMDISK, initrd_base,
+                      initrd_size);
+        } else {
+            initrd_base = 0;
+            initrd_size = 0;
+        }
+        BOOTINFO0(cs->as, parameters_base, BI_LAST);
+    } else {
+        uint8_t *ptr;
+        /* allocate and load BIOS */
+        rom = g_malloc(sizeof(*rom));
+        memory_region_init_ram(rom, NULL, "m68k_mac.rom", MACROM_SIZE,
+                               &error_abort);
+        if (bios_name == NULL) {
+            bios_name = MACROM_FILENAME;
+        }
+        filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
+        memory_region_set_readonly(rom, true);
+        memory_region_add_subregion(get_system_memory(), MACROM_ADDR, rom);
+
+        /* Load MacROM binary */
+        if (filename) {
+            bios_size = load_image_targphys(filename, MACROM_ADDR, MACROM_SIZE);
+            g_free(filename);
+        } else {
+            bios_size = -1;
+        }
+
+        /* Remove qtest_enabled() check once firmware files are in the tree */
+        if (!qtest_enabled()) {
+            if (bios_size < 0 || bios_size > MACROM_SIZE) {
+                error_report("could not load MacROM '%s'", bios_name);
+                exit(1);
+            }
+
+            ptr = rom_ptr(MACROM_ADDR, MACROM_SIZE);
+            stl_phys(cs->as, 0, ldl_p(ptr));    /* reset initial SP */
+            stl_phys(cs->as, 4,
+                     MACROM_ADDR + ldl_p(ptr + 4)); /* reset initial PC */
+        }
+    }
+}
+
+static void q800_machine_init(MachineClass *mc)
+{
+    mc->desc = "Macintosh Quadra 800";
+    mc->init = q800_init;
+    mc->default_cpu_type = M68K_CPU_TYPE_NAME("m68040");
+    mc->max_cpus = 1;
+    mc->is_default = 0;
+    mc->block_default_type = IF_SCSI;
+}
+
+DEFINE_MACHINE("q800", q800_machine_init)
-- 
2.21.0



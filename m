Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D6F2C3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 12:37:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C51882085A
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 12:37:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C51882085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzguU-0005tr-L3
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 08:37:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36391)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1hzgTq-0002Cw-L4
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 08:09:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1hzgTm-0002kd-Ez
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 08:09:46 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:58020 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1hzgTl-0002bI-SX
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 08:09:42 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 299641A21D4;
 Mon, 19 Aug 2019 14:08:25 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.13.43])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 693501A2072;
 Mon, 19 Aug 2019 14:08:24 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Mon, 19 Aug 2019 14:07:54 +0200
Message-Id: <1566216496-17375-16-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1566216496-17375-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1566216496-17375-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PATCH v8 15/37] target/mips: Style improvements in
 mips_malta.c
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
Cc: arikalo@wavecomp.com, philmd@redhat.com, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Fixes mostly errors and warnings reported by 'checkpatch.pl -f'.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 hw/mips/mips_malta.c | 216 ++++++++++++++++++++++++++++++---------------------
 1 file changed, 128 insertions(+), 88 deletions(-)

diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index 20e019b..0b5ee37 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -58,18 +58,18 @@
 #include "hw/semihosting/semihost.h"
 #include "hw/mips/cps.h"
 
-#define ENVP_ADDR		0x80002000l
-#define ENVP_NB_ENTRIES	 	16
-#define ENVP_ENTRY_SIZE	 	256
+#define ENVP_ADDR           0x80002000l
+#define ENVP_NB_ENTRIES     16
+#define ENVP_ENTRY_SIZE     256
 
 /* Hardware addresses */
-#define FLASH_ADDRESS 0x1e000000ULL
-#define FPGA_ADDRESS  0x1f000000ULL
-#define RESET_ADDRESS 0x1fc00000ULL
+#define FLASH_ADDRESS       0x1e000000ULL
+#define FPGA_ADDRESS        0x1f000000ULL
+#define RESET_ADDRESS       0x1fc00000ULL
 
-#define FLASH_SIZE    0x400000
+#define FLASH_SIZE          0x400000
 
-#define MAX_IDE_BUS 2
+#define MAX_IDE_BUS         2
 
 typedef struct {
     MemoryRegion iomem;
@@ -115,10 +115,11 @@ static void malta_fpga_update_display(void *opaque)
     MaltaFPGAState *s = opaque;
 
     for (i = 7 ; i >= 0 ; i--) {
-        if (s->leds & (1 << i))
+        if (s->leds & (1 << i)) {
             leds_text[i] = '#';
-        else
+        } else {
             leds_text[i] = ' ';
+        }
     }
     leds_text[8] = '\0';
 
@@ -138,8 +139,6 @@ static void malta_fpga_update_display(void *opaque)
  * Typical device names include Microchip 24C02SC or SGS Thomson ST24C02.
  */
 
-//~ #define DEBUG
-
 #if defined(DEBUG)
 #  define logout(fmt, ...) fprintf(stderr, "MALTA\t%-24s" fmt, __func__, ## __VA_ARGS__)
 #else
@@ -154,7 +153,7 @@ struct _eeprom24c0x_t {
   uint8_t scl;
   uint8_t sda;
   uint8_t data;
-  //~ uint16_t size;
+  /* uint16_t size; */
   uint8_t contents[256];
 };
 
@@ -162,22 +161,38 @@ typedef struct _eeprom24c0x_t eeprom24c0x_t;
 
 static eeprom24c0x_t spd_eeprom = {
     .contents = {
-        /* 00000000: */ 0x80,0x08,0xFF,0x0D,0x0A,0xFF,0x40,0x00,
-        /* 00000008: */ 0x01,0x75,0x54,0x00,0x82,0x08,0x00,0x01,
-        /* 00000010: */ 0x8F,0x04,0x02,0x01,0x01,0x00,0x00,0x00,
-        /* 00000018: */ 0x00,0x00,0x00,0x14,0x0F,0x14,0x2D,0xFF,
-        /* 00000020: */ 0x15,0x08,0x15,0x08,0x00,0x00,0x00,0x00,
-        /* 00000028: */ 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
-        /* 00000030: */ 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
-        /* 00000038: */ 0x00,0x00,0x00,0x00,0x00,0x00,0x12,0xD0,
-        /* 00000040: */ 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
-        /* 00000048: */ 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
-        /* 00000050: */ 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
-        /* 00000058: */ 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
-        /* 00000060: */ 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
-        /* 00000068: */ 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
-        /* 00000070: */ 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
-        /* 00000078: */ 0x00,0x00,0x00,0x00,0x00,0x00,0x64,0xF4,
+        /* 00000000: */
+        0x80, 0x08, 0xFF, 0x0D, 0x0A, 0xFF, 0x40, 0x00,
+        /* 00000008: */
+        0x01, 0x75, 0x54, 0x00, 0x82, 0x08, 0x00, 0x01,
+        /* 00000010: */
+        0x8F, 0x04, 0x02, 0x01, 0x01, 0x00, 0x00, 0x00,
+        /* 00000018: */
+        0x00, 0x00, 0x00, 0x14, 0x0F, 0x14, 0x2D, 0xFF,
+        /* 00000020: */
+        0x15, 0x08, 0x15, 0x08, 0x00, 0x00, 0x00, 0x00,
+        /* 00000028: */
+        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+        /* 00000030: */
+        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+        /* 00000038: */
+        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x12, 0xD0,
+        /* 00000040: */
+        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+        /* 00000048: */
+        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+        /* 00000050: */
+        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+        /* 00000058: */
+        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+        /* 00000060: */
+        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+        /* 00000068: */
+        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+        /* 00000070: */
+        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+        /* 00000078: */
+        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x64, 0xF4,
     },
 };
 
@@ -347,7 +362,8 @@ static uint64_t malta_fpga_read(void *opaque, hwaddr addr,
 
     /* SWITCH Register */
     case 0x00200:
-        val = 0x00000000;		/* All switches closed */
+        /* ori a3, a3, low(ram_low_size) */
+        val = 0x00000000;
         break;
 
     /* STATUS Register */
@@ -386,10 +402,11 @@ static uint64_t malta_fpga_read(void *opaque, hwaddr addr,
     /* GPINP Register */
     case 0x00a08:
         /* IN = OUT until a real I2C control is implemented */
-        if (s->i2csel)
+        if (s->i2csel) {
             val = s->i2cout;
-        else
+        } else {
             val = 0x00;
+        }
         break;
 
     /* I2CINP Register */
@@ -414,8 +431,8 @@ static uint64_t malta_fpga_read(void *opaque, hwaddr addr,
 
     default:
 #if 0
-        printf ("malta_fpga_read: Bad register offset 0x" TARGET_FMT_lx "\n",
-                addr);
+        printf("malta_fpga_read: Bad register offset 0x" TARGET_FMT_lx "\n",
+               addr);
 #endif
         break;
     }
@@ -467,8 +484,9 @@ static void malta_fpga_write(void *opaque, hwaddr addr,
 
     /* SOFTRES Register */
     case 0x00500:
-        if (val == 0x42)
+        if (val == 0x42) {
             qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
+        }
         break;
 
     /* BRKRES Register */
@@ -501,8 +519,8 @@ static void malta_fpga_write(void *opaque, hwaddr addr,
 
     default:
 #if 0
-        printf ("malta_fpga_write: Bad register offset 0x" TARGET_FMT_lx "\n",
-                addr);
+        printf("malta_fpga_write: Bad register offset 0x" TARGET_FMT_lx "\n",
+               addr);
 #endif
         break;
     }
@@ -561,7 +579,7 @@ static MaltaFPGAState *malta_fpga_init(MemoryRegion *address_space,
     memory_region_init_alias(&s->iomem_lo, NULL, "malta-fpga",
                              &s->iomem, 0, 0x900);
     memory_region_init_alias(&s->iomem_hi, NULL, "malta-fpga",
-                             &s->iomem, 0xa00, 0x10000-0xa00);
+                             &s->iomem, 0xa00, 0x10000 - 0xa00);
 
     memory_region_add_subregion(address_space, base, &s->iomem_lo);
     memory_region_add_subregion(address_space, base + 0xa00, &s->iomem_hi);
@@ -585,7 +603,7 @@ static void network_init(PCIBus *pci_bus)
 {
     int i;
 
-    for(i = 0; i < nb_nics; i++) {
+    for (i = 0; i < nb_nics; i++) {
         NICInfo *nd = &nd_table[i];
         const char *default_devaddr = NULL;
 
@@ -799,27 +817,28 @@ static void write_bootloader_nanomips(uint8_t *base, int64_t run_addr,
                                 /* jalrc   t8                   */
 }
 
-/* ROM and pseudo bootloader
-
-   The following code implements a very very simple bootloader. It first
-   loads the registers a0 to a3 to the values expected by the OS, and
-   then jump at the kernel address.
-
-   The bootloader should pass the locations of the kernel arguments and
-   environment variables tables. Those tables contain the 32-bit address
-   of NULL terminated strings. The environment variables table should be
-   terminated by a NULL address.
-
-   For a simpler implementation, the number of kernel arguments is fixed
-   to two (the name of the kernel and the command line), and the two
-   tables are actually the same one.
-
-   The registers a0 to a3 should contain the following values:
-     a0 - number of kernel arguments
-     a1 - 32-bit address of the kernel arguments table
-     a2 - 32-bit address of the environment variables table
-     a3 - RAM size in bytes
-*/
+/*
+ * ROM and pseudo bootloader
+ *
+ * The following code implements a very very simple bootloader. It first
+ * loads the registers a0 to a3 to the values expected by the OS, and
+ * then jump at the kernel address.
+ *
+ * The bootloader should pass the locations of the kernel arguments and
+ * environment variables tables. Those tables contain the 32-bit address
+ * of NULL terminated strings. The environment variables table should be
+ * terminated by a NULL address.
+ *
+ * For a simpler implementation, the number of kernel arguments is fixed
+ * to two (the name of the kernel and the command line), and the two
+ * tables are actually the same one.
+ *
+ * The registers a0 to a3 should contain the following values:
+ *   a0 - number of kernel arguments
+ *   a1 - 32-bit address of the kernel arguments table
+ *   a2 - 32-bit address of the environment variables table
+ *   a3 - RAM size in bytes
+ */
 static void write_bootloader(uint8_t *base, int64_t run_addr,
                              int64_t kernel_entry)
 {
@@ -857,14 +876,23 @@ static void write_bootloader(uint8_t *base, int64_t run_addr,
     } else {
         stl_p(p++, 0x24040002);                         /* addiu a0, zero, 2 */
     }
-    stl_p(p++, 0x3c1d0000 | (((ENVP_ADDR - 64) >> 16) & 0xffff)); /* lui sp, high(ENVP_ADDR) */
-    stl_p(p++, 0x37bd0000 | ((ENVP_ADDR - 64) & 0xffff));        /* ori sp, sp, low(ENVP_ADDR) */
-    stl_p(p++, 0x3c050000 | ((ENVP_ADDR >> 16) & 0xffff));       /* lui a1, high(ENVP_ADDR) */
-    stl_p(p++, 0x34a50000 | (ENVP_ADDR & 0xffff));               /* ori a1, a1, low(ENVP_ADDR) */
-    stl_p(p++, 0x3c060000 | (((ENVP_ADDR + 8) >> 16) & 0xffff)); /* lui a2, high(ENVP_ADDR + 8) */
-    stl_p(p++, 0x34c60000 | ((ENVP_ADDR + 8) & 0xffff));         /* ori a2, a2, low(ENVP_ADDR + 8) */
-    stl_p(p++, 0x3c070000 | (loaderparams.ram_low_size >> 16));     /* lui a3, high(ram_low_size) */
-    stl_p(p++, 0x34e70000 | (loaderparams.ram_low_size & 0xffff));  /* ori a3, a3, low(ram_low_size) */
+
+    /* lui sp, high(ENVP_ADDR) */
+    stl_p(p++, 0x3c1d0000 | (((ENVP_ADDR - 64) >> 16) & 0xffff));
+    /* ori sp, sp, low(ENVP_ADDR) */
+    stl_p(p++, 0x37bd0000 | ((ENVP_ADDR - 64) & 0xffff));
+    /* lui a1, high(ENVP_ADDR) */
+    stl_p(p++, 0x3c050000 | ((ENVP_ADDR >> 16) & 0xffff));
+    /* ori a1, a1, low(ENVP_ADDR) */
+    stl_p(p++, 0x34a50000 | (ENVP_ADDR & 0xffff));
+    /* lui a2, high(ENVP_ADDR + 8) */
+    stl_p(p++, 0x3c060000 | (((ENVP_ADDR + 8) >> 16) & 0xffff));
+    /* ori a2, a2, low(ENVP_ADDR + 8) */
+    stl_p(p++, 0x34c60000 | ((ENVP_ADDR + 8) & 0xffff));
+    /* lui a3, high(ram_low_size) */
+    stl_p(p++, 0x3c070000 | (loaderparams.ram_low_size >> 16));
+    /* ori a3, a3, low(ram_low_size) */
+    stl_p(p++, 0x34e70000 | (loaderparams.ram_low_size & 0xffff));
 
     /* Load BAR registers as done by YAMON */
     stl_p(p++, 0x3c09b400);                                      /* lui t1, 0xb400 */
@@ -968,14 +996,15 @@ static void write_bootloader(uint8_t *base, int64_t run_addr,
 
 }
 
-static void GCC_FMT_ATTR(3, 4) prom_set(uint32_t* prom_buf, int index,
+static void GCC_FMT_ATTR(3, 4) prom_set(uint32_t *prom_buf, int index,
                                         const char *string, ...)
 {
     va_list ap;
     int32_t table_addr;
 
-    if (index >= ENVP_NB_ENTRIES)
+    if (index >= ENVP_NB_ENTRIES) {
         return;
+    }
 
     if (string == NULL) {
         prom_buf[index] = 0;
@@ -991,7 +1020,7 @@ static void GCC_FMT_ATTR(3, 4) prom_set(uint32_t* prom_buf, int index,
 }
 
 /* Kernel */
-static int64_t load_kernel (void)
+static int64_t load_kernel(void)
 {
     int64_t kernel_entry, kernel_high, initrd_size;
     long kernel_size;
@@ -1039,11 +1068,13 @@ static int64_t load_kernel (void)
     initrd_size = 0;
     initrd_offset = 0;
     if (loaderparams.initrd_filename) {
-        initrd_size = get_image_size (loaderparams.initrd_filename);
+        initrd_size = get_image_size(loaderparams.initrd_filename);
         if (initrd_size > 0) {
-            /* The kernel allocates the bootmap memory in the low memory after
-               the initrd.  It takes at most 128kiB for 2GB RAM and 4kiB
-               pages.  */
+            /*
+             * The kernel allocates the bootmap memory in the low memory after
+             * the initrd.  It takes at most 128kiB for 2GB RAM and 4kiB
+             * pages.
+             */
             initrd_offset = (loaderparams.ram_low_size - initrd_size
                              - (128 * KiB)
                              - ~INITRD_PAGE_MASK) & INITRD_PAGE_MASK;
@@ -1069,9 +1100,10 @@ static int64_t load_kernel (void)
 
     prom_set(prom_buf, prom_index++, "%s", loaderparams.kernel_filename);
     if (initrd_size > 0) {
-        prom_set(prom_buf, prom_index++, "rd_start=0x%" PRIx64 " rd_size=%" PRId64 " %s",
-                 xlate_to_kseg0(NULL, initrd_offset), initrd_size,
-                 loaderparams.kernel_cmdline);
+        prom_set(prom_buf, prom_index++,
+                 "rd_start=0x%" PRIx64 " rd_size=%" PRId64 " %s",
+                 xlate_to_kseg0(NULL, initrd_offset),
+                 initrd_size, loaderparams.kernel_cmdline);
     } else {
         prom_set(prom_buf, prom_index++, "%s", loaderparams.kernel_cmdline);
     }
@@ -1111,9 +1143,11 @@ static void main_cpu_reset(void *opaque)
 
     cpu_reset(CPU(cpu));
 
-    /* The bootloader does not need to be rewritten as it is located in a
-       read only location. The kernel location and the arguments table
-       location does not change. */
+    /*
+     * The bootloader does not need to be rewritten as it is located in a
+     * read only location. The kernel location and the arguments table
+     * location does not change.
+     */
     if (loaderparams.kernel_filename) {
         env->CP0_Status &= ~(1 << CP0St_ERL);
     }
@@ -1211,9 +1245,11 @@ void mips_malta_init(MachineState *machine)
     DeviceState *dev = qdev_create(NULL, TYPE_MIPS_MALTA);
     MaltaState *s = MIPS_MALTA(dev);
 
-    /* The whole address space decoded by the GT-64120A doesn't generate
-       exception when accessing invalid memory. Create an empty slot to
-       emulate this feature. */
+    /*
+     * The whole address space decoded by the GT-64120A doesn't generate
+     * exception when accessing invalid memory. Create an empty slot to
+     * emulate this feature.\
+     */
     empty_slot_init(0, 0x20000000);
 
     qdev_init_nofail(dev);
@@ -1329,8 +1365,10 @@ void mips_malta_init(MachineState *machine)
                 exit(1);
             }
         }
-        /* In little endian mode the 32bit words in the bios are swapped,
-           a neat trick which allows bi-endian firmware. */
+        /*
+         * In little endian mode the 32bit words in the bios are swapped,
+         * a neat trick which allows bi-endian firmware.
+         */
 #ifndef TARGET_WORDS_BIGENDIAN
         {
             uint32_t *end, *addr;
@@ -1384,8 +1422,10 @@ void mips_malta_init(MachineState *machine)
 
     piix4_devfn = piix4_init(pci_bus, &isa_bus, 80);
 
-    /* Interrupt controller */
-    /* The 8259 is attached to the MIPS CPU INT0 pin, ie interrupt 2 */
+    /*
+     * Interrupt controller
+     * The 8259 is attached to the MIPS CPU INT0 pin, ie interrupt 2
+     */
     s->i8259 = i8259_init(isa_bus, i8259_irq);
 
     isa_bus_irqs(isa_bus, s->i8259);
-- 
2.7.4



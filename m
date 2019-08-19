Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6E92C3A59D
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 12:18:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF95C20851
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 12:18:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF95C20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzgcI-0003QS-2I
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 08:18:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36158)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1hzgTd-0001tF-Go
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 08:09:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1hzgTb-0002b6-2O
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 08:09:33 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:57766 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1hzgTa-0002ZU-IS
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 08:09:30 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id BA24E1A2142;
 Mon, 19 Aug 2019 14:08:24 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.13.43])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 4E88C1A20A0;
 Mon, 19 Aug 2019 14:08:24 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Mon, 19 Aug 2019 14:07:52 +0200
Message-Id: <1566216496-17375-14-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1566216496-17375-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1566216496-17375-1-git-send-email-aleksandar.markovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PATCH v8 13/37] target/mips: Style improvements in
 mips_fulong2e.c
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
 hw/mips/mips_fulong2e.c | 96 +++++++++++++++++++++++++++++--------------------
 1 file changed, 58 insertions(+), 38 deletions(-)

diff --git a/hw/mips/mips_fulong2e.c b/hw/mips/mips_fulong2e.c
index 5dbaa3b..0c3d947 100644
--- a/hw/mips/mips_fulong2e.c
+++ b/hw/mips/mips_fulong2e.c
@@ -48,13 +48,13 @@
 
 #define DEBUG_FULONG2E_INIT
 
-#define ENVP_ADDR       0x80002000l
-#define ENVP_NB_ENTRIES	 	16
-#define ENVP_ENTRY_SIZE	 	256
+#define ENVP_ADDR               0x80002000l
+#define ENVP_NB_ENTRIES         16
+#define ENVP_ENTRY_SIZE         256
 
 /* fulong 2e has a 512k flash: Winbond W39L040AP70Z */
-#define BIOS_SIZE (512 * KiB)
-#define MAX_IDE_BUS 2
+#define BIOS_SIZE               (512 * KiB)
+#define MAX_IDE_BUS             2
 
 /*
  * PMON is not part of qemu and released with BSD license, anyone
@@ -83,14 +83,15 @@ static struct _loaderparams {
     const char *initrd_filename;
 } loaderparams;
 
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
@@ -105,7 +106,7 @@ static void GCC_FMT_ATTR(3, 4) prom_set(uint32_t* prom_buf, int index,
     va_end(ap);
 }
 
-static int64_t load_kernel (CPUMIPSState *env)
+static int64_t load_kernel(CPUMIPSState *env)
 {
     int64_t kernel_entry, kernel_low, kernel_high, initrd_size;
     int index = 0;
@@ -130,16 +131,18 @@ static int64_t load_kernel (CPUMIPSState *env)
     initrd_size = 0;
     initrd_offset = 0;
     if (loaderparams.initrd_filename) {
-        initrd_size = get_image_size (loaderparams.initrd_filename);
+        initrd_size = get_image_size(loaderparams.initrd_filename);
         if (initrd_size > 0) {
-            initrd_offset = (kernel_high + ~INITRD_PAGE_MASK) & INITRD_PAGE_MASK;
+            initrd_offset = (kernel_high + ~INITRD_PAGE_MASK) &
+                            INITRD_PAGE_MASK;
             if (initrd_offset + initrd_size > ram_size) {
                 error_report("memory too small for initial ram disk '%s'",
                              loaderparams.initrd_filename);
                 exit(1);
             }
             initrd_size = load_image_targphys(loaderparams.initrd_filename,
-                                     initrd_offset, ram_size - initrd_offset);
+                                              initrd_offset,
+                                              ram_size - initrd_offset);
         }
         if (initrd_size == (target_ulong) -1) {
             error_report("could not load initial ram disk '%s'",
@@ -154,9 +157,10 @@ static int64_t load_kernel (CPUMIPSState *env)
 
     prom_set(prom_buf, index++, "%s", loaderparams.kernel_filename);
     if (initrd_size > 0) {
-        prom_set(prom_buf, index++, "rd_start=0x%" PRIx64 " rd_size=%" PRId64 " %s",
-                 cpu_mips_phys_to_kseg0(NULL, initrd_offset), initrd_size,
-                 loaderparams.kernel_cmdline);
+        prom_set(prom_buf, index++,
+                 "rd_start=0x%" PRIx64 " rd_size=%" PRId64 " %s",
+                 cpu_mips_phys_to_kseg0(NULL, initrd_offset),
+                 initrd_size, loaderparams.kernel_cmdline);
     } else {
         prom_set(prom_buf, index++, "%s", loaderparams.kernel_cmdline);
     }
@@ -175,34 +179,48 @@ static int64_t load_kernel (CPUMIPSState *env)
     return kernel_entry;
 }
 
-static void write_bootloader (CPUMIPSState *env, uint8_t *base, int64_t kernel_addr)
+static void write_bootloader(CPUMIPSState *env, uint8_t *base,
+                             int64_t kernel_addr)
 {
     uint32_t *p;
 
     /* Small bootloader */
-    p = (uint32_t *) base;
+    p = (uint32_t *)base;
 
-    stl_p(p++, 0x0bf00010);                                      /* j 0x1fc00040 */
-    stl_p(p++, 0x00000000);                                      /* nop */
+    /* j 0x1fc00040 */
+    stl_p(p++, 0x0bf00010);
+    /* nop */
+    stl_p(p++, 0x00000000);
 
     /* Second part of the bootloader */
-    p = (uint32_t *) (base + 0x040);
-
-    stl_p(p++, 0x3c040000);                                      /* lui a0, 0 */
-    stl_p(p++, 0x34840002);                                      /* ori a0, a0, 2 */
-    stl_p(p++, 0x3c050000 | ((ENVP_ADDR >> 16) & 0xffff));       /* lui a1, high(ENVP_ADDR) */
-    stl_p(p++, 0x34a50000 | (ENVP_ADDR & 0xffff));               /* ori a1, a0, low(ENVP_ADDR) */
-    stl_p(p++, 0x3c060000 | (((ENVP_ADDR + 8) >> 16) & 0xffff)); /* lui a2, high(ENVP_ADDR + 8) */
-    stl_p(p++, 0x34c60000 | ((ENVP_ADDR + 8) & 0xffff));         /* ori a2, a2, low(ENVP_ADDR + 8) */
-    stl_p(p++, 0x3c070000 | (loaderparams.ram_size >> 16));      /* lui a3, high(env->ram_size) */
-    stl_p(p++, 0x34e70000 | (loaderparams.ram_size & 0xffff));   /* ori a3, a3, low(env->ram_size) */
-    stl_p(p++, 0x3c1f0000 | ((kernel_addr >> 16) & 0xffff));     /* lui ra, high(kernel_addr) */;
-    stl_p(p++, 0x37ff0000 | (kernel_addr & 0xffff));             /* ori ra, ra, low(kernel_addr) */
-    stl_p(p++, 0x03e00008);                                      /* jr ra */
-    stl_p(p++, 0x00000000);                                      /* nop */
+    p = (uint32_t *)(base + 0x040);
+
+    /* lui a0, 0 */
+    stl_p(p++, 0x3c040000);
+    /* ori a0, a0, 2 */
+    stl_p(p++, 0x34840002);
+    /* lui a1, high(ENVP_ADDR) */
+    stl_p(p++, 0x3c050000 | ((ENVP_ADDR >> 16) & 0xffff));
+    /* ori a1, a0, low(ENVP_ADDR) */
+    stl_p(p++, 0x34a50000 | (ENVP_ADDR & 0xffff));
+    /* lui a2, high(ENVP_ADDR + 8) */
+    stl_p(p++, 0x3c060000 | (((ENVP_ADDR + 8) >> 16) & 0xffff));
+    /* ori a2, a2, low(ENVP_ADDR + 8) */
+    stl_p(p++, 0x34c60000 | ((ENVP_ADDR + 8) & 0xffff));
+    /* lui a3, high(env->ram_size) */
+    stl_p(p++, 0x3c070000 | (loaderparams.ram_size >> 16));
+    /* ori a3, a3, low(env->ram_size) */
+    stl_p(p++, 0x34e70000 | (loaderparams.ram_size & 0xffff));
+    /* lui ra, high(kernel_addr) */
+    stl_p(p++, 0x3c1f0000 | ((kernel_addr >> 16) & 0xffff));
+    /* ori ra, ra, low(kernel_addr) */
+    stl_p(p++, 0x37ff0000 | (kernel_addr & 0xffff));
+    /* jr ra */
+    stl_p(p++, 0x03e00008);
+    /* nop */
+    stl_p(p++, 0x00000000);
 }
 
-
 static void main_cpu_reset(void *opaque)
 {
     MIPSCPU *cpu = opaque;
@@ -252,11 +270,11 @@ static void vt82c686b_southbridge_init(PCIBus *pci_bus, int slot, qemu_irq intc,
 }
 
 /* Network support */
-static void network_init (PCIBus *pci_bus)
+static void network_init(PCIBus *pci_bus)
 {
     int i;
 
-    for(i = 0; i < nb_nics; i++) {
+    for (i = 0; i < nb_nics; i++) {
         NICInfo *nd = &nd_table[i];
         const char *default_devaddr = NULL;
 
@@ -308,15 +326,17 @@ static void mips_fulong2e_init(MachineState *machine)
     memory_region_add_subregion(address_space_mem, 0, ram);
     memory_region_add_subregion(address_space_mem, 0x1fc00000LL, bios);
 
-    /* We do not support flash operation, just loading pmon.bin as raw BIOS.
-     * Please use -L to set the BIOS path and -bios to set bios name. */
+    /*
+     * We do not support flash operation, just loading pmon.bin as raw BIOS.
+     * Please use -L to set the BIOS path and -bios to set bios name.
+     */
 
     if (kernel_filename) {
         loaderparams.ram_size = ram_size;
         loaderparams.kernel_filename = kernel_filename;
         loaderparams.kernel_cmdline = kernel_cmdline;
         loaderparams.initrd_filename = initrd_filename;
-        kernel_entry = load_kernel (env);
+        kernel_entry = load_kernel(env);
         write_bootloader(env, memory_region_get_ram_ptr(bios), kernel_entry);
     } else {
         if (bios_name == NULL) {
-- 
2.7.4



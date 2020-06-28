Return-Path: <SRS0=WNoQ=AJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C15ECC433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jun 2020 18:22:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EBA820757
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jun 2020 18:22:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EBA820757
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpbwP-0004fi-Ro
	for qemu-devel@archiver.kernel.org; Sun, 28 Jun 2020 14:22:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51564)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jpbuT-00025v-9q; Sun, 28 Jun 2020 14:20:09 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:38364)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jpbuQ-0005LV-Cl; Sun, 28 Jun 2020 14:20:08 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id EE3727482D3;
 Sun, 28 Jun 2020 20:20:04 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id C4918746331; Sun, 28 Jun 2020 20:20:04 +0200 (CEST)
Message-Id: <5e9db897c3b48bce89891599c55752acfae1b892.1593367416.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1593367416.git.balaton@eik.bme.hu>
References: <cover.1593367416.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v6 04/11] mac_oldworld: Drop some variables
Date: Sun, 28 Jun 2020 20:03:36 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/28 14:20:01
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Howard Spoelstra <hsp.cat7@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Values not used frequently enough may not worth putting in a local
variable, especially with names almost as long as the original value
because that does not improve readability, to the contrary it makes it
harder to see what value is used. Drop a few such variables.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/ppc/mac_oldworld.c | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
index d1c4244b1e..4200008851 100644
--- a/hw/ppc/mac_oldworld.c
+++ b/hw/ppc/mac_oldworld.c
@@ -83,14 +83,11 @@ static void ppc_heathrow_reset(void *opaque)
 static void ppc_heathrow_init(MachineState *machine)
 {
     ram_addr_t ram_size = machine->ram_size;
-    const char *kernel_filename = machine->kernel_filename;
-    const char *kernel_cmdline = machine->kernel_cmdline;
-    const char *initrd_filename = machine->initrd_filename;
     const char *boot_device = machine->boot_order;
     PowerPCCPU *cpu = NULL;
     CPUPPCState *env = NULL;
     char *filename;
-    int linux_boot, i;
+    int i;
     MemoryRegion *bios = g_new(MemoryRegion, 1);
     uint32_t kernel_base, initrd_base, cmdline_base = 0;
     int32_t kernel_size, initrd_size;
@@ -108,8 +105,6 @@ static void ppc_heathrow_init(MachineState *machine)
     void *fw_cfg;
     uint64_t tbfreq;
 
-    linux_boot = (kernel_filename != NULL);
-
     /* init CPUs */
     for (i = 0; i < smp_cpus; i++) {
         cpu = POWERPC_CPU(cpu_create(machine->cpu_type));
@@ -159,7 +154,7 @@ static void ppc_heathrow_init(MachineState *machine)
         exit(1);
     }
 
-    if (linux_boot) {
+    if (machine->kernel_filename) {
         uint64_t lowaddr = 0;
         int bswap_needed;
 
@@ -169,30 +164,33 @@ static void ppc_heathrow_init(MachineState *machine)
         bswap_needed = 0;
 #endif
         kernel_base = KERNEL_LOAD_ADDR;
-        kernel_size = load_elf(kernel_filename, NULL,
+        kernel_size = load_elf(machine->kernel_filename, NULL,
                                translate_kernel_address, NULL,
                                NULL, &lowaddr, NULL, NULL, 1, PPC_ELF_MACHINE,
                                0, 0);
         if (kernel_size < 0)
-            kernel_size = load_aout(kernel_filename, kernel_base,
+            kernel_size = load_aout(machine->kernel_filename, kernel_base,
                                     ram_size - kernel_base, bswap_needed,
                                     TARGET_PAGE_SIZE);
         if (kernel_size < 0)
-            kernel_size = load_image_targphys(kernel_filename,
+            kernel_size = load_image_targphys(machine->kernel_filename,
                                               kernel_base,
                                               ram_size - kernel_base);
         if (kernel_size < 0) {
-            error_report("could not load kernel '%s'", kernel_filename);
+            error_report("could not load kernel '%s'",
+                         machine->kernel_filename);
             exit(1);
         }
         /* load initrd */
-        if (initrd_filename) {
-            initrd_base = TARGET_PAGE_ALIGN(kernel_base + kernel_size + KERNEL_GAP);
-            initrd_size = load_image_targphys(initrd_filename, initrd_base,
+        if (machine->initrd_filename) {
+            initrd_base = TARGET_PAGE_ALIGN(kernel_base + kernel_size +
+                                            KERNEL_GAP);
+            initrd_size = load_image_targphys(machine->initrd_filename,
+                                              initrd_base,
                                               ram_size - initrd_base);
             if (initrd_size < 0) {
                 error_report("could not load initial ram disk '%s'",
-                             initrd_filename);
+                             machine->initrd_filename);
                 exit(1);
             }
             cmdline_base = TARGET_PAGE_ALIGN(initrd_base + initrd_size);
@@ -336,9 +334,10 @@ static void ppc_heathrow_init(MachineState *machine)
     fw_cfg_add_i16(fw_cfg, FW_CFG_MACHINE_ID, ARCH_HEATHROW);
     fw_cfg_add_i32(fw_cfg, FW_CFG_KERNEL_ADDR, kernel_base);
     fw_cfg_add_i32(fw_cfg, FW_CFG_KERNEL_SIZE, kernel_size);
-    if (kernel_cmdline) {
+    if (machine->kernel_cmdline) {
         fw_cfg_add_i32(fw_cfg, FW_CFG_KERNEL_CMDLINE, cmdline_base);
-        pstrcpy_targphys("cmdline", cmdline_base, TARGET_PAGE_SIZE, kernel_cmdline);
+        pstrcpy_targphys("cmdline", cmdline_base, TARGET_PAGE_SIZE,
+                         machine->kernel_cmdline);
     } else {
         fw_cfg_add_i32(fw_cfg, FW_CFG_KERNEL_CMDLINE, 0);
     }
-- 
2.21.3



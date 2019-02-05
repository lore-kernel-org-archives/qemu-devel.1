Received: from eggs.gnu.org ([209.51.188.92]:36064)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gr4AV-0001vW-Db
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 12:06:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gr4AR-0000Z7-Ke
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 12:05:55 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:37705)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gr4AR-0000Rt-C0
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 12:05:51 -0500
Received: by mail-wr1-x442.google.com with SMTP id s12so4473707wrt.4
	for <qemu-devel@nongnu.org>; Tue, 05 Feb 2019 09:05:40 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id w13sm5583164wmf.5.2019.02.05.09.05.37
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 05 Feb 2019 09:05:37 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  5 Feb 2019 17:05:05 +0000
Message-Id: <20190205170510.21984-18-peter.maydell@linaro.org>
In-Reply-To: <20190205170510.21984-1-peter.maydell@linaro.org>
References: <20190205170510.21984-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 17/22] hw/arm/boot: Fix block comment style in
 arm_load_kernel()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Fix the block comment style in arm_load_kernel() to QEMU's
current style preferences. This will allow us to do some
refactoring of this function without checkpatch complaining
about the code-motion patches.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-id: 20190131112240.8395-2-peter.maydell@linaro.org
---
 hw/arm/boot.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index 05762d0fc1b..dcb93fdbe2c 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -961,7 +961,8 @@ void arm_load_kernel(ARMCPU *cpu, struct arm_boot_info *info)
     static const ARMInsnFixup *primary_loader;
     AddressSpace *as = arm_boot_address_space(cpu, info);
 
-    /* CPU objects (unlike devices) are not automatically reset on system
+    /*
+     * CPU objects (unlike devices) are not automatically reset on system
      * reset, so we must always register a handler to do so. If we're
      * actually loading a kernel, the handler is also responsible for
      * arranging that we start it correctly.
@@ -970,7 +971,8 @@ void arm_load_kernel(ARMCPU *cpu, struct arm_boot_info *info)
         qemu_register_reset(do_cpu_reset, ARM_CPU(cs));
     }
 
-    /* The board code is not supposed to set secure_board_setup unless
+    /*
+     * The board code is not supposed to set secure_board_setup unless
      * running its code in secure mode is actually possible, and KVM
      * doesn't support secure.
      */
@@ -983,7 +985,8 @@ void arm_load_kernel(ARMCPU *cpu, struct arm_boot_info *info)
     if (!info->kernel_filename || info->firmware_loaded) {
 
         if (have_dtb(info)) {
-            /* If we have a device tree blob, but no kernel to supply it to (or
+            /*
+             * If we have a device tree blob, but no kernel to supply it to (or
              * the kernel is supposed to be loaded by the bootloader), copy the
              * DTB to the base of RAM for the bootloader to pick up.
              */
@@ -998,7 +1001,8 @@ void arm_load_kernel(ARMCPU *cpu, struct arm_boot_info *info)
             try_decompressing_kernel = arm_feature(&cpu->env,
                                                    ARM_FEATURE_AARCH64);
 
-            /* Expose the kernel, the command line, and the initrd in fw_cfg.
+            /*
+             * Expose the kernel, the command line, and the initrd in fw_cfg.
              * We don't process them here at all, it's all left to the
              * firmware.
              */
@@ -1018,7 +1022,8 @@ void arm_load_kernel(ARMCPU *cpu, struct arm_boot_info *info)
             }
         }
 
-        /* We will start from address 0 (typically a boot ROM image) in the
+        /*
+         * We will start from address 0 (typically a boot ROM image) in the
          * same way as hardware.
          */
         return;
@@ -1045,7 +1050,8 @@ void arm_load_kernel(ARMCPU *cpu, struct arm_boot_info *info)
     if (info->nb_cpus == 0)
         info->nb_cpus = 1;
 
-    /* We want to put the initrd far enough into RAM that when the
+    /*
+     * We want to put the initrd far enough into RAM that when the
      * kernel is uncompressed it will not clobber the initrd. However
      * on boards without much RAM we must ensure that we still leave
      * enough room for a decent sized initrd, and on boards with large
@@ -1062,12 +1068,14 @@ void arm_load_kernel(ARMCPU *cpu, struct arm_boot_info *info)
     kernel_size = arm_load_elf(info, &elf_entry, &elf_low_addr,
                                &elf_high_addr, elf_machine, as);
     if (kernel_size > 0 && have_dtb(info)) {
-        /* If there is still some room left at the base of RAM, try and put
+        /*
+         * If there is still some room left at the base of RAM, try and put
          * the DTB there like we do for images loaded with -bios or -pflash.
          */
         if (elf_low_addr > info->loader_start
             || elf_high_addr < info->loader_start) {
-            /* Set elf_low_addr as address limit for arm_load_dtb if it may be
+            /*
+             * Set elf_low_addr as address limit for arm_load_dtb if it may be
              * pointing into RAM, otherwise pass '0' (no limit)
              */
             if (elf_low_addr < info->loader_start) {
@@ -1128,7 +1136,8 @@ void arm_load_kernel(ARMCPU *cpu, struct arm_boot_info *info)
         fixupcontext[FIXUP_BOARDID] = info->board_id;
         fixupcontext[FIXUP_BOARD_SETUP] = info->board_setup_addr;
 
-        /* for device tree boot, we pass the DTB directly in r2. Otherwise
+        /*
+         * for device tree boot, we pass the DTB directly in r2. Otherwise
          * we point to the kernel args.
          */
         if (have_dtb(info)) {
@@ -1181,7 +1190,8 @@ void arm_load_kernel(ARMCPU *cpu, struct arm_boot_info *info)
             info->write_board_setup(cpu, info);
         }
 
-        /* Notify devices which need to fake up firmware initialization
+        /*
+         * Notify devices which need to fake up firmware initialization
          * that we're doing a direct kernel boot.
          */
         object_child_foreach_recursive(object_get_root(),
-- 
2.20.1

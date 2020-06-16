Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77346C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 19:28:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E8E9208C3
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 19:28:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="PeeDg72y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E8E9208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlHGS-0007Qi-EW
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 15:28:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47296)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=4293a8cce=atish.patra@wdc.com>)
 id 1jlHFA-0005tE-8f; Tue, 16 Jun 2020 15:27:36 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:63296)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=4293a8cce=atish.patra@wdc.com>)
 id 1jlHF7-000622-S2; Tue, 16 Jun 2020 15:27:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1592335653; x=1623871653;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=qeB4ucQioXwAaSmCPZoRfbYELChjOVzX11pPJN936bc=;
 b=PeeDg72yTUHykr14YaLNM2sBMDiweaBcFuxNeEkPyzq27VN16bydi9X5
 nYuYWabI05zf9O5Z3KC2w0cfcyOXMfOjKzhAM/uTlnop+y6/r7AxzZWwr
 aRp/49KfsDYv8lo2TzVqTK+MeM24uscjClI7bOs/gDqKkjAmuQ+Gjfyt9
 RL2VH7J95eKpxFB8AtOLaa0dsdnvuOlDX8sB0v5gbBctf6iYd6mAN7YUy
 /RwWBCBBPr2EnGGA3Zg+8S6N4yK69e/No7djTUMh7+f9VU1ymVlcf5TjM
 g4aK17Cc7pnRrFx/37qTCDOH3SPFWFLbKzv/nHBzR7L6CQYWYIttKSb5W Q==;
IronPort-SDR: xImD84NK6eISKrqPrsruicUy8Qlb2+XAN18iAg+FEV004sEcRscUfBQjPGVPaFkXq86CRkRLVx
 D3AYkQs7t3Lo7dCnRe1bixXcDPQB7oio4i3LbfHl8Q183f3qfn5B8QgJ+V69EUCt+apSs7DE1c
 RDqhckXcoluXEXsEr8I+PJS5/2v+ZtqLn1ktoDEQSOYUjttcckQi+YQxKTGXHE0keVk4hwQYkf
 Ikj8ITyVYpfGB8BCXA6HDpJ9snaxtd2iZoD55xjyBkc0FQejTM+IhPRSvgm1lfNLp5wNr5/Am+
 Ab8=
X-IronPort-AV: E=Sophos;i="5.73,519,1583164800"; d="scan'208";a="140158606"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 17 Jun 2020 03:27:23 +0800
IronPort-SDR: 2mh2Fj1EtB+qLpKWTzo2ArUtQxE6Lska3mNe3zq9WIKvWDoz6VCxK7W/Y25AXDishwg8GCJQHk
 YJ7H7J50G1oD3LYHAetAyK33QIa/7UaaQ=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jun 2020 12:16:39 -0700
IronPort-SDR: frjhNr+NktBL/ndrYftbjvYzgDrfEp/TAzGkbTTpfHgcn4k/rpE+8Q9J661hUI8lLWWgT04tmZ
 VTSotJMn3qIA==
WDCIronportException: Internal
Received: from usa001615.ad.shared (HELO yoda.hgst.com) ([10.86.58.120])
 by uls-op-cesaip02.wdc.com with ESMTP; 16 Jun 2020 12:27:23 -0700
From: Atish Patra <atish.patra@wdc.com>
To: qemu-devel@nongnu.org
Subject: [PATCH  3/3] riscv: Add opensbi firmware dynamic support
Date: Tue, 16 Jun 2020 12:27:00 -0700
Message-Id: <20200616192700.1900260-4-atish.patra@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200616192700.1900260-1-atish.patra@wdc.com>
References: <20200616192700.1900260-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=4293a8cce=atish.patra@wdc.com; helo=esa4.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/16 15:27:22
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Cc: qemu-riscv@nongnu.org, Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Atish Patra <atish.patra@wdc.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

OpenSBI is the default firmware in Qemu and has various firmware loading
options. Currently, qemu loader uses fw_jump which has a compile time
pre-defined address where fdt & kernel image must reside. This puts a
constraint on image size of the Linux kernel depending on the fdt location
and available memory. However, fw_dynamic allows the loader to specify
the next stage location (i.e. Linux kernel/U-boot) in memory and other
configurable boot options available in OpenSBI.

Add support for OpenSBI dynamic firmware loading support. This doesn't
break existing setup and fw_jump will continue to work as it is. Any
other firmware will continue to work without any issues as long as it
doesn't expect anything specific from loader in "a2" register.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 hw/riscv/boot.c                 | 32 ++++++++++++++++--
 hw/riscv/sifive_u.c             | 11 +++++--
 hw/riscv/spike.c                | 11 +++++--
 hw/riscv/virt.c                 | 11 +++++--
 include/hw/riscv/boot.h         |  2 +-
 include/hw/riscv/boot_opensbi.h | 58 +++++++++++++++++++++++++++++++++
 6 files changed, 116 insertions(+), 9 deletions(-)
 create mode 100644 include/hw/riscv/boot_opensbi.h

diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
index 0378b7f1bd58..47530f2732cf 100644
--- a/hw/riscv/boot.c
+++ b/hw/riscv/boot.c
@@ -26,6 +26,7 @@
 #include "hw/boards.h"
 #include "hw/loader.h"
 #include "hw/riscv/boot.h"
+#include "hw/riscv/boot_opensbi.h"
 #include "elf.h"
 #include "sysemu/device_tree.h"
 #include "sysemu/qtest.h"
@@ -34,8 +35,10 @@
 
 #if defined(TARGET_RISCV32)
 # define KERNEL_BOOT_ADDRESS 0x80400000
+#define fw_dynamic_info_data(__val)     cpu_to_le32(__val)
 #else
 # define KERNEL_BOOT_ADDRESS 0x80200000
+#define fw_dynamic_info_data(__val)     cpu_to_le64(__val)
 #endif
 
 void riscv_find_and_load_firmware(MachineState *machine,
@@ -183,13 +186,25 @@ hwaddr riscv_calc_fdt_load_addr(hwaddr dram_base, uint64_t mem_size, void *fdt)
 }
 
 void riscv_setup_rom_reset_vec(hwaddr start_addr, hwaddr rom_base,
-                               hwaddr rom_size,
+                               hwaddr rom_size, uint64_t kernel_entry,
                                hwaddr fdt_load_addr, void *fdt)
 {
     int i;
+    struct fw_dynamic_info dinfo;
+    uint64_t dinfo_len;
+
+    dinfo.magic = fw_dynamic_info_data(FW_DYNAMIC_INFO_MAGIC_VALUE);
+    dinfo.version =  fw_dynamic_info_data(FW_DYNAMIC_INFO_VERSION);
+    dinfo.next_mode = fw_dynamic_info_data(FW_DYNAMIC_INFO_NEXT_MODE_S);
+    dinfo.next_addr = fw_dynamic_info_data(kernel_entry);
+    dinfo.options = 0;
+    dinfo.boot_hart = 0;
+    dinfo_len = sizeof(dinfo);
+
     /* reset vector */
     uint32_t reset_vec[10] = {
         0x00000297,                  /* 1:  auipc  t0, %pcrel_hi(fw_dyn) */
+        0x02828613,                  /*     addi   a2, t0, %pcrel_lo(1b) */
         0xf1402573,                  /*     csrr   a0, mhartid  */
 #if defined(TARGET_RISCV32)
         0x0202a583,                  /*     lw     a1, 32(t0) */
@@ -199,7 +214,6 @@ void riscv_setup_rom_reset_vec(hwaddr start_addr, hwaddr rom_base,
         0x0182b283,                  /*     ld     t0, 24(t0) */
 #endif
         0x00028067,                  /*     jr     t0 */
-        0x00000000,
         start_addr,                  /* start: .dword */
         0x00000000,
         fdt_load_addr,               /* fdt_laddr: .dword */
@@ -214,6 +228,20 @@ void riscv_setup_rom_reset_vec(hwaddr start_addr, hwaddr rom_base,
     rom_add_blob_fixed_as("mrom.reset", reset_vec, sizeof(reset_vec),
                           rom_base, &address_space_memory);
 
+    /**
+     * copy the dynamic firmware info. This information is specific to
+     * OpenSBI but doesn't break any other firmware as long as they don't
+     * expect any certain value in "a2" register.
+     */
+    if (fdt_pack(fdt) || fdt_totalsize(fdt) >
+        rom_size - dinfo_len) {
+        error_report("not enough space to store device-tree");
+        exit(1);
+    }
+
+    rom_add_blob_fixed_as("mrom.finfo", &dinfo, dinfo_len,
+                           rom_base + sizeof(reset_vec),
+                           &address_space_memory);
     /* copy in the device tree */
     qemu_fdt_dumpdtb(fdt, fdt_totalsize(fdt));
 
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 1a1540c7f98d..11b8814b9240 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -327,6 +327,7 @@ static void sifive_u_machine_init(MachineState *machine)
     MemoryRegion *flash0 = g_new(MemoryRegion, 1);
     target_ulong start_addr = memmap[SIFIVE_U_DRAM].base;
     hwaddr fdt_load_addr;
+    uint64_t kernel_entry;
 
     /* Initialize SoC */
     object_initialize_child(OBJECT(machine), "soc", &s->soc,
@@ -356,7 +357,7 @@ static void sifive_u_machine_init(MachineState *machine)
                                  memmap[SIFIVE_U_DRAM].base, NULL);
 
     if (machine->kernel_filename) {
-        uint64_t kernel_entry = riscv_load_kernel(machine->kernel_filename,
+        kernel_entry = riscv_load_kernel(machine->kernel_filename,
                                                   NULL);
 
         if (machine->initrd_filename) {
@@ -369,6 +370,12 @@ static void sifive_u_machine_init(MachineState *machine)
             qemu_fdt_setprop_cell(s->fdt, "/chosen", "linux,initrd-end",
                                   end);
         }
+    } else {
+       /*
+        * If dynamic firmware is used, it doesn't know where is the next mode
+        * if kernel argument is not set.
+        */
+        kernel_entry = 0;
     }
 
     /* Compute the fdt load address in dram */
@@ -386,7 +393,7 @@ static void sifive_u_machine_init(MachineState *machine)
 
     /* load the reset vector */
     riscv_setup_rom_reset_vec(start_addr, memmap[SIFIVE_U_MROM].base,
-                              memmap[SIFIVE_U_MROM].size,
+                              memmap[SIFIVE_U_MROM].size, kernel_entry,
                               fdt_load_addr, s->fdt);
 }
 
diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index 2a34a1382487..bd29a2b38611 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -168,6 +168,7 @@ static void spike_board_init(MachineState *machine)
     MemoryRegion *mask_rom = g_new(MemoryRegion, 1);
     unsigned int smp_cpus = machine->smp.cpus;
     hwaddr fdt_load_addr;
+    uint64_t kernel_entry;
 
     /* Initialize SOC */
     object_initialize_child(OBJECT(machine), "soc", &s->soc, sizeof(s->soc),
@@ -199,7 +200,7 @@ static void spike_board_init(MachineState *machine)
                                  htif_symbol_callback);
 
     if (machine->kernel_filename) {
-        uint64_t kernel_entry = riscv_load_kernel(machine->kernel_filename,
+        kernel_entry = riscv_load_kernel(machine->kernel_filename,
                                                   htif_symbol_callback);
 
         if (machine->initrd_filename) {
@@ -212,6 +213,12 @@ static void spike_board_init(MachineState *machine)
             qemu_fdt_setprop_cell(s->fdt, "/chosen", "linux,initrd-end",
                                   end);
         }
+    } else {
+       /*
+        * If dynamic firmware is used, it doesn't know where is the next mode
+        * if kernel argument is not set.
+        */
+        kernel_entry = 0;
     }
 
     /* Compute the fdt load address in dram */
@@ -225,7 +232,7 @@ static void spike_board_init(MachineState *machine)
 
     /* load the reset vector */
     riscv_setup_rom_reset_vec(memmap[SPIKE_DRAM].base, memmap[SPIKE_MROM].base,
-                              memmap[SPIKE_MROM].size,
+                              memmap[SPIKE_MROM].size, kernel_entry,
                               fdt_load_addr, s->fdt);
 
     /* initialize HTIF using symbols found in load_kernel */
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index ebb5dd5c8c1c..7897eaa97301 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -482,6 +482,7 @@ static void virt_machine_init(MachineState *machine)
     size_t plic_hart_config_len;
     target_ulong start_addr = memmap[VIRT_DRAM].base;
     hwaddr fdt_load_addr;
+    uint64_t kernel_entry;
     int i;
     unsigned int smp_cpus = machine->smp.cpus;
 
@@ -514,7 +515,7 @@ static void virt_machine_init(MachineState *machine)
                                  memmap[VIRT_DRAM].base, NULL);
 
     if (machine->kernel_filename) {
-        uint64_t kernel_entry = riscv_load_kernel(machine->kernel_filename,
+        kernel_entry = riscv_load_kernel(machine->kernel_filename,
                                                   NULL);
 
         if (machine->initrd_filename) {
@@ -527,6 +528,12 @@ static void virt_machine_init(MachineState *machine)
             qemu_fdt_setprop_cell(s->fdt, "/chosen", "linux,initrd-end",
                                   end);
         }
+    } else {
+       /*
+        * If dynamic firmware is used, it doesn't know where is the next mode
+        * if kernel argument is not set.
+        */
+        kernel_entry = 0;
     }
 
     if (drive_get(IF_PFLASH, 0, 0)) {
@@ -548,7 +555,7 @@ static void virt_machine_init(MachineState *machine)
 
     /* load the reset vector */
     riscv_setup_rom_reset_vec(start_addr, virt_memmap[VIRT_MROM].base,
-                              virt_memmap[VIRT_MROM].size,
+                              virt_memmap[VIRT_MROM].size, kernel_entry,
                               fdt_load_addr, s->fdt);
 
     /* create PLIC hart topology configuration string */
diff --git a/include/hw/riscv/boot.h b/include/hw/riscv/boot.h
index b6289a05d952..2e7163e3fef2 100644
--- a/include/hw/riscv/boot.h
+++ b/include/hw/riscv/boot.h
@@ -38,7 +38,7 @@ hwaddr riscv_load_initrd(const char *filename, uint64_t mem_size,
 hwaddr riscv_calc_fdt_load_addr(hwaddr dram_start, uint64_t dram_size,
                                 void *fdt);
 void riscv_setup_rom_reset_vec(hwaddr saddr, hwaddr rom_base,
-                               hwaddr rom_size,
+                               hwaddr rom_size, hwaddr kernel_entry,
                                hwaddr fdt_load_addr, void *fdt);
 
 #endif /* RISCV_BOOT_H */
diff --git a/include/hw/riscv/boot_opensbi.h b/include/hw/riscv/boot_opensbi.h
new file mode 100644
index 000000000000..0d5ddd6c3daf
--- /dev/null
+++ b/include/hw/riscv/boot_opensbi.h
@@ -0,0 +1,58 @@
+/* SPDX-License-Identifier: BSD-2-Clause */
+/*
+ * Copyright (c) 2019 Western Digital Corporation or its affiliates.
+ *
+ * Based on include/sbi/{fw_dynamic.h,sbi_scratch.h} from the OpenSBI project.
+ */
+#ifndef OPENSBI_H
+#define OPENSBI_H
+
+/** Expected value of info magic ('OSBI' ascii string in hex) */
+#define FW_DYNAMIC_INFO_MAGIC_VALUE     0x4942534f
+
+/** Maximum supported info version */
+#define FW_DYNAMIC_INFO_VERSION         0x2
+
+/** Possible next mode values */
+#define FW_DYNAMIC_INFO_NEXT_MODE_U     0x0
+#define FW_DYNAMIC_INFO_NEXT_MODE_S     0x1
+#define FW_DYNAMIC_INFO_NEXT_MODE_M     0x3
+
+enum sbi_scratch_options {
+    /** Disable prints during boot */
+    SBI_SCRATCH_NO_BOOT_PRINTS = (1 << 0),
+    /** Enable runtime debug prints */
+    SBI_SCRATCH_DEBUG_PRINTS = (1 << 1),
+};
+
+/** Representation dynamic info passed by previous booting stage */
+struct fw_dynamic_info {
+    /** Info magic */
+    target_long magic;
+    /** Info version */
+    target_long version;
+    /** Next booting stage address */
+    target_long next_addr;
+    /** Next booting stage mode */
+    target_long next_mode;
+    /** Options for OpenSBI library */
+    target_long options;
+    /**
+     * Preferred boot HART id
+     *
+     * It is possible that the previous booting stage uses same link
+     * address as the FW_DYNAMIC firmware. In this case, the relocation
+     * lottery mechanism can potentially overwrite the previous booting
+     * stage while other HARTs are still running in the previous booting
+     * stage leading to boot-time crash. To avoid this boot-time crash,
+     * the previous booting stage can specify last HART that will jump
+     * to the FW_DYNAMIC firmware as the preferred boot HART.
+     *
+     * To avoid specifying a preferred boot HART, the previous booting
+     * stage can set it to -1UL which will force the FW_DYNAMIC firmware
+     * to use the relocation lottery mechanism.
+     */
+    target_long boot_hart;
+};
+
+#endif
-- 
2.26.2



Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 014E0C433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 00:46:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B432A218AC
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 00:46:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="c+/eHQbr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B432A218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jv95U-0003kf-Qz
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 20:46:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51950)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=457b4eeb6=alistair.francis@wdc.com>)
 id 1jv91q-0005qI-Ii
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 20:42:38 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:30779)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=457b4eeb6=alistair.francis@wdc.com>)
 id 1jv91o-0008Or-3q
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 20:42:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1594687356; x=1626223356;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=0mnpjjDd7Fku2qW/ycasrQUFJAWGVbH8DDRBJh/59c4=;
 b=c+/eHQbrov9BN1IyRZ6dhG+OavzpqZ123P+T6dm/p85SoxEJKZSzZGqg
 rIwxdgbijUcwoNhjCmPf1UhghGURB3lGXGXij2nEv1j9Lw/nRB60H4isU
 ilL3MdirDPM+L2J72/vGx5htoAap/mlCEfD76+gq2XI0nWj3Ihnsl47gm
 3m/hw0Bqg6JwFUF00RVU+PdcmHtwzyuvGrUJnuS/2pe65NlxetSB0IG1C
 vmUs7tNjhl14ehD70bzZmbR2wWDRKcscTfAH5+VUF0FKBLIqUwPQtj+k8
 bwIRCuZoNO1y4qXnRtlrmlEO05R7dnlJGvWO5Ex4puTq3iJheubOWye7M A==;
IronPort-SDR: xaxeNgkughGjZITYtrTjSzZB6GOFQ0KsQAbRKjTBcl58k6X23Dw1pBkGqUMN88cYcMpU/iy5+I
 CtkTq376aMgcHmYac+p+YRFbsFVWbJh88LCAcIWlZ1yM424kw1cvzi6oFsNSRvyte1NXhA6jzZ
 meb21bT3W+G6SZKOE/F86kxzZ5FdrAE1zf4jEuX62dXRdYqkO6HI9YCbahHrXkLEtipd8QL8Pe
 dpNo/nYUJg/LcpOyQJ/PRqrVMVVwoNOsQ0PW108LfucGJcWs+yvXIvX+lgeaOmWgcDmCP4oCVE
 vg8=
X-IronPort-AV: E=Sophos;i="5.75,349,1589212800"; d="scan'208";a="142511922"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 14 Jul 2020 08:42:28 +0800
IronPort-SDR: 3j+PQXB8r9hV/1R2UQp6USogQWmYjxkfP3XH/DP5f+Q+PqV6GwMXieYQycJnFiymcZJHbmpEH5
 LkEvZKPQFzevnvH7WAlOhiLLYa7nkRbvA=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jul 2020 17:30:57 -0700
IronPort-SDR: DBuaaRYepjFg16nMiAXG2znf/n/rykBAO9qwxFdmx+2Xa/7EbFoBmTzpXQ0FYtG7npCnDyMZMk
 +IF+TYrtxw9A==
WDCIronportException: Internal
Received: from usa002626.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.57.178])
 by uls-op-cesaip02.wdc.com with ESMTP; 13 Jul 2020 17:42:29 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Subject: [PULL 05/15] riscv: Add opensbi firmware dynamic support
Date: Mon, 13 Jul 2020 17:32:44 -0700
Message-Id: <20200714003254.4044149-6-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200714003254.4044149-1-alistair.francis@wdc.com>
References: <20200714003254.4044149-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.144;
 envelope-from=prvs=457b4eeb6=alistair.francis@wdc.com;
 helo=esa5.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 20:42:28
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Atish Patra <atish.patra@wdc.com>, Bin Meng <bin.meng@windriver.com>,
 Alistair Francis <alistair.francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Atish Patra <atish.patra@wdc.com>

OpenSBI is the default firmware in Qemu and has various firmware loading
options. Currently, qemu loader uses fw_jump which has a compile time
pre-defined address where fdt & kernel image must reside. This puts a
constraint on image size of the Linux kernel depending on the fdt location
and available memory. However, fw_dynamic allows the loader to specify
the next stage location (i.e. Linux kernel/U-Boot) in memory and other
configurable boot options available in OpenSBI.

Add support for OpenSBI dynamic firmware loading support. This doesn't
break existing setup and fw_jump will continue to work as it is. Any
other firmware will continue to work without any issues as long as it
doesn't expect anything specific from loader in "a2" register.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Bin Meng <bin.meng@windriver.com>
Tested-by: Bin Meng <bin.meng@windriver.com>
Message-Id: <20200701183949.398134-4-atish.patra@wdc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/riscv/boot.h         |  5 ++-
 include/hw/riscv/boot_opensbi.h | 58 +++++++++++++++++++++++++++++++++
 hw/riscv/boot.c                 | 42 +++++++++++++++++++++---
 hw/riscv/sifive_u.c             | 20 +++++++++---
 hw/riscv/spike.c                | 13 ++++++--
 hw/riscv/virt.c                 | 12 +++++--
 6 files changed, 134 insertions(+), 16 deletions(-)
 create mode 100644 include/hw/riscv/boot_opensbi.h

diff --git a/include/hw/riscv/boot.h b/include/hw/riscv/boot.h
index 35b6ddf710..451338780a 100644
--- a/include/hw/riscv/boot.h
+++ b/include/hw/riscv/boot.h
@@ -37,7 +37,10 @@ hwaddr riscv_load_initrd(const char *filename, uint64_t mem_size,
                          uint64_t kernel_entry, hwaddr *start);
 uint32_t riscv_load_fdt(hwaddr dram_start, uint64_t dram_size, void *fdt);
 void riscv_setup_rom_reset_vec(hwaddr saddr, hwaddr rom_base,
-                               hwaddr rom_size,
+                               hwaddr rom_size, uint64_t kernel_entry,
                                uint32_t fdt_load_addr, void *fdt);
+void riscv_rom_copy_firmware_info(hwaddr rom_base, hwaddr rom_size,
+                                  uint32_t reset_vec_size,
+                                  uint64_t kernel_entry);
 
 #endif /* RISCV_BOOT_H */
diff --git a/include/hw/riscv/boot_opensbi.h b/include/hw/riscv/boot_opensbi.h
new file mode 100644
index 0000000000..0d5ddd6c3d
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
diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
index c62f545f15..feff6e3f4e 100644
--- a/hw/riscv/boot.c
+++ b/hw/riscv/boot.c
@@ -25,6 +25,7 @@
 #include "hw/boards.h"
 #include "hw/loader.h"
 #include "hw/riscv/boot.h"
+#include "hw/riscv/boot_opensbi.h"
 #include "elf.h"
 #include "sysemu/device_tree.h"
 #include "sysemu/qtest.h"
@@ -33,8 +34,10 @@
 
 #if defined(TARGET_RISCV32)
 # define KERNEL_BOOT_ADDRESS 0x80400000
+#define fw_dynamic_info_data(__val)     cpu_to_le32(__val)
 #else
 # define KERNEL_BOOT_ADDRESS 0x80200000
+#define fw_dynamic_info_data(__val)     cpu_to_le64(__val)
 #endif
 
 void riscv_find_and_load_firmware(MachineState *machine,
@@ -189,15 +192,45 @@ uint32_t riscv_load_fdt(hwaddr dram_base, uint64_t mem_size, void *fdt)
     return fdt_addr;
 }
 
+void riscv_rom_copy_firmware_info(hwaddr rom_base, hwaddr rom_size,
+                              uint32_t reset_vec_size, uint64_t kernel_entry)
+{
+    struct fw_dynamic_info dinfo;
+    size_t dinfo_len;
+
+    dinfo.magic = fw_dynamic_info_data(FW_DYNAMIC_INFO_MAGIC_VALUE);
+    dinfo.version = fw_dynamic_info_data(FW_DYNAMIC_INFO_VERSION);
+    dinfo.next_mode = fw_dynamic_info_data(FW_DYNAMIC_INFO_NEXT_MODE_S);
+    dinfo.next_addr = fw_dynamic_info_data(kernel_entry);
+    dinfo.options = 0;
+    dinfo.boot_hart = 0;
+    dinfo_len = sizeof(dinfo);
+
+    /**
+     * copy the dynamic firmware info. This information is specific to
+     * OpenSBI but doesn't break any other firmware as long as they don't
+     * expect any certain value in "a2" register.
+     */
+    if (dinfo_len > (rom_size - reset_vec_size)) {
+        error_report("not enough space to store dynamic firmware info");
+        exit(1);
+    }
+
+    rom_add_blob_fixed_as("mrom.finfo", &dinfo, dinfo_len,
+                           rom_base + reset_vec_size,
+                           &address_space_memory);
+}
+
 void riscv_setup_rom_reset_vec(hwaddr start_addr, hwaddr rom_base,
-                               hwaddr rom_size,
+                               hwaddr rom_size, uint64_t kernel_entry,
                                uint32_t fdt_load_addr, void *fdt)
 {
     int i;
 
     /* reset vector */
     uint32_t reset_vec[10] = {
-        0x00000297,                  /* 1:  auipc  t0, %pcrel_hi(dtb) */
+        0x00000297,                  /* 1:  auipc  t0, %pcrel_hi(fw_dyn) */
+        0x02828613,                  /*     addi   a2, t0, %pcrel_lo(1b) */
         0xf1402573,                  /*     csrr   a0, mhartid  */
 #if defined(TARGET_RISCV32)
         0x0202a583,                  /*     lw     a1, 32(t0) */
@@ -207,12 +240,11 @@ void riscv_setup_rom_reset_vec(hwaddr start_addr, hwaddr rom_base,
         0x0182b283,                  /*     ld     t0, 24(t0) */
 #endif
         0x00028067,                  /*     jr     t0 */
-        0x00000000,
         start_addr,                  /* start: .dword */
         0x00000000,
         fdt_load_addr,               /* fdt_laddr: .dword */
         0x00000000,
-                                     /* dtb: */
+                                     /* fw_dyn: */
     };
 
     /* copy in the reset vector in little_endian byte order */
@@ -221,6 +253,8 @@ void riscv_setup_rom_reset_vec(hwaddr start_addr, hwaddr rom_base,
     }
     rom_add_blob_fixed_as("mrom.reset", reset_vec, sizeof(reset_vec),
                           rom_base, &address_space_memory);
+    riscv_rom_copy_firmware_info(rom_base, rom_size, sizeof(reset_vec),
+                                 kernel_entry);
 
     return;
 }
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 39923209f4..46e6ed90ca 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -380,6 +380,7 @@ static void sifive_u_machine_init(MachineState *machine)
     target_ulong start_addr = memmap[SIFIVE_U_DRAM].base;
     int i;
     uint32_t fdt_load_addr;
+    uint64_t kernel_entry;
 
     /* Initialize SoC */
     object_initialize_child(OBJECT(machine), "soc", &s->soc, TYPE_RISCV_U_SOC);
@@ -436,8 +437,7 @@ static void sifive_u_machine_init(MachineState *machine)
     riscv_find_and_load_firmware(machine, BIOS_FILENAME, start_addr, NULL);
 
     if (machine->kernel_filename) {
-        uint64_t kernel_entry = riscv_load_kernel(machine->kernel_filename,
-                                                  NULL);
+        kernel_entry = riscv_load_kernel(machine->kernel_filename, NULL);
 
         if (machine->initrd_filename) {
             hwaddr start;
@@ -449,6 +449,12 @@ static void sifive_u_machine_init(MachineState *machine)
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
@@ -458,7 +464,8 @@ static void sifive_u_machine_init(MachineState *machine)
     /* reset vector */
     uint32_t reset_vec[11] = {
         s->msel,                       /* MSEL pin state */
-        0x00000297,                    /* 1:  auipc  t0, %pcrel_hi(dtb) */
+        0x00000297,                    /* 1:  auipc  t0, %pcrel_hi(fw_dyn) */
+        0x02828613,                    /*     addi   a2, t0, %pcrel_lo(1b) */
         0xf1402573,                    /*     csrr   a0, mhartid  */
 #if defined(TARGET_RISCV32)
         0x0202a583,                    /*     lw     a1, 32(t0) */
@@ -468,12 +475,11 @@ static void sifive_u_machine_init(MachineState *machine)
         0x0182b283,                    /*     ld     t0, 24(t0) */
 #endif
         0x00028067,                    /*     jr     t0 */
-        0x00000000,
         start_addr,                    /* start: .dword */
         0x00000000,
         fdt_load_addr,                 /* fdt_laddr: .dword */
         0x00000000,
-                                       /* dtb: */
+                                       /* fw_dyn: */
     };
 
     /* copy in the reset vector in little_endian byte order */
@@ -482,6 +488,10 @@ static void sifive_u_machine_init(MachineState *machine)
     }
     rom_add_blob_fixed_as("mrom.reset", reset_vec, sizeof(reset_vec),
                           memmap[SIFIVE_U_MROM].base, &address_space_memory);
+
+    riscv_rom_copy_firmware_info(memmap[SIFIVE_U_MROM].base,
+                                 memmap[SIFIVE_U_MROM].size,
+                                 sizeof(reset_vec), kernel_entry);
 }
 
 static bool sifive_u_machine_get_start_in_flash(Object *obj, Error **errp)
diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index 13fa0455e3..b17d96aec7 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -164,6 +164,7 @@ static void spike_board_init(MachineState *machine)
     MemoryRegion *mask_rom = g_new(MemoryRegion, 1);
     unsigned int smp_cpus = machine->smp.cpus;
     uint32_t fdt_load_addr;
+    uint64_t kernel_entry;
 
     /* Initialize SOC */
     object_initialize_child(OBJECT(machine), "soc", &s->soc,
@@ -194,8 +195,8 @@ static void spike_board_init(MachineState *machine)
                                  htif_symbol_callback);
 
     if (machine->kernel_filename) {
-        uint64_t kernel_entry = riscv_load_kernel(machine->kernel_filename,
-                                                  htif_symbol_callback);
+        kernel_entry = riscv_load_kernel(machine->kernel_filename,
+                                         htif_symbol_callback);
 
         if (machine->initrd_filename) {
             hwaddr start;
@@ -207,6 +208,12 @@ static void spike_board_init(MachineState *machine)
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
@@ -214,7 +221,7 @@ static void spike_board_init(MachineState *machine)
                                    machine->ram_size, s->fdt);
     /* load the reset vector */
     riscv_setup_rom_reset_vec(memmap[SPIKE_DRAM].base, memmap[SPIKE_MROM].base,
-                              memmap[SPIKE_MROM].size,
+                              memmap[SPIKE_MROM].size, kernel_entry,
                               fdt_load_addr, s->fdt);
 
     /* initialize HTIF using symbols found in load_kernel */
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 9d87319f70..bc25ec69f7 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -479,6 +479,7 @@ static void virt_machine_init(MachineState *machine)
     size_t plic_hart_config_len;
     target_ulong start_addr = memmap[VIRT_DRAM].base;
     uint32_t fdt_load_addr;
+    uint64_t kernel_entry;
     int i;
     unsigned int smp_cpus = machine->smp.cpus;
 
@@ -510,8 +511,7 @@ static void virt_machine_init(MachineState *machine)
                                  memmap[VIRT_DRAM].base, NULL);
 
     if (machine->kernel_filename) {
-        uint64_t kernel_entry = riscv_load_kernel(machine->kernel_filename,
-                                                  NULL);
+        kernel_entry = riscv_load_kernel(machine->kernel_filename, NULL);
 
         if (machine->initrd_filename) {
             hwaddr start;
@@ -523,6 +523,12 @@ static void virt_machine_init(MachineState *machine)
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
@@ -538,7 +544,7 @@ static void virt_machine_init(MachineState *machine)
                                    machine->ram_size, s->fdt);
     /* load the reset vector */
     riscv_setup_rom_reset_vec(start_addr, virt_memmap[VIRT_MROM].base,
-                              virt_memmap[VIRT_MROM].size,
+                              virt_memmap[VIRT_MROM].size, kernel_entry,
                               fdt_load_addr, s->fdt);
 
     /* create PLIC hart topology configuration string */
-- 
2.27.0



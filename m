Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8225C433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 00:47:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8758821841
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 00:47:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="GMRhJ3ff"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8758821841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jv96K-0005ll-Pk
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 20:47:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51922)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=457b4eeb6=alistair.francis@wdc.com>)
 id 1jv91p-0005o5-78
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 20:42:37 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:30777)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=457b4eeb6=alistair.francis@wdc.com>)
 id 1jv91m-0008Oh-Rf
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 20:42:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1594687355; x=1626223355;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=RTr4YmQaz0AeM+DO20Ay2L9L1AunF1qn0y+huK4Wn68=;
 b=GMRhJ3ffU8SMaj2mzO8Z6NVVVqPWCj5MDliPREm2YYcPdHeAOFif1nl6
 VjllhtkxtPOyX9+BL5odVOeXKEPbt9LRNEsvVKCjcSEwTfzXglWVEGYly
 vg6xKxFqfDKumdbHs/VATO3kVNYA5H2RRRrPfZdXpH3QPNHaYNR+Ys5cv
 GEwp+6k2ZOR88LMYt8P6VkBUJ1GKioWM4EIkowUfTax7yI4TuHAb9p1YB
 P40Cx730zSnl28vaIelcy7H1csGjDMOV0+kJn3SnJCjbfUwAkmHX3W8d3
 i5bUgPTptoknVyhQm4gjJPU8AWb5g4AXk4OmYNhTQUCEMUmpek0RMcEsJ w==;
IronPort-SDR: 2fVBQqLtLVAt6CYXyyaq/bgDmim9jTLj2UhYZLXp/s9c6e9kWVK6h2PSi/YIq5g/Gi9jBR+83U
 PEU2X6W2W0rA6F2PFyFRLCIfn8B8T70CI8NL5yuhRWk2vpR+8f11NgRFWt5GAC/WQmri9Zo2qI
 mx/WK8ZGzpHa5y2D9mILszVSPYAKlnevU8nODVcSOdcvTyLQMpxZ15m1qUTuaF9h5RiNzR/laZ
 U/4jXVH2gdBhrFcqE/KQOB+Kw/XnQDF1k5hddR241GrfZEcHnYM/pR11vF5LBoehXjN76YHnm/
 KnU=
X-IronPort-AV: E=Sophos;i="5.75,349,1589212800"; d="scan'208";a="142511920"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 14 Jul 2020 08:42:28 +0800
IronPort-SDR: JTAChpfazoCGVLEx9ht6ilyW7+03wMGylN/HEj8E4rQ1EL0vpxDn9+KqhbzGGmphc1TtVNId66
 5oruZ2cY/1bMbrQwVCLv6ibyYqJ9uwArY=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jul 2020 17:30:56 -0700
IronPort-SDR: 5L7PkXEzOZrvSAV/tVjfAO9otOhZqTgI2wGfuVbAWd1BtpFHf74jJfQ4B4krapD0xXtzdJPFWq
 W+06Cvd56hGw==
WDCIronportException: Internal
Received: from usa002626.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.57.178])
 by uls-op-cesaip02.wdc.com with ESMTP; 13 Jul 2020 17:42:28 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Subject: [PULL 03/15] riscv: Unify Qemu's reset vector code path
Date: Mon, 13 Jul 2020 17:32:42 -0700
Message-Id: <20200714003254.4044149-4-alistair.francis@wdc.com>
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

Currently, all riscv machines except sifive_u have identical reset vector
code implementations with memory addresses being different for all machines.
They can be easily combined into a single function in common code.

Move it to common function and let all the machines use the common function.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Bin Meng <bin.meng@windriver.com>
Tested-by: Bin Meng <bin.meng@windriver.com>
Message-Id: <20200701183949.398134-2-atish.patra@wdc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/riscv/boot.h |  2 ++
 hw/riscv/boot.c         | 46 +++++++++++++++++++++++++++++++++++++++++
 hw/riscv/sifive_u.c     |  1 -
 hw/riscv/spike.c        | 41 +++---------------------------------
 hw/riscv/virt.c         | 40 +++--------------------------------
 5 files changed, 54 insertions(+), 76 deletions(-)

diff --git a/include/hw/riscv/boot.h b/include/hw/riscv/boot.h
index 9daa98da08..3e9759c89a 100644
--- a/include/hw/riscv/boot.h
+++ b/include/hw/riscv/boot.h
@@ -35,5 +35,7 @@ target_ulong riscv_load_kernel(const char *kernel_filename,
                                symbol_fn_t sym_cb);
 hwaddr riscv_load_initrd(const char *filename, uint64_t mem_size,
                          uint64_t kernel_entry, hwaddr *start);
+void riscv_setup_rom_reset_vec(hwaddr saddr, hwaddr rom_base,
+                               hwaddr rom_size, void *fdt);
 
 #endif /* RISCV_BOOT_H */
diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
index adb421b91b..3df802380a 100644
--- a/hw/riscv/boot.c
+++ b/hw/riscv/boot.c
@@ -26,8 +26,11 @@
 #include "hw/loader.h"
 #include "hw/riscv/boot.h"
 #include "elf.h"
+#include "sysemu/device_tree.h"
 #include "sysemu/qtest.h"
 
+#include <libfdt.h>
+
 #if defined(TARGET_RISCV32)
 # define KERNEL_BOOT_ADDRESS 0x80400000
 #else
@@ -155,3 +158,46 @@ hwaddr riscv_load_initrd(const char *filename, uint64_t mem_size,
 
     return *start + size;
 }
+
+void riscv_setup_rom_reset_vec(hwaddr start_addr, hwaddr rom_base,
+                               hwaddr rom_size, void *fdt)
+{
+    int i;
+
+    /* reset vector */
+    uint32_t reset_vec[8] = {
+        0x00000297,                  /* 1:  auipc  t0, %pcrel_hi(dtb) */
+        0x02028593,                  /*     addi   a1, t0, %pcrel_lo(1b) */
+        0xf1402573,                  /*     csrr   a0, mhartid  */
+#if defined(TARGET_RISCV32)
+        0x0182a283,                  /*     lw     t0, 24(t0) */
+#elif defined(TARGET_RISCV64)
+        0x0182b283,                  /*     ld     t0, 24(t0) */
+#endif
+        0x00028067,                  /*     jr     t0 */
+        0x00000000,
+        start_addr,                  /* start: .dword */
+        0x00000000,
+                                     /* dtb: */
+    };
+
+    /* copy in the reset vector in little_endian byte order */
+    for (i = 0; i < sizeof(reset_vec) >> 2; i++) {
+        reset_vec[i] = cpu_to_le32(reset_vec[i]);
+    }
+    rom_add_blob_fixed_as("mrom.reset", reset_vec, sizeof(reset_vec),
+                          rom_base, &address_space_memory);
+
+    /* copy in the device tree */
+    if (fdt_pack(fdt) || fdt_totalsize(fdt) >
+        rom_size - sizeof(reset_vec)) {
+        error_report("not enough space to store device-tree");
+        exit(1);
+    }
+    qemu_fdt_dumpdtb(fdt, fdt_totalsize(fdt));
+    rom_add_blob_fixed_as("mrom.fdt", fdt, fdt_totalsize(fdt),
+                           rom_base + sizeof(reset_vec),
+                           &address_space_memory);
+
+    return;
+}
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 7851326988..0695c93d2c 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -56,7 +56,6 @@
 #include "sysemu/device_tree.h"
 #include "sysemu/runstate.h"
 #include "sysemu/sysemu.h"
-#include "exec/address-spaces.h"
 
 #include <libfdt.h>
 
diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index c107bf3ba1..a8a0588824 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -41,9 +41,6 @@
 #include "sysemu/device_tree.h"
 #include "sysemu/qtest.h"
 #include "sysemu/sysemu.h"
-#include "exec/address-spaces.h"
-
-#include <libfdt.h>
 
 #if defined(TARGET_RISCV32)
 # define BIOS_FILENAME "opensbi-riscv32-spike-fw_jump.elf"
@@ -165,7 +162,6 @@ static void spike_board_init(MachineState *machine)
     MemoryRegion *system_memory = get_system_memory();
     MemoryRegion *main_mem = g_new(MemoryRegion, 1);
     MemoryRegion *mask_rom = g_new(MemoryRegion, 1);
-    int i;
     unsigned int smp_cpus = machine->smp.cpus;
 
     /* Initialize SOC */
@@ -212,40 +208,9 @@ static void spike_board_init(MachineState *machine)
         }
     }
 
-    /* reset vector */
-    uint32_t reset_vec[8] = {
-        0x00000297,                  /* 1:  auipc  t0, %pcrel_hi(dtb) */
-        0x02028593,                  /*     addi   a1, t0, %pcrel_lo(1b) */
-        0xf1402573,                  /*     csrr   a0, mhartid  */
-#if defined(TARGET_RISCV32)
-        0x0182a283,                  /*     lw     t0, 24(t0) */
-#elif defined(TARGET_RISCV64)
-        0x0182b283,                  /*     ld     t0, 24(t0) */
-#endif
-        0x00028067,                  /*     jr     t0 */
-        0x00000000,
-        memmap[SPIKE_DRAM].base,     /* start: .dword DRAM_BASE */
-        0x00000000,
-                                     /* dtb: */
-    };
-
-    /* copy in the reset vector in little_endian byte order */
-    for (i = 0; i < sizeof(reset_vec) >> 2; i++) {
-        reset_vec[i] = cpu_to_le32(reset_vec[i]);
-    }
-    rom_add_blob_fixed_as("mrom.reset", reset_vec, sizeof(reset_vec),
-                          memmap[SPIKE_MROM].base, &address_space_memory);
-
-    /* copy in the device tree */
-    if (fdt_pack(s->fdt) || fdt_totalsize(s->fdt) >
-            memmap[SPIKE_MROM].size - sizeof(reset_vec)) {
-        error_report("not enough space to store device-tree");
-        exit(1);
-    }
-    qemu_fdt_dumpdtb(s->fdt, fdt_totalsize(s->fdt));
-    rom_add_blob_fixed_as("mrom.fdt", s->fdt, fdt_totalsize(s->fdt),
-                          memmap[SPIKE_MROM].base + sizeof(reset_vec),
-                          &address_space_memory);
+    /* load the reset vector */
+    riscv_setup_rom_reset_vec(memmap[SPIKE_DRAM].base, memmap[SPIKE_MROM].base,
+                              memmap[SPIKE_MROM].size, s->fdt);
 
     /* initialize HTIF using symbols found in load_kernel */
     htif_mm_init(system_memory, mask_rom, &s->soc.harts[0].env, serial_hd(0));
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 18283e262e..3463cf54aa 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -39,12 +39,9 @@
 #include "sysemu/arch_init.h"
 #include "sysemu/device_tree.h"
 #include "sysemu/sysemu.h"
-#include "exec/address-spaces.h"
 #include "hw/pci/pci.h"
 #include "hw/pci-host/gpex.h"
 
-#include <libfdt.h>
-
 #if defined(TARGET_RISCV32)
 # define BIOS_FILENAME "opensbi-riscv32-virt-fw_jump.bin"
 #else
@@ -535,40 +532,9 @@ static void virt_machine_init(MachineState *machine)
         start_addr = virt_memmap[VIRT_FLASH].base;
     }
 
-    /* reset vector */
-    uint32_t reset_vec[8] = {
-        0x00000297,                  /* 1:  auipc  t0, %pcrel_hi(dtb) */
-        0x02028593,                  /*     addi   a1, t0, %pcrel_lo(1b) */
-        0xf1402573,                  /*     csrr   a0, mhartid  */
-#if defined(TARGET_RISCV32)
-        0x0182a283,                  /*     lw     t0, 24(t0) */
-#elif defined(TARGET_RISCV64)
-        0x0182b283,                  /*     ld     t0, 24(t0) */
-#endif
-        0x00028067,                  /*     jr     t0 */
-        0x00000000,
-        start_addr,                  /* start: .dword */
-        0x00000000,
-                                     /* dtb: */
-    };
-
-    /* copy in the reset vector in little_endian byte order */
-    for (i = 0; i < sizeof(reset_vec) >> 2; i++) {
-        reset_vec[i] = cpu_to_le32(reset_vec[i]);
-    }
-    rom_add_blob_fixed_as("mrom.reset", reset_vec, sizeof(reset_vec),
-                          memmap[VIRT_MROM].base, &address_space_memory);
-
-    /* copy in the device tree */
-    if (fdt_pack(s->fdt) || fdt_totalsize(s->fdt) >
-            memmap[VIRT_MROM].size - sizeof(reset_vec)) {
-        error_report("not enough space to store device-tree");
-        exit(1);
-    }
-    qemu_fdt_dumpdtb(s->fdt, fdt_totalsize(s->fdt));
-    rom_add_blob_fixed_as("mrom.fdt", s->fdt, fdt_totalsize(s->fdt),
-                          memmap[VIRT_MROM].base + sizeof(reset_vec),
-                          &address_space_memory);
+    /* load the reset vector */
+    riscv_setup_rom_reset_vec(start_addr, virt_memmap[VIRT_MROM].base,
+                              virt_memmap[VIRT_MROM].size, s->fdt);
 
     /* create PLIC hart topology configuration string */
     plic_hart_config_len = (strlen(VIRT_PLIC_HART_CONFIG) + 1) * smp_cpus;
-- 
2.27.0



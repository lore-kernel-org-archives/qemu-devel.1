Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98B79C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 19:30:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4907E2080D
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 19:30:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="jmfqz4hy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4907E2080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlHHa-0001Fn-KD
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 15:30:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47274)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=4293a8cce=atish.patra@wdc.com>)
 id 1jlHF7-0005nk-6w; Tue, 16 Jun 2020 15:27:33 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:63296)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=4293a8cce=atish.patra@wdc.com>)
 id 1jlHF5-000622-3V; Tue, 16 Jun 2020 15:27:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1592335651; x=1623871651;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=acVEzmGxMq5i2mw+86R6C3MzLML3ZaDYcYbc+1akf5o=;
 b=jmfqz4hyDRiXFKa9xOel8peqRfsQjDQOOPVR5x5T8J6Aar6tT/3XFRm9
 FT2mXZXLTg78+jHUv5W9c+3XlHQrYaXiiZNZ6W1a8TYCGN0YsdfmXsEtM
 AiampMjnJH3Sk0WfKis7xx1UkP307f0IyIFgyfLnhAwi7RNB1oZp1bcX2
 vIeC9oPNlmYPuCriVPPhmjyAPs+ByNMeL8FZp4VuRvWTZAJfol2vyl7Te
 M5bUwk7Tn+zyoyU5cz/jxROvlDTuOLweCbBas0BHFlZZV7+NHFd6bHk6G
 imlp+E7P2vL2OBpzKRooNRZLVk3OCAtKCEM/ouf9t14AQD+b4Va760+jf Q==;
IronPort-SDR: gO1Wm8p85DoLhbnr33bFPdDYP42y4KfW1c43zE3FzNf3qIU2CG3rwLuGVZR78lq8ugEJfR4wjM
 KirRthL2FKcqNZ2I3yt53eQ9yGmiTTof0WRrPpth5z1biGz+dzJqsGAYkFNkLUeHWwQzOqCV2a
 d1g13rgaxiy07b5IVZCEKxNeQC5y9L2liwcIyl51AE45/Emof9KHOg+0+954g878eqPjSa+fMg
 BVhE+OQxpSSklUg0NYsk29l8rM+ShWTMt3EAWClSIbA+JwqjEcacrMthnBDuIHqyJetoruNXmd
 33E=
X-IronPort-AV: E=Sophos;i="5.73,519,1583164800"; d="scan'208";a="140158602"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 17 Jun 2020 03:27:22 +0800
IronPort-SDR: 7b2r1hhEMp2mIy/m15ByOCTts/KNUfhze7rkvoHUvf7iKNJ8Sq3cn+SO9B5Cfew49uy0MNMErR
 ygM+5oRzLJg5vps4T7JQDlUrDj8Ihp2jg=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jun 2020 12:16:38 -0700
IronPort-SDR: hxs08aX/4CHFGeO0iW2+33M5o+yPbdXs5Wk3jxXj+8GXL0MKtvVj7z0NgTVQhEXBx5e7CiVxom
 tU4mvxIS8nfA==
WDCIronportException: Internal
Received: from usa001615.ad.shared (HELO yoda.hgst.com) ([10.86.58.120])
 by uls-op-cesaip02.wdc.com with ESMTP; 16 Jun 2020 12:27:22 -0700
From: Atish Patra <atish.patra@wdc.com>
To: qemu-devel@nongnu.org
Subject: [PATCH  1/3] riscv: Unify Qemu's reset vector code path
Date: Tue, 16 Jun 2020 12:26:58 -0700
Message-Id: <20200616192700.1900260-2-atish.patra@wdc.com>
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

Currently, all riscv machines have identical reset vector code
implementations with memory addresses being different for all machines.
They can be easily combined into a single function in common code.

Move it to common function and let all the machines use the common function.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 hw/riscv/boot.c         | 46 +++++++++++++++++++++++++++++++++++++++++
 hw/riscv/sifive_u.c     | 38 +++-------------------------------
 hw/riscv/spike.c        | 38 +++-------------------------------
 hw/riscv/virt.c         | 37 +++------------------------------
 include/hw/riscv/boot.h |  2 ++
 5 files changed, 57 insertions(+), 104 deletions(-)

diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
index adb421b91b68..8ed96da600c9 100644
--- a/hw/riscv/boot.c
+++ b/hw/riscv/boot.c
@@ -22,12 +22,16 @@
 #include "qemu/units.h"
 #include "qemu/error-report.h"
 #include "exec/cpu-defs.h"
+#include "exec/address-spaces.h"
 #include "hw/boards.h"
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
@@ -155,3 +159,45 @@ hwaddr riscv_load_initrd(const char *filename, uint64_t mem_size,
 
     return *start + size;
 }
+
+void riscv_setup_rom_reset_vec(hwaddr start_addr, hwaddr rom_base,
+                               hwaddr rom_size, void *fdt)
+{
+    int i;
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
index f9fef2be9170..c2712570e0d9 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -325,7 +325,6 @@ static void sifive_u_machine_init(MachineState *machine)
     MemoryRegion *main_mem = g_new(MemoryRegion, 1);
     MemoryRegion *flash0 = g_new(MemoryRegion, 1);
     target_ulong start_addr = memmap[SIFIVE_U_DRAM].base;
-    int i;
 
     /* Initialize SoC */
     object_initialize_child(OBJECT(machine), "soc", &s->soc,
@@ -374,40 +373,9 @@ static void sifive_u_machine_init(MachineState *machine)
         start_addr = memmap[SIFIVE_U_FLASH0].base;
     }
 
-    /* reset vector */
-    uint32_t reset_vec[8] = {
-        0x00000297,                    /* 1:  auipc  t0, %pcrel_hi(dtb) */
-        0x02028593,                    /*     addi   a1, t0, %pcrel_lo(1b) */
-        0xf1402573,                    /*     csrr   a0, mhartid  */
-#if defined(TARGET_RISCV32)
-        0x0182a283,                    /*     lw     t0, 24(t0) */
-#elif defined(TARGET_RISCV64)
-        0x0182b283,                    /*     ld     t0, 24(t0) */
-#endif
-        0x00028067,                    /*     jr     t0 */
-        0x00000000,
-        start_addr,                    /* start: .dword */
-        0x00000000,
-                                       /* dtb: */
-    };
-
-    /* copy in the reset vector in little_endian byte order */
-    for (i = 0; i < sizeof(reset_vec) >> 2; i++) {
-        reset_vec[i] = cpu_to_le32(reset_vec[i]);
-    }
-    rom_add_blob_fixed_as("mrom.reset", reset_vec, sizeof(reset_vec),
-                          memmap[SIFIVE_U_MROM].base, &address_space_memory);
-
-    /* copy in the device tree */
-    if (fdt_pack(s->fdt) || fdt_totalsize(s->fdt) >
-            memmap[SIFIVE_U_MROM].size - sizeof(reset_vec)) {
-        error_report("not enough space to store device-tree");
-        exit(1);
-    }
-    qemu_fdt_dumpdtb(s->fdt, fdt_totalsize(s->fdt));
-    rom_add_blob_fixed_as("mrom.fdt", s->fdt, fdt_totalsize(s->fdt),
-                          memmap[SIFIVE_U_MROM].base + sizeof(reset_vec),
-                          &address_space_memory);
+    /* load the reset vector */
+    riscv_setup_rom_reset_vec(start_addr, memmap[SIFIVE_U_MROM].base,
+                              memmap[SIFIVE_U_MROM].size, s->fdt);
 }
 
 static bool sifive_u_machine_get_start_in_flash(Object *obj, Error **errp)
diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index 7bbbdb50363d..238eae48716a 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -165,7 +165,6 @@ static void spike_board_init(MachineState *machine)
     MemoryRegion *system_memory = get_system_memory();
     MemoryRegion *main_mem = g_new(MemoryRegion, 1);
     MemoryRegion *mask_rom = g_new(MemoryRegion, 1);
-    int i;
     unsigned int smp_cpus = machine->smp.cpus;
 
     /* Initialize SOC */
@@ -213,40 +212,9 @@ static void spike_board_init(MachineState *machine)
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
index 4e4c494a7050..a8e2d58cc067 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -536,40 +536,9 @@ static void virt_machine_init(MachineState *machine)
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
diff --git a/include/hw/riscv/boot.h b/include/hw/riscv/boot.h
index 9daa98da08d7..3e9759c89aa2 100644
--- a/include/hw/riscv/boot.h
+++ b/include/hw/riscv/boot.h
@@ -35,5 +35,7 @@ target_ulong riscv_load_kernel(const char *kernel_filename,
                                symbol_fn_t sym_cb);
 hwaddr riscv_load_initrd(const char *filename, uint64_t mem_size,
                          uint64_t kernel_entry, hwaddr *start);
+void riscv_setup_rom_reset_vec(hwaddr saddr, hwaddr rom_base,
+                               hwaddr rom_size, void *fdt);
 
 #endif /* RISCV_BOOT_H */
-- 
2.26.2



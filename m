Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99194C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 18:41:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6878120748
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 18:41:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="BPov/Qnl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6878120748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqhfS-0002gH-MW
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 14:41:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47828)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=4447ca4a2=atish.patra@wdc.com>)
 id 1jqheM-0000zk-Ps; Wed, 01 Jul 2020 14:40:02 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:13131)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=4447ca4a2=atish.patra@wdc.com>)
 id 1jqheJ-0006SU-KX; Wed, 01 Jul 2020 14:40:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593628799; x=1625164799;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=WeVV+ECuPk5S81Hthax5qKFbwjjza9mjQLe8acb8+KE=;
 b=BPov/QnlNQabUhLzsSjWW6DAMmS2o6yKzl4Izpj2AwXrI4M3P/qC/8og
 LvIdN2wm3o0EHV7RGxjNfXy2Sh2bDKDhYmI8hBmCcxqutRDKKkfvkIYuK
 0lK2cIW33XNwu3ijRuPzV1uKDLZZ7aSHOWnuh39kvaVqEmRo83NtO86ax
 dpVQ6ALG87yeUH+Hwvabl6/lmExwnsU4lj9Q6pExo9A8XN3snkk+n6div
 blHFC1Y/8i2d2DSqGgbvexN45Oza0Yx99iiY2A7enfQBjm5H2v0OOukMw
 e6EHPC/ZvKKC81QdYoa4X3sQDLRi0ZmWi/9MnDNYYeJZBFVhGAGdOj2rK g==;
IronPort-SDR: S/SLPMvhTLUxEGPdY/V/7H0cAzgbDSMp9k+W+IOj1xdraezDrUu0IArbl2QJurEBhz2AStmSmO
 4nMXLjgal8/OMh8Epv3D0qTUoECetWgtNWlDfSeR+b5tRQTozI7XapTTOURaq+Sl7MSD4/OUoH
 X/MHTVRCgoX42Uy3q8OTCV4kLMLMLJ90hqs7fA2gs2uXeo2GBF8YJ98Dy/wmCEBMxYbpL7KSG2
 ocwCiL9rHEv+VGFmodwaI2LR6vmjCr3u06bOrOZ8vfBQNky3ptJQIvwt9Foz1s2ZIdfKtVb0zh
 238=
X-IronPort-AV: E=Sophos;i="5.75,301,1589212800"; d="scan'208";a="250642368"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 02 Jul 2020 02:39:53 +0800
IronPort-SDR: g/tvrr31HB5MKjZleoxyWNrzSaotj3e6gkDIkQ7YsaK3uFTuSJO9nWIYjNSKKBZbQtVnqoAkHe
 oYQj6B8QBmxVMrcIY5k0V6UYmz4aLDLpA=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2020 11:28:10 -0700
IronPort-SDR: 6ImAleFFqP7dq9OJfXgEkqJEj6XVutTnFD+NgPi8EaaP7nSsIMHgsYCvTuD9APbEzqbzkee8x0
 ciYGCo0W4GFQ==
WDCIronportException: Internal
Received: from cnf006900.ad.shared (HELO yoda.hgst.com) ([10.86.58.95])
 by uls-op-cesaip02.wdc.com with ESMTP; 01 Jul 2020 11:39:53 -0700
From: Atish Patra <atish.patra@wdc.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 1/4] riscv: Unify Qemu's reset vector code path
Date: Wed,  1 Jul 2020 11:39:46 -0700
Message-Id: <20200701183949.398134-2-atish.patra@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200701183949.398134-1-atish.patra@wdc.com>
References: <20200701183949.398134-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=4447ca4a2=atish.patra@wdc.com; helo=esa1.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/01 14:39:54
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
 Bin Meng <bin.meng@windriver.com>, Atish Patra <atish.patra@wdc.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Alexander Richardson <Alexander.Richardson@cl.cam.ac.uk>,
 Palmer Dabbelt <palmer@dabbelt.com>, Bin Meng <bmeng.cn@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently, all riscv machines except sifive_u have identical reset vector
code implementations with memory addresses being different for all machines.
They can be easily combined into a single function in common code.

Move it to common function and let all the machines use the common function.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Bin Meng <bin.meng@windriver.com>
Tested-by: Bin Meng <bin.meng@windriver.com>
---
 hw/riscv/boot.c         | 46 +++++++++++++++++++++++++++++++++++++++++
 hw/riscv/sifive_u.c     |  1 -
 hw/riscv/spike.c        | 41 +++---------------------------------
 hw/riscv/virt.c         | 40 +++--------------------------------
 include/hw/riscv/boot.h |  2 ++
 5 files changed, 54 insertions(+), 76 deletions(-)

diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
index adb421b91b68..3df802380a36 100644
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
index 7d051e7c9299..395b21703ab4 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -56,7 +56,6 @@
 #include "sysemu/device_tree.h"
 #include "sysemu/runstate.h"
 #include "sysemu/sysemu.h"
-#include "exec/address-spaces.h"
 
 #include <libfdt.h>
 
diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index 3c87e04fdceb..c696077cbc16 100644
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
index 616db6f5aced..8ec77e43de26 100644
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



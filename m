Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5954BC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 18:39:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21BC420789
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 18:39:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="OJrAWn4F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21BC420789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joWmN-0000t3-CP
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 14:39:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37604)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=43885dcdb=atish.patra@wdc.com>)
 id 1joWl0-0007tn-MZ; Thu, 25 Jun 2020 14:37:54 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:3333)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=43885dcdb=atish.patra@wdc.com>)
 id 1joWky-0006Ic-Ic; Thu, 25 Jun 2020 14:37:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593110273; x=1624646273;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Ai2mrRf9+4yzmnnkppKa9kqzIiDSms8AG3F3kLHnLpU=;
 b=OJrAWn4FZeoK/kC9MIG4xzVTdIYMOYgehh5CGB4ZtAainTh0kt9kGmN8
 XBnxM5FQFMH+iGs1m7WrsVZwYuBgxLC8L29cZ/tSWQjHzzXW/n/QGnPGd
 4nm1L1vbaLzz+o4daZBPTLQ09P8BRVYIQhFufprqIT7rr1fJzH5dEiWn8
 cplYJFwCJT5Wv2HBu1Iv1zkdQ1FX8GWjeZMTDC31uqaBVYKhXVB5G4yu8
 fmx5Iqbswydt1ITdvrXjem8CGkwJGm8EJ9QBrqxaEaDS8aG2H1itVD4qB
 2van/1dvkaX11bSU2INPc0MJDjIZzqEi7wU/EJCD2MIv+1hSsMUzZYFCx g==;
IronPort-SDR: Y286Xhwet0Ozn3L5LJYw18eOfR8vkBetCLSozPM7LIOtcJb3klP3IAYLip1tTlfhGQf6jeiu28
 icS4PcJ2j5jbcw3RU8PUX+uF+S51WJVbMLkXyXi3qMo9sT23bv6MvRJypyTyb3WBghQAOw2ExP
 A8EiCixQ7wgnJsRpBK3g6YNN/pFPyA7dbsFIZqc04YJeksP2cpNpNN3h5+tAGgIh08JfVui9uA
 vlvhqQVT/PL+CbGDdMyoGcjYJldAc9AQcEq/ObKBPFGIW7H9CnNnVF37GOejE+yIcqQKGM66tR
 ZxI=
X-IronPort-AV: E=Sophos;i="5.75,280,1589212800"; d="scan'208";a="145259210"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 26 Jun 2020 02:37:45 +0800
IronPort-SDR: 5obrPZPBl2ZChmzxhLLoFyf3753nY+SAVyk/q+Z9ThA1Kvfp7xQOxjZP3kJgzeyr8q+Tvy2kxH
 u6tGkxItkMll6N6/kV0SFrNL0SnbDDUlw=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jun 2020 11:26:45 -0700
IronPort-SDR: KMtH/aghD2EdGCthrzRqMJB085frxxtGq0daVTHhXZUyQfjqUgjq9rgCdsiOLrd4KmFFG9FBwe
 jeqanOJGzhBw==
WDCIronportException: Internal
Received: from usa003490.ad.shared (HELO yoda.hgst.com) ([10.86.58.205])
 by uls-op-cesaip02.wdc.com with ESMTP; 25 Jun 2020 11:37:44 -0700
From: Atish Patra <atish.patra@wdc.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/3] riscv: Unify Qemu's reset vector code path
Date: Thu, 25 Jun 2020 11:37:39 -0700
Message-Id: <20200625183741.642407-2-atish.patra@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200625183741.642407-1-atish.patra@wdc.com>
References: <20200625183741.642407-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=43885dcdb=atish.patra@wdc.com; helo=esa3.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 14:37:44
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
---
 hw/riscv/boot.c         | 46 +++++++++++++++++++++++++++++++++++++++++
 hw/riscv/spike.c        | 38 +++-------------------------------
 hw/riscv/virt.c         | 37 +++------------------------------
 include/hw/riscv/boot.h |  2 ++
 4 files changed, 54 insertions(+), 69 deletions(-)

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
diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index 3c87e04fdceb..561642c1fb5d 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -165,7 +165,6 @@ static void spike_board_init(MachineState *machine)
     MemoryRegion *system_memory = get_system_memory();
     MemoryRegion *main_mem = g_new(MemoryRegion, 1);
     MemoryRegion *mask_rom = g_new(MemoryRegion, 1);
-    int i;
     unsigned int smp_cpus = machine->smp.cpus;
 
     /* Initialize SOC */
@@ -212,40 +211,9 @@ static void spike_board_init(MachineState *machine)
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
index 616db6f5aced..22a60259daab 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -535,40 +535,9 @@ static void virt_machine_init(MachineState *machine)
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



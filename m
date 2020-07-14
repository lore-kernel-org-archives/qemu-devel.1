Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E99EEC433E3
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 00:43:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB51921835
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 00:43:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="RaybC3Yz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB51921835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jv932-0007X6-Vk
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 20:43:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51942)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=457b4eeb6=alistair.francis@wdc.com>)
 id 1jv91q-0005p7-5U
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 20:42:38 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:30774)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=457b4eeb6=alistair.francis@wdc.com>)
 id 1jv91m-0008OU-W2
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 20:42:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1594687355; x=1626223355;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=k+1QW0q23n73wDCV8zO635Gso9BXwKYiJeX1dNBB2Wc=;
 b=RaybC3YzanHZlTmzBuCs8b9+iynZb+QQrV2v+SF/Jc7taJJQWEBwMnKh
 T8hZHRbb7Jvu9UlD1wk/NBNciWZmaquzVxrXQnE7ULb4nIL13A3HI3HIA
 BNV2Na7vU3tsceM71xSX1uiz7D0vdLKMwfx6YT+Y43ngrRE4ffx6mvH41
 64WAoDzkpNUIklYZjBS1QT/L+15ZvLCgENwOlICPW72EUuqLFHqz83Zsv
 h6bS1P+1VkxW3TdCYi2F2eWPvPGcvvRecGSM85s+sTK/N3PIxiKryjljv
 CyYIFHTk7flBKbKe3FTxrDT8mvyDtTeSXW5q3n74mr4hCGw3LAfWDx7o6 Q==;
IronPort-SDR: bk1rXHwW6QcYOYYzc+ICPGmyqMMXo7tzcW59qRP6uSLogHRYLwAVUHVFmEkQIdsm6h/amnqgt6
 8gzK4m0Dzl6x82YpGFijY/VyuBrVzF/3bNCxSmrPAJqTbPLNpF0cEr+1mY2QM/WzMdiIFWnNs0
 d7WL9tCfH4Ham/KSVZsv4nDYOr+XK/jRb50L4uyhjfklrnW7xLi8HvSmJNIBD880KIUpafPq+X
 DataoYUZLE8psLIu4uz5tTsc2EZ/1925oXgpdU/Svi1J9rtzXBgQjDLlAer+wSnAx6XiqHtIIt
 /W0=
X-IronPort-AV: E=Sophos;i="5.75,349,1589212800"; d="scan'208";a="142511921"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 14 Jul 2020 08:42:28 +0800
IronPort-SDR: 8h6WUqJP8gC1Q7L6ILjOmNQvtSd9jSPf+q9+mKLX/ITCvdGY5MFqqJM6DJuvqK/t53cTdQn5iY
 rDZ8OXpcw0XkimqJdeGVRDyio5JQ2mV44=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jul 2020 17:30:56 -0700
IronPort-SDR: Q9xU5vLAORwh9OQUXxH3qTrR0DMaPQxZU+J6//06h3+7ZrySS9ZJtu865RM7QR2Bu1c8pM8s0p
 AFjxDpeBbaYw==
WDCIronportException: Internal
Received: from usa002626.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.57.178])
 by uls-op-cesaip02.wdc.com with ESMTP; 13 Jul 2020 17:42:28 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Subject: [PULL 04/15] RISC-V: Copy the fdt in dram instead of ROM
Date: Mon, 13 Jul 2020 17:32:43 -0700
Message-Id: <20200714003254.4044149-5-alistair.francis@wdc.com>
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

Currently, the fdt is copied to the ROM after the reset vector. The firmware
has to copy it to DRAM. Instead of this, directly copy the device tree to a
pre-computed dram address. The device tree load address should be as far as
possible from kernel and initrd images. That's why it is kept at the end of
the DRAM or 4GB whichever is lesser.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Bin Meng <bin.meng@windriver.com>
Tested-by: Bin Meng <bin.meng@windriver.com>
Message-Id: <20200701183949.398134-3-atish.patra@wdc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/riscv/boot.h |  4 +++-
 hw/riscv/boot.c         | 53 +++++++++++++++++++++++++++++------------
 hw/riscv/sifive_u.c     | 28 ++++++++++------------
 hw/riscv/spike.c        |  7 +++++-
 hw/riscv/virt.c         |  7 +++++-
 5 files changed, 66 insertions(+), 33 deletions(-)

diff --git a/include/hw/riscv/boot.h b/include/hw/riscv/boot.h
index 3e9759c89a..35b6ddf710 100644
--- a/include/hw/riscv/boot.h
+++ b/include/hw/riscv/boot.h
@@ -35,7 +35,9 @@ target_ulong riscv_load_kernel(const char *kernel_filename,
                                symbol_fn_t sym_cb);
 hwaddr riscv_load_initrd(const char *filename, uint64_t mem_size,
                          uint64_t kernel_entry, hwaddr *start);
+uint32_t riscv_load_fdt(hwaddr dram_start, uint64_t dram_size, void *fdt);
 void riscv_setup_rom_reset_vec(hwaddr saddr, hwaddr rom_base,
-                               hwaddr rom_size, void *fdt);
+                               hwaddr rom_size,
+                               uint32_t fdt_load_addr, void *fdt);
 
 #endif /* RISCV_BOOT_H */
diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
index 3df802380a..c62f545f15 100644
--- a/hw/riscv/boot.c
+++ b/hw/riscv/boot.c
@@ -159,45 +159,68 @@ hwaddr riscv_load_initrd(const char *filename, uint64_t mem_size,
     return *start + size;
 }
 
+uint32_t riscv_load_fdt(hwaddr dram_base, uint64_t mem_size, void *fdt)
+{
+    uint32_t temp, fdt_addr;
+    hwaddr dram_end = dram_base + mem_size;
+    int fdtsize = fdt_totalsize(fdt);
+
+    if (fdtsize <= 0) {
+        error_report("invalid device-tree");
+        exit(1);
+    }
+
+    /*
+     * We should put fdt as far as possible to avoid kernel/initrd overwriting
+     * its content. But it should be addressable by 32 bit system as well.
+     * Thus, put it at an aligned address that less than fdt size from end of
+     * dram or 4GB whichever is lesser.
+     */
+    temp = MIN(dram_end, 4096 * MiB);
+    fdt_addr = QEMU_ALIGN_DOWN(temp - fdtsize, 2 * MiB);
+
+    fdt_pack(fdt);
+    /* copy in the device tree */
+    qemu_fdt_dumpdtb(fdt, fdtsize);
+
+    rom_add_blob_fixed_as("fdt", fdt, fdtsize, fdt_addr,
+                          &address_space_memory);
+
+    return fdt_addr;
+}
+
 void riscv_setup_rom_reset_vec(hwaddr start_addr, hwaddr rom_base,
-                               hwaddr rom_size, void *fdt)
+                               hwaddr rom_size,
+                               uint32_t fdt_load_addr, void *fdt)
 {
     int i;
 
     /* reset vector */
-    uint32_t reset_vec[8] = {
+    uint32_t reset_vec[10] = {
         0x00000297,                  /* 1:  auipc  t0, %pcrel_hi(dtb) */
-        0x02028593,                  /*     addi   a1, t0, %pcrel_lo(1b) */
         0xf1402573,                  /*     csrr   a0, mhartid  */
 #if defined(TARGET_RISCV32)
+        0x0202a583,                  /*     lw     a1, 32(t0) */
         0x0182a283,                  /*     lw     t0, 24(t0) */
 #elif defined(TARGET_RISCV64)
+        0x0202b583,                  /*     ld     a1, 32(t0) */
         0x0182b283,                  /*     ld     t0, 24(t0) */
 #endif
         0x00028067,                  /*     jr     t0 */
         0x00000000,
         start_addr,                  /* start: .dword */
+        0x00000000,
+        fdt_load_addr,               /* fdt_laddr: .dword */
         0x00000000,
                                      /* dtb: */
     };
 
     /* copy in the reset vector in little_endian byte order */
-    for (i = 0; i < sizeof(reset_vec) >> 2; i++) {
+    for (i = 0; i < ARRAY_SIZE(reset_vec); i++) {
         reset_vec[i] = cpu_to_le32(reset_vec[i]);
     }
     rom_add_blob_fixed_as("mrom.reset", reset_vec, sizeof(reset_vec),
                           rom_base, &address_space_memory);
 
-    /* copy in the device tree */
-    if (fdt_pack(fdt) || fdt_totalsize(fdt) >
-        rom_size - sizeof(reset_vec)) {
-        error_report("not enough space to store device-tree");
-        exit(1);
-    }
-    qemu_fdt_dumpdtb(fdt, fdt_totalsize(fdt));
-    rom_add_blob_fixed_as("mrom.fdt", fdt, fdt_totalsize(fdt),
-                           rom_base + sizeof(reset_vec),
-                           &address_space_memory);
-
     return;
 }
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 0695c93d2c..39923209f4 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -379,6 +379,7 @@ static void sifive_u_machine_init(MachineState *machine)
     MemoryRegion *flash0 = g_new(MemoryRegion, 1);
     target_ulong start_addr = memmap[SIFIVE_U_DRAM].base;
     int i;
+    uint32_t fdt_load_addr;
 
     /* Initialize SoC */
     object_initialize_child(OBJECT(machine), "soc", &s->soc, TYPE_RISCV_U_SOC);
@@ -450,40 +451,37 @@ static void sifive_u_machine_init(MachineState *machine)
         }
     }
 
+    /* Compute the fdt load address in dram */
+    fdt_load_addr = riscv_load_fdt(memmap[SIFIVE_U_DRAM].base,
+                                   machine->ram_size, s->fdt);
+
     /* reset vector */
-    uint32_t reset_vec[8] = {
+    uint32_t reset_vec[11] = {
         s->msel,                       /* MSEL pin state */
         0x00000297,                    /* 1:  auipc  t0, %pcrel_hi(dtb) */
-        0x01c28593,                    /*     addi   a1, t0, %pcrel_lo(1b) */
         0xf1402573,                    /*     csrr   a0, mhartid  */
 #if defined(TARGET_RISCV32)
+        0x0202a583,                    /*     lw     a1, 32(t0) */
         0x0182a283,                    /*     lw     t0, 24(t0) */
 #elif defined(TARGET_RISCV64)
-        0x0182e283,                    /*     lwu    t0, 24(t0) */
+        0x0202b583,                    /*     ld     a1, 32(t0) */
+        0x0182b283,                    /*     ld     t0, 24(t0) */
 #endif
         0x00028067,                    /*     jr     t0 */
         0x00000000,
         start_addr,                    /* start: .dword */
+        0x00000000,
+        fdt_load_addr,                 /* fdt_laddr: .dword */
+        0x00000000,
                                        /* dtb: */
     };
 
     /* copy in the reset vector in little_endian byte order */
-    for (i = 0; i < sizeof(reset_vec) >> 2; i++) {
+    for (i = 0; i < ARRAY_SIZE(reset_vec); i++) {
         reset_vec[i] = cpu_to_le32(reset_vec[i]);
     }
     rom_add_blob_fixed_as("mrom.reset", reset_vec, sizeof(reset_vec),
                           memmap[SIFIVE_U_MROM].base, &address_space_memory);
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
 }
 
 static bool sifive_u_machine_get_start_in_flash(Object *obj, Error **errp)
diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index a8a0588824..13fa0455e3 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -163,6 +163,7 @@ static void spike_board_init(MachineState *machine)
     MemoryRegion *main_mem = g_new(MemoryRegion, 1);
     MemoryRegion *mask_rom = g_new(MemoryRegion, 1);
     unsigned int smp_cpus = machine->smp.cpus;
+    uint32_t fdt_load_addr;
 
     /* Initialize SOC */
     object_initialize_child(OBJECT(machine), "soc", &s->soc,
@@ -208,9 +209,13 @@ static void spike_board_init(MachineState *machine)
         }
     }
 
+    /* Compute the fdt load address in dram */
+    fdt_load_addr = riscv_load_fdt(memmap[SPIKE_DRAM].base,
+                                   machine->ram_size, s->fdt);
     /* load the reset vector */
     riscv_setup_rom_reset_vec(memmap[SPIKE_DRAM].base, memmap[SPIKE_MROM].base,
-                              memmap[SPIKE_MROM].size, s->fdt);
+                              memmap[SPIKE_MROM].size,
+                              fdt_load_addr, s->fdt);
 
     /* initialize HTIF using symbols found in load_kernel */
     htif_mm_init(system_memory, mask_rom, &s->soc.harts[0].env, serial_hd(0));
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 3463cf54aa..9d87319f70 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -478,6 +478,7 @@ static void virt_machine_init(MachineState *machine)
     char *plic_hart_config;
     size_t plic_hart_config_len;
     target_ulong start_addr = memmap[VIRT_DRAM].base;
+    uint32_t fdt_load_addr;
     int i;
     unsigned int smp_cpus = machine->smp.cpus;
 
@@ -532,9 +533,13 @@ static void virt_machine_init(MachineState *machine)
         start_addr = virt_memmap[VIRT_FLASH].base;
     }
 
+    /* Compute the fdt load address in dram */
+    fdt_load_addr = riscv_load_fdt(memmap[VIRT_DRAM].base,
+                                   machine->ram_size, s->fdt);
     /* load the reset vector */
     riscv_setup_rom_reset_vec(start_addr, virt_memmap[VIRT_MROM].base,
-                              virt_memmap[VIRT_MROM].size, s->fdt);
+                              virt_memmap[VIRT_MROM].size,
+                              fdt_load_addr, s->fdt);
 
     /* create PLIC hart topology configuration string */
     plic_hart_config_len = (strlen(VIRT_PLIC_HART_CONFIG) + 1) * smp_cpus;
-- 
2.27.0



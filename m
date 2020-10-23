Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59E21C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 16:25:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A066E2192A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 16:25:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="pJws9cGj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A066E2192A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVzt3-0000oO-I7
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 12:25:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37062)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=558518344=alistair.francis@wdc.com>)
 id 1kVzFJ-00025j-Ca; Fri, 23 Oct 2020 11:44:49 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:42257)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=558518344=alistair.francis@wdc.com>)
 id 1kVzFG-0003gw-Pt; Fri, 23 Oct 2020 11:44:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1603467886; x=1635003886;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=hkNsI+YDI8tyMdNWEckMB4IbaSMOZO66j406BQuoebQ=;
 b=pJws9cGjY5ZcHbqPAoodD8fH+jcM/8NmXuPbklF072ZruxPikeQsOcUI
 kqX3KEdPXo5ejQ+K2fX1g8NuZGwCNT7GKuBnlMRwtvcA0SmCjXG9wM4nF
 Amd3jICqGw9hc5NpxoQTBm7s/k8B4qUnCQ7UcLP5etcE3fkZb/9oABAVo
 Dfsx81Zf0Yzq2SuQmsznpkHgO7ysDiCu5IJ/XXkqYIsJyEccQP9WWJwaf
 IDdaEGM6qPTAshyLpnZ1c3kr3TXJUIDvRlHLQ7AHM+vuBRylov6wWgd/J
 6O3lRCmSnT5fKzf/UPi8yIduckZEgd2w4M+kJop1Et+hUiATFcTMZtuH4 g==;
IronPort-SDR: IqCUjowioS2MsV39bg1p8gUTWLNQvUuAx1UgfAFRWZ2A4bfOtxEy8hINICndIY+O2UUqBg7M/I
 Hvtg6ozINHWMOUQqh9axx6UDKeacfMK20pFf+zlnFBpQVqEwbxvbH2Sfa02P9H2W1EsgK9+wGN
 T3zeSFtS+61iV0Q0cO8SiMkeuBGgyCVcT41M2Jq0sF0zJdGkKiVvdcQmrD/FZmGxPmuUzFwgha
 RMWJ6jNbHDJHx5kWMNLNKxJQeQgcQ2LDMPNvKfPO4ziyDN4TPkEddA/2R7S5+Zf6cGms4G4az4
 bCA=
X-IronPort-AV: E=Sophos;i="5.77,408,1596470400"; d="scan'208";a="260636792"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 23 Oct 2020 23:44:44 +0800
IronPort-SDR: rw+eqrjJYgckri17AmccVmp1qMZUBo/Y0BAMzfUzprNVtk/hePypjC+F3ODB90hkuohsF9Osik
 V866IyuzeX67gUJcr1cpE29FyckTUtZ8/wMMhh6XdOUQbK4eJo0gmA8d6QGpnnDmYFTjL2X5d3
 R5v2BnX78MSyQJHBkBhI/TgDUkKq1kmgnAb/LCkrGCQbFaB359ISVtoXAzRzoWYqMUDLg/JSew
 VB3rh23/entgUywfDbncsMCWBTJo99XEEVf2GCLeGk/XXvzbq7QPU/gCJaEmw61xOWIpQ0gERg
 em0Aw30vU0iFOqjgzdMim4WJ
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2020 08:31:07 -0700
IronPort-SDR: jf0gfAFT/17HChI6nOOAPRqAf9P9vfIxtl5X+xuJD0+7c2SNe6P5/ENQcioduLZRlCRDtcz9wZ
 LN9xtNo0mK5bA20t9haBSrlb+sxu/LgZA0Sw3VkXaEQpPhHTcKY91x8GOOqmR1MvrQqIN9jEzN
 BCvF/Sv3ZMcljDBwEFSjhA6BBcpLP+gL09PyKpdIctTFz5ykSWMIonG9cq3Ux5BIskW3+F2Cvt
 Dl+17nB58oFTQOB3xCcZ9C3htsBPTRZuKKR/yhwVTXBEZ1bOWdXk9iv0V1rQaczsxxSdVHAA4V
 P/w=
WDCIronportException: Internal
Received: from cnf006900.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.60.46])
 by uls-op-cesaip02.wdc.com with ESMTP; 23 Oct 2020 08:44:45 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v1 04/16] hw/riscv: boot: Remove compile time XLEN checks
Date: Fri, 23 Oct 2020 08:33:24 -0700
Message-Id: <9ac707eccfca0158a851cecfd83f90ab124cded3.1603467169.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1603467169.git.alistair.francis@wdc.com>
References: <cover.1603467169.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=558518344=alistair.francis@wdc.com;
 helo=esa1.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 11:37:20
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: alistair.francis@wdc.com, bmeng.cn@gmail.com, palmer@dabbelt.com,
 alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/riscv/boot.h |  8 +++---
 hw/riscv/boot.c         | 55 ++++++++++++++++++++++-------------------
 hw/riscv/sifive_u.c     |  2 +-
 hw/riscv/spike.c        |  3 ++-
 hw/riscv/virt.c         |  2 +-
 5 files changed, 39 insertions(+), 31 deletions(-)

diff --git a/include/hw/riscv/boot.h b/include/hw/riscv/boot.h
index 0b01988727..b6d37a91d6 100644
--- a/include/hw/riscv/boot.h
+++ b/include/hw/riscv/boot.h
@@ -41,10 +41,12 @@ target_ulong riscv_load_kernel(const char *kernel_filename,
 hwaddr riscv_load_initrd(const char *filename, uint64_t mem_size,
                          uint64_t kernel_entry, hwaddr *start);
 uint32_t riscv_load_fdt(hwaddr dram_start, uint64_t dram_size, void *fdt);
-void riscv_setup_rom_reset_vec(hwaddr saddr, hwaddr rom_base,
-                               hwaddr rom_size, uint64_t kernel_entry,
+void riscv_setup_rom_reset_vec(MachineState *machine, hwaddr saddr,
+                               hwaddr rom_base, hwaddr rom_size,
+                               uint64_t kernel_entry,
                                uint32_t fdt_load_addr, void *fdt);
-void riscv_rom_copy_firmware_info(hwaddr rom_base, hwaddr rom_size,
+void riscv_rom_copy_firmware_info(MachineState *machine, hwaddr rom_base,
+                                  hwaddr rom_size,
                                   uint32_t reset_vec_size,
                                   uint64_t kernel_entry);
 
diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
index 9b3fe3fb1e..a6e4e52b32 100644
--- a/hw/riscv/boot.c
+++ b/hw/riscv/boot.c
@@ -32,12 +32,6 @@
 
 #include <libfdt.h>
 
-#if defined(TARGET_RISCV32)
-#define fw_dynamic_info_data(__val)     cpu_to_le32(__val)
-#else
-#define fw_dynamic_info_data(__val)     cpu_to_le64(__val)
-#endif
-
 bool riscv_is_32_bit(MachineState *machine)
 {
     if (!strncmp(machine->cpu_type, "rv32", 4)) {
@@ -216,16 +210,24 @@ uint32_t riscv_load_fdt(hwaddr dram_base, uint64_t mem_size, void *fdt)
     return fdt_addr;
 }
 
-void riscv_rom_copy_firmware_info(hwaddr rom_base, hwaddr rom_size,
-                              uint32_t reset_vec_size, uint64_t kernel_entry)
+void riscv_rom_copy_firmware_info(MachineState *machine, hwaddr rom_base,
+                                  hwaddr rom_size, uint32_t reset_vec_size,
+                                  uint64_t kernel_entry)
 {
     struct fw_dynamic_info dinfo;
     size_t dinfo_len;
 
-    dinfo.magic = fw_dynamic_info_data(FW_DYNAMIC_INFO_MAGIC_VALUE);
-    dinfo.version = fw_dynamic_info_data(FW_DYNAMIC_INFO_VERSION);
-    dinfo.next_mode = fw_dynamic_info_data(FW_DYNAMIC_INFO_NEXT_MODE_S);
-    dinfo.next_addr = fw_dynamic_info_data(kernel_entry);
+    if (riscv_is_32_bit(machine)) {
+        dinfo.magic = cpu_to_le32(FW_DYNAMIC_INFO_MAGIC_VALUE);
+        dinfo.version = cpu_to_le32(FW_DYNAMIC_INFO_VERSION);
+        dinfo.next_mode = cpu_to_le32(FW_DYNAMIC_INFO_NEXT_MODE_S);
+        dinfo.next_addr = cpu_to_le32(kernel_entry);
+    } else {
+        dinfo.magic = cpu_to_le64(FW_DYNAMIC_INFO_MAGIC_VALUE);
+        dinfo.version = cpu_to_le64(FW_DYNAMIC_INFO_VERSION);
+        dinfo.next_mode = cpu_to_le64(FW_DYNAMIC_INFO_NEXT_MODE_S);
+        dinfo.next_addr = cpu_to_le64(kernel_entry);
+    }
     dinfo.options = 0;
     dinfo.boot_hart = 0;
     dinfo_len = sizeof(dinfo);
@@ -245,28 +247,24 @@ void riscv_rom_copy_firmware_info(hwaddr rom_base, hwaddr rom_size,
                            &address_space_memory);
 }
 
-void riscv_setup_rom_reset_vec(hwaddr start_addr, hwaddr rom_base,
-                               hwaddr rom_size, uint64_t kernel_entry,
+void riscv_setup_rom_reset_vec(MachineState *machine, hwaddr start_addr,
+                               hwaddr rom_base, hwaddr rom_size,
+                               uint64_t kernel_entry,
                                uint32_t fdt_load_addr, void *fdt)
 {
     int i;
     uint32_t start_addr_hi32 = 0x00000000;
 
-    #if defined(TARGET_RISCV64)
-    start_addr_hi32 = start_addr >> 32;
-    #endif
+    if (!riscv_is_32_bit(machine)) {
+        start_addr_hi32 = start_addr >> 32;
+    }
     /* reset vector */
     uint32_t reset_vec[10] = {
         0x00000297,                  /* 1:  auipc  t0, %pcrel_hi(fw_dyn) */
         0x02828613,                  /*     addi   a2, t0, %pcrel_lo(1b) */
         0xf1402573,                  /*     csrr   a0, mhartid  */
-#if defined(TARGET_RISCV32)
-        0x0202a583,                  /*     lw     a1, 32(t0) */
-        0x0182a283,                  /*     lw     t0, 24(t0) */
-#elif defined(TARGET_RISCV64)
-        0x0202b583,                  /*     ld     a1, 32(t0) */
-        0x0182b283,                  /*     ld     t0, 24(t0) */
-#endif
+        0,
+        0,
         0x00028067,                  /*     jr     t0 */
         start_addr,                  /* start: .dword */
         start_addr_hi32,
@@ -274,6 +272,13 @@ void riscv_setup_rom_reset_vec(hwaddr start_addr, hwaddr rom_base,
         0x00000000,
                                      /* fw_dyn: */
     };
+    if (riscv_is_32_bit(machine)) {
+        reset_vec[3] = 0x0202a583;   /*     lw     a1, 32(t0) */
+        reset_vec[4] = 0x0182a283;   /*     lw     t0, 24(t0) */
+    } else {
+        reset_vec[3] = 0x0202b583;   /*     ld     a1, 32(t0) */
+        reset_vec[4] = 0x0182b283;   /*     ld     t0, 24(t0) */
+    }
 
     /* copy in the reset vector in little_endian byte order */
     for (i = 0; i < ARRAY_SIZE(reset_vec); i++) {
@@ -281,7 +286,7 @@ void riscv_setup_rom_reset_vec(hwaddr start_addr, hwaddr rom_base,
     }
     rom_add_blob_fixed_as("mrom.reset", reset_vec, sizeof(reset_vec),
                           rom_base, &address_space_memory);
-    riscv_rom_copy_firmware_info(rom_base, rom_size, sizeof(reset_vec),
+    riscv_rom_copy_firmware_info(machine, rom_base, rom_size, sizeof(reset_vec),
                                  kernel_entry);
 
     return;
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index b2472c6627..978cfedd24 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -538,7 +538,7 @@ static void sifive_u_machine_init(MachineState *machine)
     rom_add_blob_fixed_as("mrom.reset", reset_vec, sizeof(reset_vec),
                           memmap[SIFIVE_U_DEV_MROM].base, &address_space_memory);
 
-    riscv_rom_copy_firmware_info(memmap[SIFIVE_U_DEV_MROM].base,
+    riscv_rom_copy_firmware_info(machine, memmap[SIFIVE_U_DEV_MROM].base,
                                  memmap[SIFIVE_U_DEV_MROM].size,
                                  sizeof(reset_vec), kernel_entry);
 }
diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index 29f07f47b1..875f371f0f 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -296,7 +296,8 @@ static void spike_board_init(MachineState *machine)
     fdt_load_addr = riscv_load_fdt(memmap[SPIKE_DRAM].base,
                                    machine->ram_size, s->fdt);
     /* load the reset vector */
-    riscv_setup_rom_reset_vec(memmap[SPIKE_DRAM].base, memmap[SPIKE_MROM].base,
+    riscv_setup_rom_reset_vec(machine, memmap[SPIKE_DRAM].base,
+                              memmap[SPIKE_MROM].base,
                               memmap[SPIKE_MROM].size, kernel_entry,
                               fdt_load_addr, s->fdt);
 
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 5f1fcebdc6..192138cc76 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -643,7 +643,7 @@ static void virt_machine_init(MachineState *machine)
     fdt_load_addr = riscv_load_fdt(memmap[VIRT_DRAM].base,
                                    machine->ram_size, s->fdt);
     /* load the reset vector */
-    riscv_setup_rom_reset_vec(start_addr, virt_memmap[VIRT_MROM].base,
+    riscv_setup_rom_reset_vec(machine, start_addr, virt_memmap[VIRT_MROM].base,
                               virt_memmap[VIRT_MROM].size, kernel_entry,
                               fdt_load_addr, s->fdt);
 
-- 
2.28.0



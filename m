Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8EE6C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 00:33:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5139221D40
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 00:33:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="QT0o16lE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5139221D40
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSUjk-0004aA-EZ
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 20:33:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51168)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=549b5cc2b=alistair.francis@wdc.com>)
 id 1kSUez-0000NX-8c; Tue, 13 Oct 2020 20:28:55 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:47545)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=549b5cc2b=alistair.francis@wdc.com>)
 id 1kSUev-0003yw-0U; Tue, 13 Oct 2020 20:28:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1602635328; x=1634171328;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=GKZlPA+ZwPBcJGAYATdrJA/ocPmRdlH1x9qsEUL99Is=;
 b=QT0o16lEukXjMPfNW3l7NVm13EWbaytXNCGabtNAFzhh0p9W9HAvvlqN
 YaCFHifWerDJ32gNOH2bhktA6qzC5iLYuiW1p0F6MOTbULnrCzI93TFnn
 RqguVqi92/Obp2L8hS/MUNzTe208GVregLQik/AGjQfixrMNv8SVikUbQ
 k9lQxZrrTwDAYgQEOrdkzOBh1I6U/67ndCPlA/rm4IttcJtLrEJw0D1ld
 fikStRWKoY2RnFxOURbAAIjaDzmZY+7v1wNpqbfQUdCT2bO1Ht5osOkT+
 VoNVPYahf06/SnqEJSJ6AqWe6Su/IeH6BFAeTTxjzMa50CP7wKh57dbY5 g==;
IronPort-SDR: /1nPvkEkf1ub2aTZ642quwL0WTY96h618+UObmh6RwJD/W5RnB2++fZCJAwzu27wECZ1IXQay4
 Ppc/OGuj0XqtxqrScwLzFYuUvBiGR6y1m9faWf3Vkmf17Sd/13IUqRgJlhxckLfJsVxZ8cUrMu
 xt9MR4A8b3hfFvOK38ieGB0kt23+yhCstX9XsF4SdKS5irXnCsG8BSWZlbNm0cnmN37aG9pPpL
 zlGXKm+WZB/86b+dv1GRJbaoxxg6kfQN9s/kDCb0FtGN8pawWb3dRNSqst7H8k/l2n06Q13OfJ
 VRA=
X-IronPort-AV: E=Sophos;i="5.77,372,1596470400"; d="scan'208";a="259612093"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 14 Oct 2020 08:28:44 +0800
IronPort-SDR: HTl23AvdYeXPnmluz0iggMTB8MjXAmZJCZG0mDzeILnuctKthNSRtPpo3kovogbJAIq6N7sWBv
 s3WGguKK6jRA2xPVLCeqMkbAxqCavHBStj3j3uOQcbotvsEFXGpj8M/WuFgV+wGxcrW7EU/etQ
 48kNjUbKi/mEqBrYrMp37NZpTpH07jXI4jqytyFK55X94+UndKH9LXx+RAthVPv7eoEwKnlNgT
 576tcylUCtgWJymnjSvl7ciTK4DC2+20LoZm29NJkmM6/hNAhr3d3v4BdOU+vm6Df8D0K7Dx6U
 k2R8gJhLE1MlQzE11UubaX88
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2020 17:15:18 -0700
IronPort-SDR: JAhUpZ8uclhwJq8JR6Pk6qRcqSrURcpRgDPl4cH6L3MYzg3cihqIMKGHg1nSQF6lHmN9oBHR1q
 Md3S5d0M1t49jtWKFUy0CTWqNqPxDnFs2PNwjrAyfgp14cgvcbURjSjbPteKwIzhc7HmD2yurH
 Fx/uCVn8M4AUT6RXGDCWRCEonJ7zhnGgLssbJ2buuCsXuH227s0VBISGKF1IRYmzZ8pzJ81ZK7
 RyfJWkv4g54h0JP5oLt/jVXO7HyT2PY0z/a/d62no/ZL3jB9zbTctDSLtZdNhoyJxyvCsTbGUf
 lf8=
WDCIronportException: Internal
Received: from cnf006900.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.60.55])
 by uls-op-cesaip02.wdc.com with ESMTP; 13 Oct 2020 17:28:44 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v2 4/4] hw/riscv: Load the kernel after the firmware
Date: Tue, 13 Oct 2020 17:17:33 -0700
Message-Id: <46c00c4f15b42feb792090e3d74359e180a6d954.1602634524.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1602634524.git.alistair.francis@wdc.com>
References: <cover.1602634524.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=549b5cc2b=alistair.francis@wdc.com;
 helo=esa1.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 20:28:34
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

Instead of loading the kernel at a hardcoded start address, let's load
the kernel at the next alligned address after the end of the firmware.

This should have no impact for current users of OpenSBI, but will
allow loading a noMMU kernel at the start of memory.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/riscv/boot.h |  3 +++
 hw/riscv/boot.c         | 19 ++++++++++++++-----
 hw/riscv/opentitan.c    |  3 ++-
 hw/riscv/sifive_e.c     |  3 ++-
 hw/riscv/sifive_u.c     | 10 ++++++++--
 hw/riscv/spike.c        | 11 ++++++++---
 hw/riscv/virt.c         | 11 ++++++++---
 7 files changed, 45 insertions(+), 15 deletions(-)

diff --git a/include/hw/riscv/boot.h b/include/hw/riscv/boot.h
index 2975ed1a31..0b01988727 100644
--- a/include/hw/riscv/boot.h
+++ b/include/hw/riscv/boot.h
@@ -25,6 +25,8 @@
 
 bool riscv_is_32_bit(MachineState *machine);
 
+target_ulong riscv_calc_kernel_start_addr(MachineState *machine,
+                                          target_ulong firmware_end_addr);
 target_ulong riscv_find_and_load_firmware(MachineState *machine,
                                           const char *default_machine_firmware,
                                           hwaddr firmware_load_addr,
@@ -34,6 +36,7 @@ target_ulong riscv_load_firmware(const char *firmware_filename,
                                  hwaddr firmware_load_addr,
                                  symbol_fn_t sym_cb);
 target_ulong riscv_load_kernel(const char *kernel_filename,
+                               target_ulong firmware_end_addr,
                                symbol_fn_t sym_cb);
 hwaddr riscv_load_initrd(const char *filename, uint64_t mem_size,
                          uint64_t kernel_entry, hwaddr *start);
diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
index 5dea644f47..9b3fe3fb1e 100644
--- a/hw/riscv/boot.c
+++ b/hw/riscv/boot.c
@@ -33,10 +33,8 @@
 #include <libfdt.h>
 
 #if defined(TARGET_RISCV32)
-# define KERNEL_BOOT_ADDRESS 0x80400000
 #define fw_dynamic_info_data(__val)     cpu_to_le32(__val)
 #else
-# define KERNEL_BOOT_ADDRESS 0x80200000
 #define fw_dynamic_info_data(__val)     cpu_to_le64(__val)
 #endif
 
@@ -49,6 +47,15 @@ bool riscv_is_32_bit(MachineState *machine)
     }
 }
 
+target_ulong riscv_calc_kernel_start_addr(MachineState *machine,
+                                          target_ulong firmware_end_addr) {
+    if (riscv_is_32_bit(machine)) {
+        return QEMU_ALIGN_UP(firmware_end_addr, 4 * MiB);
+    } else {
+        return QEMU_ALIGN_UP(firmware_end_addr, 2 * MiB);
+    }
+}
+
 target_ulong riscv_find_and_load_firmware(MachineState *machine,
                                           const char *default_machine_firmware,
                                           hwaddr firmware_load_addr,
@@ -123,7 +130,9 @@ target_ulong riscv_load_firmware(const char *firmware_filename,
     exit(1);
 }
 
-target_ulong riscv_load_kernel(const char *kernel_filename, symbol_fn_t sym_cb)
+target_ulong riscv_load_kernel(const char *kernel_filename,
+                               target_ulong kernel_start_addr,
+                               symbol_fn_t sym_cb)
 {
     uint64_t kernel_entry;
 
@@ -138,9 +147,9 @@ target_ulong riscv_load_kernel(const char *kernel_filename, symbol_fn_t sym_cb)
         return kernel_entry;
     }
 
-    if (load_image_targphys_as(kernel_filename, KERNEL_BOOT_ADDRESS,
+    if (load_image_targphys_as(kernel_filename, kernel_start_addr,
                                ram_size, NULL) > 0) {
-        return KERNEL_BOOT_ADDRESS;
+        return kernel_start_addr;
     }
 
     error_report("could not load kernel '%s'", kernel_filename);
diff --git a/hw/riscv/opentitan.c b/hw/riscv/opentitan.c
index 0531bd879b..cc758b78b8 100644
--- a/hw/riscv/opentitan.c
+++ b/hw/riscv/opentitan.c
@@ -75,7 +75,8 @@ static void opentitan_board_init(MachineState *machine)
     }
 
     if (machine->kernel_filename) {
-        riscv_load_kernel(machine->kernel_filename, NULL);
+        riscv_load_kernel(machine->kernel_filename,
+                          memmap[IBEX_DEV_RAM].base, NULL);
     }
 }
 
diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
index fcfac16816..59bac4cc9a 100644
--- a/hw/riscv/sifive_e.c
+++ b/hw/riscv/sifive_e.c
@@ -114,7 +114,8 @@ static void sifive_e_machine_init(MachineState *machine)
                           memmap[SIFIVE_E_DEV_MROM].base, &address_space_memory);
 
     if (machine->kernel_filename) {
-        riscv_load_kernel(machine->kernel_filename, NULL);
+        riscv_load_kernel(machine->kernel_filename,
+                          memmap[SIFIVE_E_DEV_DTIM].base, NULL);
     }
 }
 
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 5f3ad9bc0f..b2472c6627 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -415,6 +415,7 @@ static void sifive_u_machine_init(MachineState *machine)
     MemoryRegion *main_mem = g_new(MemoryRegion, 1);
     MemoryRegion *flash0 = g_new(MemoryRegion, 1);
     target_ulong start_addr = memmap[SIFIVE_U_DEV_DRAM].base;
+    target_ulong firmware_end_addr, kernel_start_addr;
     uint32_t start_addr_hi32 = 0x00000000;
     int i;
     uint32_t fdt_load_addr;
@@ -474,10 +475,15 @@ static void sifive_u_machine_init(MachineState *machine)
         break;
     }
 
-    riscv_find_and_load_firmware(machine, BIOS_FILENAME, start_addr, NULL);
+    firmware_end_addr = riscv_find_and_load_firmware(machine, BIOS_FILENAME,
+                                                     start_addr, NULL);
 
     if (machine->kernel_filename) {
-        kernel_entry = riscv_load_kernel(machine->kernel_filename, NULL);
+        kernel_start_addr = riscv_calc_kernel_start_addr(machine,
+                                                         firmware_end_addr);
+
+        kernel_entry = riscv_load_kernel(machine->kernel_filename,
+                                         kernel_start_addr, NULL);
 
         if (machine->initrd_filename) {
             hwaddr start;
diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index 3fd152a035..facac6e7d2 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -195,6 +195,7 @@ static void spike_board_init(MachineState *machine)
     MemoryRegion *system_memory = get_system_memory();
     MemoryRegion *main_mem = g_new(MemoryRegion, 1);
     MemoryRegion *mask_rom = g_new(MemoryRegion, 1);
+    target_ulong firmware_end_addr, kernel_start_addr;
     uint32_t fdt_load_addr;
     uint64_t kernel_entry;
     char *soc_name;
@@ -261,12 +262,16 @@ static void spike_board_init(MachineState *machine)
     memory_region_add_subregion(system_memory, memmap[SPIKE_MROM].base,
                                 mask_rom);
 
-    riscv_find_and_load_firmware(machine, BIOS_FILENAME,
-                                 memmap[SPIKE_DRAM].base,
-                                 htif_symbol_callback);
+    firmware_end_addr = riscv_find_and_load_firmware(machine, BIOS_FILENAME,
+                                                     memmap[SPIKE_DRAM].base,
+                                                     htif_symbol_callback);
 
     if (machine->kernel_filename) {
+        kernel_start_addr = riscv_calc_kernel_start_addr(machine,
+                                                         firmware_end_addr);
+
         kernel_entry = riscv_load_kernel(machine->kernel_filename,
+                                         kernel_start_addr,
                                          htif_symbol_callback);
 
         if (machine->initrd_filename) {
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 41bd2f38ba..6bfd10dfc7 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -493,6 +493,7 @@ static void virt_machine_init(MachineState *machine)
     char *plic_hart_config, *soc_name;
     size_t plic_hart_config_len;
     target_ulong start_addr = memmap[VIRT_DRAM].base;
+    target_ulong firmware_end_addr, kernel_start_addr;
     uint32_t fdt_load_addr;
     uint64_t kernel_entry;
     DeviceState *mmio_plic, *virtio_plic, *pcie_plic;
@@ -602,11 +603,15 @@ static void virt_machine_init(MachineState *machine)
     memory_region_add_subregion(system_memory, memmap[VIRT_MROM].base,
                                 mask_rom);
 
-    riscv_find_and_load_firmware(machine, BIOS_FILENAME,
-                                 memmap[VIRT_DRAM].base, NULL);
+    firmware_end_addr = riscv_find_and_load_firmware(machine, BIOS_FILENAME,
+                                                     start_addr, NULL);
 
     if (machine->kernel_filename) {
-        kernel_entry = riscv_load_kernel(machine->kernel_filename, NULL);
+        kernel_start_addr = riscv_calc_kernel_start_addr(machine,
+                                                         firmware_end_addr);
+
+        kernel_entry = riscv_load_kernel(machine->kernel_filename,
+                                         kernel_start_addr, NULL);
 
         if (machine->initrd_filename) {
             hwaddr start;
-- 
2.28.0



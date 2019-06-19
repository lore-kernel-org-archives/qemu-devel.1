Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A22F5C31E5B
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 00:53:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FB3A20863
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 00:53:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="JJeJzzvo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FB3A20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34350 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdOqe-00015p-NO
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 20:53:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48401)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <prvs=066539cd8=alistair.francis@wdc.com>)
 id 1hdOp2-0007hu-8y
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 20:51:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=066539cd8=alistair.francis@wdc.com>)
 id 1hdOf2-0003Zl-IZ
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 20:41:13 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:29336)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=066539cd8=alistair.francis@wdc.com>)
 id 1hdOf2-0003VC-Ab; Tue, 18 Jun 2019 20:41:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1560904873; x=1592440873;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=3+76QIJxIBVZ79eXeNFTLJr7YxWh/86B8UEl89n99kM=;
 b=JJeJzzvoWbwfJr/rox++VI6g5GNjYXom/MgoYmf5a+YVTEudOiKEVIYv
 vPGsruRcE6H2mkNnFC6BqfZRxFSEfhOX3X9FGemFJgJLkoFQgk6ao/Fuf
 o55un1XCEcDdFOW+7EU9W/We70d8+tZ8P1+6b9JFNdIfTmOAhnvvxs/J0
 /edBpTFnInecwwcw0SUcLAxH/gGnA7w+oSrjWqtG51JyuRsi+In4Lb+k/
 /D4sp/QkIa7oGheX4+VIJvR5veomjg433xlxEyiKcUt4XRXqAIMDNcZ7F
 loLI7S9u6a1LgIx+QE4JFjYDAlsovDJBlczpP8sQWV3gDZDB5VmjoLSL1 A==;
X-IronPort-AV: E=Sophos;i="5.63,390,1557158400"; d="scan'208";a="110901045"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 19 Jun 2019 08:41:12 +0800
IronPort-SDR: CrHY7J03ZuAdz57Ba4RfqmBLfmAS2sOtPs9KouDHkQSReN1UILi+LqPRGUbvhIi6unpUZJPLfz
 TWXmZJtIsp668M1ERXD4/IUf1dZgbmmUj6kZ594SMwM+lypwoGsWKf+s2XAA01m7NNrPVTNZcC
 JF0yXb5/zpfNQpvjSMpV1OX4fPvgDP324V2hWVZeSATyFbTXZGSCzchipIdgARj1uh7Db2/Xoe
 FRbzWeJVjtaCbGJC2qzJzeEaFuuZcxmaPGZU+34mmuLvw/O3k42ljhAW2WOgPA/b428ltNKN6e
 iarRFR2jK6PmptYW4+rKbfCa
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP; 18 Jun 2019 17:40:40 -0700
IronPort-SDR: iHlpcmdti7/m/oj585t5FWlJBmB7VSsezxA7e6vEB/5wxrPI15R1hZccRp8QJJ5ucGI0uUVMmP
 4sRSI/qNNT/nUaqYSKrGHyIJ05T3qRfHaiRRQMaQsDc0TxA1UeV9VZRA+Y+NcT0xzgvaTkJCPh
 c06gipyR5P54LgjvrNeRk39MDUvEUJ9DIsm+PnJp7wdh8FeP4ODILYxWz+tJWFWFiTxeCcEhFZ
 WmyVLpAF6dXuiueDzQi8wH3DU1uA6eFJ1hu0h/a4vBYLL6D5EA71OlxqKBxCSuzLqVkQe/QpMd
 KC0=
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.140])
 by uls-op-cesaip02.wdc.com with ESMTP; 18 Jun 2019 17:41:11 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Date: Tue, 18 Jun 2019 17:38:50 -0700
Message-Id: <e718da8df07915765217dece609255b6ad196955.1560904640.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1560904640.git.alistair.francis@wdc.com>
References: <cover.1560904640.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 216.71.154.42
Subject: [Qemu-devel] [RFC v1 2/5] hw/riscv: Add support for loading a
 firmware
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
Cc: alistair23@gmail.com, palmer@sifive.com, alistair.francis@wdc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add support for loading a firmware file for the virt machine and the
SiFive U. This can be run with the following command:

    qemu-system-riscv64 -machine virt -bios fw_jump.elf -kernel vmlinux

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/boot.c         | 41 +++++++++++++++++++++++++++++++++++++++--
 hw/riscv/sifive_e.c     |  2 +-
 hw/riscv/sifive_u.c     |  6 +++++-
 hw/riscv/spike.c        |  6 +++---
 hw/riscv/virt.c         |  7 ++++++-
 include/hw/riscv/boot.h |  4 +++-
 6 files changed, 57 insertions(+), 9 deletions(-)

diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
index 62f94aaf8a..392ca0cb2e 100644
--- a/hw/riscv/boot.c
+++ b/hw/riscv/boot.c
@@ -23,13 +23,50 @@
 #include "exec/cpu-defs.h"
 #include "hw/loader.h"
 #include "hw/riscv/boot.h"
+#include "hw/boards.h"
 #include "elf.h"
 
-target_ulong riscv_load_kernel(const char *kernel_filename)
+#if defined(TARGET_RISCV32)
+# define KERNEL_BOOT_ADDRESS 0x80400000
+#else
+# define KERNEL_BOOT_ADDRESS 0x80200000
+#endif
+
+static uint64_t kernel_translate(void *opaque, uint64_t addr)
+{
+    MachineState *machine = opaque;
+
+    /*
+     * If the user specified a firmware move the kernel to the offset
+     * start address.
+     */
+    if (machine->firmware) {
+        return (addr & 0x7fffffff) + KERNEL_BOOT_ADDRESS;
+    } else {
+        return addr;
+    }
+}
+
+target_ulong riscv_load_firmware(const char *firmware_filename)
+{
+    uint64_t firmware_entry, firmware_start, firmware_end;
+
+    if (load_elf(firmware_filename, NULL, NULL, NULL,
+                 &firmware_entry, &firmware_start, &firmware_end,
+                 0, EM_RISCV, 1, 0) < 0) {
+        error_report("could not load firmware '%s'", firmware_filename);
+        exit(1);
+    }
+
+    return firmware_entry;
+}
+
+target_ulong riscv_load_kernel(MachineState *machine,
+                               const char *kernel_filename)
 {
     uint64_t kernel_entry, kernel_high;
 
-    if (load_elf(kernel_filename, NULL, NULL, NULL,
+    if (load_elf(kernel_filename, NULL, kernel_translate, machine,
                  &kernel_entry, NULL, &kernel_high,
                  0, EM_RISCV, 1, 0) < 0) {
         error_report("could not load kernel '%s'", kernel_filename);
diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
index 9d58ae362b..3695c686be 100644
--- a/hw/riscv/sifive_e.c
+++ b/hw/riscv/sifive_e.c
@@ -118,7 +118,7 @@ static void riscv_sifive_e_init(MachineState *machine)
                           memmap[SIFIVE_E_MROM].base, &address_space_memory);
 
     if (machine->kernel_filename) {
-        riscv_load_kernel(machine->kernel_filename);
+        riscv_load_kernel(machine, machine->kernel_filename);
     }
 }
 
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 1b9281bd4a..03a6c64d04 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -266,8 +266,12 @@ static void riscv_sifive_u_init(MachineState *machine)
     /* create device tree */
     create_fdt(s, memmap, machine->ram_size, machine->kernel_cmdline);
 
+    if (machine->firmware) {
+        riscv_load_firmware(machine->firmware);
+    }
+
     if (machine->kernel_filename) {
-        riscv_load_kernel(machine->kernel_filename);
+        riscv_load_kernel(machine, machine->kernel_filename);
     }
 
     /* reset vector */
diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index e68be00a5f..81cef0dcea 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -186,7 +186,7 @@ static void spike_board_init(MachineState *machine)
                                 mask_rom);
 
     if (machine->kernel_filename) {
-        riscv_load_kernel(machine->kernel_filename);
+        riscv_load_kernel(machine, machine->kernel_filename);
     }
 
     /* reset vector */
@@ -274,7 +274,7 @@ static void spike_v1_10_0_board_init(MachineState *machine)
                                 mask_rom);
 
     if (machine->kernel_filename) {
-        riscv_load_kernel(machine->kernel_filename);
+        riscv_load_kernel(machine, machine->kernel_filename);
     }
 
     /* reset vector */
@@ -359,7 +359,7 @@ static void spike_v1_09_1_board_init(MachineState *machine)
                                 mask_rom);
 
     if (machine->kernel_filename) {
-        riscv_load_kernel(machine->kernel_filename);
+        riscv_load_kernel(machine, machine->kernel_filename);
     }
 
     /* reset vector */
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 5f8c11471b..d3670b5a7c 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -380,8 +380,13 @@ static void riscv_virt_board_init(MachineState *machine)
     memory_region_add_subregion(system_memory, memmap[VIRT_MROM].base,
                                 mask_rom);
 
+    if (machine->firmware) {
+        riscv_load_firmware(machine->firmware);
+    }
+
     if (machine->kernel_filename) {
-        uint64_t kernel_entry = riscv_load_kernel(machine->kernel_filename);
+        uint64_t kernel_entry = riscv_load_kernel(machine,
+                                                  machine->kernel_filename);
 
         if (machine->initrd_filename) {
             hwaddr start;
diff --git a/include/hw/riscv/boot.h b/include/hw/riscv/boot.h
index f84fd6c2df..6f586939c7 100644
--- a/include/hw/riscv/boot.h
+++ b/include/hw/riscv/boot.h
@@ -20,7 +20,9 @@
 #ifndef RISCV_BOOT_H
 #define RISCV_BOOT_H
 
-target_ulong riscv_load_kernel(const char *kernel_filename);
+target_ulong riscv_load_firmware(const char *firmware_filename);
+target_ulong riscv_load_kernel(MachineState *machine,
+                               const char *kernel_filename);
 hwaddr riscv_load_initrd(const char *filename, uint64_t mem_size,
                          uint64_t kernel_entry, hwaddr *start);
 
-- 
2.22.0



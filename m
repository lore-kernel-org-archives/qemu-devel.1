Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22C08C31E5B
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 00:53:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7FDE20863
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 00:53:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Xq8nULFY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7FDE20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34348 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdOqY-00012W-S3
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 20:53:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48430)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <prvs=066539cd8=alistair.francis@wdc.com>)
 id 1hdOou-0007iJ-NE
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 20:51:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=066539cd8=alistair.francis@wdc.com>)
 id 1hdOfB-0003h2-Ez
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 20:41:25 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:29347)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=066539cd8=alistair.francis@wdc.com>)
 id 1hdOfB-0003bv-7I; Tue, 18 Jun 2019 20:41:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1560904882; x=1592440882;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=g+DlYUF0KXQmOfcWFncWarLKZPO22IikCZf0/MBOpR8=;
 b=Xq8nULFYlGtalKu92iOn3ts7iLfbwq36cq1z/pTH+in/xySwiUu4/HwG
 aCG0eUxHVXioDyGgp01/Kt72Ay+wb5B8KU2Gfcuf9RzY7+fcyjYI/sjih
 bnLExxaJJgfzFvA/TUb8OqteN3T7QfppJNB92b8u+p3Isl9kUsNd8q1Ux
 X8fj1ynPdMM2cd4HtDFtTaXmVmD1/S2eszrsja1swpPF6PileSil9RE5K
 Ju8IAYRYOidgNaxqSQq1GWucdcFbYrQh4lGLKCuFRj6EnoNz1DWkRYDrC
 VwyC6rusBZmr8jarNOndH9AkuHodXHN6TnOe/yBg5nykapDcvpBP0Fobg Q==;
X-IronPort-AV: E=Sophos;i="5.63,390,1557158400"; d="scan'208";a="110901050"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 19 Jun 2019 08:41:21 +0800
IronPort-SDR: XGOi74afuiC99Kt4HJOmDP+3XxTzETrdAgC0GtgzgGHLBDXX5K+AVhIEQpTbEXGHtguMUoJyXD
 N+JOu0yBSdtmuSb0gholp+Eue8YBLj3ixoXptVLkR9I4i1fCSa38/Y0iJ1bvzIZCr9lM+fwmBV
 ksMUF1ISSZ75QglSD1fY1pK8YLalppLDsP3Z/0TKgcsZ4su++slFKmtzztm2QCMm2W4HI+VWMo
 dI20YJxq0n7mytKLLfzCy26OS2eM/VWQ8kqTqVYIiAFSRBD4rxSU4ieXP8dUs5aOWNFzXxEthv
 KrXHMtf5QDn2gjmnber9HCKW
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP; 18 Jun 2019 17:40:48 -0700
IronPort-SDR: Yl4uYO6KobM0PvSMbhx+JP+dRA20CLvDsu3pSUZyX1tsyc50odeXspd790VXFNpx7FcoJMQvVI
 a5ns4UpcJw8LpsB3YnGsGaQw+i+aE9JrK+kdvQE6F5p7w9eWx/RFMU+UrI9V6BaNVw1PVMqSC/
 2OwRmM2IxV1J45ACxIhCc+xkFPFhMwP9w1fGJx9hyMHIr1yzGEyJlD8Kv5HNbbY2MkAuedONI8
 ZcmjN+DUF+0TDgK87OIOFaH+xwOLHmuGdg7wIP/IJmL83p4gHTOFs/pGMGwY2gGGlGhkQWg37O
 jD4=
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.140])
 by uls-op-cesaip02.wdc.com with ESMTP; 18 Jun 2019 17:41:20 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Date: Tue, 18 Jun 2019 17:38:58 -0700
Message-Id: <3d7dd8bc94dbfddf0c01cfc7f3bebc937d1e6894.1560904640.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1560904640.git.alistair.francis@wdc.com>
References: <cover.1560904640.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 216.71.154.42
Subject: [Qemu-devel] [RFC v1 5/5] hw/riscv: Load OpenSBI as the default
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

If the user hasn't specified a firmware to load (with -bios) or
specified no bios (with -bios none) then load OpenSBI by default. This
allows users to boot a RISC-V kernel with just -kernel.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/boot.c         | 28 ++++++++++++++++++++++++++++
 hw/riscv/sifive_u.c     |  4 +---
 hw/riscv/virt.c         |  4 +---
 include/hw/riscv/boot.h |  1 +
 4 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
index 7f68035a3f..5f021591ed 100644
--- a/hw/riscv/boot.c
+++ b/hw/riscv/boot.c
@@ -18,6 +18,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu-common.h"
 #include "qemu/units.h"
 #include "qemu/error-report.h"
 #include "exec/cpu-defs.h"
@@ -32,6 +33,12 @@
 # define KERNEL_BOOT_ADDRESS 0x80200000
 #endif
 
+#if defined(TARGET_RISCV32)
+# define BIOS_FILENAME "opensbi-riscv32-fw_jump.elf"
+#else
+# define BIOS_FILENAME "opensbi-riscv64-fw_jump.elf"
+#endif
+
 static uint64_t kernel_translate(void *opaque, uint64_t addr)
 {
     MachineState *machine = opaque;
@@ -47,6 +54,27 @@ static uint64_t kernel_translate(void *opaque, uint64_t addr)
     }
 }
 
+void riscv_find_and_load_firmware(MachineState *machine)
+{
+    char *firmware_filename;
+
+    if (!machine->firmware) {
+        /* The user didn't specify a firmware, default to OpenSBI */
+        firmware_filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, BIOS_FILENAME);
+    } else {
+        firmware_filename = machine->firmware;
+    }
+
+    if (strcmp(firmware_filename, "none")) {
+        /* If not "none" load the firmware */
+        riscv_load_firmware(firmware_filename);
+    }
+
+    if (!machine->firmware) {
+        g_free(firmware_filename);
+    }
+}
+
 target_ulong riscv_load_firmware(const char *firmware_filename)
 {
     uint64_t firmware_entry, firmware_start, firmware_end;
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 03a6c64d04..77666d0f4d 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -266,9 +266,7 @@ static void riscv_sifive_u_init(MachineState *machine)
     /* create device tree */
     create_fdt(s, memmap, machine->ram_size, machine->kernel_cmdline);
 
-    if (machine->firmware) {
-        riscv_load_firmware(machine->firmware);
-    }
+    riscv_find_and_load_firmware(machine);
 
     if (machine->kernel_filename) {
         riscv_load_kernel(machine, machine->kernel_filename);
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index d3670b5a7c..2a7e850666 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -380,9 +380,7 @@ static void riscv_virt_board_init(MachineState *machine)
     memory_region_add_subregion(system_memory, memmap[VIRT_MROM].base,
                                 mask_rom);
 
-    if (machine->firmware) {
-        riscv_load_firmware(machine->firmware);
-    }
+    riscv_find_and_load_firmware(machine);
 
     if (machine->kernel_filename) {
         uint64_t kernel_entry = riscv_load_kernel(machine,
diff --git a/include/hw/riscv/boot.h b/include/hw/riscv/boot.h
index 6f586939c7..df2e2480e6 100644
--- a/include/hw/riscv/boot.h
+++ b/include/hw/riscv/boot.h
@@ -20,6 +20,7 @@
 #ifndef RISCV_BOOT_H
 #define RISCV_BOOT_H
 
+void riscv_find_and_load_firmware(MachineState *machine);
 target_ulong riscv_load_firmware(const char *firmware_filename);
 target_ulong riscv_load_kernel(MachineState *machine,
                                const char *kernel_filename);
-- 
2.22.0



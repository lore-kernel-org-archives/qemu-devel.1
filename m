Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95FD0C4646C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 22:22:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67264205ED
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 22:22:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qM9wuNA9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67264205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55012 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfXMQ-0008Bm-5l
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 18:22:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58736)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <prvs=07161884e=alistair.francis@wdc.com>)
 id 1hfXEM-0002Iu-Ey
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 18:14:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=07161884e=alistair.francis@wdc.com>)
 id 1hfXEJ-0008Sy-WB
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 18:14:30 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:7987)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=07161884e=alistair.francis@wdc.com>)
 id 1hfXEI-0008Pf-1r; Mon, 24 Jun 2019 18:14:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1561414510; x=1592950510;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=w9mKs3/llZzgCEUFHsRlhH28oN+q90K0BfyWypydsrs=;
 b=qM9wuNA9DuK3BjLsJWuAoyajq+8qbms5wCvq+zaQkl0ZhTmKY3vkQemz
 wzHv9Ar6FcfABTeY0DxqWyreGWlRfcZuz6fsMNHm5ZkpKbe9ByXoZ1sjV
 a+jWUbLhEyt4GJhsB15ANi85RJ0q/k9Jo3NCg7gChzn2WpnK/MVVNDcqD
 7YGa932Nhca2EHuPlYf2ZeWjtXTKZsouybOwT+0AvST7a73c/Ogkn8cTy
 AyNCkbfuvRx5gxVIBSDDM4FNuKUv7AlWa6sWLJZxyvUtfmyUJS9mUiYMA
 axw7FEsWxteEfbWAzcK73xd7abUQeGFkN+ZOXBmr24kPwQypmndt9n3p8 Q==;
X-IronPort-AV: E=Sophos;i="5.63,413,1557158400"; d="scan'208";a="211210897"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 25 Jun 2019 06:15:02 +0800
IronPort-SDR: qFz5LZlw6f1KQpjgh4TCvjbYWKDIhZktKhloLo77jKAYoLiW7mmSrALif9z2PtdCY5aTGRsDwW
 m4GhmeR6qm9v6BpEAqEb4mS76g1lV3BA6aW4+q2FiQ5viAFbZxgyZrdRYE94bhr3E9vKZuu3w9
 yuq9DSKrRdDPImyORwZMPXOt/nY7j0f0jM5kPxD6bZaJ4Ef4zGwky0P+4DJCnpvdxpiHv43ULZ
 sossB3QRnYxaW64VarCjX6fB3LbdLo1lHPRqmSw7//IWr/jPALsTMslPb1Og8noEddIfg/NvlU
 aypsfdEYBMbsG1dVoLAqIiw4
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP; 24 Jun 2019 15:13:39 -0700
IronPort-SDR: uLJTM63mlEOz8zNXDCnPSaNxfc8SWQVjEJPfUsVSAd3Vhmumiu84QRpQup5FcZhWtJAT4Z2FwD
 q4eLrLSNJdrTEiCs5BBSH70C5FaYYaSH9Hh5xmSwlu+wAmnXlgmIa9FTRDr7seZOFpKDomQ7um
 5WdBHeSvcExbDoI2yWoqRSlWr5xy2VLA2kyJ68xsmJbbFM/r6PlR/R4ufFrkWhOTbypzxLXZb8
 TV6rDg5s4s69I6Yanfdpa4dx+tGCtgdWOVIxPKNKLqbTe8jnkdZ++12zR6r0sO5VJcEo7Jr1Vq
 rnk=
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.140])
 by uls-op-cesaip02.wdc.com with ESMTP; 24 Jun 2019 15:14:20 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Date: Mon, 24 Jun 2019 15:11:52 -0700
Message-Id: <03f453d45b8565472386fdb7403b6713ddbb8683.1561414240.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1561414240.git.alistair.francis@wdc.com>
References: <cover.1561414240.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 68.232.143.124
Subject: [Qemu-devel] [PATCH v1 2/5] hw/riscv: Add support for loading a
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

    qemu-system-riscv64 -machine virt -bios fw_jump.bin -kernel vmlinux

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/boot.c         | 26 ++++++++++++++++++++++++++
 hw/riscv/sifive_u.c     |  4 ++++
 hw/riscv/virt.c         |  4 ++++
 include/hw/riscv/boot.h |  2 ++
 4 files changed, 36 insertions(+)

diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
index 0c8e72e455..883df49a0c 100644
--- a/hw/riscv/boot.c
+++ b/hw/riscv/boot.c
@@ -23,8 +23,34 @@
 #include "exec/cpu-defs.h"
 #include "hw/loader.h"
 #include "hw/riscv/boot.h"
+#include "hw/boards.h"
 #include "elf.h"
 
+#if defined(TARGET_RISCV32)
+# define KERNEL_BOOT_ADDRESS 0x80400000
+#else
+# define KERNEL_BOOT_ADDRESS 0x80200000
+#endif
+
+target_ulong riscv_load_firmware(const char *firmware_filename,
+                                 hwaddr firmware_load_addr)
+{
+    uint64_t firmware_entry, firmware_start, firmware_end;
+
+    if (load_elf(firmware_filename, NULL, NULL, NULL, &firmware_entry,
+                 &firmware_start, &firmware_end, 0, EM_RISCV, 1, 0) > 0) {
+        return firmware_entry;
+    }
+
+    if (load_image_targphys_as(firmware_filename, firmware_load_addr,
+                               ram_size, NULL) > 0) {
+        return firmware_load_addr;
+    }
+
+    error_report("could not load firmware '%s'", firmware_filename);
+    exit(1);
+}
+
 target_ulong riscv_load_kernel(const char *kernel_filename)
 {
     uint64_t kernel_entry, kernel_high;
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 1b9281bd4a..a04f2d0754 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -266,6 +266,10 @@ static void riscv_sifive_u_init(MachineState *machine)
     /* create device tree */
     create_fdt(s, memmap, machine->ram_size, machine->kernel_cmdline);
 
+    if (machine->firmware) {
+        riscv_load_firmware(machine->firmware, memmap[SIFIVE_U_DRAM].base);
+    }
+
     if (machine->kernel_filename) {
         riscv_load_kernel(machine->kernel_filename);
     }
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 5f8c11471b..7fcc8c03b5 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -380,6 +380,10 @@ static void riscv_virt_board_init(MachineState *machine)
     memory_region_add_subregion(system_memory, memmap[VIRT_MROM].base,
                                 mask_rom);
 
+    if (machine->firmware) {
+        riscv_load_firmware(machine->firmware, memmap[VIRT_DRAM].base);
+    }
+
     if (machine->kernel_filename) {
         uint64_t kernel_entry = riscv_load_kernel(machine->kernel_filename);
 
diff --git a/include/hw/riscv/boot.h b/include/hw/riscv/boot.h
index f84fd6c2df..daa179b600 100644
--- a/include/hw/riscv/boot.h
+++ b/include/hw/riscv/boot.h
@@ -20,6 +20,8 @@
 #ifndef RISCV_BOOT_H
 #define RISCV_BOOT_H
 
+target_ulong riscv_load_firmware(const char *firmware_filename,
+                                 hwaddr firmware_load_addr);
 target_ulong riscv_load_kernel(const char *kernel_filename);
 hwaddr riscv_load_initrd(const char *filename, uint64_t mem_size,
                          uint64_t kernel_entry, hwaddr *start);
-- 
2.22.0



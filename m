Return-Path: <SRS0=vrBk=VF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43764C606C7
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 18:56:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DC7A21707
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 18:56:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="IhqGYys1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DC7A21707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkYo1-0004MP-3L
	for qemu-devel@archiver.kernel.org; Mon, 08 Jul 2019 14:56:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56062)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <prvs=085e8ccea=alistair.francis@wdc.com>)
 id 1hkYkT-0001vy-8O
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 14:52:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=085e8ccea=alistair.francis@wdc.com>)
 id 1hkYkR-0007gd-Pb
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 14:52:25 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:34036)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=085e8ccea=alistair.francis@wdc.com>)
 id 1hkYkR-0007eP-Eo; Mon, 08 Jul 2019 14:52:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1562611944; x=1594147944;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=T6YiDf12c8wOd9ACRSmxjp+ckUQZqqOt2r2ntOHABno=;
 b=IhqGYys1BRaRtdnBNWJ4an1KaHxAaQxDRypJ5uyIsi9PRGIoKQ+/5BB6
 WT0RUp1ENZa6tx0+J2GbyyIUhLItpEcCMzVgGVkUXIIb5eEwnRoBPZluq
 HUAp4TYkqCH8ID4e13qQ7bZTgdy4ykRQCJeg7gfgl3NLFFIyYTwr1RoNL
 X6Aw35qw6P7pH5dYwYVEILkB6mZSpkU7mk/RgZlwfr9pq5WmdBsmNwNDA
 7FZS0bZG40yQKVzJi1IQn980F1svocYzMa0DO1L7tDCcbqvmUncvfmKc7
 znU+tBDc/+dvK9rrdneoA//cOzu/ppFYP00nzt9l9lx5kpBiIhHS5sqIL A==;
IronPort-SDR: LB9AG0i0YwfuxTfy0LvgameF1xlTlXqUiQkrABkLlvwxTkK35I8+VtHbt16U0dJtBxvIFMtAyB
 kDpeBqkwbJ9CUMHi53FQEFQ1mNKOx9DPYT/DUFbvDkJl9m63E/tngBQQyGI1nbRi/bJol0y6bj
 fvzuHrpmexduIotYHYHbAH7S8zMsIS+rooD4R1k6WWBVdj9chGcYZH0p7IEOoxiIF0iXKVhb5+
 x+BnVSqkUWtt8eF+B5qixTpaiEsCyQ6obkQ57+457HnOz1Y0pbacY9jyUZioFa8oKiY6fA5zLS
 vQ8=
X-IronPort-AV: E=Sophos;i="5.63,466,1557158400"; d="scan'208";a="114094446"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 09 Jul 2019 02:52:23 +0800
IronPort-SDR: NZB23f5wkNAHHnC5SHq3Fo3FGKuRNudJwJ5RVCmf+fp5lC/ToRjkd2WXomOGP+q2ZwmSJN23Sc
 XCxcecTY1Ao4otw2J+vPLZEM8veHpM/VHqkQ+49WiEswTu+UxL+tQVv1Ji42SNPZtt3SGdCVzB
 x9dPqmjSKCk0Ws6keosdDOwFtgDH/mGqcyw+WKiTPst6DuWZBJ7YpJAiBGsBlqPt/JWvCkN/yj
 RgXxDHxKhIdud7qnQH8hYpFtXnn8jlotGwwPcRMtKDRcGolhqBsonlUukOrkm8LW8wKqRdWFi5
 bd6aMwivulDXTgMZzyCUFoG/
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP; 08 Jul 2019 11:51:11 -0700
IronPort-SDR: 9hPGORpEkam5d22xCJG4dovNcn4HlwdHNtmA2Qrdw4lo9v1FQBEO+fHQPk9qo2E7MRRs3203CX
 t5ix7dhhAc3r3+sCpz63COvNH1tGPIzN0Pxi/Pa1XLviH5TyruxP76w6J4tDIToaNqCpk+xtez
 gjXmmQZkbc/peCv8x+8yryKtYREuWz4brhrGJ9Bzbn7PxQv/P9CmJsZ+cmOHh8Dhi6SC+drOjd
 ZPO9tDFFl6BhKSLVoQFl7NspTO4ztunUI2pDUQiSfGp7u9788FM4IDtdFx6LQreH1ckhKH/IPY
 DX0=
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.140])
 by uls-op-cesaip01.wdc.com with ESMTP; 08 Jul 2019 11:52:23 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Date: Mon,  8 Jul 2019 11:49:40 -0700
Message-Id: <238062dcf3a9b99a048c8e7ae439cad7745af1da.1562611535.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1562611535.git.alistair.francis@wdc.com>
References: <cover.1562611535.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 216.71.154.45
Subject: [Qemu-devel] [PATCH v1 2/2] hw/riscv: Load OpenSBI as the default
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
Cc: peter.maydell@linaro.org, codyprime@gmail.com, anup@brainfault.org,
 palmer@sifive.com, alistair.francis@wdc.com, stefanha@redhat.com,
 pbonzini@redhat.com, alistair23@gmail.com, bmeng.cn@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If the user hasn't specified a firmware to load (with -bios) or
specified no bios (with -bios none) then load OpenSBI by default. This
allows users to boot a RISC-V kernel with just -kernel.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
Tested-by: Bin Meng <bmeng.cn@gmail.com>
---
 hw/riscv/boot.c         | 49 +++++++++++++++++++++++++++++++++++++++++
 hw/riscv/sifive_u.c     |  7 +++---
 hw/riscv/virt.c         | 11 ++++++---
 include/hw/riscv/boot.h |  3 +++
 qemu-deprecated.texi    | 20 +++++++++++++++++
 5 files changed, 84 insertions(+), 6 deletions(-)

diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
index ff023f42d0..c7d72f682f 100644
--- a/hw/riscv/boot.c
+++ b/hw/riscv/boot.c
@@ -18,6 +18,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu-common.h"
 #include "qemu/units.h"
 #include "qemu/error-report.h"
 #include "exec/cpu-defs.h"
@@ -32,6 +33,54 @@
 # define KERNEL_BOOT_ADDRESS 0x80200000
 #endif
 
+void riscv_find_and_load_firmware(MachineState *machine,
+                                  const char *default_machine_firmware,
+                                  hwaddr firmware_load_addr)
+{
+    char *firmware_filename;
+
+    if (!machine->firmware) {
+        /*
+         * The user didn't specify -bios.
+         * At the moment we default to loading nothing when this hapens.
+         * In the future this defaul will change to loading the prebuilt
+         * OpenSBI firmware. Let's warn the user and then continue.
+        */
+        warn_report("No -bios option specified. Not loading a firmware.");
+        warn_report("This default will change in QEMU 4.3. Please use the " \
+                    "-bios option to aviod breakages when this happens.");
+        warn_report("See QEMU's deprecation documentation for details");
+        return;
+    }
+
+    if (!strcmp(machine->firmware, "default")) {
+        /*
+         * The user has specified "-bios default". That means we are going to
+         * load the OpenSBI binary included in the QEMU source.
+         *
+         * We can't load the binary by default as it will break existing users
+         * as users are already loading their own firmware.
+         *
+         * Let's try to get everyone to specify the -bios option at all times,
+         * so then in the future we can make "-bios default" the default option
+         * if no -bios option is set without breaking anything.
+         */
+        firmware_filename = qemu_find_file(QEMU_FILE_TYPE_BIOS,
+                                           default_machine_firmware);
+    } else {
+        firmware_filename = machine->firmware;
+    }
+
+    if (strcmp(firmware_filename, "none")) {
+        /* If not "none" load the firmware */
+        riscv_load_firmware(firmware_filename, firmware_load_addr);
+    }
+
+    if (!strcmp(machine->firmware, "default")) {
+        g_free(firmware_filename);
+    }
+}
+
 target_ulong riscv_load_firmware(const char *firmware_filename,
                                  hwaddr firmware_load_addr)
 {
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index ca53a9290d..71b8083c05 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -49,6 +49,8 @@
 
 #include <libfdt.h>
 
+#define BIOS_FILENAME "opensbi-riscv64-sifive_u-fw_jump.bin"
+
 static const struct MemmapEntry {
     hwaddr base;
     hwaddr size;
@@ -269,9 +271,8 @@ static void riscv_sifive_u_init(MachineState *machine)
     /* create device tree */
     create_fdt(s, memmap, machine->ram_size, machine->kernel_cmdline);
 
-    if (machine->firmware) {
-        riscv_load_firmware(machine->firmware, memmap[SIFIVE_U_DRAM].base);
-    }
+    riscv_find_and_load_firmware(machine, BIOS_FILENAME,
+                                 memmap[SIFIVE_U_DRAM].base);
 
     if (machine->kernel_filename) {
         riscv_load_kernel(machine->kernel_filename);
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index ecdc77d728..25faf3b417 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -44,6 +44,12 @@
 
 #include <libfdt.h>
 
+#if defined(TARGET_RISCV32)
+# define BIOS_FILENAME "opensbi-riscv32-virt-fw_jump.bin"
+#else
+# define BIOS_FILENAME "opensbi-riscv64-virt-fw_jump.bin"
+#endif
+
 static const struct MemmapEntry {
     hwaddr base;
     hwaddr size;
@@ -399,9 +405,8 @@ static void riscv_virt_board_init(MachineState *machine)
     memory_region_add_subregion(system_memory, memmap[VIRT_MROM].base,
                                 mask_rom);
 
-    if (machine->firmware) {
-        riscv_load_firmware(machine->firmware, memmap[VIRT_DRAM].base);
-    }
+    riscv_find_and_load_firmware(machine, BIOS_FILENAME,
+                                 memmap[VIRT_DRAM].base);
 
     if (machine->kernel_filename) {
         uint64_t kernel_entry = riscv_load_kernel(machine->kernel_filename);
diff --git a/include/hw/riscv/boot.h b/include/hw/riscv/boot.h
index daa179b600..d56f2ae3eb 100644
--- a/include/hw/riscv/boot.h
+++ b/include/hw/riscv/boot.h
@@ -20,6 +20,9 @@
 #ifndef RISCV_BOOT_H
 #define RISCV_BOOT_H
 
+void riscv_find_and_load_firmware(MachineState *machine,
+                                  const char *default_machine_firmware,
+                                  hwaddr firmware_load_addr);
 target_ulong riscv_load_firmware(const char *firmware_filename,
                                  hwaddr firmware_load_addr);
 target_ulong riscv_load_kernel(const char *kernel_filename);
diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
index c90b08d553..fff07bb2a3 100644
--- a/qemu-deprecated.texi
+++ b/qemu-deprecated.texi
@@ -121,6 +121,26 @@ the backing storage specified with @option{-mem-path} can actually provide
 the guest RAM configured with @option{-m} and QEMU will fail to start up if
 RAM allocation is unsuccessful.
 
+@subsection RISC-V -bios (since 4.1)
+
+QEMU 4.1 introduced support for the -bios option in QEMU for RISC-V for the
+RISC-V virt machine and sifive_u machine.
+
+QEMU 4.1 has no changes to the default behaviour to avoid breakages. This
+default will change in a future QEMU release, so please prepare now. All users
+of the virt or sifive_u machine must change their command line usage.
+
+QEMU 4.1 has three options, please migrate to one of these three:
+ 1. ``-bios none`` - This is the current default behavior if no -bios option
+      is included. QEMU will not automatically load any firmware. It is up
+      to the user to load all the images they need.
+ 2. ``-bios default`` - In a future QEMU release this will become the default
+      behaviour if no -bios option is specified. This option will load the
+      default OpenSBI firmware automatically. The firmware is included with
+      the QEMU release and no user interaction is required. All a user needs
+      to do is specify the kernel they want to boot with the -kernel option
+ 3. ``-bios <file>`` - Tells QEMU to load the specified file as the firmwrae.
+
 @section QEMU Machine Protocol (QMP) commands
 
 @subsection block-dirty-bitmap-add "autoload" parameter (since 2.12.0)
-- 
2.22.0



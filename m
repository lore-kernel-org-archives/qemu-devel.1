Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C02FCC7618F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 18:50:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 987C02064B
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 18:50:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Hrmca4UM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 987C02064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnSXJ-0001D9-Jd
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 14:50:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38350)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <prvs=093fafc25=alistair.francis@wdc.com>)
 id 1hnSX2-0000Gc-WC
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 14:50:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=093fafc25=alistair.francis@wdc.com>)
 id 1hnSWx-0003g8-UB
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 14:50:31 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:48520)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=093fafc25=alistair.francis@wdc.com>)
 id 1hnSWv-0003XC-ON; Tue, 16 Jul 2019 14:50:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1563303025; x=1594839025;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=DTXIwdCEuylUOYJ0yzJETYoiJ6ufBIHq462j22HZFdk=;
 b=Hrmca4UMRqe5jzbHDSKzLK+sykPpCjm1NzZJsY7j6cfB6fsvkPdOSU0H
 MVnsceEN90j2EU1U08ROBxOnmdu/XMePugRalgqIcIGntCbgB+MvXTGao
 N+LdZQi812KpwlklYiJCtcwvhcimams7vE7N9EPNeoTXYCFWfmfkc2LJM
 FrU7WfmvyRECiIEaNBdzyBV4EtzIhKf9R7FDZFkM5wkV5yEHV1D21XPel
 b1+zsiD4CR/HfmLYifFtOGw51U5JqMO1S4lAEUaSoObU8NUrtmms5zc6v
 2evrNjM+VpB7hCYuI170J1rp6NmESMhNI4U0tC7WvdPqLjBJqze6Om+w4 g==;
IronPort-SDR: b0qzG1tYSiWXJBL8DRhMOtVpCAuQSQhkW31zC8O5FcTdr/3fhH+U32Lxp5D/EXErE/NE+o/a8M
 0NZ6OUpSFcKgJYhASWOuSQc2qxpIe89JPFHKGs+MsEWKh6XIZ9lgSh7ftnkbRsX8lEGYKMteh9
 Jz4VbbYbH59JtLcl4ODc1dLVaLqI37HE4rSq6x/Ufyr38gY6AyWFuFRMkRHI1f2mIKRsgtAO0n
 OgQRidXrlEvLcnRoylxvVmwCb/mGv3Z2mBoHmyXTlZLDr1RcBHgTzbDaDaDKCQow1y91gdPHDk
 BkA=
X-IronPort-AV: E=Sophos;i="5.64,271,1559491200"; d="scan'208";a="219649593"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 17 Jul 2019 02:50:17 +0800
IronPort-SDR: DL6JSVp7q2lHKm8l4fm2oENtBe5zI/DNS1BP9Y10Z+JRpakPgdiYTaBJOROrQdnRCetZfndQPF
 XmN8x7cicVD66qBQe14DTwvF1vOI02pTZK6gKGt6pvYuH5htwp5o1xsRidN/AX6I2D57xE6/Wy
 bEjbPdmMWUu8nYSFrSo4aegD2e1lYl6BsBFfbGDMu12ViDbJCC821BS3Ln+81TCrSX1V79JQC3
 Ru97O3PgRn6tzI2SDrWGqivut+XZD6suE0gJndMEj6gGeETyMZxvy5H5AaOAHRp2k4oOdnMQZF
 9XFsmI79NASc8zTWqPNBZ5es
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP; 16 Jul 2019 11:48:45 -0700
IronPort-SDR: H3cQ3fYyDJhXqhAO6OXNM2qW7IxefcJ/0zd2tZpfWaEftQJqlbcj/ISF5mDZeUAgh2IdU8pZh4
 ETQRk11oiWnwkNxDCykl9z+qRjrhVwWrMVX5VrGImdzgLCGQXwKdv9DZsgi682qU/PCtipWKiP
 h9zOBtGgh5g9V5hvsXoGe2KOVvsTq1Ff63o5UZOd/aiBTeTuFvNVZSgm+QfA6ImE+tuZ9u9Qxy
 wUel43KpcfkiQVA4G1rxzak1MShMQFFpv7NrEFovg2aDvpGUu372E+Ce7dBnMGKrff3nephnUW
 M38=
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.140])
 by uls-op-cesaip01.wdc.com with ESMTP; 16 Jul 2019 11:50:18 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org,
	palmer@sifive.com
Date: Tue, 16 Jul 2019 11:47:25 -0700
Message-Id: <2e58de1517825685b64e21860a15c681d49bd040.1563302751.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1563302751.git.alistair.francis@wdc.com>
References: <cover.1563302751.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 68.232.141.245
Subject: [Qemu-devel] [PATCH v3 2/2] hw/riscv: Load OpenSBI as the default
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
Cc: peter.maydell@linaro.org, stefanha@gmail.co, codyprime@gmail.com,
 anup@brainfault.org, alistair.francis@wdc.com, stefanha@redhat.com,
 alistair23@gmail.com, pbonzini@redhat.com, linux@roeck-us.ne,
 bmeng.cn@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If the user hasn't specified a firmware to load (with -bios) or
specified no bios (with -bios none) then load OpenSBI by default. This
allows users to boot a RISC-V kernel with just -kernel.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
Tested-by: Bin Meng <bmeng.cn@gmail.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Tested-by: Guenter Roeck <linux@roeck-us.net>
---
 hw/riscv/boot.c         | 54 +++++++++++++++++++++++++++++++++++++++++
 hw/riscv/sifive_u.c     |  7 +++---
 hw/riscv/virt.c         | 11 ++++++---
 include/hw/riscv/boot.h |  3 +++
 qemu-deprecated.texi    | 20 +++++++++++++++
 5 files changed, 89 insertions(+), 6 deletions(-)

diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
index ff023f42d0..5dee63011b 100644
--- a/hw/riscv/boot.c
+++ b/hw/riscv/boot.c
@@ -18,6 +18,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu-common.h"
 #include "qemu/units.h"
 #include "qemu/error-report.h"
 #include "exec/cpu-defs.h"
@@ -32,6 +33,59 @@
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
+        if (firmware_filename == NULL) {
+            error_report("Unable to load the default RISC-V firmware \"%s\"",
+                         default_machine_firmware);
+            exit(1);
+        }
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



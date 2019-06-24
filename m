Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5418C4646B
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 22:24:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D99020674
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 22:24:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="N3ZGZfEt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D99020674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55036 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfXNc-0001fP-TH
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 18:24:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58815)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <prvs=07161884e=alistair.francis@wdc.com>)
 id 1hfXES-0002KL-TX
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 18:14:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=07161884e=alistair.francis@wdc.com>)
 id 1hfXEO-00005F-Oz
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 18:14:34 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:7996)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=07161884e=alistair.francis@wdc.com>)
 id 1hfXEM-0008U3-JI; Mon, 24 Jun 2019 18:14:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1561414516; x=1592950516;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=CqeGaTwLwtSj5t8Bw5VBD9Fwg69+EafHOWkeml/LuM8=;
 b=N3ZGZfEtGPok2+/f8cE+a7dKd0m/GTvskmYauZTKETJLv1TpQdWJ2/GQ
 5XMMbUpVJxjEKDwniIFOJDULYJrSkjpx0u4B81vtcHelIURUeyWAcX7r1
 dj+0m+K05PJRSRbCNZlUs/7lJVvgiLNUOamIW/4CnY1ytOzuzmsEzJRgG
 9qG2k1jJP5BusL8Rldp6Onc3iSaOlG9lPkwi7Fqznmoh5zmT+j5noiqcI
 We5T21MR/TnZpI+A7HtwA1XQ4WRXrCPf04g5UcKW72AMSBLUT/a3xdOuX
 2TQa+jFxsbTOKhmHa2pGGmI2beiI8vcD5Uu8rh3lDWkTXM6wIUpczlJdd A==;
X-IronPort-AV: E=Sophos;i="5.63,413,1557158400"; d="scan'208";a="211210932"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 25 Jun 2019 06:15:14 +0800
IronPort-SDR: s6zFBDL4cMDhcbrf0NEwupcZfAd4ZXWz5hqBkNCoyEcyLgtyV2yy95oBDrvrWSJ+OcwuHKtuJN
 k01DcN5wyQhI0J0VUDNVpZmN+wWqo4MNMHlvu96P2UIJclK6ViqBfAnRKdfULD05n9vJW/BipF
 e8/EcwEDrIjZy4QcVFHzd1PrkdkGBoVeEmFXpvP0nUzASQgngIAHSNzRd99r/cQoaMb3JCWLf2
 o/0GGe+xvZ/VojHYWvD/styiC9lonxI5mCsMBqrNorixi/yfhUYc8lDkDTfBD3UGCyIXfnOJAK
 CA009eT3Fu4UkApv7S+k42DW
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP; 24 Jun 2019 15:13:47 -0700
IronPort-SDR: Rj8S4SVPXB5XQRWwVqB5psbA9bYHP8YrCOSi0TWkdPYPbhQ1w09IvFgiPK5uQkkJ9m/9RNiWY+
 JYIeUyW4xlmJNOaWdF9aFsiCy8NtmiFCH1EY5rQ9mjqg47WYMboONNHBehYu5TvGzjymnATVet
 J/XGG9rFdhhgiPpKOZjKQEl44ZBISAWMY4umXJyQ9Ax6PD8p0NeZMeRLFsKn+sZjRflKMDPVU8
 0NJ1rvxIdpafBgHQRFJYWcIQ5Jlw8FVe7iN4giDepsPIo68pXXOJNsuRCSkq+cfXDo4MicsLS7
 Euk=
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.140])
 by uls-op-cesaip02.wdc.com with ESMTP; 24 Jun 2019 15:14:29 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Date: Mon, 24 Jun 2019 15:12:00 -0700
Message-Id: <7f51ed96a93bf46f76dbdfac61e4d14002d40e08.1561414240.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1561414240.git.alistair.francis@wdc.com>
References: <cover.1561414240.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 68.232.143.124
Subject: [Qemu-devel] [PATCH v1 5/5] hw/riscv: Load OpenSBI as the default
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
index a04f2d0754..d308aec592 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -49,6 +49,8 @@
 
 #include <libfdt.h>
 
+#define BIOS_FILENAME "opensbi-riscv64-sifive_u-fw_jump.bin"
+
 static const struct MemmapEntry {
     hwaddr base;
     hwaddr size;
@@ -266,9 +268,8 @@ static void riscv_sifive_u_init(MachineState *machine)
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
index 7fcc8c03b5..260e6e8e4d 100644
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
@@ -380,9 +386,8 @@ static void riscv_virt_board_init(MachineState *machine)
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
index df04f2840b..b0494c3350 100644
--- a/qemu-deprecated.texi
+++ b/qemu-deprecated.texi
@@ -88,6 +88,26 @@ The @code{-realtime mlock=on|off} argument has been replaced by the
 The ``-virtfs_synth'' argument is now deprecated. Please use ``-fsdev synth''
 and ``-device virtio-9p-...'' instead.
 
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



Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C18E4C4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 18:13:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0FDD205F4
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 18:13:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0FDD205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgvN6-0005BA-6A
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 14:13:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55250)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <palmer@dabbelt.com>) id 1hgulU-0000gR-1S
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 13:34:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1hgulQ-0001C0-5p
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 13:34:23 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44393)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1hgulP-00017k-Da
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 13:34:20 -0400
Received: by mail-pf1-f195.google.com with SMTP id t16so3319057pfe.11
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2019 10:34:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=S4egXU7gHZ0p7K3/lqDAFFby08GeyN4BgDviPdGN1ZY=;
 b=cFknR4RCDkpYJOIzVxvjSxPHZaU9/eOdB7y0jc8KqcO0xffH4ItMHi39RsH4n5S4RZ
 X3YI4NMcU3kOutgDYJkvLlt4gPWH325F0xE1T0SQEp9E4Z4/bGVKZHblGytNo3pSwwxk
 X3ZvUu8M72HVzpg1/w7SK5Jx/ry3iW3EKWDNG2F+iOtl8jFy/gNmwzx1lwiS5TF9BrLE
 CPgqTzWWWLJ/+e8mgoMBXHq49YBQbI6GOq8FO6OCF2S3n3EMHle8E81gV9uOsynBC+gK
 uqmr+9JFIcwOHiMdmfN2Xxdb/xrAgPfmpGkGrATchoyJzkrnCPxzspNu81cPWD6Krwig
 VPJw==
X-Gm-Message-State: APjAAAUC7q6XEHRk+VECFNtNwx2UtmoxMlR1fm++8TssYxpmh1W5kplk
 8TRtWKjxTubiTZUe7UGu0+D2WmjEz+sMvg+A
X-Google-Smtp-Source: APXvYqxcmzQ2UnYTYbU/afzOsC2xWfikVyYRmJic9Z/gtGxxKvE+3GL9US0BLStZ7V/THuKcgb6ndw==
X-Received: by 2002:a65:51cb:: with SMTP id i11mr10063649pgq.390.1561743255888; 
 Fri, 28 Jun 2019 10:34:15 -0700 (PDT)
Received: from localhost (220-132-236-182.HINET-IP.hinet.net.
 [220.132.236.182])
 by smtp.gmail.com with ESMTPSA id e26sm2793002pfn.94.2019.06.28.10.34.14
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 28 Jun 2019 10:34:15 -0700 (PDT)
Date: Fri, 28 Jun 2019 10:32:27 -0700
Message-Id: <20190628173227.31925-35-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190628173227.31925-1-palmer@sifive.com>
References: <20190628173227.31925-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.210.195
Subject: [Qemu-devel] [PULL 34/34] hw/riscv: Load OpenSBI as the default
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
Cc: Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Palmer Dabbelt <palmer@sifive.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alistair Francis <alistair.francis@wdc.com>

If the user hasn't specified a firmware to load (with -bios) or
specified no bios (with -bios none) then load OpenSBI by default. This
allows users to boot a RISC-V kernel with just -kernel.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
Tested-by: Bin Meng <bmeng.cn@gmail.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 hw/riscv/boot.c         | 49 +++++++++++++++++++++++++++++++++++++++++
 hw/riscv/sifive_u.c     |  7 +++---
 hw/riscv/virt.c         | 11 ++++++---
 include/hw/riscv/boot.h |  3 +++
 qemu-deprecated.texi    | 20 +++++++++++++++++
 5 files changed, 84 insertions(+), 6 deletions(-)

diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
index ff023f42d01d..23397edc8f15 100644
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
+         */
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
index 420867155293..49254b0c0f95 100644
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
index d8181a4ff18a..244019da9e72 100644
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
@@ -398,9 +404,8 @@ static void riscv_virt_board_init(MachineState *machine)
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
index daa179b600f4..d56f2ae3eb5d 100644
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
index 97ea4ef3001a..f33e6d1c80fb 100644
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
2.21.0



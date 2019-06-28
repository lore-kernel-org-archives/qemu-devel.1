Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93C28C4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 18:13:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73C7E205F4
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 18:13:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73C7E205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgvNQ-0005ML-PZ
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 14:13:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55159)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <palmer@dabbelt.com>) id 1hgulI-0000bD-4P
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 13:34:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1hgulF-0000ze-Jp
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 13:34:12 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34657)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1hgulF-0000yg-CW
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 13:34:09 -0400
Received: by mail-pg1-f195.google.com with SMTP id p10so2901951pgn.1
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2019 10:34:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=e4LpAArqCMZjxsWg9gz2sRwwsdArZOrpMF0nx0rvwxQ=;
 b=R0fCxX7rrYJxjrFGfPuQd/gMwY6ExtP+FJeWkO3HDpMTtpDwqzSVPTUYY9sfGy+IHF
 SiEzft4vwL01GLS9d7xaH1UEB3RbKPo49ZN6xflgY14Fyl46ywSFUKr6pNNm4uxdoPO7
 rPNVx0VdjKKN8g1ODERgJX6hW0XiovrL7swhvACSHa22sveK8Z9wMIsNaX2uP+ClcSj9
 oSZON64TJf8ZMvwSOie9/uhJD1VFbyB6A5PDI0FyXTpWb15n4XiQ0YREcM+aUzXu5BzS
 OtU+r8cwLUI8m+zYrpH/IVLaOL/LfdqAkvXxbsYZG0d1x0WnhUY6yMS+EoxhUz6IURAk
 lSqA==
X-Gm-Message-State: APjAAAUG8Umqyp57usgAFbIJetBNJEsbgB4inuOxYm6jJzuVSkZTmuAl
 mLXtPSBdxloxDEWE+0PKy5F/j1Yl6R/leRUl
X-Google-Smtp-Source: APXvYqxSYcyjBNfEe4msc8D99u6Qf3LrlwpFVoBuZHNoEzULQVRAIrkFU7aYxE0EjH5uEXPaebyXqA==
X-Received: by 2002:a63:e24c:: with SMTP id y12mr8553653pgj.81.1561743247429; 
 Fri, 28 Jun 2019 10:34:07 -0700 (PDT)
Received: from localhost (220-132-236-182.HINET-IP.hinet.net.
 [220.132.236.182])
 by smtp.gmail.com with ESMTPSA id o13sm2787513pje.28.2019.06.28.10.34.06
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 28 Jun 2019 10:34:06 -0700 (PDT)
Date: Fri, 28 Jun 2019 10:32:24 -0700
Message-Id: <20190628173227.31925-32-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190628173227.31925-1-palmer@sifive.com>
References: <20190628173227.31925-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.215.195
Subject: [Qemu-devel] [PULL 31/34] hw/riscv: Add support for loading a
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

Add support for loading a firmware file for the virt machine and the
SiFive U. This can be run with the following command:

    qemu-system-riscv64 -machine virt -bios fw_jump.bin -kernel vmlinux

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
Tested-by: Bin Meng <bmeng.cn@gmail.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 hw/riscv/boot.c         | 26 ++++++++++++++++++++++++++
 hw/riscv/sifive_u.c     |  4 ++++
 hw/riscv/virt.c         |  4 ++++
 include/hw/riscv/boot.h |  2 ++
 4 files changed, 36 insertions(+)

diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
index 0c8e72e455d7..883df49a0c65 100644
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
index f6b9c12e6094..420867155293 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -269,6 +269,10 @@ static void riscv_sifive_u_init(MachineState *machine)
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
index 485aefa99523..d8181a4ff18a 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -398,6 +398,10 @@ static void riscv_virt_board_init(MachineState *machine)
     memory_region_add_subregion(system_memory, memmap[VIRT_MROM].base,
                                 mask_rom);
 
+    if (machine->firmware) {
+        riscv_load_firmware(machine->firmware, memmap[VIRT_DRAM].base);
+    }
+
     if (machine->kernel_filename) {
         uint64_t kernel_entry = riscv_load_kernel(machine->kernel_filename);
 
diff --git a/include/hw/riscv/boot.h b/include/hw/riscv/boot.h
index f84fd6c2df5e..daa179b600f4 100644
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
2.21.0



Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32684C48BD6
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 15:57:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF0D920663
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 15:57:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF0D920663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgWmH-0008PN-RX
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 11:57:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33519)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <palmer@dabbelt.com>) id 1hgWHz-0003Wn-Vc
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 11:26:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1hgWHy-0000dr-AT
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 11:26:19 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38321)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1hgWHy-0007PP-0V
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 11:26:18 -0400
Received: by mail-pg1-f194.google.com with SMTP id z75so1179911pgz.5
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2019 08:24:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=e4LpAArqCMZjxsWg9gz2sRwwsdArZOrpMF0nx0rvwxQ=;
 b=hKwRMwXQ6K7x5O/6qXj57wDLQFmE9RD9RjZZMOlKuoxLsTrM6dOX4lUGtJ80olMKPJ
 0BXWSyc7b7m4wSRWKrnxXo0lra583P5jAjgqURoQkdfrUlDwm72ornCNarrUXtAT6dW9
 o2UiD0Cl0fcjQEGAGNDsQ2yEjAZsAtz/JvKE7wRaZXpyteSk6Nj4xUgyIx8lH8EHmLYr
 8USC9QwS4OfSYOhp2sNZforonZM1d+f/U+JJqj2ZHaqTqZEg6bjIhXamOWCCGsoag0Vt
 icXT+fgev/s5z21EFAIm9v5kVgnpsilAaYSu/ARHAy5KUCHZWbR7FifDP1btuvCyFrmA
 70rQ==
X-Gm-Message-State: APjAAAWxRHDeXRjwDgH/1TTWljWcmPzk5ewtjVlEU0BoBYA3vqRDI2eA
 Bd3nHuHdlumREQK+XLG8yxc3Fg==
X-Google-Smtp-Source: APXvYqzS4fXuAQgiD1T2BKjob0CchJ7MTjj7R/cWlOqcHh/t9hXv3QHR5RyjcllMlQMX/RZlOKvK3Q==
X-Received: by 2002:a63:e018:: with SMTP id e24mr4241570pgh.361.1561649079447; 
 Thu, 27 Jun 2019 08:24:39 -0700 (PDT)
Received: from localhost (220-132-236-182.HINET-IP.hinet.net.
 [220.132.236.182])
 by smtp.gmail.com with ESMTPSA id q3sm2364742pgv.21.2019.06.27.08.24.38
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 27 Jun 2019 08:24:39 -0700 (PDT)
Date: Thu, 27 Jun 2019 08:20:08 -0700
Message-Id: <20190627152011.18686-32-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190627152011.18686-1-palmer@sifive.com>
References: <20190627152011.18686-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.215.194
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



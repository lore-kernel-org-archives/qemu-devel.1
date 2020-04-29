Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53596C8300A
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 20:44:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CB3D2076B
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 20:44:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="QtzIKC7S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CB3D2076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTtZi-0005MJ-4m
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 16:44:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53858)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=381fbd49e=alistair.francis@wdc.com>)
 id 1jTtOn-000800-Sn
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 16:37:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <prvs=381fbd49e=alistair.francis@wdc.com>)
 id 1jTtOA-0006uM-1Q
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 16:33:41 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:7549)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=381fbd49e=alistair.francis@wdc.com>)
 id 1jTtKM-00065w-39; Wed, 29 Apr 2020 16:29:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1588192146; x=1619728146;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=8K43csOgq64VK9+paDVKjdj7aHmol+gVY4vaWz2xTyg=;
 b=QtzIKC7SIx1xQ+7vgMSBqunwICSKYfANrV7B1eRckMa5CG6mg6uSoQ3K
 HgsniZ/HfgwNezBp01HrXWQUipWplPJoM6C1xJxIiYq95fy8WFY2bQljL
 8U1tybc8V46s7510RSdGlfVdWFyZypwfIldFxBAUokttdwAIMOu/F1ozL
 2VyiTKG3Ua3R+2EPbGaBF4tfsp6STqv22sQJ+qQJ/GwSr2Pk4xKzC5yD/
 q5mKTxWajBtvvU18v2I5ouspGnHMD78J9mIT3ZAWf+AP99OE4bNArDjYN
 5Dwj9ilyQMDZr7zO2dikZJM8x0QX9qrnFIidpfqgbaxavI1YWaNsBnuDT A==;
IronPort-SDR: E1LJvxRvRWHvGsxLdxG6VBoqEvfvzb0rs4KWax+GI+sG++kBIQHMk7TpVorYEr44asLiwkoX/c
 BE2dncH0hu5NF+/pFvGzauPgoLPm1B8AbbtSTUFIx7NPzWuf/AnaNuqo9wRao5F1Lz8FAltQfg
 Ay+e2277503Q3sLdrAXv4RILKOgYmy3qVw14ZEItrSuW96Dvisg9CcqfD8bjJoZaoTPV47/GyC
 DY7KJrA9cL51iziccZFwCc5E3i1cz77odBvSIW4/D0suGYoOYiOdOK2KqmV3z+EdQfKnN429J7
 71k=
X-IronPort-AV: E=Sophos;i="5.73,333,1583164800"; d="scan'208";a="136507042"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 30 Apr 2020 04:28:41 +0800
IronPort-SDR: LGciCVkuQWL/jCldNBXep+SSLRJMvVfHcvmGxOhtbTkm65v4UYjljSl6ufRy0Ctyq8AVPdEPjk
 UcXzuMjsbwarwmOuKzD5iiL6hDg74GF48=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2020 13:18:46 -0700
IronPort-SDR: HIw8vDGu0W6LgtZ12Kx87k7c4AV6tn8AdbLI61I5BI49X9ORaml2BAJ42L1CzlVjBCEjyOFfbH
 8sX5jzwqq5Iw==
WDCIronportException: Internal
Received: from usa004631.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.56.145])
 by uls-op-cesaip01.wdc.com with ESMTP; 29 Apr 2020 13:28:41 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org
Subject: [PULL v2 12/14] hw/riscv: Add optional symbol callback ptr to
 riscv_load_firmware()
Date: Wed, 29 Apr 2020 13:20:04 -0700
Message-Id: <20200429202006.775322-13-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200429202006.775322-1-alistair.francis@wdc.com>
References: <20200429202006.775322-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=381fbd49e=alistair.francis@wdc.com;
 helo=esa4.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 16:28:37
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Received-From: 216.71.154.42
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
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Anup Patel <anup.patel@wdc.com>, palmerdabbelt@google.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Anup Patel <anup.patel@wdc.com>

This patch adds an optional function pointer, "sym_cb", to
riscv_load_firmware() which provides the possibility to access
the symbol table during kernel loading.

The pointer is ignored, if supplied with flat (non-elf) firmware image.

The Spike board requires it locate the HTIF symbols from firmware ELF
passed via "-bios" option.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 20200427080644.168461-2-anup.patel@wdc.com
Message-Id: <20200427080644.168461-2-anup.patel@wdc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/boot.c         | 13 ++++++++-----
 hw/riscv/sifive_u.c     |  2 +-
 hw/riscv/virt.c         |  2 +-
 include/hw/riscv/boot.h |  6 ++++--
 4 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
index b8e765277d..726300a171 100644
--- a/hw/riscv/boot.c
+++ b/hw/riscv/boot.c
@@ -36,7 +36,8 @@
 
 void riscv_find_and_load_firmware(MachineState *machine,
                                   const char *default_machine_firmware,
-                                  hwaddr firmware_load_addr)
+                                  hwaddr firmware_load_addr,
+                                  symbol_fn_t sym_cb)
 {
     char *firmware_filename = NULL;
 
@@ -76,7 +77,7 @@ void riscv_find_and_load_firmware(MachineState *machine,
 
     if (firmware_filename) {
         /* If not "none" load the firmware */
-        riscv_load_firmware(firmware_filename, firmware_load_addr);
+        riscv_load_firmware(firmware_filename, firmware_load_addr, sym_cb);
         g_free(firmware_filename);
     }
 }
@@ -96,12 +97,14 @@ char *riscv_find_firmware(const char *firmware_filename)
 }
 
 target_ulong riscv_load_firmware(const char *firmware_filename,
-                                 hwaddr firmware_load_addr)
+                                 hwaddr firmware_load_addr,
+                                 symbol_fn_t sym_cb)
 {
     uint64_t firmware_entry, firmware_start, firmware_end;
 
-    if (load_elf(firmware_filename, NULL, NULL, NULL, &firmware_entry,
-                 &firmware_start, &firmware_end, NULL, 0, EM_RISCV, 1, 0) > 0) {
+    if (load_elf_ram_sym(firmware_filename, NULL, NULL, NULL,
+                         &firmware_entry, &firmware_start, &firmware_end, NULL,
+                         0, EM_RISCV, 1, 0, NULL, true, sym_cb) > 0) {
         return firmware_entry;
     }
 
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index e32355a691..bed10fcfa8 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -352,7 +352,7 @@ static void sifive_u_machine_init(MachineState *machine)
     create_fdt(s, memmap, machine->ram_size, machine->kernel_cmdline);
 
     riscv_find_and_load_firmware(machine, BIOS_FILENAME,
-                                 memmap[SIFIVE_U_DRAM].base);
+                                 memmap[SIFIVE_U_DRAM].base, NULL);
 
     if (machine->kernel_filename) {
         uint64_t kernel_entry = riscv_load_kernel(machine->kernel_filename,
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index c621a970aa..daae3ebdbb 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -511,7 +511,7 @@ static void riscv_virt_board_init(MachineState *machine)
                                 mask_rom);
 
     riscv_find_and_load_firmware(machine, BIOS_FILENAME,
-                                 memmap[VIRT_DRAM].base);
+                                 memmap[VIRT_DRAM].base, NULL);
 
     if (machine->kernel_filename) {
         uint64_t kernel_entry = riscv_load_kernel(machine->kernel_filename,
diff --git a/include/hw/riscv/boot.h b/include/hw/riscv/boot.h
index df80051fbc..474a940ad5 100644
--- a/include/hw/riscv/boot.h
+++ b/include/hw/riscv/boot.h
@@ -24,10 +24,12 @@
 
 void riscv_find_and_load_firmware(MachineState *machine,
                                   const char *default_machine_firmware,
-                                  hwaddr firmware_load_addr);
+                                  hwaddr firmware_load_addr,
+                                  symbol_fn_t sym_cb);
 char *riscv_find_firmware(const char *firmware_filename);
 target_ulong riscv_load_firmware(const char *firmware_filename,
-                                 hwaddr firmware_load_addr);
+                                 hwaddr firmware_load_addr,
+                                 symbol_fn_t sym_cb);
 target_ulong riscv_load_kernel(const char *kernel_filename,
                                symbol_fn_t sym_cb);
 hwaddr riscv_load_initrd(const char *filename, uint64_t mem_size,
-- 
2.26.2



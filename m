Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E4EFC83007
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 20:40:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66B3A206D9
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 20:40:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="P/TgywJF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66B3A206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTtVH-0006f5-CU
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 16:40:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53868)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=381fbd49e=alistair.francis@wdc.com>)
 id 1jTtOo-00081S-PP
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 16:37:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <prvs=381fbd49e=alistair.francis@wdc.com>)
 id 1jTtOB-0006zR-Jq
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 16:33:42 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:7550)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=381fbd49e=alistair.francis@wdc.com>)
 id 1jTtKN-000664-Pq; Wed, 29 Apr 2020 16:29:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1588192147; x=1619728147;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=BPQHeYhW0+8Gd1YdWGKpS99M5X8zYqkIAis4E32nD/c=;
 b=P/TgywJFhavGyMzX26GWUwjsvo+I0NPl3Khv1Y9Fxc0nJiyGdh/LbNpR
 x0tAsysSqYuA/oFKBDAA+pdNO3DgLxZMZDQzaZ0/wTJ7EAXxT7KjP9AjL
 6ykrKfaRgNxFB8Ec4OZ3NJy3dV2gy4gPWwraDQxvB2neKSnT23oP+o8LO
 rx51J/4PJytTbEdB6U4UwrNpu3d0Sh5XjnC8cWNpkLiZGO4Hhtk+zz50r
 wJI7ShIBrj/lzb3rQYFy0ueTsJfwOtqR3LSM+7NRkwU/uqcOYZycPLIgG
 cTnptBZeWKUn6fSaoUtDAOg4/HJr1MtJVNICONP+gHpxgmAHnWryCkAJB A==;
IronPort-SDR: hEk41qYk53loe5d9q6y0B2iGGp6qC8spUn4WYsaQk9kHf5V9+YBt+t7WpQNHtGpKuV1FsmwlpA
 a6uRb1MvgS5hZUYFWXllxrQe+fBQThQvKjnZpnUJAClvMjbYFbLEAKiWIQVZHh+bn4xbvy8UVB
 2J4KuxcqIHD4TlW/yva6p2/WFI5c3ADLYxsL/mciy9PyJOEu7sLilELS4M3UsFUxRRVMRVNJ4f
 HVgszPCMCUoJpCZdwR4fhZpy3Ow7bRjgJn82gH63hxcYx4XtoKR0Z1t40FTugObcrpw728dzdC
 qnc=
X-IronPort-AV: E=Sophos;i="5.73,333,1583164800"; d="scan'208";a="136507043"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 30 Apr 2020 04:28:41 +0800
IronPort-SDR: suMPsxX5cumflKtLXCyoOzBS0ogUgyBmJ/WQVVZu//B8aXvIUshVysvLVqzXtddKnOyCy6P4f1
 n9RCMEotrcPe76c0Gagp9/8UqB60twKyk=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2020 13:18:46 -0700
IronPort-SDR: LydcghBi0ZGn/vw5XNvMIyGyR5ER2XuwCPher4EXTW8Qa0UPhEZt1nMQhTk4HCTSZ1rpV3lm0d
 FTTvl0c0HJsA==
WDCIronportException: Internal
Received: from usa004631.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.56.145])
 by uls-op-cesaip01.wdc.com with ESMTP; 29 Apr 2020 13:28:41 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org
Subject: [PULL v2 13/14] hw/riscv/spike: Allow loading firmware separately
 using -bios option
Date: Wed, 29 Apr 2020 13:20:05 -0700
Message-Id: <20200429202006.775322-14-alistair.francis@wdc.com>
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

This patch extends Spike machine support to allow loading OpenSBI
firmware (fw_jump.elf) separately using -bios option.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 20200427080644.168461-3-anup.patel@wdc.com
Message-Id: <20200427080644.168461-3-anup.patel@wdc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/spike.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
index 98697a244e..e7908b88fe 100644
--- a/hw/riscv/spike.c
+++ b/hw/riscv/spike.c
@@ -45,6 +45,12 @@
 
 #include <libfdt.h>
 
+#if defined(TARGET_RISCV32)
+# define BIOS_FILENAME "opensbi-riscv32-spike-fw_jump.elf"
+#else
+# define BIOS_FILENAME "opensbi-riscv64-spike-fw_jump.elf"
+#endif
+
 static const struct MemmapEntry {
     hwaddr base;
     hwaddr size;
@@ -187,8 +193,24 @@ static void spike_board_init(MachineState *machine)
     memory_region_add_subregion(system_memory, memmap[SPIKE_MROM].base,
                                 mask_rom);
 
+    riscv_find_and_load_firmware(machine, BIOS_FILENAME,
+                                 memmap[SPIKE_DRAM].base,
+                                 htif_symbol_callback);
+
     if (machine->kernel_filename) {
-        riscv_load_kernel(machine->kernel_filename, htif_symbol_callback);
+        uint64_t kernel_entry = riscv_load_kernel(machine->kernel_filename,
+                                                  htif_symbol_callback);
+
+        if (machine->initrd_filename) {
+            hwaddr start;
+            hwaddr end = riscv_load_initrd(machine->initrd_filename,
+                                           machine->ram_size, kernel_entry,
+                                           &start);
+            qemu_fdt_setprop_cell(s->fdt, "/chosen",
+                                  "linux,initrd-start", start);
+            qemu_fdt_setprop_cell(s->fdt, "/chosen", "linux,initrd-end",
+                                  end);
+        }
     }
 
     /* reset vector */
-- 
2.26.2



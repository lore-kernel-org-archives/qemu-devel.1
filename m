Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89FACC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 17:15:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5483B20DD4
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 17:15:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="AHwvbOvH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5483B20DD4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmKcG-0004AE-GH
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 13:15:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58614)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4324eb4de=alistair.francis@wdc.com>)
 id 1jmKUq-0001r8-CV
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 13:08:08 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:24435)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4324eb4de=alistair.francis@wdc.com>)
 id 1jmKUn-0004Ps-ET
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 13:08:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1592586507; x=1624122507;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=l12nKCebLDNm8crHR5U10P9+ehRAVHXDgPahy6nhwdg=;
 b=AHwvbOvHip1sMEh5IDe705+CiIE/3H+lD4UTTifofTep4Op29tvTW+Ul
 OEKHbykuwXknEwmW1JPXHQzHra9x1lXLGVAXkhr6fosvS87b5lef1A0fq
 3eRb1N/2cL9QjKv9ZloYlLAMd9vv7+0b/gxyO00i81LXGfHHHQ6fgQ6Wn
 ltFW1FO5z8NAbQYm2rcuF21iIiV4kepKbOvnu+CkhYaQglCkxXSWxXc3w
 xApFBEhG7ODthhHHTA63jfIf749niYM2Asb5U3qa6MpLwF+lomBJlvqzc
 PVQVpDGFdAZmFGWSb8slmJRaHoFdGZmJj2P3FbpvDTBjcjBGqOjGu6fvf A==;
IronPort-SDR: +uNRTvNFAOKqISOJs6+VK3BxJHwBEVBSGEsqnY8onyA9+xvw1oEv0OR/FWH6H9NXZeSeXwzWvM
 K/5cEnKwXsju5W8MyQqpP2xtLzLWB8xEjs9jf+dPtuEuqzqvG7TW7zFhB8WFtypn7HRe/ssGM9
 aF6IVwX+aaQ0xsvurW6Z6jbj1wvX2anTynv6vW52OZszP/GS8N0eKYBsvZ4ld2vIYUYAUftoBp
 U2w71jXfPXVE3bxYYl+AOYQifUPxCQkEnnOaHdjFh5BrLG6dvNl7wE6j1S21u1vbZzfLzuXeq3
 WCg=
X-IronPort-AV: E=Sophos;i="5.75,256,1589212800"; d="scan'208";a="243417020"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 20 Jun 2020 01:07:31 +0800
IronPort-SDR: CgRQBp62ptm6LjyKv9H1inJJIeJHm6c503LVyF37+Glu6dAV1PeZ1QHB+L1HONWut+G5znHlVb
 F3gXqBWc8APurm8VdLyaGZzqAXLDS17pI=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jun 2020 09:56:05 -0700
IronPort-SDR: BP7TMIBBijXalVdU7P2rM0X9oBeAWiLNiuvGeWLshLrDBdjWI19FGlZ/lTaPQMQnnhiSWCvRxX
 Rr0jnEHuYdAA==
WDCIronportException: Internal
Received: from unknown (HELO risc6-mainframe.hgst.com) ([10.86.58.142])
 by uls-op-cesaip02.wdc.com with ESMTP; 19 Jun 2020 10:07:29 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL v2 30/32] hw/riscv: sifive_u: Support different boot source per
 MSEL pin state
Date: Fri, 19 Jun 2020 09:58:15 -0700
Message-Id: <20200619165817.4144200-31-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619165817.4144200-1-alistair.francis@wdc.com>
References: <20200619165817.4144200-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=68.232.143.124;
 envelope-from=prvs=4324eb4de=alistair.francis@wdc.com;
 helo=esa2.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 13:07:24
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: alistair23@gmail.com, Bin Meng <bin.meng@windriver.com>,
 Alistair Francis <alistair.francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bin Meng <bin.meng@windriver.com>

SiFive FU540 SoC supports booting from several sources, which are
controlled using the Mode Select (MSEL[3:0]) pins on the chip.
Typically, the boot process runs through several stages before it
begins execution of user-provided programs.

The SoC supports booting from memory-mapped QSPI flash, which is
how start_in_flash property is used for at present. This matches
MSEL = 1 configuration (QSPI0).

Typical booting flows involve the Zeroth Stage Boot Loader (ZSBL).
It's not necessary for QEMU to implement the full ZSBL ROM codes,
because we know ZSBL downloads the next stage program into the L2
LIM at address 0x8000000 and executes from there. We can bypass
the whole ZSBL execution and use "-bios" to load the next stage
program directly if MSEL indicates a ZSBL booting flow.

Signed-off-by: Bin Meng <bin.meng@windriver.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 1592268641-7478-4-git-send-email-bmeng.cn@gmail.com
Message-Id: <1592268641-7478-4-git-send-email-bmeng.cn@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/riscv/sifive_u.h |  6 ++++++
 hw/riscv/sifive_u.c         | 39 +++++++++++++++++++++++++++++--------
 2 files changed, 37 insertions(+), 8 deletions(-)

diff --git a/include/hw/riscv/sifive_u.h b/include/hw/riscv/sifive_u.h
index f6d10ebfb6..27dc35e0a3 100644
--- a/include/hw/riscv/sifive_u.h
+++ b/include/hw/riscv/sifive_u.h
@@ -111,6 +111,12 @@ enum {
     SIFIVE_U_RTCCLK_FREQ = 1000000
 };
 
+enum {
+    MSEL_MEMMAP_QSPI0_FLASH = 1,
+    MSEL_L2LIM_QSPI0_FLASH = 6,
+    MSEL_L2LIM_QSPI2_SD = 11
+};
+
 #define SIFIVE_U_MANAGEMENT_CPU_COUNT   1
 #define SIFIVE_U_COMPUTE_CPU_COUNT      4
 
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index ed13bc043c..eb767aa863 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -405,8 +405,34 @@ static void sifive_u_machine_init(MachineState *machine)
     /* create device tree */
     create_fdt(s, memmap, machine->ram_size, machine->kernel_cmdline);
 
-    riscv_find_and_load_firmware(machine, BIOS_FILENAME,
-                                 memmap[SIFIVE_U_DRAM].base, NULL);
+    if (s->start_in_flash) {
+        /*
+         * If start_in_flash property is given, assign s->msel to a value
+         * that representing booting from QSPI0 memory-mapped flash.
+         *
+         * This also means that when both start_in_flash and msel properties
+         * are given, start_in_flash takes the precedence over msel.
+         *
+         * Note this is to keep backward compatibility not to break existing
+         * users that use start_in_flash property.
+         */
+        s->msel = MSEL_MEMMAP_QSPI0_FLASH;
+    }
+
+    switch (s->msel) {
+    case MSEL_MEMMAP_QSPI0_FLASH:
+        start_addr = memmap[SIFIVE_U_FLASH0].base;
+        break;
+    case MSEL_L2LIM_QSPI0_FLASH:
+    case MSEL_L2LIM_QSPI2_SD:
+        start_addr = memmap[SIFIVE_U_L2LIM].base;
+        break;
+    default:
+        start_addr = memmap[SIFIVE_U_DRAM].base;
+        break;
+    }
+
+    riscv_find_and_load_firmware(machine, BIOS_FILENAME, start_addr, NULL);
 
     if (machine->kernel_filename) {
         uint64_t kernel_entry = riscv_load_kernel(machine->kernel_filename,
@@ -424,13 +450,9 @@ static void sifive_u_machine_init(MachineState *machine)
         }
     }
 
-    if (s->start_in_flash) {
-        start_addr = memmap[SIFIVE_U_FLASH0].base;
-    }
-
     /* reset vector */
     uint32_t reset_vec[8] = {
-        0x00000000,
+        s->msel,                       /* MSEL pin state */
         0x00000297,                    /* 1:  auipc  t0, %pcrel_hi(dtb) */
         0x01c28593,                    /*     addi   a1, t0, %pcrel_lo(1b) */
         0xf1402573,                    /*     csrr   a0, mhartid  */
@@ -502,7 +524,8 @@ static void sifive_u_machine_instance_init(Object *obj)
                              sifive_u_machine_set_start_in_flash);
     object_property_set_description(obj, "start-in-flash",
                                     "Set on to tell QEMU's ROM to jump to "
-                                    "flash. Otherwise QEMU will jump to DRAM");
+                                    "flash. Otherwise QEMU will jump to DRAM "
+                                    "or L2LIM depending on the msel value");
 
     s->msel = 0;
     object_property_add(obj, "msel", "uint32",
-- 
2.27.0



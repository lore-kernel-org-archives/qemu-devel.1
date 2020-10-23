Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 011B4C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 16:28:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CAB421D47
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 16:28:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="jquRFi6o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CAB421D47
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVzvY-0004U7-7N
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 12:28:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37076)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=558518344=alistair.francis@wdc.com>)
 id 1kVzFL-0002AO-EM; Fri, 23 Oct 2020 11:44:51 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:3951)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=558518344=alistair.francis@wdc.com>)
 id 1kVzFJ-0003h7-IN; Fri, 23 Oct 2020 11:44:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1603467889; x=1635003889;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=/smQkHEQ02cPvnJeFsp8cH82tHAXNAZPq9pGxFHQWBk=;
 b=jquRFi6ozdt80PaS5cMCDzUT9JXGfTdofDWWR1wOnEmdeUCEys++vwVd
 JnYLs/MdxHBdOzQRdXyon8ZZu0AT3D1+Uwlf03+Do/Ec6OeogIXqGJp6r
 d9SFn1NdUUyLcwvgKzjqpdpPZkYA5iLH/ML1IBFIHQo+qdP3u9OA5hGix
 CJq7V33uMUrG5spl+/lqPw4A2+LWKJ0YFp9hCtJJd88pSTp2SL8x39lKx
 tUU0HmUk3LnPraiFPaEYU3h/qbtn1oaw09rN0z6b29ipG0zSe6DDSidBG
 robLk1GTWR0NaRvZobQeJCCBgbl3Wbm2hiRufqiD6yaADbWg/Pw7tlY5u g==;
IronPort-SDR: 2rZY9ppoVtyWgt8n5CFvHz0yDTvyliiNPjPmbks3/kigAt9ZelL3Fw16aYXGVqYEeJFAsH7SS3
 MMoMl3zvuusjE22OGX92tae8w/gD2IfNp02BPhV9FZm8azwAg4u9Tez1LE68H4YwXiXmrrg/1G
 plz+gbZVb+CyQUQJRItVBi2fK/Gbtb9HqSYbiDJC4du+OcYZupQknbhBSFbU92lui0UebRjGKw
 0qHDOep+4ybTpeO1F65qq6nv7seoWJhknqXz0/xBdJRSUub6oJQ1wbe6ScTFvpf6txwSBUUtbx
 +VA=
X-IronPort-AV: E=Sophos;i="5.77,408,1596470400"; d="scan'208";a="155168720"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 23 Oct 2020 23:44:47 +0800
IronPort-SDR: 7IiLzuDZS1EspGlxGLMBV/OewB46cjh0MhUsaDxhpxgAHPJXhKQm8Uv5IN75fuGmPpM7b1uUZa
 /OEYuBbxTtLszqYkuyK4p+oKGl/G1IUWMeR6Jacrot0+WROmWB3Szzie057HoUb+JikOKAaij6
 ISZz6RbYbRYHkktcFB3H7g8rtU7bRGuFmmKx/3wzRO7UHqRry5t2JZ94cJbxsfSkp2XgA3ivw6
 G+vekff/z5aw+OwdeGUw85CfyxXYVI6b0UfxXP5CIlfOZ8PH8/rKyuhHDTNY4OrpDGdHdDSknS
 F91Gxog5jhvGB7AdPSXY3u6n
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2020 08:30:02 -0700
IronPort-SDR: S4Mr4Mozst6bZSAPIbd5qOe+y+3vliysa/gtUBoMO29uwsyGVg425uZ0GvL0TjTqUCv8E4aGOw
 n/qFkVrDcyEflzMEFYwausZYBiB3OGP5IPBm4MWqtqr50zXlCpfz1cbLh5bRp7vkk4TWMF3Alw
 D5ZBg0Vv7UoYmdEdNA8JF0nmGTKGAYsZj5KzGZxF+xzm6uX1zvPpcOWllM1L+th0441EKlf6cT
 RDsUJdiYs7xO27JyvdQPN7lqhYh5rlLyuYyFCYu5TPzJC38rMN0xcDfDdEhS6wvKVBloVXUrKe
 GXU=
WDCIronportException: Internal
Received: from cnf006900.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.60.46])
 by uls-op-cesaip01.wdc.com with ESMTP; 23 Oct 2020 08:44:47 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v1 05/16] hw/riscv: virt: Remove compile time XLEN checks
Date: Fri, 23 Oct 2020 08:33:26 -0700
Message-Id: <c1ea88d79c585a0c1af70acd16ce859d6d9154ba.1603467169.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1603467169.git.alistair.francis@wdc.com>
References: <cover.1603467169.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=558518344=alistair.francis@wdc.com;
 helo=esa3.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 11:44:48
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: alistair.francis@wdc.com, bmeng.cn@gmail.com, palmer@dabbelt.com,
 alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/virt.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 192138cc76..e76c0a32b9 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -43,12 +43,6 @@
 #include "hw/pci/pci.h"
 #include "hw/pci-host/gpex.h"
 
-#if defined(TARGET_RISCV32)
-# define BIOS_FILENAME "opensbi-riscv32-generic-fw_dynamic.bin"
-#else
-# define BIOS_FILENAME "opensbi-riscv64-generic-fw_dynamic.bin"
-#endif
-
 static const struct MemmapEntry {
     hwaddr base;
     hwaddr size;
@@ -177,7 +171,7 @@ static void create_pcie_irq_map(void *fdt, char *nodename,
 }
 
 static void create_fdt(RISCVVirtState *s, const struct MemmapEntry *memmap,
-    uint64_t mem_size, const char *cmdline)
+                       uint64_t mem_size, const char *cmdline, bool is_32_bit)
 {
     void *fdt;
     int i, cpu, socket;
@@ -231,11 +225,11 @@ static void create_fdt(RISCVVirtState *s, const struct MemmapEntry *memmap,
             cpu_name = g_strdup_printf("/cpus/cpu@%d",
                 s->soc[socket].hartid_base + cpu);
             qemu_fdt_add_subnode(fdt, cpu_name);
-#if defined(TARGET_RISCV32)
-            qemu_fdt_setprop_string(fdt, cpu_name, "mmu-type", "riscv,sv32");
-#else
-            qemu_fdt_setprop_string(fdt, cpu_name, "mmu-type", "riscv,sv48");
-#endif
+            if (is_32_bit) {
+                qemu_fdt_setprop_string(fdt, cpu_name, "mmu-type", "riscv,sv32");
+            } else {
+                qemu_fdt_setprop_string(fdt, cpu_name, "mmu-type", "riscv,sv48");
+            }
             name = riscv_isa_string(&s->soc[socket].harts[cpu]);
             qemu_fdt_setprop_string(fdt, cpu_name, "riscv,isa", name);
             g_free(name);
@@ -595,7 +589,8 @@ static void virt_machine_init(MachineState *machine)
         main_mem);
 
     /* create device tree */
-    create_fdt(s, memmap, machine->ram_size, machine->kernel_cmdline);
+    create_fdt(s, memmap, machine->ram_size, machine->kernel_cmdline,
+               riscv_is_32_bit(machine));
 
     /* boot rom */
     memory_region_init_rom(mask_rom, NULL, "riscv_virt_board.mrom",
@@ -603,8 +598,15 @@ static void virt_machine_init(MachineState *machine)
     memory_region_add_subregion(system_memory, memmap[VIRT_MROM].base,
                                 mask_rom);
 
-    firmware_end_addr = riscv_find_and_load_firmware(machine, BIOS_FILENAME,
-                                                     start_addr, NULL);
+    if (riscv_is_32_bit(machine)) {
+        firmware_end_addr = riscv_find_and_load_firmware(machine,
+                                    "opensbi-riscv32-generic-fw_dynamic.bin",
+                                    start_addr, NULL);
+    } else {
+        firmware_end_addr = riscv_find_and_load_firmware(machine,
+                                    "opensbi-riscv64-generic-fw_dynamic.bin",
+                                    start_addr, NULL);
+    }
 
     if (machine->kernel_filename) {
         kernel_start_addr = riscv_calc_kernel_start_addr(machine,
-- 
2.28.0



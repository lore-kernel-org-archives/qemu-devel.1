Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECD8FC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 18:41:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB15820748
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 18:41:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="iDd1tbAS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB15820748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqhfZ-0002yY-0q
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 14:41:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47900)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=4447ca4a2=atish.patra@wdc.com>)
 id 1jqheS-00016c-1F; Wed, 01 Jul 2020 14:40:08 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:13143)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=4447ca4a2=atish.patra@wdc.com>)
 id 1jqheN-0006V6-SH; Wed, 01 Jul 2020 14:40:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593628803; x=1625164803;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=SFTnFlIICJQUz0ffsBvrvq+0Fk4gFQoQwkbeCbQrNg0=;
 b=iDd1tbAS7F6tmZtPk/NP7NnWOPZNBR4muJanp/bwuMD7WPyWpavud3hV
 y+p6zLSt3FegRws1YXRiNjwvfZ9U/gvCiM0eBJKvkG3zVTFoO5pFqcL80
 gAHvKZY0daZmdq9HQKLMe0uboa/0KbP62VOp96ySOFX6h7CYt8Rc2sjJl
 9rutt3qlhKXGoWwP9H5ysITkLGND7K1S6VhLT0wd1ZF0rqlFv4JsyPqr9
 TbFcujfF5vPOAVn1jmUq+XpvwmuaN+/kimJtOfMHsIZ1PLq3oKA8v5H3x
 exBpkIPwVOqGeWwNBLl4WN74ePX3GDDoZ1cITChtToGcdIcYB7u35JvcK w==;
IronPort-SDR: ZcDEmU1Ym0J7B7lUY/JokUDOsLOxawrFqQ22JsxZjS5FNbemCWvKu4lBD7dGo9EXxF0/7wI6et
 mj1F218PJGDhnkV6bJglE90nQ8TM7SRmSR4rha3iNHxxsJF1RRWvAu8p819t98XZvvtxkgv+vS
 rlSos0TLFl0yKEVpUcESbcLrjf3ELWat9jmEdK2xI9Hpg9IWfonbyu78WSiMe0MqyjP1h8A3It
 uY6L1U21Oag2tJ4gyZGn454WtFvXFukVA/llH2Kw92bDUxnxx0gibVb7JPTuQdIP+oSmD2fmLl
 NWE=
X-IronPort-AV: E=Sophos;i="5.75,301,1589212800"; d="scan'208";a="250642378"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 02 Jul 2020 02:39:55 +0800
IronPort-SDR: fraHkk0LluqpOjQlfmSYOcwsdFPHanE2/RtOF5IyVChHpf6zxh1KjLqW3E+q8oR+S1qPAm1ocF
 0Q1FBivtlUwY6uFRdDm47Zbwj/zcDE1s8=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2020 11:28:12 -0700
IronPort-SDR: TTB9c+ZRifkn05sOBkIASo9Jbci22bYtbGasVUtEB9Kls+JrAMkYM3ch2P5TkU77sdcifqRS/g
 zsrqmyC/TS0Q==
WDCIronportException: Internal
Received: from cnf006900.ad.shared (HELO yoda.hgst.com) ([10.86.58.95])
 by uls-op-cesaip02.wdc.com with ESMTP; 01 Jul 2020 11:39:55 -0700
From: Atish Patra <atish.patra@wdc.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 4/4] RISC-V: Support 64 bit start address
Date: Wed,  1 Jul 2020 11:39:49 -0700
Message-Id: <20200701183949.398134-5-atish.patra@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200701183949.398134-1-atish.patra@wdc.com>
References: <20200701183949.398134-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=4447ca4a2=atish.patra@wdc.com; helo=esa1.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/01 14:39:54
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
Cc: qemu-riscv@nongnu.org, Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Atish Patra <atish.patra@wdc.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 Alexander Richardson <Alexander.Richardson@cl.cam.ac.uk>,
 Palmer Dabbelt <palmer@dabbelt.com>, Bin Meng <bmeng.cn@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Even though the start address in ROM code is declared as a 64 bit address
for RV64, it can't be used as upper bits are set to zero in ROM code.

Update the ROM code correctly to reflect the 64bit value.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 hw/riscv/boot.c     | 6 +++++-
 hw/riscv/sifive_u.c | 6 +++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
index feff6e3f4ed5..4c6c101ff179 100644
--- a/hw/riscv/boot.c
+++ b/hw/riscv/boot.c
@@ -226,7 +226,11 @@ void riscv_setup_rom_reset_vec(hwaddr start_addr, hwaddr rom_base,
                                uint32_t fdt_load_addr, void *fdt)
 {
     int i;
+    uint32_t start_addr_hi32 = 0x00000000;
 
+    #if defined(TARGET_RISCV64)
+    start_addr_hi32 = start_addr >> 32;
+    #endif
     /* reset vector */
     uint32_t reset_vec[10] = {
         0x00000297,                  /* 1:  auipc  t0, %pcrel_hi(fw_dyn) */
@@ -241,7 +245,7 @@ void riscv_setup_rom_reset_vec(hwaddr start_addr, hwaddr rom_base,
 #endif
         0x00028067,                  /*     jr     t0 */
         start_addr,                  /* start: .dword */
-        0x00000000,
+        start_addr_hi32,
         fdt_load_addr,               /* fdt_laddr: .dword */
         0x00000000,
                                      /* fw_dyn: */
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 901efab9d5bd..3aaee82f1f28 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -378,6 +378,7 @@ static void sifive_u_machine_init(MachineState *machine)
     MemoryRegion *main_mem = g_new(MemoryRegion, 1);
     MemoryRegion *flash0 = g_new(MemoryRegion, 1);
     target_ulong start_addr = memmap[SIFIVE_U_DRAM].base;
+    uint32_t start_addr_hi32 = 0x00000000;
     int i;
     uint32_t fdt_load_addr;
     uint64_t kernel_entry;
@@ -460,6 +461,9 @@ static void sifive_u_machine_init(MachineState *machine)
     /* Compute the fdt load address in dram */
     fdt_load_addr = riscv_load_fdt(memmap[SIFIVE_U_DRAM].base,
                                    machine->ram_size, s->fdt);
+    #if defined(TARGET_RISCV64)
+    start_addr_hi32 = start_addr >> 32;
+    #endif
 
     /* reset vector */
     uint32_t reset_vec[11] = {
@@ -476,7 +480,7 @@ static void sifive_u_machine_init(MachineState *machine)
 #endif
         0x00028067,                    /*     jr     t0 */
         start_addr,                    /* start: .dword */
-        0x00000000,
+        start_addr_hi32,
         fdt_load_addr,                 /* fdt_laddr: .dword */
         0x00000000,
                                        /* fw_dyn: */
-- 
2.26.2



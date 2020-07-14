Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB707C433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 00:43:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC77D21841
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 00:43:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="pM6oHAfk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC77D21841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jv934-0007ZI-1m
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 20:43:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51976)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=457b4eeb6=alistair.francis@wdc.com>)
 id 1jv91r-0005rb-AK
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 20:42:39 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:30777)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=457b4eeb6=alistair.francis@wdc.com>)
 id 1jv91p-0008Oh-HC
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 20:42:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1594687357; x=1626223357;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=9ZxznTewde8ZUXzQUlIEhOiky01rG5EcL9nfdxqoQTE=;
 b=pM6oHAfkoMzefxvsF4Uulwnd7JnbI0fh7/QJQui6gfzHNsYUSBu2n7nZ
 KGaLfDw+9G9co0FxN4X1NJs7Rphau/s0hoOWSdppWdE3JiDiUKtXlw6WS
 E9+UGDonJIY4RiYWMn2a1SUSJ8YTe8yOZBKvfhZD6AFTxaoG4DAcLsev/
 nj/uKyJZ7G2z6HNmMvsVFGINlvqLaDNW68ED4p9gtzOnPNJJRyUDvvy0i
 bYm86/PS3BSOgSL/HdO+nCMk3qrZQy3ev6NFyKXpo2C/V1BkokOppwZV7
 CN7zx1z/xmS6ihKxSkB5fxH1DYUva3gmnXmKmzOjAYafg3bLNBLSBa094 w==;
IronPort-SDR: AV1ylQDHH+teoxDPQCt7pAN83XxPAKER7seOKbWJ3VFeTl7yaKeyoH65Frqo1wQCwUoJCg+0/Y
 MLxWVNprYPpxdVIoWLrvgIP5DSthpg2kU3fg0sYIMGzLqzZCotwL2yWWaZEwSb1MaRugYC+HSZ
 qwTzA0gWZ+74C2XssGvN0YpYMpNpGlcNSZsfmRQ8cPhMgqdMe5vb+Ci4HDLLGL6/kPdzHRis7y
 +9HBeNGiaFEFo9+37sbqGzhvMA7x0GlIa2gDCDkFLuiYVYlekizGOzuNzKwgwaygo3iKkLk0dm
 5tU=
X-IronPort-AV: E=Sophos;i="5.75,349,1589212800"; d="scan'208";a="142511923"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 14 Jul 2020 08:42:29 +0800
IronPort-SDR: jsK3TOpkKmnKzuYPTYymx9b6WjnwJxfJ7nr57+IlHhDJpx2m1X9ctk3QBvBQ9X7M4Fmd7w5UBO
 aiIQffsVE4ayVz4cqiV1XhTsa/eD2RHtE=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jul 2020 17:30:57 -0700
IronPort-SDR: YyVQ373fxL50qkqMYrr8Erf/jCfVxskWIOzoT9IEf1ipvztNlGMN51YG9k701iXJoxGIJO+oz6
 pQqjeD1EkFxw==
WDCIronportException: Internal
Received: from usa002626.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.57.178])
 by uls-op-cesaip02.wdc.com with ESMTP; 13 Jul 2020 17:42:29 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Subject: [PULL 06/15] RISC-V: Support 64 bit start address
Date: Mon, 13 Jul 2020 17:32:45 -0700
Message-Id: <20200714003254.4044149-7-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200714003254.4044149-1-alistair.francis@wdc.com>
References: <20200714003254.4044149-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.144;
 envelope-from=prvs=457b4eeb6=alistair.francis@wdc.com;
 helo=esa5.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 20:42:28
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Atish Patra <atish.patra@wdc.com>, Bin Meng <bin.meng@windriver.com>,
 Alistair Francis <alistair.francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Atish Patra <atish.patra@wdc.com>

Even though the start address in ROM code is declared as a 64 bit address
for RV64, it can't be used as upper bits are set to zero in ROM code.

Update the ROM code correctly to reflect the 64bit value.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
Reviewed-by: Bin Meng <bin.meng@windriver.com>
Tested-by: Bin Meng <bin.meng@windriver.com>
Message-Id: <20200701183949.398134-5-atish.patra@wdc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/boot.c     | 6 +++++-
 hw/riscv/sifive_u.c | 6 +++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
index feff6e3f4e..4c6c101ff1 100644
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
index 46e6ed90ca..6595ab3f87 100644
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
2.27.0



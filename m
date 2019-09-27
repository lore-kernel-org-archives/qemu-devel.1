Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CFD5C4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 00:57:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D97BD21783
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 00:57:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Gbg2KK1U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D97BD21783
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDeZH-0008Aa-Sa
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 20:57:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49417)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=1662a5b7b=alistair.francis@wdc.com>)
 id 1iDeRO-000764-0K
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 20:48:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=1662a5b7b=alistair.francis@wdc.com>)
 id 1iDeRN-00006A-0A
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 20:48:57 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:63397)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=1662a5b7b=alistair.francis@wdc.com>)
 id 1iDeRM-0008VX-Nc; Thu, 26 Sep 2019 20:48:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1569545337; x=1601081337;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ENasHGS+g9tLPWNh3aiQ6ypnoRzlgfskAvUW+2KIzv4=;
 b=Gbg2KK1UP/779ndm1gJfRdvWRd5Orv2oJLnrCQyRXVDW8r14joG6EMPg
 iFvV22TmlR4N4tUX5bMTiI86fXgjim1cnHlwUqP1h9LNwBhf0dsL79vYm
 Rj5ts48nB9UvUaZ3z+fgIokGBU0ul4SLVXmk+6LAr50Of5wla9ibs4NdN
 hd9eB3Rhp0GDWrHvjw4UvyyLz9IZVhvSNYCIiXN9L7GUbBS7sGZCt7eft
 2PD1mvbm6OkzG8NLJGz7KYbFTXFESPc809+2cLpl4tmEuF6AMkPYtqFgi
 8woMAMKUDFUQHDaKpK3UWk0ErX+Czqk442mNKqOsT3IDDXRxFEPhVEWhN g==;
IronPort-SDR: BM8O42wNPnP/q9zNGek1C0x+loOGwKfN9nWbEJiVwpVo9gjKV/6h06tu8fMGQLaRa694A4+i60
 RkDN/bBfWCyl3acBIdVAM14AfULTAZwuNWIMbrqHamV51z/j0pSJ0HU973iWeQh72+gXqhaBnx
 IBL5jm8wp/j4CBVxcuwJVNI3SNZqJZ9TD+DXDOOzJlmCnD9kMWqrILMSCaqIrwtfY4DxUNT6fz
 dlUmkd9sE3LIPj3gLN9JQE+WKwRiwonAM0aYEAE3MOSOSExQsnBY/0Fm+ukGoVzFRIk5hcxrgL
 wg4=
X-IronPort-AV: E=Sophos;i="5.64,553,1559491200"; d="scan'208";a="123689892"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 27 Sep 2019 08:48:56 +0800
IronPort-SDR: I/ZrxTyWtWJv1TDUMDUdJ07oKk1UB7Nv2h/ly8OvmftqKJjkn+nHynNBr/2iHlv9Lcwu6ouIf9
 CUQNpaJAbklTw3pigWll/n0gRRirNvNu5cVr59+NQnaYt9WLaOpgwb97miIjz8FCOYApe1k5aJ
 6cS3WuMAeYMhceBVPkH0CkpU7svxWsuKOzMezgoa85xuRc4fUe487/6165pPcatPek+vcD48nr
 +/gm8W9j2GInVUjAe15kRYP072LzP0ja+TsMdT4Wi3uZXQ4D88MIQzx8D/YLdiPiE/0CYvtkjK
 KCuZjCOUsiI7ieB9AZ8J2LgL
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Sep 2019 17:45:09 -0700
IronPort-SDR: E+0u4lm0pl5rSPXIk9RjgeNfu/528T7ygv1M2As0ENxd+bOLf51BEgCribrPi/IhtatWNt206L
 dmP+IQOeHwUJ2HqOzXJQVeBO1u2dvOUfi8xF3PPW8q1UuliRF7pk4dsmYsTqJkxxU7MHgslrLn
 LqIiS6VHyCeFNau3L/RrW6ltIrj/j6n0jNgds9ne3ROcBq+CCE7Pkyu2xYIVYrkY/VHBwFbuaF
 UKIATLJRoHdeZ/91Rkmh5PNrxlMnKPbrWTUl1ryG3eSIOz3JGv6MuYFufwj/8u+LVTCyDGcroe
 gnQ=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.58])
 by uls-op-cesaip01.wdc.com with ESMTP; 26 Sep 2019 17:48:55 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v2 7/7] riscv/virt: Jump to pflash if specified
Date: Thu, 26 Sep 2019 17:44:36 -0700
Message-Id: <c02135a1838ad7b289774b03989424a7a40b38d3.1569545046.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1569545046.git.alistair.francis@wdc.com>
References: <cover.1569545046.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 216.71.153.141
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

If the user supplied pflash to QEMU then change the reset code to jump
to the pflash base address instead of the DRAM base address.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/riscv/virt.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index ad29e14d5f..a79d16d99a 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -445,6 +445,7 @@ static void riscv_virt_board_init(MachineState *machine)
     MemoryRegion *mask_rom = g_new(MemoryRegion, 1);
     char *plic_hart_config;
     size_t plic_hart_config_len;
+    target_ulong start_addr = memmap[VIRT_DRAM].base;
     int i;
     unsigned int smp_cpus = machine->smp.cpus;
 
@@ -491,6 +492,14 @@ static void riscv_virt_board_init(MachineState *machine)
         }
     }
 
+    if (drive_get(IF_PFLASH, 0, 0)) {
+        /*
+         * Pflash was supplied, let's overwrite the address we jump to after
+         * reset to the base of the flash.
+         */
+        start_addr = virt_memmap[VIRT_FLASH].base;
+    }
+
     /* reset vector */
     uint32_t reset_vec[8] = {
         0x00000297,                  /* 1:  auipc  t0, %pcrel_hi(dtb) */
@@ -503,7 +512,7 @@ static void riscv_virt_board_init(MachineState *machine)
 #endif
         0x00028067,                  /*     jr     t0 */
         0x00000000,
-        memmap[VIRT_DRAM].base,      /* start: .dword memmap[VIRT_DRAM].base */
+        start_addr,                  /* start: .dword */
         0x00000000,
                                      /* dtb: */
     };
-- 
2.23.0



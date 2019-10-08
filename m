Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96351C4360C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 23:46:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6076A20873
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 23:46:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="j4gwr/67"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6076A20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHzBc-0000Pt-CF
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 19:46:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33081)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=177211c83=alistair.francis@wdc.com>)
 id 1iHz2N-0000gA-Fc
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 19:37:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=177211c83=alistair.francis@wdc.com>)
 id 1iHz2L-0006VV-LI
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 19:37:02 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:55070)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=177211c83=alistair.francis@wdc.com>)
 id 1iHz2L-0006Tc-8c; Tue, 08 Oct 2019 19:37:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1570577821; x=1602113821;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=RU8L3oxCCu9rwkGr2v5lEfYto4Cw/aINw92350YjUp8=;
 b=j4gwr/67d++55lsKAfTX5SREEy/BOfu91AVGg09el7+xrNVe3dVU7CQ6
 D+krLEeAVqc/uMeXVGIfNkxlRTsjHNo1+MZt7evKVvYUruHPVnYCaRqj8
 u2ohsFutcil1zaeYZ3esJIr4b8Hr8AR3UasdQPlCnAqmBfjoYVuazU7Cz
 6aF5jky3Bqy/4n52SmCm1KgLJr1kG2MmRztzjVnaeIKmH4/WlFVdwwKQW
 5tNqk/jDN04tALm7hsRn8JWGJ0LRRoH2POR6F+/bwk/CiZC4cF3gNgUKt
 ELR7k+fCWac1UYGJETMkEdGA01CdRcwtgiRZb2r2eG6R1X8aMD66oblLn Q==;
IronPort-SDR: Cuo5cqX/2nmKQ+v+Tu7PD/7LmJTAVXPBxz6Uh2GuZC49/ZBE9hdvFXL0B6ajMqZIsM8+RWMFG3
 J1eNtWdk2ejEeriHmrOc4A0k60zlJBcR4Zb01YxovQsKsLLIXMN47QQnt4YJ4CUXbYPDxRvAuu
 GVrJpeQIWowx1OY7fVRWG4tCfLc7tOVHxseCeMevcVXPwyy/6lfEe22cffvq4NTwe+VSB7Kw+E
 rMypuN1NDPSz3zt37K6aZkERmv7bS9t+W/5th09uxNYajzMwypHOymRjyq4dhmAOzOZ3dcrg9A
 N/c=
X-IronPort-AV: E=Sophos;i="5.67,273,1566835200"; d="scan'208";a="120085879"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 09 Oct 2019 07:37:00 +0800
IronPort-SDR: DcFjVJqdBQgI9fazqAJ6grSV6crstLZWuM7SJ6/dg/Y8TcYFno/V33fPKTxWfc+9tpVHspBEwM
 IGLo/bTCNukhL4vHHvNoLdHpTv913zZ4AjV5m3VXqT3vJObX3RUI5Br2ivAXPjsCaW0jCtY0hi
 cCOYLjlLyVC99DTtbJdfl0j83BbQ24cXVyb+ZExcQ7TjMmpSU5p8dxi28zDjTi3V+oIqsetMZB
 7cqOYFBnNcdwjPMKuB5oYXXcVGyHiYogezBPvetOO6IO1vvLyaWZWCTPfRv3rIabQvYksB+tXg
 4XDksQv/+AlwFCl1L3GZRReH
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2019 16:32:55 -0700
IronPort-SDR: Oey/FfhnXJjAxlfNX5/vzfwxAy6t+zqluSyETm0CX8W/Z6UF+joQnKtLrKV1pH3ml/YR4Th854
 H1PUnLWmApxdcTWHaaXnfITt7SDFSWPLCH8tRZd9eg/dW4iXfPovNAXGHERlhHCNRTLiol2zFd
 AUrF8Qi2zojGT2TfIFGmEWkBwJeBcl1GGFey4fjykZSbrFYIAZiaqimgDviGQkekC6Li6+mkTr
 mhQu7630s6mYK5Rt4Lnf6tTQoP0sHL11vHexRXXeFhYg9VpbFbAtdhJ6Ydu5R6xjKZwQX+Bngv
 Ot8=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.58])
 by uls-op-cesaip02.wdc.com with ESMTP; 08 Oct 2019 16:37:01 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v3 7/7] riscv/virt: Jump to pflash if specified
Date: Tue,  8 Oct 2019 16:32:29 -0700
Message-Id: <17eaa7913cfb731de7311e0e63b26723706073eb.1570577500.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1570577500.git.alistair.francis@wdc.com>
References: <cover.1570577500.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
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
Cc: alistair23@gmail.com, palmer@sifive.com, alistair.francis@wdc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If the user supplied pflash to QEMU then change the reset code to jump
to the pflash base address instead of the DRAM base address.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Bin Meng <bmeng.cn@gmail.com>
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



Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9267AC2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 15:48:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0658C2071E
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 15:48:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="K3c8GjPm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0658C2071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZyXX-0004xD-3H
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 10:48:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51888)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=569a91e0c=alistair.francis@wdc.com>)
 id 1kZyKF-0002RX-Cw
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 10:34:24 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:15005)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=569a91e0c=alistair.francis@wdc.com>)
 id 1kZyK7-0001Fa-Fg
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 10:34:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1604417656; x=1635953656;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=az4hi+7Qmy3zzRkU/t2y0reaYkYBTtPhn+llQuZih24=;
 b=K3c8GjPm9BGvp1BrI5Vxxyy0ZoQWevYRlUlRA4O1whWJsK8ciEyRaq0/
 zDzWFr3QvL323SoTALA2EaAGRAJ8ZEAB8NMwVqebrWSeLYxNErWlY+2qf
 HRA8WpXPJD2Vds8UcgwyucgKh6RwaXPJkPXIt0Hxb0xTP24EMIDk0E8WR
 X2xXxg2oxPdfCJLbgtd7Bf4AcWpg6c0dMGMeaKSH5LtPPBp2YSNiBtYOF
 BkJJwu+dIs+DeTBdUmsT1aM7f548siwJ4hBIZ3CgVy2hYEt3tBiurGlmp
 qjpfE7GaoVXaZ8pL14ZNBFnYu/iN7pjFpoGdd18ZHoLmGPlQbUGSEC2Hn A==;
IronPort-SDR: nT5XZpdCrLdOKN981q414wj2A/C6m8JV4st/vzS5QbCK/jbrCNcx2FwnlpPk8Hbs5bfclUKINf
 h8sF+NF8a3HLJ0Out06PyCnFbQGtfc8Xi9aO88OZOtAbCxdMPeoXwB1ElgGZcyzQTMHKa/DM59
 DOlghwHcI+Vu8RAzchoLMJhM1Lb/dHlQYnRCrx6yh8rHlKCeKxgaVQ1xR9QnZPCgHl2+veQakp
 5nhQzSapV95CJqo48x4faB3WfvTcK7KV6w09jpLRKuIs9T/F+Hvkpx3EG67p87c4QJbPgHUdrK
 DKk=
X-IronPort-AV: E=Sophos;i="5.77,448,1596470400"; d="scan'208";a="152867483"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 03 Nov 2020 23:33:28 +0800
IronPort-SDR: lq9PwhdGEF/XnKJwPFd5tMYBetEqBErZdHQCviF7seZopPiuU9I0QCX5MOtLVZbT30dobsA+sh
 DkpgOhFcWaXI58csuxJPQAlPUrSu1ingw9WnnYgb7ufqQJiMLXeeKxRKeGQpNal7eB/P2hIHj3
 lIm4b75ckI3VHWz8FE2LYMXRB/yNZB+vDahfFO43ETyrWRAHZRFgy1tAbzWp0YezJGN5H4unD7
 h7vZsDGD3V0hN0yW9MGqrpimt7i4M+2+FMeLhcsP1yoIQ0ycrIBYrLn7uyH+dC53DTYmRl0+Pw
 HL6DPgfoNdNXyh9CeqaPrK5+
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2020 07:19:36 -0800
IronPort-SDR: BhWFul50anFknOln8z3xVmSXYQfYpheF7gb0VhzdEZtK+WSB22u6ImU3VhUB0mstQ9vs3hrYn3
 P9gLLJCetY0FQyp0BBK6o9Qi5i7hM3jgxFIyJkuU92lqqXnWMTJBTVpJBCIsCrgpkOyA99eKt3
 v7EczKukGcS7WvAL9zLjPOpsZO45rXV89VmPRFTDdqfu3fiNM1N3C6yXIJ0mELw3yM2dg7b8BL
 P4TvFlXTs5VIRzvFPqtHMRRFWO0M5lePzW6YuEMfywOriGtW6GfgG3ZhSVf673m5maDSHn0KB2
 oAQ=
WDCIronportException: Internal
Received: from usa003000.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.60.113])
 by uls-op-cesaip01.wdc.com with ESMTP; 03 Nov 2020 07:33:28 -0800
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL v2 16/19] hw/riscv: microchip_pfsoc: Map the reserved memory at
 address 0
Date: Tue,  3 Nov 2020 07:21:47 -0800
Message-Id: <20201103152150.2677566-17-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201103152150.2677566-1-alistair.francis@wdc.com>
References: <20201103152150.2677566-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.45;
 envelope-from=prvs=569a91e0c=alistair.francis@wdc.com;
 helo=esa6.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 10:33:23
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
Cc: alistair23@gmail.com, Bin Meng <bin.meng@windriver.com>,
 Alistair Francis <alistair.francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bin Meng <bin.meng@windriver.com>

Somehow HSS needs to access address 0 [1] for the DDR calibration data
which is in the chipset's reserved memory. Let's map it.

[1] See the config_copy() calls in various places in ddr_setup() in
    the HSS source codes.

Signed-off-by: Bin Meng <bin.meng@windriver.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 1603863010-15807-9-git-send-email-bmeng.cn@gmail.com
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/riscv/microchip_pfsoc.h |  1 +
 hw/riscv/microchip_pfsoc.c         | 11 ++++++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/include/hw/riscv/microchip_pfsoc.h b/include/hw/riscv/microchip_pfsoc.h
index 245c82db61..f34a6b3fd7 100644
--- a/include/hw/riscv/microchip_pfsoc.h
+++ b/include/hw/riscv/microchip_pfsoc.h
@@ -74,6 +74,7 @@ typedef struct MicrochipIcicleKitState {
                  TYPE_MICROCHIP_ICICLE_KIT_MACHINE)
 
 enum {
+    MICROCHIP_PFSOC_RSVD0,
     MICROCHIP_PFSOC_DEBUG,
     MICROCHIP_PFSOC_E51_DTIM,
     MICROCHIP_PFSOC_BUSERR_UNIT0,
diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
index bc908e07d9..44a84732ac 100644
--- a/hw/riscv/microchip_pfsoc.c
+++ b/hw/riscv/microchip_pfsoc.c
@@ -90,7 +90,8 @@ static const struct MemmapEntry {
     hwaddr base;
     hwaddr size;
 } microchip_pfsoc_memmap[] = {
-    [MICROCHIP_PFSOC_DEBUG] =           {        0x0,     0x1000 },
+    [MICROCHIP_PFSOC_RSVD0] =           {        0x0,      0x100 },
+    [MICROCHIP_PFSOC_DEBUG] =           {      0x100,      0xf00 },
     [MICROCHIP_PFSOC_E51_DTIM] =        {  0x1000000,     0x2000 },
     [MICROCHIP_PFSOC_BUSERR_UNIT0] =    {  0x1700000,     0x1000 },
     [MICROCHIP_PFSOC_BUSERR_UNIT1] =    {  0x1701000,     0x1000 },
@@ -176,6 +177,7 @@ static void microchip_pfsoc_soc_realize(DeviceState *dev, Error **errp)
     MicrochipPFSoCState *s = MICROCHIP_PFSOC(dev);
     const struct MemmapEntry *memmap = microchip_pfsoc_memmap;
     MemoryRegion *system_memory = get_system_memory();
+    MemoryRegion *rsvd0_mem = g_new(MemoryRegion, 1);
     MemoryRegion *e51_dtim_mem = g_new(MemoryRegion, 1);
     MemoryRegion *l2lim_mem = g_new(MemoryRegion, 1);
     MemoryRegion *envm_data = g_new(MemoryRegion, 1);
@@ -195,6 +197,13 @@ static void microchip_pfsoc_soc_realize(DeviceState *dev, Error **errp)
     qdev_realize(DEVICE(&s->e_cluster), NULL, &error_abort);
     qdev_realize(DEVICE(&s->u_cluster), NULL, &error_abort);
 
+    /* Reserved Memory at address 0 */
+    memory_region_init_ram(rsvd0_mem, NULL, "microchip.pfsoc.rsvd0_mem",
+                           memmap[MICROCHIP_PFSOC_RSVD0].size, &error_fatal);
+    memory_region_add_subregion(system_memory,
+                                memmap[MICROCHIP_PFSOC_RSVD0].base,
+                                rsvd0_mem);
+
     /* E51 DTIM */
     memory_region_init_ram(e51_dtim_mem, NULL, "microchip.pfsoc.e51_dtim_mem",
                            memmap[MICROCHIP_PFSOC_E51_DTIM].size, &error_fatal);
-- 
2.28.0



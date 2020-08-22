Return-Path: <SRS0=Iy1T=CA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E9FDC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2020 05:57:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 683BA2072D
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2020 05:57:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="izWHQXld"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 683BA2072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9MWV-0003kH-I3
	for qemu-devel@archiver.kernel.org; Sat, 22 Aug 2020 01:57:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33918)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=49637c5a7=alistair.francis@wdc.com>)
 id 1k9MR2-0001kr-6Z
 for qemu-devel@nongnu.org; Sat, 22 Aug 2020 01:51:24 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:26625)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=49637c5a7=alistair.francis@wdc.com>)
 id 1k9MQz-0000Cq-FQ
 for qemu-devel@nongnu.org; Sat, 22 Aug 2020 01:51:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1598075481; x=1629611481;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=MzRodNA+DMByRA1q2GX4wajdANGMVETakge3ogGzXA4=;
 b=izWHQXldaZd5UqSUVIdSx/bCjeRK66mzqFnYEDoFLFcxzU/GnoUAXlm3
 M1v56EVK4z/QzxIITQ/5yTp8NHjHKa92vEdzck6FAtIpiYY1AlEOdNUpl
 evRAHrIp51bSWAv2Vp2uCPqT37dW+UXtZypAABlu+1tDkQncoo4YU0+fW
 N1RlMemSbTasFutHmWjGTv3xY01pweKVRaio/tZM7JX4EkrmCJy9Kqkcj
 9uDrsBQPEyvyZPtLP7Ez0AtbHDIFnYw8IDYfb+F7Z4fOdIQ2N3bFliStk
 u5to5Exv7XNuZvmzJfwPEXL7ToHSDNKRZE3533rPxOdHgwYmRPjbRcdev g==;
IronPort-SDR: Vb8HDPua+gOcucrmMcUIFGAGGRmCXvruRrtuVDaPdi8fXUbk+fLjRH2MO1E5mmGN2Viehmj3V6
 u1x1QJrZ4/cxsHaqiVRmFUajoI+QmXqmaR1UdFK2KBwgx2Mg9b9DD4/v+Sj9ihhd61tzZT8zzt
 ZVNjmDJzQOMr2jRtzVmFYr+IX3N0dabB8J0yfr1UNghcyplrEPXdRXPG9vAnUhi3tTWQxudnE3
 pdZIdim+psSpO+ibLkmMsoug4Ni074nFC6Op0llUBSbLbDfprrte8Nx2SVrzOan7okGESmbenW
 gdg=
X-IronPort-AV: E=Sophos;i="5.76,339,1592841600"; d="scan'208";a="145571955"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 22 Aug 2020 13:51:18 +0800
IronPort-SDR: DBTeFb5aZ1dZ10sGhMxokZHHYyf1yLKYaSMmTFFLU+psm7zF6NNImXkypzwVcC9HbxzFI6WXkT
 buc7cHqRTP6A==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Aug 2020 22:38:57 -0700
IronPort-SDR: QmOrKuM3Yh5wWuatjGpxS+jgjo+gbY/OdfUw+MtU88yTm421Gr1G7CceG8m4L7+QQVpLz8yxYk
 c1n3WtbWf7cg==
WDCIronportException: Internal
Received: from 5zn13g2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.59.90])
 by uls-op-cesaip02.wdc.com with ESMTP; 21 Aug 2020 22:51:18 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Subject: [PULL v3 08/20] hw/riscv: sifive_u: Add a dummy L2 cache controller
 device
Date: Fri, 21 Aug 2020 22:40:49 -0700
Message-Id: <20200822054101.1202175-9-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200822054101.1202175-1-alistair.francis@wdc.com>
References: <20200822054101.1202175-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.144;
 envelope-from=prvs=49637c5a7=alistair.francis@wdc.com;
 helo=esa5.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/22 01:43:18
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
Cc: alistair23@gmail.com, Bin Meng <bin.meng@windriver.com>,
 alistair.francis@wdc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bin Meng <bin.meng@windriver.com>

It is enough to simply map the SiFive FU540 L2 cache controller
into the MMIO space using create_unimplemented_device(), with an
FDT fragment generated, to make the latest upstream U-Boot happy.

Signed-off-by: Bin Meng <bin.meng@windriver.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <1595227748-24720-1-git-send-email-bmeng.cn@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/riscv/sifive_u.h |  4 ++++
 hw/riscv/sifive_u.c         | 22 ++++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/include/hw/riscv/sifive_u.h b/include/hw/riscv/sifive_u.h
index aba4d0181f..d3c0c00d10 100644
--- a/include/hw/riscv/sifive_u.h
+++ b/include/hw/riscv/sifive_u.h
@@ -71,6 +71,7 @@ enum {
     SIFIVE_U_DEBUG,
     SIFIVE_U_MROM,
     SIFIVE_U_CLINT,
+    SIFIVE_U_L2CC,
     SIFIVE_U_L2LIM,
     SIFIVE_U_PLIC,
     SIFIVE_U_PRCI,
@@ -86,6 +87,9 @@ enum {
 };
 
 enum {
+    SIFIVE_U_L2CC_IRQ0 = 1,
+    SIFIVE_U_L2CC_IRQ1 = 2,
+    SIFIVE_U_L2CC_IRQ2 = 3,
     SIFIVE_U_UART0_IRQ = 4,
     SIFIVE_U_UART1_IRQ = 5,
     SIFIVE_U_GPIO_IRQ0 = 7,
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index e5682c38a9..55b3383c31 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -72,6 +72,7 @@ static const struct MemmapEntry {
     [SIFIVE_U_DEBUG] =    {        0x0,      0x100 },
     [SIFIVE_U_MROM] =     {     0x1000,     0xf000 },
     [SIFIVE_U_CLINT] =    {  0x2000000,    0x10000 },
+    [SIFIVE_U_L2CC] =     {  0x2010000,     0x1000 },
     [SIFIVE_U_L2LIM] =    {  0x8000000,  0x2000000 },
     [SIFIVE_U_PLIC] =     {  0xc000000,  0x4000000 },
     [SIFIVE_U_PRCI] =     { 0x10000000,     0x1000 },
@@ -302,6 +303,24 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
     qemu_fdt_setprop_string(fdt, nodename, "compatible", "gpio-restart");
     g_free(nodename);
 
+    nodename = g_strdup_printf("/soc/cache-controller@%lx",
+        (long)memmap[SIFIVE_U_L2CC].base);
+    qemu_fdt_add_subnode(fdt, nodename);
+    qemu_fdt_setprop_cells(fdt, nodename, "reg",
+        0x0, memmap[SIFIVE_U_L2CC].base,
+        0x0, memmap[SIFIVE_U_L2CC].size);
+    qemu_fdt_setprop_cells(fdt, nodename, "interrupts",
+        SIFIVE_U_L2CC_IRQ0, SIFIVE_U_L2CC_IRQ1, SIFIVE_U_L2CC_IRQ2);
+    qemu_fdt_setprop_cell(fdt, nodename, "interrupt-parent", plic_phandle);
+    qemu_fdt_setprop(fdt, nodename, "cache-unified", NULL, 0);
+    qemu_fdt_setprop_cell(fdt, nodename, "cache-size", 2097152);
+    qemu_fdt_setprop_cell(fdt, nodename, "cache-sets", 1024);
+    qemu_fdt_setprop_cell(fdt, nodename, "cache-level", 2);
+    qemu_fdt_setprop_cell(fdt, nodename, "cache-block-size", 64);
+    qemu_fdt_setprop_string(fdt, nodename, "compatible",
+                            "sifive,fu540-c000-ccache");
+    g_free(nodename);
+
     phy_phandle = phandle++;
     nodename = g_strdup_printf("/soc/ethernet@%lx",
         (long)memmap[SIFIVE_U_GEM].base);
@@ -733,6 +752,9 @@ static void sifive_u_soc_realize(DeviceState *dev, Error **errp)
 
     create_unimplemented_device("riscv.sifive.u.dmc",
         memmap[SIFIVE_U_DMC].base, memmap[SIFIVE_U_DMC].size);
+
+    create_unimplemented_device("riscv.sifive.u.l2cc",
+        memmap[SIFIVE_U_L2CC].base, memmap[SIFIVE_U_L2CC].size);
 }
 
 static Property sifive_u_soc_props[] = {
-- 
2.28.0



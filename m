Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95D51C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 18:28:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12CEC207EA
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 18:28:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qAOOvpSI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12CEC207EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGRJ7-00087a-15
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 14:28:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57414)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=515d47f05=alistair.francis@wdc.com>)
 id 1kGRBr-0004gA-BZ
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 14:20:59 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:28256)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=515d47f05=alistair.francis@wdc.com>)
 id 1kGRBo-0002lX-Kq
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 14:20:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1599762056; x=1631298056;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=cXsVA5p/DqXijeQyHksD3R4PvZRbw0q4xEv/ESLL9bo=;
 b=qAOOvpSIxbARSwNf/m0veqytldE4giGTwEhJUdhHvfRXlzcGz1PkGlDA
 n04UT3/BIo0UzsKr2ENjQfi1MKQkguwKn+olFFoPeijhZSPvqncNFc+SH
 SARXs2UYfNYeOHh9aERj281SOR6eW9nntChMjfJWUfHV2TaXkIZJdjSWe
 J6KLAPp0BbuY8nd7rkyh0V2VWVfuPAs67Iv0jCRwv0fbAmiCciAZeyCTY
 LWcboPlDD20fPrhLmrTDgBgXLvHu/eIfTNEKIuK/nvs6qZeGx79pIRVG5
 2io3E3o1rG9NyE+cqBdsQSQQ4aQt3LW3AjHy4KgBWrXRUKcXgLIL3+NWY A==;
IronPort-SDR: D/T33LI68NV12au+pTtN4flNP5KqLXqMAZqQOZ7CrRttNsDO5PjRlhqtjHr8Y8kXwXB+YktQz5
 m94lG/0FhE5TGg3zc7MhitWacgYBjBDaC9K96HA1cnDBe/lwkLxJ10z+8AHdAbREp3bwPPb2Dx
 s+UGxJDi5GANOg6YqwY6IyN+JTe4qe3thhE5eroTMqt0XEU7DUKJqzxpcsDV/ROU/jMQCt8sTw
 ZB2hK1EXBx2SAxdVboXO5KPgcKDShk8IuzHTzfNaWTsIRdGDIyzeDIHH77bYZozSQlf/qI8nW0
 3w8=
X-IronPort-AV: E=Sophos;i="5.76,413,1592841600"; d="scan'208";a="146979240"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 11 Sep 2020 02:20:19 +0800
IronPort-SDR: avBAkphvHll9ghgUTclsszC62FpubjUnrSJDP/1GWNT+JnUO6Sh5TcTR3oIE6E1rf1ijGbIBTX
 vMbCFGaoGckg==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2020 11:07:36 -0700
IronPort-SDR: AvdKnmS5bTxuWgWV00DFpfywA3tjqP8Fp1SNCp01LRoQ2UMn5j8GtU+JD+REJU8KBpAR3q5x4c
 IctQGH/6GshQ==
WDCIronportException: Internal
Received: from fwvkpc2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.59.152])
 by uls-op-cesaip01.wdc.com with ESMTP; 10 Sep 2020 11:20:19 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 18/30] hw/riscv: sifive_u: Connect a DMA controller
Date: Thu, 10 Sep 2020 11:09:26 -0700
Message-Id: <20200910180938.584205-19-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200910180938.584205-1-alistair.francis@wdc.com>
References: <20200910180938.584205-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=515d47f05=alistair.francis@wdc.com;
 helo=esa4.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 14:20:04
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

SiFive FU540 SoC integrates a platform DMA controller with 4 DMA
channels. This connects the exsiting SiFive PDMA model to the SoC,
and adds its device tree data as well.

Signed-off-by: Bin Meng <bin.meng@windriver.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <1598924352-89526-17-git-send-email-bmeng.cn@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/riscv/sifive_u.h | 11 +++++++++++
 hw/riscv/sifive_u.c         | 30 ++++++++++++++++++++++++++++++
 hw/riscv/Kconfig            |  1 +
 3 files changed, 42 insertions(+)

diff --git a/include/hw/riscv/sifive_u.h b/include/hw/riscv/sifive_u.h
index d3c0c00d10..793000a2ed 100644
--- a/include/hw/riscv/sifive_u.h
+++ b/include/hw/riscv/sifive_u.h
@@ -19,6 +19,7 @@
 #ifndef HW_SIFIVE_U_H
 #define HW_SIFIVE_U_H
 
+#include "hw/dma/sifive_pdma.h"
 #include "hw/net/cadence_gem.h"
 #include "hw/riscv/riscv_hart.h"
 #include "hw/riscv/sifive_cpu.h"
@@ -43,6 +44,7 @@ typedef struct SiFiveUSoCState {
     SiFiveUPRCIState prci;
     SIFIVEGPIOState gpio;
     SiFiveUOTPState otp;
+    SiFivePDMAState dma;
     CadenceGEMState gem;
 
     uint32_t serial;
@@ -72,6 +74,7 @@ enum {
     SIFIVE_U_MROM,
     SIFIVE_U_CLINT,
     SIFIVE_U_L2CC,
+    SIFIVE_U_PDMA,
     SIFIVE_U_L2LIM,
     SIFIVE_U_PLIC,
     SIFIVE_U_PRCI,
@@ -108,6 +111,14 @@ enum {
     SIFIVE_U_GPIO_IRQ13 = 20,
     SIFIVE_U_GPIO_IRQ14 = 21,
     SIFIVE_U_GPIO_IRQ15 = 22,
+    SIFIVE_U_PDMA_IRQ0 = 23,
+    SIFIVE_U_PDMA_IRQ1 = 24,
+    SIFIVE_U_PDMA_IRQ2 = 25,
+    SIFIVE_U_PDMA_IRQ3 = 26,
+    SIFIVE_U_PDMA_IRQ4 = 27,
+    SIFIVE_U_PDMA_IRQ5 = 28,
+    SIFIVE_U_PDMA_IRQ6 = 29,
+    SIFIVE_U_PDMA_IRQ7 = 30,
     SIFIVE_U_GEM_IRQ = 0x35
 };
 
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 2bc3992989..79975372ef 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -14,6 +14,7 @@
  * 4) GPIO (General Purpose Input/Output Controller)
  * 5) OTP (One-Time Programmable) memory with stored serial number
  * 6) GEM (Gigabit Ethernet Controller) and management block
+ * 7) DMA (Direct Memory Access Controller)
  *
  * This board currently generates devicetree dynamically that indicates at least
  * two harts and up to five harts.
@@ -73,6 +74,7 @@ static const struct MemmapEntry {
     [SIFIVE_U_MROM] =     {     0x1000,     0xf000 },
     [SIFIVE_U_CLINT] =    {  0x2000000,    0x10000 },
     [SIFIVE_U_L2CC] =     {  0x2010000,     0x1000 },
+    [SIFIVE_U_PDMA] =     {  0x3000000,   0x100000 },
     [SIFIVE_U_L2LIM] =    {  0x8000000,  0x2000000 },
     [SIFIVE_U_PLIC] =     {  0xc000000,  0x4000000 },
     [SIFIVE_U_PRCI] =     { 0x10000000,     0x1000 },
@@ -303,6 +305,22 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
     qemu_fdt_setprop_string(fdt, nodename, "compatible", "gpio-restart");
     g_free(nodename);
 
+    nodename = g_strdup_printf("/soc/dma@%lx",
+        (long)memmap[SIFIVE_U_PDMA].base);
+    qemu_fdt_add_subnode(fdt, nodename);
+    qemu_fdt_setprop_cell(fdt, nodename, "#dma-cells", 1);
+    qemu_fdt_setprop_cells(fdt, nodename, "interrupts",
+        SIFIVE_U_PDMA_IRQ0, SIFIVE_U_PDMA_IRQ1, SIFIVE_U_PDMA_IRQ2,
+        SIFIVE_U_PDMA_IRQ3, SIFIVE_U_PDMA_IRQ4, SIFIVE_U_PDMA_IRQ5,
+        SIFIVE_U_PDMA_IRQ6, SIFIVE_U_PDMA_IRQ7);
+    qemu_fdt_setprop_cell(fdt, nodename, "interrupt-parent", plic_phandle);
+    qemu_fdt_setprop_cells(fdt, nodename, "reg",
+        0x0, memmap[SIFIVE_U_PDMA].base,
+        0x0, memmap[SIFIVE_U_PDMA].size);
+    qemu_fdt_setprop_string(fdt, nodename, "compatible",
+                            "sifive,fu540-c000-pdma");
+    g_free(nodename);
+
     nodename = g_strdup_printf("/soc/cache-controller@%lx",
         (long)memmap[SIFIVE_U_L2CC].base);
     qemu_fdt_add_subnode(fdt, nodename);
@@ -627,6 +645,7 @@ static void sifive_u_soc_instance_init(Object *obj)
     object_initialize_child(obj, "otp", &s->otp, TYPE_SIFIVE_U_OTP);
     object_initialize_child(obj, "gem", &s->gem, TYPE_CADENCE_GEM);
     object_initialize_child(obj, "gpio", &s->gpio, TYPE_SIFIVE_GPIO);
+    object_initialize_child(obj, "pdma", &s->dma, TYPE_SIFIVE_PDMA);
 }
 
 static void sifive_u_soc_realize(DeviceState *dev, Error **errp)
@@ -730,6 +749,17 @@ static void sifive_u_soc_realize(DeviceState *dev, Error **errp)
                                             SIFIVE_U_GPIO_IRQ0 + i));
     }
 
+    /* PDMA */
+    sysbus_realize(SYS_BUS_DEVICE(&s->dma), errp);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->dma), 0, memmap[SIFIVE_U_PDMA].base);
+
+    /* Connect PDMA interrupts to the PLIC */
+    for (i = 0; i < SIFIVE_PDMA_IRQS; i++) {
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->dma), i,
+                           qdev_get_gpio_in(DEVICE(s->plic),
+                                            SIFIVE_U_PDMA_IRQ0 + i));
+    }
+
     qdev_prop_set_uint32(DEVICE(&s->otp), "serial", s->serial);
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->otp), errp)) {
         return;
diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index 9032cb0cbd..e53ab1efa5 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -22,6 +22,7 @@ config SIFIVE_U
     select CADENCE
     select HART
     select SIFIVE
+    select SIFIVE_PDMA
     select UNIMP
 
 config SPIKE
-- 
2.28.0



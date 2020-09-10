Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 464F1C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 18:26:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABB86207EA
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 18:26:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="p6WFheIA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABB86207EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGRHL-00047T-8J
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 14:26:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57120)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=515d47f05=alistair.francis@wdc.com>)
 id 1kGRBO-0003pS-7S
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 14:20:30 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:28256)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=515d47f05=alistair.francis@wdc.com>)
 id 1kGRBL-0002lX-A7
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 14:20:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1599762027; x=1631298027;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=NhJJ78B4/ygnmHBj6fEzSk4fVveI7qnKUtEsfsPEHS8=;
 b=p6WFheIAnwjfEXK/Ag6wUam69NRLnqisxZ/ukNvMXgr/raXYkbS7cQVR
 QUFExg/u82dcfAgyBKUVQ7lN/IfLs0Orv3gs6m+mxFFWuExc8e2v/9PCO
 ioWwrblHXLeWcWQ3tHbpVtQphYhO84Bj6iVFf7dFlyVz5slwglPz0JU4s
 FN5GMQceeQi5hIcNR6lT9PPOSbJUf5lpFrvuq/c9UfWFTsbJ9GxavoIOT
 slJEr3ZTtlfteMlQ8k9Q0GuEUq4s+n+ebWGqfM0cg6ta/b80JUTmna09G
 wuSIz2dPX7lUOVwiqfejZavrdomx4V3BC94UvBxhctUQ/pqCZOxDyegao Q==;
IronPort-SDR: NYNq8GhV+8+Y8XvpA/eZDYzfrAVX4sA/qjO7NMTUkLs7ZpnPgyNlLm5/gvybbmyspfNkPIQO0F
 FG4gfFj25wRZI9Tc8jJVQGm/URVb8jbs0TldeWD2zSSIswsb+EO9kwEnzk1MMvLLUCo07wqTF3
 XVlLLtVyxrxCnPngdVC0XhoR833iFQdYc63+lghA3u6xpF9PkTjYp2tGAOsUXoo8eXi/tlBUXj
 /RIpxjB94Ff2iIMFnPvXeXyDnoNhi03d6iSmrLAvXwh9cJPAGeY30xQ0etU03oMCaXY6gXCOpL
 5S8=
X-IronPort-AV: E=Sophos;i="5.76,413,1592841600"; d="scan'208";a="146979221"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 11 Sep 2020 02:20:16 +0800
IronPort-SDR: zCUtC8d4wdWvJkGJSZfy4088J7qYz1kwhWE0bhHfNyozyyPjyI2EhVSv3FiJV8b83wnrMh/PQV
 us182OZVL/xQ==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2020 11:07:33 -0700
IronPort-SDR: iBB3boRE4yMums/htvM1CWVIGXhXz5lwRJUbiv0g42Rmo971XWpHemwvP/QrSQ+pzRtmevmByP
 YaCyb+XEpi1w==
WDCIronportException: Internal
Received: from fwvkpc2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.59.152])
 by uls-op-cesaip01.wdc.com with ESMTP; 10 Sep 2020 11:20:16 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 08/30] hw/riscv: microchip_pfsoc: Connect 5 MMUARTs
Date: Thu, 10 Sep 2020 11:09:16 -0700
Message-Id: <20200910180938.584205-9-alistair.francis@wdc.com>
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

Microchip PolarFire SoC has 5 MMUARTs, and the Icicle Kit board
wires 4 of them out. Let's connect all 5 MMUARTs.

Signed-off-by: Bin Meng <bin.meng@windriver.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <1598924352-89526-7-git-send-email-bmeng.cn@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/riscv/microchip_pfsoc.h | 20 ++++++++++++++++++++
 hw/riscv/microchip_pfsoc.c         | 30 ++++++++++++++++++++++++++++++
 hw/riscv/Kconfig                   |  1 +
 3 files changed, 51 insertions(+)

diff --git a/include/hw/riscv/microchip_pfsoc.h b/include/hw/riscv/microchip_pfsoc.h
index 1953ef1464..a5efa1dcb8 100644
--- a/include/hw/riscv/microchip_pfsoc.h
+++ b/include/hw/riscv/microchip_pfsoc.h
@@ -22,6 +22,8 @@
 #ifndef HW_MICROCHIP_PFSOC_H
 #define HW_MICROCHIP_PFSOC_H
 
+#include "hw/char/mchp_pfsoc_mmuart.h"
+
 typedef struct MicrochipPFSoCState {
     /*< private >*/
     DeviceState parent_obj;
@@ -32,6 +34,11 @@ typedef struct MicrochipPFSoCState {
     RISCVHartArrayState e_cpus;
     RISCVHartArrayState u_cpus;
     DeviceState *plic;
+    MchpPfSoCMMUartState *serial0;
+    MchpPfSoCMMUartState *serial1;
+    MchpPfSoCMMUartState *serial2;
+    MchpPfSoCMMUartState *serial3;
+    MchpPfSoCMMUartState *serial4;
 } MicrochipPFSoCState;
 
 #define TYPE_MICROCHIP_PFSOC    "microchip.pfsoc"
@@ -64,14 +71,27 @@ enum {
     MICROCHIP_PFSOC_L2CC,
     MICROCHIP_PFSOC_L2LIM,
     MICROCHIP_PFSOC_PLIC,
+    MICROCHIP_PFSOC_MMUART0,
     MICROCHIP_PFSOC_SYSREG,
     MICROCHIP_PFSOC_MPUCFG,
+    MICROCHIP_PFSOC_MMUART1,
+    MICROCHIP_PFSOC_MMUART2,
+    MICROCHIP_PFSOC_MMUART3,
+    MICROCHIP_PFSOC_MMUART4,
     MICROCHIP_PFSOC_ENVM_CFG,
     MICROCHIP_PFSOC_ENVM_DATA,
     MICROCHIP_PFSOC_IOSCB_CFG,
     MICROCHIP_PFSOC_DRAM,
 };
 
+enum {
+    MICROCHIP_PFSOC_MMUART0_IRQ = 90,
+    MICROCHIP_PFSOC_MMUART1_IRQ = 91,
+    MICROCHIP_PFSOC_MMUART2_IRQ = 92,
+    MICROCHIP_PFSOC_MMUART3_IRQ = 93,
+    MICROCHIP_PFSOC_MMUART4_IRQ = 94,
+};
+
 #define MICROCHIP_PFSOC_MANAGEMENT_CPU_COUNT    1
 #define MICROCHIP_PFSOC_COMPUTE_CPU_COUNT       4
 
diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
index d946b2aae5..cee959a5e0 100644
--- a/hw/riscv/microchip_pfsoc.c
+++ b/hw/riscv/microchip_pfsoc.c
@@ -11,6 +11,7 @@
  * 0) CLINT (Core Level Interruptor)
  * 1) PLIC (Platform Level Interrupt Controller)
  * 2) eNVM (Embedded Non-Volatile Memory)
+ * 3) MMUARTs (Multi-Mode UART)
  *
  * This board currently generates devicetree dynamically that indicates at least
  * two harts and up to five harts.
@@ -38,6 +39,7 @@
 #include "hw/irq.h"
 #include "hw/loader.h"
 #include "hw/sysbus.h"
+#include "chardev/char.h"
 #include "hw/cpu/cluster.h"
 #include "target/riscv/cpu.h"
 #include "hw/misc/unimp.h"
@@ -46,6 +48,7 @@
 #include "hw/riscv/sifive_clint.h"
 #include "hw/riscv/sifive_plic.h"
 #include "hw/riscv/microchip_pfsoc.h"
+#include "sysemu/sysemu.h"
 
 /*
  * The BIOS image used by this machine is called Hart Software Services (HSS).
@@ -69,8 +72,13 @@ static const struct MemmapEntry {
     [MICROCHIP_PFSOC_L2CC] =            {  0x2010000,     0x1000 },
     [MICROCHIP_PFSOC_L2LIM] =           {  0x8000000,  0x2000000 },
     [MICROCHIP_PFSOC_PLIC] =            {  0xc000000,  0x4000000 },
+    [MICROCHIP_PFSOC_MMUART0] =         { 0x20000000,     0x1000 },
     [MICROCHIP_PFSOC_SYSREG] =          { 0x20002000,     0x2000 },
     [MICROCHIP_PFSOC_MPUCFG] =          { 0x20005000,     0x1000 },
+    [MICROCHIP_PFSOC_MMUART1] =         { 0x20100000,     0x1000 },
+    [MICROCHIP_PFSOC_MMUART2] =         { 0x20102000,     0x1000 },
+    [MICROCHIP_PFSOC_MMUART3] =         { 0x20104000,     0x1000 },
+    [MICROCHIP_PFSOC_MMUART4] =         { 0x20106000,     0x1000 },
     [MICROCHIP_PFSOC_ENVM_CFG] =        { 0x20200000,     0x1000 },
     [MICROCHIP_PFSOC_ENVM_DATA] =       { 0x20220000,    0x20000 },
     [MICROCHIP_PFSOC_IOSCB_CFG] =       { 0x37080000,     0x1000 },
@@ -215,6 +223,28 @@ static void microchip_pfsoc_soc_realize(DeviceState *dev, Error **errp)
         memmap[MICROCHIP_PFSOC_MPUCFG].base,
         memmap[MICROCHIP_PFSOC_MPUCFG].size);
 
+    /* MMUARTs */
+    s->serial0 = mchp_pfsoc_mmuart_create(system_memory,
+        memmap[MICROCHIP_PFSOC_MMUART0].base,
+        qdev_get_gpio_in(DEVICE(s->plic), MICROCHIP_PFSOC_MMUART0_IRQ),
+        serial_hd(0));
+    s->serial1 = mchp_pfsoc_mmuart_create(system_memory,
+        memmap[MICROCHIP_PFSOC_MMUART1].base,
+        qdev_get_gpio_in(DEVICE(s->plic), MICROCHIP_PFSOC_MMUART1_IRQ),
+        serial_hd(1));
+    s->serial2 = mchp_pfsoc_mmuart_create(system_memory,
+        memmap[MICROCHIP_PFSOC_MMUART2].base,
+        qdev_get_gpio_in(DEVICE(s->plic), MICROCHIP_PFSOC_MMUART2_IRQ),
+        serial_hd(2));
+    s->serial3 = mchp_pfsoc_mmuart_create(system_memory,
+        memmap[MICROCHIP_PFSOC_MMUART3].base,
+        qdev_get_gpio_in(DEVICE(s->plic), MICROCHIP_PFSOC_MMUART3_IRQ),
+        serial_hd(3));
+    s->serial4 = mchp_pfsoc_mmuart_create(system_memory,
+        memmap[MICROCHIP_PFSOC_MMUART4].base,
+        qdev_get_gpio_in(DEVICE(s->plic), MICROCHIP_PFSOC_MMUART4_IRQ),
+        serial_hd(4));
+
     /* eNVM */
     memory_region_init_rom(envm_data, OBJECT(dev), "microchip.pfsoc.envm.data",
                            memmap[MICROCHIP_PFSOC_ENVM_DATA].size,
diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index 3292faef27..ceb7c166a3 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -54,3 +54,4 @@ config MICROCHIP_PFSOC
     select HART
     select SIFIVE
     select UNIMP
+    select MCHP_PFSOC_MMUART
-- 
2.28.0



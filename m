Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A721C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 06:48:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59BB520707
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 06:48:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="PUXK6nVr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59BB520707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmAp2-0003Ji-EA
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 02:48:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57006)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4324eb4de=alistair.francis@wdc.com>)
 id 1jmAc8-00067B-SA
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 02:35:00 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:13005)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4324eb4de=alistair.francis@wdc.com>)
 id 1jmAc6-00028f-U5
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 02:35:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1592548499; x=1624084499;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=/VFbNCBNHJmJE++nCPIO8b5lhNMmW1HmNeApASFycK4=;
 b=PUXK6nVr5ZXDU00QdXQ0Mf19lvtvN5d8lrv1PBljrcm0ybzh674dTp75
 TZB0aN7DPqguyJOk+2jxy0JVJBijmlbmPTOb2/7lGklURlaIt5Khaijzp
 pnjYCT1qH7BG7z6TNMr5/EMtE1EbTTsHLR919UFqWcZn7P7AEl1CZwiKG
 N1fT+TvThoj5MJWQxtr3groI6jEr+ieBM0cNgVy1PlpCxarMrLnmGo5sE
 veU+2xvNIS98bCdZfi8zP1HS9ob5X/1Y6zhHFx2OtTHVsfo0ps4Q4eLkm
 QfUxkYzVcZ1aaWw5ESZlydjONH6NcakZLWACTV+fXrwAs4eLOBMzoqUaR A==;
IronPort-SDR: IciwrAbBBbbPmGaT6H4mjpzoMM2+lcuYlsTWlfOJoJxigQXvzAfQRDAGKj5nGCC+AMMXNXd0xq
 +0X2l6Cp51z1VFEI2/Jl6Pgp1ArGpFajijtVWNEnNJSFa5fqCwBxZBchmjU0nA3DPTGJhSjU3g
 4Z7szKYZmV7hDGBwCV+L6dt4H2UjBnLjboDCmgDP+/dWi96SBwz9+QqrqBqrml1KKlNOAVZ10f
 hCJcIwShHIc9f8SiPxCYaNkd+bmQXXVk1ECBD2ivAzqWDNkMD3q+8Ff1KfvD8O2j8JnvOwIp6P
 Z0k=
X-IronPort-AV: E=Sophos;i="5.75,253,1589212800"; d="scan'208";a="141781942"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 19 Jun 2020 14:34:32 +0800
IronPort-SDR: wvfWnnBeQp7KDvRwCG6PWLK6ZsAqfTikXWQRCoA3Wq69GwtdPIk6yJXah/9PTKVQxZGoe5vPOp
 5pswTEVj++j1rKNR3HePps6Hes/obx6qU=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jun 2020 23:23:43 -0700
IronPort-SDR: 7O2+4ep1smA0zosWCThqAbAIKyn0cBKqYiNks5rYBYFm/B29J9S1MUYAikMFUddiUgyn7akjEa
 DBXfuW8XjOFQ==
WDCIronportException: Internal
Received: from unknown (HELO risc6-mainframe.hgst.com) ([10.86.58.142])
 by uls-op-cesaip02.wdc.com with ESMTP; 18 Jun 2020 23:34:31 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 25/32] hw/riscv: sifive_u: Add reset functionality
Date: Thu, 18 Jun 2020 23:25:11 -0700
Message-Id: <20200619062518.1718523-26-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619062518.1718523-1-alistair.francis@wdc.com>
References: <20200619062518.1718523-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.45;
 envelope-from=prvs=4324eb4de=alistair.francis@wdc.com;
 helo=esa6.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 02:34:29
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

The HiFive Unleashed board wires GPIO pin#10 to the input of the
system reset signal. Let's set up the GPIO pin#10 and insert a
"gpio-restart" device tree node so that reboot is now functional
with QEMU 'sifive_u' machine.

Signed-off-by: Bin Meng <bin.meng@windriver.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 1591625864-31494-10-git-send-email-bmeng.cn@gmail.com
Message-Id: <1591625864-31494-10-git-send-email-bmeng.cn@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/sifive_u.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index c9ef59c482..a0fcef63b1 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -37,6 +37,7 @@
 #include "qapi/error.h"
 #include "qapi/visitor.h"
 #include "hw/boards.h"
+#include "hw/irq.h"
 #include "hw/loader.h"
 #include "hw/sysbus.h"
 #include "hw/char/serial.h"
@@ -53,6 +54,7 @@
 #include "net/eth.h"
 #include "sysemu/arch_init.h"
 #include "sysemu/device_tree.h"
+#include "sysemu/runstate.h"
 #include "sysemu/sysemu.h"
 #include "exec/address-spaces.h"
 
@@ -96,7 +98,7 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
     uint32_t *cells;
     char *nodename;
     char ethclk_names[] = "pclk\0hclk";
-    uint32_t plic_phandle, prci_phandle, phandle = 1;
+    uint32_t plic_phandle, prci_phandle, gpio_phandle, phandle = 1;
     uint32_t hfclk_phandle, rtcclk_phandle, phy_phandle;
 
     fdt = s->fdt = create_device_tree(&s->fdt_size);
@@ -270,9 +272,11 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
     g_free(cells);
     g_free(nodename);
 
+    gpio_phandle = phandle++;
     nodename = g_strdup_printf("/soc/gpio@%lx",
         (long)memmap[SIFIVE_U_GPIO].base);
     qemu_fdt_add_subnode(fdt, nodename);
+    qemu_fdt_setprop_cell(fdt, nodename, "phandle", gpio_phandle);
     qemu_fdt_setprop_cells(fdt, nodename, "clocks",
         prci_phandle, PRCI_CLK_TLCLK);
     qemu_fdt_setprop_cell(fdt, nodename, "#interrupt-cells", 2);
@@ -292,6 +296,12 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
     qemu_fdt_setprop_string(fdt, nodename, "compatible", "sifive,gpio0");
     g_free(nodename);
 
+    nodename = g_strdup_printf("/gpio-restart");
+    qemu_fdt_add_subnode(fdt, nodename);
+    qemu_fdt_setprop_cells(fdt, nodename, "gpios", gpio_phandle, 10, 1);
+    qemu_fdt_setprop_string(fdt, nodename, "compatible", "gpio-restart");
+    g_free(nodename);
+
     phy_phandle = phandle++;
     nodename = g_strdup_printf("/soc/ethernet@%lx",
         (long)memmap[SIFIVE_U_GEM].base);
@@ -352,6 +362,14 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
     g_free(nodename);
 }
 
+static void sifive_u_machine_reset(void *opaque, int n, int level)
+{
+    /* gpio pin active low triggers reset */
+    if (!level) {
+        qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
+    }
+}
+
 static void sifive_u_machine_init(MachineState *machine)
 {
     const struct MemmapEntry *memmap = sifive_u_memmap;
@@ -380,6 +398,10 @@ static void sifive_u_machine_init(MachineState *machine)
     memory_region_add_subregion(system_memory, memmap[SIFIVE_U_FLASH0].base,
                                 flash0);
 
+    /* register gpio-restart */
+    qdev_connect_gpio_out(DEVICE(&(s->soc.gpio)), 10,
+                          qemu_allocate_irq(sifive_u_machine_reset, NULL, 0));
+
     /* create device tree */
     create_fdt(s, memmap, machine->ram_size, machine->kernel_cmdline);
 
-- 
2.27.0



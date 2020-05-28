Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C364C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 22:35:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07822206F1
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 22:35:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="gOUJsLmZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07822206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeR7A-0003iX-4V
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 18:35:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45442)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4104b2603=alistair.francis@wdc.com>)
 id 1jeQvx-0003PK-Bb; Thu, 28 May 2020 18:23:29 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:15467)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4104b2603=alistair.francis@wdc.com>)
 id 1jeQvw-0005wh-2B; Thu, 28 May 2020 18:23:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1590704608; x=1622240608;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Yze3hqguLA+ZPW/079pxXd43GbTnC7jJ94uG3nnkdwo=;
 b=gOUJsLmZ//afauicJU9T/Fj+zWrUXxTwwk+GYD5M8z4yrftVwutQL8p0
 e/Fx4MAOSTBJRhUbvUEgDLEl54fiZbJkUDGfPZbyPLSY858FNIhGdi3Mq
 ohN2/I5YmF/eWUMMvXSO3m09mmuZS5wesGDm2lvIu+IsGjRxTz/3ETtll
 x9p3+pxhEpHnxdjo/y644Iwr/nHbyivWuf25gCDDyIYQjtfARzSe1sNgH
 1ltvTVzyux2YGLzz9VzYub0bbnECz8UdTwfYbww87D/f9t2Ovo+KxyNxc
 tUuxdfI1g6rL+NRfeQRlrem4eMXgoVvWwNX+7RrHhFKfJZzvVofQPyCCT A==;
IronPort-SDR: kS2OuoX8KBd1U+WpAEv2t3lITF4uZcwphZGRNq2Nd2hRTwNd1hyEtdr71XpBxMs2a+baStkQWO
 9HhENxMt9+oWT8pqW6H3PdGKHMiTC0b9O3y5FPEuuOUilzRuN73WWAq+VXm+uQUtIk2IudFP5W
 1J/qh+gUl24udA81cZIQz99uC5PS+6xjZD2W9VUu9xGR6J/f38Np7e/NHZmbXxv3PrZO2xcURS
 jNkTxjhq6TK5ABHEqzIqQ6NhhvzTtrIE9vpPmsfc6TooT7ZLjopLTG85aNEebfzZGZ1A4aXr0Y
 bxo=
X-IronPort-AV: E=Sophos;i="5.73,446,1583164800"; d="scan'208";a="143076003"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 29 May 2020 06:23:08 +0800
IronPort-SDR: fYG4cr/87UO2YhVTL+9Rdhxs2uyqNkkA5oanPaGnl9SMbfltTGM4HwD4QaKsxBGsoCAplHBGXO
 hxrDNOOSFPqhQMqfGq996bW9lzPmFDas4=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 May 2020 15:12:22 -0700
IronPort-SDR: paoOaApGnr9Ga9GNrBqYUPkhRlrzVX43pz2h+Yr4M6dqmILWzxFJ5AoABDOQ0fzxYKb928QAOE
 hcSvh6ADqRug==
WDCIronportException: Internal
Received: from 6xf7cg2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.57.123])
 by uls-op-cesaip02.wdc.com with ESMTP; 28 May 2020 15:23:07 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v5 09/11] riscv/opentitan: Connect the PLIC device
Date: Thu, 28 May 2020 15:14:31 -0700
Message-Id: <377c075d02a082b6ea5c8cb853118671ac7ede1e.1590704015.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1590704015.git.alistair.francis@wdc.com>
References: <cover.1590704015.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=4104b2603=alistair.francis@wdc.com;
 helo=esa3.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 18:23:00
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_PASS=-0.001,
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
Cc: alistair.francis@wdc.com, bmeng.cn@gmail.com, palmer@dabbelt.com,
 alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Bin Meng <bin.meng@windriver.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/riscv/opentitan.h |  3 +++
 hw/riscv/opentitan.c         | 19 +++++++++++++++++--
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/include/hw/riscv/opentitan.h b/include/hw/riscv/opentitan.h
index a4b6499444..76f72905a8 100644
--- a/include/hw/riscv/opentitan.h
+++ b/include/hw/riscv/opentitan.h
@@ -20,6 +20,7 @@
 #define HW_OPENTITAN_H
 
 #include "hw/riscv/riscv_hart.h"
+#include "hw/intc/ibex_plic.h"
 
 #define TYPE_RISCV_IBEX_SOC "riscv.lowrisc.ibex.soc"
 #define RISCV_IBEX_SOC(obj) \
@@ -31,6 +32,8 @@ typedef struct LowRISCIbexSoCState {
 
     /*< public >*/
     RISCVHartArrayState cpus;
+    IbexPlicState plic;
+
     MemoryRegion flash_mem;
     MemoryRegion rom;
 } LowRISCIbexSoCState;
diff --git a/hw/riscv/opentitan.c b/hw/riscv/opentitan.c
index b4fb836466..46a3a93c5e 100644
--- a/hw/riscv/opentitan.c
+++ b/hw/riscv/opentitan.c
@@ -25,6 +25,7 @@
 #include "hw/misc/unimp.h"
 #include "hw/riscv/boot.h"
 #include "exec/address-spaces.h"
+#include "sysemu/sysemu.h"
 
 static const struct MemmapEntry {
     hwaddr base;
@@ -97,6 +98,9 @@ static void riscv_lowrisc_ibex_soc_init(Object *obj)
     object_initialize_child(obj, "cpus", &s->cpus,
                             sizeof(s->cpus), TYPE_RISCV_HART_ARRAY,
                             &error_abort, NULL);
+
+    sysbus_init_child_obj(obj, "plic", &s->plic,
+                          sizeof(s->plic), TYPE_IBEX_PLIC);
 }
 
 static void riscv_lowrisc_ibex_soc_realize(DeviceState *dev_soc, Error **errp)
@@ -105,6 +109,9 @@ static void riscv_lowrisc_ibex_soc_realize(DeviceState *dev_soc, Error **errp)
     MachineState *ms = MACHINE(qdev_get_machine());
     LowRISCIbexSoCState *s = RISCV_IBEX_SOC(dev_soc);
     MemoryRegion *sys_mem = get_system_memory();
+    DeviceState *dev;
+    SysBusDevice *busdev;
+    Error *err = NULL;
 
     object_property_set_str(OBJECT(&s->cpus), ms->cpu_type, "cpu-type",
                             &error_abort);
@@ -125,6 +132,16 @@ static void riscv_lowrisc_ibex_soc_realize(DeviceState *dev_soc, Error **errp)
     memory_region_add_subregion(sys_mem, memmap[IBEX_FLASH].base,
                                 &s->flash_mem);
 
+    /* PLIC */
+    dev = DEVICE(&s->plic);
+    object_property_set_bool(OBJECT(&s->plic), true, "realized", &err);
+    if (err != NULL) {
+        error_propagate(errp, err);
+        return;
+    }
+    busdev = SYS_BUS_DEVICE(dev);
+    sysbus_mmio_map(busdev, 0, memmap[IBEX_PLIC].base);
+
     create_unimplemented_device("riscv.lowrisc.ibex.uart",
         memmap[IBEX_UART].base, memmap[IBEX_UART].size);
     create_unimplemented_device("riscv.lowrisc.ibex.gpio",
@@ -145,8 +162,6 @@ static void riscv_lowrisc_ibex_soc_realize(DeviceState *dev_soc, Error **errp)
         memmap[IBEX_AES].base, memmap[IBEX_AES].size);
     create_unimplemented_device("riscv.lowrisc.ibex.hmac",
         memmap[IBEX_HMAC].base, memmap[IBEX_HMAC].size);
-    create_unimplemented_device("riscv.lowrisc.ibex.plic",
-        memmap[IBEX_PLIC].base, memmap[IBEX_PLIC].size);
     create_unimplemented_device("riscv.lowrisc.ibex.pinmux",
         memmap[IBEX_PINMUX].base, memmap[IBEX_PINMUX].size);
     create_unimplemented_device("riscv.lowrisc.ibex.alert_handler",
-- 
2.26.2



Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03808C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 17:08:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6AEF20771
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 17:08:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="kGhRpwjN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6AEF20771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmKVC-0002ES-Uk
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 13:08:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58092)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4324eb4de=alistair.francis@wdc.com>)
 id 1jmKUD-0000f9-5d
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 13:07:29 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:24431)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4324eb4de=alistair.francis@wdc.com>)
 id 1jmKUA-0004Pk-By
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 13:07:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1592586448; x=1624122448;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ZyHGfLXMoD/vQlrAS/c+SUX96vz+cOHa3/TUMLtyVWc=;
 b=kGhRpwjNSGbfcwmNKyPGUiiRrEImMVnm5KB83w8kmXC0eh8Czpb9V1Y4
 eap9+r5wlmfT3L97L3UeygkJR/QrVOprISWGaK9fCbg6fmtIJxMiokqNf
 9CkVsQTQhR3QhhKnna2w8dHQFK+l1+YD/A+QvnSIrBw/WEp05yVrQgEoW
 zIyAIAuwhHozEOfKn3A06krjwZjHEC/LaRPJEDsW8gsjDDes35LreSdSJ
 xKo+sF94sJnZ5CDHVQmRrWRbX/w4WLw1M0cdqH0mMs/FvrKkQyDXbbhhZ
 g0m7TXxOCRitx1aTtEatAJTQzFcwm0jVfXpgs/YrSFIXuNO6auJUZIVDG Q==;
IronPort-SDR: Po9P9PvycdX9ExbhWAg3UAezC8IcKs416WAMKO1cLR57KWqnlRhP7rqpF3+AWJEUGaVfHQZ77N
 SyBQbZfCU0L24kE+6x7w/b3C7NwLXWDBpFK4HwuUsbED10MR1E68Y0jqwZxw97pDJPCsy7TBY2
 KA8YTOCashF/5xjlalCLspSfnzWs2DY/Ts4aqh4EVpIxXuyzPvaZs07ihUFW9SkvjjagcsAA2E
 bh4mMYUZfNJ00i1SbrYTH1NXbG6g87Wzc3bHjxb29tBSifsO0E61Zx/Rf8JKI2u8VI1MaSO3Js
 i54=
X-IronPort-AV: E=Sophos;i="5.75,256,1589212800"; d="scan'208";a="243416990"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 20 Jun 2020 01:07:25 +0800
IronPort-SDR: 5S/qM5xJwe+WMPJG2iq33egEkJLmmWKLdoDtGOsYszd3xm2AnsGol6Y5xhml3mf8ZlI+YUts4w
 3A1mh44f2wI+JnB8/7yotN86HjG89Q/CI=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jun 2020 09:56:01 -0700
IronPort-SDR: pX4EIbFiMrPRRMf3mBSgcwb3UHD9NFFIm8ADkfnOn1H7hNqc35sxmQltERG/5aT0DiFBMEOoDH
 pJNQ+Q9qr/OQ==
WDCIronportException: Internal
Received: from unknown (HELO risc6-mainframe.hgst.com) ([10.86.58.142])
 by uls-op-cesaip02.wdc.com with ESMTP; 19 Jun 2020 10:07:25 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL v2 14/32] riscv/opentitan: Connect the PLIC device
Date: Fri, 19 Jun 2020 09:57:59 -0700
Message-Id: <20200619165817.4144200-15-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619165817.4144200-1-alistair.francis@wdc.com>
References: <20200619165817.4144200-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=68.232.143.124;
 envelope-from=prvs=4324eb4de=alistair.francis@wdc.com;
 helo=esa2.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 13:07:24
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
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Bin Meng <bin.meng@windriver.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/riscv/opentitan.h |  3 +++
 hw/riscv/opentitan.c         | 14 ++++++++++++--
 2 files changed, 15 insertions(+), 2 deletions(-)

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
index 011e4f7ee2..835b2c503f 100644
--- a/hw/riscv/opentitan.c
+++ b/hw/riscv/opentitan.c
@@ -26,6 +26,7 @@
 #include "hw/riscv/boot.h"
 #include "exec/address-spaces.h"
 #include "qemu/units.h"
+#include "sysemu/sysemu.h"
 
 static const struct MemmapEntry {
     hwaddr base;
@@ -94,6 +95,8 @@ static void riscv_lowrisc_ibex_soc_init(Object *obj)
     LowRISCIbexSoCState *s = RISCV_IBEX_SOC(obj);
 
     object_initialize_child(obj, "cpus", &s->cpus, TYPE_RISCV_HART_ARRAY);
+
+    object_initialize_child(obj, "plic", &s->plic, TYPE_IBEX_PLIC);
 }
 
 static void riscv_lowrisc_ibex_soc_realize(DeviceState *dev_soc, Error **errp)
@@ -102,6 +105,7 @@ static void riscv_lowrisc_ibex_soc_realize(DeviceState *dev_soc, Error **errp)
     MachineState *ms = MACHINE(qdev_get_machine());
     LowRISCIbexSoCState *s = RISCV_IBEX_SOC(dev_soc);
     MemoryRegion *sys_mem = get_system_memory();
+    Error *err = NULL;
 
     object_property_set_str(OBJECT(&s->cpus), ms->cpu_type, "cpu-type",
                             &error_abort);
@@ -121,6 +125,14 @@ static void riscv_lowrisc_ibex_soc_realize(DeviceState *dev_soc, Error **errp)
     memory_region_add_subregion(sys_mem, memmap[IBEX_FLASH].base,
                                 &s->flash_mem);
 
+    /* PLIC */
+    sysbus_realize(SYS_BUS_DEVICE(&s->plic), &err);
+    if (err != NULL) {
+        error_propagate(errp, err);
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->plic), 0, memmap[IBEX_PLIC].base);
+
     create_unimplemented_device("riscv.lowrisc.ibex.uart",
         memmap[IBEX_UART].base, memmap[IBEX_UART].size);
     create_unimplemented_device("riscv.lowrisc.ibex.gpio",
@@ -141,8 +153,6 @@ static void riscv_lowrisc_ibex_soc_realize(DeviceState *dev_soc, Error **errp)
         memmap[IBEX_AES].base, memmap[IBEX_AES].size);
     create_unimplemented_device("riscv.lowrisc.ibex.hmac",
         memmap[IBEX_HMAC].base, memmap[IBEX_HMAC].size);
-    create_unimplemented_device("riscv.lowrisc.ibex.plic",
-        memmap[IBEX_PLIC].base, memmap[IBEX_PLIC].size);
     create_unimplemented_device("riscv.lowrisc.ibex.pinmux",
         memmap[IBEX_PINMUX].base, memmap[IBEX_PINMUX].size);
     create_unimplemented_device("riscv.lowrisc.ibex.alert_handler",
-- 
2.27.0



Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FA4BC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 17:20:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5601220809
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 17:20:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="HOOuMai8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5601220809
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmKgq-0004R7-Ga
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 13:20:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58230)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4324eb4de=alistair.francis@wdc.com>)
 id 1jmKUG-0000kQ-D9
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 13:07:32 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:24436)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=4324eb4de=alistair.francis@wdc.com>)
 id 1jmKUE-0004Q3-03
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 13:07:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1592586453; x=1624122453;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=XRyEFMliFOazvxi0uiuNB7H49JK+CbFims83EBUndek=;
 b=HOOuMai8MlpHgr399522zV16bytVIpISJYwhr/J+3WiZVWOad/m/jU/W
 McNdAP3DIBIrUqQ95fUjvmpVxffwz8Lbb+G50FPtg49fXhaGjyAzDJQ4W
 R7in5a+S/pp6fOZpOkbk8iuRZYXf3ahMt0tz6GKjwqfFsvAW2H2YTITjs
 CH9iscnJXT/C96FTNDxVn7/pb9vejkRhxvlUceOLD/bHNuSGMV2XoTud9
 X9dv7origunhn8jJl0b1mm1Frb0yo+JJBp67kkA+IO1r028D3zeQSLnA1
 wOJrFm4/Y4WwUJcofLAq0xkRaKUrAoQ8qu6EB/lur/I4qPKFaTkzMzyiC w==;
IronPort-SDR: Y9ipvCupa62SzXDYAKh1+h5J/AQac/uoTr5kHFc2D7i4rI4DV9OHXGVU+FgfVu3+XwHQ9sQ2LE
 BtrCSLHxTo2C2MimB0iLBNxdN2TyDzfFQoTkVZeXVXVnHyy3nCyQK+AJP7VgQM2anjF2GCUDxm
 0X2tNzM83ERwZ7KCNAu+y3tC3TgJhnOfo40KSZuPr6AZt7o1sJBk2kcoDpr2S2cCcZqlZe76xJ
 FdbhCYPPHOSfIF8zT0nCXqlhP26APXO0mrpfbmfPRCJ4sLN4JBH32NcuGUC0X0ddeFgV35Kai5
 rww=
X-IronPort-AV: E=Sophos;i="5.75,256,1589212800"; d="scan'208";a="243416999"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 20 Jun 2020 01:07:27 +0800
IronPort-SDR: NTWeMTPfmNu68y5kAJbn6gpHHJIxfeMgrnWabYYb4r8awmlI3RpnphjUJvUGAtlbwko0qt1FEB
 iTLNpZ2t6wgkorWi8FywAEGvnDilnfwbw=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jun 2020 09:56:02 -0700
IronPort-SDR: dYAT47Ubq5wt971yWEOlY6zbwIrEoTNsN/HOziCICJkaScm3EjrrJW5s1MD01ldjxbQ2MajoUL
 pfBzUcKuaUSw==
WDCIronportException: Internal
Received: from unknown (HELO risc6-mainframe.hgst.com) ([10.86.58.142])
 by uls-op-cesaip02.wdc.com with ESMTP; 19 Jun 2020 10:07:26 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL v2 18/32] hw/riscv: opentitan: Remove the riscv_ prefix of the
 machine* and soc* functions
Date: Fri, 19 Jun 2020 09:58:03 -0700
Message-Id: <20200619165817.4144200-19-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619165817.4144200-1-alistair.francis@wdc.com>
References: <20200619165817.4144200-1-alistair.francis@wdc.com>
MIME-Version: 1.0
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
 Alistair Francis <alistair.francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bin Meng <bin.meng@windriver.com>

This was done in the virt & sifive_u codes, but opentitan codes were
missed. Remove the riscv_ prefix of the machine* and soc* functions.

Signed-off-by: Bin Meng <bin.meng@windriver.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 1591625864-31494-3-git-send-email-bmeng.cn@gmail.com
Message-Id: <1591625864-31494-3-git-send-email-bmeng.cn@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/opentitan.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/hw/riscv/opentitan.c b/hw/riscv/opentitan.c
index 675ce900bd..19223e4c29 100644
--- a/hw/riscv/opentitan.c
+++ b/hw/riscv/opentitan.c
@@ -53,7 +53,7 @@ static const struct MemmapEntry {
     [IBEX_PADCTRL] =        {  0x40160000,  0x10000 }
 };
 
-static void riscv_opentitan_init(MachineState *machine)
+static void opentitan_board_init(MachineState *machine)
 {
     const struct MemmapEntry *memmap = ibex_memmap;
     OpenTitanState *s = g_new0(OpenTitanState, 1);
@@ -70,7 +70,6 @@ static void riscv_opentitan_init(MachineState *machine)
     memory_region_add_subregion(sys_mem,
         memmap[IBEX_RAM].base, main_mem);
 
-
     if (machine->firmware) {
         riscv_load_firmware(machine->firmware, memmap[IBEX_RAM].base, NULL);
     }
@@ -80,17 +79,17 @@ static void riscv_opentitan_init(MachineState *machine)
     }
 }
 
-static void riscv_opentitan_machine_init(MachineClass *mc)
+static void opentitan_machine_init(MachineClass *mc)
 {
     mc->desc = "RISC-V Board compatible with OpenTitan";
-    mc->init = riscv_opentitan_init;
+    mc->init = opentitan_board_init;
     mc->max_cpus = 1;
     mc->default_cpu_type = TYPE_RISCV_CPU_IBEX;
 }
 
-DEFINE_MACHINE("opentitan", riscv_opentitan_machine_init)
+DEFINE_MACHINE("opentitan", opentitan_machine_init)
 
-static void riscv_lowrisc_ibex_soc_init(Object *obj)
+static void lowrisc_ibex_soc_init(Object *obj)
 {
     LowRISCIbexSoCState *s = RISCV_IBEX_SOC(obj);
 
@@ -101,7 +100,7 @@ static void riscv_lowrisc_ibex_soc_init(Object *obj)
     object_initialize_child(obj, "uart", &s->uart, TYPE_IBEX_UART);
 }
 
-static void riscv_lowrisc_ibex_soc_realize(DeviceState *dev_soc, Error **errp)
+static void lowrisc_ibex_soc_realize(DeviceState *dev_soc, Error **errp)
 {
     const struct MemmapEntry *memmap = ibex_memmap;
     MachineState *ms = MACHINE(qdev_get_machine());
@@ -186,26 +185,26 @@ static void riscv_lowrisc_ibex_soc_realize(DeviceState *dev_soc, Error **errp)
         memmap[IBEX_PADCTRL].base, memmap[IBEX_PADCTRL].size);
 }
 
-static void riscv_lowrisc_ibex_soc_class_init(ObjectClass *oc, void *data)
+static void lowrisc_ibex_soc_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
-    dc->realize = riscv_lowrisc_ibex_soc_realize;
+    dc->realize = lowrisc_ibex_soc_realize;
     /* Reason: Uses serial_hds in realize function, thus can't be used twice */
     dc->user_creatable = false;
 }
 
-static const TypeInfo riscv_lowrisc_ibex_soc_type_info = {
+static const TypeInfo lowrisc_ibex_soc_type_info = {
     .name = TYPE_RISCV_IBEX_SOC,
     .parent = TYPE_DEVICE,
     .instance_size = sizeof(LowRISCIbexSoCState),
-    .instance_init = riscv_lowrisc_ibex_soc_init,
-    .class_init = riscv_lowrisc_ibex_soc_class_init,
+    .instance_init = lowrisc_ibex_soc_init,
+    .class_init = lowrisc_ibex_soc_class_init,
 };
 
-static void riscv_lowrisc_ibex_soc_register_types(void)
+static void lowrisc_ibex_soc_register_types(void)
 {
-    type_register_static(&riscv_lowrisc_ibex_soc_type_info);
+    type_register_static(&lowrisc_ibex_soc_type_info);
 }
 
-type_init(riscv_lowrisc_ibex_soc_register_types)
+type_init(lowrisc_ibex_soc_register_types)
-- 
2.27.0



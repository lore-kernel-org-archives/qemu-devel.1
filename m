Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF1F8C83004
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 18:39:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A0BF2072A
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 18:39:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qGe4F+Gy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A0BF2072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTrbs-0002km-Ld
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 14:39:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37410)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=381fbd49e=alistair.francis@wdc.com>)
 id 1jTraA-0008J2-Rh
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 14:37:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <prvs=381fbd49e=alistair.francis@wdc.com>)
 id 1jTra8-0003Tp-1p
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 14:37:18 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:2041)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=381fbd49e=alistair.francis@wdc.com>)
 id 1jTra1-0003PZ-9U; Wed, 29 Apr 2020 14:37:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1588185430; x=1619721430;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=dQnv0AWXrAZvSlmsbH49Gt2Jsse2jUj501EULWstkYo=;
 b=qGe4F+GyK7Ysl6iie/4c7WBlrw+lKLZ/hD8QcFIUBjh0jGdv06NEQVDA
 trlrI3Jio5mgv4MkYdBAq5Yuw3Z+4cTyAvuah0VyUTe3faFsIuDtM0kMC
 t9fDjpfR3cvR4u/OOEXTc0HuS+lVPRBmZZIaFL8dqK2g6HeFajh2gLMAe
 55728gh+G9NQQKwCzE69OnwgewCFGzHzAP7gFTnaUBXGKP+RULVvZTQbh
 VR2o1/G/hkc7rkAiH+/GyKIgRuRbWvP7+zvWNlT7Vr+LMoYkslex+sSOW
 /Q0DZeCfxIv1gg3W8ubS6BIe9/NB561uQCozlHSPW7d2PbNcqqFBt+Lk1 g==;
IronPort-SDR: rgSO3F5miD5lHbbtOap8JOCl9P1g2Qzf+Tsxx8mGARNuKE6D0drlrdD/hFNs71i+VJrVVmsWY6
 +P9aa+8ucpoYTpIwbCeby82TrkWx/26gDgWDSmCWnKMpdpgCe0CQYQ2Q/WD1JbFvUyxm5VywBe
 QaJxdCfoF7n2YG+MSNyUHown9DGr0pr3Jqf821JkwVztEbqoocbxRYZVde5hwGCmKqO00lBpgh
 CfzkaVtYvlvNh5QcabhvWRY7W0bmAzrm7yJUQc0+3pSQNZm86vFogQknRc0G14b/yohYfBx1fY
 qgQ=
X-IronPort-AV: E=Sophos;i="5.73,332,1583164800"; d="scan'208";a="137935128"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 30 Apr 2020 02:37:04 +0800
IronPort-SDR: jKBlkO6P8KnylH+UIbawlj6puiY1AipcedR8Yk5cavsNpiSxcb5fy1ekEfJRgu7loBXjdYi/Nb
 MovGAQtj5I3KKWnL0GqMUc+0QEjUJpK/M=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Apr 2020 11:27:08 -0700
IronPort-SDR: yjz7qovcvUwPLULOV6wltPLDIu1SWFJV1B3/coKpv4Of/XYY2N71+EE2+XC2IZryS37RKs0xET
 TH2pU2iUsEMA==
WDCIronportException: Internal
Received: from cnf007834.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.55.253])
 by uls-op-cesaip01.wdc.com with ESMTP; 29 Apr 2020 11:37:02 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: peter.maydell@linaro.org
Subject: [PULL 01/14] riscv/sifive_u: Fix up file ordering
Date: Wed, 29 Apr 2020 11:28:43 -0700
Message-Id: <20200429182856.2588202-2-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200429182856.2588202-1-alistair.francis@wdc.com>
References: <20200429182856.2588202-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.45;
 envelope-from=prvs=381fbd49e=alistair.francis@wdc.com;
 helo=esa6.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 14:37:03
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Received-From: 216.71.154.45
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
Cc: Alistair Francis <alistair.francis@wdc.com>, palmerdabbelt@google.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org, Bin Meng <bmeng.cn@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Split the file into clear machine and SoC sections.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
---
 hw/riscv/sifive_u.c | 109 ++++++++++++++++++++++----------------------
 1 file changed, 55 insertions(+), 54 deletions(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 56351c4faa..d0ea6803db 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -312,7 +312,7 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
     g_free(nodename);
 }
 
-static void riscv_sifive_u_init(MachineState *machine)
+static void sifive_u_machine_init(MachineState *machine)
 {
     const struct MemmapEntry *memmap = sifive_u_memmap;
     SiFiveUState *s = RISCV_U_MACHINE(machine);
@@ -403,6 +403,60 @@ static void riscv_sifive_u_init(MachineState *machine)
                           &address_space_memory);
 }
 
+static bool sifive_u_machine_get_start_in_flash(Object *obj, Error **errp)
+{
+    SiFiveUState *s = RISCV_U_MACHINE(obj);
+
+    return s->start_in_flash;
+}
+
+static void sifive_u_machine_set_start_in_flash(Object *obj, bool value, Error **errp)
+{
+    SiFiveUState *s = RISCV_U_MACHINE(obj);
+
+    s->start_in_flash = value;
+}
+
+static void sifive_u_machine_instance_init(Object *obj)
+{
+    SiFiveUState *s = RISCV_U_MACHINE(obj);
+
+    s->start_in_flash = false;
+    object_property_add_bool(obj, "start-in-flash", sifive_u_machine_get_start_in_flash,
+                             sifive_u_machine_set_start_in_flash, NULL);
+    object_property_set_description(obj, "start-in-flash",
+                                    "Set on to tell QEMU's ROM to jump to " \
+                                    "flash. Otherwise QEMU will jump to DRAM",
+                                    NULL);
+}
+
+
+static void sifive_u_machine_class_init(ObjectClass *oc, void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+
+    mc->desc = "RISC-V Board compatible with SiFive U SDK";
+    mc->init = sifive_u_machine_init;
+    mc->max_cpus = SIFIVE_U_MANAGEMENT_CPU_COUNT + SIFIVE_U_COMPUTE_CPU_COUNT;
+    mc->min_cpus = SIFIVE_U_MANAGEMENT_CPU_COUNT + 1;
+    mc->default_cpus = mc->min_cpus;
+}
+
+static const TypeInfo sifive_u_machine_typeinfo = {
+    .name       = MACHINE_TYPE_NAME("sifive_u"),
+    .parent     = TYPE_MACHINE,
+    .class_init = sifive_u_machine_class_init,
+    .instance_init = sifive_u_machine_instance_init,
+    .instance_size = sizeof(SiFiveUState),
+};
+
+static void sifive_u_machine_init_register_types(void)
+{
+    type_register_static(&sifive_u_machine_typeinfo);
+}
+
+type_init(sifive_u_machine_init_register_types)
+
 static void riscv_sifive_u_soc_init(Object *obj)
 {
     MachineState *ms = MACHINE(qdev_get_machine());
@@ -443,33 +497,6 @@ static void riscv_sifive_u_soc_init(Object *obj)
                           TYPE_CADENCE_GEM);
 }
 
-static bool sifive_u_get_start_in_flash(Object *obj, Error **errp)
-{
-    SiFiveUState *s = RISCV_U_MACHINE(obj);
-
-    return s->start_in_flash;
-}
-
-static void sifive_u_set_start_in_flash(Object *obj, bool value, Error **errp)
-{
-    SiFiveUState *s = RISCV_U_MACHINE(obj);
-
-    s->start_in_flash = value;
-}
-
-static void riscv_sifive_u_machine_instance_init(Object *obj)
-{
-    SiFiveUState *s = RISCV_U_MACHINE(obj);
-
-    s->start_in_flash = false;
-    object_property_add_bool(obj, "start-in-flash", sifive_u_get_start_in_flash,
-                             sifive_u_set_start_in_flash, NULL);
-    object_property_set_description(obj, "start-in-flash",
-                                    "Set on to tell QEMU's ROM to jump to " \
-                                    "flash. Otherwise QEMU will jump to DRAM",
-                                    NULL);
-}
-
 static void riscv_sifive_u_soc_realize(DeviceState *dev, Error **errp)
 {
     MachineState *ms = MACHINE(qdev_get_machine());
@@ -607,29 +634,3 @@ static void riscv_sifive_u_soc_register_types(void)
 }
 
 type_init(riscv_sifive_u_soc_register_types)
-
-static void riscv_sifive_u_machine_class_init(ObjectClass *oc, void *data)
-{
-    MachineClass *mc = MACHINE_CLASS(oc);
-
-    mc->desc = "RISC-V Board compatible with SiFive U SDK";
-    mc->init = riscv_sifive_u_init;
-    mc->max_cpus = SIFIVE_U_MANAGEMENT_CPU_COUNT + SIFIVE_U_COMPUTE_CPU_COUNT;
-    mc->min_cpus = SIFIVE_U_MANAGEMENT_CPU_COUNT + 1;
-    mc->default_cpus = mc->min_cpus;
-}
-
-static const TypeInfo riscv_sifive_u_machine_typeinfo = {
-    .name       = MACHINE_TYPE_NAME("sifive_u"),
-    .parent     = TYPE_MACHINE,
-    .class_init = riscv_sifive_u_machine_class_init,
-    .instance_init = riscv_sifive_u_machine_instance_init,
-    .instance_size = sizeof(SiFiveUState),
-};
-
-static void riscv_sifive_u_machine_init_register_types(void)
-{
-    type_register_static(&riscv_sifive_u_machine_typeinfo);
-}
-
-type_init(riscv_sifive_u_machine_init_register_types)
-- 
2.26.2



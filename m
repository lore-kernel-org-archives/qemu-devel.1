Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 071B4C4360C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 23:42:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5B7E21721
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 23:42:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ldXPgJv3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5B7E21721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHz7Z-00060J-Vn
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 19:42:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32997)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=177211c83=alistair.francis@wdc.com>)
 id 1iHz2B-0000RH-0T
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 19:36:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=177211c83=alistair.francis@wdc.com>)
 id 1iHz29-0006Qo-CA
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 19:36:50 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:26134)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=177211c83=alistair.francis@wdc.com>)
 id 1iHz29-0006Q6-28; Tue, 08 Oct 2019 19:36:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1570577809; x=1602113809;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=R2nVtvjRrWvX24XxkUnh1oGyAnhgooAojvHlsrtud9s=;
 b=ldXPgJv3e/xif27u1itUm8NNcQ6T78cjeukZnN6k1Euu1QDVJCyka/7z
 z+23/QwvEU4l/wLCj9FB6uuN/HyWgejPj0h3cK+w4StJFh2ZhKzLRU4x1
 v0JWOGVxeHT6DFb0eJ6+GivUHBiElGe4gZHMaCVpYcdLuukS6d3+Fcsdo
 SbuwBXluL0YKY75IzTE89uivq5879VWSuHvV372nBaOAVoFgxnkUTQvu6
 F1aVMi6u0hjYeV/qOPhnbx+yM9JIwxGcTiarIaudg4jeM1EHOXfiTQEpe
 wrM/gkrDLxvpiIgC+o36ABh0q0botbrAQ5JIAwjc+wMjjre9LT/FtawLn A==;
IronPort-SDR: nchJAm6MnHfj8WiV5M5KLxLyF65KRKQXwWFL3B8BbmROtZ6njuaLeLgVTI25qldXANa4RVc8Ft
 lAq8GiiFeB5NxwCGtWuDoSpiC9YKe8LEcNfzACD+FEQGPtvRrByDTXcvSDxzPRHGXb12XP7A1t
 QtBpSvGfURDSuwA16+GYNma1OmKZiGBunyUKbUCg03NErKNU5WOBS0r49JLcjf4o71HsBBIgWv
 k7/lFfAKU9Ss5zScXnqoICOb6zNdQBLY8fsLLqdzOR/Wf9+xD/pFzDdaIPZ1HAbcTFkVQ6Dg3X
 PKc=
X-IronPort-AV: E=Sophos;i="5.67,273,1566835200"; d="scan'208";a="227059688"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 09 Oct 2019 07:36:46 +0800
IronPort-SDR: DTKWztKd4F/qmR6XuFxQ6jaR4BQ1rqx2wyEljy2Br54L5ruJEyI8VTxLVH45hdnlbbvUkOYdvv
 xf8Zd23ENXKv4uHF0HFg2tpMHE7o9JQKQus/6HSIRugMwqwKnG0dCPslJ7fdnPyUCPgrMn+eQ3
 3QDAcgHbvTLN5anBp+ivIHzXaVM73vnyg7835RTe3gjlxdU2eE5OTx0TlVxT11Gk9zkROAyWsQ
 HO/zpmoX3TO+UACZLc8ozS9sdpNssnRAOdUP5I3qCly/by/hFvAfxPCJ4kjkwmD+3GI48FPuOw
 BRaY1T8tYGazLa6Miq5Fz4so
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2019 16:32:46 -0700
IronPort-SDR: ECxz0I8bL62xCodACoQwtBjhYuZ5XYq8Ikn5vAKiK6EfxwoM6IYDvFviOM2xtwwbinCEiuvnvI
 dXT7Ap3pwkxSYEKX5hqd6iOs0BVvk2oT3ASwUdXTccISrMHOLg6BMO5egACTcEJ19lwjZuUMTR
 HOR+Mk0md0srXE3xVKRT71JUu6KHvw/4oQzKDtHEonJGPmM2cS7xyYyw0wxw88EoO9n53pEKV2
 h34RfBqKiBUC+Q5tTzUC4l2oJw93Q44jX8jQuHMrs0PowaV+lR+3gZFcflbY9AhlVJ3g43i6/m
 pLM=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.58])
 by uls-op-cesaip02.wdc.com with ESMTP; 08 Oct 2019 16:36:46 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v3 3/7] riscv/sifive_u: Manually define the machine
Date: Tue,  8 Oct 2019 16:32:14 -0700
Message-Id: <bf625755872198c71d9fbe64599858b6394afdc8.1570577500.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1570577500.git.alistair.francis@wdc.com>
References: <cover.1570577500.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 68.232.141.245
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

Instead of using the DEFINE_MACHINE() macro to define the machine let's
do it manually. This allows us to specify machine properties.

This patch is no functional change.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
Tested-by: Bin Meng <bmeng.cn@gmail.com>
---
 hw/riscv/sifive_u.c         | 44 ++++++++++++++++++++++++++-----------
 include/hw/riscv/sifive_u.h |  7 +++++-
 2 files changed, 37 insertions(+), 14 deletions(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index bc0e01242b..f5741e9a38 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -310,8 +310,7 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
 static void riscv_sifive_u_init(MachineState *machine)
 {
     const struct MemmapEntry *memmap = sifive_u_memmap;
-
-    SiFiveUState *s = g_new0(SiFiveUState, 1);
+    SiFiveUState *s = RISCV_U_MACHINE(machine);
     MemoryRegion *system_memory = get_system_memory();
     MemoryRegion *main_mem = g_new(MemoryRegion, 1);
     MemoryRegion *flash0 = g_new(MemoryRegion, 1);
@@ -433,6 +432,10 @@ static void riscv_sifive_u_soc_init(Object *obj)
                           TYPE_CADENCE_GEM);
 }
 
+static void riscv_sifive_u_machine_instance_init(Object *obj)
+{
+}
+
 static void riscv_sifive_u_soc_realize(DeviceState *dev, Error **errp)
 {
     MachineState *ms = MACHINE(qdev_get_machine());
@@ -546,17 +549,6 @@ static void riscv_sifive_u_soc_realize(DeviceState *dev, Error **errp)
         memmap[SIFIVE_U_GEM_MGMT].base, memmap[SIFIVE_U_GEM_MGMT].size);
 }
 
-static void riscv_sifive_u_machine_init(MachineClass *mc)
-{
-    mc->desc = "RISC-V Board compatible with SiFive U SDK";
-    mc->init = riscv_sifive_u_init;
-    mc->max_cpus = SIFIVE_U_MANAGEMENT_CPU_COUNT + SIFIVE_U_COMPUTE_CPU_COUNT;
-    mc->min_cpus = SIFIVE_U_MANAGEMENT_CPU_COUNT + 1;
-    mc->default_cpus = mc->min_cpus;
-}
-
-DEFINE_MACHINE("sifive_u", riscv_sifive_u_machine_init)
-
 static void riscv_sifive_u_soc_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
@@ -580,3 +572,29 @@ static void riscv_sifive_u_soc_register_types(void)
 }
 
 type_init(riscv_sifive_u_soc_register_types)
+
+static void riscv_sifive_u_machine_class_init(ObjectClass *oc, void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+
+    mc->desc = "RISC-V Board compatible with SiFive U SDK";
+    mc->init = riscv_sifive_u_init;
+    mc->max_cpus = SIFIVE_U_MANAGEMENT_CPU_COUNT + SIFIVE_U_COMPUTE_CPU_COUNT;
+    mc->min_cpus = SIFIVE_U_MANAGEMENT_CPU_COUNT + 1;
+    mc->default_cpus = mc->min_cpus;
+}
+
+static const TypeInfo riscv_sifive_u_machine_typeinfo = {
+    .name       = MACHINE_TYPE_NAME("sifive_u"),
+    .parent     = TYPE_MACHINE,
+    .class_init = riscv_sifive_u_machine_class_init,
+    .instance_init = riscv_sifive_u_machine_instance_init,
+    .instance_size = sizeof(SiFiveUState),
+};
+
+static void riscv_sifive_u_machine_init_register_types(void)
+{
+    type_register_static(&riscv_sifive_u_machine_typeinfo);
+}
+
+type_init(riscv_sifive_u_machine_init_register_types)
diff --git a/include/hw/riscv/sifive_u.h b/include/hw/riscv/sifive_u.h
index 2a08e2a5db..a921079fbe 100644
--- a/include/hw/riscv/sifive_u.h
+++ b/include/hw/riscv/sifive_u.h
@@ -44,12 +44,17 @@ typedef struct SiFiveUSoCState {
     CadenceGEMState gem;
 } SiFiveUSoCState;
 
+#define TYPE_RISCV_U_MACHINE MACHINE_TYPE_NAME("sifive_u")
+#define RISCV_U_MACHINE(obj) \
+    OBJECT_CHECK(SiFiveUState, (obj), TYPE_RISCV_U_MACHINE)
+
 typedef struct SiFiveUState {
     /*< private >*/
-    SysBusDevice parent_obj;
+    MachineState parent_obj;
 
     /*< public >*/
     SiFiveUSoCState soc;
+
     void *fdt;
     int fdt_size;
 } SiFiveUState;
-- 
2.23.0



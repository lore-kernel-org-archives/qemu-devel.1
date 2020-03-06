Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B13C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 21:45:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3B1220674
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 21:45:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="rb3lspD/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3B1220674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAKmE-0000y0-1J
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 16:45:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35204)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=32724e9af=alistair.francis@wdc.com>)
 id 1jAKlP-0008Vr-GB
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 16:44:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=32724e9af=alistair.francis@wdc.com>)
 id 1jAKlO-0002T4-3E
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 16:44:11 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:5208)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=32724e9af=alistair.francis@wdc.com>)
 id 1jAKlN-0002PM-QB; Fri, 06 Mar 2020 16:44:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1583531054; x=1615067054;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=05Q1mBpOGmEOAS6Fful2qHlv72Yzd6EzLEwaVFrElcg=;
 b=rb3lspD/A5+FH/RZzVfg3hldak8+gpsElC1JGJhJAGqHfp5hAlm/8b+i
 FBxJSHzSg7s/o4+cvjGOQDFQb5EgQlbByz4E280h4HQQU9HRy4R0x8ON4
 3XeKbyrCFZiUeUnMi0hSqklzTnHFTX6fknPZlhQZSXr8HHaSp+eJiPi8G
 L7bnzyY1tVBkHeZlUbOTcOqWdmotwUnMCX4HfqH9gnypl0K0YsMCgDdQM
 pAqyn2pibqvxB8LEAAVG81T2JkRnJ8+bNDkZkEPPN51cs0FRY+vZ/4Y/T
 XnnnorDAJJT0618TTvdWZ1fgufI8mkXgPNLLSbiBabMaty0AJZzLBH8GV Q==;
IronPort-SDR: /rCpoR6/JoQeWjZqlxn8h9dkJKsjY/BbjJ0qt9tkEuOycwsom1JFukJsEHNHCxUNRpNGCWMbPv
 WeVUhZpHV5gtHT3X3cnoL5qcPC51m8NLZLJ/1te+JZuLTwPe6+mA+1cgphAknkO2/RfXqkHZih
 XX6/Ip/vvxLDYLs864gtUZsO3CjtL0Bdk9Hub4uyIIQXmg02iuS7VKaYL8Ngs69WAxwBB9/wYV
 JN7SeWWt4MAWWNM5lFHFDbpWbdr2DdOO4dYFM5mox2K1oEX9WGXWqvbKdqU7Cqu1fCg71MdQ1U
 gP0=
X-IronPort-AV: E=Sophos;i="5.70,523,1574092800"; d="scan'208";a="233784271"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 07 Mar 2020 05:44:08 +0800
IronPort-SDR: EnvuAOlnYxCmFXTBIro8FdSq6bdSc0IxLNbvXhhcqLOMnhMtEtG3X5kSWInJP4h8iKJJu+puAG
 aq3qwTaYmRoFmlRSGn2RjFxtHOrYDj8tcWH7DCsRjl88nM0mDIlZbp0wSxPSIOmC1TXBFYBd6+
 I8nngBlSMhvUdpNIb+IT2ctuEznxOrg/Lb96vOLIPEtEb2uwd/QyRE2h5oobo+giu/OgdlVpAC
 GlvS78wI2hVvOjjyvcBbVperYuYqDed1w14tmF9HP/LtRV9QDDFvPhmEN7MkHyAZWbDJ+yCCBV
 FkvFthrt+szMmziTo+97YHQQ
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Mar 2020 13:35:52 -0800
IronPort-SDR: nH/w6hAdohxTcymeNl5wzeCRd8cJDJoh8f1NcjM2LHH3zPPPAejXn7ufbYRA45arRQxlFK3XXm
 ++ZFfI/0atFMGGHFV4M/pQKiWiCznAAjpQLpOTJz7g2aWZlajbWKxLC4GLBeL57nsNX25zToRO
 11P1Vnxh8gS93sNiEShcLwwkdYc6uwgsBm/IrgF3t/7o9JXfClCDz0s6rjANdMq+vTlH3+XzMH
 rLNLXu873oetn3qK77w0KImt2BpRgK3p2U1K6KBywdBfYMoHetT/E6TAR0xfISW28eJARg97tm
 eiQ=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.158.235])
 by uls-op-cesaip02.wdc.com with ESMTP; 06 Mar 2020 13:44:07 -0800
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v3 1/3] riscv/sifive_u: Fix up file ordering
Date: Fri,  6 Mar 2020 13:36:47 -0800
Message-Id: <b1b13c2243ecfe08e688240a38fec4ebe8794017.1583530528.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1583530528.git.alistair.francis@wdc.com>
References: <cover.1583530528.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 68.232.143.124
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
Cc: alistair.francis@wdc.com, palmer@dabbelt.com, alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Split the file into clear machine and SoC sections.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/sifive_u.c | 109 ++++++++++++++++++++++----------------------
 1 file changed, 55 insertions(+), 54 deletions(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 156a003642..4688837216 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -308,7 +308,7 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
     g_free(nodename);
 }
 
-static void riscv_sifive_u_init(MachineState *machine)
+static void sifive_u_machine_init(MachineState *machine)
 {
     const struct MemmapEntry *memmap = sifive_u_memmap;
     SiFiveUState *s = RISCV_U_MACHINE(machine);
@@ -399,6 +399,60 @@ static void riscv_sifive_u_init(MachineState *machine)
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
@@ -439,33 +493,6 @@ static void riscv_sifive_u_soc_init(Object *obj)
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
@@ -603,29 +630,3 @@ static void riscv_sifive_u_soc_register_types(void)
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
2.25.1



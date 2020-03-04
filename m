Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C54A5C3F2C6
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 01:37:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F69E2073D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 01:37:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="EK+o82aa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F69E2073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9IyW-0004C9-O8
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 20:37:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47581)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=3258e4f7a=alistair.francis@wdc.com>)
 id 1j9IxW-0003By-Gq
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 20:36:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=3258e4f7a=alistair.francis@wdc.com>)
 id 1j9IxV-0004N6-B5
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 20:36:26 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:26811)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=3258e4f7a=alistair.francis@wdc.com>)
 id 1j9IxU-0004Ky-VL; Tue, 03 Mar 2020 20:36:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1583285786; x=1614821786;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=dpSnUXJsfXsvbPky0lT+EZH/OqTvD/6BTmdDhhB8700=;
 b=EK+o82aa0jdZaagNLcFMUoe6NJCP9bVyw+L+rvXWv2G/rzottXk0NULJ
 kPuzCc3WOXF8Jo78aT8yhlmccv8jVzLhXELZhMv+HRFXhnF0R5VYMUhqQ
 fwLnqPfyztRKOTWVLNXul5itYw1CQDPDEJRbF6RNuqeItXmJMnLD3eJsP
 15uEHl5+0w0cA4AaDcrXkKhFK69ThQs3ODZodYgj04PIgr9N5C0XWHbxD
 Qts1cTR1okShrY8YTW4BO5Nx3tztrvI4mZOXcXnqLhZrED7iNNS9RLeZ+
 I0lHpSzJAowobB2nf22KpFJPAyU0lC4WA6VINzBuqZqPrCSYd4K6jk+EH Q==;
IronPort-SDR: Nio2yPUxEPcBGTKlum4bit4OoaZ6CusA4LlWyT/m3uUfh3BMG1LHcb+KYIWuaAdJcinY0KiLbo
 nLUv0K7C0t+B1FSftl36Ztj4wPywIjiOma3PX4NNBPxSElgAfSZruP26tLA3IgjJyfM2vq5Ufr
 WjAcN0JreUYaVE1UWBJfFAVH++d0yVnLGTZnNgYcz6ATOww2BGE71CKYMkrXOPY2JhGIt/gMrh
 V11yBAB8INcPUOOx2MDZxhrmTYzFwpadgY1/yGYmaqxZmZ84FrPryDAN6o8wtj4rRpUrN/1c/2
 tCI=
X-IronPort-AV: E=Sophos;i="5.70,511,1574092800"; d="scan'208";a="131866039"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 04 Mar 2020 09:36:24 +0800
IronPort-SDR: 7Fc3Fiwxm3f8Hgybe5fBXiaM3Kz+UDKS090Gw+yzW1WyIW+pH1H9jfcjrzq3IhnYlfEmaIn6IS
 1bYSE76uBQwtfujKGyCw3o4tO3sgWCTEAIH1A66zRwDiV1Tv+wyIpIyEAujZsa3MtsTDo23AAa
 uWBlrH97w80M5uLYZTuSDNlo2JemXG+gRw/OoudHKW0c28vMltx9CaZFwr1Nt0SsF3kEiUmnRG
 MFX2JwLISwsFAqpMKf8OeSWRO2PtGBL4PVsBWYJIf1BK4y0/ol5/ctAsjnyJYILtFl8yaZPjR9
 Yb9hEUJq5OMRtERYS3mxNBdX
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Mar 2020 17:28:14 -0800
IronPort-SDR: TS3hUjm8PVfy/0cd5gx1UeyGkD9BLkXojD54vlPz3T0EDj7wWjZxCHRMXcHvocGtywyAU7M2S3
 8DbsvLB8fcOhbh/6qYK+b2wQ5RXjxUxwndp7ABGQmnXXUka0UYLlObelTW/3V0Og//xRNpY/0g
 Nd6edrF8/4d52kC5XjHH5il997kYDaaJPxIBKVplN/5v6Nvp4u+BqILkw+vtNMM8RrO6KBWupF
 AQJ5m6sYQZcxK+zq/gGCoPjebsXXfMscaGpsaQzsUg9vlmNZ856VYi4t2sR+QZkf2HRRDW6mTH
 EgA=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.158.235])
 by uls-op-cesaip01.wdc.com with ESMTP; 03 Mar 2020 17:36:22 -0800
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v1 1/3] riscv/sifive_u: Fix up file ordering
Date: Tue,  3 Mar 2020 17:29:10 -0800
Message-Id: <3f5f5106d357f6ff911e4b81973840d414920b78.1583285287.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1583285287.git.alistair.francis@wdc.com>
References: <cover.1583285287.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 216.71.153.144
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
 hw/riscv/sifive_u.c | 107 ++++++++++++++++++++++----------------------
 1 file changed, 54 insertions(+), 53 deletions(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 156a003642..9a0145b5b4 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -399,6 +399,60 @@ static void riscv_sifive_u_init(MachineState *machine)
                           &address_space_memory);
 }
 
+static bool sifive_u_get_start_in_flash(Object *obj, Error **errp)
+{
+    SiFiveUState *s = RISCV_U_MACHINE(obj);
+
+    return s->start_in_flash;
+}
+
+static void sifive_u_set_start_in_flash(Object *obj, bool value, Error **errp)
+{
+    SiFiveUState *s = RISCV_U_MACHINE(obj);
+
+    s->start_in_flash = value;
+}
+
+static void riscv_sifive_u_machine_instance_init(Object *obj)
+{
+    SiFiveUState *s = RISCV_U_MACHINE(obj);
+
+    s->start_in_flash = false;
+    object_property_add_bool(obj, "start-in-flash", sifive_u_get_start_in_flash,
+                             sifive_u_set_start_in_flash, NULL);
+    object_property_set_description(obj, "start-in-flash",
+                                    "Set on to tell QEMU's ROM to jump to " \
+                                    "flash. Otherwise QEMU will jump to DRAM",
+                                    NULL);
+}
+
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



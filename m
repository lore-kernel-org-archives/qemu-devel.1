Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98E3DC3F2CE
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 23:10:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67C8E20866
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 23:10:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="B8yyAiZr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67C8E20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9dAF-0007tM-I4
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 18:10:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43447)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=3258e4f7a=alistair.francis@wdc.com>)
 id 1j9d98-0006RG-Uw
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 18:09:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=3258e4f7a=alistair.francis@wdc.com>)
 id 1j9d97-0004gX-MY
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 18:09:46 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:51004)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=3258e4f7a=alistair.francis@wdc.com>)
 id 1j9d97-0004Sp-ET; Wed, 04 Mar 2020 18:09:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1583363385; x=1614899385;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=dpSnUXJsfXsvbPky0lT+EZH/OqTvD/6BTmdDhhB8700=;
 b=B8yyAiZrKElW7N4BwDvfGhflTkitf5mMRq78xWrdJ4tPsmuPNcUZquwX
 X/LbutcyU6Wyg6SiQACg96pR1SceVRXJRkqHVUnTI3TIR1pT2i1QKHrpn
 eHDwbwbRxcAdaXPR930Jr4Mp7YNq+5GFmNYTYGsr0OZTbi+0x8VpvaH/W
 ypSLdhuwQI1SgyHl047aoAq+aaiETDFLGxpp5bvQ2fXmrHXLG/s0SQnjN
 xoQwQ09XFV1NyFO8+652ViTw+juxjEZ5zMRuzNsK/DQU3X702UoWkB7hs
 LwXVgsj9QHUuEvygt93ZRewr4fLMHGSDzKtjsrTtjnjI1wDC+FZol4Ms3 w==;
IronPort-SDR: aaz0jI4RfkXyTmV91uE1TSHpDqeYg2oQ7oyRY2w9w6eavcubfHQj/hYv/dUA5ImG9QqaUbCsX8
 g8LtHqxp87BMzPv1UPumMfDOarEIdc4p+EcsgcAM5RGE2fQZVzMfmKVdsfzVkMcIkbFVKdGNFt
 a6f3uY/inEw5Mqh9iSZeeiLnttnG/7XglFd2yhrvaTsA4Czw9l6mqGVlvLDUz1LnTj2xeqAuDv
 PxXiJ1ulr9Wy5H2+gzv0SvhD8FfnXEXOF7DPisFECAsGFkyJonJw/rNdXe6+SsGThYD+HhQZkE
 9EY=
X-IronPort-AV: E=Sophos;i="5.70,515,1574092800"; d="scan'208";a="131477237"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 05 Mar 2020 07:09:42 +0800
IronPort-SDR: hsYFAKYfg4nSVKQ8Dl80XPKiQQCXr6wNvC92md00ZBXAs1j1kvCjDV36snxcE+7ZhdBdhNJKJp
 gpFIulhdVifZB/cWE36C1MV8S+1xcBhkiB3WvV76n+oID/zDHMl7pEqgyURM3K6ug5dWYZZvNm
 i/eV/Zzw1dLymbtoSADVKRfwEmMOftBPSK8xPoFW3xgi9dLg/OstFUV3N2d/wM82dk26H80qsl
 n1LWcFf1+ZJcQbpCYCDhNlz9fBjJF3GjOxqTDFkodD6SKb/I3+E0DCMLMRHSOY4iwQ0kHarTwu
 STlAAMHiRFhI79BgPgU90LJ1
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Mar 2020 15:01:55 -0800
IronPort-SDR: We84TR+jMNm9G8J/+N9Qg23q7VoSJ8G4WiR0+9LD4HTkkHFcWKUEs9OevqwBDTDroujiUo0VKC
 nrV14wFJPggL8FTdZHWwH8k3gzl00YrNoATKZbZKHh2bnkNKBegQ/Irs0eZJnlg+YhRVmNtQQ5
 buH4FhvOmyF6v+ALc7E0LZxhh9dFM7gzeIav83W9ok1/ZpiIgfv6Jq8h9AqfikYJP8r20cpi7h
 rQKwUhV95ugfYHUM8iuOCyxDxsX/Yh+0TEGX7iG6GmVdKlOTC+BqlkliMwdmD32xocKtSHVV0d
 sWA=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.158.235])
 by uls-op-cesaip01.wdc.com with ESMTP; 04 Mar 2020 15:09:43 -0800
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v2 1/3] riscv/sifive_u: Fix up file ordering
Date: Wed,  4 Mar 2020 15:02:28 -0800
Message-Id: <a814566684adc3278874f0165a0a62047c66db5b.1583362888.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1583362888.git.alistair.francis@wdc.com>
References: <cover.1583362888.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 216.71.154.42
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



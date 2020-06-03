Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64FFDC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 16:26:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FA3A20659
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 16:26:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="bblBJ6js"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FA3A20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgWDN-0004QW-ER
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 12:26:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46996)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=416cc4bc0=alistair.francis@wdc.com>)
 id 1jgWAI-0007nP-LE
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 12:22:54 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:49287)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=416cc4bc0=alistair.francis@wdc.com>)
 id 1jgWAH-000625-HA
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 12:22:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1591201374; x=1622737374;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=PclMO5sTB+bwgBlASm1SuHh06xaJQLOTF7aqfhi7ZAo=;
 b=bblBJ6js9PLQB8z8e1gTrMTG36nV0W+ZtLYzorF/TnKmRGDBO3x4gIdu
 j9APX8SoTeJuKI4J+ETcAfIKK8WH8UMhll2EN5EgxObUyv8eoxOoUBCET
 B/PFXWl6ANhsPOqs+r2syxRMc1u2LXgi71lZmNRigm21lvM4YGtqzsWWS
 LD6rRwLNna0lgwsjNhvZ+uEcRXIZN9m6mWANonwPBvmIs623WC2hHRWFN
 dbUs4xCtytEHD7iZ9kykWuIQk9CItbX0TOaocuA3G2fkDcB01BRxB36Y/
 s2Rk0AvI8ENV8zcH4PA38jJrity2/CpnP5nQUAuN8g8pXuwAlHRQvvjeo w==;
IronPort-SDR: JfpttE0xIHvDBsyhTiyu1/+Cj2EEWMDw0rJ9dvSUUUIZ2mMq1zokGDF7fb6tm9pI7yqzhoavbR
 O1wZxwsEx3ugfjrs9Cx5uOr4JzPXqfuldOd29DoXHjLcP11aefOw3ZBdiviKOIAQFP9yoY74GH
 v3Ht54+MbGLb3ElGJAHH+HOCPx73rrT3wMJA4i2UpF+zThHCO/oPq32HV+ZM9RHjC5toQaw4ly
 45KIrCf3k2QQnJur6ozUvdodvK+90SffRNdsHiKwB4q1ECUEu9qXKX96RTKQ5HhALZfXz3D6Ay
 3AM=
X-IronPort-AV: E=Sophos;i="5.73,468,1583164800"; d="scan'208";a="143451372"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 04 Jun 2020 00:22:43 +0800
IronPort-SDR: 3Cwuw36JVBmzRNTlZdQ8w0qUULAJ5iXdoCDQaAGd2l4OrEw/mpUTLfTN0vgPLnLfvtopYGVzAJ
 51VBACpwDNMBeyjujtmTZOYa9AZCMUBS8=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2020 09:11:48 -0700
IronPort-SDR: qt26ZLFzgoHhMxZgB02NEh/OYNIEomFSLSrUpg9gg8vLSI/QhHb24jyElAIjXRlK46uubUE+/U
 /oTTt3p6kkiA==
WDCIronportException: Internal
Received: from cne220230.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.57.144])
 by uls-op-cesaip02.wdc.com with ESMTP; 03 Jun 2020 09:22:42 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL 09/15] riscv: sifive_e: Manually define the machine
Date: Wed,  3 Jun 2020 09:13:52 -0700
Message-Id: <20200603161352.744204-10-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200603161352.744204-1-alistair.francis@wdc.com>
References: <20200603161352.744204-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=416cc4bc0=alistair.francis@wdc.com;
 helo=esa3.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/03 12:22:40
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
Cc: alistair23@gmail.com, Palmer Dabbelt <palmerdabbelt@google.com>,
 Alistair Francis <alistair.francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 include/hw/riscv/sifive_e.h |  4 ++++
 hw/riscv/sifive_e.c         | 41 +++++++++++++++++++++++++++----------
 2 files changed, 34 insertions(+), 11 deletions(-)

diff --git a/include/hw/riscv/sifive_e.h b/include/hw/riscv/sifive_e.h
index 25ce7aa9d5..414992119e 100644
--- a/include/hw/riscv/sifive_e.h
+++ b/include/hw/riscv/sifive_e.h
@@ -47,6 +47,10 @@ typedef struct SiFiveEState {
     SiFiveESoCState soc;
 } SiFiveEState;
 
+#define TYPE_RISCV_E_MACHINE MACHINE_TYPE_NAME("sifive_e")
+#define RISCV_E_MACHINE(obj) \
+    OBJECT_CHECK(SiFiveEState, (obj), TYPE_RISCV_E_MACHINE)
+
 enum {
     SIFIVE_E_DEBUG,
     SIFIVE_E_MROM,
diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
index b53109521e..472a98970b 100644
--- a/hw/riscv/sifive_e.c
+++ b/hw/riscv/sifive_e.c
@@ -79,7 +79,7 @@ static void riscv_sifive_e_init(MachineState *machine)
 {
     const struct MemmapEntry *memmap = sifive_e_memmap;
 
-    SiFiveEState *s = g_new0(SiFiveEState, 1);
+    SiFiveEState *s = RISCV_E_MACHINE(machine);
     MemoryRegion *sys_mem = get_system_memory();
     MemoryRegion *main_mem = g_new(MemoryRegion, 1);
     int i;
@@ -115,6 +115,35 @@ static void riscv_sifive_e_init(MachineState *machine)
     }
 }
 
+static void sifive_e_machine_instance_init(Object *obj)
+{
+}
+
+static void sifive_e_machine_class_init(ObjectClass *oc, void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+
+    mc->desc = "RISC-V Board compatible with SiFive E SDK";
+    mc->init = riscv_sifive_e_init;
+    mc->max_cpus = 1;
+    mc->default_cpu_type = SIFIVE_E_CPU;
+}
+
+static const TypeInfo sifive_e_machine_typeinfo = {
+    .name       = MACHINE_TYPE_NAME("sifive_e"),
+    .parent     = TYPE_MACHINE,
+    .class_init = sifive_e_machine_class_init,
+    .instance_init = sifive_e_machine_instance_init,
+    .instance_size = sizeof(SiFiveEState),
+};
+
+static void sifive_e_machine_init_register_types(void)
+{
+    type_register_static(&sifive_e_machine_typeinfo);
+}
+
+type_init(sifive_e_machine_init_register_types)
+
 static void riscv_sifive_e_soc_init(Object *obj)
 {
     MachineState *ms = MACHINE(qdev_get_machine());
@@ -214,16 +243,6 @@ static void riscv_sifive_e_soc_realize(DeviceState *dev, Error **errp)
         &s->xip_mem);
 }
 
-static void riscv_sifive_e_machine_init(MachineClass *mc)
-{
-    mc->desc = "RISC-V Board compatible with SiFive E SDK";
-    mc->init = riscv_sifive_e_init;
-    mc->max_cpus = 1;
-    mc->default_cpu_type = SIFIVE_E_CPU;
-}
-
-DEFINE_MACHINE("sifive_e", riscv_sifive_e_machine_init)
-
 static void riscv_sifive_e_soc_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
-- 
2.26.2



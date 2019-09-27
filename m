Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B885C352AC
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 00:51:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9E7C2146E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 00:51:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="jV366L5b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9E7C2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDeTQ-0000KB-Nh
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 20:51:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49173)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=1662a5b7b=alistair.francis@wdc.com>)
 id 1iDeRD-0006wv-Ci
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 20:48:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=1662a5b7b=alistair.francis@wdc.com>)
 id 1iDeRB-0008Ky-P5
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 20:48:47 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:12537)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=1662a5b7b=alistair.francis@wdc.com>)
 id 1iDeRB-0008JB-FT; Thu, 26 Sep 2019 20:48:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1569545325; x=1601081325;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=P0+zpP1aR0Bufjmc+81ioH4NeM99sLPUDhZp2EXBmg8=;
 b=jV366L5bFeoiLJhNBCkvyRD0esLPLWQkIMRt2PWvUeHntjGtQ7Z72lMI
 TvDHHnuYo+bxmp+5EghPP+GFrnToJnfOorKl/kiT7szFNtnjqKJYsfGlT
 zx4i+qED1eUH8enFhfw8MqRWSItG+/XjH8gfgm8cqcBXUVrJq4Q8i/Mmp
 sfBijysZ+jW9xBW8E3+RG1WoeFwWX5ziPxAWuvowTfVhDg+Oy4AkJGsHw
 dMAHwzvJMWkBzTZ70VawrLLJvsy8v/x5xKa2Vv8yYSmQVuHUS9BK2ruTc
 75IDXkh8j10t3eXQls+wxfNTv+BUIYj7x7/9Go2iV+bXLmGsxiVoRWsqn Q==;
IronPort-SDR: czX4M8nMRdlenvEEBJaTm9wuH8TgL0wCiDs2Vm+1/g9jVOj5v4o3EwwuPc5NkMYs6kP4ujZk3F
 6IevAkmBm6nld4DRf3BEQY2y9Dc9qC3h0XeyC2bwlpod2uKJvmVKutVRuY6WgjilG283BHHNnD
 aVCORTHR7R3uYCUq5FLS6vwXpreh1+7b78CDhAcMn4Ukl06B3Wwcz84Djzn2GaB/CbY3z5tyv7
 KlY82h3ZlB/Kt9Xzb3IBmy6Hi7KYuPcPrvx6/JjRkfd2yIT0TWa3Zfk7/gfMiPUA1qtk88DEGp
 Mss=
X-IronPort-AV: E=Sophos;i="5.64,553,1559491200"; d="scan'208";a="119225545"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 27 Sep 2019 08:48:44 +0800
IronPort-SDR: tbaM0FtoIEqnIn2CFpD1t6A52X/082E+xL/WYCm6Vys2BxK79e+96mi08oYN0ffvQOfjVMvWEJ
 QuwWyCx7XW8trhLQ6Bw55Siqz+2qpe6l9YMCe81n2OGYlxW4hPw+lsPbQ5fGKbH9931Oc/5edH
 k1YE7INTElQam36+wrygUkAoFdcH/KaKgnC3BUAdK2VcjpQDriNY1dWtZarCLEQkfqYjYGFaf8
 2obuGsdgFD9pZ75ioa4zPu/x9lryFmoEuOxkP5W78R1vCM3+554t4K5Lyft/+RwKgWd8tqmXL8
 CVqetpCRxUG9qAbEDjeB1j92
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Sep 2019 17:44:59 -0700
IronPort-SDR: oKaIC+MUwRsElywRFDg9j/TwE16QhQHMRGtdVi6uOwxkref5YWO9A5+yPtBTrldeotZDNYUNju
 QF04hEgaNcs4VGE/xG3ZaXLX0dbjyEtFdLIIsCNMEdbB2LbwxOa7dj5jY3WtwJdTkDV5sKU9M0
 RvI/Gv63Bo6wlfdMvEpdk3JCFPQWY8SJsSrhVfGH0ddCRd5poTRgRBvHrwADjM4JwDg5xEpsE8
 Yku6d+6V6/gKkP4Y5W4Akdc1NTqsNxmSyrKPeVeI+vvpiazpERw6voeVuWbhHAnB4Prz4igfmV
 +s0=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.58])
 by uls-op-cesaip01.wdc.com with ESMTP; 26 Sep 2019 17:48:44 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v2 3/7] riscv/sifive_u: Manually define the machine
Date: Thu, 26 Sep 2019 17:44:25 -0700
Message-Id: <7406836747a1a0e9f91c6d79f9fe40ca17995c8a.1569545046.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1569545046.git.alistair.francis@wdc.com>
References: <cover.1569545046.git.alistair.francis@wdc.com>
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
Cc: alistair23@gmail.com, palmer@sifive.com, alistair.francis@wdc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Instead of using the DEFINE_MACHINE() macro to define the machine let's
do it manually. This allows us to specify machine properties.

This patch is no functional change.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
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



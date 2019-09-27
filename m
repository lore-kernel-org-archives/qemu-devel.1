Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BD88C4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 00:51:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02F9820872
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 00:51:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="du4oiZeH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02F9820872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDeTX-0000Xf-Qp
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 20:51:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49316)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=1662a5b7b=alistair.francis@wdc.com>)
 id 1iDeRJ-00071N-BY
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 20:48:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=1662a5b7b=alistair.francis@wdc.com>)
 id 1iDeRG-0008S2-L2
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 20:48:53 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:12537)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=1662a5b7b=alistair.francis@wdc.com>)
 id 1iDeRG-0008JB-8W; Thu, 26 Sep 2019 20:48:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1569545330; x=1601081330;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Vlv8jQm3wKK4DZJjww99om+ANcA80EJzz7CM7x+XWj4=;
 b=du4oiZeHgwoi4gZy413k5timSm++H13jH4Pm7ZLYcc9efHtJMg1CBNfD
 84qxsfZ8/ikMQpunYcJdcOckn8nXiMOT0qjFePov7WGm6sat1CzopMQ0I
 f9YNX56JopfvhSozFr6+VgK3J9O/qPwxUIYOzwGKQJSRbDYMRDNSeddFn
 3BT9j35oc3KwBorGDPlP8KyIomVLMmU9bCAq7cV2jsykr7EE61qD6FBbq
 fOd4nVtbBNfSYenGZTd7COiwsxIFYwZOS1JVhuIYp005OG78OA4OvW/0+
 JpA/nxa8yA/MMeJbTbsoN1wwqEexqYQZcsZemCgf0jQ3a/mDQ0fAaJ0gr A==;
IronPort-SDR: RQwiBJmxmyodr/PU+7G3fqJzpDIfJGv4+q9tSUtL3kmG4lcR5gzgSAxFwOi8X7d3utm5I2u9A/
 QCP8SjTt9JoRSSor1LewkvuSCbEE5xIbHMbuEnm96aIksfEyKtJIGMFxjd/tYgw6+oZJ1HcVDU
 j8D4RJnYtqXrJWA2uYazXKjiUMUO0aePfsrQzmfWH27bSEOt3KXzwM8K6GG0tk5+XoqVfri+fv
 EDNj7Q2CoxPwMZS9UyOZrnDwRLBjM4EC9d07BJqb7ft5nKrOCpX1ikYDh/qoqMI2GVfQT8fXSJ
 fpE=
X-IronPort-AV: E=Sophos;i="5.64,553,1559491200"; d="scan'208";a="119225551"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 27 Sep 2019 08:48:49 +0800
IronPort-SDR: Jqzx55lkpRGymF235yvP3XH0YPc5TFcEVzQHccbam0WOomiuzWGCDs4DLccAyJDPZ6Oa1VmX48
 O6XO8g2UHcPLbqFKM4MfZwHXoy6KLeuNCsQNM5ue7JsAcME5jWqnp2oC2H6sJJoYt0gKDPWqin
 /6h1ySiYv3Aye+ZORNRZVO/DeqiORvMTcrmjWfyCTjGevdiAH/6LeJ1okbIgW3FBrhsf0bFQ/W
 D0ntLpLMDMqW//9t/IN1PFgBMa066vHf4y5SGBwDiWr2RbutK8PD5iKqrQR91rGr/DlmK5IYSN
 lOiU+a7s0BjRew9F+x1D5EQm
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Sep 2019 17:45:04 -0700
IronPort-SDR: NfcGtkJs7u89PC/CSEgSIDFPpMxLB99qOmty5VtKGO1AOgeqMei+n9hi4JD0jKsoWhr3u8HPAi
 g4i/tZ2eOUFGLLuF8dxLz3NKM/nTySrJZ9RIaoOvFwwLk6Raq6CBeAVdZjvshb8ax5qOG6xi79
 /b8sLCxhNTLghWSFvOq00ROIgwEZKAno9ZWJPQDQayT4REG7PTBETo1kO0yqDHFOspDAdl4CBq
 sRnmCGXIZc6YoUNMUuoesXdjqzNJ+Wleb+6yyeh2KXmCgklUtq0sYNrhjhg3jxqg1C0ZSvUsmw
 5jw=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.58])
 by uls-op-cesaip01.wdc.com with ESMTP; 26 Sep 2019 17:48:50 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v2 5/7] riscv/virt: Manually define the machine
Date: Thu, 26 Sep 2019 17:44:31 -0700
Message-Id: <737cb09136e20293c82da7b07eb2020cc7bb99a2.1569545046.git.alistair.francis@wdc.com>
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
do it manually. This allows us to use the machine object to create
RISCVVirtState. This is required to add children and aliases to the
machine.

This patch is no functional change.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/virt.c         | 30 ++++++++++++++++++++++++------
 include/hw/riscv/virt.h |  7 ++++++-
 2 files changed, 30 insertions(+), 7 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index d36f5625ec..e4dcbadcb5 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -362,8 +362,7 @@ static inline DeviceState *gpex_pcie_init(MemoryRegion *sys_mem,
 static void riscv_virt_board_init(MachineState *machine)
 {
     const struct MemmapEntry *memmap = virt_memmap;
-
-    RISCVVirtState *s = g_new0(RISCVVirtState, 1);
+    RISCVVirtState *s = RISCV_VIRT_MACHINE(machine);
     MemoryRegion *system_memory = get_system_memory();
     MemoryRegion *main_mem = g_new(MemoryRegion, 1);
     MemoryRegion *mask_rom = g_new(MemoryRegion, 1);
@@ -499,12 +498,31 @@ static void riscv_virt_board_init(MachineState *machine)
     g_free(plic_hart_config);
 }
 
-static void riscv_virt_board_machine_init(MachineClass *mc)
+static void riscv_virt_machine_instance_init(Object *obj)
 {
-    mc->desc = "RISC-V VirtIO Board (Privileged ISA v1.10)";
+}
+
+static void riscv_virt_machine_class_init(ObjectClass *oc, void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+
+    mc->desc = "RISC-V VirtIO board";
     mc->init = riscv_virt_board_init;
-    mc->max_cpus = 8; /* hardcoded limit in BBL */
+    mc->max_cpus = 8;
     mc->default_cpu_type = VIRT_CPU;
 }
 
-DEFINE_MACHINE("virt", riscv_virt_board_machine_init)
+static const TypeInfo riscv_virt_machine_typeinfo = {
+    .name       = MACHINE_TYPE_NAME("virt"),
+    .parent     = TYPE_MACHINE,
+    .class_init = riscv_virt_machine_class_init,
+    .instance_init = riscv_virt_machine_instance_init,
+    .instance_size = sizeof(RISCVVirtState),
+};
+
+static void riscv_virt_machine_init_register_types(void)
+{
+    type_register_static(&riscv_virt_machine_typeinfo);
+}
+
+type_init(riscv_virt_machine_init_register_types)
diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
index 6e5fbe5d3b..ffcdcc6dcc 100644
--- a/include/hw/riscv/virt.h
+++ b/include/hw/riscv/virt.h
@@ -22,13 +22,18 @@
 #include "hw/riscv/riscv_hart.h"
 #include "hw/sysbus.h"
 
+#define TYPE_RISCV_VIRT_MACHINE MACHINE_TYPE_NAME("virt")
+#define RISCV_VIRT_MACHINE(obj) \
+    OBJECT_CHECK(RISCVVirtState, (obj), TYPE_RISCV_VIRT_MACHINE)
+
 typedef struct {
     /*< private >*/
-    SysBusDevice parent_obj;
+    MachineState parent;
 
     /*< public >*/
     RISCVHartArrayState soc;
     DeviceState *plic;
+
     void *fdt;
     int fdt_size;
 } RISCVVirtState;
-- 
2.23.0



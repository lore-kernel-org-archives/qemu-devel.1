Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CDA0C4360C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 23:39:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6778F21721
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 23:39:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Xq83Jnj3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6778F21721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHz4o-0002LW-BL
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 19:39:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33045)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=177211c83=alistair.francis@wdc.com>)
 id 1iHz2F-0000XS-T6
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 19:36:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=177211c83=alistair.francis@wdc.com>)
 id 1iHz2E-0006SK-8t
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 19:36:55 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:26134)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=177211c83=alistair.francis@wdc.com>)
 id 1iHz2D-0006Q6-RR; Tue, 08 Oct 2019 19:36:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1570577813; x=1602113813;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=RmUUWqqvs0KbSgjoaH5oggrEyXhZo+WnAXQN4PPkPvE=;
 b=Xq83Jnj3D4aGruU7MyzuZgi81NMfAMG5j9UIYzjB3hA9CaV/9Mm7WOq8
 tP8RI94pDD/7ag5uucJ718s+CZ5jwTXC90sLWrzYeutLlxoZsq4APBQRZ
 j4smyDN7z9jIrCTb1r5MteKd4rowD31WeprdARaSfPsSnsIMd2yIIzIpc
 vU8n9VGkVQ5aW2cQE7lsNMN50f8aNsZoQM5s+M3nK55gGoIECPcn+xhpR
 jFnVnigpTMHAg5ILgbVxFVIVwOri8qX3ccUODhbpHnEXwtgNhYutdghhm
 5oBwoMda8eEgd3RDLQ0LnKaWSI6fj4lhJVav97sLzsW+4dNaHuJzv0aLW g==;
IronPort-SDR: Wffgew3yru6WU0lDxNT8zJ+e/b5fBRSQoZJF3tMh4ABEoJtsHaTKjy8Hbuyf/rFpxI56JL9yV5
 HogjofJEPn5xMufgRdWHUno96hDTZkRcBE8Ln+T4z/oGcP4806rcftDipMJ1q6W3XkT8LaG/1Y
 1ytXgvMtE4kxrm2rYsrm8o8DlxH7ig4rTpx1VwXdMTupZtdNds9bHyl8Nay5fML6jCCkK6HncW
 /b7Hq0j9nJ/+tbHwsJWlxEulZ4zxck30bGubDbNp+zBEyoOlAizmhNwyjJUGd6QLFQJof6uD7y
 6ME=
X-IronPort-AV: E=Sophos;i="5.67,273,1566835200"; d="scan'208";a="227059696"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 09 Oct 2019 07:36:53 +0800
IronPort-SDR: PWUKnYMouIFh6CyFS0MOwdttCi32N0Orard73A1NB1EVh4VKhKybvMd5tyYaCJlRrvqpfbnL9o
 4z4zJrZVMsjGADm/ZM94H4C3MhSFJkzd6EM2XiZenyO/TNoq98UuTwQQ6BFq/z8zn2gWOGG7qY
 fZv5GpCcBMfQmBO6jxDAqqDI9CLjVbFFGLPdtvAVvKkUNLzJnnqQULj9GaYdG3GAl8bKqXh5aJ
 3b+OocJCfJcp/Qs9gbR+AGhPrcZSAxuyv5jO2T3oRM62QzH3qKJIPih1SA7iZKeGaO7dLo49WE
 7YvMldNlc+ejE+5NCAKnGvDm
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2019 16:32:53 -0700
IronPort-SDR: WVdkHJTUEjGuKMQf5utIGnioWDqzo+BZHiW2YPylWYfUr1hpilLai/ejkrQTSC8PshENtv3oGn
 M3NQX3/nQq2C+z0FsVOnFERCr78f/8Q7mJHHlAkt3iS2Qd4l/hfAkVkPDIFNxUracqYStvioM6
 ZUQRhA8cq78U2u6buQYnNXBGXz6w+xugHJlKEkc0GPNZaa7YcOQFYKxNzOtahz0wDjB4TwdxSU
 CNZO6bJGJsDeXz6hrD00OCaWt7My6E66u/x5rqYFjakxgqR/A3Jbk4RCMbb0zV9HEWTPYljDEh
 xq8=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.58])
 by uls-op-cesaip02.wdc.com with ESMTP; 08 Oct 2019 16:36:54 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v3 5/7] riscv/virt: Manually define the machine
Date: Tue,  8 Oct 2019 16:32:22 -0700
Message-Id: <31a8a928cefd62773ccfbad96e85e29d15e0de94.1570577500.git.alistair.francis@wdc.com>
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
do it manually. This allows us to use the machine object to create
RISCVVirtState. This is required to add children and aliases to the
machine.

This patch is no functional change.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
Tested-by: Bin Meng <bmeng.cn@gmail.com>
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



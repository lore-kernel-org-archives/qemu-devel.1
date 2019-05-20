Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D26D8C04AAC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 21:49:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9FF32171F
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 21:49:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9FF32171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42413 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSqAP-0002xo-RI
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 17:49:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57920)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hSq4v-0007j2-Rz
	for qemu-devel@nongnu.org; Mon, 20 May 2019 17:44:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hSq4u-0000QN-H7
	for qemu-devel@nongnu.org; Mon, 20 May 2019 17:44:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58226)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>)
	id 1hSq4r-0000M7-Vc; Mon, 20 May 2019 17:44:14 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D29B980F6D;
	Mon, 20 May 2019 21:44:10 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-28.brq.redhat.com [10.40.204.28])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id CD6481001E6C;
	Mon, 20 May 2019 21:44:03 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 20 May 2019 23:43:42 +0200
Message-Id: <20190520214342.13709-5-philmd@redhat.com>
In-Reply-To: <20190520214342.13709-1-philmd@redhat.com>
References: <20190520214342.13709-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.27]);
	Mon, 20 May 2019 21:44:10 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 4/4] hw/arm/exynos4210: QOM'ify the Exynos4210
 SoC
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Igor Mitsyanko <i.mitsyanko@gmail.com>,
	Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	Guenter Roeck <linux@roeck-us.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/arm/exynos4210.c         | 26 +++++++++++++++++++++++---
 hw/arm/exynos4_boards.c     |  9 ++++++---
 include/hw/arm/exynos4210.h |  9 +++++++--
 3 files changed, 36 insertions(+), 8 deletions(-)

diff --git a/hw/arm/exynos4210.c b/hw/arm/exynos4210.c
index 19009b76e7c..0b09129eff8 100644
--- a/hw/arm/exynos4210.c
+++ b/hw/arm/exynos4210.c
@@ -178,9 +178,10 @@ static void pl330_create(uint32_t base, qemu_irq irq=
, int nreq)
     sysbus_connect_irq(busdev, 0, irq);
 }
=20
-Exynos4210State *exynos4210_init(MemoryRegion *system_mem)
+static void exynos4210_realize(DeviceState *socdev, Error **errp)
 {
-    Exynos4210State *s =3D g_new0(Exynos4210State, 1);
+    Exynos4210State *s =3D EXYNOS4210_SOC(socdev);
+    MemoryRegion *system_mem =3D get_system_memory();
     qemu_irq gate_irq[EXYNOS4210_NCPUS][EXYNOS4210_IRQ_GATE_NINPUTS];
     SysBusDevice *busdev;
     DeviceState *dev;
@@ -435,6 +436,25 @@ Exynos4210State *exynos4210_init(MemoryRegion *syste=
m_mem)
                  qemu_irq_invert(s->irq_table[exynos4210_get_irq(36, 1)]=
), 32);
     pl330_create(EXYNOS4210_PL330_BASE2_ADDR,
                  qemu_irq_invert(s->irq_table[exynos4210_get_irq(34, 1)]=
), 1);
+}
+
+static void exynos4210_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
=20
-    return s;
+    dc->realize =3D exynos4210_realize;
 }
+
+static const TypeInfo exynos4210_info =3D {
+    .name =3D TYPE_EXYNOS4210_SOC,
+    .parent =3D TYPE_SYS_BUS_DEVICE,
+    .instance_size =3D sizeof(Exynos4210State),
+    .class_init =3D exynos4210_class_init,
+};
+
+static void exynos4210_register_types(void)
+{
+    type_register_static(&exynos4210_info);
+}
+
+type_init(exynos4210_register_types)
diff --git a/hw/arm/exynos4_boards.c b/hw/arm/exynos4_boards.c
index f824eef0d36..700e90d6671 100644
--- a/hw/arm/exynos4_boards.c
+++ b/hw/arm/exynos4_boards.c
@@ -45,7 +45,7 @@ typedef enum Exynos4BoardType {
 } Exynos4BoardType;
=20
 typedef struct Exynos4BoardState {
-    Exynos4210State *soc;
+    Exynos4210State soc;
     MemoryRegion dram0_mem;
     MemoryRegion dram1_mem;
 } Exynos4BoardState;
@@ -130,7 +130,10 @@ exynos4_boards_init_common(MachineState *machine,
     exynos4_boards_init_ram(s, get_system_memory(),
                             exynos4_board_ram_size[board_type]);
=20
-    s->soc =3D exynos4210_init(get_system_memory());
+    object_initialize(&s->soc, sizeof(s->soc), TYPE_EXYNOS4210_SOC);
+    qdev_set_parent_bus(DEVICE(&s->soc), sysbus_get_default());
+    object_property_set_bool(OBJECT(&s->soc), true, "realized",
+                             &error_fatal);
=20
     return s;
 }
@@ -148,7 +151,7 @@ static void smdkc210_init(MachineState *machine)
                                                       EXYNOS4_BOARD_SMDK=
C210);
=20
     lan9215_init(SMDK_LAN9118_BASE_ADDR,
-            qemu_irq_invert(s->soc->irq_table[exynos4210_get_irq(37, 1)]=
));
+            qemu_irq_invert(s->soc.irq_table[exynos4210_get_irq(37, 1)])=
);
     arm_load_kernel(ARM_CPU(first_cpu), &exynos4_board_binfo);
 }
=20
diff --git a/include/hw/arm/exynos4210.h b/include/hw/arm/exynos4210.h
index 098a69ec73d..27c684e851d 100644
--- a/include/hw/arm/exynos4210.h
+++ b/include/hw/arm/exynos4210.h
@@ -85,6 +85,9 @@ typedef struct Exynos4210Irq {
 } Exynos4210Irq;
=20
 typedef struct Exynos4210State {
+    /*< private >*/
+    SysBusDevice parent_obj;
+    /*< public >*/
     ARMCPU *cpu[EXYNOS4210_NCPUS];
     Exynos4210Irq irqs;
     qemu_irq *irq_table;
@@ -98,11 +101,13 @@ typedef struct Exynos4210State {
     I2CBus *i2c_if[EXYNOS4210_I2C_NUMBER];
 } Exynos4210State;
=20
+#define TYPE_EXYNOS4210_SOC "exynos4210"
+#define EXYNOS4210_SOC(obj) \
+    OBJECT_CHECK(Exynos4210State, obj, TYPE_EXYNOS4210_SOC)
+
 void exynos4210_write_secondary(ARMCPU *cpu,
         const struct arm_boot_info *info);
=20
-Exynos4210State *exynos4210_init(MemoryRegion *system_mem);
-
 /* Initialize exynos4210 IRQ subsystem stub */
 qemu_irq *exynos4210_init_irq(Exynos4210Irq *env);
=20
--=20
2.20.1



Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C66A3C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 14:40:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98C8B2054F
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 14:40:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98C8B2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1AjR-0005eB-3f
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 10:40:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50214)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i1Acw-0008Rj-9u
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 10:33:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i1Acu-0001Xy-VN
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 10:33:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52258)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>)
 id 1i1Acs-0001VL-5p; Fri, 23 Aug 2019 10:33:14 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 71363300C033;
 Fri, 23 Aug 2019 14:33:13 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-118.brq.redhat.com [10.40.204.118])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8F0465DD61;
 Fri, 23 Aug 2019 14:33:05 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 23 Aug 2019 16:32:44 +0200
Message-Id: <20190823143249.8096-2-philmd@redhat.com>
In-Reply-To: <20190823143249.8096-1-philmd@redhat.com>
References: <20190823143249.8096-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Fri, 23 Aug 2019 14:33:13 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 1/6] hw/arm: Use ARM_CPU_TYPE_NAME() macro
 when appropriate
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Andrey Smirnov <andrew.smirnov@gmail.com>, Jason Wang <jasowang@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, qemu-arm@nongnu.org,
 Peter Chubb <peter.chubb@nicta.com.au>,
 Antony Pavlov <antonynpavlov@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Commit ba1ba5cca introduce the ARM_CPU_TYPE_NAME() macro.
Unify the code base by use it in all places.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
v2: rebased, use in imx25/31 (pm215)
---
 hw/arm/allwinner-a10.c | 3 ++-
 hw/arm/cubieboard.c    | 3 ++-
 hw/arm/digic.c         | 3 ++-
 hw/arm/fsl-imx25.c     | 2 +-
 hw/arm/fsl-imx31.c     | 2 +-
 hw/arm/fsl-imx6.c      | 3 ++-
 hw/arm/fsl-imx6ul.c    | 2 +-
 hw/arm/xlnx-zynqmp.c   | 8 ++++----
 8 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/hw/arm/allwinner-a10.c b/hw/arm/allwinner-a10.c
index 73810a4440..118032c8c7 100644
--- a/hw/arm/allwinner-a10.c
+++ b/hw/arm/allwinner-a10.c
@@ -30,7 +30,8 @@ static void aw_a10_init(Object *obj)
     AwA10State *s =3D AW_A10(obj);
=20
     object_initialize_child(obj, "cpu", &s->cpu, sizeof(s->cpu),
-                            "cortex-a8-" TYPE_ARM_CPU, &error_abort, NUL=
L);
+                            ARM_CPU_TYPE_NAME("cortex-a8"),
+                            &error_abort, NULL);
=20
     sysbus_init_child_obj(obj, "intc", &s->intc, sizeof(s->intc),
                           TYPE_AW_A10_PIC);
diff --git a/hw/arm/cubieboard.c b/hw/arm/cubieboard.c
index 38e0ca0f53..ed8d2333a0 100644
--- a/hw/arm/cubieboard.c
+++ b/hw/arm/cubieboard.c
@@ -81,7 +81,8 @@ static void cubieboard_init(MachineState *machine)
=20
 static void cubieboard_machine_init(MachineClass *mc)
 {
-    mc->desc =3D "cubietech cubieboard";
+    mc->desc =3D "cubietech cubieboard (Cortex-A9)";
+    mc->default_cpu_type =3D ARM_CPU_TYPE_NAME("cortex-a9");
     mc->init =3D cubieboard_init;
     mc->block_default_type =3D IF_IDE;
     mc->units_per_default_bus =3D 1;
diff --git a/hw/arm/digic.c b/hw/arm/digic.c
index 4f52465875..22434a65a2 100644
--- a/hw/arm/digic.c
+++ b/hw/arm/digic.c
@@ -37,7 +37,8 @@ static void digic_init(Object *obj)
     int i;
=20
     object_initialize_child(obj, "cpu", &s->cpu, sizeof(s->cpu),
-                            "arm946-" TYPE_ARM_CPU, &error_abort, NULL);
+                            ARM_CPU_TYPE_NAME("arm946"),
+                            &error_abort, NULL);
=20
     for (i =3D 0; i < DIGIC4_NB_TIMERS; i++) {
 #define DIGIC_TIMER_NAME_MLEN    11
diff --git a/hw/arm/fsl-imx25.c b/hw/arm/fsl-imx25.c
index 532d088298..2b2fdb203a 100644
--- a/hw/arm/fsl-imx25.c
+++ b/hw/arm/fsl-imx25.c
@@ -36,7 +36,7 @@ static void fsl_imx25_init(Object *obj)
     FslIMX25State *s =3D FSL_IMX25(obj);
     int i;
=20
-    object_initialize(&s->cpu, sizeof(s->cpu), "arm926-" TYPE_ARM_CPU);
+    object_initialize(&s->cpu, sizeof(s->cpu), ARM_CPU_TYPE_NAME("arm926=
"));
=20
     sysbus_init_child_obj(obj, "avic", &s->avic, sizeof(s->avic),
                           TYPE_IMX_AVIC);
diff --git a/hw/arm/fsl-imx31.c b/hw/arm/fsl-imx31.c
index 1a37a7b997..6760de3c8c 100644
--- a/hw/arm/fsl-imx31.c
+++ b/hw/arm/fsl-imx31.c
@@ -33,7 +33,7 @@ static void fsl_imx31_init(Object *obj)
     FslIMX31State *s =3D FSL_IMX31(obj);
     int i;
=20
-    object_initialize(&s->cpu, sizeof(s->cpu), "arm1136-" TYPE_ARM_CPU);
+    object_initialize(&s->cpu, sizeof(s->cpu), ARM_CPU_TYPE_NAME("arm113=
6"));
=20
     sysbus_init_child_obj(obj, "avic", &s->avic, sizeof(s->avic),
                           TYPE_IMX_AVIC);
diff --git a/hw/arm/fsl-imx6.c b/hw/arm/fsl-imx6.c
index 8c397ef04b..552145b24e 100644
--- a/hw/arm/fsl-imx6.c
+++ b/hw/arm/fsl-imx6.c
@@ -43,7 +43,8 @@ static void fsl_imx6_init(Object *obj)
     for (i =3D 0; i < MIN(ms->smp.cpus, FSL_IMX6_NUM_CPUS); i++) {
         snprintf(name, NAME_SIZE, "cpu%d", i);
         object_initialize_child(obj, name, &s->cpu[i], sizeof(s->cpu[i])=
,
-                                "cortex-a9-" TYPE_ARM_CPU, &error_abort,=
 NULL);
+                                ARM_CPU_TYPE_NAME("cortex-a9"),
+                                &error_abort, NULL);
     }
=20
     sysbus_init_child_obj(obj, "a9mpcore", &s->a9mpcore, sizeof(s->a9mpc=
ore),
diff --git a/hw/arm/fsl-imx6ul.c b/hw/arm/fsl-imx6ul.c
index b074177a71..c405b68d1d 100644
--- a/hw/arm/fsl-imx6ul.c
+++ b/hw/arm/fsl-imx6ul.c
@@ -34,7 +34,7 @@ static void fsl_imx6ul_init(Object *obj)
     int i;
=20
     object_initialize_child(obj, "cpu0", &s->cpu, sizeof(s->cpu),
-                            "cortex-a7-" TYPE_ARM_CPU, &error_abort, NUL=
L);
+                            ARM_CPU_TYPE_NAME("cortex-a7"), &error_abort=
, NULL);
=20
     /*
      * A7MPCORE
diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
index 0f587e63d3..fb03c60ebb 100644
--- a/hw/arm/xlnx-zynqmp.c
+++ b/hw/arm/xlnx-zynqmp.c
@@ -196,8 +196,8 @@ static void xlnx_zynqmp_create_rpu(MachineState *ms, =
XlnxZynqMPState *s,
=20
         object_initialize_child(OBJECT(&s->rpu_cluster), "rpu-cpu[*]",
                                 &s->rpu_cpu[i], sizeof(s->rpu_cpu[i]),
-                                "cortex-r5f-" TYPE_ARM_CPU, &error_abort=
,
-                                NULL);
+                                ARM_CPU_TYPE_NAME("cortex-r5f"),
+                                &error_abort, NULL);
=20
         name =3D object_get_canonical_path_component(OBJECT(&s->rpu_cpu[=
i]));
         if (strcmp(name, boot_cpu)) {
@@ -237,8 +237,8 @@ static void xlnx_zynqmp_init(Object *obj)
     for (i =3D 0; i < num_apus; i++) {
         object_initialize_child(OBJECT(&s->apu_cluster), "apu-cpu[*]",
                                 &s->apu_cpu[i], sizeof(s->apu_cpu[i]),
-                                "cortex-a53-" TYPE_ARM_CPU, &error_abort=
,
-                                NULL);
+                                ARM_CPU_TYPE_NAME("cortex-a53"),
+                                &error_abort, NULL);
     }
=20
     sysbus_init_child_obj(obj, "gic", &s->gic, sizeof(s->gic),
--=20
2.20.1



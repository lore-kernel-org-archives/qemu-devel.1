Return-Path: <SRS0=qU7A=VV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25217C7618B
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 11:00:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEF9F22387
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 11:00:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEF9F22387
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqF0X-0006yG-SY
	for qemu-devel@archiver.kernel.org; Wed, 24 Jul 2019 07:00:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45951)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <clg@kaod.org>) id 1hqF0J-0006QS-Om
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 07:00:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1hqF0I-0001Uq-Aq
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 07:00:15 -0400
Received: from 10.mo173.mail-out.ovh.net ([46.105.74.148]:35904)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1hqF0I-0001TO-5K
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 07:00:14 -0400
Received: from player770.ha.ovh.net (unknown [10.109.159.159])
 by mo173.mail-out.ovh.net (Postfix) with ESMTP id DEDFC1141AC
 for <qemu-devel@nongnu.org>; Wed, 24 Jul 2019 13:00:11 +0200 (CEST)
Received: from kaod.org (lfbn-1-2240-157.w90-76.abo.wanadoo.fr [90.76.60.157])
 (Authenticated sender: clg@kaod.org)
 by player770.ha.ovh.net (Postfix) with ESMTPSA id 1B2F08448905;
 Wed, 24 Jul 2019 11:00:06 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 24 Jul 2019 13:00:01 +0200
Message-Id: <20190724110001.17553-1-clg@kaod.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 4195947481003494374
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrkedtgdefudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.74.148
Subject: [Qemu-devel] [PATCH v2] ppc/pnv: Introduce PowerNV machines with
 fixed CPU models
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
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-ppc@nongnu.org,
 Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Make the current "powernv" machine an abstract type and derive from it
new machines with specific CPU models: power8 and power9.

The "powernv" machine is now an alias on the "powernv9" machine.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---

 Changes since v1:

 - removed power8e and power8nvl machines
 - added a pnv_match_cpu() helper to check compatibility of the
   specified CPU with the machine default

 hw/ppc/pnv.c | 70 ++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 63 insertions(+), 7 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 4570ce8afe6a..18602b9e9bcd 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -602,9 +602,20 @@ static void pnv_chip_power9_pic_print_info(PnvChip *=
chip, Monitor *mon)
     pnv_psi_pic_print_info(&chip9->psi, mon);
 }
=20
+static bool pnv_match_cpu(const char *default_type, const char *cpu_type=
)
+{
+    PowerPCCPUClass *ppc_default =3D
+        POWERPC_CPU_CLASS(object_class_by_name(default_type));
+    PowerPCCPUClass *ppc =3D
+        POWERPC_CPU_CLASS(object_class_by_name(cpu_type));
+
+    return ppc_default->pvr_match(ppc_default, ppc->pvr);
+}
+
 static void pnv_init(MachineState *machine)
 {
     PnvMachineState *pnv =3D PNV_MACHINE(machine);
+    MachineClass *mc =3D MACHINE_GET_CLASS(machine);
     MemoryRegion *ram;
     char *fw_filename;
     long fw_size;
@@ -664,13 +675,23 @@ static void pnv_init(MachineState *machine)
         }
     }
=20
+    /*
+     * Check compatibility of the specified CPU with the machine
+     * default.
+     */
+    if (!pnv_match_cpu(mc->default_cpu_type, machine->cpu_type)) {
+        error_report("invalid CPU model '%s' for %s machine",
+                     machine->cpu_type, mc->name);
+        exit(1);
+    }
+
     /* Create the processor chips */
     i =3D strlen(machine->cpu_type) - strlen(POWERPC_CPU_TYPE_SUFFIX);
     chip_typename =3D g_strdup_printf(PNV_CHIP_TYPE_NAME("%.*s"),
                                     i, machine->cpu_type);
     if (!object_class_by_name(chip_typename)) {
-        error_report("invalid CPU model '%.*s' for %s machine",
-                     i, machine->cpu_type, MACHINE_GET_CLASS(machine)->n=
ame);
+        error_report("invalid chip model '%.*s' for %s machine",
+                     i, machine->cpu_type, mc->name);
         exit(1);
     }
=20
@@ -1348,25 +1369,43 @@ static void pnv_machine_class_props_init(ObjectCl=
ass *oc)
                               NULL);
 }
=20
-static void pnv_machine_class_init(ObjectClass *oc, void *data)
+static void pnv_machine_power8_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc =3D MACHINE_CLASS(oc);
     XICSFabricClass *xic =3D XICS_FABRIC_CLASS(oc);
+
+    mc->desc =3D "IBM PowerNV (Non-Virtualized) POWER8";
+    mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("power8_v2.0");
+
+    xic->icp_get =3D pnv_icp_get;
+    xic->ics_get =3D pnv_ics_get;
+    xic->ics_resend =3D pnv_ics_resend;
+}
+
+static void pnv_machine_power9_class_init(ObjectClass *oc, void *data)
+{
+    MachineClass *mc =3D MACHINE_CLASS(oc);
+
+    mc->desc =3D "IBM PowerNV (Non-Virtualized) POWER9";
+    mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("power9_v2.0");
+
+    mc->alias =3D "powernv";
+}
+
+static void pnv_machine_class_init(ObjectClass *oc, void *data)
+{
+    MachineClass *mc =3D MACHINE_CLASS(oc);
     InterruptStatsProviderClass *ispc =3D INTERRUPT_STATS_PROVIDER_CLASS=
(oc);
=20
     mc->desc =3D "IBM PowerNV (Non-Virtualized)";
     mc->init =3D pnv_init;
     mc->reset =3D pnv_reset;
     mc->max_cpus =3D MAX_CPUS;
-    mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("power8_v2.0");
     mc->block_default_type =3D IF_IDE; /* Pnv provides a AHCI device for
                                       * storage */
     mc->no_parallel =3D 1;
     mc->default_boot_order =3D NULL;
     mc->default_ram_size =3D 2 * GiB;
-    xic->icp_get =3D pnv_icp_get;
-    xic->ics_get =3D pnv_ics_get;
-    xic->ics_resend =3D pnv_ics_resend;
     ispc->print_info =3D pnv_pic_print_info;
=20
     pnv_machine_class_props_init(oc);
@@ -1386,10 +1425,27 @@ static void pnv_machine_class_init(ObjectClass *o=
c, void *data)
         .parent        =3D TYPE_PNV9_CHIP,          \
     }
=20
+#define DEFINE_PNV_MACHINE_TYPE(cpu, class_initfn)      \
+    {                                                   \
+        .name          =3D MACHINE_TYPE_NAME(cpu),        \
+        .parent        =3D TYPE_PNV_MACHINE,              \
+        .instance_size =3D sizeof(PnvMachineState),       \
+        .instance_init =3D pnv_machine_instance_init,     \
+        .class_init    =3D class_initfn,                  \
+        .interfaces =3D (InterfaceInfo[]) {               \
+            { TYPE_XICS_FABRIC },                       \
+            { TYPE_INTERRUPT_STATS_PROVIDER },          \
+            { },                                        \
+        },                                              \
+    }
+
 static const TypeInfo types[] =3D {
+    DEFINE_PNV_MACHINE_TYPE("powernv8", pnv_machine_power8_class_init),
+    DEFINE_PNV_MACHINE_TYPE("powernv9", pnv_machine_power9_class_init),
     {
         .name          =3D TYPE_PNV_MACHINE,
         .parent        =3D TYPE_MACHINE,
+        .abstract       =3D true,
         .instance_size =3D sizeof(PnvMachineState),
         .instance_init =3D pnv_machine_instance_init,
         .class_init    =3D pnv_machine_class_init,
--=20
2.21.0



Return-Path: <SRS0=dPN4=5U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19C74C2BA15
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Apr 2020 15:38:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCEE320644
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Apr 2020 15:38:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCEE320644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKks9-0005pn-3p
	for qemu-devel@archiver.kernel.org; Sat, 04 Apr 2020 11:38:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46671)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1jKkrB-0005EI-2T
 for qemu-devel@nongnu.org; Sat, 04 Apr 2020 11:37:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1jKkr9-0004IU-Oh
 for qemu-devel@nongnu.org; Sat, 04 Apr 2020 11:37:13 -0400
Received: from 5.mo4.mail-out.ovh.net ([188.165.44.50]:38179)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1jKkr9-0004Hy-JF
 for qemu-devel@nongnu.org; Sat, 04 Apr 2020 11:37:11 -0400
Received: from player755.ha.ovh.net (unknown [10.108.57.18])
 by mo4.mail-out.ovh.net (Postfix) with ESMTP id 34B7822D565
 for <qemu-devel@nongnu.org>; Sat,  4 Apr 2020 17:37:08 +0200 (CEST)
Received: from kaod.org (82-64-250-170.subs.proxad.net [82.64.250.170])
 (Authenticated sender: clg@kaod.org)
 by player755.ha.ovh.net (Postfix) with ESMTPSA id 240C61130C753;
 Sat,  4 Apr 2020 15:36:57 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH] ppc/pnv: Create BMC devices only when defaults are enabled
Date: Sat,  4 Apr 2020 17:36:55 +0200
Message-Id: <20200404153655.166834-1-clg@kaod.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 12223895292269464550
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrtdekgdeltdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofggtgfgsehtkeertdertdejnecuhfhrohhmpeevrogurhhitgcunfgvucfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdekvddrieegrddvhedtrddujedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeehhedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 188.165.44.50
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
Cc: Corey Minyard <cminyard@mvista.com>, Greg Kurz <groug@kaod.org>,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Oliver O'Halloran <oohall@gmail.com>,
 Nathan Chancellor <natechancellor@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Commit e2392d4395dd ("ppc/pnv: Create BMC devices at machine init")
introduced default BMC devices which can be a problem when the same
devices are defined on the command line with :

  -device ipmi-bmc-sim,id=3Dbmc0 -device isa-ipmi-bt,bmc=3Dbmc0,irq=3D10

QEMU fails with :

  qemu-system-ppc64: error creating device tree: node: FDT_ERR_EXISTS

Use defaults_enabled() when creating the default BMC devices to let
the user provide its own BMC devices using '-nodefaults'. If no BMC
device are provided, output a warning but let QEMU run as this is a
supported configuration. However, when multiple BMC devices are
defined, stop QEMU with a clear error as the results are unexpected.

Fixes: e2392d4395dd ("ppc/pnv: Create BMC devices at machine init")
Reported-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/ppc/pnv.h |  2 ++
 hw/ppc/pnv.c         | 32 ++++++++++++++++++++++++++-----
 hw/ppc/pnv_bmc.c     | 45 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 74 insertions(+), 5 deletions(-)

diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index fb4d0c0234b3..d4b0b0e2ff71 100644
--- a/include/hw/ppc/pnv.h
+++ b/include/hw/ppc/pnv.h
@@ -241,6 +241,8 @@ struct PnvMachineState {
 void pnv_dt_bmc_sensors(IPMIBmc *bmc, void *fdt);
 void pnv_bmc_powerdown(IPMIBmc *bmc);
 IPMIBmc *pnv_bmc_create(PnvPnor *pnor);
+IPMIBmc *pnv_bmc_find(Error **errp);
+void pnv_bmc_set_pnor(IPMIBmc *bmc, PnvPnor *pnor);
=20
 /*
  * POWER8 MMIO base addresses
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index ac83b8698b8e..a3b7a8d0ff32 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -573,10 +573,29 @@ static void pnv_powerdown_notify(Notifier *n, void =
*opaque)
=20
 static void pnv_reset(MachineState *machine)
 {
+    PnvMachineState *pnv =3D PNV_MACHINE(machine);
+    IPMIBmc *bmc;
     void *fdt;
=20
     qemu_devices_reset();
=20
+    /*
+     * The machine should provide by default an internal BMC simulator.
+     * If not, try to use the BMC device that was provided on the comman=
d
+     * line.
+     */
+    bmc =3D pnv_bmc_find(&error_fatal);
+    if (!pnv->bmc) {
+        if (!bmc) {
+            warn_report("machine has no BMC device. Use '-device "
+                        "ipmi-bmc-sim,id=3Dbmc0 -device isa-ipmi-bt,bmc=3D=
bmc0,irq=3D10' "
+                        "to define one");
+        } else {
+            pnv_bmc_set_pnor(bmc, pnv->pnor);
+            pnv->bmc =3D bmc;
+        }
+    }
+
     fdt =3D pnv_dt_create(machine);
=20
     /* Pack resulting tree */
@@ -835,9 +854,6 @@ static void pnv_init(MachineState *machine)
     }
     g_free(chip_typename);
=20
-    /* Create the machine BMC simulator */
-    pnv->bmc =3D pnv_bmc_create(pnv->pnor);
-
     /* Instantiate ISA bus on chip 0 */
     pnv->isa_bus =3D pnv_isa_create(pnv->chips[0], &error_fatal);
=20
@@ -847,8 +863,14 @@ static void pnv_init(MachineState *machine)
     /* Create an RTC ISA device too */
     mc146818_rtc_init(pnv->isa_bus, 2000, NULL);
=20
-    /* Create the IPMI BT device for communication with the BMC */
-    pnv_ipmi_bt_init(pnv->isa_bus, pnv->bmc, 10);
+    /*
+     * Create the machine BMC simulator and the IPMI BT device for
+     * communication with the BMC
+     */
+    if (defaults_enabled()) {
+        pnv->bmc =3D pnv_bmc_create(pnv->pnor);
+        pnv_ipmi_bt_init(pnv->isa_bus, pnv->bmc, 10);
+    }
=20
     /*
      * OpenPOWER systems use a IPMI SEL Event message to notify the
diff --git a/hw/ppc/pnv_bmc.c b/hw/ppc/pnv_bmc.c
index 8863354c1c08..4e018b8b70e4 100644
--- a/hw/ppc/pnv_bmc.c
+++ b/hw/ppc/pnv_bmc.c
@@ -213,6 +213,18 @@ static const IPMINetfn hiomap_netfn =3D {
     .cmd_handlers =3D hiomap_cmds
 };
=20
+
+void pnv_bmc_set_pnor(IPMIBmc *bmc, PnvPnor *pnor)
+{
+    object_ref(OBJECT(pnor));
+    object_property_add_const_link(OBJECT(bmc), "pnor", OBJECT(pnor),
+                                   &error_abort);
+
+    /* Install the HIOMAP protocol handlers to access the PNOR */
+    ipmi_sim_register_netfn(IPMI_BMC_SIMULATOR(bmc), IPMI_NETFN_OEM,
+                            &hiomap_netfn);
+}
+
 /*
  * Instantiate the machine BMC. PowerNV uses the QEMU internal
  * simulator but it could also be external.
@@ -232,3 +244,36 @@ IPMIBmc *pnv_bmc_create(PnvPnor *pnor)
=20
     return IPMI_BMC(obj);
 }
+
+typedef struct ForeachArgs {
+    const char *name;
+    Object *obj;
+} ForeachArgs;
+
+static int bmc_find(Object *child, void *opaque)
+{
+    ForeachArgs *args =3D opaque;
+
+    if (object_dynamic_cast(child, args->name)) {
+        if (args->obj) {
+            return 1;
+        }
+        args->obj =3D child;
+    }
+    return 0;
+}
+
+IPMIBmc *pnv_bmc_find(Error **errp)
+{
+    ForeachArgs args =3D { TYPE_IPMI_BMC_SIMULATOR, NULL };
+    int ret;
+
+    ret =3D object_child_foreach_recursive(object_get_root(), bmc_find, =
&args);
+    if (ret) {
+        error_setg(errp, "machine should have only one BMC device. "
+                   "Use '-nodefaults'");
+        return NULL;
+    }
+
+    return args.obj ? IPMI_BMC(args.obj) : NULL;
+}
--=20
2.25.1



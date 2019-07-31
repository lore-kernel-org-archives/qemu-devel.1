Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A74EC32751
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 14:18:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4E5220449
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 14:18:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4E5220449
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hspQc-0008Pg-2q
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 10:18:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34154)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <clg@kaod.org>) id 1hspLx-0007LN-K9
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 10:13:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1hspLw-0001ke-Be
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 10:13:17 -0400
Received: from 2.mo177.mail-out.ovh.net ([178.33.109.80]:57891)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1hspLw-0001jc-4t
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 10:13:16 -0400
Received: from player715.ha.ovh.net (unknown [10.109.146.50])
 by mo177.mail-out.ovh.net (Postfix) with ESMTP id 64A87106430
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 16:13:14 +0200 (CEST)
Received: from kaod.org (lfbn-1-2240-157.w90-76.abo.wanadoo.fr [90.76.60.157])
 (Authenticated sender: clg@kaod.org)
 by player715.ha.ovh.net (Postfix) with ESMTPSA id EF99B850B8AC;
 Wed, 31 Jul 2019 14:13:08 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 31 Jul 2019 16:12:19 +0200
Message-Id: <20190731141233.1340-5-clg@kaod.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190731141233.1340-1-clg@kaod.org>
References: <20190731141233.1340-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 11671641387786210278
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrleehgdejfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 178.33.109.80
Subject: [Qemu-devel] [PATCH v3 04/18] ppc/pnv: Implement the XiveFabric and
 XivePresenter interfaces
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

The CAM line matching on the PowerNV machine now scans all chips of
the system and all CPUs of a chip to find a dispatched NVT in the
thread contexts.

As there is now easy way to loop on the CPUs belonging to a chip, the
PowerNV handler loops on all CPUs and filter out the external CPUs.

Fixes: af53dbf6227a ("ppc/xive: introduce a simplified XIVE presenter")
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/intc/pnv_xive.c | 76 ++++++++++++++++++++++++++++++++++++++++++++++
 hw/ppc/pnv.c       | 32 +++++++++++++++++++
 2 files changed, 108 insertions(+)

diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
index ff1226485983..183798b81496 100644
--- a/hw/intc/pnv_xive.c
+++ b/hw/intc/pnv_xive.c
@@ -390,6 +390,80 @@ static int pnv_xive_get_eas(XiveRouter *xrtr, uint8_=
t blk, uint32_t idx,
     return pnv_xive_vst_read(xive, VST_TSEL_IVT, blk, idx, eas);
 }
=20
+static int cpu_pir(PowerPCCPU *cpu)
+{
+    CPUPPCState *env =3D &cpu->env;
+    return env->spr_cb[SPR_PIR].default_value;
+}
+
+static int cpu_chip_id(PowerPCCPU *cpu)
+{
+    int pir =3D cpu_pir(cpu);
+    return (pir >> 8) & 0x7f;
+}
+
+static bool pnv_xive_is_cpu_enabled(PnvXive *xive, PowerPCCPU *cpu)
+{
+    int pir =3D cpu_pir(cpu);
+    int thrd_id =3D pir & 0x7f;
+
+    return xive->regs[PC_THREAD_EN_REG0 >> 3] & PPC_BIT(thrd_id);
+}
+
+static bool pnv_xive_is_ignored(PnvChip *chip, CPUState *cs)
+{
+    return chip->chip_id !=3D cpu_chip_id(POWERPC_CPU(cs));
+}
+
+#define PNV_CHIP_CPU_FOREACH(chip, cs)                                  =
\
+    CPU_FOREACH(cs)                                                     =
\
+        if (pnv_xive_is_ignored(chip, cs)) {} else
+
+static int pnv_xive_match_nvt(XivePresenter *xptr, uint8_t format,
+                              uint8_t nvt_blk, uint32_t nvt_idx,
+                              bool cam_ignore, uint8_t priority,
+                              uint32_t logic_serv, XiveTCTXMatch *match)
+{
+    PnvXive *xive =3D PNV_XIVE(xptr);
+    CPUState *cs;
+    int count =3D 0;
+
+    /*
+     * Loop on all CPUs of the machine and filter out the CPUs
+     * belonging to another chip.
+     */
+    PNV_CHIP_CPU_FOREACH(xive->chip, cs) {
+        PowerPCCPU *cpu =3D POWERPC_CPU(cs);
+        XiveTCTX *tctx =3D XIVE_TCTX(pnv_cpu_state(cpu)->intc);
+        int ring;
+
+        if (!pnv_xive_is_cpu_enabled(xive, cpu)) {
+            continue;
+        }
+
+        ring =3D xive_presenter_tctx_match(xptr, tctx, format, nvt_blk, =
nvt_idx,
+                                         cam_ignore, logic_serv);
+        /*
+         * Save the context and follow on to catch duplicates, that we
+         * don't support yet.
+         */
+        if (ring !=3D -1) {
+            if (match->tctx) {
+                qemu_log_mask(LOG_GUEST_ERROR, "XIVE: already found a "
+                              "thread context NVT %x/%x\n",
+                              nvt_blk, nvt_idx);
+                return -1;
+            }
+
+            match->ring =3D ring;
+            match->tctx =3D tctx;
+            count++;
+        }
+    }
+
+    return count;
+}
+
 static XiveTCTX *pnv_xive_get_tctx(XiveRouter *xrtr, CPUState *cs)
 {
     PowerPCCPU *cpu =3D POWERPC_CPU(cs);
@@ -1795,6 +1869,7 @@ static void pnv_xive_class_init(ObjectClass *klass,=
 void *data)
     PnvXScomInterfaceClass *xdc =3D PNV_XSCOM_INTERFACE_CLASS(klass);
     XiveRouterClass *xrc =3D XIVE_ROUTER_CLASS(klass);
     XiveNotifierClass *xnc =3D XIVE_NOTIFIER_CLASS(klass);
+    XivePresenterClass *xpc =3D XIVE_PRESENTER_CLASS(klass);
=20
     xdc->dt_xscom =3D pnv_xive_dt_xscom;
=20
@@ -1810,6 +1885,7 @@ static void pnv_xive_class_init(ObjectClass *klass,=
 void *data)
     xrc->get_tctx =3D pnv_xive_get_tctx;
=20
     xnc->notify =3D pnv_xive_notify;
+    xpc->match_nvt  =3D pnv_xive_match_nvt;
 };
=20
 static const TypeInfo pnv_xive_info =3D {
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 18602b9e9bcd..3f6796831b68 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1322,6 +1322,35 @@ static void pnv_pic_print_info(InterruptStatsProvi=
der *obj,
     }
 }
=20
+static int pnv_xive_match_nvt(XiveFabric *xfb, uint8_t format,
+                               uint8_t nvt_blk, uint32_t nvt_idx,
+                               bool cam_ignore, uint8_t priority,
+                               uint32_t logic_serv,
+                               XiveTCTXMatch *match)
+{
+    PnvMachineState *pnv =3D PNV_MACHINE(xfb);
+    int total_count =3D 0;
+    int i;
+
+    for (i =3D 0; i < pnv->num_chips; i++) {
+        Pnv9Chip *chip9 =3D PNV9_CHIP(pnv->chips[i]);
+        XivePresenter *xptr =3D XIVE_PRESENTER(&chip9->xive);
+        XivePresenterClass *xpc =3D XIVE_PRESENTER_GET_CLASS(xptr);
+        int count;
+
+        count =3D xpc->match_nvt(xptr, format, nvt_blk, nvt_idx, cam_ign=
ore,
+                               priority, logic_serv, match);
+
+        if (count < 0) {
+            return count;
+        }
+
+        total_count +=3D count;
+    }
+
+    return total_count;
+}
+
 static void pnv_get_num_chips(Object *obj, Visitor *v, const char *name,
                               void *opaque, Error **errp)
 {
@@ -1385,9 +1414,11 @@ static void pnv_machine_power8_class_init(ObjectCl=
ass *oc, void *data)
 static void pnv_machine_power9_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc =3D MACHINE_CLASS(oc);
+    XiveFabricClass *xfc =3D XIVE_FABRIC_CLASS(oc);
=20
     mc->desc =3D "IBM PowerNV (Non-Virtualized) POWER9";
     mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("power9_v2.0");
+    xfc->match_nvt =3D pnv_xive_match_nvt;
=20
     mc->alias =3D "powernv";
 }
@@ -1435,6 +1466,7 @@ static void pnv_machine_class_init(ObjectClass *oc,=
 void *data)
         .interfaces =3D (InterfaceInfo[]) {               \
             { TYPE_XICS_FABRIC },                       \
             { TYPE_INTERRUPT_STATS_PROVIDER },          \
+            { TYPE_XIVE_FABRIC },                       \
             { },                                        \
         },                                              \
     }
--=20
2.21.0



Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B2BAC32751
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 14:16:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34E27206A3
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 14:16:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34E27206A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hspOn-0003Ok-CJ
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 10:16:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34231)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <clg@kaod.org>) id 1hspM3-0007fM-ON
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 10:13:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1hspM2-0001q0-84
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 10:13:23 -0400
Received: from 7.mo7.mail-out.ovh.net ([46.105.43.131]:44663)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1hspM1-0001ok-W5
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 10:13:22 -0400
Received: from player715.ha.ovh.net (unknown [10.109.143.209])
 by mo7.mail-out.ovh.net (Postfix) with ESMTP id B993712BDED
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 16:13:20 +0200 (CEST)
Received: from kaod.org (lfbn-1-2240-157.w90-76.abo.wanadoo.fr [90.76.60.157])
 (Authenticated sender: clg@kaod.org)
 by player715.ha.ovh.net (Postfix) with ESMTPSA id 564BB850B92A;
 Wed, 31 Jul 2019 14:13:14 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 31 Jul 2019 16:12:20 +0200
Message-Id: <20190731141233.1340-6-clg@kaod.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190731141233.1340-1-clg@kaod.org>
References: <20190731141233.1340-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 11673330235673971686
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrleehgdejvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.43.131
Subject: [Qemu-devel] [PATCH v3 05/18] ppc/spapr: Implement the XiveFabric
 and XivePresenter interfaces
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

The CAM line matching sequence in the pseries machine does not change
much apart from the use of the new QOM interfaces.

Fixes: af53dbf6227a ("ppc/xive: introduce a simplified XIVE presenter")
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/ppc/spapr_irq.h |  6 ++++++
 hw/intc/spapr_xive.c       | 41 ++++++++++++++++++++++++++++++++++++++
 hw/ppc/spapr.c             | 34 +++++++++++++++++++++++++++++++
 hw/ppc/spapr_irq.c         | 25 +++++++++++++++++++++++
 4 files changed, 106 insertions(+)

diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
index f965a58f8954..8c99b0680f97 100644
--- a/include/hw/ppc/spapr_irq.h
+++ b/include/hw/ppc/spapr_irq.h
@@ -30,6 +30,8 @@ int spapr_irq_msi_alloc(SpaprMachineState *spapr, uint3=
2_t num, bool align,
 void spapr_irq_msi_free(SpaprMachineState *spapr, int irq, uint32_t num)=
;
 void spapr_irq_msi_reset(SpaprMachineState *spapr);
=20
+struct XiveTCTXMatch;
+
 typedef struct SpaprIrq {
     uint32_t    nr_irqs;
     uint32_t    nr_msis;
@@ -49,6 +51,10 @@ typedef struct SpaprIrq {
     void (*set_irq)(void *opaque, int srcno, int val);
     const char *(*get_nodename)(SpaprMachineState *spapr);
     void (*init_kvm)(SpaprMachineState *spapr, Error **errp);
+    int (*match_nvt)(SpaprMachineState *spapr, uint8_t format,
+                     uint8_t nvt_blk, uint32_t nvt_idx,
+                     bool cam_ignore, uint8_t priority,
+                     uint32_t logic_serv, struct XiveTCTXMatch *match);
 } SpaprIrq;
=20
 extern SpaprIrq spapr_irq_xics;
diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index ba012c7b0fdc..beb5049ad9da 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -419,6 +419,44 @@ static XiveTCTX *spapr_xive_get_tctx(XiveRouter *xrt=
r, CPUState *cs)
     return spapr_cpu_state(cpu)->tctx;
 }
=20
+static int spapr_xive_match_nvt(XivePresenter *xptr, uint8_t format,
+                                uint8_t nvt_blk, uint32_t nvt_idx,
+                                bool cam_ignore, uint8_t priority,
+                                uint32_t logic_serv, XiveTCTXMatch *matc=
h)
+{
+    CPUState *cs;
+    int count =3D 0;
+
+    CPU_FOREACH(cs) {
+        PowerPCCPU *cpu =3D POWERPC_CPU(cs);
+        XiveTCTX *tctx =3D spapr_cpu_state(cpu)->tctx;
+        int ring;
+
+        /*
+         * Check the thread context CAM lines and record matches.
+         */
+        ring =3D xive_presenter_tctx_match(xptr, tctx, format, nvt_blk, =
nvt_idx,
+                                         cam_ignore, logic_serv);
+        /*
+         * Save the matching thread interrupt context and follow on to
+         * check for duplicates which are invalid.
+         */
+        if (ring !=3D -1) {
+            if (match->tctx) {
+                qemu_log_mask(LOG_GUEST_ERROR, "XIVE: already found a th=
read "
+                              "context NVT %x/%x\n", nvt_blk, nvt_idx);
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
 static const VMStateDescription vmstate_spapr_xive_end =3D {
     .name =3D TYPE_SPAPR_XIVE "/end",
     .version_id =3D 1,
@@ -496,6 +534,7 @@ static void spapr_xive_class_init(ObjectClass *klass,=
 void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(klass);
     XiveRouterClass *xrc =3D XIVE_ROUTER_CLASS(klass);
+    XivePresenterClass *xpc =3D XIVE_PRESENTER_CLASS(klass);
=20
     dc->desc    =3D "sPAPR XIVE Interrupt Controller";
     dc->props   =3D spapr_xive_properties;
@@ -508,6 +547,8 @@ static void spapr_xive_class_init(ObjectClass *klass,=
 void *data)
     xrc->get_nvt =3D spapr_xive_get_nvt;
     xrc->write_nvt =3D spapr_xive_write_nvt;
     xrc->get_tctx =3D spapr_xive_get_tctx;
+
+    xpc->match_nvt  =3D spapr_xive_match_nvt;
 }
=20
 static const TypeInfo spapr_xive_info =3D {
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 115bbfb0e788..631db719f41f 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4302,6 +4302,37 @@ static void spapr_pic_print_info(InterruptStatsPro=
vider *obj,
     spapr->irq->print_info(spapr, mon);
 }
=20
+static int spapr_xive_match_nvt(XiveFabric *xfb, uint8_t format,
+                                uint8_t nvt_blk, uint32_t nvt_idx,
+                                bool cam_ignore, uint8_t priority,
+                                uint32_t logic_serv, XiveTCTXMatch *matc=
h)
+{
+    SpaprMachineState *spapr =3D SPAPR_MACHINE(xfb);
+    int count;
+
+    count =3D spapr->irq->match_nvt(spapr, format, nvt_blk, nvt_idx, cam=
_ignore,
+                                  priority, logic_serv, match);
+    if (count < 0) {
+        return count;
+    }
+
+    /*
+     * When we implement the save and restore of the thread interrupt
+     * contexts in the enter/exit CPU handlers of the machine and the
+     * escalations in QEMU, we should be able to handle non dispatched
+     * vCPUs.
+     *
+     * Until this is done, the sPAPR machine should find at least one
+     * matching context always.
+     */
+    if (count =3D=3D 0) {
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: NVT %x/%x is not dispatche=
d\n",
+                      nvt_blk, nvt_idx);
+    }
+
+    return count;
+}
+
 int spapr_get_vcpu_id(PowerPCCPU *cpu)
 {
     return cpu->vcpu_id;
@@ -4398,6 +4429,7 @@ static void spapr_machine_class_init(ObjectClass *o=
c, void *data)
     PPCVirtualHypervisorClass *vhc =3D PPC_VIRTUAL_HYPERVISOR_CLASS(oc);
     XICSFabricClass *xic =3D XICS_FABRIC_CLASS(oc);
     InterruptStatsProviderClass *ispc =3D INTERRUPT_STATS_PROVIDER_CLASS=
(oc);
+    XiveFabricClass *xfc =3D XIVE_FABRIC_CLASS(oc);
=20
     mc->desc =3D "pSeries Logical Partition (PAPR compliant)";
     mc->ignore_boot_device_suffixes =3D true;
@@ -4456,6 +4488,7 @@ static void spapr_machine_class_init(ObjectClass *o=
c, void *data)
      */
     mc->numa_mem_align_shift =3D 28;
     mc->numa_mem_supported =3D true;
+    xfc->match_nvt =3D spapr_xive_match_nvt;
=20
     smc->default_caps.caps[SPAPR_CAP_HTM] =3D SPAPR_CAP_OFF;
     smc->default_caps.caps[SPAPR_CAP_VSX] =3D SPAPR_CAP_ON;
@@ -4488,6 +4521,7 @@ static const TypeInfo spapr_machine_info =3D {
         { TYPE_PPC_VIRTUAL_HYPERVISOR },
         { TYPE_XICS_FABRIC },
         { TYPE_INTERRUPT_STATS_PROVIDER },
+        { TYPE_XIVE_FABRIC },
         { }
     },
 };
diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index ff3df0bbd8cf..ff824d950f05 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -262,6 +262,7 @@ SpaprIrq spapr_irq_xics =3D {
     .set_irq     =3D spapr_irq_set_irq_xics,
     .get_nodename =3D spapr_irq_get_nodename_xics,
     .init_kvm    =3D spapr_irq_init_kvm_xics,
+    .match_nvt   =3D NULL, /* should not be used */
 };
=20
 /*
@@ -411,6 +412,18 @@ static void spapr_irq_init_kvm_xive(SpaprMachineStat=
e *spapr, Error **errp)
     }
 }
=20
+static int spapr_irq_match_nvt_xive(SpaprMachineState *spapr, uint8_t fo=
rmat,
+                                    uint8_t nvt_blk, uint32_t nvt_idx,
+                                    bool cam_ignore, uint8_t priority,
+                                    uint32_t logic_serv, XiveTCTXMatch *=
match)
+{
+    XivePresenter *xptr =3D XIVE_PRESENTER(spapr->xive);
+    XivePresenterClass *xpc =3D XIVE_PRESENTER_GET_CLASS(xptr);
+
+    return xpc->match_nvt(xptr, format, nvt_blk, nvt_idx, cam_ignore,
+                          priority, logic_serv, match);
+}
+
 /*
  * XIVE uses the full IRQ number space. Set it to 8K to be compatible
  * with XICS.
@@ -436,6 +449,7 @@ SpaprIrq spapr_irq_xive =3D {
     .set_irq     =3D spapr_irq_set_irq_xive,
     .get_nodename =3D spapr_irq_get_nodename_xive,
     .init_kvm    =3D spapr_irq_init_kvm_xive,
+    .match_nvt   =3D spapr_irq_match_nvt_xive,
 };
=20
 /*
@@ -590,6 +604,15 @@ static const char *spapr_irq_get_nodename_dual(Spapr=
MachineState *spapr)
     return spapr_irq_current(spapr)->get_nodename(spapr);
 }
=20
+static int spapr_irq_match_nvt_dual(SpaprMachineState *spapr, uint8_t fo=
rmat,
+                                    uint8_t nvt_blk, uint32_t nvt_idx,
+                                    bool cam_ignore, uint8_t priority,
+                                    uint32_t logic_serv, XiveTCTXMatch *=
match)
+{
+    return spapr_irq_current(spapr)->match_nvt(spapr, format, nvt_blk, n=
vt_idx,
+                                     cam_ignore, priority, logic_serv, m=
atch);
+}
+
 /*
  * Define values in sync with the XIVE and XICS backend
  */
@@ -613,6 +636,7 @@ SpaprIrq spapr_irq_dual =3D {
     .set_irq     =3D spapr_irq_set_irq_dual,
     .get_nodename =3D spapr_irq_get_nodename_dual,
     .init_kvm    =3D NULL, /* should not be used */
+    .match_nvt   =3D spapr_irq_match_nvt_dual,
 };
=20
=20
@@ -828,4 +852,5 @@ SpaprIrq spapr_irq_xics_legacy =3D {
     .set_irq     =3D spapr_irq_set_irq_xics,
     .get_nodename =3D spapr_irq_get_nodename_xics,
     .init_kvm    =3D spapr_irq_init_kvm_xics,
+    .match_nvt   =3D NULL, /* should not be used */
 };
--=20
2.21.0



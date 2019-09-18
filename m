Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53C56C4CEC4
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 17:26:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AB8E21907
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 17:26:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AB8E21907
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAdib-0004Xv-La
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 13:26:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55674)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iAcUk-0003zw-LR
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 12:07:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iAcUj-0003D8-29
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 12:07:54 -0400
Received: from 2.mo173.mail-out.ovh.net ([178.33.251.49]:46029)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iAcUi-0003C5-TI
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 12:07:53 -0400
Received: from player799.ha.ovh.net (unknown [10.109.160.253])
 by mo173.mail-out.ovh.net (Postfix) with ESMTP id 67D5C119FF0
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2019 18:07:51 +0200 (CEST)
Received: from kaod.org (lfbn-1-2240-157.w90-76.abo.wanadoo.fr [90.76.60.157])
 (Authenticated sender: clg@kaod.org)
 by player799.ha.ovh.net (Postfix) with ESMTPSA id CC2B39F0E68D;
 Wed, 18 Sep 2019 16:07:45 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 18 Sep 2019 18:06:30 +0200
Message-Id: <20190918160645.25126-11-clg@kaod.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190918160645.25126-1-clg@kaod.org>
References: <20190918160645.25126-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 6221441411813182438
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudekgdeliecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 178.33.251.49
Subject: [Qemu-devel] [PATCH v4 10/25] ppc/pnv: Clarify how the TIMA is
 accessed on a multichip system
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
 qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The TIMA MMIO space is shared among the chips. To identify the chip
from which the access is being done, the PowerBUS uses a 'chip' field
in the load/store messages. QEMU does not model these messages,
instead, we extract the chip id from the CPU PIR and do a lookup at
the machine level to fetch the targeted interrupt controller.

Introduce pnv_get_chip() and pnv_xive_tm_get_xive() helpers to clarify
this process in pnv_xive_get_tctx(). The latter will be removed in the
subsequent patches but the same principle will be kept.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/ppc/pnv.h | 13 +++++++++++++
 hw/intc/pnv_xive.c   | 40 +++++++++++++++++++++++-----------------
 2 files changed, 36 insertions(+), 17 deletions(-)

diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index 1cdbe55bf86c..5e01a9f3df95 100644
--- a/include/hw/ppc/pnv.h
+++ b/include/hw/ppc/pnv.h
@@ -185,6 +185,19 @@ static inline bool pnv_is_power9(PnvMachineState *pn=
v)
     return pnv_chip_is_power9(pnv->chips[0]);
 }
=20
+static inline PnvChip *pnv_get_chip(PnvMachineState *pnv, uint32_t chip_=
id)
+{
+    int i;
+
+    for (i =3D 0; i < pnv->num_chips; i++) {
+        PnvChip *chip =3D pnv->chips[i];
+        if (chip->chip_id =3D=3D chip_id) {
+            return chip;
+        }
+    }
+    return NULL;
+}
+
 #define PNV_FDT_ADDR          0x01000000
 #define PNV_TIMEBASE_FREQ     512000000ULL
=20
diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
index 5c9483b394ab..3d6fcf9ac139 100644
--- a/hw/intc/pnv_xive.c
+++ b/hw/intc/pnv_xive.c
@@ -464,31 +464,37 @@ static int pnv_xive_match_nvt(XivePresenter *xptr, =
uint8_t format,
     return count;
 }
=20
+/*
+ * The TIMA MMIO space is shared among the chips and to identify the
+ * chip from which the access is being done, we extract the chip id
+ * from the PIR.
+ */
+static PnvXive *pnv_xive_tm_get_xive(PowerPCCPU *cpu)
+{
+    PnvMachineState *pnv =3D PNV_MACHINE(qdev_get_machine());
+    PnvChip *chip;
+    PnvXive *xive;
+
+    chip =3D pnv_get_chip(pnv, cpu_chip_id(cpu));
+    assert(chip);
+    xive =3D &PNV9_CHIP(chip)->xive;
+
+    if (!pnv_xive_is_cpu_enabled(xive, cpu)) {
+        xive_error(xive, "IC: CPU %x is not enabled", cpu_pir(cpu));
+    }
+    return xive;
+}
+
 static XiveTCTX *pnv_xive_get_tctx(XiveRouter *xrtr, CPUState *cs)
 {
     PowerPCCPU *cpu =3D POWERPC_CPU(cs);
-    XiveTCTX *tctx =3D XIVE_TCTX(pnv_cpu_state(cpu)->intc);
-    PnvXive *xive =3D NULL;
-    CPUPPCState *env =3D &cpu->env;
-    int pir =3D env->spr_cb[SPR_PIR].default_value;
+    PnvXive *xive =3D pnv_xive_tm_get_xive(cpu);
=20
-    /*
-     * Perform an extra check on the HW thread enablement.
-     *
-     * The TIMA is shared among the chips and to identify the chip
-     * from which the access is being done, we extract the chip id
-     * from the PIR.
-     */
-    xive =3D pnv_xive_get_ic((pir >> 8) & 0xf);
     if (!xive) {
         return NULL;
     }
=20
-    if (!(xive->regs[PC_THREAD_EN_REG0 >> 3] & PPC_BIT(pir & 0x3f))) {
-        xive_error(PNV_XIVE(xrtr), "IC: CPU %x is not enabled", pir);
-    }
-
-    return tctx;
+    return XIVE_TCTX(pnv_cpu_state(cpu)->intc);
 }
=20
 /*
--=20
2.21.0



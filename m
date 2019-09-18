Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF62DC4CEC4
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 17:12:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94FD120665
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 17:12:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94FD120665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAdVe-0000JD-ER
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 13:12:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55454)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iAcU6-00033v-W6
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 12:07:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iAcU5-0002dp-PO
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 12:07:14 -0400
Received: from 7.mo2.mail-out.ovh.net ([188.165.48.182]:56539)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iAcU5-0002dM-Jq
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 12:07:13 -0400
Received: from player799.ha.ovh.net (unknown [10.108.54.87])
 by mo2.mail-out.ovh.net (Postfix) with ESMTP id 42AAC1AD3AC
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2019 18:07:12 +0200 (CEST)
Received: from kaod.org (lfbn-1-2240-157.w90-76.abo.wanadoo.fr [90.76.60.157])
 (Authenticated sender: clg@kaod.org)
 by player799.ha.ovh.net (Postfix) with ESMTPSA id 4E7869F0E3C3;
 Wed, 18 Sep 2019 16:07:06 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 18 Sep 2019 18:06:23 +0200
Message-Id: <20190918160645.25126-4-clg@kaod.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190918160645.25126-1-clg@kaod.org>
References: <20190918160645.25126-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 6210463888279636966
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudekgdeljecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 188.165.48.182
Subject: [Qemu-devel] [PATCH v4 03/25] ppc/pnv: Introduce a
 PNV_CHIP_CPU_FOREACH() helper
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

As there is now easy way to loop on the CPUs belonging to a chip, add
a helper to filter out external CPUs.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/intc/pnv_xive.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
index ae449aa1119b..e1c15b6b5b71 100644
--- a/hw/intc/pnv_xive.c
+++ b/hw/intc/pnv_xive.c
@@ -392,15 +392,36 @@ static int pnv_xive_get_eas(XiveRouter *xrtr, uint8=
_t blk, uint32_t idx,
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
+#define PNV_CHIP_CPU_FOREACH(chip, cs)                                  =
\
+    CPU_FOREACH(cs)                                                     =
\
+        if (chip->chip_id !=3D cpu_chip_id(POWERPC_CPU(cs))) {} else
+
 static int pnv_xive_match_nvt(XivePresenter *xptr, uint8_t format,
                               uint8_t nvt_blk, uint32_t nvt_idx,
                               bool cam_ignore, uint8_t priority,
                               uint32_t logic_serv, XiveTCTXMatch *match)
 {
+    PnvXive *xive =3D PNV_XIVE(xptr);
     CPUState *cs;
     int count =3D 0;
=20
-    CPU_FOREACH(cs) {
+    /*
+     * Loop on all CPUs of the machine and filter out the CPUs
+     * belonging to another chip.
+     */
+    PNV_CHIP_CPU_FOREACH(xive->chip, cs) {
         PowerPCCPU *cpu =3D POWERPC_CPU(cs);
         XiveTCTX *tctx =3D XIVE_TCTX(pnv_cpu_state(cpu)->intc);
         int ring;
--=20
2.21.0



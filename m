Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28137C432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 16:37:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1B0A20718
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 16:37:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1B0A20718
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVeah-0004WM-Gx
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 11:36:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52307)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iVePw-0000JT-Ra
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 11:25:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iVePv-0000v9-Ix
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 11:25:52 -0500
Received: from 2.mo2.mail-out.ovh.net ([188.165.53.149]:42564)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iVePv-0000uE-D5
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 11:25:51 -0500
Received: from player787.ha.ovh.net (unknown [10.108.35.215])
 by mo2.mail-out.ovh.net (Postfix) with ESMTP id B32F11B0D3B
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2019 17:25:49 +0100 (CET)
Received: from kaod.org (lfbn-1-2229-223.w90-76.abo.wanadoo.fr [90.76.50.223])
 (Authenticated sender: clg@kaod.org)
 by player787.ha.ovh.net (Postfix) with ESMTPSA id 43694C444AC3;
 Fri, 15 Nov 2019 16:25:44 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH for-5.0 v5 11/23] ppc/pnv: Introduce a
 pnv_xive_is_cpu_enabled() helper
Date: Fri, 15 Nov 2019 17:24:24 +0100
Message-Id: <20191115162436.30548-12-clg@kaod.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191115162436.30548-1-clg@kaod.org>
References: <20191115162436.30548-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 15099725128657046502
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudefhedgkeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdqfffguegfifdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepveorughrihgtucfnvgcuifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpledtrdejiedrhedtrddvvdefnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejkeejrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpedv
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 188.165.53.149
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

and use this helper to exclude CPUs which are not enabled in the XIVE
controller.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/intc/pnv_xive.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
index 71ca4961b6b1..4c8c6e51c20f 100644
--- a/hw/intc/pnv_xive.c
+++ b/hw/intc/pnv_xive.c
@@ -372,6 +372,20 @@ static int pnv_xive_get_eas(XiveRouter *xrtr, uint8_=
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
+static bool pnv_xive_is_cpu_enabled(PnvXive *xive, PowerPCCPU *cpu)
+{
+    int pir =3D cpu_pir(cpu);
+    int thrd_id =3D pir & 0x7f;
+
+    return xive->regs[PC_THREAD_EN_REG0 >> 3] & PPC_BIT(thrd_id);
+}
+
 static int pnv_xive_match_nvt(XivePresenter *xptr, uint8_t format,
                               uint8_t nvt_blk, uint32_t nvt_idx,
                               bool cam_ignore, uint8_t priority,
@@ -393,6 +407,10 @@ static int pnv_xive_match_nvt(XivePresenter *xptr, u=
int8_t format,
             XiveTCTX *tctx;
             int ring;
=20
+            if (!pnv_xive_is_cpu_enabled(xive, cpu)) {
+                continue;
+            }
+
             tctx =3D XIVE_TCTX(pnv_cpu_state(cpu)->intc);
=20
             /*
--=20
2.21.0



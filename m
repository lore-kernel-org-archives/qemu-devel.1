Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF72CA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 17:17:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A6FF20679
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 17:17:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A6FF20679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMxmT-0001n6-IH
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 13:17:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41353)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iMxC9-0001oX-Oz
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 12:39:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iMxC8-0006wl-KX
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 12:39:41 -0400
Received: from 13.mo1.mail-out.ovh.net ([178.33.253.128]:50397)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iMxC8-0006wO-EO
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 12:39:40 -0400
Received: from player688.ha.ovh.net (unknown [10.108.54.52])
 by mo1.mail-out.ovh.net (Postfix) with ESMTP id C36CD1917CE
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 18:39:38 +0200 (CEST)
Received: from kaod.org (lfbn-1-2229-223.w90-76.abo.wanadoo.fr [90.76.50.223])
 (Authenticated sender: clg@kaod.org)
 by player688.ha.ovh.net (Postfix) with ESMTPSA id 350F3B32C42C;
 Tue, 22 Oct 2019 16:39:30 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH v5 6/7] ppc/pnv: Fix naming of routines realizing the CPUs
Date: Tue, 22 Oct 2019 18:38:11 +0200
Message-Id: <20191022163812.330-7-clg@kaod.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191022163812.330-1-clg@kaod.org>
References: <20191022163812.330-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 3515622459560856550
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrkeejgddutdefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 178.33.253.128
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The 'vcpu' suffix is inherited from the sPAPR machine. Use better
names for PowerNV.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/pnv_core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index be0310ac0340..e81cd3a3e047 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -162,7 +162,7 @@ static const MemoryRegionOps pnv_core_power9_xscom_op=
s =3D {
     .endianness =3D DEVICE_BIG_ENDIAN,
 };
=20
-static void pnv_realize_vcpu(PowerPCCPU *cpu, PnvChip *chip, Error **err=
p)
+static void pnv_core_cpu_realize(PowerPCCPU *cpu, PnvChip *chip, Error *=
*errp)
 {
     CPUPPCState *env =3D &cpu->env;
     int core_pir;
@@ -247,7 +247,7 @@ static void pnv_core_realize(DeviceState *dev, Error =
**errp)
     }
=20
     for (j =3D 0; j < cc->nr_threads; j++) {
-        pnv_realize_vcpu(pc->threads[j], pc->chip, &local_err);
+        pnv_core_cpu_realize(pc->threads[j], pc->chip, &local_err);
         if (local_err) {
             goto err;
         }
@@ -269,7 +269,7 @@ err:
     error_propagate(errp, local_err);
 }
=20
-static void pnv_unrealize_vcpu(PowerPCCPU *cpu)
+static void pnv_core_cpu_unrealize(PowerPCCPU *cpu)
 {
     PnvCPUState *pnv_cpu =3D pnv_cpu_state(cpu);
=20
@@ -289,7 +289,7 @@ static void pnv_core_unrealize(DeviceState *dev, Erro=
r **errp)
     qemu_unregister_reset(pnv_core_reset, pc);
=20
     for (i =3D 0; i < cc->nr_threads; i++) {
-        pnv_unrealize_vcpu(pc->threads[i]);
+        pnv_core_cpu_unrealize(pc->threads[i]);
     }
     g_free(pc->threads);
 }
--=20
2.21.0



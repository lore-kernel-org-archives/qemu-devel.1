Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B01F9C33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 15:28:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86232207FD
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 15:28:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86232207FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioUJ0-0007um-TY
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 10:28:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50017)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1ioTpM-0001KF-QU
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 09:57:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1ioTpL-0001IV-NC
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 09:57:56 -0500
Received: from 4.mo4.mail-out.ovh.net ([178.32.98.131]:55607)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1ioTpL-0001HN-Hr
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 09:57:55 -0500
Received: from player731.ha.ovh.net (unknown [10.108.35.13])
 by mo4.mail-out.ovh.net (Postfix) with ESMTP id C5F1C21DBC7
 for <qemu-devel@nongnu.org>; Mon,  6 Jan 2020 15:57:53 +0100 (CET)
Received: from kaod.org (deibp9eh1--blueice1n4.emea.ibm.com [195.212.29.166])
 (Authenticated sender: clg@kaod.org)
 by player731.ha.ovh.net (Postfix) with ESMTPSA id 02753DB3A84E;
 Mon,  6 Jan 2020 14:57:47 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH v3 10/12] pnv/xive: Deduce the PnvXive pointer from
 XiveTCTX::xptr
Date: Mon,  6 Jan 2020 15:56:43 +0100
Message-Id: <20200106145645.4539-11-clg@kaod.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200106145645.4539-1-clg@kaod.org>
References: <20200106145645.4539-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 5400097432419470310
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrvdehtddgjedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepveorughrihgtucfnvgcuifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpudelhedrvdduvddrvdelrdduieeinecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejfedurdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpedt
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 178.32.98.131
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

From: Greg Kurz <groug@kaod.org>

And use it instead of reaching out to the machine. This allows to get
rid of pnv_get_chip().

Signed-off-by: Greg Kurz <groug@kaod.org>
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/ppc/pnv.h |  2 --
 hw/intc/pnv_xive.c   |  8 ++------
 hw/ppc/pnv.c         | 14 --------------
 3 files changed, 2 insertions(+), 22 deletions(-)

diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index 2504d8cd4f6b..d65dd32036c8 100644
--- a/include/hw/ppc/pnv.h
+++ b/include/hw/ppc/pnv.h
@@ -219,8 +219,6 @@ struct PnvMachineState {
     PnvPnor      *pnor;
 };
=20
-PnvChip *pnv_get_chip(uint32_t chip_id);
-
 #define PNV_FDT_ADDR          0x01000000
 #define PNV_TIMEBASE_FREQ     512000000ULL
=20
diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
index 6412cf222eae..715fca61ae22 100644
--- a/hw/intc/pnv_xive.c
+++ b/hw/intc/pnv_xive.c
@@ -472,12 +472,8 @@ static uint8_t pnv_xive_get_block_id(XiveRouter *xrt=
r)
 static PnvXive *pnv_xive_tm_get_xive(PowerPCCPU *cpu)
 {
     int pir =3D ppc_cpu_pir(cpu);
-    PnvChip *chip;
-    PnvXive *xive;
-
-    chip =3D pnv_get_chip(PNV9_PIR2CHIP(pir));
-    assert(chip);
-    xive =3D &PNV9_CHIP(chip)->xive;
+    XivePresenter *xptr =3D XIVE_TCTX(pnv_cpu_state(cpu)->intc)->xptr;
+    PnvXive *xive =3D PNV_XIVE(xptr);
=20
     if (!pnv_xive_is_cpu_enabled(xive, cpu)) {
         xive_error(xive, "IC: CPU %x is not enabled", pir);
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index de44c7ddb304..924b8dc592fe 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1705,20 +1705,6 @@ static int pnv_match_nvt(XiveFabric *xfb, uint8_t =
format,
     return total_count;
 }
=20
-PnvChip *pnv_get_chip(uint32_t chip_id)
-{
-    PnvMachineState *pnv =3D PNV_MACHINE(qdev_get_machine());
-    int i;
-
-    for (i =3D 0; i < pnv->num_chips; i++) {
-        PnvChip *chip =3D pnv->chips[i];
-        if (chip->chip_id =3D=3D chip_id) {
-            return chip;
-        }
-    }
-    return NULL;
-}
-
 static void pnv_get_num_chips(Object *obj, Visitor *v, const char *name,
                               void *opaque, Error **errp)
 {
--=20
2.21.1



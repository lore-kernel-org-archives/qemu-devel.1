Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9002AC32751
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 14:20:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6596320449
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 14:20:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6596320449
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hspT6-0007Gr-Lr
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 10:20:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34651)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <clg@kaod.org>) id 1hspMu-0001T2-O8
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 10:14:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1hspMt-0002Sy-JA
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 10:14:16 -0400
Received: from 8.mo6.mail-out.ovh.net ([178.33.42.204]:42711)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1hspMs-0002RJ-Sh
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 10:14:15 -0400
Received: from player715.ha.ovh.net (unknown [10.109.146.50])
 by mo6.mail-out.ovh.net (Postfix) with ESMTP id 26EF91D9F1A
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 16:14:13 +0200 (CEST)
Received: from kaod.org (lfbn-1-2240-157.w90-76.abo.wanadoo.fr [90.76.60.157])
 (Authenticated sender: clg@kaod.org)
 by player715.ha.ovh.net (Postfix) with ESMTPSA id C0F3F850BC8B;
 Wed, 31 Jul 2019 14:14:07 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 31 Jul 2019 16:12:29 +0200
Message-Id: <20190731141233.1340-15-clg@kaod.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190731141233.1340-1-clg@kaod.org>
References: <20190731141233.1340-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 11688248408967384038
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrleehgdejfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 178.33.42.204
Subject: [Qemu-devel] [PATCH v3 14/18] ppc/pnv: Skip empty slots of the XIVE
 NVT table
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

We try to loop on the full table skipping empty indirect pages which
are not necessarily allocated. This is useful to dump the contexts of
the KVM vCPUs.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/intc/pnv_xive.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
index 849291ee683e..84fbfd8e27b0 100644
--- a/hw/intc/pnv_xive.c
+++ b/hw/intc/pnv_xive.c
@@ -1641,6 +1641,12 @@ static const MemoryRegionOps pnv_xive_pc_ops =3D {
     },
 };
=20
+/*
+ * skiboot uses an indirect NVT table with 64k subpages
+ */
+#define XIVE_NVT_COUNT          (1 << XIVE_NVT_SHIFT)
+#define XIVE_NVT_PER_PAGE       (0x10000 / sizeof(XiveNVT))
+
 static void xive_nvt_pic_print_info(XiveNVT *nvt, uint32_t nvt_idx,
                                     Monitor *mon)
 {
@@ -1694,10 +1700,12 @@ void pnv_xive_pic_print_info(PnvXive *xive, Monit=
or *mon)
         xive_end_eas_pic_print_info(&end, i++, mon);
     }
=20
-    monitor_printf(mon, "XIVE[%x] NVTT\n", blk);
-    i =3D 0;
-    while (!xive_router_get_nvt(xrtr, blk, i, &nvt)) {
-        xive_nvt_pic_print_info(&nvt, i++, mon);
+    monitor_printf(mon, "XIVE[%x] NVTT %08x .. %08x\n", blk, 0,
+                   XIVE_NVT_COUNT - 1);
+    for (i =3D 0; i < XIVE_NVT_COUNT; i +=3D XIVE_NVT_PER_PAGE) {
+        while (!xive_router_get_nvt(xrtr, blk, i, &nvt)) {
+            xive_nvt_pic_print_info(&nvt, i++, mon);
+        }
     }
 }
=20
--=20
2.21.0



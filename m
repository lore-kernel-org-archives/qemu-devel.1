Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB23BC432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 09:20:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9470320692
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 09:20:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9470320692
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWdD1-0007YC-OO
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 04:20:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56733)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iWdC0-0006Tu-4f
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 04:19:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iWdBy-00069g-Rx
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 04:19:31 -0500
Received: from 7.mo6.mail-out.ovh.net ([46.105.59.196]:48584)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iWdBy-00063p-M7
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 04:19:30 -0500
Received: from player776.ha.ovh.net (unknown [10.108.57.183])
 by mo6.mail-out.ovh.net (Postfix) with ESMTP id 493831E3211
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2019 10:19:25 +0100 (CET)
Received: from kaod.org (lfbn-1-2229-223.w90-76.abo.wanadoo.fr [90.76.50.223])
 (Authenticated sender: clg@kaod.org)
 by player776.ha.ovh.net (Postfix) with ESMTPSA id 47570C30EEF0;
 Mon, 18 Nov 2019 09:19:20 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH] ppc/pnv: Add a LPC "ranges" property
Date: Mon, 18 Nov 2019 10:19:08 +0100
Message-Id: <20191118091908.15044-1-clg@kaod.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 7069525517583879142
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudeghedgtdefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdqfffguegfifdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffogggtgfesthekredtredtjeenucfhrhhomhepveorughrihgtucfnvgcuifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpledtrdejiedrhedtrddvvdefnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejjeeirdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpedt
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.59.196
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

And fix a typo in the MEM address space definition.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/ppc/pnv_lpc.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/pnv_lpc.c b/hw/ppc/pnv_lpc.c
index fb9f93032020..c5a85c38c783 100644
--- a/hw/ppc/pnv_lpc.c
+++ b/hw/ppc/pnv_lpc.c
@@ -86,7 +86,7 @@ enum {
 #define ISA_FW_SIZE             0x10000000
 #define LPC_IO_OPB_ADDR         0xd0010000
 #define LPC_IO_OPB_SIZE         0x00010000
-#define LPC_MEM_OPB_ADDR        0xe0010000
+#define LPC_MEM_OPB_ADDR        0xe0000000
 #define LPC_MEM_OPB_SIZE        0x10000000
 #define LPC_FW_OPB_ADDR         0xf0000000
 #define LPC_FW_OPB_SIZE         0x10000000
@@ -143,6 +143,16 @@ int pnv_dt_lpc(PnvChip *chip, void *fdt, int root_of=
fset)
                             cpu_to_be32(PNV9_LPCM_SIZE >> 32),
                             cpu_to_be32((uint32_t)PNV9_LPCM_SIZE),
     };
+    uint32_t lpc_ranges[12] =3D { 0, 0,
+                                cpu_to_be32(LPC_MEM_OPB_ADDR),
+                                cpu_to_be32(LPC_MEM_OPB_SIZE),
+                                cpu_to_be32(1), 0,
+                                cpu_to_be32(LPC_IO_OPB_ADDR),
+                                cpu_to_be32(LPC_IO_OPB_SIZE),
+                                cpu_to_be32(3), 0,
+                                cpu_to_be32(LPC_FW_OPB_ADDR),
+                                cpu_to_be32(LPC_FW_OPB_SIZE),
+    };
     uint32_t reg[2];
=20
     /*
@@ -211,6 +221,8 @@ int pnv_dt_lpc(PnvChip *chip, void *fdt, int root_off=
set)
     _FDT((fdt_setprop_cell(fdt, offset, "#size-cells", 1)));
     _FDT((fdt_setprop(fdt, offset, "compatible", lpc_compat,
                       sizeof(lpc_compat))));
+    _FDT((fdt_setprop(fdt, offset, "ranges", lpc_ranges,
+                      sizeof(lpc_ranges))));
=20
     return 0;
 }
--=20
2.21.0



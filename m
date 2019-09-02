Return-Path: <SRS0=OFvx=W5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD599C3A59B
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 09:31:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A961215EA
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 09:31:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A961215EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i4igG-00011r-Bx
	for qemu-devel@archiver.kernel.org; Mon, 02 Sep 2019 05:31:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48944)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1i4ief-0000N1-DR
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 05:29:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1i4iee-0002a7-Ea
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 05:29:45 -0400
Received: from 2.mo2.mail-out.ovh.net ([188.165.53.149]:41629)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1i4iec-0002To-B1
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 05:29:44 -0400
Received: from player714.ha.ovh.net (unknown [10.108.35.158])
 by mo2.mail-out.ovh.net (Postfix) with ESMTP id AC0431A9F76
 for <qemu-devel@nongnu.org>; Mon,  2 Sep 2019 11:29:38 +0200 (CEST)
Received: from kaod.org (lfbn-1-2240-157.w90-76.abo.wanadoo.fr [90.76.60.157])
 (Authenticated sender: clg@kaod.org)
 by player714.ha.ovh.net (Postfix) with ESMTPSA id 9A1659450851;
 Mon,  2 Sep 2019 09:29:33 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Mon,  2 Sep 2019 11:29:32 +0200
Message-Id: <20190902092932.20200-1-clg@kaod.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 16213521610154347494
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrudejtddgudeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 188.165.53.149
Subject: [Qemu-devel] [PATCH] ppc/pnv: fix "bmc" node name in DT
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

Fixes the dtc output :

ERROR (node_name_chars): //bmc: Bad character '/' in node name
Warning (avoid_unnecessary_addr_size): /bmc: unnecessary #address-cells/#=
size-cells without "ranges" or child "reg" property

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/ppc/pnv_bmc.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/hw/ppc/pnv_bmc.c b/hw/ppc/pnv_bmc.c
index e5eb6e5a70da..dc5e918cb79e 100644
--- a/hw/ppc/pnv_bmc.c
+++ b/hw/ppc/pnv_bmc.c
@@ -77,13 +77,10 @@ void pnv_dt_bmc_sensors(IPMIBmc *bmc, void *fdt)
     const struct ipmi_sdr_compact *sdr;
     uint16_t nextrec;
=20
-    offset =3D fdt_add_subnode(fdt, 0, "/bmc");
+    offset =3D fdt_add_subnode(fdt, 0, "bmc");
     _FDT(offset);
=20
     _FDT((fdt_setprop_string(fdt, offset, "name", "bmc")));
-    _FDT((fdt_setprop_cell(fdt, offset, "#address-cells", 0x1)));
-    _FDT((fdt_setprop_cell(fdt, offset, "#size-cells", 0x0)));
-
     offset =3D fdt_add_subnode(fdt, offset, "sensors");
     _FDT(offset);
=20
--=20
2.21.0



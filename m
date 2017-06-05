Received: from eggs.gnu.org ([2001:4830:134:3::10]:34797)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dHuBH-0007pl-Mo
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 11:44:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dHuBC-000741-8r
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 11:44:35 -0400
Received: from 9.mo3.mail-out.ovh.net ([87.98.184.141]:49469)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1dHuBC-00072f-2W
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 11:44:30 -0400
Received: from player158.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 5D72AEBC07
	for <qemu-devel@nongnu.org>; Mon,  5 Jun 2017 17:44:28 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon,  5 Jun 2017 17:44:21 +0200
Message-Id: <1496677461-22320-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] ppc/pnv: check the return value of fd_setprop()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/ppc/pnv.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 231ed9735b65..89b6801f67b5 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -378,8 +378,9 @@ static void powernv_populate_ipmi_bt(ISADevice *d, vo=
id *fdt, int lpc_off)
     _FDT(node);
     g_free(name);
=20
-    fdt_setprop(fdt, node, "reg", io_regs, sizeof(io_regs));
-    fdt_setprop(fdt, node, "compatible", compatible, sizeof(compatible))=
;
+    _FDT((fdt_setprop(fdt, node, "reg", io_regs, sizeof(io_regs))));
+    _FDT((fdt_setprop(fdt, node, "compatible", compatible,
+                      sizeof(compatible))));
=20
     /* Mark it as reserved to avoid Linux trying to claim it */
     _FDT((fdt_setprop_string(fdt, node, "status", "reserved")));
--=20
2.7.4

Received: from eggs.gnu.org ([2001:4830:134:3::10]:54314)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dI4ay-0003VL-BB
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 22:51:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dI4ax-0002ze-4y
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 22:51:48 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue,  6 Jun 2017 12:51:28 +1000
Message-Id: <20170606025135.2685-11-david@gibson.dropbear.id.au>
In-Reply-To: <20170606025135.2685-1-david@gibson.dropbear.id.au>
References: <20170606025135.2685-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 10/17] ppc/pnv: check the return value of
 fdt_setprop()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

From: C=C3=A9dric Le Goater <clg@kaod.org>

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
[dwg: Correct typo in commit message]
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/pnv.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 231ed97..89b6801 100644
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
2.9.4

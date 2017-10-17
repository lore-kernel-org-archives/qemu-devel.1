Received: from eggs.gnu.org ([2001:4830:134:3::10]:50274)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e4JOP-0008GJ-HD
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 00:22:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e4JOO-0006rU-Io
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 00:22:13 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 17 Oct 2017 15:21:20 +1100
Message-Id: <20171017042152.29443-3-david@gibson.dropbear.id.au>
In-Reply-To: <20171017042152.29443-1-david@gibson.dropbear.id.au>
References: <20171017042152.29443-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 02/34] hw/ppc: use 0 instead of
 fdt_path_offset(fdt, "/")
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: ehabkost@redhat.com, agraf@suse.de, imammedo@redhat.com, groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

From: Greg Kurz <groug@kaod.org>

The offset of the root node is guaranteed to be 0.

This doesn't fix anything, it's just trivial cleanup of the two
remaining places where this was done under hw/ppc.

Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/pnv.c   | 3 +--
 hw/ppc/spapr.c | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index d46d91c76f..84b2389ea6 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -92,8 +92,7 @@ static int get_cpus_node(void *fdt)
     int cpus_offset =3D fdt_path_offset(fdt, "/cpus");
=20
     if (cpus_offset < 0) {
-        cpus_offset =3D fdt_add_subnode(fdt, fdt_path_offset(fdt, "/"),
-                                      "cpus");
+        cpus_offset =3D fdt_add_subnode(fdt, 0, "cpus");
         if (cpus_offset) {
             _FDT((fdt_setprop_cell(fdt, cpus_offset, "#address-cells", 0=
x1)));
             _FDT((fdt_setprop_cell(fdt, cpus_offset, "#size-cells", 0x0)=
));
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index ff87f155d5..352ff3d614 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -353,8 +353,7 @@ static int spapr_fixup_cpu_dt(void *fdt, sPAPRMachine=
State *spapr)
=20
         cpus_offset =3D fdt_path_offset(fdt, "/cpus");
         if (cpus_offset < 0) {
-            cpus_offset =3D fdt_add_subnode(fdt, fdt_path_offset(fdt, "/=
"),
-                                          "cpus");
+            cpus_offset =3D fdt_add_subnode(fdt, 0, "cpus");
             if (cpus_offset < 0) {
                 return cpus_offset;
             }
--=20
2.13.6

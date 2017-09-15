Received: from eggs.gnu.org ([2001:4830:134:3::10]:54130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dshfK-0006e1-Pn
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 23:51:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dshfJ-0003Mq-KC
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 23:51:42 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 15 Sep 2017 13:51:16 +1000
Message-Id: <20170915035130.8354-5-david@gibson.dropbear.id.au>
In-Reply-To: <20170915035130.8354-1-david@gibson.dropbear.id.au>
References: <20170915035130.8354-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 04/18] spapr_pci: drop useless check in
 spapr_populate_pci_child_dt()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, gkurz@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, aik@ozlabs.ru, Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

From: Greg Kurz <groug@kaod.org>

spapr_phb_get_loc_code() either returns a non-null pointer, or aborts
if g_strdup_printf() failed to allocate memory.

Signed-off-by: Greg Kurz <groug@kaod.org>
[dwg: Grammatical fix to commit message]
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_pci.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index ef982f2ef3..cd8efb1812 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1282,12 +1282,8 @@ static int spapr_populate_pci_child_dt(PCIDevice *=
dev, void *fdt, int offset,
                             pci_find_device_name((ccode >> 16) & 0xff,
                                                  (ccode >> 8) & 0xff,
                                                  ccode & 0xff)));
-    buf =3D spapr_phb_get_loc_code(sphb, dev);
-    if (!buf) {
-        error_report("Failed setting the ibm,loc-code");
-        return -1;
-    }
=20
+    buf =3D spapr_phb_get_loc_code(sphb, dev);
     err =3D fdt_setprop_string(fdt, offset, "ibm,loc-code", buf);
     g_free(buf);
     if (err < 0) {
--=20
2.13.5

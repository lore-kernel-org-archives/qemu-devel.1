Received: from eggs.gnu.org ([2001:4830:134:3::10]:54042)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dshfH-0006SD-Qj
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 23:51:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dshfH-0003Jx-1K
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 23:51:39 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 15 Sep 2017 13:51:15 +1000
Message-Id: <20170915035130.8354-4-david@gibson.dropbear.id.au>
In-Reply-To: <20170915035130.8354-1-david@gibson.dropbear.id.au>
References: <20170915035130.8354-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 03/18] spapr_pci: drop useless check in
 spapr_phb_vfio_get_loc_code()
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

g_strdup_printf() either returns a non-null pointer, or aborts if it
failed to allocate memory.

Signed-off-by: Greg Kurz <groug@kaod.org>
[dwg: Grammatical fix to commit message]
Acked-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index d7880f257a..ef982f2ef3 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -766,7 +766,7 @@ static char *spapr_phb_vfio_get_loc_code(sPAPRPHBStat=
e *sphb,  PCIDevice *pdev)
     /* Construct the path of the file that will give us the DT location =
*/
     path =3D g_strdup_printf("/sys/bus/pci/devices/%s/devspec", host);
     g_free(host);
-    if (!path || !g_file_get_contents(path, &buf, NULL, NULL)) {
+    if (!g_file_get_contents(path, &buf, NULL, NULL)) {
         goto err_out;
     }
     g_free(path);
@@ -774,7 +774,7 @@ static char *spapr_phb_vfio_get_loc_code(sPAPRPHBStat=
e *sphb,  PCIDevice *pdev)
     /* Construct and read from host device tree the loc-code */
     path =3D g_strdup_printf("/proc/device-tree%s/ibm,loc-code", buf);
     g_free(buf);
-    if (!path || !g_file_get_contents(path, &buf, NULL, NULL)) {
+    if (!g_file_get_contents(path, &buf, NULL, NULL)) {
         goto err_out;
     }
     return buf;
--=20
2.13.5

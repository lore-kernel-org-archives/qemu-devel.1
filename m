Received: from eggs.gnu.org ([209.51.188.92]:58298)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gyUlP-0005Zs-72
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 23:54:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gyUlN-0002zT-AX
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 23:54:43 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 26 Feb 2019 15:53:03 +1100
Message-Id: <20190226045304.25618-50-david@gibson.dropbear.id.au>
In-Reply-To: <20190226045304.25618-1-david@gibson.dropbear.id.au>
References: <20190226045304.25618-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 49/50] ppc/pnv: add INITRD_MAX_SIZE constant
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: gkurz@kaod.org, clg@kaod.org, lvivier@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Murilo Opsfelder Araujo <mopsfelder@gmail.com>, Murilo Opsfelder Araujo <muriloo@linux.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

From: Murilo Opsfelder Araujo <mopsfelder@gmail.com>

The current 0x10000000 value is actually 256MiB, not 128MB as the comment
suggests. Move it to a constant and fix the comment (no change in the siz=
e
value).

Signed-off-by: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
Message-Id: <20190225170155.1972-3-muriloo@linux.ibm.com>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/pnv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 4144976aec..0cd6af4669 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -56,6 +56,7 @@
 #define KERNEL_LOAD_ADDR        0x20000000
 #define KERNEL_MAX_SIZE         (256 * MiB)
 #define INITRD_LOAD_ADDR        0x60000000
+#define INITRD_MAX_SIZE         (256 * MiB)
=20
 static const char *pnv_chip_core_typename(const PnvChip *o)
 {
@@ -601,7 +602,7 @@ static void pnv_init(MachineState *machine)
     if (machine->initrd_filename) {
         pnv->initrd_base =3D INITRD_LOAD_ADDR;
         pnv->initrd_size =3D load_image_targphys(machine->initrd_filenam=
e,
-                                  pnv->initrd_base, 0x10000000); /* 128M=
B max */
+                                  pnv->initrd_base, INITRD_MAX_SIZE);
         if (pnv->initrd_size < 0) {
             error_report("Could not load initial ram disk '%s'",
                          machine->initrd_filename);
--=20
2.20.1

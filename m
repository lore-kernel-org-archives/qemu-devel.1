Received: from eggs.gnu.org ([209.51.188.92]:58641)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gyUmI-0006PF-UM
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 23:55:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gyUmD-0003kx-8M
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 23:55:36 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 26 Feb 2019 15:53:02 +1100
Message-Id: <20190226045304.25618-49-david@gibson.dropbear.id.au>
In-Reply-To: <20190226045304.25618-1-david@gibson.dropbear.id.au>
References: <20190226045304.25618-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 48/50] ppc/pnv: increase kernel size limit to
 256MiB
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

Building kernel with CONFIG_DEBUG_INFO_REDUCED can generate a ~90MB image=
 and
building with CONFIG_DEBUG_INFO can generate a ~225M one, both exceeds th=
e
current limit of 32MiB.

Increasing kernel size limit to 256MiB should fit for now.

Signed-off-by: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
Message-Id: <20190225170155.1972-2-muriloo@linux.ibm.com>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/pnv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 9e03e9c336..4144976aec 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -54,6 +54,7 @@
 #define FW_MAX_SIZE             0x00400000
=20
 #define KERNEL_LOAD_ADDR        0x20000000
+#define KERNEL_MAX_SIZE         (256 * MiB)
 #define INITRD_LOAD_ADDR        0x60000000
=20
 static const char *pnv_chip_core_typename(const PnvChip *o)
@@ -588,7 +589,7 @@ static void pnv_init(MachineState *machine)
         long kernel_size;
=20
         kernel_size =3D load_image_targphys(machine->kernel_filename,
-                                          KERNEL_LOAD_ADDR, 0x2000000);
+                                          KERNEL_LOAD_ADDR, KERNEL_MAX_S=
IZE);
         if (kernel_size < 0) {
             error_report("Could not load kernel '%s'",
                          machine->kernel_filename);
--=20
2.20.1

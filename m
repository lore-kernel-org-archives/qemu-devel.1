Received: from eggs.gnu.org ([209.51.188.92]:57990)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gh08t-00061U-RV
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 17:46:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gh08r-0006j0-Lw
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 17:46:39 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed,  9 Jan 2019 09:45:45 +1100
Message-Id: <20190108224600.23125-15-david@gibson.dropbear.id.au>
In-Reply-To: <20190108224600.23125-1-david@gibson.dropbear.id.au>
References: <20190108224600.23125-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 14/29] MAINTAINERS: Add some missing ppc-related
 files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, clg@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

From: Thomas Huth <thuth@redhat.com>

hw/gpio/mpc8xxx.c is only used by the e500 machine, so add it there.
And the hw/input/adb* files are specific to the Mac machines, so
they should be assigned to these categories.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 MAINTAINERS | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index fc0be06756..625e1c8c93 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -962,6 +962,7 @@ L: qemu-ppc@nongnu.org
 S: Odd Fixes
 F: hw/ppc/e500.[hc]
 F: hw/ppc/e500plat.c
+F: hw/gpio/mpc8xxx.c
 F: include/hw/ppc/ppc_e500.h
 F: include/hw/pci-host/ppce500.h
 F: pc-bios/u-boot.e500
@@ -973,7 +974,7 @@ S: Odd Fixes
 F: hw/ppc/mpc8544ds.c
 F: hw/ppc/mpc8544_guts.c
=20
-New World
+New World (mac99)
 M: David Gibson <david@gibson.dropbear.id.au>
 L: qemu-ppc@nongnu.org
 S: Odd Fixes
@@ -983,12 +984,14 @@ F: hw/pci-bridge/dec.[hc]
 F: hw/misc/macio/
 F: hw/misc/mos6522.c
 F: hw/nvram/mac_nvram.c
+F: hw/input/adb*
 F: include/hw/misc/macio/
 F: include/hw/misc/mos6522.h
 F: include/hw/ppc/mac_dbdma.h
 F: include/hw/pci-host/uninorth.h
+F: include/hw/input/adb*
=20
-Old World
+Old World (g3beige)
 M: David Gibson <david@gibson.dropbear.id.au>
 L: qemu-ppc@nongnu.org
 S: Odd Fixes
@@ -996,7 +999,9 @@ F: hw/ppc/mac_oldworld.c
 F: hw/pci-host/grackle.c
 F: hw/misc/macio/
 F: hw/intc/heathrow_pic.c
+F: hw/input/adb*
 F: include/hw/intc/heathrow_pic.h
+F: include/hw/input/adb*
=20
 PReP
 M: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
--=20
2.20.1

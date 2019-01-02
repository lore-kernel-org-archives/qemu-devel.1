Received: from eggs.gnu.org ([208.118.235.92]:57243)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1geiuI-0005dE-MT
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 10:58:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1geiuE-00057p-JD
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 10:58:10 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Wed,  2 Jan 2019 16:57:56 +0100
Message-Id: <1546444676-27790-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] MAINTAINERS: Add some missing ppc-related files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org

hw/gpio/mpc8xxx.c is only used by the e500 machine, so add it there.
And the hw/input/adb* files are specific to the Mac machines, so
they should be assigned to these categories.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index ef6b7f6..eb037df 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -951,6 +951,7 @@ L: qemu-ppc@nongnu.org
 S: Odd Fixes
 F: hw/ppc/e500.[hc]
 F: hw/ppc/e500plat.c
+F: hw/gpio/mpc8xxx.c
 F: include/hw/ppc/ppc_e500.h
 F: include/hw/pci-host/ppce500.h
 F: pc-bios/u-boot.e500
@@ -962,7 +963,7 @@ S: Odd Fixes
 F: hw/ppc/mpc8544ds.c
 F: hw/ppc/mpc8544_guts.c
=20
-New World
+New World (mac99)
 M: David Gibson <david@gibson.dropbear.id.au>
 L: qemu-ppc@nongnu.org
 S: Odd Fixes
@@ -972,12 +973,14 @@ F: hw/pci-bridge/dec.[hc]
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
@@ -985,7 +988,9 @@ F: hw/ppc/mac_oldworld.c
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
1.8.3.1

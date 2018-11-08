Received: from eggs.gnu.org ([2001:4830:134:3::10]:43542)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gKjFP-0005K6-8P
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 07:17:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gKjFN-00040D-BJ
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 07:17:19 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu,  8 Nov 2018 23:16:42 +1100
Message-Id: <20181108121646.26173-19-david@gibson.dropbear.id.au>
In-Reply-To: <20181108121646.26173-1-david@gibson.dropbear.id.au>
References: <20181108121646.26173-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 18/22] MAINTAINERS: PPC: Remove myself
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, groug@kaod.org, agraf@suse.de, lvivier@redhat.com, David Gibson <david@gibson.dropbear.id.au>

From: Alexander Graf <agraf@suse.de>

I haven't really been maintaining any PowerPC code for quite a while now,
so let's reflect reality: David does all the work and embedded PPC is in
"Odd Fixes" state rather than supported now.

Signed-off-by: Alexander Graf <agraf@suse.de>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 MAINTAINERS | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0499e11593..46772bc0b0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -230,7 +230,6 @@ F: tests/tcg/openrisc/
=20
 PowerPC
 M: David Gibson <david@gibson.dropbear.id.au>
-M: Alexander Graf <agraf@suse.de>
 L: qemu-ppc@nongnu.org
 S: Maintained
 F: target/ppc/
@@ -341,7 +340,7 @@ S: Maintained
 F: target/mips/kvm.c
=20
 PPC
-M: Alexander Graf <agraf@suse.de>
+M: David Gibson <david@gibson.dropbear.id.au>
 S: Maintained
 F: target/ppc/kvm.c
=20
@@ -779,21 +778,21 @@ F: hw/openrisc/openrisc_sim.c
 PowerPC Machines
 ----------------
 405
-M: Alexander Graf <agraf@suse.de>
+M: David Gibson <david@gibson.dropbear.id.au>
 L: qemu-ppc@nongnu.org
 S: Odd Fixes
 F: hw/ppc/ppc405_boards.c
=20
 Bamboo
-M: Alexander Graf <agraf@suse.de>
+M: David Gibson <david@gibson.dropbear.id.au>
 L: qemu-ppc@nongnu.org
 S: Odd Fixes
 F: hw/ppc/ppc440_bamboo.c
=20
 e500
-M: Alexander Graf <agraf@suse.de>
+M: David Gibson <david@gibson.dropbear.id.au>
 L: qemu-ppc@nongnu.org
-S: Supported
+S: Odd Fixes
 F: hw/ppc/e500.[hc]
 F: hw/ppc/e500plat.c
 F: include/hw/ppc/ppc_e500.h
@@ -801,16 +800,16 @@ F: include/hw/pci-host/ppce500.h
 F: pc-bios/u-boot.e500
=20
 mpc8544ds
-M: Alexander Graf <agraf@suse.de>
+M: David Gibson <david@gibson.dropbear.id.au>
 L: qemu-ppc@nongnu.org
-S: Supported
+S: Odd Fixes
 F: hw/ppc/mpc8544ds.c
 F: hw/ppc/mpc8544_guts.c
=20
 New World
-M: Alexander Graf <agraf@suse.de>
+M: David Gibson <david@gibson.dropbear.id.au>
 L: qemu-ppc@nongnu.org
-S: Maintained
+S: Odd Fixes
 F: hw/ppc/mac_newworld.c
 F: hw/pci-host/uninorth.c
 F: hw/pci-bridge/dec.[hc]
@@ -822,9 +821,9 @@ F: include/hw/misc/mos6522.h
 F: include/hw/ppc/mac_dbdma.h
=20
 Old World
-M: Alexander Graf <agraf@suse.de>
+M: David Gibson <david@gibson.dropbear.id.au>
 L: qemu-ppc@nongnu.org
-S: Maintained
+S: Odd Fixes
 F: hw/ppc/mac_oldworld.c
 F: hw/pci-host/grackle.c
 F: hw/misc/macio/
@@ -849,7 +848,6 @@ F: pc-bios/ppc_rom.bin
=20
 sPAPR
 M: David Gibson <david@gibson.dropbear.id.au>
-M: Alexander Graf <agraf@suse.de>
 L: qemu-ppc@nongnu.org
 S: Supported
 F: hw/*/spapr*
@@ -1124,7 +1122,7 @@ F: tests/acpi-test-data/*
 F: tests/acpi-test-data/*/*
=20
 ppc4xx
-M: Alexander Graf <agraf@suse.de>
+M: David Gibson <david@gibson.dropbear.id.au>
 L: qemu-ppc@nongnu.org
 S: Odd Fixes
 F: hw/ppc/ppc4*.c
@@ -1133,9 +1131,9 @@ F: include/hw/ppc/ppc4xx.h
 F: include/hw/i2c/ppc4xx_i2c.h
=20
 ppce500
-M: Alexander Graf <agraf@suse.de>
+M: David Gibson <david@gibson.dropbear.id.au>
 L: qemu-ppc@nongnu.org
-S: Supported
+S: Odd Fixes
 F: hw/ppc/e500*
 F: hw/pci-host/ppce500.c
 F: hw/net/fsl_etsec/
--=20
2.19.1

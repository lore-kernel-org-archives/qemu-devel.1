Received: from eggs.gnu.org ([2001:4830:134:3::10]:53443)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1gHQR0-0001KS-BK
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 05:35:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1gHQQw-0004hs-8t
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 05:35:38 -0400
From: Alexander Graf <agraf@suse.de>
Date: Tue, 30 Oct 2018 10:35:31 +0100
Message-Id: <20181030093531.18587-1-agraf@suse.de>
Subject: [Qemu-devel] [PATCH] MAINTAINERS: PPC: Remove myself
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org

I haven't really been maintaining any PowerPC code for quite a while now,
so let's reflect reality: David does all the work and embedded PPC is in
"Odd Fixes" state rather than supported now.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 MAINTAINERS | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d794bd7a66..d1a6d3c740 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -230,7 +230,6 @@ F: tests/tcg/openrisc/
 
 PowerPC
 M: David Gibson <david@gibson.dropbear.id.au>
-M: Alexander Graf <agraf@suse.de>
 L: qemu-ppc@nongnu.org
 S: Maintained
 F: target/ppc/
@@ -340,7 +339,7 @@ S: Maintained
 F: target/mips/kvm.c
 
 PPC
-M: Alexander Graf <agraf@suse.de>
+M: David Gibson <david@gibson.dropbear.id.au>
 S: Maintained
 F: target/ppc/kvm.c
 
@@ -780,21 +779,21 @@ F: hw/openrisc/openrisc_sim.c
 PowerPC Machines
 ----------------
 405
-M: Alexander Graf <agraf@suse.de>
+M: David Gibson <david@gibson.dropbear.id.au>
 L: qemu-ppc@nongnu.org
 S: Odd Fixes
 F: hw/ppc/ppc405_boards.c
 
 Bamboo
-M: Alexander Graf <agraf@suse.de>
+M: David Gibson <david@gibson.dropbear.id.au>
 L: qemu-ppc@nongnu.org
 S: Odd Fixes
 F: hw/ppc/ppc440_bamboo.c
 
 e500
-M: Alexander Graf <agraf@suse.de>
+M: David Gibson <david@gibson.dropbear.id.au>
 L: qemu-ppc@nongnu.org
-S: Supported
+S: Odd Fixes
 F: hw/ppc/e500.[hc]
 F: hw/ppc/e500plat.c
 F: include/hw/ppc/ppc_e500.h
@@ -802,16 +801,16 @@ F: include/hw/pci-host/ppce500.h
 F: pc-bios/u-boot.e500
 
 mpc8544ds
-M: Alexander Graf <agraf@suse.de>
+M: David Gibson <david@gibson.dropbear.id.au>
 L: qemu-ppc@nongnu.org
-S: Supported
+S: Odd Fixes
 F: hw/ppc/mpc8544ds.c
 F: hw/ppc/mpc8544_guts.c
 
 New World
-M: Alexander Graf <agraf@suse.de>
+M: David Gibson <david@gibson.dropbear.id.au>
 L: qemu-ppc@nongnu.org
-S: Maintained
+S: Odd Fixes
 F: hw/ppc/mac_newworld.c
 F: hw/pci-host/uninorth.c
 F: hw/pci-bridge/dec.[hc]
@@ -823,9 +822,9 @@ F: include/hw/misc/mos6522.h
 F: include/hw/ppc/mac_dbdma.h
 
 Old World
-M: Alexander Graf <agraf@suse.de>
+M: David Gibson <david@gibson.dropbear.id.au>
 L: qemu-ppc@nongnu.org
-S: Maintained
+S: Odd Fixes
 F: hw/ppc/mac_oldworld.c
 F: hw/pci-host/grackle.c
 F: hw/misc/macio/
@@ -850,7 +849,6 @@ F: pc-bios/ppc_rom.bin
 
 sPAPR
 M: David Gibson <david@gibson.dropbear.id.au>
-M: Alexander Graf <agraf@suse.de>
 L: qemu-ppc@nongnu.org
 S: Supported
 F: hw/*/spapr*
@@ -1117,7 +1115,7 @@ F: tests/bios-tables-test.c
 F: tests/acpi-utils.[hc]
 
 ppc4xx
-M: Alexander Graf <agraf@suse.de>
+M: David Gibson <david@gibson.dropbear.id.au>
 L: qemu-ppc@nongnu.org
 S: Odd Fixes
 F: hw/ppc/ppc4*.c
@@ -1126,9 +1124,9 @@ F: include/hw/ppc/ppc4xx.h
 F: include/hw/i2c/ppc4xx_i2c.h
 
 ppce500
-M: Alexander Graf <agraf@suse.de>
+M: David Gibson <david@gibson.dropbear.id.au>
 L: qemu-ppc@nongnu.org
-S: Supported
+S: Odd Fixes
 F: hw/ppc/e500*
 F: hw/pci-host/ppce500.c
 F: hw/net/fsl_etsec/
-- 
2.12.3

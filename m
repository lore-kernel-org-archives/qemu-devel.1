Received: from eggs.gnu.org ([2001:4830:134:3::10]:41797)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gPod8-0008TT-8V
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 08:02:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gPod4-00046c-3t
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 08:02:50 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Thu, 22 Nov 2018 14:02:40 +0100
Message-Id: <1542891760-13937-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] MAINTAINERS: Add missing hw/pci-host entries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: Aleksandar Markovic <amarkovic@wavecomp.com>, Stefan Markovic <smarkovic@wavecomp.com>, Paul Burton <pburton@wavecomp.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org

Bonito belongs to Fulong-2E, Sabre belongs to Sun4u, and Mac-Newworld
and Mips-Boston were missing the header files.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6522621..46a5581 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -876,7 +876,7 @@ R: Stefan Markovic <smarkovic@wavecomp.com>
 S: Odd Fixes
 F: hw/mips/mips_fulong2e.c
 F: hw/isa/vt82c686.c
-
+F: hw/pci-host/bonito.c
 F: include/hw/isa/vt82c686.h
 
 Boston
@@ -886,6 +886,7 @@ S: Maintained
 F: hw/core/loader-fit.c
 F: hw/mips/boston.c
 F: hw/pci-host/xilinx-pcie.c
+F: include/hw/pci-host/xilinx-pcie.h
 
 OpenRISC Machines
 -----------------
@@ -938,6 +939,7 @@ F: hw/nvram/mac_nvram.c
 F: include/hw/misc/macio/
 F: include/hw/misc/mos6522.h
 F: include/hw/ppc/mac_dbdma.h
+F: include/hw/pci-host/uninorth.h
 
 Old World
 M: David Gibson <david@gibson.dropbear.id.au>
@@ -1029,6 +1031,8 @@ M: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
 S: Maintained
 F: hw/sparc64/sun4u.c
 F: pc-bios/openbios-sparc64
+F: hw/pci-host/sabre.c
+F: include/hw/pci-host/sabre.h
 
 Sun4v
 M: Artyom Tarasenko <atar4qemu@gmail.com>
-- 
1.8.3.1

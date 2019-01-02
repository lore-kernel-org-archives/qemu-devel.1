Received: from eggs.gnu.org ([208.118.235.92]:54340)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1geij0-0000iI-QH
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 10:46:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1geiiz-0003HX-Kt
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 10:46:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44036)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1geiiz-0003GC-Fi
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 10:46:29 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Wed,  2 Jan 2019 16:46:20 +0100
Message-Id: <1546443980-26779-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] MAINTAINERS: Add some missing SPARC-related
 files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org

These files / devices are only used by SPARC machines, so we can sort
them into the corresponding categories in the MAINTAINERS file.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index b6c2645..e897963 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1069,9 +1069,11 @@ M: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
 S: Maintained
 F: hw/sparc/sun4m.c
 F: hw/sparc/sun4m_iommu.c
+F: hw/display/cg3.c
+F: hw/display/tcx.c
 F: hw/dma/sparc32_dma.c
 F: hw/misc/eccmemctl.c
-F: hw/misc/slavio_misc.c
+F: hw/*/slavio_*.c
 F: include/hw/sparc/sparc32_dma.h
 F: pc-bios/openbios-sparc32
 F: include/hw/sparc/sun4m_iommu.h
@@ -1083,6 +1085,8 @@ F: hw/sparc64/sun4u.c
 F: pc-bios/openbios-sparc64
 F: hw/pci-host/sabre.c
 F: include/hw/pci-host/sabre.h
+F: include/hw/sparc/sun4u_iommu.h
+F: include/hw/nvram/sun_nvram.h
 
 Sun4v
 M: Artyom Tarasenko <atar4qemu@gmail.com>
-- 
1.8.3.1

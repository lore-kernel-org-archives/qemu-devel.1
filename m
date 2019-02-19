Received: from eggs.gnu.org ([209.51.188.92]:51201)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gw0tp-00005X-2a
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 03:37:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gw0to-000480-BS
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 03:37:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39550)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gw0to-00047K-2a
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 03:37:08 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Tue, 19 Feb 2019 09:36:48 +0100
Message-Id: <1550565421-10944-2-git-send-email-thuth@redhat.com>
In-Reply-To: <1550565421-10944-1-git-send-email-thuth@redhat.com>
References: <1550565421-10944-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH 01/14] MAINTAINERS: Add some missing entries
 for the sun4m machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

These files / devices are only used by SPARC machines, so we can sort
them into the corresponding categories in the MAINTAINERS file.

Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index b1d786c..7e4f70a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1082,12 +1082,15 @@ M: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
 S: Maintained
 F: hw/sparc/sun4m.c
 F: hw/sparc/sun4m_iommu.c
+F: hw/display/cg3.c
+F: hw/display/tcx.c
 F: hw/dma/sparc32_dma.c
 F: hw/misc/eccmemctl.c
-F: hw/misc/slavio_misc.c
+F: hw/*/slavio_*.c
+F: include/hw/nvram/sun_nvram.h
 F: include/hw/sparc/sparc32_dma.h
-F: pc-bios/openbios-sparc32
 F: include/hw/sparc/sun4m_iommu.h
+F: pc-bios/openbios-sparc32
 
 Sun4u
 M: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
-- 
1.8.3.1

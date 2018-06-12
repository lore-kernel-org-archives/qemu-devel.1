Received: from eggs.gnu.org ([2001:4830:134:3::10]:58910)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fSd3n-0002k3-ET
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 02:45:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fSd3m-0001uC-G3
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 02:45:43 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 12 Jun 2018 16:44:46 +1000
Message-Id: <20180612064503.14282-17-david@gibson.dropbear.id.au>
In-Reply-To: <20180612064503.14282-1-david@gibson.dropbear.id.au>
References: <20180612064503.14282-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 16/33] ppc: remove obsolete macio_init()
 definition from mac.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, lvivier@redhat.com, groug@kaod.org, clg@kaod.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, David Gibson <david@gibson.dropbear.id.au>

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Commits b6712ea391 removed the macio_init() function but missed the heade=
r
prototype in mac.h. Remove it since it is no longer needed.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/mac.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/hw/ppc/mac.h b/hw/ppc/mac.h
index dac96317af..89fa8bbed7 100644
--- a/hw/ppc/mac.h
+++ b/hw/ppc/mac.h
@@ -91,9 +91,6 @@ typedef struct MACIOIDEState {
 void macio_ide_init_drives(MACIOIDEState *ide, DriveInfo **hd_table);
 void macio_ide_register_dma(MACIOIDEState *ide);
=20
-void macio_init(PCIDevice *dev,
-                MemoryRegion *pic_mem);
-
 /* Grackle PCI */
 #define TYPE_GRACKLE_PCI_HOST_BRIDGE "grackle-pcihost"
=20
--=20
2.17.1

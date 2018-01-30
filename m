Received: from eggs.gnu.org ([2001:4830:134:3::10]:48869)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1egVmv-0005WS-Sg
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 08:17:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1egVmn-0001m8-UP
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 08:17:25 -0500
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Tue, 30 Jan 2018 14:10:10 +0100
Message-Id: <20180130131716.5899D7456D5@zero.eik.bme.hu>
Subject: [Qemu-devel] [PATCH] sii3112: Change angle brackets to quotes in
 #include lines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>

This matches what other files do for qemu includes

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/ide/sii3112.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/ide/sii3112.c b/hw/ide/sii3112.c
index 17aa930..e3896c6 100644
--- a/hw/ide/sii3112.c
+++ b/hw/ide/sii3112.c
@@ -12,8 +12,8 @@
  * http://wiki.osdev.org/User:Quok/Silicon_Image_Datasheets
  */
 
-#include <qemu/osdep.h>
-#include <hw/ide/pci.h>
+#include "qemu/osdep.h"
+#include "hw/ide/pci.h"
 #include "trace.h"
 
 #define TYPE_SII3112_PCI "sii3112"
-- 
2.7.6

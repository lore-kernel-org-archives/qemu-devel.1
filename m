Received: from eggs.gnu.org ([2001:4830:134:3::10]:41237)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhIs-0001wd-0U
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:19:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhIr-0003R4-1H
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:19:33 -0400
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 23 Jul 2018 15:16:11 -0500
Message-Id: <20180723201748.25573-3-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
References: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 02/99] device_tree: Increase FDT_MAX_SIZE to 1
 MiB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Geert Uytterhoeven <geert+renesas@glider.be>, Peter Maydell <peter.maydell@linaro.org>

From: Geert Uytterhoeven <geert+renesas@glider.be>

It is not uncommon for a contemporary FDT to be larger than 64 KiB,
leading to failures loading the device tree from sysfs:

    qemu-system-aarch64: qemu_fdt_setprop: Couldn't set ...: FDT_ERR_NOSPACE

Hence increase the limit to 1 MiB, like on PPC.

For reference, the largest arm64 DTB created from the Linux sources is
ca. 75 KiB large (100 KiB when built with symbols/fixup support).

Cc: qemu-stable@nongnu.org
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Message-id: 1523541337-23919-1-git-send-email-geert+renesas@glider.be
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit 14ec3cbd7c1e31dca4d23f028100c8f43e156573)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 device_tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/device_tree.c b/device_tree.c
index 19458b32bf..52c3358a55 100644
--- a/device_tree.c
+++ b/device_tree.c
@@ -29,7 +29,7 @@
 
 #include <libfdt.h>
 
-#define FDT_MAX_SIZE  0x10000
+#define FDT_MAX_SIZE  0x100000
 
 void *create_device_tree(int *sizep)
 {
-- 
2.17.1

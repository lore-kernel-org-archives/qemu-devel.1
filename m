Received: from eggs.gnu.org ([2001:4830:134:3::10]:45925)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <geert@linux-m68k.org>) id 1elde8-0006Af-ON
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 11:41:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <geert@linux-m68k.org>) id 1elde3-0006bj-S2
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 11:41:32 -0500
Received: from michel.telenet-ops.be ([2a02:1800:110:4::f00:18]:57434)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <geert@linux-m68k.org>)
	id 1elde3-0006at-Ix
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 11:41:27 -0500
From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Tue, 13 Feb 2018 17:41:17 +0100
Message-Id: <1518540077-14481-1-git-send-email-geert+renesas@glider.be>
Subject: [Qemu-devel] [PATCH] device_tree: Increase FDT_MAX_SIZE to 128 KiB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alexander Graf <agraf@suse.de>
Cc: qemu-devel@nongnu.org, linux-renesas-soc@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

It is not uncommon for a contemporary FDT to be larger than 64 KiB,
leading to failures loading the device tree from sysfs:

    qemu-system-aarch64: qemu_fdt_setprop: Couldn't set ...: FDT_ERR_NOSPACE

For reference, the largest arm64 DTB created from the Linux sources is
70 KiB large (93 KiB when built with symbols/fixup support).

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 device_tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/device_tree.c b/device_tree.c
index a24ddff02bdd857c..1ba9b8e0a49e6bbc 100644
--- a/device_tree.c
+++ b/device_tree.c
@@ -29,7 +29,7 @@
 
 #include <libfdt.h>
 
-#define FDT_MAX_SIZE  0x10000
+#define FDT_MAX_SIZE  0x20000
 
 void *create_device_tree(int *sizep)
 {
-- 
2.7.4

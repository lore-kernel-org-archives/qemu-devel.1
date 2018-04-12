Received: from eggs.gnu.org ([2001:4830:134:3::10]:35536)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <geert@linux-m68k.org>) id 1f6cho-0003Lk-5t
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 09:56:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <geert@linux-m68k.org>) id 1f6chj-0006dm-8h
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 09:56:04 -0400
Received: from baptiste.telenet-ops.be ([2a02:1800:120:4::f00:13]:49296)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <geert@linux-m68k.org>)
	id 1f6chj-0006ZI-2d
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 09:55:59 -0400
From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 12 Apr 2018 15:55:37 +0200
Message-Id: <1523541337-23919-1-git-send-email-geert+renesas@glider.be>
Subject: [Qemu-devel] [PATCH qemu v3] device_tree: Increase FDT_MAX_SIZE to
 1 MiB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alexander Graf <agraf@suse.de>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, linux-renesas-soc@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

It is not uncommon for a contemporary FDT to be larger than 64 KiB,
leading to failures loading the device tree from sysfs:

    qemu-system-aarch64: qemu_fdt_setprop: Couldn't set ...: FDT_ERR_NOSPACE

Hence increase the limit to 1 MiB, like on PPC.

For reference, the largest arm64 DTB created from the Linux sources is
ca. 75 KiB large (100 KiB when built with symbols/fixup support).

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v3:
  - Update example size figures,

v2:
  - Enlarge from 128 KiB to 1 MiB, as suggested by Peter Maydell.
---
 device_tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/device_tree.c b/device_tree.c
index 19458b32bf81e55e..52c3358a55838d33 100644
--- a/device_tree.c
+++ b/device_tree.c
@@ -29,7 +29,7 @@
 
 #include <libfdt.h>
 
-#define FDT_MAX_SIZE  0x10000
+#define FDT_MAX_SIZE  0x100000
 
 void *create_device_tree(int *sizep)
 {
-- 
2.7.4

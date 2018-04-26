Received: from eggs.gnu.org ([2001:4830:134:3::10]:39831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fBeR1-0002lH-NV
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 06:47:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fBeR0-0001bR-Fp
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 06:47:31 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:41154)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fBeR0-0001XB-8d
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 06:47:30 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fBeQn-0002z2-6Z
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 11:47:17 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 26 Apr 2018 11:46:57 +0100
Message-Id: <20180426104715.21702-2-peter.maydell@linaro.org>
In-Reply-To: <20180426104715.21702-1-peter.maydell@linaro.org>
References: <20180426104715.21702-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 01/19] device_tree: Increase FDT_MAX_SIZE to 1
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
2.17.0

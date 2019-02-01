Received: from eggs.gnu.org ([209.51.188.92]:42215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gphnp-0003Th-T8
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 18:00:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gphnn-0002uP-UO
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 18:00:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46992)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gphnl-0002r9-OJ
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 18:00:51 -0500
Date: Fri, 1 Feb 2019 18:00:44 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190201230042.31003-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] [PATCH] r2d: fix build on mingw
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Magnus Damm <magnus.damm@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>

Comment near strncpy explains kernel_cmdline does
not need to be 0-terminated.

Accordingly mark it as QEMU_NONSTRING.

Without this, gcc warns:
    'strncpy' specified bound 256 equals destination size

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/sh4/r2d.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/sh4/r2d.c b/hw/sh4/r2d.c
index 5b399e7161..dcdb3728cb 100644
--- a/hw/sh4/r2d.c
+++ b/hw/sh4/r2d.c
@@ -220,7 +220,7 @@ static struct QEMU_PACKED
 
     char pad[232];
 
-    char kernel_cmdline[256];
+    char kernel_cmdline[256] QEMU_NONSTRING;
 } boot_params;
 
 static void r2d_init(MachineState *machine)
-- 
MST

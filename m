Received: from eggs.gnu.org ([2001:4830:134:3::10]:58298)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fMFsa-0003hg-F2
	for qemu-devel@nongnu.org; Fri, 25 May 2018 12:47:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fMFsY-0002gq-QV
	for qemu-devel@nongnu.org; Fri, 25 May 2018 12:47:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37924 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fMFsY-0002gX-Lc
	for qemu-devel@nongnu.org; Fri, 25 May 2018 12:47:46 -0400
Date: Fri, 25 May 2018 19:47:45 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1527266793-301361-7-git-send-email-mst@redhat.com>
References: <1527266793-301361-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1527266793-301361-1-git-send-email-mst@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 06/20] display: use local path for local
 headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, peter.maydell@linaro.org, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

When pulling in headers that are in the same directory as C file (as
opposed to one in include/), we should use its relative path, without a
directory.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
 hw/display/bcm2835_fb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/display/bcm2835_fb.c b/hw/display/bcm2835_fb.c
index 7eab927..3355f4c 100644
--- a/hw/display/bcm2835_fb.c
+++ b/hw/display/bcm2835_fb.c
@@ -26,7 +26,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "hw/display/bcm2835_fb.h"
-#include "hw/display/framebuffer.h"
+#include "framebuffer.h"
 #include "ui/pixel_ops.h"
 #include "hw/misc/bcm2835_mbox_defs.h"
 #include "qemu/log.h"
--=20
MST

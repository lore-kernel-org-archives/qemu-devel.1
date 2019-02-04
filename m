Received: from eggs.gnu.org ([209.51.188.92]:45857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gqfaa-00066m-9s
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 09:51:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gqfTV-0005d1-AW
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 09:43:54 -0500
Received: from mail-qt1-f178.google.com ([209.85.160.178]:39280)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gqfTV-0005cB-2y
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 09:43:53 -0500
Received: by mail-qt1-f178.google.com with SMTP id u47so88529qtj.6
	for <qemu-devel@nongnu.org>; Mon, 04 Feb 2019 06:43:52 -0800 (PST)
Date: Mon, 4 Feb 2019 09:43:50 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190204142638.27021-17-mst@redhat.com>
References: <20190204142638.27021-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190204142638.27021-1-mst@redhat.com>
Subject: [Qemu-devel] [PULL 16/25] contrib/vhost-user-blk: fix the
 compilation issue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Changpeng Liu <changpeng.liu@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>

From: Changpeng Liu <changpeng.liu@intel.com>

Signed-off-by: Changpeng Liu <changpeng.liu@intel.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 contrib/vhost-user-blk/vhost-user-blk.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/contrib/vhost-user-blk/vhost-user-blk.c b/contrib/vhost-user-blk/vhost-user-blk.c
index 858221ad95..49640dfdf2 100644
--- a/contrib/vhost-user-blk/vhost-user-blk.c
+++ b/contrib/vhost-user-blk/vhost-user-blk.c
@@ -20,6 +20,10 @@
 #include "contrib/libvhost-user/libvhost-user-glib.h"
 #include "contrib/libvhost-user/libvhost-user.h"
 
+#if defined(__linux__)
+#include <linux/fs.h>
+#include <sys/ioctl.h>
+#endif
 
 struct virtio_blk_inhdr {
     unsigned char status;
@@ -454,7 +458,7 @@ vub_get_blocksize(int fd)
 
 #if defined(__linux__) && defined(BLKSSZGET)
     if (ioctl(fd, BLKSSZGET, &blocksize) == 0) {
-        return blocklen;
+        return blocksize;
     }
 #endif
 
-- 
MST

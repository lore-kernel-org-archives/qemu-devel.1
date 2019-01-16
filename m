Received: from eggs.gnu.org ([209.51.188.92]:40011)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <changpeng.liu@intel.com>) id 1gjdLQ-0006xK-JF
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 00:02:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <changpeng.liu@intel.com>) id 1gjdLM-0005Ca-O4
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 00:02:27 -0500
Received: from mga05.intel.com ([192.55.52.43]:4444)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <changpeng.liu@intel.com>)
	id 1gjdLI-00058k-VM
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 00:02:22 -0500
From: Changpeng Liu <changpeng.liu@intel.com>
Date: Wed, 16 Jan 2019 13:19:29 +0800
Message-Id: <1547615970-23545-2-git-send-email-changpeng.liu@intel.com>
In-Reply-To: <1547615970-23545-1-git-send-email-changpeng.liu@intel.com>
References: <1547615970-23545-1-git-send-email-changpeng.liu@intel.com>
Subject: [Qemu-devel] [PATCH v2 2/3] contrib/vhost-user-blk: fix the
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
Cc: mst@redhat.com, stefanha@redhat.com, sgazare@redhat.com, changpeng.liu@intel.com

Signed-off-by: Changpeng Liu <changpeng.liu@intel.com>
---
 contrib/vhost-user-blk/vhost-user-blk.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/contrib/vhost-user-blk/vhost-user-blk.c b/contrib/vhost-user-blk/vhost-user-blk.c
index 858221a..49640df 100644
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
1.9.3

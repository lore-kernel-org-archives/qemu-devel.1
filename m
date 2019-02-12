Received: from eggs.gnu.org ([209.51.188.92]:51639)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gtYiE-0002N4-PT
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 09:07:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gtYi4-00076h-OF
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 09:07:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57378)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gtYi4-00073d-IB
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 09:06:52 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Tue, 12 Feb 2019 15:06:20 +0100
Message-Id: <20190212140621.17009-3-philmd@redhat.com>
In-Reply-To: <20190212140621.17009-1-philmd@redhat.com>
References: <20190212140621.17009-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 2/3] contrib/vhost-user-blk: fix the
 compilation issue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Changpeng Liu <changpeng.liu@intel.com>, Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

From: Changpeng Liu <changpeng.liu@intel.com>

Signed-off-by: Changpeng Liu <changpeng.liu@intel.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <1547615970-23545-2-git-send-email-changpeng.liu@intel.com>
[PMD: this patch was first (incorrectly) introduced as a56de056c91f8]
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 contrib/vhost-user-blk/vhost-user-blk.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/contrib/vhost-user-blk/vhost-user-blk.c b/contrib/vhost-user=
-blk/vhost-user-blk.c
index 5c2092e13a..43583f2659 100644
--- a/contrib/vhost-user-blk/vhost-user-blk.c
+++ b/contrib/vhost-user-blk/vhost-user-blk.c
@@ -20,6 +20,10 @@
 #include "contrib/libvhost-user/libvhost-user-glib.h"
 #include "contrib/libvhost-user/libvhost-user.h"
=20
+#if defined(__linux__)
+#include <linux/fs.h>
+#include <sys/ioctl.h>
+#endif
=20
 struct virtio_blk_inhdr {
     unsigned char status;
@@ -521,7 +525,7 @@ vub_get_blocksize(int fd)
=20
 #if defined(__linux__) && defined(BLKSSZGET)
     if (ioctl(fd, BLKSSZGET, &blocksize) =3D=3D 0) {
-        return blocklen;
+        return blocksize;
     }
 #endif
=20
--=20
2.20.1

Received: from eggs.gnu.org ([2001:4830:134:3::10]:44317)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fHJdp-000321-HB
	for qemu-devel@nongnu.org; Fri, 11 May 2018 21:48:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fHJdm-0007FJ-FX
	for qemu-devel@nongnu.org; Fri, 11 May 2018 21:48:09 -0400
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:34384)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fHJdm-0007ES-84
	for qemu-devel@nongnu.org; Fri, 11 May 2018 21:48:06 -0400
Received: by mail-pl0-x241.google.com with SMTP id ay10-v6so4203186plb.1
	for <qemu-devel@nongnu.org>; Fri, 11 May 2018 18:48:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 11 May 2018 18:48:00 -0700
Message-Id: <20180512014801.17566-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 1/2] hw/virtio: Fix brace Werror with clang
 6.0.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>

The warning is

hw/virtio/vhost-user.c:1319:26: error: suggest braces
      around initialization of subobject [-Werror,-Wmissing-braces]
    VhostUserMsg msg = { 0 };
                         ^
                         {}

While the original code is correct, and technically exactly correct
as per ISO C89, both GCC and Clang support plain empty set of braces
as an extension.

Cc: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/virtio/vhost-user.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 38da8692bb..b455fca394 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -1316,7 +1316,7 @@ static bool vhost_user_requires_shm_log(struct vhost_dev *dev)
 
 static int vhost_user_migration_done(struct vhost_dev *dev, char* mac_addr)
 {
-    VhostUserMsg msg = { 0 };
+    VhostUserMsg msg = { };
 
     assert(dev->vhost_ops->backend_type == VHOST_BACKEND_TYPE_USER);
 
-- 
2.17.0

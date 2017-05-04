Received: from eggs.gnu.org ([2001:4830:134:3::10]:59790)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1d6OP4-0003AC-HE
	for qemu-devel@nongnu.org; Thu, 04 May 2017 17:35:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1d6OP4-0008OL-03
	for qemu-devel@nongnu.org; Thu, 04 May 2017 17:35:14 -0400
From: Jeff Cody <jcody@redhat.com>
Date: Thu,  4 May 2017 17:35:01 -0400
Message-Id: <0ed31cb5524d0f2c82f09d2a2ed1b84d6c1eaeb4.1493933558.git.jcody@redhat.com>
In-Reply-To: <cover.1493933558.git.jcody@redhat.com>
References: <cover.1493933558.git.jcody@redhat.com>
In-Reply-To: <cover.1493933558.git.jcody@redhat.com>
References: <cover.1493933558.git.jcody@redhat.com>
Subject: [Qemu-devel] [PATCH 2/2] block/vxhs: set errp on iio_init() failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, ashmit602@gmail.com, stefanha@redhat.com

Signed-off-by: Jeff Cody <jcody@redhat.com>
---
 block/vxhs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/vxhs.c b/block/vxhs.c
index 9ffe9d3..1f1e5db 100644
--- a/block/vxhs.c
+++ b/block/vxhs.c
@@ -301,6 +301,7 @@ static int vxhs_open(BlockDriverState *bs, QDict *options,
 
     ret = vxhs_init_and_ref();
     if (ret < 0) {
+        error_setg(&local_err, "libvxhs iio_init() failed");
         ret = -EINVAL;
         goto out;
     }
-- 
2.9.3

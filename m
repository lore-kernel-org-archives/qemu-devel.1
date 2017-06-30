Received: from eggs.gnu.org ([2001:4830:134:3::10]:48139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dQuNs-0008BZ-8C
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 07:46:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dQuNr-0004sG-G2
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 07:46:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33818)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dQuNr-0004ry-AR
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 07:46:47 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Fri, 30 Jun 2017 12:46:30 +0100
Message-Id: <20170630114635.9286-3-stefanha@redhat.com>
In-Reply-To: <20170630114635.9286-1-stefanha@redhat.com>
References: <20170630114635.9286-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL 2/7] libqos: fix typo in virtio.h
 QVirtQueue->used comment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Tested-by: Eric Blake <eblake@redhat.com>
Tested-by: Kevin Wolf <kwolf@redhat.com>
Message-id: 20170628184724.21378-2-stefanha@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/libqos/virtio.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/libqos/virtio.h b/tests/libqos/virtio.h
index 3397a08..829de5e 100644
--- a/tests/libqos/virtio.h
+++ b/tests/libqos/virtio.h
@@ -26,7 +26,7 @@ typedef struct QVirtioDevice {
 typedef struct QVirtQueue {
     uint64_t desc; /* This points to an array of struct vring_desc */
     uint64_t avail; /* This points to a struct vring_avail */
-    uint64_t used; /* This points to a struct vring_desc */
+    uint64_t used; /* This points to a struct vring_used */
     uint16_t index;
     uint32_t size;
     uint32_t free_head;
-- 
2.9.4

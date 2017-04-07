Received: from eggs.gnu.org ([2001:4830:134:3::10]:53977)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <weiqi4@huawei.com>) id 1cwODU-0001HK-9h
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 03:21:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <weiqi4@huawei.com>) id 1cwODQ-0000Gd-CB
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 03:21:56 -0400
Received: from [45.249.212.189] (port=2914 helo=dggrg03-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <weiqi4@huawei.com>) id 1cwODP-0000CE-UN
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 03:21:52 -0400
From: weiqi <weiqi4@huawei.com>
Date: Fri, 7 Apr 2017 14:58:46 +0800
Message-ID: <1491548326-60072-1-git-send-email-weiqi4@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 1/3] vhost: simple clean up
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com
Cc: qemu-devel@nongnu.org, arei.gonglei@huawei.com, Wei Qi <weiqi4@huawei.com>

From: Wei Qi <weiqi4@huawei.com>

It is unnecessary to assign 'hdev->nvqs' to 'i', because 'hdev->nvqs' unused after assignment, so remove it.

Signed-off-by: Wei Qi <weiqi4@huawei.com>
---
 hw/virtio/vhost.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 613494d..5c57983 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1557,7 +1557,6 @@ fail_vq:
                              hdev->vqs + i,
                              hdev->vq_index + i);
     }
-    i = hdev->nvqs;
 
 fail_mem:
 fail_features:
-- 
1.8.3.1

Received: from eggs.gnu.org ([2001:4830:134:3::10]:49283)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1duhVE-0004BL-SV
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 12:05:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1duhV9-0007Lk-1A
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 12:05:32 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:44610)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tgolembi@redhat.com>) id 1duhV8-0007KP-Qg
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 12:05:26 -0400
Received: by mail-wm0-f50.google.com with SMTP id 189so5554328wmh.1
	for <qemu-devel@nongnu.org>; Wed, 20 Sep 2017 09:05:26 -0700 (PDT)
From: =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>
Date: Wed, 20 Sep 2017 18:05:22 +0200
Message-Id: <13ca7e373615efac74661590527067ee8966f027.1505923516.git.tgolembi@redhat.com>
In-Reply-To: <cover.1505923516.git.tgolembi@redhat.com>
References: <cover.1505923516.git.tgolembi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 1/1] virtio-balloon: include buffers and
 chached memory statistics
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org
Cc: Wei Wang <wei.w.wang@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>

Signed-off-by: Tomáš Golembiovský <tgolembi@redhat.com>
---
 hw/virtio/virtio-balloon.c                      | 2 ++
 include/standard-headers/linux/virtio_balloon.h | 4 +++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index a705e0ec55..0434784c14 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -49,6 +49,8 @@ static const char *balloon_stat_names[] = {
    [VIRTIO_BALLOON_S_MEMFREE] = "stat-free-memory",
    [VIRTIO_BALLOON_S_MEMTOT] = "stat-total-memory",
    [VIRTIO_BALLOON_S_AVAIL] = "stat-available-memory",
+   [VIRTIO_BALLOON_S_BUFFERS] = "stat-linux-buffers",
+   [VIRTIO_BALLOON_S_CACHED] = "stat-linux-cached",
    [VIRTIO_BALLOON_S_NR] = NULL
 };
 
diff --git a/include/standard-headers/linux/virtio_balloon.h b/include/standard-headers/linux/virtio_balloon.h
index 9d06ccd066..d61efbfcee 100644
--- a/include/standard-headers/linux/virtio_balloon.h
+++ b/include/standard-headers/linux/virtio_balloon.h
@@ -52,7 +52,9 @@ struct virtio_balloon_config {
 #define VIRTIO_BALLOON_S_MEMFREE  4   /* Total amount of free memory */
 #define VIRTIO_BALLOON_S_MEMTOT   5   /* Total amount of memory */
 #define VIRTIO_BALLOON_S_AVAIL    6   /* Available memory as in /proc */
-#define VIRTIO_BALLOON_S_NR       7
+#define VIRTIO_BALLOON_S_BUFFERS  7   /* Buffers memory as in /proc */
+#define VIRTIO_BALLOON_S_CACHED   8   /* Cached memory as in /proc */
+#define VIRTIO_BALLOON_S_NR       9
 
 /*
  * Memory statistics structure.
-- 
2.14.1

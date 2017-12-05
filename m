Received: from eggs.gnu.org ([2001:4830:134:3::10]:52818)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1eMC7h-0003bc-Aj
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 07:14:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tgolembi@redhat.com>) id 1eMC7e-0004EO-Hq
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 07:14:53 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:38365)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tgolembi@redhat.com>) id 1eMC7e-0004E3-BX
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 07:14:50 -0500
Received: by mail-wm0-f66.google.com with SMTP id 64so852309wme.3
	for <qemu-devel@nongnu.org>; Tue, 05 Dec 2017 04:14:50 -0800 (PST)
From: =?UTF-8?q?Tom=C3=A1=C5=A1=20Golembiovsk=C3=BD?= <tgolembi@redhat.com>
Date: Tue,  5 Dec 2017 13:14:46 +0100
Message-Id: <938dc32019864c9c19259bdddd64a53b6b99efef.1512476043.git.tgolembi@redhat.com>
In-Reply-To: <cover.1512476043.git.tgolembi@redhat.com>
References: <cover.1512476043.git.tgolembi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 1/1] virtio-balloon: include statistics of
 disk/file caches
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
 hw/virtio/virtio-balloon.c                      | 1 +
 include/standard-headers/linux/virtio_balloon.h | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index 37cde38982..8141326a51 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -50,6 +50,7 @@ static const char *balloon_stat_names[] = {
    [VIRTIO_BALLOON_S_MEMFREE] = "stat-free-memory",
    [VIRTIO_BALLOON_S_MEMTOT] = "stat-total-memory",
    [VIRTIO_BALLOON_S_AVAIL] = "stat-available-memory",
+   [VIRTIO_BALLOON_S_CACHES] = "stat-disk-caches",
    [VIRTIO_BALLOON_S_NR] = NULL
 };
 
diff --git a/include/standard-headers/linux/virtio_balloon.h b/include/standard-headers/linux/virtio_balloon.h
index 9d06ccd066..7b0a41b8fc 100644
--- a/include/standard-headers/linux/virtio_balloon.h
+++ b/include/standard-headers/linux/virtio_balloon.h
@@ -52,7 +52,8 @@ struct virtio_balloon_config {
 #define VIRTIO_BALLOON_S_MEMFREE  4   /* Total amount of free memory */
 #define VIRTIO_BALLOON_S_MEMTOT   5   /* Total amount of memory */
 #define VIRTIO_BALLOON_S_AVAIL    6   /* Available memory as in /proc */
-#define VIRTIO_BALLOON_S_NR       7
+#define VIRTIO_BALLOON_S_CACHES   7   /* Disk caches */
+#define VIRTIO_BALLOON_S_NR       8
 
 /*
  * Memory statistics structure.
-- 
2.15.1

Received: from eggs.gnu.org ([2001:4830:134:3::10]:49226)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1erRLL-0006Hd-12
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 11:46:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1erRLJ-00010p-AA
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 11:46:07 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40602 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1erRLJ-00010I-4S
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 11:46:05 -0500
Date: Thu, 1 Mar 2018 18:46:04 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1519922735-29054-9-git-send-email-mst@redhat.com>
References: <1519922735-29054-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519922735-29054-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 08/13] vhost: fix incorrect check in
 vhost_verify_ring_mappings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Jia He <hejianet@gmail.com>, Jia He <jia.he@hxt-semitech.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

From: Jia He <hejianet@gmail.com>

In commit 0ca1fd2d6878 ("vhost: Simplify ring verification checks"),
it checks the virtqueue desc mapping for 3 times.

Fixed: commit 0ca1fd2d6878 ("vhost: Simplify ring verification checks")
Signed-off-by: Jia He <jia.he@hxt-semitech.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 hw/virtio/vhost.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index d02d12a..d8d0ef9 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -359,7 +359,7 @@ static int vhost_verify_ring_mappings(struct vhost_dev *dev,
 
         j++;
         r = vhost_verify_ring_part_mapping(
-                vq->desc, vq->desc_phys, vq->desc_size,
+                vq->avail, vq->avail_phys, vq->avail_size,
                 reg_hva, reg_gpa, reg_size);
         if (r) {
             break;
@@ -367,7 +367,7 @@ static int vhost_verify_ring_mappings(struct vhost_dev *dev,
 
         j++;
         r = vhost_verify_ring_part_mapping(
-                vq->desc, vq->desc_phys, vq->desc_size,
+                vq->used, vq->used_phys, vq->used_size,
                 reg_hva, reg_gpa, reg_size);
         if (r) {
             break;
-- 
MST

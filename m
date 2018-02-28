Received: from eggs.gnu.org ([2001:4830:134:3::10]:50921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hejianet@gmail.com>) id 1eqyA9-0001lU-9i
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 04:36:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hejianet@gmail.com>) id 1eqyA8-0000b8-Eo
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 04:36:37 -0500
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:46520)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <hejianet@gmail.com>) id 1eqyA8-0000aj-83
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 04:36:36 -0500
Received: by mail-pl0-x241.google.com with SMTP id y8-v6so1166445pll.13
	for <qemu-devel@nongnu.org>; Wed, 28 Feb 2018 01:36:36 -0800 (PST)
From: Jia He <hejianet@gmail.com>
Date: Wed, 28 Feb 2018 01:35:29 -0800
Message-Id: <1519810529-4034-2-git-send-email-hejianet@gmail.com>
In-Reply-To: <1519810529-4034-1-git-send-email-hejianet@gmail.com>
References: <1519810529-4034-1-git-send-email-hejianet@gmail.com>
Subject: [Qemu-devel] [PATCH 2/2] vhost: fix incorrect check in
 vhost_verify_ring_mappings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Jia He <hejianet@gmail.com>, Jia He <jia.he@hxt-semitech.com>

In commit 0ca1fd2d6878 ("vhost: Simplify ring verification checks"),
it checks the virtqueue desc mapping for 3 times.

Fixed: commit 0ca1fd2d6878 ("vhost: Simplify ring verification checks")
Signed-off-by: Jia He <jia.he@hxt-semitech.com>
---
 hw/virtio/vhost.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 00f2512..bbf6c0c 100644
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
2.7.4

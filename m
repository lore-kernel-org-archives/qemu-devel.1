Received: from eggs.gnu.org ([2001:4830:134:3::10]:40339)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1eRMNu-0007cB-09
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 13:12:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1eRMNs-00056s-JD
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 13:12:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34954)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <maxime.coquelin@redhat.com>)
	id 1eRMNs-000564-Ch
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 13:12:56 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 87D34356EF
	for <qemu-devel@nongnu.org>; Tue, 19 Dec 2017 18:12:55 +0000 (UTC)
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Date: Tue, 19 Dec 2017 19:11:27 +0100
Message-Id: <20171219181129.24189-2-maxime.coquelin@redhat.com>
In-Reply-To: <20171219181129.24189-1-maxime.coquelin@redhat.com>
References: <20171219181129.24189-1-maxime.coquelin@redhat.com>
Subject: [Qemu-devel] [PATCH 1/3] vhost-user: rename VhostUserMemory
 userspace_addr field to user_addr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, stefanha@redhat.com, mst@redhat.com
Cc: mlureau@redhat.com, Maxime Coquelin <maxime.coquelin@redhat.com>

The Vhost-user specification does not specify the user address should
be a valid address within master process address space.

Let's name it user_addr to comply with the specification.

Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
---
 hw/virtio/vhost-user.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 093675ed98..43b342a65b 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -77,7 +77,7 @@ typedef enum VhostUserSlaveRequest {
 typedef struct VhostUserMemoryRegion {
     uint64_t guest_phys_addr;
     uint64_t memory_size;
-    uint64_t userspace_addr;
+    uint64_t user_addr;
     uint64_t mmap_offset;
 } VhostUserMemoryRegion;
 
@@ -317,7 +317,7 @@ static int vhost_user_set_mem_table(struct vhost_dev *dev,
                                      &offset);
         fd = memory_region_get_fd(mr);
         if (fd > 0) {
-            msg.payload.memory.regions[fd_num].userspace_addr = reg->userspace_addr;
+            msg.payload.memory.regions[fd_num].user_addr = reg->userspace_addr;
             msg.payload.memory.regions[fd_num].memory_size  = reg->memory_size;
             msg.payload.memory.regions[fd_num].guest_phys_addr = reg->guest_phys_addr;
             msg.payload.memory.regions[fd_num].mmap_offset = offset;
-- 
2.14.3

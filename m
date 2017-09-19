Received: from eggs.gnu.org ([2001:4830:134:3::10]:46887)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1duK0g-0005L4-5X
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 11:00:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1duK0c-0001T6-1V
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 11:00:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33762)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1duK0b-0001SQ-NT
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 11:00:21 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Tue, 19 Sep 2017 16:56:31 +0200
Message-Id: <20170919145636.9389-34-cohuck@redhat.com>
In-Reply-To: <20170919145636.9389-1-cohuck@redhat.com>
References: <20170919145636.9389-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 33/38] virtio-ccw: remove stale comments on
 endianness
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, rth@twiddle.net, agraf@suse.de, thuth@redhat.com, borntraeger@de.ibm.com, david@redhat.com, Halil Pasic <pasic@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>

From: Halil Pasic <pasic@linux.vnet.ibm.com>

We have two stale comments suggesting one should think about virtio
config space endianness a bit longer. We have just done that, and came to
the conclusion we are fine as is: it's the responsibility of the virtio
device and not of the transport (and that is how it works now). Putting
the responsibility into the transport isn't even possible, because the
transport would have to know about the config space layout of each
device.

Let us remove the stale comments.

Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Suggested-by: Cornelia Huck <cohuck@redhat.com>
Message-Id: <20170914105535.47941-1-pasic@linux.vnet.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/virtio-ccw.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index b1976fdd19..2262b0cc9a 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -487,7 +487,6 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
             ret = -EFAULT;
         } else {
             virtio_bus_get_vdev_config(&dev->bus, vdev->config);
-            /* XXX config space endianness */
             cpu_physical_memory_write(ccw.cda, vdev->config, len);
             sch->curr_status.scsw.count = ccw.count - len;
             ret = 0;
@@ -510,7 +509,6 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
                 ret = -EFAULT;
             } else {
                 len = hw_len;
-                /* XXX config space endianness */
                 memcpy(vdev->config, config, len);
                 cpu_physical_memory_unmap(config, hw_len, 0, hw_len);
                 virtio_bus_set_vdev_config(&dev->bus, vdev->config);
-- 
2.13.5

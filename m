Received: from eggs.gnu.org ([2001:4830:134:3::10]:60256)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dsRoC-0000eW-Cl
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 06:55:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dsRo8-00066k-2T
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 06:55:48 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35444
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1dsRo7-00066A-Jz
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 06:55:43 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8EAstmC062189
	for <qemu-devel@nongnu.org>; Thu, 14 Sep 2017 06:55:42 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2cyq8m50ca-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 14 Sep 2017 06:55:42 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Thu, 14 Sep 2017 11:55:41 +0100
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Thu, 14 Sep 2017 12:55:35 +0200
Message-Id: <20170914105535.47941-1-pasic@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 1/1] virtio-ccw: remove stale comments on
 endiannes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org, Halil Pasic <pasic@linux.vnet.ibm.com>

We have two stale comments suggesting one should think about virtio
config space endiannes a bit longer. We have just done that, and came to
the conclusion we are fine as is: it's the responsibility of the virtio
device and not of the transport (and that is how it works now). Putting
the responsibility into the transport isn't even possible, because the
transport would have to know about the config space layout of each
device.

Let us remove the stale comments.

Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Suggested-by: Cornelia Huck <cohuck@redhat.com>
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

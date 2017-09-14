Received: from eggs.gnu.org ([2001:4830:134:3::10]:33436)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alifm@linux.vnet.ibm.com>) id 1dsWU7-0001df-Jm
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 11:55:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alifm@linux.vnet.ibm.com>) id 1dsWU2-0006Ze-NP
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 11:55:23 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60543)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alifm@linux.vnet.ibm.com>)
	id 1dsWU2-0006Z0-E4
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 11:55:18 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8EFsTaS048479
	for <qemu-devel@nongnu.org>; Thu, 14 Sep 2017 11:55:16 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2cyr8e4cbh-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 14 Sep 2017 11:55:15 -0400
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <alifm@linux.vnet.ibm.com>;
	Thu, 14 Sep 2017 09:55:14 -0600
From: Farhan Ali <alifm@linux.vnet.ibm.com>
Date: Thu, 14 Sep 2017 11:55:07 -0400
Message-Id: <cover.1505403478.git.alifm@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v2 0/2] Virtio GPU for S390
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, thuth@redhat.com, kraxel@redhat.com, cohuck@redhat.com

These patches wire up the virtio-gpu device for CCW bus for
S390.

For the S390 architecture which does not natively support any graphics
device, virtio gpu in 2D mode could be used to emulate a simple graphics
card and use VNC as the display.

eg: qemu-system-s390x ... -device virtio-gpu-ccw,devno=fe.0.0101
    -vnc host_ip_addr:5900

Note, to actually see any display content the
guest kernel needs to support DRM layer, Virtio GPU driver,
the Virtual Terminal layer etc.

I would appreciate any feedback on these patches, specially the
first patch.

ChangeLog
--------
v1 -> v2
    - remove error_propagate (patch 2)
    - Add byteswap functions (patch 1)
    - Handle endian conversion for virtio_gpu_ctrl_response (patch 1)


Thank you
Farhan


Farhan Ali (2):
  virtio-gpu: Handle endian conversion
  virtio-gpu-ccw: Create a virtio gpu device for the ccw bus

 hw/display/virtio-gpu.c | 75 +++++++++++++++++++++++++++++++++++++++++++------
 hw/s390x/virtio-ccw.c   | 49 ++++++++++++++++++++++++++++++++
 hw/s390x/virtio-ccw.h   | 10 +++++++
 3 files changed, 126 insertions(+), 8 deletions(-)

-- 
1.9.1

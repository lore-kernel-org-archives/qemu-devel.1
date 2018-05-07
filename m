Received: from eggs.gnu.org ([2001:4830:134:3::10]:46935)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fFiQV-00023f-MF
	for qemu-devel@nongnu.org; Mon, 07 May 2018 11:51:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fFiQQ-00018q-Or
	for qemu-devel@nongnu.org; Mon, 07 May 2018 11:51:47 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Mon,  7 May 2018 17:51:28 +0200
Message-Id: <20180507155130.21085-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] s390x: reset handling for ccw devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Thomas Huth <thuth@redhat.com>
Cc: Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>

On Friday, Thomas noticed some problems with 3270 devices. One result
was "s390x/css: disabled subchannels cannot be status pending", but
a reboot did not cure the previous broken status. Turns out that 3270
devices are missing a reset handler.

This series cleans up reset handling a bit and makes sure that the base
ccw device class provides a subchannel reset handler. I'm currently
not sure what we should do with vfio-ccw, so the behaviour there is
left unchanged.

Cornelia Huck (2):
  virtio-ccw: common reset handler
  s390x/ccw: make sure all ccw devices are properly reset

 hw/s390x/ccw-device.c |  8 ++++++++
 hw/s390x/virtio-ccw.c | 20 ++++++--------------
 hw/s390x/virtio-ccw.h |  1 +
 3 files changed, 15 insertions(+), 14 deletions(-)

-- 
2.14.3

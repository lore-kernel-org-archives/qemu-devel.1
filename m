Received: from eggs.gnu.org ([2001:4830:134:3::10]:41202)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jbaron@akamai.com>) id 1erbet-0000XS-GL
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 22:47:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jbaron@akamai.com>) id 1erbep-0000nI-Eo
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 22:46:59 -0500
Received: from mx0a-00190b01.pphosted.com ([2620:100:9001:583::1]:47288)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jbaron@akamai.com>) id 1erbep-0000m7-46
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 22:46:55 -0500
From: Jason Baron <jbaron@akamai.com>
Date: Thu,  1 Mar 2018 22:46:32 -0500
Message-Id: <cover.1519961667.git.jbaron@akamai.com>
Subject: [Qemu-devel] [PATCH 0/4] virtio-net: allow linkspeed and duplex
 setting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com
Cc: jasowang@redhat.com, qemu-devel@nongnu.org

Hi,

Linux can now read linkspeed and duplex settings as set by the
hypervisor:

faa9b39 virtio_net: propagate linkspeed/duplex settings from the hypervisor

This series thus adds qemu support. Michael Tsirkin requested that we pull
in the linkspeed/duplex defines from include/linux/ethtool.h. I started to
do that and it seems to require a number of addtional headers. It seemed
like a lot of extra headers for only a few defines so I've added them all
to include/net/eth.h.

Also, this patchset depends on this header sync:

https://lists.gnu.org/archive/html/qemu-devel/2018-02/msg07072.html

Thanks,

-Jason

Jason Baron (4):
  eth: add speed and duplex definitions
  rocker: drop local duplex definitions
  virtio-net: use 64-bit values for feature flags
  virtio-net: add linkspeed and duplex settings to virtio-net

 hw/net/rocker/rocker_fp.c      |  6 +---
 hw/net/virtio-net.c            | 81 ++++++++++++++++++++++++++++--------------
 include/hw/virtio/virtio-net.h |  5 ++-
 include/net/eth.h              |  7 ++++
 4 files changed, 66 insertions(+), 33 deletions(-)

-- 
2.7.4

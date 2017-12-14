Received: from eggs.gnu.org ([2001:4830:134:3::10]:55902)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jbaron@akamai.com>) id 1ePZHH-0005FA-64
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 14:34:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jbaron@akamai.com>) id 1ePZHD-0005gG-0D
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 14:34:43 -0500
Received: from mx0a-00190b01.pphosted.com ([2620:100:9001:583::1]:56384)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jbaron@akamai.com>) id 1ePZHC-0005dp-My
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 14:34:38 -0500
From: Jason Baron <jbaron@akamai.com>
Date: Thu, 14 Dec 2017 14:33:51 -0500
Message-Id: <cover.1513278334.git.jbaron@akamai.com>
Subject: [Qemu-devel] [PATCH 0/2] virtio_net: allow hypervisor to indicate
 linkspeed and duplex setting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, linux-kernel@vger.kernel.org
Cc: mst@redhat.com, jasowang@redhat.com

We have found it useful to be able to set the linkspeed and duplex
settings from the host-side for virtio_net. This obviates the need
for guest changes and settings for these fields.

The ability to set linkspeed and duplex was introduced by:

16032be virtio_net: add ethtool support for set and get of settings

And using 'ethtool -s' continues to over-write the linkspeed/duplex
settings with this patch.

The 1/2 patch is against net-next, while the 2/2 patch is the associated
qemu changes that would go in after as update-linux-headers.sh should
be run first. So 2/2 is more meant as a demonstration of how I intend this
to work.

Thanks,

-Jason

Jason Baron (2):
  virtio_net: allow hypervisor to indicate linkspeed and duplex setting
  qemu: add linkspeed and duplex setting to virtio-net

 linux changes:

 drivers/net/virtio_net.c        | 11 ++++++++++-
 include/uapi/linux/virtio_net.h |  4 ++++
 2 files changed, 14 insertions(+), 1 deletion(-)

 qemu changes:

 hw/net/virtio-net.c                         | 29 +++++++++++++++++++++++++++++                                
 include/hw/virtio/virtio-net.h              |  3 +++                                                          
 include/standard-headers/linux/virtio_net.h |  4 ++++                                                         
 3 files changed, 36 insertions(+)      

-- 
2.6.1

Received: from eggs.gnu.org ([2001:4830:134:3::10]:36994)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jbaron@akamai.com>) id 1eSVI7-0006Tx-6V
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 16:55:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jbaron@akamai.com>) id 1eSVI4-0007FC-23
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 16:55:43 -0500
Received: from mx0a-00190b01.pphosted.com ([2620:100:9001:583::1]:48634)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jbaron@akamai.com>) id 1eSVI3-0007Eo-Pc
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 16:55:39 -0500
From: Jason Baron <jbaron@akamai.com>
Date: Fri, 22 Dec 2017 16:54:00 -0500
Message-Id: <cover.1513974243.git.jbaron@akamai.com>
In-Reply-To: <1513979641-7999-1-git-send-email-jbaron@akamai.com>
References: <1513979641-7999-1-git-send-email-jbaron@akamai.com>
Subject: [Qemu-devel] [PATCH v2 0/3] virtio_net: allow hypervisor to
 indicate linkspeed and duplex setting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org
Cc: mst@redhat.com, jasowang@redhat.com

We have found it useful to be able to set the linkspeed and duplex
settings from the host-side for virtio_net. This obviates the need
for guest changes and settings for these fields, and does not require
custom ethtool commands for virtio_net.
                                                                                                                          
The ability to set linkspeed and duplex is useful in various cases
as described here:                                                                                                        
                                                                                                                          
16032be virtio_net: add ethtool support for set and get of settings                                                       
                                                                                                                          
Using 'ethtool -s' continues to over-write the linkspeed/duplex                                                           
settings with this patch.                                                                                          
                                                                                                                          
The 1/3 patch is against net-next, while the 2-3/3 patch are the associated
qemu changes that would go in after as update-linux-headers.sh should
be run first. So the qemu patches are a demonstration of how I intend this
to work.
                                                                                                                          
Thanks,                                                                                                                   
                                                                                                                          
-Jason                                                                                                                    
                                                                                                                          
 linux changes:                                                                                                           

Jason Baron (1):
  virtio_net: propagate linkspeed/duplex settings from the hypervisor

 drivers/net/virtio_net.c        | 17 ++++++++++++++++-
 include/uapi/linux/virtio_net.h |  5 +++++
 2 files changed, 21 insertions(+), 1 deletion(-)
                                                                                                                          
                                                                                                                          
 qemu changes:                                                                                                            

Jason Baron (2):
  qemu: virtio-net: use 64-bit values for feature flags
  qemu: add linkspeed and duplex settings to virtio-net

 hw/net/virtio-net.c                         | 83 +++++++++++++++++++----------
 include/hw/virtio/virtio-net.h              |  5 +-
 include/standard-headers/linux/virtio_net.h |  4 ++
 3 files changed, 64 insertions(+), 28 deletions(-)

Received: from eggs.gnu.org ([2001:4830:134:3::10]:48947)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jbaron@akamai.com>) id 1etmBo-0007wq-V3
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 22:25:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jbaron@akamai.com>) id 1etmBl-000304-OK
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 22:25:56 -0500
Received: from mx0a-00190b01.pphosted.com ([2620:100:9001:583::1]:59660)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jbaron@akamai.com>) id 1etmBl-0002zS-C0
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 22:25:53 -0500
From: Jason Baron <jbaron@akamai.com>
Date: Wed,  7 Mar 2018 22:25:38 -0500
Message-Id: <cover.1520450515.git.jbaron@akamai.com>
Subject: [Qemu-devel] [PATCH v2 0/3] virtio-net: allow linkspeed and duplex
 setting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, jasowang@redhat.com, virtio-dev@lists.oasis-open.org

Hi,

Linux can now read linkspeed and duplex settings as set by the
hypervisor:

faa9b39 virtio_net: propagate linkspeed/duplex settings from the hypervisor

This series thus adds qemu support.

Also, this patchset depends on this header sync:

https://lists.gnu.org/archive/html/qemu-devel/2018-02/msg07072.html

Thanks,

-Jason

v2
-pull in include/linux/ethtool.h (Michael Tsirkin)

Jason Baron (3):
  scripts/update-linux-headers: add ethtool.h and update to 4.16.0-rc4
  virtio-net: use 64-bit values for feature flags
  virtio-net: add linkspeed and duplex settings to virtio-net

 hw/net/virtio-net.c                      |   81 +-
 include/hw/virtio/virtio-net.h           |    5 +-
 include/standard-headers/linux/ethtool.h | 1821 ++++++++++++++++++++++++++++++
 include/standard-headers/linux/input.h   |    4 +-
 include/standard-headers/linux/kernel.h  |   15 +
 include/standard-headers/linux/sysinfo.h |   25 +
 linux-headers/asm-x86/kvm_para.h         |    1 +
 linux-headers/linux/kvm.h                |    2 +
 scripts/update-linux-headers.sh          |   11 +-
 9 files changed, 1934 insertions(+), 31 deletions(-)
 create mode 100644 include/standard-headers/linux/ethtool.h
 create mode 100644 include/standard-headers/linux/kernel.h
 create mode 100644 include/standard-headers/linux/sysinfo.h

-- 
2.7.4

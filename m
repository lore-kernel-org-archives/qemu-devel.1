Received: from eggs.gnu.org ([2001:4830:134:3::10]:39166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1gAbeB-0004g3-Ce
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 10:09:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1gAbe5-0005fn-Nr
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 10:09:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37538)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wexu@redhat.com>) id 1gAbe5-0005eN-HE
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 10:08:57 -0400
From: wexu@redhat.com
Date: Thu, 11 Oct 2018 10:08:23 -0400
Message-Id: <1539266915-15216-1-git-send-email-wexu@redhat.com>
Subject: [Qemu-devel] [RFC v3 00/12] packed ring virtio-net userspace
 backend support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jasowang@redhat.com, tiwei.bie@intel.com, wexu@redhat.com, jfreimann@redhat.com, maxime.coquelin@redhat.com

From: Wei Xu <wexu@redhat.com>

code base:
https://github.com/Whishay/qemu.git

Todo:
- migration has not been support yet

v2->v3
- addressed performance issue
- fixed feedback from v2

v1->v2
- sync to tiwei's v5
- reuse memory cache function with 1.0
- dropped detach patch and notification helper(04 & 05 in v1)
- guest virtio-net driver unload/reload support
- event suppression support(not tested)
- addressed feedback from v1

Wei Xu (12):
  virtio: introduce packed ring definitions
  virtio: redefine structure & memory cache for packed ring
  virtio: init memory cache for packed ring
  virtio: init wrap counter for packed ring
  virtio: init and desc empty check for packed ring
  virtio: get avail bytes check for packed ring
  virtio: fill/flush/pop for packed ring
  virtio: event suppression support for packed ring
  virtio-net: fill head desc after done all in a chain
  virtio: packed ring feature bit for userspace backend
  virtio: enable packed ring via a new command line
  virtio: feature vhost-net support for packed ring

 hw/net/vhost_net.c                             |   1 +
 hw/net/virtio-net.c                            |  11 +-
 hw/virtio/vhost.c                              |  19 +-
 hw/virtio/virtio.c                             | 685 +++++++++++++++++++++++--
 include/hw/virtio/virtio.h                     |   9 +-
 include/standard-headers/linux/virtio_config.h |  15 +
 include/standard-headers/linux/virtio_ring.h   |  43 ++
 7 files changed, 736 insertions(+), 47 deletions(-)

-- 
1.8.3.1

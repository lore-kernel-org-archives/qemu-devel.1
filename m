Received: from eggs.gnu.org ([2001:4830:134:3::10]:54156)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1f3hx3-00017S-OU
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 08:55:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wexu@redhat.com>) id 1f3hwz-0005X9-G1
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 08:55:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33808 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wexu@redhat.com>) id 1f3hwz-0005WL-20
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 08:55:41 -0400
From: wexu@redhat.com
Date: Wed,  4 Apr 2018 20:53:56 +0800
Message-Id: <1522846444-31725-1-git-send-email-wexu@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 0/8] virtio-net 1.1 userspace backend
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: wexu@redhat.com, jasowang@redhat.com, mst@redhat.com, tiwei.bie@intel.com, jfreimann@redhat.com, qemu-devel@nongnu.org

From: Wei Xu <wexu@redhat.com>

This is a prototype for virtio-net 1.1 support in userspace backend,
only minimum part are included in this RFC(roughly synced to v8 as
Jason and Tiwei's RFC).

Test has been done together with Tiwei's RFC guest virtio-net driver
patch, ping and a quick iperf test successfully.

Issues:
1. Rx performance of Iperf is much slower than TX.
    TX: 13-15Gb
    RX: 100-300Mb

Missing:
- device and driver
- indirect descriptor
- migration
- vIOMMU support
- other revisions since v8
- see FIXME

Wei Xu (8):
  virtio: feature bit, data structure for packed ring
  virtio: memory cache for packed ring
  virtio: add empty check for packed ring
  virtio: add detach element for packed ring(1.1)
  virtio: notification tweak for packed ring
  virtio: flush/push support for packed ring
  virtio: get avail bytes check for packed ring
  virtio: queue pop support for packed ring

 hw/virtio/virtio.c                             | 618 +++++++++++++++++++++++--
 include/hw/virtio/virtio.h                     |  12 +-
 include/standard-headers/linux/virtio_config.h |   2 +
 3 files changed, 601 insertions(+), 31 deletions(-)

-- 
2.7.4

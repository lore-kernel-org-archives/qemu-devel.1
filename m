Received: from eggs.gnu.org ([2001:4830:134:3::10]:54372)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1eVCtO-0005fh-VB
	for qemu-devel@nongnu.org; Sat, 30 Dec 2017 03:53:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1eVCtL-00040e-TA
	for qemu-devel@nongnu.org; Sat, 30 Dec 2017 03:53:23 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2059 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jianjay.zhou@huawei.com>)
	id 1eVCtL-0003tM-Gh
	for qemu-devel@nongnu.org; Sat, 30 Dec 2017 03:53:19 -0500
From: Jay Zhou <jianjay.zhou@huawei.com>
Date: Sat, 30 Dec 2017 16:52:09 +0800
Message-ID: <1514623933-25568-1-git-send-email-jianjay.zhou@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 0/4] cryptodev: add vhost support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, pbonzini@redhat.com, weidong.huang@huawei.com, stefanha@redhat.com, jianjay.zhou@huawei.com, pasic@linux.vnet.ibm.com, longpeng2@huawei.com, xin.zeng@intel.com, roy.fan.zhang@intel.com, arei.gonglei@huawei.com

From: Gonglei <arei.gonglei@huawei.com>

I posted the RFC verion five months ago for DPDK
vhost-crypto implmention, and now it's time to send
the formal version. Because we need an user space scheme
for better performance.

The vhost user crypto server side patches had been
sent to DPDK community, pls see

[RFC PATCH 0/6] lib/librte_vhost: introduce new vhost_user crypto backend
support
http://dpdk.org/ml/archives/dev/2017-November/081048.html

You also can get virtio-crypto polling mode driver from:

[PATCH] virtio: add new driver for crypto devices
http://dpdk.org/ml/archives/dev/2017-November/081985.html

Gonglei (4):
  cryptodev: add vhost-user as a new cryptodev backend
  cryptodev: add vhost support
  cryptodev-vhost-user: add crypto session handler
  cryptodev-vhost-user: set the key length

 backends/Makefile.objs                |   4 +
 backends/cryptodev-builtin.c          |   1 +
 backends/cryptodev-vhost-user.c       | 381 ++++++++++++++++++++++++++++++++++
 backends/cryptodev-vhost.c            | 297 ++++++++++++++++++++++++++
 docs/interop/vhost-user.txt           |  19 ++
 hw/virtio/Makefile.objs               |   2 +-
 hw/virtio/vhost-user.c                |  89 ++++++++
 hw/virtio/virtio-crypto.c             |  70 +++++++
 include/hw/virtio/vhost-backend.h     |   8 +
 include/hw/virtio/virtio-crypto.h     |   1 +
 include/sysemu/cryptodev-vhost-user.h |  47 +++++
 include/sysemu/cryptodev-vhost.h      | 154 ++++++++++++++
 include/sysemu/cryptodev.h            |   8 +
 qemu-options.hx                       |  21 ++
 vl.c                                  |   4 +
 15 files changed, 1105 insertions(+), 1 deletion(-)
 create mode 100644 backends/cryptodev-vhost-user.c
 create mode 100644 backends/cryptodev-vhost.c
 create mode 100644 include/sysemu/cryptodev-vhost-user.h
 create mode 100644 include/sysemu/cryptodev-vhost.h

--
1.8.3.1

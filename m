Received: from eggs.gnu.org ([2001:4830:134:3::10]:45810)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1dWKD2-0000pQ-HD
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 06:22:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1dWKCz-0005R1-Ce
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 06:22:00 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:4345)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1dWKCy-0005QO-QR
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 06:21:57 -0400
From: Gonglei <arei.gonglei@huawei.com>
Date: Sat, 15 Jul 2017 18:21:07 +0800
Message-ID: <1500114070-181004-1-git-send-email-arei.gonglei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [RFC 0/3] cryptodev: add vhost support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, weidong.huang@huawei.com, stefanha@redhat.com, roy.fan.zhang@intel.com, xin.zeng@intel.com, linqiangmin@huawei.com, marcandre.lureau@redhat.com, pasic@linux.vnet.ibm.com, longpeng2@huawei.com, jianjay.zhou@huawei.com, Gonglei <arei.gonglei@huawei.com>

Because the cryptodev-builtin beckend doesn't fit
in production environment as its' poor performance.

And the Intel guys are working on the DPDK vhost-crypto
implementation. So let us push the cryptodev-vhost-user
backend upstream so that the whole process can be
accelerated.

This is a RFC version, pls review.

Gonglei (3):
  cryptodev: add vhost-user as a new cryptodev backend
  cryptodev: add vhost support
  cryptodev-vhost-user: add crypto session handler

 backends/Makefile.objs                |   1 +
 backends/cryptodev-builtin.c          |   1 +
 backends/cryptodev-vhost-user.c       | 377 ++++++++++++++++++++++++++++++++++
 backends/cryptodev-vhost.c            | 297 ++++++++++++++++++++++++++
 docs/interop/vhost-user.txt           |  19 ++
 hw/virtio/vhost-user.c                |  89 ++++++++
 hw/virtio/virtio-crypto.c             |  70 +++++++
 include/hw/virtio/vhost-backend.h     |   8 +
 include/hw/virtio/virtio-crypto.h     |   1 +
 include/sysemu/cryptodev-vhost-user.h |  44 ++++
 include/sysemu/cryptodev-vhost.h      | 154 ++++++++++++++
 include/sysemu/cryptodev.h            |   8 +
 qemu-options.hx                       |  21 ++
 vl.c                                  |   4 +
 14 files changed, 1094 insertions(+)
 create mode 100644 backends/cryptodev-vhost-user.c
 create mode 100644 backends/cryptodev-vhost.c
 create mode 100644 include/sysemu/cryptodev-vhost-user.h
 create mode 100644 include/sysemu/cryptodev-vhost.h

-- 
1.8.3.1

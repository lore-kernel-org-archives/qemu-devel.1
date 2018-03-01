Received: from eggs.gnu.org ([2001:4830:134:3::10]:48252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1erOYH-0002js-Tk
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 08:47:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1erOYE-00018N-QZ
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 08:47:17 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2092 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jianjay.zhou@huawei.com>)
	id 1erOYE-00017S-EW
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 08:47:14 -0500
From: Jay Zhou <jianjay.zhou@huawei.com>
Date: Thu, 1 Mar 2018 21:46:27 +0800
Message-ID: <cover.1519910384.git.arei.gonglei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH RESEND v8 0/4] cryptodev: add vhost support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, pbonzini@redhat.com, weidong.huang@huawei.com, stefanha@redhat.com, jianjay.zhou@huawei.com, pasic@linux.vnet.ibm.com, longpeng2@huawei.com, xin.zeng@intel.com, roy.fan.zhang@intel.com, arei.gonglei@huawei.com, wangxinxin.wang@huawei.com

From: Gonglei <arei.gonglei@huawei.com>

I posted the RFC verion a few months ago for DPDK
vhost-crypto implmention, and now it's time to send
the formal version. Because we need an user space scheme
for better performance.

The vhost user crypto server side patches had been
sent to DPDK community, pls see

[PATCH v2 00/10] lib/librte_vhost: introduce new vhost user
crypto backend support
https://dpdk.org/ml/archives/dev/2018-February/091594.html

You also can get virtio-crypto polling mode driver from:

[PATCH v2 0/7] crypto: add virtio poll mode driver
http://dpdk.org/ml/archives/dev/2018-February/091410.html

v8:
  - make cryptodev-vhost.c complied linux independently
  - move CONFIG_VHOST_CRYPTO to host makefile
v7:
  - make virtio crypto enabled on non-Linux
  - fix format-string issues
  - fix error reported by clang
  - fix a typo when setting length of cipher key
  - rebased on the master
v6:
  - Fix compile error about backends/cryptodev-vhost-user.o and rebase on
    the master
v5:
  - squash [PATCH v4 5/5] into previous patches [Michael]
v4:
  - "[PATCH v4 5/5] cryptodev-vhost-user: depend on CONFIG_VHOST_CRYPTO
    and CONFIG_VHOST_USER" newly added to fix compilation dependency [Michael]
v3:
  - New added vhost user messages should be sent only when feature
    has been successfully negotiated [Michael]
v2:
  - Fix compile error on mingw32

Gonglei (4):
  cryptodev: add vhost-user as a new cryptodev backend
  cryptodev: add vhost support
  cryptodev-vhost-user: add crypto session handler
  cryptodev-vhost-user: set the key length

 backends/Makefile.objs                |   6 +
 backends/cryptodev-builtin.c          |   1 +
 backends/cryptodev-vhost-user.c       | 377 ++++++++++++++++++++++++++++++++++
 backends/cryptodev-vhost.c            | 347 +++++++++++++++++++++++++++++++
 configure                             |  15 ++
 docs/interop/vhost-user.txt           |  26 +++
 hw/virtio/vhost-user.c                | 104 ++++++++++
 hw/virtio/virtio-crypto.c             |  70 +++++++
 include/hw/virtio/vhost-backend.h     |   8 +
 include/hw/virtio/virtio-crypto.h     |   1 +
 include/sysemu/cryptodev-vhost-user.h |  47 +++++
 include/sysemu/cryptodev-vhost.h      | 154 ++++++++++++++
 include/sysemu/cryptodev.h            |   8 +
 qemu-options.hx                       |  21 ++
 vl.c                                  |   6 +
 15 files changed, 1191 insertions(+)
 create mode 100644 backends/cryptodev-vhost-user.c
 create mode 100644 backends/cryptodev-vhost.c
 create mode 100644 include/sysemu/cryptodev-vhost-user.h
 create mode 100644 include/sysemu/cryptodev-vhost.h

--
1.8.3.1

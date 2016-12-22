Received: from eggs.gnu.org ([2001:4830:134:3::10]:48180)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cJtp5-0006ED-8P
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 22:13:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cJtp4-0000Iv-DD
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 22:13:39 -0500
Received: from szxga01-in.huawei.com ([58.251.152.64]:48726)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1cJtp3-0000FC-Um
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 22:13:38 -0500
From: Gonglei <arei.gonglei@huawei.com>
Date: Thu, 22 Dec 2016 11:12:37 +0800
Message-ID: <1482376362-13804-1-git-send-email-arei.gonglei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH RESEND 0/5] hotplugging support for both
 cryptdoev and virtio crypto device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, Gonglei <arei.gonglei@huawei.com>

The patch set make the cryptodev object can be hot plugging
in safety, and which are preparing works for virtio-crypto
device hotplugging.

Patch 5 opens the hotplugging capability for virtio crypto
device.

Gonglei (5):
  cryptodev: introduce a new is_used property
  cryptodev: wrap the ready flag
  virtio-crypto-pci: add check for cryptodev object
  virtio-crypto: avoid one cryptodev device is used by multiple virtio
    crypto devices
  virtio-crypto-pci: tag virtio-crypto device hot pluggable

 backends/cryptodev-builtin.c  |  4 ++++
 backends/cryptodev.c          | 34 ++++++++++++++++++++++++++++++----
 hw/virtio/virtio-crypto-pci.c |  6 +++++-
 hw/virtio/virtio-crypto.c     | 22 +++++++++++++++++++---
 include/sysemu/cryptodev.h    | 42 ++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 100 insertions(+), 8 deletions(-)

-- 
1.8.3.1

Received: from eggs.gnu.org ([208.118.235.92]:59000)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@trasno.org>) id 1gf3ha-0005ju-Rt
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 09:10:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@trasno.org>) id 1gf3hX-0008Q3-J5
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 09:10:26 -0500
Received: from trasno.trasno.org ([83.165.45.250]:43068 helo=mail.trasno.org)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@trasno.org>) id 1gf3hX-0008PE-BI
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 09:10:23 -0500
From: Juan Quintela <quintela@redhat.com>
Date: Thu,  3 Jan 2019 15:09:57 +0100
Message-Id: <20190103141013.18019-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 00/16] Virtio devices split from virtio-pci
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Gonglei <arei.gonglei@huawei.com>, Juan Quintela <quintela@redhat.com>

Hi

v4:
- rebase to master (have conflict with other changes)

v3:
- rebase to master
- only compile them if CONFIG_PCI is set (thomas)

Please review.

Later, Juan.

V2:

- Rebase on top of master

Please review.

Later, Juan.

[v1]
>From previous verision (in the middle of make check tests):
- split also the bits of virtio-pci.h (mst suggestion)
- add gpu, crypt and gpg bits
- more cleanups
- fix all the copyrights (the ones not changed have been there
  foverever)
- be consistent with naming, vhost-* or virtio-*

Please review, Juan.

Juan Quintela (16):
  virtio: split vhost vsock bits from virtio-pci
  virtio: split virtio input host bits from virtio-pci
  virtio: split virtio input bits from virtio-pci
  virtio: split virtio rng bits from virtio-pci
  virtio: split virtio balloon bits from virtio-pci
  virtio: split virtio 9p bits from virtio-pci
  virtio: split vhost user blk bits from virtio-pci
  virtio: split vhost user scsi bits from virtio-pci
  virtio: split vhost scsi bits from virtio-pci
  virtio: split virtio scsi bits from virtio-pci
  virtio: split virtio blk bits rom virtio-pci
  virtio: split virtio net bits rom virtio-pci
  virtio: split virtio serial bits rom virtio-pci
  virtio: split virtio gpu bits rom virtio-pci.h
  virtio: split virtio crypto bits rom virtio-pci.h
  virtio: virtio 9p really requires CONFIG_VIRTFS to work

 default-configs/virtio.mak        |   3 +-
 hw/display/virtio-gpu-pci.c       |  14 +
 hw/display/virtio-vga.c           |   1 +
 hw/virtio/Makefile.objs           |  15 +
 hw/virtio/vhost-scsi-pci.c        |  97 ++++
 hw/virtio/vhost-user-blk-pci.c    | 103 ++++
 hw/virtio/vhost-user-scsi-pci.c   | 103 ++++
 hw/virtio/vhost-vsock-pci.c       |  86 ++++
 hw/virtio/virtio-9p-pci.c         |  88 ++++
 hw/virtio/virtio-balloon-pci.c    |  95 ++++
 hw/virtio/virtio-blk-pci.c        | 100 ++++
 hw/virtio/virtio-crypto-pci.c     |  14 +
 hw/virtio/virtio-input-host-pci.c |  48 ++
 hw/virtio/virtio-input-pci.c      | 157 ++++++
 hw/virtio/virtio-net-pci.c        |  98 ++++
 hw/virtio/virtio-pci.c            | 811 +-----------------------------
 hw/virtio/virtio-pci.h            | 234 ---------
 hw/virtio/virtio-rng-pci.c        |  88 ++++
 hw/virtio/virtio-scsi-pci.c       | 107 ++++
 hw/virtio/virtio-serial-pci.c     | 115 +++++
 tests/Makefile.include            |  20 +-
 21 files changed, 1342 insertions(+), 1055 deletions(-)
 create mode 100644 hw/virtio/vhost-scsi-pci.c
 create mode 100644 hw/virtio/vhost-user-blk-pci.c
 create mode 100644 hw/virtio/vhost-user-scsi-pci.c
 create mode 100644 hw/virtio/vhost-vsock-pci.c
 create mode 100644 hw/virtio/virtio-9p-pci.c
 create mode 100644 hw/virtio/virtio-balloon-pci.c
 create mode 100644 hw/virtio/virtio-blk-pci.c
 create mode 100644 hw/virtio/virtio-input-host-pci.c
 create mode 100644 hw/virtio/virtio-input-pci.c
 create mode 100644 hw/virtio/virtio-net-pci.c
 create mode 100644 hw/virtio/virtio-rng-pci.c
 create mode 100644 hw/virtio/virtio-scsi-pci.c
 create mode 100644 hw/virtio/virtio-serial-pci.c

-- 
2.20.1

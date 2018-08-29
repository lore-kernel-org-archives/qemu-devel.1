Received: from eggs.gnu.org ([2001:4830:134:3::10]:42929)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fuyqy-0001kp-Pf
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 07:41:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fuynB-0007Kr-BL
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 07:37:48 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56590 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fuynB-0007Kc-4x
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 07:37:45 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3E5148574E
	for <qemu-devel@nongnu.org>; Wed, 29 Aug 2018 11:37:44 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 29 Aug 2018 13:37:14 +0200
Message-Id: <20180829113730.14992-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 00/16] Virtio devices split from virtio-pci
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com, mst@redhat.com

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
 hw/virtio/Makefile.objs           |  14 +-
 hw/virtio/vhost-scsi-pci.c        |  95 ++++
 hw/virtio/vhost-user-blk-pci.c    | 101 ++++
 hw/virtio/vhost-user-scsi-pci.c   | 101 ++++
 hw/virtio/vhost-vsock-pci.c       |  82 ++++
 hw/virtio/virtio-9p-pci.c         |  86 ++++
 hw/virtio/virtio-balloon-pci.c    |  94 ++++
 hw/virtio/virtio-blk-pci.c        |  97 ++++
 hw/virtio/virtio-crypto-pci.c     |  14 +
 hw/virtio/virtio-input-host-pci.c |  45 ++
 hw/virtio/virtio-input-pci.c      | 154 ++++++
 hw/virtio/virtio-net-pci.c        |  96 ++++
 hw/virtio/virtio-pci.c            | 783 ------------------------------
 hw/virtio/virtio-pci.h            | 234 ---------
 hw/virtio/virtio-rng-pci.c        |  86 ++++
 hw/virtio/virtio-scsi-pci.c       | 106 ++++
 hw/virtio/virtio-serial-pci.c     | 112 +++++
 tests/Makefile.include            |  34 +-
 21 files changed, 1316 insertions(+), 1036 deletions(-)
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
2.17.1

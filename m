Received: from eggs.gnu.org ([2001:4830:134:3::10]:45628)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gYchC-0001Mi-7a
	for qemu-devel@nongnu.org; Sun, 16 Dec 2018 15:07:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gYch9-00049u-3s
	for qemu-devel@nongnu.org; Sun, 16 Dec 2018 15:07:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51586)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gYch8-00045b-QT
	for qemu-devel@nongnu.org; Sun, 16 Dec 2018 15:07:23 -0500
Date: Sun, 16 Dec 2018 15:07:16 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181216150359-mutt-send-email-mst@kernel.org>
References: <20181213210057.3676-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181213210057.3676-1-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 00/16] Virtio devices split from
 virtio-pci
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Gonglei <arei.gonglei@huawei.com>

Thanks!
I'd like to apply this but there's a conflict with other stuff queued.

Could you pls rebase on top of pci in git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git

Alternatively wait until after the next pull request.

Thanks and sorry for all the churn!

On Thu, Dec 13, 2018 at 10:00:41PM +0100, Juan Quintela wrote:
> Hi
> 
> v3:
> - rebase to master
> - only compile them if CONFIG_PCI is set (thomas)
> 
> Please review.
> 
> Later, Juan.
> 
> V2:
> 
> - Rebase on top of master
> 
> Please review.
> 
> Later, Juan.
> 
> [v1]
> >From previous verision (in the middle of make check tests):
> - split also the bits of virtio-pci.h (mst suggestion)
> - add gpu, crypt and gpg bits
> - more cleanups
> - fix all the copyrights (the ones not changed have been there
>   foverever)
> - be consistent with naming, vhost-* or virtio-*
> 
> Please review, Juan.
> 
> Juan Quintela (16):
>   virtio: split vhost vsock bits from virtio-pci
>   virtio: split virtio input host bits from virtio-pci
>   virtio: split virtio input bits from virtio-pci
>   virtio: split virtio rng bits from virtio-pci
>   virtio: split virtio balloon bits from virtio-pci
>   virtio: split virtio 9p bits from virtio-pci
>   virtio: split vhost user blk bits from virtio-pci
>   virtio: split vhost user scsi bits from virtio-pci
>   virtio: split vhost scsi bits from virtio-pci
>   virtio: split virtio scsi bits from virtio-pci
>   virtio: split virtio blk bits rom virtio-pci
>   virtio: split virtio net bits rom virtio-pci
>   virtio: split virtio serial bits rom virtio-pci
>   virtio: split virtio gpu bits rom virtio-pci.h
>   virtio: split virtio crypto bits rom virtio-pci.h
>   virtio: virtio 9p really requires CONFIG_VIRTFS to work
> 
>  default-configs/virtio.mak        |   3 +-
>  hw/display/virtio-gpu-pci.c       |  14 +
>  hw/display/virtio-vga.c           |   1 +
>  hw/virtio/Makefile.objs           |  15 +
>  hw/virtio/vhost-scsi-pci.c        |  95 ++++
>  hw/virtio/vhost-user-blk-pci.c    | 101 ++++
>  hw/virtio/vhost-user-scsi-pci.c   | 101 ++++
>  hw/virtio/vhost-vsock-pci.c       |  82 ++++
>  hw/virtio/virtio-9p-pci.c         |  86 ++++
>  hw/virtio/virtio-balloon-pci.c    |  94 ++++
>  hw/virtio/virtio-blk-pci.c        |  97 ++++
>  hw/virtio/virtio-crypto-pci.c     |  14 +
>  hw/virtio/virtio-input-host-pci.c |  45 ++
>  hw/virtio/virtio-input-pci.c      | 154 ++++++
>  hw/virtio/virtio-net-pci.c        |  96 ++++
>  hw/virtio/virtio-pci.c            | 783 ------------------------------
>  hw/virtio/virtio-pci.h            | 234 ---------
>  hw/virtio/virtio-rng-pci.c        |  86 ++++
>  hw/virtio/virtio-scsi-pci.c       | 106 ++++
>  hw/virtio/virtio-serial-pci.c     | 112 +++++
>  tests/Makefile.include            |  20 +-
>  21 files changed, 1311 insertions(+), 1028 deletions(-)
>  create mode 100644 hw/virtio/vhost-scsi-pci.c
>  create mode 100644 hw/virtio/vhost-user-blk-pci.c
>  create mode 100644 hw/virtio/vhost-user-scsi-pci.c
>  create mode 100644 hw/virtio/vhost-vsock-pci.c
>  create mode 100644 hw/virtio/virtio-9p-pci.c
>  create mode 100644 hw/virtio/virtio-balloon-pci.c
>  create mode 100644 hw/virtio/virtio-blk-pci.c
>  create mode 100644 hw/virtio/virtio-input-host-pci.c
>  create mode 100644 hw/virtio/virtio-input-pci.c
>  create mode 100644 hw/virtio/virtio-net-pci.c
>  create mode 100644 hw/virtio/virtio-rng-pci.c
>  create mode 100644 hw/virtio/virtio-scsi-pci.c
>  create mode 100644 hw/virtio/virtio-serial-pci.c
> 
> -- 
> 2.19.2

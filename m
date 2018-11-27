Received: from eggs.gnu.org ([2001:4830:134:3::10]:60265)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gRbhd-0004Zu-AA
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 06:38:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gRbhY-00060k-Cf
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 06:38:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54312)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gRbhY-0005zY-24
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 06:38:48 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0AA4089AC3
	for <qemu-devel@nongnu.org>; Tue, 27 Nov 2018 11:38:46 +0000 (UTC)
Date: Tue, 27 Nov 2018 11:38:33 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20181127113832.GA2616@work-vm>
References: <20181126200009.862-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181126200009.862-1-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 00/16] Virtio devices split from
 virtio-pci
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>, mst@redhat.com, stefanha@redhat.com
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, peterx@redhat.com

* Juan Quintela (quintela@redhat.com) wrote:
> Hi
> 
> V2:
> 
> - Rebase on top of master
> 
> Please review.

cc'ing in mst and Stefan; this is all virtio stuff.

Dave

> Later, Juan.
> 
> 
> [v1]
> From previous verision (in the middle of make check tests):
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
>  hw/virtio/Makefile.objs           |  14 +-
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
>  tests/Makefile.include            |  18 +-
>  21 files changed, 1308 insertions(+), 1028 deletions(-)
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
> 2.19.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

Received: from eggs.gnu.org ([2001:4830:134:3::10]:41080)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1gY2UW-0007bp-By
	for qemu-devel@nongnu.org; Sat, 15 Dec 2018 00:27:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1gY2UT-0001Ca-4w
	for qemu-devel@nongnu.org; Sat, 15 Dec 2018 00:27:56 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:2869 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <arei.gonglei@huawei.com>)
	id 1gY2UR-0000rW-N9
	for qemu-devel@nongnu.org; Sat, 15 Dec 2018 00:27:53 -0500
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Sat, 15 Dec 2018 05:27:43 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DB1C9EF3@dggeml531-mbs.china.huawei.com>
References: <20181213210057.3676-1-quintela@redhat.com>
	<33183CC9F5247A488A2544077AF19020DB1BECBE@dggeml511-mbx.china.huawei.com>
	<20181214075249-mutt-send-email-mst@kernel.org>
In-Reply-To: <20181214075249-mutt-send-email-mst@kernel.org>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
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
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

> -----Original Message-----
> From: Michael S. Tsirkin [mailto:mst@redhat.com]
> Sent: Friday, December 14, 2018 8:53 PM
> To: Gonglei (Arei) <arei.gonglei@huawei.com>
> Cc: Juan Quintela <quintela@redhat.com>; qemu-devel@nongnu.org; Thomas
> Huth <thuth@redhat.com>; Gerd Hoffmann <kraxel@redhat.com>
> Subject: Re: [PATCH v3 00/16] Virtio devices split from virtio-pci
>=20
> On Fri, Dec 14, 2018 at 07:07:44AM +0000, Gonglei (Arei) wrote:
> >
> > > -----Original Message-----
> > > From: Juan Quintela [mailto:quintela@redhat.com]
> > > Sent: Friday, December 14, 2018 5:01 AM
> > > To: qemu-devel@nongnu.org
> > > Cc: Michael S. Tsirkin <mst@redhat.com>; Thomas Huth
> <thuth@redhat.com>;
> > > Gerd Hoffmann <kraxel@redhat.com>; Gonglei (Arei)
> > > <arei.gonglei@huawei.com>; Juan Quintela <quintela@redhat.com>
> > > Subject: [PATCH v3 00/16] Virtio devices split from virtio-pci
> > >
> > > Hi
> > >
> > > v3:
> > > - rebase to master
> > > - only compile them if CONFIG_PCI is set (thomas)
> > >
> > > Please review.
> > >
> > > Later, Juan.
> > >
> > > V2:
> > >
> > > - Rebase on top of master
> > >
> > > Please review.
> > >
> > > Later, Juan.
> > >
> > > [v1]
> > > From previous verision (in the middle of make check tests):
> > > - split also the bits of virtio-pci.h (mst suggestion)
> > > - add gpu, crypt and gpg bits
> > > - more cleanups
> > > - fix all the copyrights (the ones not changed have been there
> > >   foverever)
> > > - be consistent with naming, vhost-* or virtio-*
> > >
> > > Please review, Juan.
> > >
> > > Juan Quintela (16):
> > >   virtio: split vhost vsock bits from virtio-pci
> > >   virtio: split virtio input host bits from virtio-pci
> > >   virtio: split virtio input bits from virtio-pci
> > >   virtio: split virtio rng bits from virtio-pci
> > >   virtio: split virtio balloon bits from virtio-pci
> > >   virtio: split virtio 9p bits from virtio-pci
> > >   virtio: split vhost user blk bits from virtio-pci
> > >   virtio: split vhost user scsi bits from virtio-pci
> > >   virtio: split vhost scsi bits from virtio-pci
> > >   virtio: split virtio scsi bits from virtio-pci
> > >   virtio: split virtio blk bits rom virtio-pci
> > >   virtio: split virtio net bits rom virtio-pci
> > >   virtio: split virtio serial bits rom virtio-pci
> > >   virtio: split virtio gpu bits rom virtio-pci.h
> > >   virtio: split virtio crypto bits rom virtio-pci.h
> > >   virtio: virtio 9p really requires CONFIG_VIRTFS to work
> > >
> > >  default-configs/virtio.mak        |   3 +-
> > >  hw/display/virtio-gpu-pci.c       |  14 +
> > >  hw/display/virtio-vga.c           |   1 +
> > >  hw/virtio/Makefile.objs           |  15 +
> > >  hw/virtio/vhost-scsi-pci.c        |  95 ++++
> > >  hw/virtio/vhost-user-blk-pci.c    | 101 ++++
> > >  hw/virtio/vhost-user-scsi-pci.c   | 101 ++++
> > >  hw/virtio/vhost-vsock-pci.c       |  82 ++++
> > >  hw/virtio/virtio-9p-pci.c         |  86 ++++
> > >  hw/virtio/virtio-balloon-pci.c    |  94 ++++
> > >  hw/virtio/virtio-blk-pci.c        |  97 ++++
> > >  hw/virtio/virtio-crypto-pci.c     |  14 +
> > >  hw/virtio/virtio-input-host-pci.c |  45 ++
> > >  hw/virtio/virtio-input-pci.c      | 154 ++++++
> > >  hw/virtio/virtio-net-pci.c        |  96 ++++
> > >  hw/virtio/virtio-pci.c            | 783 ----------------------------=
--
> > >  hw/virtio/virtio-pci.h            | 234 ---------
> > >  hw/virtio/virtio-rng-pci.c        |  86 ++++
> > >  hw/virtio/virtio-scsi-pci.c       | 106 ++++
> > >  hw/virtio/virtio-serial-pci.c     | 112 +++++
> > >  tests/Makefile.include            |  20 +-
> > >  21 files changed, 1311 insertions(+), 1028 deletions(-)
> > >  create mode 100644 hw/virtio/vhost-scsi-pci.c
> > >  create mode 100644 hw/virtio/vhost-user-blk-pci.c
> > >  create mode 100644 hw/virtio/vhost-user-scsi-pci.c
> > >  create mode 100644 hw/virtio/vhost-vsock-pci.c
> > >  create mode 100644 hw/virtio/virtio-9p-pci.c
> > >  create mode 100644 hw/virtio/virtio-balloon-pci.c
> > >  create mode 100644 hw/virtio/virtio-blk-pci.c
> > >  create mode 100644 hw/virtio/virtio-input-host-pci.c
> > >  create mode 100644 hw/virtio/virtio-input-pci.c
> > >  create mode 100644 hw/virtio/virtio-net-pci.c
> > >  create mode 100644 hw/virtio/virtio-rng-pci.c
> > >  create mode 100644 hw/virtio/virtio-scsi-pci.c
> > >  create mode 100644 hw/virtio/virtio-serial-pci.c
> > >
> > > --
> > > 2.19.2
> >
> > For series:
> > 	Reviewed-by: Gonglei <arei.gonglei@huawei.com>
> >
> >
> > Thanks,
> > -Gonglei
>=20
> Thanks!
> Can you pls align Reviewed-by: tag at the 1st column in the future?
> Makes it easier to apply the tag.

OK, I will, thanks :)

Thanks,
-Gonglei

Received: from eggs.gnu.org ([208.118.235.92]:59692)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gedTf-0001VZ-PY
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 05:10:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gedTa-0006pz-Tq
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 05:10:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40202)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1gedTa-0006pA-LE
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 05:10:14 -0500
Date: Wed, 2 Jan 2019 10:10:06 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190102101006.GD24009@stefanha-x1.localdomain>
References: <20181213210057.3676-1-quintela@redhat.com>
	<20181213210057.3676-10-quintela@redhat.com>
	<6793abab-886c-b8f4-fe5f-a94150119f5f@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/3yNEOqWowh/8j+e"
Content-Disposition: inline
In-Reply-To: <6793abab-886c-b8f4-fe5f-a94150119f5f@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 09/16] virtio: split vhost scsi bits
 from virtio-pci
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org, Nicholas Bellinger <nab@risingtidesystems.com>, "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Gonglei <arei.gonglei@huawei.com>


--/3yNEOqWowh/8j+e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 14, 2018 at 10:19:38AM +0100, Thomas Huth wrote:
> On 2018-12-13 22:00, Juan Quintela wrote:
> > Reviewed-by: Laurent Vivier <lvivier@redhat.com>
> > Signed-off-by: Juan Quintela <quintela@redhat.com>
> > ---
> >  hw/virtio/Makefile.objs    |  1 +
> >  hw/virtio/vhost-scsi-pci.c | 95 ++++++++++++++++++++++++++++++++++++++
> >  hw/virtio/virtio-pci.c     | 59 -----------------------
> >  hw/virtio/virtio-pci.h     | 19 --------
> >  4 files changed, 96 insertions(+), 78 deletions(-)
> >  create mode 100644 hw/virtio/vhost-scsi-pci.c
> >=20
> > diff --git a/hw/virtio/Makefile.objs b/hw/virtio/Makefile.objs
> > index f851a6f2b5..0a56946c1a 100644
> > --- a/hw/virtio/Makefile.objs
> > +++ b/hw/virtio/Makefile.objs
> > @@ -15,6 +15,7 @@ ifeq ($(CONFIG_PCI),y)
> >  obj-$(CONFIG_VHOST_VSOCK) +=3D vhost-vsock-pci.o
> >  obj-$(CONFIG_VHOST_USER_BLK) +=3D vhost-user-blk-pci.o
> >  obj-$(CONFIG_VHOST_USER_SCSI) +=3D vhost-user-scsi-pci.o
> > +obj-$(CONFIG_VHOST_SCSI) +=3D vhost-scsi-pci.o
> >  obj-$(CONFIG_VIRTIO_INPUT_HOST) +=3D virtio-input-host-pci.o
> >  obj-$(CONFIG_VIRTIO_INPUT) +=3D virtio-input-pci.o
> >  obj-$(CONFIG_VIRTIO_RNG) +=3D virtio-rng-pci.o
> > diff --git a/hw/virtio/vhost-scsi-pci.c b/hw/virtio/vhost-scsi-pci.c
> > new file mode 100644
> > index 0000000000..2be2c567ea
> > --- /dev/null
> > +++ b/hw/virtio/vhost-scsi-pci.c
> > @@ -0,0 +1,95 @@
> > +/*
> > + * Vhost scsi PCI bindings
> > + *
> > + * Copyright IBM, Corp. 2011
> > + *
> > + * Authors:
> > + *  Stefan Hajnoczi   <stefanha@linux.vnet.ibm.com>
> > + *
> > + * Changes for QEMU mainline + tcm_vhost kernel upstream:
> > + *  Nicholas Bellinger <nab@risingtidesystems.com>
> > + *
> > + * This work is licensed under the terms of the GNU LGPL, version 2 or=
 later.
> > + * See the COPYING.LIB file in the top-level directory.
>=20
> Let's double-check: Stefan, Nicholas, should this file be LGPLv2.1+
> (like hw/scsi/vhost-scsi.c) or rather GPLv2+ (like hw/virtio/virtio-pci.c=
) ?

I had the LGPL in mind.

Stefan

--/3yNEOqWowh/8j+e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcLI3+AAoJEJykq7OBq3PIbO4IAJkODZxRt7v/IQugldwXDSfR
jvebN9JFi1Jgh10cExjkSWxxRPTzMbnra0/reEChqXbwzBXDN0SFH+xWjQ/bLr3O
kAr5hbDT9rj5cTv3RN1FOro8EeMFxiE6fXLLM//+KgenkKfQE8AJddfCUwIAt0pJ
jfffGq6fOilWSqXrmUp5Uf6JJsl1CNsx9xdz6aNTRvuaPs/gHAIaI1cB1mSJgvB7
W0hbGNtn9LSQm/wwgqChwQv96jTSiLI579hMARwUPsQHZXxR5oo3cutDmGjpZB8l
9ajkG5LafDJVOuMc1tNVpA2pj/VD34Rmz7VWtxwda+/UgDBocee16PlVzftvwME=
=dr3d
-----END PGP SIGNATURE-----

--/3yNEOqWowh/8j+e--

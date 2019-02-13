Received: from eggs.gnu.org ([209.51.188.92]:42767)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gtpSx-0005oT-1L
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 03:00:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gtpSw-0008Ja-1H
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 03:00:22 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:41165)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1gtpSv-0008IZ-QC
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 03:00:21 -0500
Received: by mail-pg1-x542.google.com with SMTP id m1so777589pgq.8
	for <qemu-devel@nongnu.org>; Wed, 13 Feb 2019 00:00:21 -0800 (PST)
Date: Wed, 13 Feb 2019 16:00:17 +0800
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190213080017.GD26332@stefanha-x1.localdomain>
References: <1550022537-27565-1-git-send-email-changpeng.liu@intel.com>
	<20190212210456-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="n2Pv11Ogg/Ox8ay5"
Content-Disposition: inline
In-Reply-To: <20190212210456-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [PATCH v4] virtio-blk: set correct config size for
 the host driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Changpeng Liu <changpeng.liu@intel.com>, ldoktor@redhat.com, dgilbert@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com, sgarzare@redhat.com


--n2Pv11Ogg/Ox8ay5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 12, 2019 at 09:05:11PM -0500, Michael S. Tsirkin wrote:
> On Wed, Feb 13, 2019 at 09:48:57AM +0800, Changpeng Liu wrote:
> > Commit caa1ee43 "vhost-user-blk: add discard/write zeroes features
> > support" added fields to struct virtio_blk_config. This changes
> > the size of the config space and breaks migration from QEMU 3.1
> > and older:
> >=20
> > qemu-system-ppc64: get_pci_config_device: Bad config data: i=3D0x10 rea=
d: 41 device: 1 cmask: ff wmask: 80 w1cmask:0
> > qemu-system-ppc64: Failed to load PCIDevice:config
> > qemu-system-ppc64: Failed to load virtio-blk:virtio
> > qemu-system-ppc64: error while loading state for instance 0x0 of device=
 'pci@800000020000000:01.0/virtio-blk'
> > qemu-system-ppc64: load of migration failed: Invalid argument
> >=20
> > Since virtio-blk doesn't support the "discard" and "write zeroes"
> > features, it shouldn't even expose the associated fields in the
> > config space actually. Just include all fields up to num_queues to
> > match QEMU 3.1 and older.
> >=20
> > Signed-off-by: Changpeng Liu <changpeng.liu@intel.com>
>=20
>=20
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
>=20
> Stefan, are you merging this?

Yes.

Stefan

--n2Pv11Ogg/Ox8ay5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcY86RAAoJEJykq7OBq3PIzr0H/13iV4FKVn3zvUP68hhpQXHL
EZrTaHSa02avRc6sxQ2n+5LwkjazzAQkxV1Z6U0xR+H8YbRjH/2Ag7d0un9+QIjZ
GQUddxeuDUICYjctE9v/KKjLIZC0iWr5YHoeIW+ZBUbXRjnUzqRweBl0GTyb1yBN
OAL7hNOyZBqcYUwPu0pYTaHM0se2mrVqLhqK4+1eJKlSC7LE4aROpmGW87FXiB6F
rc1pg7wbdBIrHMw4Iq1joHc4Ah8bU1cVLkoyZULCAzKguPZMAjEfFTQRYoH800Dn
HbqAjC1JeuA0DSwfn9lbkIM8wA5GnSX/r+EYkMoA40xm6JZL7ZYklnf1jAnYqoQ=
=0zQp
-----END PGP SIGNATURE-----

--n2Pv11Ogg/Ox8ay5--

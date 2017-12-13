Received: from eggs.gnu.org ([2001:4830:134:3::10]:58363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eP3wc-0005k9-Sh
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 05:07:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eP3wZ-0001Vh-R8
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 05:07:18 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:42087)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1eP3wZ-0001V5-K4
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 05:07:15 -0500
Received: by mail-wm0-x243.google.com with SMTP id b199so3872573wme.1
	for <qemu-devel@nongnu.org>; Wed, 13 Dec 2017 02:07:15 -0800 (PST)
Date: Wed, 13 Dec 2017 10:07:12 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20171213100712.GA16782@stefanha-x1.localdomain>
References: <20171213082644.83113-1-ben@skyportsystems.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="d6Gm4EdcadzBjdND"
Content-Disposition: inline
In-Reply-To: <20171213082644.83113-1-ben@skyportsystems.com>
Subject: Re: [Qemu-devel] [PATCH] virtio-pci: Add subsystem-vendor-id
 property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ben@skyportsystems.com
Cc: mst@redhat.com, qemu-devel@nongnu.org, yan@daynix.com, eswierk@skyportsystems.com, lprosek@redhat.com


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2017 at 12:26:44AM -0800, Ben Warren via Qemu-devel wrote:
> From: Ben Warren <ben@skyportsystems.com>
>=20
> Now that virtio-win guest drivers provided by non-Redhat vendors need to
> use a different Subsystem Vendor ID value, a way is needed to set this
> parameter on the host.  This works with all of the PCI-based devices,
> such as NetKVM, viostor, vioscsi, vioserial and balloon.
>=20
> Signed-off-by: Ben Warren <ben@skyportsystems.com>
> ---
>  hw/virtio/virtio-pci.c | 5 +++++
>  hw/virtio/virtio-pci.h | 1 +
>  2 files changed, 6 insertions(+)

Is it possible to put this property in hw/pci/pci.c:pci_props[] so that
users can override the Subsystem Vendor ID for any PCI adapter, not just
virtio-pci?

--d6Gm4EdcadzBjdND
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaMPvQAAoJEJykq7OBq3PIgmkH/iRsQWvGH3oOEVxPZB4OY45B
eh1jwCajQdJu6MSnFhM/C/9OaOoAPq97IyhM4+isgpARf9Zmo1ySyVRlvqpAv1ct
QiMwpuHcq4Hdu12VUmy2mvH6Ubsvn3CjshpJ8WYYOtJNg3HE/bwF+jFZaJ7phc0V
bKlsgxlkU/1KPazkZ79mFh6JeYxlwhCJX95+lRq3d4SEpkU8vsGehRjKD6lO/4k5
QQ/qa2s5xAOXS/egwKz2qb3whngp+mJHRzW+jLAwBl3y0GDWcVy7GaoeT3yIGuSF
pbTMR+7Q+Bo9+XAMbt44Mr562YQnDpbemAD8rf/p5QFOvlbO1aT5wQpWhBRV8l8=
=KmGD
-----END PGP SIGNATURE-----

--d6Gm4EdcadzBjdND--

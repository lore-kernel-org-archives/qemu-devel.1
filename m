Received: from eggs.gnu.org ([209.51.188.92]:54599)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hJe1g-0004Bv-Pq
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:02:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hJe1f-0008Ru-Q9
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:02:56 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:37427)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1hJe1f-0008R1-Gz
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:02:55 -0400
Received: by mail-wr1-x443.google.com with SMTP id t17so18506595wrr.4
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 06:02:55 -0700 (PDT)
Date: Thu, 25 Apr 2019 14:02:52 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190425130252.GA17806@stefanha-x1.localdomain>
References: <20190424152401.28304-1-stefanha@redhat.com>
	<20190424164447.GB18406@habkost.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GvXjxJ+pjyke8COw"
Content-Disposition: inline
In-Reply-To: <20190424164447.GB18406@habkost.net>
Subject: Re: [Qemu-devel] [PATCH] virtio: clarify VirtioPCIDeviceTypeInfo
 usage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, sebastien.boeuf@intel.com, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2019 at 01:44:47PM -0300, Eduardo Habkost wrote:
> On Wed, Apr 24, 2019 at 04:24:01PM +0100, Stefan Hajnoczi wrote:
> > How to use .base_name, .generic_name, .transitional_name, and
> > .non_transitional_name can be confusing.
> >=20
> > Existing devices have .generic_name but its behavior is somewhat magic.
> >=20
> > Devices added to new versions of the VIRTIO specification should forego
> > transitional mode completely and always operate in non-transitional mode
> > because there are no existing drivers for them that require backwards
> > compatibility.
> >=20
> > This patch adds comments that hopefully make it easier for developers to
> > decide how to fill out VirtioPCIDeviceTypeInfo.
> >=20
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >  hw/virtio/virtio-pci.h | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/hw/virtio/virtio-pci.h b/hw/virtio/virtio-pci.h
> > index 18581854ca..debdee28b3 100644
> > --- a/hw/virtio/virtio-pci.h
> > +++ b/hw/virtio/virtio-pci.h
> > @@ -209,7 +209,9 @@ typedef struct VirtioPCIDeviceTypeInfo {
> >       * Implements both INTERFACE_PCIE_DEVICE and INTERFACE_CONVENTIONA=
L_PCI_DEVICE,
> >       * but PCI Express is supported only in non-transitional mode.
> >       *
> > -     * The only type implemented by QEMU 3.1 and older.
> > +     * The only type implemented by QEMU 3.1 and older.  This type is =
less
> > +     * explicit than the transitional and non-transitional device type=
s.  Its
> > +     * behavior can be affected by machine type compat properties.
>=20
> I'm not sure what you mean here.  All types can be affected by
> machine type compat properties when necessary, don't they?

That's true.  I didn't realize that the compat properties are applied
after instance_init().

Will fix in v2.

--GvXjxJ+pjyke8COw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcwa/8AAoJEJykq7OBq3PIWi0H/3ZqK0ITByN1lq2o6Spg65zK
hqAcm5vYkcJ5E5HNtZQoQ+PfkT8v51yLrVYf1UbU0OVfYzmWeUeKwk5VOcJYxS4X
YBg5x7MQR8LOUxDgwYQYkNL2ID5FR8cTEAsxL8l/dqBVgm34nbxXfKfB2Zgmf1R/
STxmoTZwH/FPriS0Kr1S0nvHlJHWJBkZZw61GCML93lcUzz4k0N1NQiXGp8owLkN
wMD6xZCBto5TDYfXhO1bw2QN+u6NWvf1Rv0RNuUiw9sWPisyKk6yeiAyPcv70Ebh
tsIzQEiPTMHXk/URNI1HozjZGLvKhaH3pgfrI7NhL99FY0Td6+iHS/tyDRcB0IU=
=MKHc
-----END PGP SIGNATURE-----

--GvXjxJ+pjyke8COw--

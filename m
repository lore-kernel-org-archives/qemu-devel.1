Received: from eggs.gnu.org ([2001:4830:134:3::10]:38405)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dKxJt-00049l-Bh
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 21:42:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dKxJp-0000S2-6F
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 21:42:05 -0400
Date: Wed, 14 Jun 2017 09:36:11 +0800
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170614013611.GD13420@umbus>
References: <1497383329-10393-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hoZxPH4CaxYzWscb"
Content-Disposition: inline
In-Reply-To: <1497383329-10393-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] hw/pci-bridge/dec: Classify the DEC PCI
 bridge as bridge device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, qemu-ppc@nongnu.org, qemu-trivial@nongnu.org


--hoZxPH4CaxYzWscb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 13, 2017 at 09:48:49PM +0200, Thomas Huth wrote:
> This way the bridge shows up in the correct section of the
> "-device help" text.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/pci-bridge/dec.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/hw/pci-bridge/dec.c b/hw/pci-bridge/dec.c
> index cca9362..eb275e1 100644
> --- a/hw/pci-bridge/dec.c
> +++ b/hw/pci-bridge/dec.c
> @@ -62,6 +62,7 @@ static void dec_21154_pci_bridge_class_init(ObjectClass=
 *klass, void *data)
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
>      PCIDeviceClass *k =3D PCI_DEVICE_CLASS(klass);
> =20
> +    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
>      k->realize =3D dec_pci_bridge_realize;
>      k->exit =3D pci_bridge_exitfn;
>      k->vendor_id =3D PCI_VENDOR_ID_DEC;
> @@ -118,6 +119,7 @@ static void dec_21154_pci_host_class_init(ObjectClass=
 *klass, void *data)
>      PCIDeviceClass *k =3D PCI_DEVICE_CLASS(klass);
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
> =20
> +    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
>      k->realize =3D dec_21154_pci_host_realize;
>      k->vendor_id =3D PCI_VENDOR_ID_DEC;
>      k->device_id =3D PCI_DEVICE_ID_DEC_21154;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--hoZxPH4CaxYzWscb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZQJMJAAoJEGw4ysog2bOS+CQP/iiRgohOMBuOmgQg3bKB+iI0
c3464YW++ipoz509ZruxXJX8PPoZfZI4vP+BdLVRbE9GTWM6uw3U6x9T/AJTCrb+
4hmMLDhUBsvcMk7OsNKpqUqMNHJUE4P65z6S3ztuk23qb8YxN2ODT7tyY5hgk6cg
gJ+l+Cvdu2SM5aeUFK+vuiUckh/Vrl+04mxEJG2By6fZR6NRnssvimIgfdRzhYW+
Qyciwy7mrvq+MABvmGVDQwcMGpMCiDdAhEg+COlTahson/PqqPJ/eHeFoNGgoYd2
OKWye3/z7hS1t5XJ+JjxsdJJ8VXtzAi4nppdh0iM3Y/2n99OT83qYhJrVUBVe+QZ
9x80Z3BBQenp/jRC4H8s/PYVebl8rTeTRxXwNWCzc3dTATcmkGuUzrw/4I5lM4WM
uGDGv4Dnfuf8zWV+25MSwQSFmaaStYE7uq8NP12PGtu+2+4+6vjdp2U54UP/NyrN
1hcnZ9c2gsEQzCC5v4ZNxlGrjR9yeetEnjX3soSG5vtk0rxT+Mv0fybHAh/v8KL6
uc/n0MYRAgdwAyfWOtgmsAh+3QRvWAq0U/XcrQds1w0WquP7UzGolB+OPESIpEVD
LlOPeB0ksecouKSVJeyTWQJ+vBJNV+xM2rYlA64EXE1Ym6TqTTNAj2dKo9bjdZKo
azvV+hmu3xo+L8Y4/Xlf
=i3eW
-----END PGP SIGNATURE-----

--hoZxPH4CaxYzWscb--

Received: from eggs.gnu.org ([209.51.188.92]:51931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hBGkp-00018b-Pl
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 06:34:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hBGko-0000u4-L0
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 06:34:55 -0400
Date: Tue, 2 Apr 2019 21:34:07 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190402103407.GA7904@umbus.fritz.box>
References: <20190402054028.20926-1-david@gibson.dropbear.id.au>
	<20190402054028.20926-4-david@gibson.dropbear.id.au>
	<20190402091055.016165b6@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="d6Gm4EdcadzBjdND"
Content-Disposition: inline
In-Reply-To: <20190402091055.016165b6@bahia.lan>
Subject: Re: [Qemu-devel] [RFC for-4.1 3/5] pcie: Remove redundant test in
 pcie_mmcfg_data_read()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-ppc@nongnu.org, clg@kaod.org


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 02, 2019 at 09:10:55AM +0200, Greg Kurz wrote:
> On Tue,  2 Apr 2019 16:40:26 +1100
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > This function has an explicit test for accesses above the device's conf=
ig
> > size, in which case it returns ~0x0.  But pci_host_config_read_common()
> > which it is about to call already has checks against the config space
> > limit and likewise returns ~0x0 in that case.  So, remove the redundant
> > test.
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
> >  hw/pci/pcie_host.c | 5 -----
> >  1 file changed, 5 deletions(-)
> >=20
> > diff --git a/hw/pci/pcie_host.c b/hw/pci/pcie_host.c
> > index 553db56778..8f4435838e 100644
> > --- a/hw/pci/pcie_host.c
> > +++ b/hw/pci/pcie_host.c
> > @@ -70,11 +70,6 @@ static uint64_t pcie_mmcfg_data_read(void *opaque,
> >      }
> >      addr =3D PCIE_MMCFG_CONFOFFSET(mmcfg_addr);
> >      limit =3D pci_config_size(pci_dev);
> > -    if (limit <=3D addr) {
> > -        /* conventional pci device can be behind pcie-to-pci bridge.
> > -           256 <=3D addr < 4K has no effects. */
> > -        return ~0x0;
> > -    }
> >      return pci_host_config_read_common(pci_dev, addr, limit, len);
> >  }
> > =20
>=20
> It looks good but what about pcie_mmcfg_data_write(), which follows
> the same pattern ?

Oops, didn't spot that.  Adjusted for the next spin.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--d6Gm4EdcadzBjdND
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlyjOp0ACgkQbDjKyiDZ
s5J6IhAAmiJAGroww1Lu/2+jtliM09gwmoCQp+t9pdizRP25ktnQWpEtieFmJr8c
JRz7Vorerkx8ZhMSxIjV7Bj70eoRJA18HXshMbEzXhPJ2GUdAzYPXPO9SQbEQN4l
QeMOHnVo7CrONbtc19SkjPJM/9c/8fcxF7/o9W9d4Fojoruiygo9T7rSWjqIMJGK
vij3HuPZgjjE8P6B/ShvzEmYe+H7YPFYU3FNk98JFUKRcAtwBKZcfINKCkrQQoIf
nVJmtvqYBd0qmgOMJ8IwYeIUtUK5YBV0HgyIT+uZ0iNI7pCqlKjng+8lxHHCKGBs
/ClvkzgSt31P066gr4yu0vColChaKippDXdYVTNALtdGYjDITQR5qrAyH8x5FV0A
26DW0NpsEUTwFbK4HZTbc/FnDiL0MN+rFfBw0UplJ5JcCxTdtnl9xvlv415oSNWx
eVIg1IzlXnODCjQPBZbzZm6Yq1VIqyptgRZ5w4ldstoObByj6WOH5wG/OmTqnGpr
REZeRMoSfdhlYwUxtLIRMH9QQ6RdmBjcoezt/P+kz8YDKlxVZw/yaqpeHJ07WWhV
DxWlMlv+P/PbbjF7i0BUJ/L0zgDLjB6fhs+uWQxwiFp3a6ZApao61zVYRqpzjjGF
D+cCNt4lnwmBRbCY57xZ1lUjRPJ2MbuRE3C3POgL4L7qvxyMF2g=
=hllT
-----END PGP SIGNATURE-----

--d6Gm4EdcadzBjdND--

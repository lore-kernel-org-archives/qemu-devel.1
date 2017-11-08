Received: from eggs.gnu.org ([2001:4830:134:3::10]:59033)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eCKtm-0005ev-9M
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 02:35:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eCKtj-0000NY-6u
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 02:35:46 -0500
Date: Wed, 8 Nov 2017 17:08:45 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171108060845.GB7732@umbus.fritz.box>
References: <1510060738-25975-1-git-send-email-s1seetee@linux.vnet.ibm.com>
	<7426dac9-67bf-a70a-bb5b-307de4602263@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7ZAtKRhVyVSsbBD2"
Content-Disposition: inline
In-Reply-To: <7426dac9-67bf-a70a-bb5b-307de4602263@ozlabs.ru>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v1] spapr_pci: fix the path
 while fetching loc-code from host DT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>, agraf@suse.de, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--7ZAtKRhVyVSsbBD2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 08, 2017 at 01:30:04PM +1100, Alexey Kardashevskiy wrote:
> On 08/11/17 00:18, Seeteena Thoufeek wrote:
> > The function spapr_phb_vfio_get_loc_code uses wrong path for
> > fetching loc-code from host DT
> >=20
> > this is the call that needs to be fixed:
> > /* Construct and read from host device tree the loc-code */
> > path =3D g_strdup_printf("/proc/device-tree%s/ibm,loc-code", buf);
>=20
>=20
> I do not see why would extra '/' hurt but where does it really fail?
>=20
> My machines have leading '/' in devspec, do not yours?
>=20
> aik@garrison2:~$ cat /sys/bus/pci/devices/0009:03:00.0/devspec && echo -e=
 '\n'
> /pciex@3fffe40500000/pci@0/pci@0/pci@1/usb-xhci@0

Right, what Alexey said.  I see no reason to change this.

>=20
>=20
>=20
>=20
> >=20
> > Signed-off-by: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
> > ---
> >  hw/ppc/spapr_pci.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> > index 5a3122a..ae86322 100644
> > --- a/hw/ppc/spapr_pci.c
> > +++ b/hw/ppc/spapr_pci.c
> > @@ -762,7 +762,7 @@ static char *spapr_phb_vfio_get_loc_code(sPAPRPHBSt=
ate *sphb,  PCIDevice *pdev)
> >      g_free(path);
> > =20
> >      /* Construct and read from host device tree the loc-code */
> > -    path =3D g_strdup_printf("/proc/device-tree%s/ibm,loc-code", buf);
> > +    path =3D g_strdup_printf("/proc/device-tree/%s/ibm,loc-code", buf);
> >      g_free(buf);
> >      if (!g_file_get_contents(path, &buf, NULL, NULL)) {
> >          goto err_out;
> >=20
>=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--7ZAtKRhVyVSsbBD2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAloCn2sACgkQbDjKyiDZ
s5JkBg/8DFE5cyQx9v03rRkWTQF+cvlOZlM7tizJwvJGGerLZ2H/LEbdhSttmcVN
j/B0XN3EZrUjL5UPIbP2bQmXFKmin5awcf79Q45Qgbik+RILsI2q/hPFruO6sppW
RN/CsQ4hXfVJYNfDmPxR5yOMUWCsYXa2xzmI7c5mlAOoVlJyr+N3DSzfkrGU6gOz
C2RP5kdQnrzvOj//vZI2wL3lJjKARTtnsw+WF2b7mzREf5VCU7NTJmvZxSPM3QDc
wwt8/vSXyMISp9onxxEI8QlYMZGruIOL4MjzrK+eo2t06AEBG+kP33H15QhfQ8EB
9+k+o4QogD+msOT5D/9TqcKJdCw50/ET6397Gxd7Q4GR3y8USeahlfmc3WE4+YCc
PFJG6/m2U9GN/v1JD3k7A57rDyJ/ILlpe0kAMf19RYeuRV5/m1eCa/vox307MMp4
vDmawDi2t/39QjzFCDTcQ/ohPqKNCU7lFDQRukO7VM8BGivdk8mk7evoqBP4vHQx
4y7UY7+iuHHjOHy6Jr1SskoQrdow4aZHKmRtmtueDauDMrUOGnbCjNhqVz3eRKms
XeeFkIqsa9lMZjT8O1KpUJiDh0TS1bM6rHJfAkh06DOZ8WB4Px7HN64K5lmETIQ5
7qYjmtQQ29zB38lqeTqH7v+RCD6U2ur+4K0hpjUtWaOxJHaf59s=
=AbMD
-----END PGP SIGNATURE-----

--7ZAtKRhVyVSsbBD2--

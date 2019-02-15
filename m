Received: from eggs.gnu.org ([209.51.188.92]:36145)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1guULt-0008U6-DV
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 22:39:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1guU8j-0007Lp-Hy
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 22:26:14 -0500
Date: Fri, 15 Feb 2019 14:22:50 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190215032250.GF4573@umbus.fritz.box>
References: <20190214052144.59541-1-aik@ozlabs.ru>
	<20190214163743.7162ad53@w520.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8JPrznbw0YAQ/KXy"
Content-Disposition: inline
In-Reply-To: <20190214163743.7162ad53@w520.home>
Subject: Re: [Qemu-devel] [PATCH qemu v2 0/4] spapr_pci,
 vfio: NVIDIA V100 + POWER9 passthrough
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Reza Arbab <arbab@linux.ibm.com>, Piotr Jaroszynski <pjaroszynski@nvidia.com>, Jose Ricardo Ziviani <joserz@linux.ibm.com>, Daniel Henrique Barboza <danielhb413@gmail.com>


--8JPrznbw0YAQ/KXy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 14, 2019 at 04:37:43PM -0700, Alex Williamson wrote:
> On Thu, 14 Feb 2019 16:21:40 +1100
> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
>=20
> > This is for passing through NVIDIA V100 GPUs on POWER9 systems.
> >=20
> > This implements a subdriver for NVIDIA V100 GPU with coherent memory and
> > NPU/ATS support available in the POWER9 CPU.
> >=20
> > 1/4 is a preparation for bigger DMA windows.
> > 2/4 is a small cleanup.
> >=20
> > Here is the kernel driver:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/drivers/vfio/pci?h=3Dv5.0-rc6&id=3D7f92891778dff62303c070ac81de7b7d80de3=
31a
> >=20
> > SLOF changes already went in.
> >=20
> > This depends on "pci: Move NVIDIA vendor id to the rest of ids" (posted=
 separately).
>=20
> TBH, I'm not sure it was the best idea to let it live or die on it's
> own when it now creates a build dependency for this series.

I'd suggest folding it into this series for reconsideration - the
original post's clearly been lost track of.

>=20
> > This is based on sha1
> > 1ea6057 Mark Cave-Ayland "mac_newworld: change default NIC to sungem fo=
r mac99 machine".
>=20
> Perhaps this is why it doesn't apply cleanly against qemu.git.  Are
> there dependencies we need to wait for in the ppc tree as well?
>=20
> > Please comment. Thanks.
>=20
> Besides the build dependency on PCI_VENDOR_ID_NVIDIA, I also get this:
>=20
> .../qemu.git/hw/vfio/spapr.c: In function =E2=80=98vfio_spapr_create_wind=
ow=E2=80=99:
> .../qemu.git/hw/vfio/spapr.c:212:9: error: =E2=80=98ret=E2=80=99 may be u=
sed uninitialized in this function [-Werror=3Dmaybe-uninitialized]
>          error_report("Failed to create a window, ret =3D %d (%m)", ret);
>          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
>=20
> Is this series expected to go in through the ppc branch given the bulk
> of the changes are there?  Thanks,
>=20
> Alex
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--8JPrznbw0YAQ/KXy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxmMIkACgkQbDjKyiDZ
s5LkshAA3KLHQpemue2GvClrfrTdwR/+lItfG6eY0sshjEclW7y1TfkmKSZpyrU4
4LKPd4Nmbqj6g5B8ga0BryJSRBW2g8GUAfdRJDzLQ9M31mhxcEU2FOsXFYA6E+6L
qIRub6ywdOjI8Hz4Wj4iEbXTFTcTwlb4QCHNFSfYsNI8OSIZkxqKAlortikC0kFY
Ejj7kXORWJcAT7gyCWQ5vqgbUnGCe/nL2lQe/I2Nw8u5EvsmIcLaHPxA/ZeH+c+w
l7f/t3d+aIGgYGLRpxrFFvJaYgzkXeerLKWPXnqtgOLth+KA4GGNic8vaODGxd1Q
3PQZP6JwgreGRvJBzOWH5qW690WOWyJmsPTYnylYkXaLsR0lSY22+sJ8smnKdHvF
KlRJleyDw6fY8Z8dfUwEexfRU95hGrJErte9n1JqpvTyQs0hZLFXCAftg2S485yd
k6owR5Lw+2B/BblLPtF38lHSA5hr85x99IAbKcB1G/Bq1FEp+RD7+40cYpFmfBys
pTH1OTRPnBMH0828RCU8m05OplWvRx8LzL8xsj/5Oto7fUrNnk3FVD6w9KuNSTZh
rAH3OAUCl87XesZiici7tANkvgz7DrnN+W67dOmFR9i8nNYEhKZoG+drQQ3p2ps7
sC4vB8IOjqQ2xYsT7voC01B9WG2WdvVNfRKVNsNkqL7mWwpJFQ8=
=pYjF
-----END PGP SIGNATURE-----

--8JPrznbw0YAQ/KXy--

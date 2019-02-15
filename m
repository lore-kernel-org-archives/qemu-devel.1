Received: from eggs.gnu.org ([209.51.188.92]:36179)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1guULu-00008g-8m
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 22:39:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1guU8j-0007LJ-9O
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 22:26:14 -0500
Date: Fri, 15 Feb 2019 14:24:36 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190215032436.GG4573@umbus.fritz.box>
References: <20190214052144.59541-1-aik@ozlabs.ru>
	<20190214163743.7162ad53@w520.home>
	<f8effbfc-e42e-acad-d141-a84a8aa04b92@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8S1fMsFYqgBC+BN/"
Content-Disposition: inline
In-Reply-To: <f8effbfc-e42e-acad-d141-a84a8aa04b92@ozlabs.ru>
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
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Reza Arbab <arbab@linux.ibm.com>, Piotr Jaroszynski <pjaroszynski@nvidia.com>, Jose Ricardo Ziviani <joserz@linux.ibm.com>, Daniel Henrique Barboza <danielhb413@gmail.com>


--8S1fMsFYqgBC+BN/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 15, 2019 at 11:35:02AM +1100, Alexey Kardashevskiy wrote:
>=20
>=20
> On 15/02/2019 10:37, Alex Williamson wrote:
> > On Thu, 14 Feb 2019 16:21:40 +1100
> > Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> >=20
> >> This is for passing through NVIDIA V100 GPUs on POWER9 systems.
> >>
> >> This implements a subdriver for NVIDIA V100 GPU with coherent memory a=
nd
> >> NPU/ATS support available in the POWER9 CPU.
> >>
> >> 1/4 is a preparation for bigger DMA windows.
> >> 2/4 is a small cleanup.
> >>
> >> Here is the kernel driver:
> >> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/com=
mit/drivers/vfio/pci?h=3Dv5.0-rc6&id=3D7f92891778dff62303c070ac81de7b7d80de=
331a
> >>
> >> SLOF changes already went in.
> >>
> >> This depends on "pci: Move NVIDIA vendor id to the rest of ids" (poste=
d separately).
> >=20
> > TBH, I'm not sure it was the best idea to let it live or die on it's
> > own when it now creates a build dependency for this series.
> I am sure that patch is disgustingly primitive and can make it to
> upstream in just one click and the rest of the series will take more
> time anyway (always does :) ).
>=20
> >> This is based on sha1
> >> 1ea6057 Mark Cave-Ayland "mac_newworld: change default NIC to sungem f=
or mac99 machine".
> >=20
> > Perhaps this is why it doesn't apply cleanly against qemu.git.  Are
> > there dependencies we need to wait for in the ppc tree as well?
>=20
> There are few changes in spapr_pci so conflicts are possible, every time
> when David updates his tree and I rebase I get some minor ones.
>=20
> >> Please comment. Thanks.
> >=20
> > Besides the build dependency on PCI_VENDOR_ID_NVIDIA, I also get this:
> >=20
> > .../qemu.git/hw/vfio/spapr.c: In function =E2=80=98vfio_spapr_create_wi=
ndow=E2=80=99:
> > .../qemu.git/hw/vfio/spapr.c:212:9: error: =E2=80=98ret=E2=80=99 may be=
 used uninitialized in this function [-Werror=3Dmaybe-uninitialized]
> >          error_report("Failed to create a window, ret =3D %d (%m)", ret=
);
> >          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > cc1: all warnings being treated as errors
>=20
> Agrh. How exactly do you make them errors, not warnings? I get no
> warning/error with --disable-werror but not having  --disable-werror
> prints warnings, not errors so it does not fail the build and easy to mis=
s.

Are you sure it's printing warnings with --enable-werror?  Otherwise
it sounds like you just have a compiler version that's not picking
this up.

> > Is this series expected to go in through the ppc branch given the bulk
> > of the changes are there?  Thanks,
>=20
> I think so.
>=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--8S1fMsFYqgBC+BN/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxmMPMACgkQbDjKyiDZ
s5JTKA/9EJLReuOb361O46R1fBuP66i30GjmPFTASKUtHC2XF46jVWf1EGx7j6xs
mHdZN55ZElBx7LcdstfCeGbqQ0bENj/HhcsRS5qnH6N5XrLiFlgnmCmQ9vzaHN/U
S66UUl1YNzOgy83WHmX3qr/z6FlReWjsNJUif3R+S2HhckKD+/uqkR7F+0cjLS+R
wr/9tsJm2iTNw0/1lkEeFh2kSol15u6xZcwVP9ZQTKEijTeYBuN8uQSk7sFiZtFj
TsbnoB6iC7Mu2OXl+75dlFtagO0JnmM9NOu+PMJCBh3LI0JArlvfvIn4hTDFTho6
c7tMIiqfteVXYsrtLUhcl9dIZ9T7FzY9ksd5mAIkgnesDnTpASwE/IVug+zNiUjp
4WvGmhfIuusoabSkB86HT8q5jvYqyvG3IWEOle1iYnqFm88IBREiv36y2qPn95oX
dbFhLBBz48qEvLAAgcOaMkT8GrTMlEqOzfrxdRTiyjBmlD+rhRViNgLlKLwTdFdm
hoT9hLKfA3LXw19h67WnM8j7XpWE1G1EAJ5fN8B3Hwfo24s+ObnuDtm0jQ2lF+A1
6tDiZOAgKROlbZY5CM+6c+S+CeQ6alD3u4OLDz3w7fztIPlEVYuhAoNev/p4TaN7
PEieLooCsfAQpTs4Iui0YA1ZaYd16u8WtqV94rNjmfd9gkzhZpU=
=+0SE
-----END PGP SIGNATURE-----

--8S1fMsFYqgBC+BN/--

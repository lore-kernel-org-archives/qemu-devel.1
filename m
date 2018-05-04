Received: from eggs.gnu.org ([2001:4830:134:3::10]:53864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fEPUX-00023A-Sf
	for qemu-devel@nongnu.org; Thu, 03 May 2018 21:26:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fEPUU-0004AK-OS
	for qemu-devel@nongnu.org; Thu, 03 May 2018 21:26:33 -0400
Date: Fri, 4 May 2018 10:04:57 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180504000457.GG13229@umbus.fritz.box>
References: <20180503202441.26293-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="TALVG7vV++YnpwZG"
Content-Disposition: inline
In-Reply-To: <20180503202441.26293-1-mark.cave-ayland@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCH 0/3] uninorth: move wiring of macio IRQs to
 Mac New World machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--TALVG7vV++YnpwZG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 03, 2018 at 09:24:38PM +0100, Mark Cave-Ayland wrote:
> This is the remaining set of patches from my previous uninorth patchset w=
hich
> moves the uninorth token register to its own separate device, and then mo=
ves
> the wiring of macio IRQs to the Mac New World machine (similar to as alre=
ady
> has been done with the Old World machine).
>=20
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Applied to ppc-for-2.13, thanks.

>=20
> Not strictly a v2 but contains the following changes from the original
> submission to patch 1:
>=20
> - Change DEVICE_NATIVE_ENDIAN to DEVICE_BIG_ENDIAN for the Uninorth device
> - Add Philippe's R-B tag
>=20
>=20
> Mark Cave-Ayland (3):
>   uninorth: create new uninorth device
>   mac_newworld: remove pics IRQ array and wire up macio to OpenPIC
>     directly
>   mac_newworld: move wiring of macio IRQs to macio_newworld_realize()
>=20
>  hw/misc/macio/macio.c          | 39 ++++++++++++++++------------
>  hw/pci-host/trace-events       |  2 ++
>  hw/pci-host/uninorth.c         | 58 ++++++++++++++++++++++++++++++++++++=
++++++
>  hw/ppc/mac.h                   |  9 +++++++
>  hw/ppc/mac_newworld.c          | 56 +++++-------------------------------=
----
>  hw/ppc/trace-events            |  4 ---
>  include/hw/misc/macio/macio.h  |  1 -
>  include/hw/pci-host/uninorth.h | 11 ++++++++
>  8 files changed, 110 insertions(+), 70 deletions(-)
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--TALVG7vV++YnpwZG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrro6kACgkQbDjKyiDZ
s5IBFg//QOqGeBqTTJgXEdbZSg/CcgOe/jl2nWRi6UF/nCggsokEUBbpap1EOdfQ
Z3vb3eO80pD57LsdtQ9ZkbRay1yRZkQRMKgoI3XuZkZv1465lr+E4LjhcWPwtqqD
THs0ZMxhGlAFzz1/zv74LexFtnQxn/enaVDY+tMIuzI8CLQT6V9rVwSGp+lxY9LX
V71E+4KXPCJxHitXPLQ0kVYHFvAZlOsaNwWZQVoMFTxywXZts7avUSiUfktgtDIy
PTa3gL/ZOfep3CccEhLelMuDd+k9gpiHsaGMPo30gN8mE2l0rMk3ak45tyjK3/kV
o+aaXxxXx87MYcM5UqsWRCXjvNsUARqDXPlXAVH4UpuDagQ8SH02GiXqgWMraCTb
2/eJSY64yie6Rl5jLBc5t4RmHIno5uxH6ZRT8CwznnGwEdrM1xB/Wlfe63IItsob
99+uLDEKpVZJJxb9ZCgU9R2cB+IcX3VB0ELS0NfOVIxp9yQMGcOKQv7mQNDXRgJc
eu/jCPI3dT2q6jnikcqF+5VMo+AjxsSoxy5cT7qsM9KBB0zXrBLppN7bDZ/LQ35C
OMJfrJZ2a61V6tS9x4Gvz/oS/rNP8lXlPmuXYP87ovFRvWhiywbq0ntEdpMVjs5u
1o9BcWStKqhZ/C4S5ex6yuQC00Y7lPiMwHrX8ET7BQ+CntdqY5A=
=HWju
-----END PGP SIGNATURE-----

--TALVG7vV++YnpwZG--

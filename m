Received: from eggs.gnu.org ([2001:4830:134:3::10]:42321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fvBcW-0000X3-64
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 21:19:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fvBcV-0004gr-6d
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 21:19:36 -0400
Date: Thu, 30 Aug 2018 10:46:48 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180830004648.GF2222@umbus.fritz.box>
References: <20180829165911.30106-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="R6sEYoIZpp9JErk7"
Content-Disposition: inline
In-Reply-To: <20180829165911.30106-1-mark.cave-ayland@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCH 0/7] mac: generate correct fw paths for
 macio IDE and virtio-blk-pci devices
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


--R6sEYoIZpp9JErk7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 29, 2018 at 05:59:04PM +0100, Mark Cave-Ayland wrote:
1;5202;0c> This patchset is the QEMU counterpart to the patches posted on t=
he OpenBIOS
> list at https://mail.coreboot.org/pipermail/openbios/2018-August/010422.h=
tml
> which generate correct fw paths for the Mac Old World and New World machi=
nes.
>=20
> With these patches applied QEMU generates the correct fw paths for both t=
he
> in-built macio IDE and virtio-blk-pci devices enabling support for bootin=
dex
> and most importantly with an updated OpenBIOS, allowing boot from
> virtio-pci-blk devices.
>=20
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Applied to ppc-for-3.1, thanks.


>=20
>=20
> Mark Cave-Ayland (7):
>   macio: move MACIOIDEState type declarations to macio.h
>   macio: add macio bus to help with fw path generation
>   macio: add addr property to macio IDE object
>   grackle: set device fw_name and address for correct fw path generation
>   mac_oldworld: implement custom FWPathProvider
>   uninorth: add ofw-addr property to allow correct fw path generation
>   mac_newworld: implement custom FWPathProvider
>=20
>  hw/ide/macio.c                 |  2 ++
>  hw/misc/macio/macio.c          | 42 ++++++++++++++++++++++--------
>  hw/pci-host/grackle.c          | 17 ++++++++++++
>  hw/pci-host/uninorth.c         | 16 ++++++++++++
>  hw/ppc/mac.h                   | 26 -------------------
>  hw/ppc/mac_newworld.c          | 59 ++++++++++++++++++++++++++++++++++++=
+++++-
>  hw/ppc/mac_oldworld.c          | 59 ++++++++++++++++++++++++++++++++++++=
+++++-
>  include/hw/misc/macio/macio.h  | 37 ++++++++++++++++++++++++++
>  include/hw/pci-host/uninorth.h |  1 +
>  9 files changed, 220 insertions(+), 39 deletions(-)
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--R6sEYoIZpp9JErk7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAluHPnMACgkQbDjKyiDZ
s5JjyxAAmTTuBCY8Zk7A0n7t47I5jTQK1Sv/tf5yXh0797rJBdTaiIC+pBt3Lo4K
6/AzJ2JVTPOZv/HU7CM3idsHYGfw+hxHXLX0/Bl9YCFBsx7DfNUPpZz7d/JaKwPP
KlV7SXq+ppBdyUARZwx6ZTkbkmjOR4enRGMmwiK09HD4FPOVNi2HkINIifymlBYH
mPyuLpvmfltaJm/g0V4EnfqCZCsxzUUkaiMbNAdHmAPOCoP6z/2sRvmteFt6PB6i
hPGECSRgKQztE8jajXO7VJFFz5LZ0ITgFj10fUyC2WztNnGo/YySSB4K/nSKl1Xn
1EIeNJrDL9W0+zQj99TPmTkl20iAcHWlMIr1qrSG5ntJMn5WqcY2QIIDDdRHgOTO
Oi+/n4awfhaDq1B2yvXOx33ilFnqsuXE0tSuMu7nsgkSytR+whi+mnC2cbSOKIgD
rQTzpumN53NLfSouIIjV9009CZpGf+Fvrid7YznIL9XoxjHk1kFxWKvF/+sWYzCD
wuKVfFj0a1BwnZlkXVK1hkkVKmzHAvExghS5uF66Pv2xIvZppdaZod53+CJw7BDO
vKfIQ0hu6G6XOPYHMyUFizZErcoYqCc0uC8zlsbEc1d2DdyW787Wy8hOaSeN766v
t4Oh4+Lh9r+Ky8BPFpseqwcmAJ0ta94VqkXjSBPy7D9LZUdu5NE=
=3lJ1
-----END PGP SIGNATURE-----

--R6sEYoIZpp9JErk7--

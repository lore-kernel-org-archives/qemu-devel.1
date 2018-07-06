Received: from eggs.gnu.org ([2001:4830:134:3::10]:49010)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fbHVu-0007x5-9I
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 23:34:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fbHVt-0000RL-5i
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 23:34:30 -0400
Date: Fri, 6 Jul 2018 13:18:49 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180706031849.GM3450@umbus.fritz.box>
References: <6E19EBEF-B31C-473C-8279-49A28D571F61@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8m/hfNLtAhX2NvnO"
Content-Disposition: inline
In-Reply-To: <6E19EBEF-B31C-473C-8279-49A28D571F61@gmail.com>
Subject: Re: [Qemu-devel] VGA cirrus patch prevents video output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Programmingkid <programmingkidx@gmail.com>
Cc: mail@sebastianbauer.info, "list@suse.de:PowerPC list:PowerPC" <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>


--8m/hfNLtAhX2NvnO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 05, 2018 at 10:41:43PM -0400, Programmingkid wrote:
> I noticed that the video in QEMU stopped working. When I start qemu-syste=
m-ppc all I see is a black window. Not even OpenBIOS displays anything. Aft=
er some bisecting I found out it was this patch that causes the problem:=20
>=20
> Commit 29f9cef39eb1ae55e82c6763eb22d7a1bdff7276
> Author: Sebastian Bauer <mail@sebastianbauer.info>
> Date:   Mon Jul 2 21:13:45 2018 +0200
>=20
>     ppc: Include vga cirrus card into the compiling process
>    =20
>     Drivers for this card exists on PPC-based AmigaOS guests so it is use=
ful to
>     allow users to emulate the graphics card for PPC machines.
>    =20
>     As cirrus vga is currently preferred over std(vga) in absence of any =
user
>     choice, this change also sets the default display of spapr machines to
>     std as otherwise qemu refuses to start these machines. Not specifying=
 an
>     explicit graphics mode is for instance done by 'make check'.
>    =20
>     Signed-off-by: Sebastian Bauer <mail@sebastianbauer.info>
>     Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
>=20
>=20
> I think a solution to this problem might be to have the mac99
> machine use "-vga std" as default. When I use -vga std, video works
> again.

There are already patches in the works to fix this.


--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--8m/hfNLtAhX2NvnO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAls+35cACgkQbDjKyiDZ
s5L9ng//X9Mne0LubJFqpoN1IXOaGYO0TPJNRh4dtpzHlByPaDHVmEBx8GlSG6CF
bAoAq0b6zgcg+7PubXY96kp1mrlMeyH29caWcq0I0XtaY43ptp1HAlTokA70oWlF
VQo8mxQh14W9Mc6Izn8EDoV5S1mOk/XGrc2aokbuuQhNJRS+rtd5i0+U+j/BNvyx
13m9AVVDSXwUkQ//5tPXs/WMYrFaGALl5SxFMI8/fjLpACHFYizWqcmO7VCtMWfy
hjL3At9LMzKIGZVggusmJ4huBQRrSXrIS89GXk9Ki9GhfVwNO7bPIUQWQNBkD43y
eNKGEoL9HZAGOUzpImSEoSPeCxA2MTdRMVpdSKDig5KnovHzHgK7E7GYBCDoRoc3
/P+0DCMBBQhhFRXZWhacOQYP64rYkJihp793gK2ky5DjJSXNFtAkgDKhVBxoSiY7
3syIPnFFjJEAp8tgzgWs5Lmpb+dwrdPGEXai/zuYajrzsp0Il5zmeHguNVCcSwL0
qIDnQ8A14vKEr7n1qwEatsPG+ddkBgRv5DXiVUifoVV98fs6ji89eu7v31OWqzZa
5NzJUwxyhxYtFsSA38Aaz1c9ifLoR5vl7z12Vt17qPqo3fCQdF9QUXZ5ioKGjuP9
6ZSTKZNy2x44blYLPKyLk2fg40U1nYmXxXtGqr2/omVd7YkRiYk=
=54VP
-----END PGP SIGNATURE-----

--8m/hfNLtAhX2NvnO--

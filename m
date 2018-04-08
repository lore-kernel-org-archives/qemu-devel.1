Received: from eggs.gnu.org ([2001:4830:134:3::10]:47493)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wsa-dev@sang-engineering.com>) id 1f54vW-000731-6J
	for qemu-devel@nongnu.org; Sun, 08 Apr 2018 03:39:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wsa-dev@sang-engineering.com>) id 1f54vS-00056U-8l
	for qemu-devel@nongnu.org; Sun, 08 Apr 2018 03:39:50 -0400
Received: from www.zeus03.de ([194.117.254.33]:34074 helo=mail.zeus03.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wsa-dev@sang-engineering.com>)
	id 1f54vR-00055u-Vr
	for qemu-devel@nongnu.org; Sun, 08 Apr 2018 03:39:46 -0400
Date: Sun, 8 Apr 2018 09:39:42 +0200
From: Wolfram Sang <wsa@the-dreams.de>
Message-ID: <20180408073942.lktkq4gqn6ofvjwf@katana>
References: <20180320161850.2104-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="buikjcctq7qeoo2h"
Content-Disposition: inline
In-Reply-To: <20180320161850.2104-1-wsa+renesas@sang-engineering.com>
Subject: Re: [Qemu-devel] [PATCH v3 0/3] nvram: at24c: fix problems related
 to "rom-size"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: qemu-devel@nongnu.org, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, linux-renesas-soc@vger.kernel.org


--buikjcctq7qeoo2h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 20, 2018 at 05:18:47PM +0100, Wolfram Sang wrote:
> I used this driver as a template for a custom one. While hacking on my ow=
n, I
> noticed some problems in this driver, too. This series fixes the first se=
t of
> them, related to the "rom-size" parameter. It fixes a segfault.
>=20
> I think the first patch is clearly suitable for stable. I think the secon=
d one,
> too, but not as clearly. The third one is a cleanup and not for stable. S=
till,
> I am open for opinions about these thoughts.

Through which tree should these patches go? get_maintainer doesn't list
a person specifically. Anything else I could do?

>=20
> Thanks,
>=20
>    Wolfram
>=20
> Changes since v2:
>=20
> * removed '\n' from error_report-strings
> * made sure checkpatch is happy
> * added tags from Philippe (thanks!)
>=20
> Changes since v1:
>=20
> * reordered patches according to significance for stable
> * use AT24C_ROMSIZE_DEFAULT instead of magic value
> * patch 3 doesn't improve the ERR macro anymore but replaces
>   it completely with error_report().
>=20
>=20
> Wolfram Sang (3):
>   nvram: at24c: prevent segfault by checking "rom-size"
>   nvram: at24c: use a sane default for "rom-size"
>   nvram: at24c: use standard error reporting
>=20
>  hw/nvram/eeprom_at24c.c | 25 ++++++++++++++-----------
>  1 file changed, 14 insertions(+), 11 deletions(-)
>=20
> --=20
> 2.11.0
>=20

--buikjcctq7qeoo2h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlrJxz4ACgkQFA3kzBSg
KbZHyQ//ZkGZuVhmHH7+iPHMtlL66tg3bF3DImVFKQgHwq7dhgsCx3cJFSs/ixtI
fezPy4dqF9xSD46K2maueLLbW8QGIa+ukEwe74OP8j07yMjCiPtmtvB2Lj6G89da
QyfxBsxOkUuicx1MrUUN42MTHCFa2gvoZgdHD6hgs4mXqWiAHCIX3LMigkHZ327b
K92bJhGvZmAu6MUhMp+vJ8x7QLnreADATItZATp1NBQH4OGZ+Kp1Vo9fKDwTwMDm
N7xuEqNEPmg5bGnVa3de0XUY6/au4Ywu5oECwr6bH0yDVLueegOONzw7VaFKl7Ao
Vcxk2rheo2is/RKPcgGCnZBwyG3mxP2pxSUv0o4tEl9VbChc7HGNIRZcMLXWGTCg
A/lJASUs10CcGXNaAtnZ4ObrRsWkAZdp1MswilSnh0xzNAJw+04nXRPuqGimrcv8
UnY4hpYIWdfHxQKVdH9sDU6DXB/n2K/pCm5u/4xCtfrK+R/zIXrxJvz+cbSmhee7
ZZu3Gxnk+WwAIHMYaSoq7mrILz3a4WqrNZahfmkO3CYOb/ufUvztQQyxdXuUnR2H
VyY+VEioZyl3NMJm4+Sig19Mx1G/SJxH0/a/f0XaVLUNtgxwv427uu+rKHBELCua
YWqLYg0qF5pYF3ebwIhmwEAfWbhn3xhDF7iCmnxBAl36MX5xFbk=
=bYzH
-----END PGP SIGNATURE-----

--buikjcctq7qeoo2h--

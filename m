Received: from eggs.gnu.org ([2001:4830:134:3::10]:49620)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wsa@the-dreams.de>) id 1evqLu-0004nT-GU
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 16:16:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wsa@the-dreams.de>) id 1evqLr-00036E-Bz
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 16:16:54 -0400
Received: from sauhun.de ([88.99.104.3]:57983 helo=pokefinder.org)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wsa@the-dreams.de>) id 1evqLr-00035i-5c
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 16:16:51 -0400
Date: Tue, 13 Mar 2018 21:16:49 +0100
From: Wolfram Sang <wsa@the-dreams.de>
Message-ID: <20180313201649.w44jtdbk4bow2f7x@ninjato>
References: <20180312214230.17561-1-wsa+renesas@sang-engineering.com>
	<20180312214230.17561-4-wsa+renesas@sang-engineering.com>
	<5108cc9b-9fb9-d202-d4bc-a5c1dd4d4f76@amsat.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="76e3fl6etoahgbib"
Content-Disposition: inline
In-Reply-To: <5108cc9b-9fb9-d202-d4bc-a5c1dd4d4f76@amsat.org>
Subject: Re: [Qemu-devel] [PATCH 3/3] nvram: at24c: use a sane default for
 "rom-size"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, qemu-devel@nongnu.org, linux-renesas-soc@vger.kernel.org, Michael Davidsaver <mdavidsaver@gmail.com>


--76e3fl6etoahgbib
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

> >  static Property at24c_eeprom_props[] =3D {
> > -    DEFINE_PROP_UINT32("rom-size", EEPROMState, rsize, 0),
> > +    DEFINE_PROP_UINT32("rom-size", EEPROMState, rsize, 128),
>=20
> This patch should goes before your 2/3 in your series.

I don't mind much, but why? My reasoning was "let's first fix the cause
and then the symptom"?

> Can you add a #define for this value? Such AT24C_ROMSIZE_MIN.

Can do, of course. But won't that give room for regressions because
people are already using it with lower values?

Ideally, we would have a "model" variable. The model type would define
the size of the memory. The "rom-size" variable could then be kept as is
(except for the 0 bugfix) or deprecated?

Thanks for the review,

   Wolfram

--76e3fl6etoahgbib
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlqoMbEACgkQFA3kzBSg
Kbb3Ow//UFSVqr8NJsUtIhd0lLW2Kitt/ZRtWtWJIj1KpfLglXszlcU9x9Ux6Fb4
NklEmfYC/7Deca9xssxPXj05/5fVoW18yqoo/wtV/bEtKPQJ31qjuNq/ZtN51ruJ
G0s599zbx1qVURUsrjoNUWSdTrJzBlgeEnP4veCHoA0NRqBArBongexHUm9sSeKN
Bv8s9w0SXsLGmTXX8xP6XQB3V1OLnzvP0aw+Nh7WizjTvqZPB40qIGanMSKQiTHe
VQEuuO1CUPQPbOHIIEvdi7YgT2LVFe7kvsL7fIwZNnFKA0rWwPdBXrz8ASGgpgTa
918fbQVlSHqcQELhahC28epuFICfnQwLbfGxDwLk5GO5NKFfMEimcbzW42x0xKO3
EQ2HddiI84qT77pZssjXIQ6NiIwBLwPix6EnQgeC+1lBjO1YlNIFsDPvb9L43VpI
CBSPzC7z334/dY6Kvw629r/RqlhgnENJo9IAOCjTDUOZc1TQ/ZD84mJntpqPF8IH
UFgDRK6ovtvdJwxurerWqub3/M8X0m0u63D9rO8vVr9CuG8RVdGouGOfilU0YRcr
NqGoFjc6QX+Yi7415gBX+pcTti6a8x9LD8E+jyRuOl+bnGcsdgBBiMk9Y5j2ex7P
PhTgDqrCQHyO0VeVivP711I7edh2iaYYiESCNoG5n6/JRUBCKHk=
=w1F9
-----END PGP SIGNATURE-----

--76e3fl6etoahgbib--

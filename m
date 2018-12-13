Received: from eggs.gnu.org ([2001:4830:134:3::10]:48443)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gXQJA-0003cH-0Y
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 07:41:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gXQJ5-0005QB-EU
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 07:41:39 -0500
Date: Thu, 13 Dec 2018 23:08:19 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181213120819.GF29278@umbus.fritz.box>
References: <20181213040126.6768-1-david@gibson.dropbear.id.au>
	<154468701869.9757.9904985862866857416@02a1dbf831e2>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2FkSFaIQeDFoAt0B"
Content-Disposition: inline
In-Reply-To: <154468701869.9757.9904985862866857416@02a1dbf831e2>
Subject: Re: [Qemu-devel] [PULL 00/27] ppc-for-4.0 queue 20181213
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: fam@euphon.net, peter.maydell@linaro.org, lvivier@redhat.com, gkurz@kaod.org, spopovyc@redhat.com, qemu-ppc@nongnu.org, clg@kaod.org


--2FkSFaIQeDFoAt0B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 12, 2018 at 11:43:40PM -0800, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/20181213040126.6768-1-david@gibson.=
dropbear.id.au/
>=20
>=20
>=20
> Hi,
>=20
> This series seems to have some coding style problems. See output below for
> more information:
>=20
> Type: series
> Message-id: 20181213040126.6768-1-david@gibson.dropbear.id.au
> Subject: [Qemu-devel] [PULL 00/27] ppc-for-4.0 queue 20181213

[snip]
> =3D=3D=3D OUTPUT BEGIN =3D=3D=3D
> Checking PATCH 1/27: spapr: Fix ibm, max-associativity-domains property n=
umber of nodes...
> Checking PATCH 2/27: target/ppc: tcg: Implement addex instruction...
> ERROR: space required after that ',' (ctx:VxV)
> #42: FILE: disas/ppc.c:3737:
> +{ "addex",   XO(31,170,0,0), XO_MASK,   POWER9,         { RT, RA, RB } },
>                    ^
>=20
> ERROR: space required after that ',' (ctx:VxV)
> #42: FILE: disas/ppc.c:3737:
> +{ "addex",   XO(31,170,0,0), XO_MASK,   POWER9,         { RT, RA, RB } },
>                        ^
>=20
> ERROR: space required after that ',' (ctx:VxV)
> #42: FILE: disas/ppc.c:3737:
> +{ "addex",   XO(31,170,0,0), XO_MASK,   POWER9,         { RT, RA, RB } },
>                          ^
>=20
> total: 3 errors, 0 warnings, 156 lines checked

These are sorta-false positives.  There's a whole old set of macro
conventions in that file that are a real mess coding style wise
(amongst other ways).  For the time being, internal consistency is
more important than consistency outside here.

[snip]
> Checking PATCH 13/27: ppc/xive: introduce a XIVE interrupt source model...
> WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
> #61:=20
> new file mode 100644
>=20
> total: 0 errors, 1 warnings, 656 lines checked
>=20
> Your patch has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> Checking PATCH 14/27: ppc/xive: add support for the LSI interrupt sources=
=2E..
> Checking PATCH 15/27: ppc/xive: introduce the XiveNotifier interface...
> Checking PATCH 16/27: ppc/xive: introduce the XiveRouter model...
> WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
> #170:=20
> new file mode 100644

These do need a MAINTAINERS update, which I plan to do in followup.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--2FkSFaIQeDFoAt0B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwSS7EACgkQbDjKyiDZ
s5IsyBAAmDuto/x1LK5u3J9+OTne/dqFDyzoYieptMl07Ecgh6tfDlyyi+nznivC
y0wDCc15rH8DcSMqlwKiZws0ZHd81jX6BbLfZkbTk0qcwTFFstFxw7e4IA2WYNLI
75keP8KrQRveTyJZbBbB/dOdqrGjH2WjY/8p4yytFtQ9xeXYz10Nr8YIKtAg52QU
lEc9KF8rZiEQUPyqASePfheGyI8YlB3p9VKJkYzC7eSf3k0zRHhFMC/t88UIqzqE
kzHAKke7oT24tW4qkvFySYlO41jtqf/8I1mWOkbYo5KQykGg/h8ArAaTNZ2YtDyZ
rd6ydU4U36meUJyc/+QJ8c2aVe3V40sKOrw7v3tUBrNv08lysoGNc0UqnxDbSN7a
z6yvCLafyELrcDmKFE7R/36ZBdf0tb8vZdPrynoFDilJzvqbqahzvY9kDD11Ujrc
7+7+/Q0xTVpgjS6/i0hXjDj1fSvLK9tF36u6zH0jhjZJA6nAWIGacb9WWBEOq+hF
x4cI5MpNjaH52seP/p057MxbKUI079w+SiAO8AWJ8x+71KIAx8hVm1H8V9r+Fa++
a1MV4bQNgYDXIe4jOugn9y+J4Mgn9eIaxDdy4LFRhYnNrmg1dy0YXDXXCudBiZ2k
uHwtjtY4vFooIFD/UATGn8j5Hia6BsqxIfMwqkx2jiasIFAFeWY=
=GjcT
-----END PGP SIGNATURE-----

--2FkSFaIQeDFoAt0B--

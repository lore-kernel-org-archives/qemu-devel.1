Received: from eggs.gnu.org ([209.51.188.92]:60861)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1hDXDJ-0004MG-1i
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 12:33:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1hDXDI-0004lG-2Q
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 12:33:41 -0400
Date: Mon, 8 Apr 2019 18:25:23 +0200
From: Peter Krempa <pkrempa@redhat.com>
Message-ID: <20190408162523.GG4288@angien.pipo.sk>
References: <20190408143543.3982-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="peRj85VDUce1fu/0"
Content-Disposition: inline
In-Reply-To: <20190408143543.3982-1-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/4] file-posix: Add dynamic-auto-read-only
 QAPI feature
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, armbru@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org


--peRj85VDUce1fu/0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 08, 2019 at 16:35:39 +0200, Kevin Wolf wrote:
> This series adds optional feature lists to struct definitions in the
> QAPI schema and makes use of them to advertise the new behaviour of
> auto-read-only=3Don in file-posix.
>=20
> Kevin Wolf (4):
>   qapi: Support features for structs
>   tests/qapi-schema: Test for good feature lists in structs
>   tests/qapi-schema: Error case tests for features in structs
>   file-posix: Add dynamic-auto-read-only QAPI feature

I was able to implement this in libvirt fairly easy. My work-in-progress
(needs some docs and polishing) patches can be found at:

https://github.com/pipo/libvirt/commits/qapi-features-introspect

--peRj85VDUce1fu/0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEUn7DGLvflazX+2GwHGwCByjY1GoFAlyrde8ACgkQHGwCByjY
1GrcPQ//bfxmrb6gKlhqYqXW+mkflwSyy6t9+DhB8vw737m5pGFWUhUIGWSS3DvV
emWCZq5wLsW9D5D1NBqV54TZo8YFTxA7a1BHSU4urYi5xD9XkuzU4SB/9o6UNuB2
td0z/6n0expfCDbmiByUnIl+JLAKJkYDbnOEjMW0iQqwL+smjEAyKCln4eIqROLv
xG5UxXf5seQnuG7oPUf1KoU9zx32/Q1TxgLdkZlPcGDDOBCZEuzwFUueF0WgNG9t
ttEbi+mY/lmeOSzqzA9CaKH1W6PXUc1L/yQ2CsmSiYmmoWlcbeXsQdCHPimAfqHw
KY8qSBxElaoaabP/3Y7YzroGVk14qDBRGSP8uVVJjGHlzEhPzTyAF8AvplPuBb1t
AfncDZj3Gcmmi9YzrE/y+q/iStrtHU1cnjQHDrHzaGKJwtsx6U0MwiB16NDq0FGg
WLradObME7KwBCviiK2D0YHcIthbXtSiVlShP3i9wuXpN4QFo4qfQwPtp3CqdF4I
IbAbm9X5dxGZWf6m64rl15FHI2a0DDIM+iJrVSppg3KwCJtHwRHOAlBejc3QmrNZ
ULZNjWUSaIYyOwZ9YpXd1VIzMELQ1qa/vnVEpYgdBaG8VcX5ikWTVlGwR8BA4sbi
5LpaTiCzeGn9LKBJKZP1tn0IUmtbq4J44br02eoduQtLpqcpdLQ=
=u8tZ
-----END PGP SIGNATURE-----

--peRj85VDUce1fu/0--

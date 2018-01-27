Received: from eggs.gnu.org ([2001:4830:134:3::10]:51241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1efTUq-00050e-Fj
	for qemu-devel@nongnu.org; Sat, 27 Jan 2018 11:38:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1efTUn-0007Yj-CI
	for qemu-devel@nongnu.org; Sat, 27 Jan 2018 11:38:28 -0500
Received: from mail.weilnetz.de ([37.120.169.71]:45994
	helo=v2201612906741603.powersrv.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sw@weilnetz.de>) id 1efTUn-0007XA-4x
	for qemu-devel@nongnu.org; Sat, 27 Jan 2018 11:38:25 -0500
References: <20180127134908.24095-1-anatoly.trosinenko@gmail.com>
	<20180127134908.24095-2-anatoly.trosinenko@gmail.com>
From: Stefan Weil <sw@weilnetz.de>
Message-ID: <aab013fb-5ada-6ee5-d038-0277d8ef0b24@weilnetz.de>
Date: Sat, 27 Jan 2018 17:38:21 +0100
MIME-Version: 1.0
In-Reply-To: <20180127134908.24095-2-anatoly.trosinenko@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="nwVuBVUcVC2aqOoGCisBCRFOyIk2lgffa"
Subject: Re: [Qemu-devel] [PATCH 1/1] tci: eliminate UB due to unaligned
 reads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anatoly Trosinenko <anatoly.trosinenko@gmail.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nwVuBVUcVC2aqOoGCisBCRFOyIk2lgffa
From: Stefan Weil <sw@weilnetz.de>
To: Anatoly Trosinenko <anatoly.trosinenko@gmail.com>, qemu-devel@nongnu.org
Message-ID: <aab013fb-5ada-6ee5-d038-0277d8ef0b24@weilnetz.de>
Subject: Re: [PATCH 1/1] tci: eliminate UB due to unaligned reads
References: <20180127134908.24095-1-anatoly.trosinenko@gmail.com>
 <20180127134908.24095-2-anatoly.trosinenko@gmail.com>
In-Reply-To: <20180127134908.24095-2-anatoly.trosinenko@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Am 27.01.2018 um 14:49 schrieb Anatoly Trosinenko:
> Use ldl_he_p / ldq_he_p functions instead of a plain memory access
> through pointer.
>=20
> Signed-off-by: Anatoly Trosinenko <anatoly.trosinenko@gmail.com>
> ---
>  tcg/tci.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)

A better alternative might be aligning the relevant data when generating
the bytecode. See also my comment on alignment in tcg/tci/README.

Stefan


--nwVuBVUcVC2aqOoGCisBCRFOyIk2lgffa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEESSNv6nXJXWmOwreK4Iwh1Wd0UK0FAlpsqv0ACgkQ4Iwh1Wd0
UK2IDQ/9FFCG5Vbcd+QrtUXEuZzBxuXp+Pso34/VCMdUP3m5YahicmdXb/qGl10L
k1mG2Y0d4/jU84NT0bL87WH9VMz1B2CGT56up5PyFEt8peabZmTi55Pv/F2/yzvF
CH7oiu5Z1JcPkKD4hjOUNIjcf3iFjBe/nGBvJ6E5Uv2WlTQkrmZLWAHjFJL88iXr
SHBHs5WS3SPz0v1dN0hz3PYV6Ws6VGor7WgKYPksQvNmaymhAGRloDOtI1ObgND5
fJJcyD+l1zpHqPeG2HlN2RJBX5DhNUDt7euTKy0VZxqYyuaQzSnh0/BZlqdkwNFL
3ZOo8umwUVSSjgleb0RTctv94ToDziID+ZMlGXc6Jd13J6/LJXrkNSJzU4RA3IEF
T6dc+enEtZHk/xE2u4PTbfy3rS7RfrG4y6nJ0DDeNaUU+tA3i8GDLqrYe2fqY0+Q
q+qSmurpIaYVq1bcfdJN8OAPMqyY1eseQufO+zy7y6Y4Az2nlRVROOIZsTGsusks
X0DAm1es/DZxjEFayKsu6mAVUMSape61FwIMCxSsokPCNcgzFXcbINOdUMUU/SDL
F5PDT7Bk4+NKxszXgWf7P4weAv4h5Tajo2Ua8KZd6f6YgLiyESN+UJ6IL71v+mS2
bvJSqKd91XjFV+bukhhTxmka4QRIlh4FfbBolLoldjJU2P7CagQ=
=boyq
-----END PGP SIGNATURE-----

--nwVuBVUcVC2aqOoGCisBCRFOyIk2lgffa--

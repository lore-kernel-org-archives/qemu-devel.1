Received: from eggs.gnu.org ([209.51.188.92]:59848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hK86f-0000Mz-9Q
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 17:10:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hK86e-0002dz-8X
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 17:10:05 -0400
References: <20190404112953.4058-1-berto@igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <59746d5a-5a22-1120-6115-fe78d665a509@redhat.com>
Date: Fri, 26 Apr 2019 23:09:58 +0200
MIME-Version: 1.0
In-Reply-To: <20190404112953.4058-1-berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="sLsujUKtRHCDfVcd3a8WLTWK2sNNK3XdZ"
Subject: Re: [Qemu-devel] [PATCH for-4.1] block: Assert that
 drv->bdrv_child_perm is set in bdrv_child_perm()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--sLsujUKtRHCDfVcd3a8WLTWK2sNNK3XdZ
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <59746d5a-5a22-1120-6115-fe78d665a509@redhat.com>
Subject: Re: [PATCH for-4.1] block: Assert that drv->bdrv_child_perm is set in
 bdrv_child_perm()
References: <20190404112953.4058-1-berto@igalia.com>
In-Reply-To: <20190404112953.4058-1-berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04.04.19 13:29, Alberto Garcia wrote:
> There is no need to check for this because all block drivers that have
> children implement bdrv_child_perm and all callers already ensure that
> bs->drv is set.
>=20
> Furthermore, if this check would fail then the callers would end up
> with uninitialized values for nperm and nshared.
>=20
> This patch replaces the check with an assertion.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)

Thanks, applied to my block branch:

https://git.xanclic.moe/XanClic/qemu/commits/branch/block

Max


--sLsujUKtRHCDfVcd3a8WLTWK2sNNK3XdZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlzDc6YACgkQ9AfbAGHV
z0B9/Qf9EtZT61SI9CXvj3A7vyG61fDU8zR1KrGjPX0BxRSq1bOLSOd8u9KDFBED
TuE+L7otusxhL2CezXQjWdgcDyj1iTqTDj6DM2JSrPBE+kr50FJNfDIj8wENf8Ch
CAt/QfoGoWKYY1XFwh2MA+be8mVgP5Eyzm/YfOYJwx6tefezXiuUeSzRMRYkQ4RC
A1YJl7g0GAJIlnUHklh3Slkrn/TKSHbsm9eSCqJfb51zmF9+cfpTwA7OfVYpfBH4
iWjBVMLPB1p72JzBuMHCEaRO7tTkVu9mUnp9GBzn5PjYz8OGJXsLa5PdqKjtu2XX
7FHLOYe2Nm1XfiiLT5cF9mYpigcSMw==
=qZDT
-----END PGP SIGNATURE-----

--sLsujUKtRHCDfVcd3a8WLTWK2sNNK3XdZ--

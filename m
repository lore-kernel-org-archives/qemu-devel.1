Received: from eggs.gnu.org ([209.51.188.92]:46370)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gyzDp-0002OZ-DZ
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 08:26:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gyzDn-0001D7-AA
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 08:26:05 -0500
References: <20190227131433.197063-1-vsementsov@virtuozzo.com>
	<20190227131433.197063-6-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <df4b140a-247e-027a-95f1-d62732267b32@redhat.com>
Date: Wed, 27 Feb 2019 14:18:12 +0100
MIME-Version: 1.0
In-Reply-To: <20190227131433.197063-6-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="pdR4D8E7Mt3EokmsMDRWrOiblnTLrz9EZ"
Subject: Re: [Qemu-devel] [PATCH v5 5/5] qcow2-refcount: don't mask
 corruptions under internal errors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, den@virtuozzo.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pdR4D8E7Mt3EokmsMDRWrOiblnTLrz9EZ
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, den@virtuozzo.com
Message-ID: <df4b140a-247e-027a-95f1-d62732267b32@redhat.com>
Subject: Re: [PATCH v5 5/5] qcow2-refcount: don't mask corruptions under
 internal errors
References: <20190227131433.197063-1-vsementsov@virtuozzo.com>
 <20190227131433.197063-6-vsementsov@virtuozzo.com>
In-Reply-To: <20190227131433.197063-6-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 27.02.19 14:14, Vladimir Sementsov-Ogievskiy wrote:
> No reasons for not reporting found corruptions as corruptions in case
> of some internal errors, especially in case of just failed to fix l2
> entry (and in this case, missed corruptions may influence comparing
> logic, when we calculate difference between corruptions fields of two
> results)
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/qcow2-refcount.c | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>

I'll be on PTO for a couple of weeks, so it doesn't make sense for me to
take this series to my branch now, though...

Max


--pdR4D8E7Mt3EokmsMDRWrOiblnTLrz9EZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlx2jhQACgkQ9AfbAGHV
z0AjZQgAm1yOXtF5a2ewia0igGDxNjSQv6hHBCZHvJEH+7bbFACz3heXRQzYAy6T
56IezpLe3rHZkHiqPBJO2KcMINHOZYzeO8YNv8RPFXl5hYV8Mu0DDPkMiNuswaTM
7U6Zq7D30fqAdzNLWJ1hNs4cEJmIIvRLFGXy+/Lm3ZFAqJQ4EXSHXqm1wCu5i9mF
+5zwbAS+ApmxdaFNoY0YwW2yltn4CCJ0/+A2I/qDPJZ/lbzzAEGRJnKd75/DSboO
mgZYgtChNOvQJI/WVfuljvqdqY4Va/K4ppVZRoFz/tWUheydAUaYQz7hPszwZ20o
p5tlGIWctWQSWX9SYb4On2D4ccko7w==
=UtZ+
-----END PGP SIGNATURE-----

--pdR4D8E7Mt3EokmsMDRWrOiblnTLrz9EZ--

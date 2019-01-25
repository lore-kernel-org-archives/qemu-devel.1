Received: from eggs.gnu.org ([209.51.188.92]:51325)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gn4Ir-0008Ec-53
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 11:26:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gn4Iq-0004g3-Gm
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 11:26:01 -0500
References: <20190124122525.145968-1-vsementsov@virtuozzo.com>
	<20190124122525.145968-3-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <9757d1d6-6ceb-e6d5-e1b1-cc77e6f4ac82@redhat.com>
Date: Fri, 25 Jan 2019 17:25:49 +0100
MIME-Version: 1.0
In-Reply-To: <20190124122525.145968-3-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="wyWvgqj0VHq32u9t8Tso47FlQkMsZltiw"
Subject: Re: [Qemu-devel] [PATCH 2/2] iotest: fix 169: do not run qmp_cont
 in RUN_STATE_FINISH_MIGRATE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, eblake@redhat.com, lcapitulino@redhat.com, dgilbert@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wyWvgqj0VHq32u9t8Tso47FlQkMsZltiw
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, eblake@redhat.com,
 lcapitulino@redhat.com, dgilbert@redhat.com
Message-ID: <9757d1d6-6ceb-e6d5-e1b1-cc77e6f4ac82@redhat.com>
Subject: Re: [PATCH 2/2] iotest: fix 169: do not run qmp_cont in
 RUN_STATE_FINISH_MIGRATE
References: <20190124122525.145968-1-vsementsov@virtuozzo.com>
 <20190124122525.145968-3-vsementsov@virtuozzo.com>
In-Reply-To: <20190124122525.145968-3-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 24.01.19 13:25, Vladimir Sementsov-Ogievskiy wrote:
> qmp_cont fails if vm in RUN_STATE_FINISH_MIGRATE, so let's wait for
> final RUN_STATE_POSTMIGRATE. Also, while being here, check qmp_cont
> result.
>=20
> Reported-by: Max Reitz <mreitz@redhat.com>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  tests/qemu-iotests/169 | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Tested-by: Max Reitz <mreitz@redhat.com>

Thanks!


--wyWvgqj0VHq32u9t8Tso47FlQkMsZltiw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlxLOI0ACgkQ9AfbAGHV
z0Df7Af+J8Fik97ND9jZ4jGrU5X5BFJNn0Ce7a2yfQ9nfZ+zuZHhoatTwNWPGlGR
dbHj19mZIA7fSSm1TnHVb1wnQLcyoXf82UARjoz5bEL2x6KpTO38PRh3JjDEunOy
18EyQdfQNPwFIb1gL4a6tdMbxCDfhGf2g0a6UVKojSQ9ZSsYECowklWFNRx9WOfz
wV0//nX1sluXf6AXwBneDL+uBXAbSWwz4dcxxAyzEF0uTVPCEqgC5plqjvttRjHE
YU2vCtxraJJ1HU/JQuIwP3Pq7o4whXI/CbQsH0ugyz7k/fJlFvdbVWhcgPeVkjcO
3MOfSLpqvGHhW+YUrJsIa1w7Twezsg==
=0Ocp
-----END PGP SIGNATURE-----

--wyWvgqj0VHq32u9t8Tso47FlQkMsZltiw--

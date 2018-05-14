Received: from eggs.gnu.org ([2001:4830:134:3::10]:35059)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fIFHb-0004R1-9i
	for qemu-devel@nongnu.org; Mon, 14 May 2018 11:21:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fIFHW-0007Bk-Ng
	for qemu-devel@nongnu.org; Mon, 14 May 2018 11:21:03 -0400
References: <20180509162637.15575-1-kwolf@redhat.com>
	<20180509162637.15575-17-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <805fc7ef-c1f0-0d62-9f66-2f0aae925348@redhat.com>
Date: Mon, 14 May 2018 17:20:50 +0200
MIME-Version: 1.0
In-Reply-To: <20180509162637.15575-17-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Do2f0wy1sBAqh4JzniL1aNIXQQ8MOk63H"
Subject: Re: [Qemu-devel] [PATCH 16/42] job: Add Job.aio_context
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: eblake@redhat.com, jsnow@redhat.com, armbru@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Do2f0wy1sBAqh4JzniL1aNIXQQ8MOk63H
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: eblake@redhat.com, jsnow@redhat.com, armbru@redhat.com, jcody@redhat.com,
 qemu-devel@nongnu.org
Message-ID: <805fc7ef-c1f0-0d62-9f66-2f0aae925348@redhat.com>
Subject: Re: [PATCH 16/42] job: Add Job.aio_context
References: <20180509162637.15575-1-kwolf@redhat.com>
 <20180509162637.15575-17-kwolf@redhat.com>
In-Reply-To: <20180509162637.15575-17-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-05-09 18:26, Kevin Wolf wrote:
> When block jobs need an AioContext, they just take it from their main
> block node. Generic jobs don't have a main block node, so we need to
> assign them an AioContext explicitly.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  include/qemu/job.h | 7 ++++++-
>  blockjob.c         | 5 ++++-
>  job.c              | 4 +++-
>  3 files changed, 13 insertions(+), 3 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--Do2f0wy1sBAqh4JzniL1aNIXQQ8MOk63H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlr5qVIACgkQ9AfbAGHV
z0Av7AgAqQk/H3u3j4gsUfPKiRosusNWliDv0qwMdkH1TAHcJeYzHr0HHdrq3mmp
61zFdpUtZQGGMpPXHNKN6kaShIfpAKJEm2o1pt2qXE6B9MEm69mT6FD0atSUIb8c
PVcU/LJDBP0yTPGmSkzYl+1h1fbPReRqhlt9NKOAB21A6xbTqoEwDO+S5lvvrule
8Vvvui+mnEPbBq+NAEvj/k5A3LAsuhVmChgqlwbnR1BaZ7a+RIu5ZWYgot0SBbjy
1rmnCUKwcnLPiHLfHIfyQqpo+koYxOXN5GmCkKcstRB3STlYYTgI45oVsgYIJgcu
GLsnYn9IIgLWSHt8xSkWafBzKcU5Yw==
=n/hq
-----END PGP SIGNATURE-----

--Do2f0wy1sBAqh4JzniL1aNIXQQ8MOk63H--

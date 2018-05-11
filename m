Received: from eggs.gnu.org ([2001:4830:134:3::10]:39759)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fHGIk-0006XX-52
	for qemu-devel@nongnu.org; Fri, 11 May 2018 18:14:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fHGIj-00019E-BR
	for qemu-devel@nongnu.org; Fri, 11 May 2018 18:14:10 -0400
References: <20180509162637.15575-1-kwolf@redhat.com>
	<20180509162637.15575-4-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <7f23a8c8-b4ca-5dab-56d1-92b77727c73e@redhat.com>
Date: Sat, 12 May 2018 00:14:02 +0200
MIME-Version: 1.0
In-Reply-To: <20180509162637.15575-4-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="0TaM4i7Fx50WDgyg5rmguUwp9iB6UhfD7"
Subject: Re: [Qemu-devel] [PATCH 03/42] blockjob: Move RateLimit to BlockJob
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
--0TaM4i7Fx50WDgyg5rmguUwp9iB6UhfD7
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: eblake@redhat.com, jsnow@redhat.com, armbru@redhat.com, jcody@redhat.com,
 qemu-devel@nongnu.org
Message-ID: <7f23a8c8-b4ca-5dab-56d1-92b77727c73e@redhat.com>
Subject: Re: [PATCH 03/42] blockjob: Move RateLimit to BlockJob
References: <20180509162637.15575-1-kwolf@redhat.com>
 <20180509162637.15575-4-kwolf@redhat.com>
In-Reply-To: <20180509162637.15575-4-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-05-09 18:25, Kevin Wolf wrote:
> Every block job has a RateLimit, and they all do the exact same thing
> with it, so it should be common infrastructure. Move the struct field
> for a start.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
>  include/block/blockjob.h | 4 ++++
>  block/backup.c           | 5 ++---
>  block/commit.c           | 5 ++---
>  block/mirror.c           | 6 +++---
>  block/stream.c           | 5 ++---
>  5 files changed, 13 insertions(+), 12 deletions(-)

Instead of finally getting rid of block job throttling, you make it
central functionality?  Bah, I say, bah! ;-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--0TaM4i7Fx50WDgyg5rmguUwp9iB6UhfD7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlr2FaoACgkQ9AfbAGHV
z0BxQwf7BebhkJFyQy4TLVq5MggFdFy2M/y0kyoQMcRpg6x16Sdlb5z4tKhHELDc
dL4y1RK+RmPcFYCrM5aY6WFjiwni9c9s/hqx/OXcVG/x2wOHr1DoIJmTvtLGNl9k
gWLVymOI2ldoif3BS24y6U6p1fMyIDQqf1Nmcpn1+gCjsI5K9FsmYaZ99+mtKZ9w
m8WWqjzSyNNFGrjx3QsSDGWI2aENul+sjOpjd85X90DXEFbup+McD02PTosAC1RG
AfGckydwq/BCxPZvkS8oNwRshhUYsHXc2DC7nVzHsqPks5M28fOP3mJbcvz7ezwS
Bxacic3IkqzTpFiCN/oqiaxLdVn28g==
=7dx2
-----END PGP SIGNATURE-----

--0TaM4i7Fx50WDgyg5rmguUwp9iB6UhfD7--

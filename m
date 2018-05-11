Received: from eggs.gnu.org ([2001:4830:134:3::10]:42004)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fHGTq-0001pS-At
	for qemu-devel@nongnu.org; Fri, 11 May 2018 18:25:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fHGTp-0005OC-K5
	for qemu-devel@nongnu.org; Fri, 11 May 2018 18:25:38 -0400
References: <20180509162637.15575-1-kwolf@redhat.com>
	<20180509162637.15575-6-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <80ccffaa-189b-0de2-ecd0-1bac47d90ee8@redhat.com>
Date: Sat, 12 May 2018 00:25:28 +0200
MIME-Version: 1.0
In-Reply-To: <20180509162637.15575-6-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="XghMwv9lCaF8gSGdtZG7aqtHblX1SzUCb"
Subject: Re: [Qemu-devel] [PATCH 05/42] blockjob: Introduce
 block_job_ratelimit_get_delay()
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
--XghMwv9lCaF8gSGdtZG7aqtHblX1SzUCb
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: eblake@redhat.com, jsnow@redhat.com, armbru@redhat.com, jcody@redhat.com,
 qemu-devel@nongnu.org
Message-ID: <80ccffaa-189b-0de2-ecd0-1bac47d90ee8@redhat.com>
Subject: Re: [PATCH 05/42] blockjob: Introduce block_job_ratelimit_get_delay()
References: <20180509162637.15575-1-kwolf@redhat.com>
 <20180509162637.15575-6-kwolf@redhat.com>
In-Reply-To: <20180509162637.15575-6-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-05-09 18:26, Kevin Wolf wrote:
> This gets us rid of more direct accesses to BlockJob fields from the
> job drivers.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
>  include/block/blockjob_int.h |  8 ++++++++
>  block/backup.c               | 18 +++++++-----------
>  block/commit.c               |  4 ++--
>  block/mirror.c               |  5 +----
>  block/stream.c               |  4 ++--
>  blockjob.c                   |  9 +++++++++
>  6 files changed, 29 insertions(+), 19 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--XghMwv9lCaF8gSGdtZG7aqtHblX1SzUCb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlr2GFgACgkQ9AfbAGHV
z0AOZwgAuE1eAARSS68lAkV6hs1qQhZjJxkL8nVhx69Z8kg2+0dzLJipgKzObI3w
cQDFBkH5ua9/W+8EYaLcVaPGk/RsZb7fN26M/X7FbPUBbve2lsADAO2NY+BEq14n
IxNNIsMHSjPmtCYRD4jB3oaVjlCdkSAlhaukZjMYYkPsVUEMZ8xIfbPL0ByJ2vSo
xSfYIBoIXQhgmeOT9dYevFR6KkbxNyGrNPQRSO641YhGxurls2gHFGbtX5l0Uwgv
Pdup+jvggUFwdXkkJNIFzkfRZucOb3o4QBnZ6r1CYH5QuDW9ADG5+AR3GHRBYBRV
GpVcfsrBiJNUJIbOjc+awLCcD3C+Lw==
=3Co8
-----END PGP SIGNATURE-----

--XghMwv9lCaF8gSGdtZG7aqtHblX1SzUCb--

Received: from eggs.gnu.org ([2001:4830:134:3::10]:57665)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eQwKr-0005wX-Fi
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 09:24:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eQwKo-0001xy-70
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 09:24:05 -0500
Date: Mon, 18 Dec 2017 14:23:26 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171218142326.GJ16653@stefanha-x1.localdomain>
References: <20171214005953.8898-1-jsnow@redhat.com>
	<20171214005953.8898-3-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6THr7QwYWIbrk6Kt"
Content-Disposition: inline
In-Reply-To: <20171214005953.8898-3-jsnow@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/7] blockjob: consolidate SLICE_TIME
 definition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: qemu-block@nongnu.org, kwolf@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com


--6THr7QwYWIbrk6Kt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2017 at 07:59:48PM -0500, John Snow wrote:
> They're all the same. If it actually becomes important to configure it,
> it can become a job or driver property.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  block/backup.c               | 1 -
>  block/commit.c               | 2 --
>  block/mirror.c               | 1 -
>  block/stream.c               | 2 --
>  include/block/blockjob_int.h | 2 ++
>  5 files changed, 2 insertions(+), 6 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--6THr7QwYWIbrk6Kt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaN89eAAoJEJykq7OBq3PIDiYH/imxONOi5DeA5DNB8vweyZ1a
b+6fOVSKbqeYTaBbGCZg7jXyFneIcFHSa6L3TBqKGs3YS1EbRLzl+V3Wa7xiS+/Q
Gzla37DeRIOBNbwwTL5bSPd9f1yqvU5qdSbBO01vSn7AcKiLWftszbxBb6KfWqmi
eTJXHb+3hgsEw9j0G6XddVl/0A3pBm7I6tn0UpvXiusCpvrj7X0hJWvHk6opjEWR
oTRIhH1HOAz0zFyn64jystpLPEvX/BJlOOePsOO4+PrcQ8jdQE+jX89D+n0TimWU
fpzZQX6P1p58YsJ6zECD7qYofGZ7LCKY80Wk9OGmfyI8xSIM5+qZgkcu2kDcWhE=
=YSL4
-----END PGP SIGNATURE-----

--6THr7QwYWIbrk6Kt--

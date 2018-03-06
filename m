Received: from eggs.gnu.org ([2001:4830:134:3::10]:56192)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1etF0v-0006cU-O4
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 11:00:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1etF0m-0008Dg-G1
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 11:00:29 -0500
Date: Tue, 6 Mar 2018 16:00:17 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180306160017.GM31045@stefanha-x1.localdomain>
References: <20180207125037.13510-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ICrdrp3pM9DyZLTK"
Content-Disposition: inline
In-Reply-To: <20180207125037.13510-1-vsementsov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/2] block latency histogram
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, kwolf@redhat.com, armbru@redhat.com, mreitz@redhat.com, nshirokovskiy@virtuozzo.com, den@openvz.org


--ICrdrp3pM9DyZLTK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 07, 2018 at 03:50:35PM +0300, Vladimir Sementsov-Ogievskiy wrot=
e:
> v2:
>=20
> 01: add block_latency_histogram_clear()
> 02: fix spelling (sorry =3D()
>     some rewordings
>     remove histogram if latency parameter unspecified
>=20
> Vladimir Sementsov-Ogievskiy (2):
>   block/accounting: introduce latency histogram
>   qapi: add block latency histogram interface
>=20
>  qapi/block-core.json       | 73 +++++++++++++++++++++++++++++++++-
>  include/block/accounting.h |  9 +++++
>  block/accounting.c         | 97 ++++++++++++++++++++++++++++++++++++++++=
++++++
>  block/qapi.c               | 31 +++++++++++++++
>  blockdev.c                 | 19 +++++++++
>  5 files changed, 228 insertions(+), 1 deletion(-)

The feature looks good.  I posted documentation and code readability
suggestions.

Stefan

--ICrdrp3pM9DyZLTK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJanrsRAAoJEJykq7OBq3PIL3EH/RTTD8/e9768vJlAzrbE+L0U
4380KSLaOij/OdOZgq9KRuTNoaMWGRvCG/ZReM/ebfpTy4SGqSDDb1ZsY2RCqxDf
cC74MM/Ri37QlX9nt9lX1dz+Ms/WJiXvPQIRlFEuPjJeBG6tS6tJq58ESa+GSA+E
ZBMRhtQIOd/lCSraThgfo+6+WhcbnYrbnfloVdiE2r01Y1H5V4hJ9ve4Al6eVunT
Ow3V1xjKgqX5P+CMBUET+J0/IH3X/2EjVK0A4pKbfTtve/zaTj+6dojUVW8/e9P9
7tqTdMTmPjKKMuBD8gzbHjM0HxjolnuNAg+LwZaTofzgo6/pH85/6+kcRjZsSt0=
=uJmu
-----END PGP SIGNATURE-----

--ICrdrp3pM9DyZLTK--

Received: from eggs.gnu.org ([2001:4830:134:3::10]:57422)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ejXxr-0007sJ-Mp
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 17:13:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ejXxq-0000HZ-Vh
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 17:13:15 -0500
References: <20180119205847.7141-1-jsnow@redhat.com>
	<20180119205847.7141-4-jsnow@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <b9f01f29-5cf6-5615-31d8-49eaed503dae@redhat.com>
Date: Wed, 7 Feb 2018 23:12:46 +0100
MIME-Version: 1.0
In-Reply-To: <20180119205847.7141-4-jsnow@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Sh468sxRtQm07xdxw8uKyC9Om7AxcAuqb"
Subject: Re: [Qemu-devel] [PATCH v2 03/13] blockjob: create block_job_relax
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Sh468sxRtQm07xdxw8uKyC9Om7AxcAuqb
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org,
 stefanha@redhat.com
Message-ID: <b9f01f29-5cf6-5615-31d8-49eaed503dae@redhat.com>
Subject: Re: [PATCH v2 03/13] blockjob: create block_job_relax
References: <20180119205847.7141-1-jsnow@redhat.com>
 <20180119205847.7141-4-jsnow@redhat.com>
In-Reply-To: <20180119205847.7141-4-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-01-19 21:58, John Snow wrote:
> This will replace mirror_throttle, for reuse in other jobs.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  block/mirror.c               | 15 ++-------------
>  blockjob.c                   | 11 +++++++++++
>  include/block/blockjob_int.h |  9 +++++++++
>  3 files changed, 22 insertions(+), 13 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--Sh468sxRtQm07xdxw8uKyC9Om7AxcAuqb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlp7ed4SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AVY8H/3uvKP329FzVE7cao3MmsuXnCXjcVRJ0
m9+MmtJGGzF/OSzEi+SOLlfMbwR+2UhpO7bVkApdkidaeEKh0P55iFcKkTdBASuL
SZy3RBmTmubiMn2/XDDl8zOCxw03LG3ZfrLdASBW0zex7QHWcImkkZMmY7/DXgPb
X9xtmwtK3h4YxCgZ1rJb3vAl6T8MzDAjLqrCME8lUPmdLrwW060JSb0T0bZqKj2G
GiK9+NtegLgV6aCy8VVI6Ta3OmcvstPW/3x1ZwuClmBbjpryjGFCEiBPAvX4FI5s
PGou8md1e5tGCfK9MBPL1APBNkM7+Htmzd4WMCqE9U+irduV6CLoryg=
=mEmK
-----END PGP SIGNATURE-----

--Sh468sxRtQm07xdxw8uKyC9Om7AxcAuqb--

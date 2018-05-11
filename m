Received: from eggs.gnu.org ([2001:4830:134:3::10]:47473)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fHGxr-0002Cb-MV
	for qemu-devel@nongnu.org; Fri, 11 May 2018 18:56:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fHGxr-0008BG-2T
	for qemu-devel@nongnu.org; Fri, 11 May 2018 18:56:39 -0400
References: <20180509162637.15575-1-kwolf@redhat.com>
	<20180509162637.15575-12-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <5056f340-839e-132c-c562-5693c8dc0ede@redhat.com>
Date: Sat, 12 May 2018 00:56:29 +0200
MIME-Version: 1.0
In-Reply-To: <20180509162637.15575-12-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="HTzvCTVjhFeu7NmYJriGHRx7lETYdhFr6"
Subject: Re: [Qemu-devel] [PATCH 11/42] job: Add job_delete()
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
--HTzvCTVjhFeu7NmYJriGHRx7lETYdhFr6
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: eblake@redhat.com, jsnow@redhat.com, armbru@redhat.com, jcody@redhat.com,
 qemu-devel@nongnu.org
Message-ID: <5056f340-839e-132c-c562-5693c8dc0ede@redhat.com>
Subject: Re: [PATCH 11/42] job: Add job_delete()
References: <20180509162637.15575-1-kwolf@redhat.com>
 <20180509162637.15575-12-kwolf@redhat.com>
In-Reply-To: <20180509162637.15575-12-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-05-09 18:26, Kevin Wolf wrote:
> This moves freeing the Job object and its fields from block_job_unref()=

> to job_delete().
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  include/qemu/job.h | 3 +++
>  blockjob.c         | 3 +--
>  job.c              | 6 ++++++
>  3 files changed, 10 insertions(+), 2 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--HTzvCTVjhFeu7NmYJriGHRx7lETYdhFr6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlr2H50ACgkQ9AfbAGHV
z0CAtAf/Vmnwi44uLW2JVDNKiedEb5ABeA72Of6VrIhz3jLESZitzqPQe13yYXHJ
a4irve9wXCJM/UNJlhQP1+uTT31C3+V2B8pL56/2SodH+KnwR9+MdsoHJJZ3iRmJ
RgeaLlZ0QiJmrAJuSmXHUIdarcjdqVwzQ6kcEeOZaaASUDFxlcDIFG4LBDzouSI/
2r5VRX47aBhtBQf4tZxYBpzney6F6/beiRP3omH/9g6jArDVS5XoKKhXeHNy2wWZ
FPUTbK9I9lAnQT7qFZaVgRsbyWYHfiO4dKR2jaOiBO27S4est9Qoq7/L6o7Oml3v
iE9WXyyT/5orkoZ+h7a6nI+X/4vh5Q==
=xJ07
-----END PGP SIGNATURE-----

--HTzvCTVjhFeu7NmYJriGHRx7lETYdhFr6--

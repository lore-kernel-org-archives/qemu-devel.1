Received: from eggs.gnu.org ([2001:4830:134:3::10]:42900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fIE18-0007aL-0x
	for qemu-devel@nongnu.org; Mon, 14 May 2018 09:59:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fIE14-0003aL-5i
	for qemu-devel@nongnu.org; Mon, 14 May 2018 09:59:58 -0400
References: <20180509162637.15575-1-kwolf@redhat.com>
	<20180509162637.15575-13-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <7acff37e-6362-1cf0-f109-c4facc22318b@redhat.com>
Date: Mon, 14 May 2018 15:59:33 +0200
MIME-Version: 1.0
In-Reply-To: <20180509162637.15575-13-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="giUUXHYeznSnFaMTAiUX7ntONQJZ0Ga8h"
Subject: Re: [Qemu-devel] [PATCH 12/42] job: Maintain a list of all jobs
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
--giUUXHYeznSnFaMTAiUX7ntONQJZ0Ga8h
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: eblake@redhat.com, jsnow@redhat.com, armbru@redhat.com, jcody@redhat.com,
 qemu-devel@nongnu.org
Message-ID: <7acff37e-6362-1cf0-f109-c4facc22318b@redhat.com>
Subject: Re: [PATCH 12/42] job: Maintain a list of all jobs
References: <20180509162637.15575-1-kwolf@redhat.com>
 <20180509162637.15575-13-kwolf@redhat.com>
In-Reply-To: <20180509162637.15575-13-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-05-09 18:26, Kevin Wolf wrote:
> This moves the job list from BlockJob to Job. Now we can check for
> duplicate IDs in job_create().
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  include/block/blockjob.h |  3 ---
>  include/qemu/job.h       | 19 +++++++++++++++++++
>  blockjob.c               | 47 +++++++++++++++++++++++++---------------=
-------
>  job.c                    | 31 +++++++++++++++++++++++++++++++
>  4 files changed, 75 insertions(+), 25 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--giUUXHYeznSnFaMTAiUX7ntONQJZ0Ga8h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlr5lkUACgkQ9AfbAGHV
z0DBpwf9FBbR6KQQQzuDjrsaxkRpGx3Bg4XD8YYtrdZU02UyR5btPPz3PpYtzqIz
IDUE1Nlen6Y+AJNKpmZfCwCNqib+HPOGgTf1qUraO7n9i60Re9jreVhNimU+wpS8
ILP5BTR6r+VW8hBN5yB9nqNDep7fKyplemNyRoLipWArV1fVvGmFAlxtH+tt0J83
6ju/z3g7tCO94OjPHHZzrs+qs77JXFpYFFwpA60q/QKHqI5sksZ5UzAb5Bb9Jj4E
3Q8u5h6dHitjjhnFRODbqqcLwWIY2pASMcdVOxq5N0QucauJxVrY/N9foqKBHtGI
1YQpprT8KgSc4Elq1BfmAgIxI6BxTQ==
=XNAK
-----END PGP SIGNATURE-----

--giUUXHYeznSnFaMTAiUX7ntONQJZ0Ga8h--

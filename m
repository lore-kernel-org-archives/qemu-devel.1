Received: from eggs.gnu.org ([2001:4830:134:3::10]:41259)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fIKgM-0000U3-Ku
	for qemu-devel@nongnu.org; Mon, 14 May 2018 17:07:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fIKgL-000502-Ud
	for qemu-devel@nongnu.org; Mon, 14 May 2018 17:06:58 -0400
References: <20180509162637.15575-1-kwolf@redhat.com>
	<20180509162637.15575-35-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <8e31ddd1-99ff-75c3-2ae7-b874c6a987c4@redhat.com>
Date: Mon, 14 May 2018 23:06:46 +0200
MIME-Version: 1.0
In-Reply-To: <20180509162637.15575-35-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="TJHya9L94fjbMVyMHgab5h6uSy8KftdTN"
Subject: Re: [Qemu-devel] [PATCH 34/42] job: Add job_dismiss()
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
--TJHya9L94fjbMVyMHgab5h6uSy8KftdTN
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: eblake@redhat.com, jsnow@redhat.com, armbru@redhat.com, jcody@redhat.com,
 qemu-devel@nongnu.org
Message-ID: <8e31ddd1-99ff-75c3-2ae7-b874c6a987c4@redhat.com>
Subject: Re: [PATCH 34/42] job: Add job_dismiss()
References: <20180509162637.15575-1-kwolf@redhat.com>
 <20180509162637.15575-35-kwolf@redhat.com>
In-Reply-To: <20180509162637.15575-35-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-05-09 18:26, Kevin Wolf wrote:
> This moves block_job_dismiss() to the Job layer.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  include/block/blockjob.h |  9 ---------
>  include/qemu/job.h       |  7 ++++++-
>  blockdev.c               |  8 +++++---
>  blockjob.c               | 13 -------------
>  job.c                    | 15 ++++++++++++++-
>  tests/test-blockjob.c    |  4 ++--
>  6 files changed, 27 insertions(+), 29 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--TJHya9L94fjbMVyMHgab5h6uSy8KftdTN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlr5+mYACgkQ9AfbAGHV
z0CDlQf+INlUzoAH7oKcYLsnwSCYywF48HE0DrY9gs8oooW4pUI5OOKsvv5SLR8A
35/GpbS4ftdCfk+D3Lv4bPDHSN1e03Tg/z0zfNn5pGiNEBia2E4WKALYADzsuU2Z
SOcVehWc7FEI1ZTdMZ88DYjai/+prPLTZydKWqFOZr/DWiWsDINNJ7ZrrQ8Gy19E
O3i2us2do51j227yCXvOcVPdOoWQs26OXX7WbCoLhEC/L8Yl+v9Xu5M/LKpWkctF
uK68L3rhqdxBOywh/1RCxqtdN/GZTJf7Dz3dL5HTVnfxuqHRcGpA/yg/DiRnzl8Q
fViDnmUdMWUCHtfG6j+EXdEevJ2uDg==
=9scR
-----END PGP SIGNATURE-----

--TJHya9L94fjbMVyMHgab5h6uSy8KftdTN--

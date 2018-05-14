Received: from eggs.gnu.org ([2001:4830:134:3::10]:39924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fIKZq-00073N-6t
	for qemu-devel@nongnu.org; Mon, 14 May 2018 17:00:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fIKZl-0006bM-4K
	for qemu-devel@nongnu.org; Mon, 14 May 2018 17:00:14 -0400
References: <20180509162637.15575-1-kwolf@redhat.com>
	<20180509162637.15575-34-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <515d7b90-a621-2cf0-1eca-b4b614ca0307@redhat.com>
Date: Mon, 14 May 2018 22:59:57 +0200
MIME-Version: 1.0
In-Reply-To: <20180509162637.15575-34-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="F4lux2pbgG6ltqCRxHt9M0dLGJWNFuMC7"
Subject: Re: [Qemu-devel] [PATCH 33/42] job: Add job_yield()
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
--F4lux2pbgG6ltqCRxHt9M0dLGJWNFuMC7
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: eblake@redhat.com, jsnow@redhat.com, armbru@redhat.com, jcody@redhat.com,
 qemu-devel@nongnu.org
Message-ID: <515d7b90-a621-2cf0-1eca-b4b614ca0307@redhat.com>
Subject: Re: [PATCH 33/42] job: Add job_yield()
References: <20180509162637.15575-1-kwolf@redhat.com>
 <20180509162637.15575-34-kwolf@redhat.com>
In-Reply-To: <20180509162637.15575-34-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-05-09 18:26, Kevin Wolf wrote:
> This moves block_job_yield() to the Job layer.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  include/block/blockjob_int.h |  8 --------
>  include/qemu/job.h           |  9 +++++++--
>  block/backup.c               |  2 +-
>  block/mirror.c               |  2 +-
>  blockjob.c                   | 16 ----------------
>  job.c                        | 20 ++++++++++++++++++--
>  tests/test-blockjob-txn.c    |  2 +-
>  7 files changed, 28 insertions(+), 31 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--F4lux2pbgG6ltqCRxHt9M0dLGJWNFuMC7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlr5+M0ACgkQ9AfbAGHV
z0CSEQf8Dh7J0M11kI6AQ4SNHFUYL9Roocso2YwinpiWkveeFoFz4xV0yxdN9Tjo
YtirRD8EUskuCjGt1NYW+J2KDmtEg/6PMem8DeZrNLbBdVF+qQqXDyB9FQT/8yGs
Y481UfEZRxhNWB1kNIy6TJd4k2IbveFDhhliE3SXQUI9AViVRP484oGwT8O5Unq9
glKB5JV5oaUfGQ1IKWgsOxXxDrSeoK6Qf1BrFjt9fjCXuB7zb0ozRuOwh3NHhv/I
yW/jcgM/zJgHWBHA61M3X50g6Hl5WxG5srevf6FQukuQQCEzQArpxc6rgXKkXc6e
SLMVFR8hR1OFh5sqMwpXOkAErJ7w2w==
=9qjV
-----END PGP SIGNATURE-----

--F4lux2pbgG6ltqCRxHt9M0dLGJWNFuMC7--

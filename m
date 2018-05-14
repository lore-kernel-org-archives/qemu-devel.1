Received: from eggs.gnu.org ([2001:4830:134:3::10]:52684)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fIEe3-000626-41
	for qemu-devel@nongnu.org; Mon, 14 May 2018 10:40:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fIEdx-0003aA-D2
	for qemu-devel@nongnu.org; Mon, 14 May 2018 10:40:11 -0400
References: <20180509162637.15575-1-kwolf@redhat.com>
	<20180509162637.15575-16-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <1405401b-fb71-c4fb-73c7-50b76dfa5431@redhat.com>
Date: Mon, 14 May 2018 16:39:53 +0200
MIME-Version: 1.0
In-Reply-To: <20180509162637.15575-16-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="W8yRM079tRwTkEiyq9wRUNrhb9KvfMYIb"
Subject: Re: [Qemu-devel] [PATCH 15/42] job: Move cancelled to Job
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
--W8yRM079tRwTkEiyq9wRUNrhb9KvfMYIb
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: eblake@redhat.com, jsnow@redhat.com, armbru@redhat.com, jcody@redhat.com,
 qemu-devel@nongnu.org
Message-ID: <1405401b-fb71-c4fb-73c7-50b76dfa5431@redhat.com>
Subject: Re: [PATCH 15/42] job: Move cancelled to Job
References: <20180509162637.15575-1-kwolf@redhat.com>
 <20180509162637.15575-16-kwolf@redhat.com>
In-Reply-To: <20180509162637.15575-16-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-05-09 18:26, Kevin Wolf wrote:
> We cannot yet move the whole logic around job cancelling to Job because=

> it depends on quite a few other things that are still only in BlockJob,=

> but we can move the cancelled field at least.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  include/block/blockjob.h     |  8 --------
>  include/block/blockjob_int.h |  8 --------
>  include/qemu/job.h           | 11 +++++++++++
>  block/backup.c               |  6 +++---
>  block/commit.c               |  4 ++--
>  block/mirror.c               | 20 ++++++++++----------
>  block/stream.c               |  4 ++--
>  blockjob.c                   | 28 +++++++++++++---------------
>  job.c                        |  5 +++++
>  tests/test-blockjob-txn.c    |  6 +++---
>  tests/test-blockjob.c        |  2 +-
>  11 files changed, 50 insertions(+), 52 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--W8yRM079tRwTkEiyq9wRUNrhb9KvfMYIb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlr5n7kACgkQ9AfbAGHV
z0AMxQf9FVNlg7rbwEji5qysylp+IJ95z9DNnJjcwb9RCLMd6S8HEaM9Mpp1MoLP
qJKCzCrt2IEfBXJ2rRTZsFaFAbN81CT5UWtAeVfu4Lh0PWWUrOjYl0VDoKd9AAuO
DjLqoa69WNMYk55b1px7XBSJZx538AB2ZFUMjfXbsUIRPo4SGyunjIVhkmdAFS/E
6QqhBnUPSGplo8heu1OVI/ZqI+io3XaHCI9nk5OPONWW3UNtG5QyvULKOhZFfWtu
rL9HhEBHLxIsUst9nuGKuttvfK1b/FzREGrlQ7aP8F4pWkZivNXj0UTR21Dtx1T2
ztmBYUkl4/XaEZCx62QTZpINB8do4g==
=FDVA
-----END PGP SIGNATURE-----

--W8yRM079tRwTkEiyq9wRUNrhb9KvfMYIb--

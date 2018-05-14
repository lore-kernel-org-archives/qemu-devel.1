Received: from eggs.gnu.org ([2001:4830:134:3::10]:49898)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fIETd-00021P-6T
	for qemu-devel@nongnu.org; Mon, 14 May 2018 10:29:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fIETc-0008Tl-B5
	for qemu-devel@nongnu.org; Mon, 14 May 2018 10:29:25 -0400
References: <20180509162637.15575-1-kwolf@redhat.com>
	<20180509162637.15575-15-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <91acdb5c-12d2-506c-ee13-3b4a9624d555@redhat.com>
Date: Mon, 14 May 2018 16:29:16 +0200
MIME-Version: 1.0
In-Reply-To: <20180509162637.15575-15-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="jy4TS7drk90ZgQnZY4fHheUZGJPdhfYEX"
Subject: Re: [Qemu-devel] [PATCH 14/42] job: Add reference counting
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
--jy4TS7drk90ZgQnZY4fHheUZGJPdhfYEX
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: eblake@redhat.com, jsnow@redhat.com, armbru@redhat.com, jcody@redhat.com,
 qemu-devel@nongnu.org
Message-ID: <91acdb5c-12d2-506c-ee13-3b4a9624d555@redhat.com>
Subject: Re: [PATCH 14/42] job: Add reference counting
References: <20180509162637.15575-1-kwolf@redhat.com>
 <20180509162637.15575-15-kwolf@redhat.com>
In-Reply-To: <20180509162637.15575-15-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-05-09 18:26, Kevin Wolf wrote:
> This moves reference counting from BlockJob to Job.
>=20
> In order to keep calling the BlockJob cleanup code when the job is
> deleted via job_unref(), introduce a new JobDriver.free callback. Every=

> block job must use block_job_free() for this callback, this is asserted=

> in block_job_create().
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  include/block/blockjob.h     | 21 -------------------
>  include/block/blockjob_int.h |  7 +++++++
>  include/qemu/job.h           | 19 ++++++++++++++++--
>  block/backup.c               |  1 +
>  block/commit.c               |  1 +
>  block/mirror.c               |  2 ++
>  block/stream.c               |  1 +
>  blockjob.c                   | 48 +++++++++++++++++++-----------------=
--------
>  job.c                        | 22 ++++++++++++++++----
>  qemu-img.c                   |  4 ++--
>  tests/test-bdrv-drain.c      |  1 +
>  tests/test-blockjob-txn.c    |  1 +
>  tests/test-blockjob.c        |  6 ++++--
>  13 files changed, 76 insertions(+), 58 deletions(-)
Reviewed-by: Max Reitz <mreitz@redhat.com>


--jy4TS7drk90ZgQnZY4fHheUZGJPdhfYEX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlr5nTwACgkQ9AfbAGHV
z0Ammwf+JMwbnJEFogzb0yz1gb0D75JoQlL1DNsKdBKNlKBpC376+JEKbrlU5ua5
3jrR6SjdjhXkEm0PPiCZnrU8q7TUJFNBmPLZzGcErCHvEE2J3PmhKe9/FPcE+bg5
Qp8yj2V4jNBsW+iIXmOM6URSKjbwQESrwnvzLlpHtt4Q9pp7+Vfm86Gs7Yo4Q+3A
pyxj6/lCj/3O1UGxvdeIMZvXathM8uTp1Bh8OJ5heSAMwSh4o1xSxN/oySABR7rg
A5ccEMleCmkyLqp/mIxuGSQK66UgLWrF2oe2uQDb1dag4/QPtdRBSG26cUL/JArQ
RJy2yrjKU9QdbZiLV7r1ljxwTFR69w==
=wZm0
-----END PGP SIGNATURE-----

--jy4TS7drk90ZgQnZY4fHheUZGJPdhfYEX--

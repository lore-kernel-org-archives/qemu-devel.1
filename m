Received: from eggs.gnu.org ([2001:4830:134:3::10]:56709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fuEtp-0004Eb-F7
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 06:37:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fuEto-0001wX-Nx
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 06:37:33 -0400
References: <20180823220856.10094-1-jsnow@redhat.com>
	<20180823220856.10094-7-jsnow@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <1fb73484-c48e-a986-a570-7c603fbcc7cb@redhat.com>
Date: Mon, 27 Aug 2018 12:37:18 +0200
MIME-Version: 1.0
In-Reply-To: <20180823220856.10094-7-jsnow@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="uIQJhrWBsMSLJkwt6V4yWLfiT9WB0uwQO"
Subject: Re: [Qemu-devel] [PATCH v2 6/9] jobs: utilize job_exit shim
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, jtc@redhat.com, Jeff Cody <jcody@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uIQJhrWBsMSLJkwt6V4yWLfiT9WB0uwQO
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, jtc@redhat.com,
 Jeff Cody <jcody@redhat.com>
Message-ID: <1fb73484-c48e-a986-a570-7c603fbcc7cb@redhat.com>
Subject: Re: [PATCH v2 6/9] jobs: utilize job_exit shim
References: <20180823220856.10094-1-jsnow@redhat.com>
 <20180823220856.10094-7-jsnow@redhat.com>
In-Reply-To: <20180823220856.10094-7-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-08-24 00:08, John Snow wrote:
> Utilize the job_exit shim by not calling job_defer_to_main_loop, and
> where applicable, converting the deferred callback into the job_exit
> callback.
>=20
> This converts backup, stream, create, and the unit tests all at once.
> Most of these jobs do not see any changes to the order in which they
> clean up their resources, except the test-blockjob-txn test, which
> now puts down its bs before job_completed is called.
>=20
> This is safe for the same reason the reordering in the mirror job is
> safe, because job_completed no longer runs under two locks, making
> the unref safe even if it causes a flush.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  block/backup.c            | 16 ----------------
>  block/create.c            | 14 +++-----------
>  block/stream.c            | 22 +++++++---------------
>  tests/test-bdrv-drain.c   |  6 ------
>  tests/test-blockjob-txn.c | 11 ++---------
>  tests/test-blockjob.c     | 10 ++++------
>  6 files changed, 16 insertions(+), 63 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--uIQJhrWBsMSLJkwt6V4yWLfiT9WB0uwQO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAluD1F4ACgkQ9AfbAGHV
z0Chqwf9Eawt0Zo6p4u2J9agOKiG8BktjsRcU4uRy/honcWIqwAGMzF7FUrwS7Jq
yoNvBDmwY7MMRKlOTjsZwMrauerHJQBe4Ueb7E4wpTIAFAVYgDFfd7emrb01TWTJ
zTgkWT4/KIOlH68WGyoMVNRg893jWjk+SI9YlQiRJEdpaj776JCBgolT60Dy2iZ5
vrixFCvSuUj3Cr7z1xvpKundiHbMkZaaTNJFUC1NF/014cIHRQBWIPkPVCKWRRap
cJ2DMTFQ3fC/k5fYizX1FtMdKRSIh2LOkbFLuQiu2Igr3bSyppgzSk14j4a1w12/
s0g7WpHbD6BNRvoCWtRleUP8kkyk9w==
=43w/
-----END PGP SIGNATURE-----

--uIQJhrWBsMSLJkwt6V4yWLfiT9WB0uwQO--

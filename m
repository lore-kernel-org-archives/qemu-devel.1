Received: from eggs.gnu.org ([2001:4830:134:3::10]:52996)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1g0SsR-0001b3-Em
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 10:45:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1g0SsQ-00077r-Mj
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 10:45:51 -0400
References: <20180913125217.23173-1-kwolf@redhat.com>
	<20180913125217.23173-7-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <4a55da4e-c90e-c801-023b-2d9669428f66@redhat.com>
Date: Thu, 13 Sep 2018 16:45:33 +0200
MIME-Version: 1.0
In-Reply-To: <20180913125217.23173-7-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="zcK7kpz7hF2MJiucVxDbCXccYsCfrxWwA"
Subject: Re: [Qemu-devel] [PATCH v2 06/17] job: Use AIO_WAIT_WHILE() in
 job_finish_sync()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: famz@redhat.com, pbonzini@redhat.com, slp@redhat.com, jsnow@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--zcK7kpz7hF2MJiucVxDbCXccYsCfrxWwA
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: famz@redhat.com, pbonzini@redhat.com, slp@redhat.com, jsnow@redhat.com,
 qemu-devel@nongnu.org
Message-ID: <4a55da4e-c90e-c801-023b-2d9669428f66@redhat.com>
Subject: Re: [PATCH v2 06/17] job: Use AIO_WAIT_WHILE() in job_finish_sync()
References: <20180913125217.23173-1-kwolf@redhat.com>
 <20180913125217.23173-7-kwolf@redhat.com>
In-Reply-To: <20180913125217.23173-7-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 13.09.18 14:52, Kevin Wolf wrote:
> job_finish_sync() needs to release the AioContext lock of the job befor=
e
> calling aio_poll(). Otherwise, callbacks called by aio_poll() would
> possibly take the lock a second time and run into a deadlock with a
> nested AIO_WAIT_WHILE() call.
>=20
> Also, job_drain() without aio_poll() isn't necessarily enough to make
> progress on a job, it could depend on bottom halves to be executed.
>=20
> Combine both open-coded while loops into a single AIO_WAIT_WHILE() call=

> that solves both of these problems.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> Reviewed-by: Fam Zheng <famz@redhat.com>
> ---
>  job.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--zcK7kpz7hF2MJiucVxDbCXccYsCfrxWwA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAluaeA0ACgkQ9AfbAGHV
z0CZdwf+J40V0HlAbks87GD3BwX+guAXXcxrYv4yugiu+XXTX62SxHagpiDWenh1
b8xe5JV4ickwiNnH3rOu3R/Nx9o9nVHTIhakh902Qg6T8h7CcSigmWfeXMJoItgR
4ozFL5mTBGKJWrD1wyfpw3i+bjt9fsiB3GiBjs8a7xuiEM66Pd2RIdcR/s57sxAp
m7oYatjiSMpQeO0cvN7HLP6K0RsSDEwih9OGro5jnOp4Grq0tGldqep3hgjLtlfr
6zS6WYwF9kGe8W6vt5mdG7SSB30yzeXveg/oEFubPadS2ZuQdrqUUESU1UExceL+
0+BJwyaGQwPMS8uwimgD7oeXfTqo5w==
=lxDN
-----END PGP SIGNATURE-----

--zcK7kpz7hF2MJiucVxDbCXccYsCfrxWwA--

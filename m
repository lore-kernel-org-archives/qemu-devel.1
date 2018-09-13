Received: from eggs.gnu.org ([2001:4830:134:3::10]:48597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1g0SeZ-00044E-Sz
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 10:31:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1g0SeZ-0005bf-5r
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 10:31:31 -0400
References: <20180913125217.23173-1-kwolf@redhat.com>
	<20180913125217.23173-3-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <f3020321-0cf3-07c1-30e2-e3f302e0ba97@redhat.com>
Date: Thu, 13 Sep 2018 16:31:10 +0200
MIME-Version: 1.0
In-Reply-To: <20180913125217.23173-3-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="AL80XG6JUcbRgxaAmcwmNauTMoEsnTuPg"
Subject: Re: [Qemu-devel] [PATCH v2 02/17] blockjob: Wake up BDS when job
 becomes idle
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
--AL80XG6JUcbRgxaAmcwmNauTMoEsnTuPg
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: famz@redhat.com, pbonzini@redhat.com, slp@redhat.com, jsnow@redhat.com,
 qemu-devel@nongnu.org
Message-ID: <f3020321-0cf3-07c1-30e2-e3f302e0ba97@redhat.com>
Subject: Re: [PATCH v2 02/17] blockjob: Wake up BDS when job becomes idle
References: <20180913125217.23173-1-kwolf@redhat.com>
 <20180913125217.23173-3-kwolf@redhat.com>
In-Reply-To: <20180913125217.23173-3-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 13.09.18 14:52, Kevin Wolf wrote:
> In the context of draining a BDS, the .drained_poll callback of block
> jobs is called. If this returns true (i.e. there is still some activity=

> pending), the drain operation may call aio_poll() with blocking=3Dtrue =
to
> wait for completion.
>=20
> As soon as the pending activity is completed and the job finally arrive=
s
> in a quiescent state (i.e. its coroutine either yields with busy=3Dfals=
e
> or terminates), the block job must notify the aio_poll() loop to wake
> up, otherwise we get a deadlock if both are running in different
> threads.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> Reviewed-by: Fam Zheng <famz@redhat.com>
> ---
>  include/block/blockjob.h | 13 +++++++++++++
>  include/qemu/job.h       |  3 +++
>  blockjob.c               | 18 ++++++++++++++++++
>  job.c                    |  7 +++++++
>  4 files changed, 41 insertions(+)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--AL80XG6JUcbRgxaAmcwmNauTMoEsnTuPg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAluadK4ACgkQ9AfbAGHV
z0A8JAf/RbhUhmPlv/yCt8If6Xd/3HmGwd3nR/s8CzndBy9NyxpY8IE0v8/j6+UK
xYGDJMY/t8DlNEE5CNNfXbAztxDir8E/42fxmBAQtGeO8mUjvaq1OHwJ/6h3Gj4j
mUc4XCIv9PftDLkUWTsBJo6TMJepMj/orPT0PSzD1D8ykdjyb0P3ewU+XXoULIuX
hRA8fk17bFutXhoxoSzfdFsGMavcsM1CizZ9HmwXxJa9SBeyZWyZCSV4NRDm9xAF
YPalt7ekCc89oVrud0TDKfqEg31MKolcpTvtwT7748BOscOQjWcEnEXwh0xVXHeg
iswESYHGW+E4WL63xaaIQkXGcSHqCQ==
=B01A
-----END PGP SIGNATURE-----

--AL80XG6JUcbRgxaAmcwmNauTMoEsnTuPg--

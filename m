Received: from eggs.gnu.org ([2001:4830:134:3::10]:59469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dUx4D-0005Te-25
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 11:27:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dUx48-0002lw-3s
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 11:27:13 -0400
Date: Tue, 11 Jul 2017 16:27:03 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170711152703.GD31231@stefanha-x1.localdomain>
References: <20170704220346.29244-1-marcandre.lureau@redhat.com>
	<20170704220346.29244-8-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AbQceqfdZEv+FvjW"
Content-Disposition: inline
In-Reply-To: <20170704220346.29244-8-marcandre.lureau@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 07/35] blockjob: mark
 coroutine_fn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>


--AbQceqfdZEv+FvjW
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 05, 2017 at 12:03:18AM +0200, Marc-Andr=E9 Lureau wrote:
> /home/elmarco/src/qemu/blockjob.c:820:9: error: calling function 'qemu_co=
routine_yield' requires holding role '_coroutine_fn' exclusively [-Werror,-=
Wthread-safety-analysis]
>         qemu_coroutine_yield();
>         ^
> /home/elmarco/src/qemu/blockjob.c:824:5: error: calling function 'block_j=
ob_pause_point' requires holding role '_coroutine_fn' exclusively [-Werror,=
-Wthread-safety-analysis]
>     block_job_pause_point(job);
>     ^
> Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> ---
>  include/block/blockjob_int.h | 4 ++--
>  blockjob.c                   | 6 ++++--
>  2 files changed, 6 insertions(+), 4 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--AbQceqfdZEv+FvjW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZZO5HAAoJEJykq7OBq3PI8yMH/i2djUatEk3PrCD/nria+UCA
G5iQwR40GW+fT31NLyHJrfw3oHV1BnXRZlgjbY+bU0/+bjZkFZ0CUkjqzAjoI+GR
QPM40vTwq0Pun6P7gvSBq5OC1v4kccCxGGbapVKQs/rF7dFtdYdqUfsN/SN2h96K
RkiixZwCuj05x0aPPwLR5yLEYJVbNuIx+YqxZ5jsJ0JYMuMLJYGu7qHXzTzG4oTV
E9iWDQ9o/SOpXKQi0DPJ7nNgw0LhD9cTPNS+XdYbYA/az/KT8Ieyf/hLNGj3IA0M
Jk4tECdHn8a2QWLAkOI2P1BqkosSG/vIS4ny9gwsGFraAzTO+fBse7Ndo9cQA2Y=
=KGTh
-----END PGP SIGNATURE-----

--AbQceqfdZEv+FvjW--

Received: from eggs.gnu.org ([2001:4830:134:3::10]:39600)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eJiK2-0008Dm-1L
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 11:01:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eJiJx-0005Db-Dn
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 11:01:22 -0500
Date: Tue, 28 Nov 2017 16:00:56 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171128160056.GA18339@stefanha-x1.localdomain>
References: <20171128154350.21504-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="azLHFNyN32YCQGCU"
Content-Disposition: inline
In-Reply-To: <20171128154350.21504-1-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.11 0/4] Fix qemu-iotests failures
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, jcody@redhat.com, pbonzini@redhat.com, famz@redhat.com, qemu-devel@nongnu.org


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 28, 2017 at 04:43:46PM +0100, Kevin Wolf wrote:
> This reverts the recent fix for the case of qemu-iotests 200 (block job
> completion races when using a separate I/O thread) that only fixed a
> symptom and caused many regressions, and replaces it with a new
> solution that hopefully attacks the right root cause.
>=20
> The series also contains a bonus fix for a bug that was uncovered by the
> different timing with the patches that are reverted here.
>=20
> Kevin Wolf (4):
>   Revert "coroutine: abort if we try to schedule or enter a pending
>     coroutine"
>   Revert "blockjob: do not allow coroutine double entry or
>     entry-after-completion"
>   coroutine: Cancel aio_co_schedule() on direct entry
>   block: Expect graph changes in bdrv_parent_drained_begin/end
>=20
>  include/block/blockjob_int.h |  3 +--
>  include/qemu/coroutine_int.h | 14 ++++----------
>  block/io.c                   |  8 ++++----
>  blockjob.c                   |  7 ++-----
>  util/async.c                 | 26 +++++++++++++-------------
>  util/qemu-coroutine-sleep.c  | 12 ------------
>  util/qemu-coroutine.c        | 31 +++++++++++++++++--------------
>  7 files changed, 41 insertions(+), 60 deletions(-)
>=20
> --=20
> 2.13.6
>=20

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--azLHFNyN32YCQGCU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaHYg3AAoJEJykq7OBq3PIEkQH/2249yutv1Pyy0/MHfHHMzqF
YGk0PKJ+uKACGFiQBWjRv/yDAsW6BnMb4MMxXZl68wFwJ/ShTvhSP8kMd3551ymp
X7zzFMkf4S6FBxD3iCBF6rDvcRJBPLEvIJq78Lb3ObzJ04OWjn/ziAbDSzZ/aHHs
g0dNFBfaqGbexSRO18/gKDSxv1XuzV44CB5U4Y++p2DgSv6uxkUIEkU/dQIBxnrW
RHfGA5wRsOPvz5WDoo+tA1UfvgKDx7HoqNHMsjhhnk2V9c/tqJ1e1FMPVczg8aJK
BGHkP1deL9DVTGWuCv1lnn2HTDWvH6+2xpfOqzO4Veb9bxxy4p6VdL2YrY5jzeo=
=837V
-----END PGP SIGNATURE-----

--azLHFNyN32YCQGCU--

Received: from eggs.gnu.org ([2001:4830:134:3::10]:54382)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cYZy1-0005Yg-6J
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 10:03:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cYZxy-0006KV-5G
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 10:03:33 -0500
Date: Tue, 31 Jan 2017 15:03:19 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170131150319.GS18804@stefanha-x1.localdomain>
References: <1482503344-6424-1-git-send-email-vsementsov@virtuozzo.com>
	<1482503344-6424-14-git-send-email-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zu8lIfFVzXMVnfzp"
Content-Disposition: inline
In-Reply-To: <1482503344-6424-14-git-send-email-vsementsov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH 13/21] coroutine: add
 qemu_coroutine_add_next
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, pbonzini@redhat.com, jcody@redhat.com


--zu8lIfFVzXMVnfzp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 23, 2016 at 05:28:56PM +0300, Vladimir Sementsov-Ogievskiy wrot=
e:
> Simple add coroutine to self->co_queue_wakeup.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  include/qemu/coroutine.h | 2 ++
>  util/qemu-coroutine.c    | 7 +++++++
>  2 files changed, 9 insertions(+)
>=20
> diff --git a/include/qemu/coroutine.h b/include/qemu/coroutine.h
> index e6a60d5..6e87c87 100644
> --- a/include/qemu/coroutine.h
> +++ b/include/qemu/coroutine.h
> @@ -226,4 +226,6 @@ void coroutine_fn co_aio_sleep_ns(AioContext *ctx, QE=
MUClockType type,
>   */
>  void coroutine_fn yield_until_fd_readable(int fd);
> =20
> +void qemu_coroutine_add_next(Coroutine *next);

Missing coroutine_fn.

Please add a doc comment and a testcase in tests/test-coroutine.c.

--zu8lIfFVzXMVnfzp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYkKc3AAoJEJykq7OBq3PIYcUIAKkUBQra9tz/Iyl5VQogIO/T
pKOICVd2X49S2u/Y/J/VxfJmapEN1x+cDPEkge1xz5oyuRHA2iaXR1ZWyiHxJri3
XC+qrS0PWqsNdxRpzqDSIoW6V+Dv9/+GrQmZfYLXrKE8Dv0evxQEaPpQgG88Qv3L
dEq6yV+I6gIoOUzm/6oVCizEyzSD5JU22ce1pXS9T5yuYE4cbbxobLwowg/ErHBm
EbknCPxkulT5FyzNG9K1SZ1TUsWWKqWOUF1dRWMJQvBc9S6pKEWE6qSgJtcdqPKn
duetjhqkITy6IHy1oz7IJH/XqDdsJLfo+M+eIhkj6Ckjpj7sucDiTpGmd22OjF4=
=33YJ
-----END PGP SIGNATURE-----

--zu8lIfFVzXMVnfzp--

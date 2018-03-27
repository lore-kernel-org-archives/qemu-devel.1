Received: from eggs.gnu.org ([2001:4830:134:3::10]:43705)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1f0nRw-00050b-DH
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 08:11:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1f0nRt-0002Ui-8k
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 08:11:36 -0400
Date: Tue, 27 Mar 2018 13:11:12 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180327121112.GB4909@stefanha-x1.localdomain>
References: <20180322152834.12656-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UHN/qo2QbUvPLonB"
Content-Disposition: inline
In-Reply-To: <20180322152834.12656-1-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/3] coroutine: avoid co_queue_wakeup
 recursion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>


--UHN/qo2QbUvPLonB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 22, 2018 at 03:28:31PM +0000, Stefan Hajnoczi wrote:
> co_queue_wakeup is currently implemented in a recursive fashion.  Patholo=
gical
> patterns of aio_co_enter() between coroutines can cause stack exhaustion.
>=20
> This patch series implements co_queue_wakeup iteratively and avoids stack
> exhaustion.
>=20
> This issue was originally reported with qemu-img convert but I don't have=
 a
> good reproducer.  See Patch 3 for a test-aio test case instead.
>=20
> Stefan Hajnoczi (3):
>   queue: add QSIMPLEQ_PREPEND()
>   coroutine: avoid co_queue_wakeup recursion
>   coroutine: add test-aio coroutine queue chaining test case
>=20
>  include/qemu/coroutine_int.h |   1 -
>  include/qemu/queue.h         |   8 ++++
>  block/io.c                   |   3 +-
>  tests/test-aio.c             |  65 ++++++++++++++++++++-----
>  util/qemu-coroutine-lock.c   |  34 -------------
>  util/qemu-coroutine.c        | 110 +++++++++++++++++++++++--------------=
------
>  6 files changed, 120 insertions(+), 101 deletions(-)
>=20
> --=20
> 2.14.3
>=20

Thanks, applied to my block tree:
https://github.com/stefanha/qemu/commits/block

Stefan

--UHN/qo2QbUvPLonB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaujTgAAoJEJykq7OBq3PISYoH+QGadGqZc3XcITvjforlYQAu
LXGRoJSJ6Y81rjoDfT9DWCSlvumA1f7j077w5vI8+7sNmGOra0VLrBV9PY2W7M0u
pI/jNz7BZTTnFH7ZzbnC+weZE0pOP7tJt3/ayRwNt5lthq3lXNsU4OzC+D9goDcO
bHID6muxoWCJ8eH6ZZdY2V4YsUdJtPblvzUXjnTu4nb0p3pr7yx3xC/wFW25bd8L
+qc3VxdWg5XFJzRYVBMxz4LfV4w2WzFRWYwLu9216MKigX9BS5wA4qwri1R7Rc1s
cs/AJmqHu7KGt214o5PFnkjkPvbINE7KRKJOzIj7xziGL+GNiOoC+M1RCoIUZW4=
=P8YF
-----END PGP SIGNATURE-----

--UHN/qo2QbUvPLonB--

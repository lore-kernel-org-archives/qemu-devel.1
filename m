Received: from eggs.gnu.org ([2001:4830:134:3::10]:54221)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eK2px-0001cO-Co
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 08:55:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eK2ps-0001c5-Gq
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 08:55:41 -0500
Date: Wed, 29 Nov 2017 13:55:33 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20171129135533.GC4281@stefanha-x1.localdomain>
References: <20171129102513.9153-1-pbonzini@redhat.com>
	<20171129102513.9153-3-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1ccMZA6j1vT5UqiK"
Content-Disposition: inline
In-Reply-To: <20171129102513.9153-3-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 2/4] blockjob: remove clock
 argument from block_job_sleep_ns
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org


--1ccMZA6j1vT5UqiK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2017 at 11:25:11AM +0100, Paolo Bonzini wrote:
> All callers are using QEMU_CLOCK_REALTIME, and it will not be possible to
> support more than one clock when block_job_sleep_ns switches to a single
> timer stored in the BlockJob struct.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  block/backup.c               | 4 ++--
>  block/commit.c               | 2 +-
>  block/mirror.c               | 6 +++---
>  block/stream.c               | 2 +-
>  blockjob.c                   | 5 +++--
>  include/block/blockjob_int.h | 7 +++----
>  tests/test-blockjob-txn.c    | 2 +-
>  7 files changed, 14 insertions(+), 14 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--1ccMZA6j1vT5UqiK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaHrxVAAoJEJykq7OBq3PIU8gIAIumIC7JFSezHo9RzD9UwqPD
/KnBMR1ELugCk7ZAePPGv1DtfhH5VkToj+jS/YDI0jAmEidyMe3M1665kbEimfQ8
ayx29W8jduKMN7+PctDERz7UM5Z+IyY4dqdtUsKtTSDX0owArsepZ8sQcRAcgmYV
t+uMGDK70Z2MjiQOdbdbXZUdlcBmUKd91nN0sksRqEYY8vIx8f22Z8UK7RIumt77
2rugrigqDGdUL9A6wIHjMWzt6nodIY0TIT1N061YuEj5wbNJMkgWzhdbRxuDVcOR
Lpt3lbcp+hsEFqN7PLhTw+iUtWeSEmy+NsrqXb07/+flSsWmoUx06Y+24+R6llI=
=03+U
-----END PGP SIGNATURE-----

--1ccMZA6j1vT5UqiK--

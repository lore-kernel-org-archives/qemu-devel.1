Received: from eggs.gnu.org ([2001:4830:134:3::10]:52900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eCpHK-0000oI-Kv
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 11:02:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eCpHG-0001Kq-PA
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 11:02:06 -0500
Date: Thu, 9 Nov 2017 16:01:59 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20171109160159.GA25162@stefanha-x1.localdomain>
References: <20171109102652.6360-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZGiS0Q5IWpPtfppv"
Content-Disposition: inline
In-Reply-To: <20171109102652.6360-1-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] coroutine: simplify
 co_aio_sleep_ns() prototype
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 09, 2017 at 10:26:52AM +0000, Stefan Hajnoczi wrote:
> The AioContext pointer argument to co_aio_sleep_ns() is only used for
> the sleep timer.  It does not affect where the caller coroutine is
> resumed.
>=20
> Due to changes to coroutine and AIO APIs it is now possible to drop the
> AioContext pointer argument.  This is safe to do since no caller has
> specific requirements for which AioContext the timer must run in.
>=20
> This patch drops the AioContext pointer argument and renames the
> function to simplify the API.
>=20
> Reported-by: Paolo Bonzini <pbonzini@redhat.com>
> Reported-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  include/qemu/coroutine.h    | 6 +-----
>  block/null.c                | 3 +--
>  block/sheepdog.c            | 3 +--
>  blockjob.c                  | 2 +-
>  util/qemu-coroutine-sleep.c | 4 ++--
>  5 files changed, 6 insertions(+), 12 deletions(-)

Thanks, applied to my block-next tree for QEMU 2.12:
https://github.com/stefanha/qemu/commits/block-next

Stefan

--ZGiS0Q5IWpPtfppv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaBHv2AAoJEJykq7OBq3PISvIH/RB9U7V/BoX5aR9mWdKB4KwB
N94su0T6RD42jG533ntrtG5VMLAbnx/8TKpk5ux8brsKgE0Lr6Q7LA9yxgM8047c
eWyZ6F/gkROKoLown+77IeyNt9QF3MJkM6MgFemJ2B3MCkIo8ylfPOF9tN2bpWeb
mWipW5ba/hKjmeNZ3NcZhIIowyiyQRrVjOtnGKhdH6QZPo1sud59ZIR1P4BQ1GYg
1BzOmlt0x1ppO7VhAvUmIQP3GKOE6hSFEviS/ItfbVFoK+wjzn5dlyJ24If6MKXT
Z3APzK9eA7rFYiuYVfVX7OH1+VopqvWUNK1eBjEp8XaGXzabxdQMifz2GhO8ywA=
=/O2d
-----END PGP SIGNATURE-----

--ZGiS0Q5IWpPtfppv--

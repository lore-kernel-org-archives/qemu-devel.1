Received: from eggs.gnu.org ([2001:4830:134:3::10]:54817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fuEr0-0000tp-Px
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 06:34:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fuEnF-00020u-Kx
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 06:30:46 -0400
References: <20180823220856.10094-1-jsnow@redhat.com>
	<20180823220856.10094-6-jsnow@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <e18cc5ec-714a-0b9d-55b8-32f798b73c31@redhat.com>
Date: Mon, 27 Aug 2018 12:30:32 +0200
MIME-Version: 1.0
In-Reply-To: <20180823220856.10094-6-jsnow@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="4JW6aLTx9dAFlMx3b8QaWeGO9bNBflzgI"
Subject: Re: [Qemu-devel] [PATCH v2 5/9] block/mirror: utilize job_exit shim
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
--4JW6aLTx9dAFlMx3b8QaWeGO9bNBflzgI
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, jtc@redhat.com,
 Jeff Cody <jcody@redhat.com>
Message-ID: <e18cc5ec-714a-0b9d-55b8-32f798b73c31@redhat.com>
Subject: Re: [PATCH v2 5/9] block/mirror: utilize job_exit shim
References: <20180823220856.10094-1-jsnow@redhat.com>
 <20180823220856.10094-6-jsnow@redhat.com>
In-Reply-To: <20180823220856.10094-6-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-08-24 00:08, John Snow wrote:
> Change the manual deferment to mirror_exit into the implicit
> callback to job_exit and the mirror_exit callback.
>=20
> This does change the order of some bdrv_unref calls and job_completed,
> but thanks to the new context in which we call .exit, this is safe to
> defer the possible flushing of any nodes to the job_finalize_single
> cleanup stage.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  block/mirror.c | 25 +++++++++----------------
>  1 file changed, 9 insertions(+), 16 deletions(-)

Looks good, but the comment about why @src is bdrv_ref()'ed needs to be
updated.

Max


--4JW6aLTx9dAFlMx3b8QaWeGO9bNBflzgI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAluD0sgACgkQ9AfbAGHV
z0Ca3wgAwEZTPSqGBl2dN5eWxLj9NOgNRVoL5889sKKehvdEqZjJ0JEiD6W+oa+f
qWSo3regEVPKm63eLUzoCTdS6okxzM111Da2Cqm0iT/dn4gCTZIPLK/nK3taWV2x
x6SVWfNNw0XE3OB75o4dEZtNcZgQBl1M9tAx5RXQ2/c4NaPCiJP8JFJLIcgqKKDC
c70iRRecQbkwTYKZTaU4zeFr9nXYjzXUn21HCD0hbs17rfPaQq0rQjmHKy+CP9sB
LhQNBoom2g/z+KWnlGq6VdXi8LSzqQJxvXcZr2vF0BmfSD0ZmeApWS7pMl/rW7vm
Bj9xunWmbCIiceBrO9MUQjeVWfIYMw==
=LPTq
-----END PGP SIGNATURE-----

--4JW6aLTx9dAFlMx3b8QaWeGO9bNBflzgI--

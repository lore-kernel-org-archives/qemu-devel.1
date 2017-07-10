Received: from eggs.gnu.org ([2001:4830:134:3::10]:42404)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dUYdB-0007lz-UY
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 09:21:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dUYdB-00068Y-49
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 09:21:41 -0400
Date: Mon, 10 Jul 2017 14:21:21 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170710132121.GF14195@stefanha-x1.localdomain>
References: <20170706163828.24082-1-pbonzini@redhat.com>
	<20170706163828.24082-2-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Il7n/DHsA0sMLmDu"
Content-Disposition: inline
In-Reply-To: <20170706163828.24082-2-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 01/11] block: prepare write threshold code
 for thread safety
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com, qemu-block@nongnu.org


--Il7n/DHsA0sMLmDu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 06, 2017 at 06:38:18PM +0200, Paolo Bonzini wrote:
> Code refactoring only.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  block/write-threshold.c | 28 ++++++++++++++++------------
>  1 file changed, 16 insertions(+), 12 deletions(-)
>=20
> diff --git a/block/write-threshold.c b/block/write-threshold.c
> index 0bd1a01c86..c8ebc32b4d 100644
> --- a/block/write-threshold.c
> +++ b/block/write-threshold.c
> @@ -37,18 +37,22 @@ static void write_threshold_disable(BlockDriverState =
*bs)
>      }
>  }
> =20
> +static uint64_t exceeded_amount(const BdrvTrackedRequest *req,
> +                                uint64_t thres)

Not a reason to respin, but I would prefer a more specific name so the
intent of the code is easier to understand: exceeded_threshold() instead
of exceeded_amount().

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--Il7n/DHsA0sMLmDu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZY39RAAoJEJykq7OBq3PIQoMH/iR2w445OJKvPpUQQ2e0c8XB
uCkQORSTPZq/z1HUxe60TTBzIkZQRmXhrDjsS2T0xHAAphUguMie+wqLkC87Ld3b
q1wVQfWigRhG9YCHoUKYVsfOhT+DvmwwYlN9FizubJpsjJnWqSl+NrlRS8pO2iQU
JGfJM9OkE8DOBZebscq1GOEMbji2+pm1GAkSV2e4Mu9IYZW85Tn2CG6PkXxlLbv/
taE4yvERKU8XWtAUHMEpmaZRhSxrd7tfUOO9BzxMowtTGGVf065NoIj9P4eCsutB
bPMoc1oe9wkNOk0Uec+5qlCJyLL2ESDnKcFb/OyUsHgWOUu4W9aN3Ae1GteTIKU=
=wdIP
-----END PGP SIGNATURE-----

--Il7n/DHsA0sMLmDu--

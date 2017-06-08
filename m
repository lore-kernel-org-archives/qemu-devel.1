Received: from eggs.gnu.org ([2001:4830:134:3::10]:34717)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dIrnb-0007v2-Al
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 03:24:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dIrnY-0006GJ-6z
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 03:24:07 -0400
Date: Thu, 8 Jun 2017 08:24:00 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170608072400.GB2232@stefanha-x1.localdomain>
References: <20170607224316.6952-1-el13635@mail.ntua.gr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9zSXsLTf0vkW971A"
Content-Disposition: inline
In-Reply-To: <20170607224316.6952-1-el13635@mail.ntua.gr>
Subject: Re: [Qemu-devel] [PATCH] block: change variable names in
 BlockDriverState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-trivial@nongnu.org, Max Reitz <mreitz@redhat.com>


--9zSXsLTf0vkW971A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 08, 2017 at 01:43:16AM +0300, Manos Pitsidianakis wrote:
> Change the 'int count' parameter in bdrv_co_pwrite_zeros and
> bdrv_co_pdiscard to 'int bytes', as they both refer to bytes.
> This helps with code legibility.
>=20
> Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
> ---
>  include/block/block_int.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/include/block/block_int.h b/include/block/block_int.h
> index cb78c4f..06e398b 100644
> --- a/include/block/block_int.h
> +++ b/include/block/block_int.h
> @@ -162,9 +162,9 @@ struct BlockDriver {
>       * will be called instead.
>       */
>      int coroutine_fn (*bdrv_co_pwrite_zeroes)(BlockDriverState *bs,
> -        int64_t offset, int count, BdrvRequestFlags flags);
> +        int64_t offset, int bytes, BdrvRequestFlags flags);
>      int coroutine_fn (*bdrv_co_pdiscard)(BlockDriverState *bs,
> -        int64_t offset, int count);
> +        int64_t offset, int bytes);

Please also convert all the implementations of these function pointers.
For example, block/qcow2.c:qcow2_co_pwrite_zeroes().

--9zSXsLTf0vkW971A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZOPuQAAoJEJykq7OBq3PIltsH/ia5pjLuN5WXQoinv9cOBAgL
Q6xr6l8URPPzBsTW3Rid2qTxlnmbmV9FoY8gXwCXky6TQpYCZDZEERizm88NCEbP
ph0N2xSZ03wZfUJEsUOQdKQpST8zqKbOQfdC86CROL829UcDfegDsjeb+JKc0o0b
wzQn7S1RJ/M4i5daosgTjwbP9QGGYgi8L4lJjuAmYtD6HzKSY49ix7TrLq/7DYZ1
uXbKh3C0IyyUlkPjOgJzXmU7NlBFEbrSkQASGrg373EMr0lIvpdE1iDFV4Wd9+v2
RPuKLKf+2YQGbYyDLhYLMD1CCRa7R3DY9laa7Fhox9z0IFyR2aKo1gZEKn5i9F4=
=eI7v
-----END PGP SIGNATURE-----

--9zSXsLTf0vkW971A--

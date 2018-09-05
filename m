Received: from eggs.gnu.org ([2001:4830:134:3::10]:60188)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fxXML-0000Em-KJ
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 08:56:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fxXMK-0002Jv-TQ
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 08:56:37 -0400
References: <cover.1535983918.git.berto@igalia.com>
	<a63ee5b8ab13edb6e339c245a5963a63a044f4ae.1535983918.git.berto@igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <c3c62806-1fd5-8cf8-3c2b-8bfb35e1e9f6@redhat.com>
Date: Wed, 5 Sep 2018 14:56:17 +0200
MIME-Version: 1.0
In-Reply-To: <a63ee5b8ab13edb6e339c245a5963a63a044f4ae.1535983918.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="bQkwxylLjz49vPtY3EgJCrB9BYXjGHYyh"
Subject: Re: [Qemu-devel] [PATCH v2 10/10] block: Allow changing
 'force-share' on reopen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bQkwxylLjz49vPtY3EgJCrB9BYXjGHYyh
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <c3c62806-1fd5-8cf8-3c2b-8bfb35e1e9f6@redhat.com>
Subject: Re: [PATCH v2 10/10] block: Allow changing 'force-share' on reopen
References: <cover.1535983918.git.berto@igalia.com>
 <a63ee5b8ab13edb6e339c245a5963a63a044f4ae.1535983918.git.berto@igalia.com>
In-Reply-To: <a63ee5b8ab13edb6e339c245a5963a63a044f4ae.1535983918.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-09-03 16:34, Alberto Garcia wrote:
> 'force-share' is one of the basic BlockdevOptions available for all
> drivers, but it's not handled by bdrv_reopen_prepare() so any attempt
> to change it results in a "Cannot change the option" error:
>=20
>    (qemu) qemu-io virtio0 "reopen -o force-share=3Don"
>    Cannot change the option 'force-share'
>=20
> Since there's no reason why we shouldn't allow changing it and the
> implementation is simple let's just do it.
>=20
> It's worth noting that after this patch the above reopen call will
> still return an error -although a different one- if the image is not
> read-only:
>=20
>    (qemu) qemu-io virtio0 "reopen -o force-share=3Don"
>    force-share=3Don can only be used with read-only images
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> Cc: Max Reitz <mreitz@redhat.com>
> ---
>  block.c               | 30 ++++++++++++++++++++++++------
>  include/block/block.h |  1 +
>  2 files changed, 25 insertions(+), 6 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--bQkwxylLjz49vPtY3EgJCrB9BYXjGHYyh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAluP0nEACgkQ9AfbAGHV
z0AAGQf/XcwCOyAOYIU9yVqL1HId/mArrzVCwlGV4nTZiOYgDUJ9EAaZoDY+wcXa
RO7Qct91fmiJHgMnrioB0+BQpe2uGjOe8BXUEQGGZmKnPXR+cMow24FMLKlCBswY
d8BIAWmKwguMJC41CKJeAgis/MXDXyazxZC6XZmlCqVDBV/K16afvSwwN2YVE6xe
+3hU/SYt159zlIDCSd0uLN+NycMDdzieanzVNP/kovZfIz5iNhWd83W+ZxzK4jaf
0k/FVtib7rxfCm8/ofx9/ING3rPqAt/y2vKGGBZyjVMcOyX+e5S6WovjWQUU1piD
pXoaSt0Zs/ZUtaFyK6lN2mWdfKkjjA==
=jGdH
-----END PGP SIGNATURE-----

--bQkwxylLjz49vPtY3EgJCrB9BYXjGHYyh--

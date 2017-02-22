Received: from eggs.gnu.org ([2001:4830:134:3::10]:36431)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cgXhD-0008Ee-Pn
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 09:15:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cgXh9-0002UE-W2
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 09:15:07 -0500
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
	<1487689130-30373-22-git-send-email-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <1dd8886d-c9f9-78d9-ae6f-ea303df996d8@redhat.com>
Date: Wed, 22 Feb 2017 15:14:53 +0100
MIME-Version: 1.0
In-Reply-To: <1487689130-30373-22-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="NLPNlTewrLQ58iaFbGcMiP2jX7EfC58BA"
Subject: Re: [Qemu-devel] [PATCH 21/54] block: Require .bdrv_child_perm()
 with child nodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NLPNlTewrLQ58iaFbGcMiP2jX7EfC58BA
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org
Message-ID: <1dd8886d-c9f9-78d9-ae6f-ea303df996d8@redhat.com>
Subject: Re: [PATCH 21/54] block: Require .bdrv_child_perm() with child nodes
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
 <1487689130-30373-22-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487689130-30373-22-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 21.02.2017 15:58, Kevin Wolf wrote:
> All block drivers that can have child nodes implement .bdrv_child_perm(=
)
> now. Make this officially a requirement by asserting that only drivers
> without children can omit .bdrv_child_perm().
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--NLPNlTewrLQ58iaFbGcMiP2jX7EfC58BA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlitnN0SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AavEH/R1fqTXO4cVEv17mXBwhg1UqCOgNnBRB
9ScmH0XX+MeaYKHteN8w9Gpt4xdfFUHACyeHKZmBeZIyoB7WPgr9jnV5W8a9Ir5G
z66igibRE5mJdVEhkA/Pgrbr01LDFVEZLartNCwmrJ4ZXtl+QGaki05ttqTyuoKr
yt1O6wXeY4GI+OwqHy21nkizfGZeACq8OyvPjxNVZInx4AAtCkJOAC8hdpaHQ13w
5/yBlYCTRT/gESETH9P9FUU+P9/Q52ltu0pzEbG7CVjnWYcMjLXMqjYH8lri5tIR
vFKBTpTc8cRmXGniOXo9YOwbMpWwM4crqRwJNdwpzikzXHlH13Soc/8=
=lQrQ
-----END PGP SIGNATURE-----

--NLPNlTewrLQ58iaFbGcMiP2jX7EfC58BA--

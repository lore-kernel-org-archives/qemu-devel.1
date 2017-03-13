Received: from eggs.gnu.org ([2001:4830:134:3::10]:53148)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cnYH4-0006UW-3N
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 18:17:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cnYH3-0007OT-2d
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 18:17:06 -0400
References: <20170308025428.1037-1-eblake@redhat.com>
	<20170308025428.1037-7-eblake@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <dc3ed94a-46ea-076c-d2f2-ffb00b2f2501@redhat.com>
Date: Mon, 13 Mar 2017 23:16:55 +0100
MIME-Version: 1.0
In-Reply-To: <20170308025428.1037-7-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="oerFrjEOqNqB80nB44M5UlFDB9dUbLaUu"
Subject: Re: [Qemu-devel] [PATCH v6 06/10] blkdebug: Refactor error injection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--oerFrjEOqNqB80nB44M5UlFDB9dUbLaUu
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org
Message-ID: <dc3ed94a-46ea-076c-d2f2-ffb00b2f2501@redhat.com>
Subject: Re: [PATCH v6 06/10] blkdebug: Refactor error injection
References: <20170308025428.1037-1-eblake@redhat.com>
 <20170308025428.1037-7-eblake@redhat.com>
In-Reply-To: <20170308025428.1037-7-eblake@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 08.03.2017 03:54, Eric Blake wrote:
> Rather than repeat the logic at each caller of checking if a Rule
> exists that warrants an error injection, fold that logic into
> inject_error(); and rename it to rule_check() for legibility.
> This will help the next patch, which adds two more callers that
> need to check rules for the potential of injecting errors.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
>=20
> ---
> v6: new patch
> ---
>  block/blkdebug.c | 74 +++++++++++++++++++++++++-----------------------=
--------
>  1 file changed, 33 insertions(+), 41 deletions(-)
>=20
> diff --git a/block/blkdebug.c b/block/blkdebug.c
> index 7c804b2..f721bcb 100644
> --- a/block/blkdebug.c
> +++ b/block/blkdebug.c

Reviewed-by: Max Reitz <mreitz@redhat.com>


--oerFrjEOqNqB80nB44M5UlFDB9dUbLaUu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAljHGlcSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ApPUH/jamz4kJoftoQa/p6/eGUCDXltK+jVcg
M74UtGI46cpEXgafFmdyQsE38abu4Ed3jX/OmGy1mjoXfyfALVcTbUltkX6DZC8p
27eTBPp94Utmd36UMQg+FbW/Q04ZkQgef3PiY2hPxFwQ9yKfwPXyow7LyofvU5QD
adT5KQEb6I2rDE4NE8O1jQYXdarp6lg7AtzJCdq6SV9HK8NkfqOIJnNoXgjKybp9
qsYdZ1Ru+SNxBdWlw/Tdl5mrduhSH4qHHOea7hd1wuiGkSjlYxZ7icUSWS7fDZil
ppOe1d1iQ1VrgKvtKsOIVGPgvkqjoMJGSkDwEvsesrfIGkETEeEtoyk=
=lQF8
-----END PGP SIGNATURE-----

--oerFrjEOqNqB80nB44M5UlFDB9dUbLaUu--

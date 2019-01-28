Received: from eggs.gnu.org ([209.51.188.92]:37380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1goBEM-0003dP-0e
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 13:02:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1goB5h-0004NP-Dh
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 12:53:02 -0500
References: <20190128173901.3357-1-antonkuchin@yandex-team.ru>
From: Eric Blake <eblake@redhat.com>
Message-ID: <60bb98e7-ffae-667e-9fb7-57b53003eed6@redhat.com>
Date: Mon, 28 Jan 2019 11:52:48 -0600
MIME-Version: 1.0
In-Reply-To: <20190128173901.3357-1-antonkuchin@yandex-team.ru>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="4WSghDbKSZIDecZ7Hcsx48BqVAoOsr5yR"
Subject: Re: [Qemu-devel] [PATCH] block: split block/qapi.c to avoid linking
 utilities with qapi
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Kuchin <antonkuchin@yandex-team.ru>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>, Evgeny Yakovlev <wrfsh@yandex-team.ru>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4WSghDbKSZIDecZ7Hcsx48BqVAoOsr5yR
From: Eric Blake <eblake@redhat.com>
To: Anton Kuchin <antonkuchin@yandex-team.ru>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Evgeny Yakovlev <wrfsh@yandex-team.ru>
Message-ID: <60bb98e7-ffae-667e-9fb7-57b53003eed6@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] block: split block/qapi.c to avoid linking
 utilities with qapi
References: <20190128173901.3357-1-antonkuchin@yandex-team.ru>
In-Reply-To: <20190128173901.3357-1-antonkuchin@yandex-team.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/28/19 11:39 AM, Anton Kuchin wrote:
> Only part of block/qapi.c is used by qemu-io qemu-nbd and qemu-img
> and its not realy about QAPI, so move it to separate file to reduce

s/realy/really/

> amount of unused code linked to utilities and avoid unnecessary
> dependencies.

That's a decent start for a good commit message; although giving even
more details about which interfaces are candidates for moving (to make
it easier for future patches to know which of the two files to add to)
would be helpful.

Also, do you have any before/after comparisons, perhaps such as size of
the executables or of 'nm | wc' output, proving that the split makes an
obvious difference?

>=20
> Signed-off-by: Anton Kuchin <antonkuchin@yandex-team.ru>
> ---
>  block.c                               |   2 +-
>  block/Makefile.objs                   |   3 +-
>  block/bdrv_info.c                     | 582 ++++++++++++++++++++++++++=

>  block/qapi.c                          | 553 +-----------------------
>  hmp.c                                 |   2 +-
>  include/block/{qapi.h =3D> bdrv_info.h} |   6 +-
>  monitor.c                             |   2 +-
>  qemu-img.c                            |   2 +-
>  qemu-io-cmds.c                        |   2 +-
>  9 files changed, 593 insertions(+), 561 deletions(-)
>  create mode 100644 block/bdrv_info.c
>  rename include/block/{qapi.h =3D> bdrv_info.h} (97%)
>=20
--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--4WSghDbKSZIDecZ7Hcsx48BqVAoOsr5yR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxPQXAACgkQp6FrSiUn
Q2qd7gf/TqIACWthcxON+x34jc1fSaVJUHa2YzliH5YkiFnl9gdBz9YEd+dEDZBJ
/WIbOJ59x+4r2ZCWg86Z+rAgJcBZ8ZVrDvupx7SNuOna8q8U1ekLNbia8Magl+Xl
X6mZgRRpt7C13NVlUbie0A0Y/+i3AFKivstEE8zsz298xD+ZDP6HsisZwEN4m94L
Kvf7dK77dKwCg1cHX2m2rHXE2RxTaAdR5fbEnGxpMQzqfywtnw7aMRO51vSChe2O
GM5C/s5xwj4OKiCfFyOBnwpNJv/x9jJv+mrpn5uBNT+xLgStLc2bHyks38A7gq7z
RQHBqrI/F28iYhNHMxPagSr/nyreig==
=APOU
-----END PGP SIGNATURE-----

--4WSghDbKSZIDecZ7Hcsx48BqVAoOsr5yR--

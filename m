Received: from eggs.gnu.org ([209.51.188.92]:57973)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gtdim-0007ej-NA
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 14:27:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gtdik-0004sp-Pw
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 14:27:56 -0500
References: <20190212010248.11056-1-jsnow@redhat.com>
	<20190212010248.11056-6-jsnow@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ef434d29-2059-12b3-5c6c-3a6b455447eb@redhat.com>
Date: Tue, 12 Feb 2019 13:27:35 -0600
MIME-Version: 1.0
In-Reply-To: <20190212010248.11056-6-jsnow@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="vM07grRJZkVAP4KhfIOgeTr0LhFYVBCYf"
Subject: Re: [Qemu-devel] [PATCH 5/5] block/dirty-bitmaps: unify qmp_locked
 and user_locked calls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Juan Quintela <quintela@redhat.com>, qemu-block@nongnu.org, Fam Zheng <fam@euphon.net>, vsementsov@virtuozzo.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vM07grRJZkVAP4KhfIOgeTr0LhFYVBCYf
From: Eric Blake <eblake@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Juan Quintela <quintela@redhat.com>, qemu-block@nongnu.org,
 Fam Zheng <fam@euphon.net>, vsementsov@virtuozzo.com,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz
 <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>
Message-ID: <ef434d29-2059-12b3-5c6c-3a6b455447eb@redhat.com>
Subject: Re: [PATCH 5/5] block/dirty-bitmaps: unify qmp_locked and user_locked
 calls
References: <20190212010248.11056-1-jsnow@redhat.com>
 <20190212010248.11056-6-jsnow@redhat.com>
In-Reply-To: <20190212010248.11056-6-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2/11/19 7:02 PM, John Snow wrote:
> These mean the same thing now. Unify them and rename the merged call
> bdrv_dirty_bitmap_busy to indicate semantically what we are describing,=

> as well as help disambiguate from the various _locked and _unlocked
> versions of bitmap helpers that refer to mutex locks.

Yay, definitely improved naming.

> ---
>  block/dirty-bitmap.c           | 41 +++++++++++++++-------------------=

>  blockdev.c                     | 18 +++++++--------
>  include/block/dirty-bitmap.h   |  5 ++---
>  migration/block-dirty-bitmap.c |  6 ++---
>  nbd/server.c                   |  6 ++---
>  5 files changed, 35 insertions(+), 41 deletions(-)
>=20
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--vM07grRJZkVAP4KhfIOgeTr0LhFYVBCYf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxjHicACgkQp6FrSiUn
Q2pxdgf/Q8yPRwKyvgs61rv5VO8swlkDUS8FZD4nJCqZ4XP6z8F/WaGa/H1Im0CS
U1Psl+mHeLIdRqHF08RSnnIUjeY96YFasXmSES6OFhgIB2NbbZK1ibPKlZkjO11T
95mNaSia7YEGezkkCrBnWNOF8kcavj2FyhLsqV6/x7VCHA3ljSB9IAFuXdGg+SwS
lfgCYECRT3TptSpVvCb+8fOIdP22gipXBY8MXt36caVVpQ1Eck+stXeRLVWVGdDe
29n055I1JtmjctZz6kfikyrUSCrNP/MqgwJTYsThsEZfOQP8dZU7KJ2fS4QBgRhO
PcrRbOyfeKb16gIpex+XCHhq3HW/cg==
=CXtS
-----END PGP SIGNATURE-----

--vM07grRJZkVAP4KhfIOgeTr0LhFYVBCYf--

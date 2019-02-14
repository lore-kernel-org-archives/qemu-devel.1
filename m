Received: from eggs.gnu.org ([209.51.188.92]:51068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gu7GY-0007i5-R9
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 22:00:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gu7Dc-0002KD-SB
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 21:57:46 -0500
References: <20190213232356.21034-1-jsnow@redhat.com>
	<20190213232356.21034-3-jsnow@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <002be4e5-70c1-2c85-53de-327f202f1b31@redhat.com>
Date: Wed, 13 Feb 2019 20:57:11 -0600
MIME-Version: 1.0
In-Reply-To: <20190213232356.21034-3-jsnow@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="zGEaAiV4IrgZL50MB1qyPkpyVwH5K5lcc"
Subject: Re: [Qemu-devel] [PATCH v2 2/6] block/dirty-bitmaps: rename frozen
 predicate helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, vsementsov@virtuozzo.com, Fam Zheng <fam@euphon.net>, libvir-list@redhat.com, Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--zGEaAiV4IrgZL50MB1qyPkpyVwH5K5lcc
From: Eric Blake <eblake@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, vsementsov@virtuozzo.com,
 Fam Zheng <fam@euphon.net>, libvir-list@redhat.com,
 Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Kevin Wolf
 <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
Message-ID: <002be4e5-70c1-2c85-53de-327f202f1b31@redhat.com>
Subject: Re: [PATCH v2 2/6] block/dirty-bitmaps: rename frozen predicate
 helper
References: <20190213232356.21034-1-jsnow@redhat.com>
 <20190213232356.21034-3-jsnow@redhat.com>
In-Reply-To: <20190213232356.21034-3-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2/13/19 5:23 PM, John Snow wrote:
> "Frozen" was a good description a long time ago, but it isn't adequate =
now.
> Rename the frozen predicate to has_successor to make the semantics of t=
he
> predicate more clear to outside callers.
>=20
> In the process, remove some calls to frozen() that no longer semantical=
ly
> make sense. For enabled and disabled in particular, it's actually okay =
for
> the internals to do this but only forbidden for users to invoke them, a=
nd
> all of the QMP entry uses already check against qmp_locked.
>=20
> Several other assertions really want to check that the bitmap isn't in-=
use
> by another operation -- use the qmp_locked function for this instead, w=
hich
> presently also checks for has_successor.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  block/dirty-bitmap.c           | 32 +++++++++++++++++---------------
>  include/block/dirty-bitmap.h   |  2 +-
>  migration/block-dirty-bitmap.c |  2 +-
>  3 files changed, 19 insertions(+), 17 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--zGEaAiV4IrgZL50MB1qyPkpyVwH5K5lcc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxk2QcACgkQp6FrSiUn
Q2pLGwgArf31/ipZZXVMPqc5vwmBA0OBpgwT8SWCmL0nDl35c6BhCgeAA88PbiWd
w5PkrQxWpCRQRK2uxp0tE7zY5I+abfz6x4mZMHVdpwrKhwmiwZKTcTBXeID6EZVq
NjRU6vSCnGGAzGfrVx6C47cZJKN6SStekSxgc8oWSItO3QQxjCcsost19OrIc7SE
ZvKj5swHjAabLYWflzFexIbyC6pf4kiWHX7HwPBbYabSnJQVhvE1a/5S+ct07Bhi
Eg0lj1GKb7HhjDlg7OIqr6YS6fkZa9XPQGTTUAP4NmzUS2mCAqooZg3inW0/5uJ2
Y+B2pFoUXTwaJDNdvqfnIhYy9djMJA==
=/zfy
-----END PGP SIGNATURE-----

--zGEaAiV4IrgZL50MB1qyPkpyVwH5K5lcc--

Received: from eggs.gnu.org ([209.51.188.92]:34414)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gtcb5-0001yt-6X
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 13:15:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gtcYR-0004dH-E8
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 13:13:13 -0500
References: <20190212010248.11056-1-jsnow@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <04ac803b-1faa-f184-2fd8-10a202bd6042@redhat.com>
Date: Tue, 12 Feb 2019 12:12:35 -0600
MIME-Version: 1.0
In-Reply-To: <20190212010248.11056-1-jsnow@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ofiUQoKhAPgZTwMVDYax7W6Yzb7HDYPCM"
Subject: Re: [Qemu-devel] [PATCH 0/5] dirty-bitmaps: deprecate @status field
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
--ofiUQoKhAPgZTwMVDYax7W6Yzb7HDYPCM
From: Eric Blake <eblake@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Juan Quintela <quintela@redhat.com>, qemu-block@nongnu.org,
 Fam Zheng <fam@euphon.net>, vsementsov@virtuozzo.com,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz
 <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>
Message-ID: <04ac803b-1faa-f184-2fd8-10a202bd6042@redhat.com>
Subject: Re: [PATCH 0/5] dirty-bitmaps: deprecate @status field
References: <20190212010248.11056-1-jsnow@redhat.com>
In-Reply-To: <20190212010248.11056-1-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2/11/19 7:02 PM, John Snow wrote:
> The current internal meanings of "locked", "user_locked",
> "qmp_locked", "frozen", "enabled", and "disabled" are all
> a little muddled.
>=20
> Deprecate the @status field in favor of two new booleans
> that carry very specific meanings. Then, rename and rework
> some of the internal semantics to help make the API a bit
> more clear and easier to read.

So far, my libvirt patches are not relying on the contents of the status
field, so deprecating things should not hurt libvirt. Using the full
2-cycle process is still probably wise for other users, though, even if
it means for some awkward back-compat computation of status for a while
longer.

>=20
> Well, in my opinion.
>=20
> Based on my current bitmaps branch (includes Eric's patch
> and my documentation update patch.)
>=20
> John Snow (5):
>   block/dirty-bitmap: add recording and busy properties
>   block/dirty-bitmaps: rename frozen predicate helper
>   block/dirty-bitmap: change semantics of enabled predicate
>   block/dirty-bitmap: explicitly lock bitmaps with successors
>   block/dirty-bitmaps: unify qmp_locked and user_locked calls
>=20
>  block/dirty-bitmap.c           | 74 +++++++++++++++++++---------------=

>  blockdev.c                     | 18 ++++-----
>  include/block/dirty-bitmap.h   |  7 ++--
>  migration/block-dirty-bitmap.c |  8 ++--
>  nbd/server.c                   |  6 +--
>  qapi/block-core.json           |  9 ++++-
>  tests/qemu-iotests/236.out     | 28 +++++++++++++
>  7 files changed, 96 insertions(+), 54 deletions(-)

No change to qemu-deprecated.texi to start the clock ticking, so we can
remove the old field?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--ofiUQoKhAPgZTwMVDYax7W6Yzb7HDYPCM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxjDJMACgkQp6FrSiUn
Q2pXRgf/VFN+VZfasINhAKAsVVHjSjf2xIsAtk+8SB4AkRZdqrwJL8mONRb2pQGl
0pdJH7nb6ychBALCPp0JfDZ3NaBHyXf8T4ZK2+ODpk6VfS69JiC/1juexm1l9v/R
6aTOQwfx3aNydQfd1qnJV0420uiK2jNDdA4i18X1tJ02UZg5egnmTVm1LDGzZDeV
Go2p9TNQ1uZrGfNqR+HXSVtJ/tXsYnYYrmY/rk3FUPkFHpu68276rJIuN9/63Yqt
Sy+EVp/G3KrApa7ypXqIDeVCqxbMfr82Eqgv5CREFma2cmqF0Kv6026i267d2yct
50pn8yTOPDX8Gp4dluI5gizIXJOPgQ==
=7H54
-----END PGP SIGNATURE-----

--ofiUQoKhAPgZTwMVDYax7W6Yzb7HDYPCM--

Received: from eggs.gnu.org ([2001:4830:134:3::10]:46013)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ebnlW-0001h9-JX
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 08:28:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ebnlS-0000bt-LP
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 08:28:30 -0500
References: <20171110224302.14424-1-mreitz@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <e6d13697-b7b5-5c8f-1a1f-61ac30ad8016@redhat.com>
Date: Wed, 17 Jan 2018 14:28:13 +0100
MIME-Version: 1.0
In-Reply-To: <20171110224302.14424-1-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="0Se7pm9DY6JGs4dK7nNpdd6qXqvCuNQOA"
Subject: Re: [Qemu-devel] [PATCH for-2.12 0/4] blockdev: Mark BD-{remove,
 insert}-medium stable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0Se7pm9DY6JGs4dK7nNpdd6qXqvCuNQOA
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Eric Blake <eblake@redhat.com>
Message-ID: <e6d13697-b7b5-5c8f-1a1f-61ac30ad8016@redhat.com>
Subject: Re: [PATCH for-2.12 0/4] blockdev: Mark BD-{remove,insert}-medium
 stable
References: <20171110224302.14424-1-mreitz@redhat.com>
In-Reply-To: <20171110224302.14424-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-11-10 23:42, Max Reitz wrote:
> Berto's "Test I/O limits with removable media" patch proves that
> throttling survives a blockdev-remove-medium/blockdev-insert-medium pai=
r
> now, so let's mark them stable (because that was the reason they were
> considered experimental, see commit
> 6e0abc251dd4f8eba1f53656dfede12e5840e83b for more).
>=20
> But before we do that, let's use the chance and drop the @device
> parameter.
>=20
>=20
> Based-on: <cover.1510339534.git.berto@igalia.com>
> ("Fix throttling crashes in BlockBackend with no BlockDriverState",
>  because of the test case added there)
>=20
>=20
> Max Reitz (4):
>   iotests: Make BD-{remove,insert}-medium use @id
>   tests/ahci: Switch tray and medium commands to @id
>   blockdev: Drop BD-{remove,insert}-medium's @device
>   blockdev: Mark BD-{remove,insert}-medium stable
>=20
>  qapi/block-core.json   |  42 ++++-------
>  blockdev.c             |  30 ++++++--
>  tests/ahci-test.c      |  16 ++---
>  tests/qemu-iotests/093 |   6 +-
>  tests/qemu-iotests/118 | 184 +++++++++++++++++++++++------------------=
--------
>  tests/qemu-iotests/139 |   2 +-
>  tests/qemu-iotests/155 |  60 ++++++++--------
>  7 files changed, 163 insertions(+), 177 deletions(-)

Applied to my block branch.

Max


--0Se7pm9DY6JGs4dK7nNpdd6qXqvCuNQOA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlpfT20SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ABIUH/jVv/2ohy80ib9hH9HXoiHcPtnESUAwo
G726UZ6YVUO2+54SvizKcvOHgzS22tQ2l+pZOfh2gPV5IkQfudlege+qtcKK8Zsn
7cPHGKuz3RElkdc7+XaV3wmRxP8B7YWq/e67Q72AakE89ViNjqP0JsiJR642GRdE
KHlBtvm9klVEF23S55QgwW7wsFva/uGc/Oa4dLJ0w02WWZ8WAbTbN+zttFwSTS8z
ty5SqYshCscvS4z676rCGENF8mBprFNXyEVQhcqGRjnuWcAPpy2/AVKPAQLxVnZb
Mr5MY52tJL0wy6rmasuSjGK5y8+py/30cBcHJ63DU172zKLIbaqHiUs=
=7kOz
-----END PGP SIGNATURE-----

--0Se7pm9DY6JGs4dK7nNpdd6qXqvCuNQOA--

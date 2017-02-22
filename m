Received: from eggs.gnu.org ([2001:4830:134:3::10]:35121)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cgXb3-0002fm-KU
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 09:08:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cgXb2-0001Kk-OP
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 09:08:45 -0500
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
	<1487689130-30373-19-git-send-email-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <7a65cd44-b141-bd46-2727-1c96aa3b965f@redhat.com>
Date: Wed, 22 Feb 2017 15:08:34 +0100
MIME-Version: 1.0
In-Reply-To: <1487689130-30373-19-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="LKcwwU5njos9Jfq7iHx2anAdH2SVwLTj7"
Subject: Re: [Qemu-devel] [PATCH 18/54] block: Default .bdrv_child_perm()
 for format drivers
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
--LKcwwU5njos9Jfq7iHx2anAdH2SVwLTj7
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org
Message-ID: <7a65cd44-b141-bd46-2727-1c96aa3b965f@redhat.com>
Subject: Re: [PATCH 18/54] block: Default .bdrv_child_perm() for format
 drivers
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
 <1487689130-30373-19-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487689130-30373-19-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 21.02.2017 15:58, Kevin Wolf wrote:
> Almost all format drivers have the same characteristics as far as
> permissions are concerned: They have one or more children for storing
> their own data and, more importantly, metadata (can be written to and
> grow even without external write requests, must be protected against
> other writers and present consistent data) and optionally a backing fil=
e
> (this is just data, so like for a filter, it only depends on what the
> parent nodes need).
>=20
> This provides a default implementation that can be shared by most of
> our format drivers.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block.c                   | 42 +++++++++++++++++++++++++++++++++++++++=
+++
>  include/block/block_int.h |  8 ++++++++
>  2 files changed, 50 insertions(+)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--LKcwwU5njos9Jfq7iHx2anAdH2SVwLTj7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlitm2ISHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AhGQH/1qqzQ/5G+9m/PBmWE+1tDfQV5QsJEi9
KGq+gfw8ke9uMTTQDczhyazQ2tx+UXKKZ5/6ZaoRpoGbBs05oizgqP1zQ0H7MZHG
eUG53+by5EusrStq5zbp4lVg9s6Lo4jv+hzz5ocDisYThPKCPtRdGvq3ce3LpPXK
DDAPINxFCFFiWdYdfMpaP+fN23a3CzBAhAtpCaMoAMiqBD3YFxNs6PhKLHcmvKJL
KZ02mU4+pmzWLdoLeOPJxG+0o1nbg41lwI2XFHNeGqbMOztpBxpVLHaBYPhprmDB
se0Fm0Llroet72KUM+ozY9ot5WlFReazvKMVtss8L0hZxfDSlrLCNBo=
=3mpD
-----END PGP SIGNATURE-----

--LKcwwU5njos9Jfq7iHx2anAdH2SVwLTj7--

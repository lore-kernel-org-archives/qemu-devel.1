Received: from eggs.gnu.org ([2001:4830:134:3::10]:50016)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cijHV-0006zX-9H
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 10:01:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cijHR-0008Cz-GO
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 10:01:37 -0500
References: <1488286469-9381-1-git-send-email-kwolf@redhat.com>
	<1488286469-9381-8-git-send-email-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <bedbb62d-c351-a3f9-3186-e4bbcf2587a9@redhat.com>
Date: Tue, 28 Feb 2017 16:01:24 +0100
MIME-Version: 1.0
In-Reply-To: <1488286469-9381-8-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="H2veIAVA5kJfsBA2e4ovSieXpAHpTdvkT"
Subject: Re: [Qemu-devel] [PATCH v3 07/44] block: Default .bdrv_child_perm()
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
--H2veIAVA5kJfsBA2e4ovSieXpAHpTdvkT
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org
Message-ID: <bedbb62d-c351-a3f9-3186-e4bbcf2587a9@redhat.com>
Subject: Re: [PATCH v3 07/44] block: Default .bdrv_child_perm() for format
 drivers
References: <1488286469-9381-1-git-send-email-kwolf@redhat.com>
 <1488286469-9381-8-git-send-email-kwolf@redhat.com>
In-Reply-To: <1488286469-9381-8-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 28.02.2017 13:53, Kevin Wolf wrote:
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
>  block.c                   | 44 +++++++++++++++++++++++++++++++++++++++=
+++++
>  include/block/block_int.h |  8 ++++++++
>  2 files changed, 52 insertions(+)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--H2veIAVA5kJfsBA2e4ovSieXpAHpTdvkT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAli1kMQSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A4LgH+wQs49pyTdilRF8kpVJLCs9rR4ohGwPE
mjd3JqkzQnlkqwyW6wmWP1UtBZioHkKLtdHDA5vr/IuiL1Ap+nRkb8QmJLw+ESIt
Iak3FDtN7WImADBBxKsbaSUKjJZHaVSiYae+4B7b35QScbVcZ1uG0QBybSqOWVf/
z588hecnqHdqvXU/UtR/HNVxODJKkIJP8uHHP9IczQ4pOWS2aay7FIDBu+enEFk5
d5ZObq9PSOL3eVZoJiNeW1aDpIa7fuS2aXDEGbo0aWVaShDaGmMAALtktXNoZ1dz
3QnZKq3v7BZoVXokwQDtc6wHZO94EABKwUHgRD7ihjPyaB+cuJ9twJY=
=P+A4
-----END PGP SIGNATURE-----

--H2veIAVA5kJfsBA2e4ovSieXpAHpTdvkT--

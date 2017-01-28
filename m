Received: from eggs.gnu.org ([2001:4830:134:3::10]:48838)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cXab7-00017K-T1
	for qemu-devel@nongnu.org; Sat, 28 Jan 2017 16:31:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cXab3-0005r1-De
	for qemu-devel@nongnu.org; Sat, 28 Jan 2017 16:31:49 -0500
References: <20170123121036.4823-1-vsementsov@virtuozzo.com>
	<20170123121036.4823-9-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <633cb17f-fb49-46d7-2c94-4659237d1970@redhat.com>
Date: Sat, 28 Jan 2017 22:31:30 +0100
MIME-Version: 1.0
In-Reply-To: <20170123121036.4823-9-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="xcvmeKlwq8LGJSvpNsnekHOs6upf4nK44"
Subject: Re: [Qemu-devel] [PATCH 08/24] block: introduce auto-loading bitmaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xcvmeKlwq8LGJSvpNsnekHOs6upf4nK44
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com,
 famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com
Message-ID: <633cb17f-fb49-46d7-2c94-4659237d1970@redhat.com>
Subject: Re: [PATCH 08/24] block: introduce auto-loading bitmaps
References: <20170123121036.4823-1-vsementsov@virtuozzo.com>
 <20170123121036.4823-9-vsementsov@virtuozzo.com>
In-Reply-To: <20170123121036.4823-9-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 23.01.2017 13:10, Vladimir Sementsov-Ogievskiy wrote:
> Auto loading bitmaps are bitmaps stored in the disk image, which should=

> be loaded when the image is opened and become BdrvDirtyBitmaps for the
> corresponding drive.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: John Snow <jsnow@redhat.com>
> ---
>  block.c                   | 14 ++++++++++++++
>  include/block/block.h     |  2 ++
>  include/block/block_int.h |  3 +++
>  3 files changed, 19 insertions(+)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--xcvmeKlwq8LGJSvpNsnekHOs6upf4nK44
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAliNDbISHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AoecH/ihm411++N13QJzxOnAeUfmOcI3PQ1LD
v+sPG+tOB/RPrwvX/ZJ2M/1/gmoVdBjFPINxJ+4hsYVL51rN9DlZcHSGUkxo3ltu
YGobjvxlXvwgdt3lKR3EtudUJNCq2AVxDTnv0qVZUqTse+uj7JYyP5Flcn3ZXFUy
lRvurCkrMWps2uP6Uuot1cYduWo+TOXwW8FpHOnNff55iU/6zq+z7L9fg38gk1Xe
QF2hrkiHIqOJudIrkyA7Bh4ajbEl2kzuX5Sm9PgUs3Cgmrt8wnn3KSFV7FogBUqs
mUWYnKnyOHArnG00UYn12PTz8s21IQJBMbm6bDS4a8L1/3wE08XLw90=
=QJQ2
-----END PGP SIGNATURE-----

--xcvmeKlwq8LGJSvpNsnekHOs6upf4nK44--

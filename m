Received: from eggs.gnu.org ([2001:4830:134:3::10]:56723)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dAdsb-0002uu-C5
	for qemu-devel@nongnu.org; Tue, 16 May 2017 10:55:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dAdsa-0006MN-PG
	for qemu-devel@nongnu.org; Tue, 16 May 2017 10:55:17 -0400
Date: Tue, 16 May 2017 15:55:03 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170516145503.GL8498@stefanha-x1.localdomain>
References: <20170511144208.24075-1-pbonzini@redhat.com>
	<20170511144208.24075-15-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DN8g+DOX2TxGxleI"
Content-Disposition: inline
In-Reply-To: <20170511144208.24075-15-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 14/18] block: introduce dirty_bitmap_mutex
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com, qemu-block@nongnu.org


--DN8g+DOX2TxGxleI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 11, 2017 at 04:42:04PM +0200, Paolo Bonzini wrote:
> It protects only the list of dirty bitmaps; in the next patch we will
> also protect their content.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>         v1->v2: remove global mutex [Fam]
>=20
>  block/dirty-bitmap.c      | 44 +++++++++++++++++++++++++++++++++++++++++=
++-
>  block/mirror.c            |  3 ++-
>  blockdev.c                | 44 +++++++----------------------------------=
---
>  include/block/block_int.h |  5 +++++
>  migration/block.c         |  6 ------
>  5 files changed, 57 insertions(+), 45 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--DN8g+DOX2TxGxleI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZGxLHAAoJEJykq7OBq3PIZC4IAIqbsaCMsx+Y4P+6Ej24/pxR
/UJZIO3zrPeJTlwkhqD654a1d0CAolLRMYSvjCK8teUXuWk6TUCf1Rchoizwx68S
VAS/ShkXdxZkiBcadBED0OzMkvG1Y6svgBth/y17dn7oZsFO6wRMZm9gNZRPePtQ
p1WYMiX/OMjRYNYc/AbNlwZS/6pIHKMNSjh3wtxoRUVMGIZls/BWUvIwjNtHJFcw
DY7kcFICEdITWDvEixZfmEMZO456wyvHmWKsA7cftJ3zize5qNR+Jc4iNzKnTg5q
lGoehLDKhSiACxE1tQ0gXqfRocJFWa+8ObvE4nLqA62LAzCucLuuHcATK+cGi/Y=
=CV/u
-----END PGP SIGNATURE-----

--DN8g+DOX2TxGxleI--

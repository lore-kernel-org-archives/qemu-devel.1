Received: from eggs.gnu.org ([2001:4830:134:3::10]:49802)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d5zGU-0008Oa-EZ
	for qemu-devel@nongnu.org; Wed, 03 May 2017 14:44:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d5zGT-000303-Lz
	for qemu-devel@nongnu.org; Wed, 03 May 2017 14:44:42 -0400
References: <20170429191419.30051-1-eblake@redhat.com>
	<20170429191419.30051-3-eblake@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <0b0bc880-c296-b57b-b0da-0c0e79d08c1a@redhat.com>
Date: Wed, 3 May 2017 20:44:33 +0200
MIME-Version: 1.0
In-Reply-To: <20170429191419.30051-3-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="F2aUSpQdIil1qTO3gcU2iOueeGl1qOQKw"
Subject: Re: [Qemu-devel] [PATCH v11 2/9] qemu-io: Switch 'alloc' command to
 byte-based length
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
--F2aUSpQdIil1qTO3gcU2iOueeGl1qOQKw
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org
Message-ID: <0b0bc880-c296-b57b-b0da-0c0e79d08c1a@redhat.com>
Subject: Re: [PATCH v11 2/9] qemu-io: Switch 'alloc' command to byte-based
 length
References: <20170429191419.30051-1-eblake@redhat.com>
 <20170429191419.30051-3-eblake@redhat.com>
In-Reply-To: <20170429191419.30051-3-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 29.04.2017 21:14, Eric Blake wrote:
> For the 'alloc' command, accepting an offset in bytes but a length
> in sectors, and reporting output in sectors, is confusing.  Do
> everything in bytes, and adjust the expected output accordingly.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
>=20
> ---
> v11: s/bytes/count/ for the parameter name, drop R-b
> v10: rebase to code cleanup
> v9: new patch
> ---
>  qemu-io-cmds.c                    | 30 ++++++++++++++++++------------
>  tests/qemu-iotests/019.out        |  8 ++++----
>  tests/qemu-iotests/common.pattern |  2 +-
>  3 files changed, 23 insertions(+), 17 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--F2aUSpQdIil1qTO3gcU2iOueeGl1qOQKw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlkKJRESHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AqU0H/Rkg0dlIz0ucC7Ve7PpHpbDdsy6y+f4Z
VlO/0uGc48HxhSdFKo3cALmWz8+afkrpmVnXK4os8gG7jHF1FFTFyegPCrlE0k1e
i8v2OJOmZXZWBIBjxwea5p4b5/BrAHCCdwMjWvRthzwvKGlYHojjko9Nd3IhnI6P
bV0TTZSkIvNMtgduE7HitO5FmaK0txjcp/Y0p7IerR36pqakJCITUwUD8onMemPZ
L1ZV/PKrh1OuwFiRXAxp3dRN0tp+z65tKOInC1sh8e16zbhh6Uoqstl34WJKqVjC
+I660De+Xe1YkNzk/O6I07OEFjxxOarahEWMY+UIclH+J8YUa5OTsm4=
=8FGv
-----END PGP SIGNATURE-----

--F2aUSpQdIil1qTO3gcU2iOueeGl1qOQKw--

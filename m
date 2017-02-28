Received: from eggs.gnu.org ([2001:4830:134:3::10]:41924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cikCM-0007xL-FH
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 11:00:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cikCL-00053H-KI
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 11:00:22 -0500
References: <1488286469-9381-1-git-send-email-kwolf@redhat.com>
	<1488286469-9381-38-git-send-email-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <51442624-7c37-5b1a-e03d-cfbab8838e00@redhat.com>
Date: Tue, 28 Feb 2017 17:00:10 +0100
MIME-Version: 1.0
In-Reply-To: <1488286469-9381-38-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="1r8PuaDcBB0UVQ28OtKiw1FSf4FRJIEOh"
Subject: Re: [Qemu-devel] [PATCH v3 37/44] migration/block: Use real
 permissions
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
--1r8PuaDcBB0UVQ28OtKiw1FSf4FRJIEOh
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org
Message-ID: <51442624-7c37-5b1a-e03d-cfbab8838e00@redhat.com>
Subject: Re: [PATCH v3 37/44] migration/block: Use real permissions
References: <1488286469-9381-1-git-send-email-kwolf@redhat.com>
 <1488286469-9381-38-git-send-email-kwolf@redhat.com>
In-Reply-To: <1488286469-9381-38-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 28.02.2017 13:54, Kevin Wolf wrote:
> Request BLK_PERM_CONSISTENT_READ for the source of block migration, and=

> handle potential permission errors as good as we can in this place
> (which is not very good, but it matches the other failure cases).
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  migration/block.c | 22 +++++++++++++++++-----
>  1 file changed, 17 insertions(+), 5 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--1r8PuaDcBB0UVQ28OtKiw1FSf4FRJIEOh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAli1nooSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AWRIIALqao80hJxUE5PD/HQvEePLQLI+MLc0U
0e16dSNbxKPLsKzriqR2Ua4Q8a7CndUFxswz39a1ChqNlUgkKN1RMFT0DBCX/XX4
2/xMlmK7g5dSq6eOgSiZRZUbUFVz33Y0RmR+MMarUFY3ZloAdyPKDE5BjLfmRcfQ
S9qi8TuTitHDtsZUgSk5D0wi4r/4ZGlkyuQQRbLfqydEXBuLxZ85GNi6QzrEqwOO
toQtMCn9whw9NhlnDuvKPK2SZD5CBfBPWkbvKrKErcMEYWf/mO99S/iErZjJRztG
TtmmgAhf8hk7lOM2zYy09/1MgN9Dtu296y9XbYZ+79JkzIh+k6ufhiw=
=t579
-----END PGP SIGNATURE-----

--1r8PuaDcBB0UVQ28OtKiw1FSf4FRJIEOh--

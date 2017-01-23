Received: from eggs.gnu.org ([2001:4830:134:3::10]:49856)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cVjg9-0005Ir-VX
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 13:49:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cVjg6-0005lA-PA
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 13:49:22 -0500
References: <20161115225746.3590-1-mreitz@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <68247e89-a8f5-ea07-ef3d-d7918e054c82@redhat.com>
Date: Mon, 23 Jan 2017 19:49:03 +0100
MIME-Version: 1.0
In-Reply-To: <20161115225746.3590-1-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="rtvqaP2RH0M3x3CPF6hDie5NL90Mw4SaK"
Subject: Re: [Qemu-devel] [PATCH for-2.9 0/2] hbitmap: Add
 hbitmap_is_serializable()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, John Snow <jsnow@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rtvqaP2RH0M3x3CPF6hDie5NL90Mw4SaK
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Fam Zheng <famz@redhat.com>, John Snow <jsnow@redhat.com>
Message-ID: <68247e89-a8f5-ea07-ef3d-d7918e054c82@redhat.com>
Subject: Re: [PATCH for-2.9 0/2] hbitmap: Add hbitmap_is_serializable()
References: <20161115225746.3590-1-mreitz@redhat.com>
In-Reply-To: <20161115225746.3590-1-mreitz@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 15.11.2016 23:57, Max Reitz wrote:
> This series is a follow-up for "hbitmap: Fix shifts of constants by
> granularity".
>=20
> So far, adding the assertion in hbitmap_serialization_granularity() (as=

> done by said previous patch) is enough and we know that it will always
> hold true since bitmaps are only serialized as part of a test for now.
>=20
> However, in the future we need some other way than a failed assertion t=
o
> tell the user that they cannot serialize a certain bitmap. This series
> adds a function that can be called to tell whether a bitmap can be
> (de-)serialized.
>=20
>=20
> Max Reitz (2):
>   hbitmap: Add hbitmap_is_serializable()
>   test-hbitmap: Add hbitmap_is_serializable() calls
>=20
>  include/qemu/hbitmap.h | 13 +++++++++++++
>  tests/test-hbitmap.c   | 11 +++++++++++
>  util/hbitmap.c         | 22 +++++++++++++++++++---
>  3 files changed, 43 insertions(+), 3 deletions(-)

pingedy-ping


--rtvqaP2RH0M3x3CPF6hDie5NL90Mw4SaK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAliGUB8SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9Al5UIALpzN8GxkkrU01JbsKBhRIvy0kEPprO+
FyXkPP3fFeVFG4iiBE+7XbamIvjfGY8/ZwDGccGC+7I8+FYom6a5hb2HFnbimJpY
vyCPbZVhrkMiZwq33wumJfKYik6kvExDbY9zP9wfNY4JHBqWFrPHEBeWeY3UMr5e
x3mCZpStD68Q/r2DQtPa/mKWcYcUTD5nPZNZqhpM9Mzp0xPS08OqOyqRwmuDH+VV
w8Ai7bdQ1C93tcLZfmNHJ4HdoCdUW/5QQHKKkb1RIa2oS7GvODlRfvfKyInEWfId
/pLkTsOXdHXDmI0WirEmp9FnQp1ExzaH433+Pgij+oecy49a5P8zNfI=
=sWfr
-----END PGP SIGNATURE-----

--rtvqaP2RH0M3x3CPF6hDie5NL90Mw4SaK--

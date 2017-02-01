Received: from eggs.gnu.org ([2001:4830:134:3::10]:43641)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cZ28K-0004fy-DU
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 16:08:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cZ28J-0005AZ-9j
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 16:08:04 -0500
References: <20170201003120.23378-1-nirsof@gmail.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <805d84d3-9288-5699-17c0-6bc5defb7179@redhat.com>
Date: Wed, 1 Feb 2017 22:07:54 +0100
MIME-Version: 1.0
In-Reply-To: <20170201003120.23378-1-nirsof@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="TkFjfPg48FVkoQqTMHRlrTmFeavp6fhvU"
Subject: Re: [Qemu-devel] [PATCH v5 0/3] Fix qemu-io return value on failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nir Soffer <nirsof@gmail.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--TkFjfPg48FVkoQqTMHRlrTmFeavp6fhvU
From: Max Reitz <mreitz@redhat.com>
To: Nir Soffer <nirsof@gmail.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org
Message-ID: <805d84d3-9288-5699-17c0-6bc5defb7179@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 0/3] Fix qemu-io return value on failure
References: <20170201003120.23378-1-nirsof@gmail.com>
In-Reply-To: <20170201003120.23378-1-nirsof@gmail.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 01.02.2017 01:31, Nir Soffer wrote:
> This series fix qemu-io to fail with non zero exit code when failing to=
 open
> the file.
>=20
> Changes since v4:
> - Added _unsupported_fmt helper
> - Test any format except raw, instead of only raw
> - Don't test stderr content, depends on the format
> - New test move to 174 since 173 is pending
> - Private copyright for new test
> - Fix commit message issues
>=20
> Changes since v3:
> - Add cover letter
> - Squash the tests fix with the behavior change, so git bisect landing =
on the
>   change in behavior does not hit unnecessarily-broken tests.
>=20
> Tested by running qemu-io manually and by running tests/check-block.sh.=

> Note that test 059 has one unrelated test failure.
>=20
> Nir Soffer (3):
>   qemu-io: Return non-zero exit code on failure
>   qemu-iotests: Add _unsupported_fmt helper
>   qemu-io: Add failure regression tests
>=20
>  qemu-io.c                    |  8 ++++--
>  tests/qemu-iotests/059.out   |  3 ---
>  tests/qemu-iotests/070.out   |  1 -
>  tests/qemu-iotests/075.out   |  7 ------
>  tests/qemu-iotests/076.out   |  3 ---
>  tests/qemu-iotests/078.out   |  6 -----
>  tests/qemu-iotests/080.out   | 18 --------------
>  tests/qemu-iotests/083.out   | 17 -------------
>  tests/qemu-iotests/088.out   |  6 -----
>  tests/qemu-iotests/092.out   | 12 ---------
>  tests/qemu-iotests/116.out   |  7 ------
>  tests/qemu-iotests/131.out   |  1 -
>  tests/qemu-iotests/140.out   |  1 -
>  tests/qemu-iotests/174       | 59 ++++++++++++++++++++++++++++++++++++=
++++++++
>  tests/qemu-iotests/174.out   |  7 ++++++
>  tests/qemu-iotests/common.rc | 11 +++++++++
>  tests/qemu-iotests/group     |  1 +
>  17 files changed, 84 insertions(+), 84 deletions(-)
>  create mode 100755 tests/qemu-iotests/174
>  create mode 100644 tests/qemu-iotests/174.out

Thanks, I've applied the series to my block tree:

https://github.com/XanClic/qemu/commits/block

Max


--TkFjfPg48FVkoQqTMHRlrTmFeavp6fhvU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAliSTioSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AvgsIAMAvrK27WdgfJcgWQyiX4inwecR11XQZ
UMntIF2AmI6boAQa/lohvw37K+J44kNRtTMGceKtvL9Hlrf3vIEVAHB2RVw6fzLh
jiMR9rXICydtrsTiYaqqRt9HU7OJZnQZU3+KTKtR4gdKdqYEQsbX+Kriso18j0xr
BKQzDcXVFOW6K1QJGxniqcK3r6dopwARG96inPPsf883PhMgLXdhpalH5eRncI3z
/zfqg2EhEBz8iV+4V6vr7xDeu1qptEgF2K/p2sGU2vXo0zE5Re5vr1ge+VdIP8CY
bmpYnuz2Ef4pXXNan5CoBA99P0vBIuLV2H3ePzosHkPuLw+i89X58Wk=
=2GXo
-----END PGP SIGNATURE-----

--TkFjfPg48FVkoQqTMHRlrTmFeavp6fhvU--

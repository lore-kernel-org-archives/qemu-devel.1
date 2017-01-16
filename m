Received: from eggs.gnu.org ([2001:4830:134:3::10]:33415)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cTDGN-00079b-Lc
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 14:48:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cTDGN-0006fX-06
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 14:48:19 -0500
References: <20170103182801.9638-1-berrange@redhat.com>
	<20170103182801.9638-7-berrange@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <b45c39a3-ba4b-a14f-3a97-35fef82758a1@redhat.com>
Date: Mon, 16 Jan 2017 20:48:09 +0100
MIME-Version: 1.0
In-Reply-To: <20170103182801.9638-7-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="wQKgHWELXjNvpNmb8k3pNQm1RGMkkA1n9"
Subject: Re: [Qemu-devel] [PATCH v1 06/15] iotests: skip 048 with qcow which
 doesn't support resize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wQKgHWELXjNvpNmb8k3pNQm1RGMkkA1n9
From: Max Reitz <mreitz@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Message-ID: <b45c39a3-ba4b-a14f-3a97-35fef82758a1@redhat.com>
Subject: Re: [PATCH v1 06/15] iotests: skip 048 with qcow which doesn't
 support resize
References: <20170103182801.9638-1-berrange@redhat.com>
 <20170103182801.9638-7-berrange@redhat.com>
In-Reply-To: <20170103182801.9638-7-berrange@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 03.01.2017 19:27, Daniel P. Berrange wrote:
> Test 048 is designed to verify data preservation during an
> image resize. The qcow (v1) format impl has never supported
> resize so always fails.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  tests/qemu-iotests/048 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--wQKgHWELXjNvpNmb8k3pNQm1RGMkkA1n9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlh9I3kSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AYY8IALpv95TefTtoo6mLQmAT8qMiK3P7RSK5
3/0rAEdgESbK6+kugRR7Xu7FqFyzH5VZqFjEdsMHKXiZeKSwO6K12YYY7iCOIUGN
6HNlmvv7XR4fW3kZOWr1PAUTU8YdbbXlX2nvreje+KYolJlhfbjLJ+SgeIItZEwW
KthzIG8arhWtL7K9Wc2cd7nO4GSO9pYOSXC2YSXlm3vRAB+Ba4xDIywg4O9j7Iwe
WES/wZp7zt4JCYBe4GUV2Pod1/4Xalf8vSPriDmjdCClw/yqQcTdgyXmtSf14uEi
QrOUvHgcxsvwe6tcsfesQ+KnV7c+gyTsMRgh0eNBN+DCM3r7GJGyVac=
=H9Ez
-----END PGP SIGNATURE-----

--wQKgHWELXjNvpNmb8k3pNQm1RGMkkA1n9--

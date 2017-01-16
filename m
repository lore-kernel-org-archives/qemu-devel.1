Received: from eggs.gnu.org ([2001:4830:134:3::10]:60782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cTDB5-0002d3-PG
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 14:42:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cTDB4-0005Ex-TR
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 14:42:51 -0500
References: <20170103182801.9638-1-berrange@redhat.com>
	<20170103182801.9638-6-berrange@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <4127cdca-02be-df4a-b77f-0a285951922c@redhat.com>
Date: Mon, 16 Jan 2017 20:42:41 +0100
MIME-Version: 1.0
In-Reply-To: <20170103182801.9638-6-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="AJQOaQuhk3IqITWHw7B5xBH9eRlK2sDPK"
Subject: Re: [Qemu-devel] [PATCH v1 05/15] iotests: skip 042 with qcow which
 dosn't support zero sized images
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
--AJQOaQuhk3IqITWHw7B5xBH9eRlK2sDPK
From: Max Reitz <mreitz@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Message-ID: <4127cdca-02be-df4a-b77f-0a285951922c@redhat.com>
Subject: Re: [PATCH v1 05/15] iotests: skip 042 with qcow which dosn't support
 zero sized images
References: <20170103182801.9638-1-berrange@redhat.com>
 <20170103182801.9638-6-berrange@redhat.com>
In-Reply-To: <20170103182801.9638-6-berrange@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 03.01.2017 19:27, Daniel P. Berrange wrote:
> Test 042 is designed to verify operation with zero sized images.
> Such images are not supported with qcow (v1), so this test has
> always failed.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  tests/qemu-iotests/042 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--AJQOaQuhk3IqITWHw7B5xBH9eRlK2sDPK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlh9IjESHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AAUAIAKqwBXbD/kqqighZ9rdfTSGzGt/p+7gR
JwdpmU+2mnaI8qh/ObqT4rwlI/AhVRGnRrZtHl3dWabOVf8LvxHuPzFQ5hqBloFX
TNRp5sDYJ8qukdKyVcKZrMREaGLYItDBOa347/ytyAdNOgWvv+kQ5dcWBXH2/ujS
Vz28qZrRbrwOH3BlOetwgMNiuQRlWF9QPMTYAha0YKMYtCTfj69N28sogFht2QHT
5XAD/79FtW3mK97/JYAqlIom0U4XExjl9VktEfJtvOneP5cOqiSWEhJLXXhQBLjS
I10nkoJSEgjmbvGs+Sf95/wCrnTxYkNTfl+YV4CtHQAZU7KcmoMW8S4=
=LzB/
-----END PGP SIGNATURE-----

--AJQOaQuhk3IqITWHw7B5xBH9eRlK2sDPK--

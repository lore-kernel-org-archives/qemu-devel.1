Received: from eggs.gnu.org ([2001:4830:134:3::10]:52748)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dwqEX-0006U8-JU
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 09:49:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dwqET-0006G7-1R
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 09:49:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56286)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dwqES-0006FA-O5
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 09:49:04 -0400
References: <20170926110134.2786-1-famz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d916ab4b-dd2e-3b54-64a7-bfc76c822b58@redhat.com>
Date: Tue, 26 Sep 2017 08:48:58 -0500
MIME-Version: 1.0
In-Reply-To: <20170926110134.2786-1-famz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="t8x759oJKs9JNvKvCm4vmTfintMVlCWgd"
Subject: Re: [Qemu-devel] [PATCH] docker: test-block: Don't continue if
 build fails
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--t8x759oJKs9JNvKvCm4vmTfintMVlCWgd
From: Eric Blake <eblake@redhat.com>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <d916ab4b-dd2e-3b54-64a7-bfc76c822b58@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] docker: test-block: Don't continue if build
 fails
References: <20170926110134.2786-1-famz@redhat.com>
In-Reply-To: <20170926110134.2786-1-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/26/2017 06:01 AM, Fam Zheng wrote:
> Report error and exit upon compiling error, otherwise the iotests outpu=
t
> will be pure noise.
>=20
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  tests/docker/test-block | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

>=20
> diff --git a/tests/docker/test-block b/tests/docker/test-block
> index 2ca1ce54f6..5624b81827 100755
> --- a/tests/docker/test-block
> +++ b/tests/docker/test-block
> @@ -14,7 +14,7 @@
> =20
>  cd "$BUILD_DIR"
> =20
> -build_qemu --target-list=3Dx86_64-softmmu
> +build_qemu --target-list=3Dx86_64-softmmu || test_fail "Build failed"
>  cd tests/qemu-iotests
>  for t in raw qcow2 nbd luks; do
>      ./check -g quick -$t || test_fail "Test failed: iotests $t"
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--t8x759oJKs9JNvKvCm4vmTfintMVlCWgd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnKWsoACgkQp6FrSiUn
Q2r7Mwf+OhGj55MZojHVhss7GDU6Q1NQfPuZxjiHEn8pXx2DGQOKaK+U02iTBR9c
npUtfcgguQKC6i4sORGYguKv3r0mmRBH7ZxOMtJBzNHxrxHv4B0ftMTel+D2fQ2C
NSQfOeDe2GQhrpvc99Zha1JuUyImyBWU8rGNtc2xg8pxXVgJxwHVp9WBeOpM90ld
xyaZTliET5Cua0KMr6w9ssH4qb8qdNw20pjQZ6Rp6qDnif61QraGQaEw+vKctKOD
rmn2kIqlA5kLla9NwhIIru6WzdhzvWIHacv7fJkXTU+v5IeQGwHHkYPn7iunQ0Cu
gosdGZl3nJf3IXIUcZPsDmo7m924hA==
=ATv4
-----END PGP SIGNATURE-----

--t8x759oJKs9JNvKvCm4vmTfintMVlCWgd--

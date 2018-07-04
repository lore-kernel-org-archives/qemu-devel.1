Received: from eggs.gnu.org ([2001:4830:134:3::10]:60664)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fak3l-00086O-Po
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 11:51:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fak3i-0000zJ-L1
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 11:51:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33278 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fak3i-0000yl-Fr
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 11:51:10 -0400
Date: Wed, 4 Jul 2018 16:51:04 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180704155104.GN32267@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180704153919.12432-1-f4bug@amsat.org>
	<20180704153919.12432-4-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180704153919.12432-4-f4bug@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/8] crypto: Remove useless casts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Laurent Vivier <laurent@vivier.eu>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org

On Wed, Jul 04, 2018 at 12:39:14PM -0300, Philippe Mathieu-Daud=C3=A9 wro=
te:
> Patch created mechanically by rerunning:
>=20
>   $  spatch --sp-file scripts/coccinelle/typecast.cocci \
>             --macro-file scripts/cocci-macro-file.h \
>             --dir . --in-place
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  crypto/cipher-builtin.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/crypto/cipher-builtin.c b/crypto/cipher-builtin.c
> index d8c811fd33..7eff760f0a 100644
> --- a/crypto/cipher-builtin.c
> +++ b/crypto/cipher-builtin.c
> @@ -133,7 +133,7 @@ static void qcrypto_cipher_aes_xts_encrypt(const vo=
id *ctx,
>  {
>      const QCryptoCipherBuiltinAESContext *aesctx =3D ctx;
> =20
> -    qcrypto_cipher_aes_ecb_encrypt((AES_KEY *)&aesctx->enc,
> +    qcrypto_cipher_aes_ecb_encrypt(&aesctx->enc,
>                                     src, dst, length);

qcrypto_cipher_aes_ecb_encrypt expects a 'AES_KEY *' parameter, but
'&aesctx->enc, is a 'const AES_KEY *'. The cast is needed to discard
the const-ness.

> @@ -145,7 +145,7 @@ static void qcrypto_cipher_aes_xts_decrypt(const vo=
id *ctx,
>  {
>      const QCryptoCipherBuiltinAESContext *aesctx =3D ctx;
> =20
> -    qcrypto_cipher_aes_ecb_decrypt((AES_KEY *)&aesctx->dec,
> +    qcrypto_cipher_aes_ecb_decrypt(&aesctx->dec,
>                                     src, dst, length);

Same here.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

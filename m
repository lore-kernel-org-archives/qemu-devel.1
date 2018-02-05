Received: from eggs.gnu.org ([2001:4830:134:3::10]:45845)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eimVH-0007Lc-7t
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:32:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eimVD-0006ht-B8
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:32:35 -0500
Received: from mail-qt0-x236.google.com ([2607:f8b0:400d:c0d::236]:44404)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eimVD-0006hC-4p
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 14:32:31 -0500
Received: by mail-qt0-x236.google.com with SMTP id l20so41047342qtj.11
	for <qemu-devel@nongnu.org>; Mon, 05 Feb 2018 11:32:31 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180205114938.15784-1-berrange@redhat.com>
	<20180205114938.15784-3-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <19fcd335-9cb3-f377-0938-2125c677655c@amsat.org>
Date: Mon, 5 Feb 2018 16:32:26 -0300
MIME-Version: 1.0
In-Reply-To: <20180205114938.15784-3-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="YqwQQbLjRgCtFyQa3zgmVv0M47OJpHtCX"
Subject: Re: [Qemu-devel] [PATCH 2/4] ui: avoid 'local_err' variable
 shadowing in VNC SASL auth
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Laszlo Ersek <lersek@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--YqwQQbLjRgCtFyQa3zgmVv0M47OJpHtCX
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: =?UTF-8?Q?Daniel_P._Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Laszlo Ersek <lersek@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <19fcd335-9cb3-f377-0938-2125c677655c@amsat.org>
Subject: Re: [Qemu-devel] [PATCH 2/4] ui: avoid 'local_err' variable shadowing
 in VNC SASL auth
References: <20180205114938.15784-1-berrange@redhat.com>
 <20180205114938.15784-3-berrange@redhat.com>
In-Reply-To: <20180205114938.15784-3-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/05/2018 08:49 AM, Daniel P. Berrang=C3=A9 wrote:
> The start_auth_sasl() method declares a 'Error *local_err' variable in
> an inner if () {...} scope, which shadows a variable of the same name
> declared at the start of the method. This is confusing for reviewers an=
d
> may trigger compiler warnings.
>=20
> Reported-by: Laszlo Ersek <lersek@redhat.com>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

> ---
>  ui/vnc-auth-sasl.c | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/ui/vnc-auth-sasl.c b/ui/vnc-auth-sasl.c
> index fbccca8c8a..8ebd0d3d00 100644
> --- a/ui/vnc-auth-sasl.c
> +++ b/ui/vnc-auth-sasl.c
> @@ -556,7 +556,6 @@ void start_auth_sasl(VncState *vs)
>      /* Inform SASL that we've got an external SSF layer from TLS/x509 =
*/
>      if (vs->auth =3D=3D VNC_AUTH_VENCRYPT &&
>          vs->subauth =3D=3D VNC_AUTH_VENCRYPT_X509SASL) {
> -        Error *local_err =3D NULL;
>          int keysize;
>          sasl_ssf_t ssf;
> =20
> @@ -565,7 +564,6 @@ void start_auth_sasl(VncState *vs)
>          if (keysize < 0) {
>              trace_vnc_auth_fail(vs, vs->auth, "cannot TLS get cipher s=
ize",
>                                  error_get_pretty(local_err));
> -            error_free(local_err);
>              sasl_dispose(&vs->sasl.conn);
>              vs->sasl.conn =3D NULL;
>              goto authabort;
>=20


--YqwQQbLjRgCtFyQa3zgmVv0M47OJpHtCX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+qvnXhKRciHc/Wuy4+MsLN6twN4FAlp4sUsACgkQ4+MsLN6t
wN6tPhAAmviuWjXM0xyv4qR+zxxK+QJ4q5VlDNTnOeDREXxFbWPH/ndJG4gc0jv/
sg2KBMe7x3DMHI7p7DwIv/wDIRpg4KEGLfglT/0fmxqh2r+7ERbuYuc4vl6mDccN
PtqbmGdVWYCexCGn7JoNQvyhaNc6UEMeKQYZJ2Y/26SMuvaUgftaurC0xsUBXf9R
9kbc4cY/fyBeebKQX+8Pr0RIVxM8H36Xk9rsxVSZyJxG/yYuMKtmDn1KLysaz4/q
z/i2F7fwmbhP9o9wh9Z0Wtu7kmIQRojMQw0mrlHRYPJx8l0Sw0VIWU/f5yFPHny5
2P06EAmKeh0FBV0dbr41+LoUQ/KbteVEGZeZcFzrMFnsyKWqrWoU69VRuauEowQF
mpNel9X4bhJZ//CV9pjCwcahGHrRveJRubu+mPt5haw/UQX3sZuENbAl9OHlIFjl
132rdhozP4vOlfRwJ6+pDEfQ0UWMA1wXhWmVcFFMlCTQtRbMuSxxY/uqQwG0mUBO
wqrCUzQP6sqlfRsv1ncpSYxWK+8T2s/wmUL7Fm4EIWdE4dnOoEcQ8Cb6Nu7iOPJK
xwy6jkOsLLlxgFpXp+pglHbAltVb3Uke/9qy1zw5ioJCWABm5p1lnuLOyonpN/9N
tqxJgPXWtu8xAkANg7FkhIx9TCXq0GbN8nQTqV3JsdNFg35q1Vc=
=lCz2
-----END PGP SIGNATURE-----

--YqwQQbLjRgCtFyQa3zgmVv0M47OJpHtCX--

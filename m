Received: from eggs.gnu.org ([2001:4830:134:3::10]:56048)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dfsre-0001rz-Bb
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 15:11:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dfsra-0004AI-2Z
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 15:11:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44608)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dfsrZ-00048h-Pj
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 15:11:22 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 97BAC2C96F3
	for <qemu-devel@nongnu.org>; Thu, 10 Aug 2017 19:11:20 +0000 (UTC)
References: <20170810155522.31099-1-berrange@redhat.com>
	<20170810155522.31099-4-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <dfbfc64f-e14c-5811-8b10-7f6534d70f7c@redhat.com>
Date: Thu, 10 Aug 2017 14:11:16 -0500
MIME-Version: 1.0
In-Reply-To: <20170810155522.31099-4-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="vFWulBer6nGVXok4bgbr2N5l9IC6M3nAB"
Subject: Re: [Qemu-devel] [PATCH 03/15] ui: convert key events to QKeyCodes
 immediately
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vFWulBer6nGVXok4bgbr2N5l9IC6M3nAB
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <dfbfc64f-e14c-5811-8b10-7f6534d70f7c@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 03/15] ui: convert key events to QKeyCodes
 immediately
References: <20170810155522.31099-1-berrange@redhat.com>
 <20170810155522.31099-4-berrange@redhat.com>
In-Reply-To: <20170810155522.31099-4-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/10/2017 10:55 AM, Daniel P. Berrange wrote:
> Always use QKeyCode in the InputKeyEvent struct, by converting key
> numbers to QKeyCode at the time the event is created.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  ui/input.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

> diff --git a/ui/input.c b/ui/input.c
> index af05f06368..64e9103a61 100644
> --- a/ui/input.c
> +++ b/ui/input.c
> @@ -400,10 +400,8 @@ void qemu_input_event_send_key(QemuConsole *src, K=
eyValue *key, bool down)
> =20
>  void qemu_input_event_send_key_number(QemuConsole *src, int num, bool =
down)
>  {
> -    KeyValue *key =3D g_new0(KeyValue, 1);
> -    key->type =3D KEY_VALUE_KIND_NUMBER;
> -    key->u.number.data =3D num;
> -    qemu_input_event_send_key(src, key, down);
> +    QKeyCode code =3D qemu_input_key_number_to_qcode(num);
> +    qemu_input_event_send_key_qcode(src, code, down);
>  }
> =20
>  void qemu_input_event_send_key_qcode(QemuConsole *src, QKeyCode q, boo=
l down)
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--vFWulBer6nGVXok4bgbr2N5l9IC6M3nAB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmMr9QACgkQp6FrSiUn
Q2ouWAf+PvZLXbWt6/b/qw5pA5VG9om52cXlcFfpZtA38/SRHIB6DmCtgi7IAw3Y
wsaEpJk+VnEEMX72xdY+Q5XEBxuDzirx9yS31Dh+liLgq6hLXBD+TNh+X80jh5Ql
Bq9YYRALAJu0o4S/YXad84gVB0Nu6j3xowU9gTVDDPN+MAsXf3z3Cgux3eazMJVa
UKHPIMxu4D1R8+2LgAtiKKWJJr5ljeIdTW3OD6Jz5hW0221GrH5ELOmkbaM7LyWZ
pdRWtrNBsWcFn0vGKno5FdUQ30FAh3DTbskO49X7wRRTtGhYnufK3iSsRPxxAsqX
K9Psh31ioZ6UrOVtgqsR3vrzkHFlcA==
=pmzR
-----END PGP SIGNATURE-----

--vFWulBer6nGVXok4bgbr2N5l9IC6M3nAB--

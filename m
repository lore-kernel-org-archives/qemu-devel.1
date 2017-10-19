Received: from eggs.gnu.org ([2001:4830:134:3::10]:36302)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e5CZl-0004R4-LJ
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 11:17:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e5CZi-0003ii-DT
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 11:17:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49326)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1e5CZi-0003iB-48
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 11:17:34 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1A1C2A074E
	for <qemu-devel@nongnu.org>; Thu, 19 Oct 2017 15:17:33 +0000 (UTC)
References: <20171019142848.572-1-berrange@redhat.com>
	<20171019142848.572-2-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e7be1372-f8cc-a65b-2068-d430ee2e5cde@redhat.com>
Date: Thu, 19 Oct 2017 10:17:30 -0500
MIME-Version: 1.0
In-Reply-To: <20171019142848.572-2-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="OxS4sRp5OhQ3Wj6pQBLgpoIW1Vp2RpJ6b"
Subject: Re: [Qemu-devel] [PATCH v1 1/9] input: use hex in ps2 keycode trace
 events
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
--OxS4sRp5OhQ3Wj6pQBLgpoIW1Vp2RpJ6b
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <e7be1372-f8cc-a65b-2068-d430ee2e5cde@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v1 1/9] input: use hex in ps2 keycode trace
 events
References: <20171019142848.572-1-berrange@redhat.com>
 <20171019142848.572-2-berrange@redhat.com>
In-Reply-To: <20171019142848.572-2-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/19/2017 09:28 AM, Daniel P. Berrange wrote:
> Hardware scancodes are all documented in hex, so use that in trace
> events to make it easier to understand.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  hw/input/trace-events | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

>=20
> diff --git a/hw/input/trace-events b/hw/input/trace-events
> index 6fcb3c063f..d04132d342 100644
> --- a/hw/input/trace-events
> +++ b/hw/input/trace-events
> @@ -1,7 +1,7 @@
>  # See docs/devel/tracing.txt for syntax documentation.
> =20
>  # hw/input/ps2.c
> -ps2_put_keycode(void *opaque, int keycode) "%p keycode %d"
> +ps2_put_keycode(void *opaque, int keycode) "%p keycode 0x%02x"
>  ps2_read_data(void *opaque) "%p"
>  ps2_set_ledstate(void *s, int ledstate) "%p ledstate %d"
>  ps2_reset_keyboard(void *s) "%p"
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--OxS4sRp5OhQ3Wj6pQBLgpoIW1Vp2RpJ6b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEyBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnowgoACgkQp6FrSiUn
Q2oIugf3VtP9q0Px0A4TDpXQhnjJLtksb7LcjMCoAufmpqv8KdD34BIT8889wNdX
pzpeZb1S93C81xV8YMY1aNIx91MDhi6nyG2p5T8Pjgbb8ArA/uYiG8jLdz+H9xMf
Q02+/58pE45ih8kjG5l2aHiE0OdSMebUVcbDnXkrtwpH6Ada6mtVhhkR7qQRsNan
bRWx3Zd/STzKberwkc+CKQj3yE0fcwMvqITi0N1l37NRbt5AVwPl3QcG0TyhD8Iy
OSEF2d8nMCxvSLRhiIIUOLyKMa35SS+PYpM9XBd9CmodNLqK2eob0hgae8RDwzNy
npAbMuEnPOo+GsGkwRUYB4JpZ6dv
=2f5L
-----END PGP SIGNATURE-----

--OxS4sRp5OhQ3Wj6pQBLgpoIW1Vp2RpJ6b--

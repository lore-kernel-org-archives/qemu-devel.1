Received: from eggs.gnu.org ([2001:4830:134:3::10]:48614)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dmjhl-0003uD-OT
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 12:49:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dmjhi-0000RV-Lz
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 12:49:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38386)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dmjhi-0000RH-Cw
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 12:49:30 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 356F185376
	for <qemu-devel@nongnu.org>; Tue, 29 Aug 2017 16:49:29 +0000 (UTC)
References: <20170829164017.14178-1-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <58a43572-668b-7c49-609f-f3686f2740f4@redhat.com>
Date: Tue, 29 Aug 2017 11:49:27 -0500
MIME-Version: 1.0
In-Reply-To: <20170829164017.14178-1-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="q4AVG5LMBNR7P6tWTs7OEOSdHuWX8RshM"
Subject: Re: [Qemu-devel] [PATCH] io: fix check for handshake completion in
 TLS test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--q4AVG5LMBNR7P6tWTs7OEOSdHuWX8RshM
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Message-ID: <58a43572-668b-7c49-609f-f3686f2740f4@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] io: fix check for handshake completion in
 TLS test
References: <20170829164017.14178-1-berrange@redhat.com>
In-Reply-To: <20170829164017.14178-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/29/2017 11:40 AM, Daniel P. Berrange wrote:
> The TLS I/O channel test had mistakenly used && instead
> of || when checking for handshake completion. As a
> result it could terminate the handshake process before
> it had actually completed. This was harmless before but
> changes in GNUTLS 3.6.0 exposed this bug and caused the
> test suite to fail.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  tests/test-io-channel-tls.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

> diff --git a/tests/test-io-channel-tls.c b/tests/test-io-channel-tls.c
> index 8eaa208e1b..e7c80f46cf 100644
> --- a/tests/test-io-channel-tls.c
> +++ b/tests/test-io-channel-tls.c
> @@ -218,7 +218,7 @@ static void test_io_channel_tls(const void *opaque)=

>      mainloop =3D g_main_context_default();
>      do {
>          g_main_context_iteration(mainloop, TRUE);
> -    } while (!clientHandshake.finished &&
> +    } while (!clientHandshake.finished ||
>               !serverHandshake.finished);
> =20
>      g_assert(clientHandshake.failed =3D=3D data->expectClientFail);
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--q4AVG5LMBNR7P6tWTs7OEOSdHuWX8RshM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmlmxcACgkQp6FrSiUn
Q2okYgf+MoMePeYXbbzO3z7DfaqdXyX1QMR9VfpA6mRjcbhZyjyAt6OGKDBM7rwa
mam0QsSQ15HurxyhTfhNAz1YwGPFXbn9TufWQ7yQUMBgqV9rkOtLK7WaoKgnb+63
J0PNnTimy8E9K9Sam6etoo/dgYQpW8m2tTmOkVidVq/eWWsFcngAfojztfvhgsgX
aG7Ar+0vCPWoXWvsU+FO34K8K2O9YlEhNQngf3d5ZmAC6M3ruJ+kW6mYF5tnpYpM
py9HXZTBXVyxmhG7BAGl9ZrcdLSM2CsSwbkuH8hvPC6j+QWvaqogmXqXDXqd8OgH
gk3vIp+u4oHFxMZJVFl7oc+0toJsZw==
=FAzt
-----END PGP SIGNATURE-----

--q4AVG5LMBNR7P6tWTs7OEOSdHuWX8RshM--

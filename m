Received: from eggs.gnu.org ([209.51.188.92]:49659)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1goabm-0001cP-1j
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 16:07:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1goabl-0006S6-98
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 16:07:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38720)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1goabj-0006GS-CM
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 16:07:49 -0500
References: <20190129113921.21599-1-berrange@redhat.com>
	<20190129113921.21599-2-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f87b8474-ade5-2586-1dcf-9eef25bb3055@redhat.com>
Date: Tue, 29 Jan 2019 15:07:24 -0600
MIME-Version: 1.0
In-Reply-To: <20190129113921.21599-2-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="1dYXJKYNKc78bmBjvr9R5EEbDOhEqMJes"
Subject: Re: [Qemu-devel] [PATCH 1/5] nsis: don't install files into /tmp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Adam Baxter <voltagex@voltagex.org>, Stefan Weil <sw@weilnetz.de>, Peter Maydell <peter.maydell@linaro.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1dYXJKYNKc78bmBjvr9R5EEbDOhEqMJes
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Adam Baxter <voltagex@voltagex.org>, Stefan Weil <sw@weilnetz.de>,
 Peter Maydell <peter.maydell@linaro.org>
Message-ID: <f87b8474-ade5-2586-1dcf-9eef25bb3055@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/5] nsis: don't install files into /tmp
References: <20190129113921.21599-1-berrange@redhat.com>
 <20190129113921.21599-2-berrange@redhat.com>
In-Reply-To: <20190129113921.21599-2-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/29/19 5:39 AM, Daniel P. Berrang=C3=A9 wrote:
> The nsis installer target has to run 'make install' to populate a
> directory tree with content for the package. Replace the current
> usage of '/tmp/qemu-nsis' with a location underneath the build
> directory. This ensures that when a developer cleans their build
> directory, any left over files from the installer build process
> are also purged.
>=20
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20

Should "qemu-nsis-vroot/" be added to .gitignore for the sake of in-tree
builds?

> diff --git a/Makefile b/Makefile
> index de898eab62..362a98d275 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -907,7 +907,7 @@ endif
>  .PHONY: installer
>  installer: $(INSTALLER)
> =20
> -INSTDIR=3D/tmp/qemu-nsis
> +INSTDIR=3D$(BUILD_DIR)/qemu-nsis-vroot
> =20
>  $(INSTALLER): $(SRC_PATH)/qemu.nsi
>  	$(MAKE) install prefix=3D${INSTDIR}
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--1dYXJKYNKc78bmBjvr9R5EEbDOhEqMJes
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxQwIwACgkQp6FrSiUn
Q2r27gf9F9oRzqVJ6Yr3CExUqWZmOmo8TfdrV3R3L/zEiVqojn4yhwoJQ0wXhCL/
0hy2jMCMa3lBQUf4Mv2IalwP3hlRIpvusuBdNRxLUPxK6XAY+ZWb1NJ8IAXMO9qy
kjFadMx1PsrWTNUGjpjaGWm1LLXXWjOkcrPPtrdFhqXZpfHKyKCSE6vuikQnfwd0
9gD3ceQXBMFG60Ke5KCSTmg2C96UTWUNeffTl9xYmjebFw96P0Uweui6vgZHhoUU
0WzTNaWJLnu9cugNerz9pq/3tkLVoO5+1Szi9idHixCwDZ7tfk5LAahW524SBdom
IOxaDBDUyVYQocfDZQvx0nFGZX/hYQ==
=BGfi
-----END PGP SIGNATURE-----

--1dYXJKYNKc78bmBjvr9R5EEbDOhEqMJes--

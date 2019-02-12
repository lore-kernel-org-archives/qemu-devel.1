Received: from eggs.gnu.org ([209.51.188.92]:42166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gteIB-0006RS-Ag
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 15:04:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gteI8-0001Vv-R8
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 15:04:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57276)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gteI8-0001Lb-C8
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 15:04:28 -0500
References: <1550001205-7883-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1550001205-7883-2-git-send-email-aleksandar.markovic@rt-rk.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <14ccdc5c-3b80-c60d-86e0-ddd90050e9e6@redhat.com>
Date: Tue, 12 Feb 2019 14:04:21 -0600
MIME-Version: 1.0
In-Reply-To: <1550001205-7883-2-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="onQeNO5SdLhZRPgHhwasRxKLP68u8wzV9"
Subject: Re: [Qemu-devel] [PATCH 1/5] tests/tcg: target/mips: Remove an
 unnecessary file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
Cc: arikalo@wavecomp.com, alex.bennee@linaro.org, amarkovic@wavecomp.com, aurelien@aurel32.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--onQeNO5SdLhZRPgHhwasRxKLP68u8wzV9
From: Eric Blake <eblake@redhat.com>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
Cc: arikalo@wavecomp.com, alex.bennee@linaro.org, amarkovic@wavecomp.com,
 aurelien@aurel32.net
Message-ID: <14ccdc5c-3b80-c60d-86e0-ddd90050e9e6@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/5] tests/tcg: target/mips: Remove an
 unnecessary file
References: <1550001205-7883-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1550001205-7883-2-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1550001205-7883-2-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2/12/19 1:53 PM, Aleksandar Markovic wrote:
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>=20
> Remove a file that was added long time ago by mistake.

Might be worth mentioning commit d70080c4 (in 2012).

Is this the sort of file that is likely enough to be created during
typical workflows that it should be listed in the project's .gitignore
for everyone?  Or is it particular enough to your environment that you
could 'echo .directory >> .git/info/exclude' to ensure it doesn't happen
again for your setup, without bothering other developers with your
exclusion?

Either way, the cleanup itself makes sense.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--onQeNO5SdLhZRPgHhwasRxKLP68u8wzV9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxjJsUACgkQp6FrSiUn
Q2r08gf/RRkas5KWyOh3DKE64bca+lkk+SbLJ38Fc4Fym8ZpLiR7G8AArD373S4c
a8rvxKwXcWfnjbDuvCP6u5j0fwLNy0qMuYnFtdFytLrmmV6h1uzoq4FqS2LPIaQN
yXxvZXTmCg3ZoRz9SZ52DdZQXgvhuq1pgG2c9dFIAPYjUT4xeUNLEp4Qlsw3pFWC
x64spAdCJdZI9wFpJ8Q/mSvNjobkbibY/oJMW3HWKldNyww8hELNWGUUob44K91e
1PII2DLjvNZZBqre9YkDFRdvwxfh9zH5Kf4+hOTY5OUBQ0KCzXIlpZ/YG4aNqQbN
ZedFXi1gWoWmArctDZapjQ7dp6mpew==
=1S0B
-----END PGP SIGNATURE-----

--onQeNO5SdLhZRPgHhwasRxKLP68u8wzV9--

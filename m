Received: from eggs.gnu.org ([209.51.188.92]:50022)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1goadf-0002pC-6a
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 16:09:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1goade-0007a3-GU
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 16:09:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48248)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1goade-0007ZI-8B
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 16:09:46 -0500
References: <20190129113921.21599-1-berrange@redhat.com>
	<20190129113921.21599-3-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9fadf240-07c7-b569-f300-a4fc4d9044eb@redhat.com>
Date: Tue, 29 Jan 2019 15:09:44 -0600
MIME-Version: 1.0
In-Reply-To: <20190129113921.21599-3-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ptvInMV81hFCJqtLbmaEwh5bSjJt5rTrR"
Subject: Re: [Qemu-devel] [PATCH 2/5] make: don't insert a '/' after
 $(DESTDIR)
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
--ptvInMV81hFCJqtLbmaEwh5bSjJt5rTrR
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Adam Baxter <voltagex@voltagex.org>, Stefan Weil <sw@weilnetz.de>,
 Peter Maydell <peter.maydell@linaro.org>
Message-ID: <9fadf240-07c7-b569-f300-a4fc4d9044eb@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/5] make: don't insert a '/' after
 $(DESTDIR)
References: <20190129113921.21599-1-berrange@redhat.com>
 <20190129113921.21599-3-berrange@redhat.com>
In-Reply-To: <20190129113921.21599-3-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/29/19 5:39 AM, Daniel P. Berrang=C3=A9 wrote:
> This breaks when $(prefix) is a relative directory, as it turns it
> into an absolute path.
>=20
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  Makefile | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)

Yes, it is long-standing practice among Automake and others that
$(DESTDIR) is normally empty but should contain its own trailing slash
when defined, as it is NOT separated from the rest of the installation
lines with an explicit /.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--ptvInMV81hFCJqtLbmaEwh5bSjJt5rTrR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxQwRgACgkQp6FrSiUn
Q2pH4Qf/ef/GkzDXef8sS7ACzEeSdER/z9tBg2vWOqtSD15MF6m4kL8q5EqaDRRe
lnF9jHGwDei/kcN7NS58eZAP71vpVTqurPACXsX6f4YYbYBG0rVu/1q5ytJ8Hvfr
knqnEvLLWPL3Ayw0hkXngPFtDb8paLhFwGePHQ7PpDxX+M9moJTl8Du3Ib4OY2rk
wQCVGC7XM5DuDaoc6O/2EZOmq4FOG9rzt2nGSQb9dFW9wiqZyh10/C4S8U5qxR/e
5J2SzyoELBKyykuCufyArgXDZt19PLuitcuLE1JRJf1RbxFkYDwQWcIF8mcpwfCR
j7YgaFxs4FKBhxuXRYXAOPmBMKNhOQ==
=+tsT
-----END PGP SIGNATURE-----

--ptvInMV81hFCJqtLbmaEwh5bSjJt5rTrR--

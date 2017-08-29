Received: from eggs.gnu.org ([2001:4830:134:3::10]:40311)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dmjQJ-0007tp-Jt
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 12:31:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dmjQF-0008IY-17
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 12:31:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44918)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dmjQE-0008I2-OL
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 12:31:26 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AEAFFC056793
	for <qemu-devel@nongnu.org>; Tue, 29 Aug 2017 16:31:25 +0000 (UTC)
References: <20170829162727.13081-1-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a51f6738-f858-1ea2-ec08-eb68339eff90@redhat.com>
Date: Tue, 29 Aug 2017 11:31:24 -0500
MIME-Version: 1.0
In-Reply-To: <20170829162727.13081-1-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="8QuGReDRsQ1qbEHMvVNQRXxlgxixNhWrU"
Subject: Re: [Qemu-devel] [PATCH] crypto: fix test cert generation to not
 use SHA1 algorithm
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
--8QuGReDRsQ1qbEHMvVNQRXxlgxixNhWrU
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Message-ID: <a51f6738-f858-1ea2-ec08-eb68339eff90@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] crypto: fix test cert generation to not use
 SHA1 algorithm
References: <20170829162727.13081-1-berrange@redhat.com>
In-Reply-To: <20170829162727.13081-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/29/2017 11:27 AM, Daniel P. Berrange wrote:
> GNUTLS 3.6.0 marked SHA1 as untrusted for certificates.
> Unfortunately the gnutls_x509_crt_sign() method we are
> using to create certificates in the test suite is fixed
> to always use SHA1. We must switch to a different method
> and explicitly ask for SHA256.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  tests/crypto-tls-x509-helpers.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/tests/crypto-tls-x509-helpers.c b/tests/crypto-tls-x509-he=
lpers.c
> index 64073d3bd3..173d4e28fb 100644
> --- a/tests/crypto-tls-x509-helpers.c
> +++ b/tests/crypto-tls-x509-helpers.c
> @@ -406,7 +406,8 @@ test_tls_generate_cert(QCryptoTLSTestCertReq *req,
>       * If no 'ca' is set then we are self signing
>       * the cert. This is done for the root CA certs
>       */
> -    err =3D gnutls_x509_crt_sign(crt, ca ? ca : crt, privkey);
> +    err =3D gnutls_x509_crt_sign2(crt, ca ? ca : crt, privkey,
> +                                GNUTLS_DIG_SHA256, 0);

Is _sign2() available on all the older versions of gnutls that we must
support, or do we need this to be a conditional compilation?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--8QuGReDRsQ1qbEHMvVNQRXxlgxixNhWrU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmlltwACgkQp6FrSiUn
Q2pauwf+PwMPEt/E71qCbwJ3tbu6AFJzU8aqHfwkyO+Hgo5R6R1eMWJQM2j9yImE
v4dXZtZHAWb5+IFyQzOxmj3gdEoVR45XXyMp89xeXjlbm/4vk7zxdl46ItRDPCyC
9ZnVjHKdMpd+aFtMRgreCLbsJjJ9H3McVy8J3B5tjVklpHGwkIp8i2jCosFyVxb/
62sjAg43tG5I3WbjVQGi6DRmtILfQg0EH6HrV5D4IznrV9uGSnvYcjoF5sO/8SIw
gHfI8PGHkFyuvxaEeo5PfbhDuPycYiTCSl/47RXoCUC4pb4GUI6Lwxb7dAQdrZkD
ITwdQJeYjntF/UXARSpEFKMjOcjkOQ==
=XNHR
-----END PGP SIGNATURE-----

--8QuGReDRsQ1qbEHMvVNQRXxlgxixNhWrU--

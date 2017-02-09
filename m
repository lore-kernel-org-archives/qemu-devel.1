Received: from eggs.gnu.org ([2001:4830:134:3::10]:36037)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cbcxH-0008GO-Ak
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 19:51:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cbcxG-00060c-NT
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 19:51:23 -0500
References: <20170126101827.22378-1-berrange@redhat.com>
	<20170126101827.22378-19-berrange@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <c509caaf-9045-3009-833a-bf0c56df7216@redhat.com>
Date: Thu, 9 Feb 2017 01:51:13 +0100
MIME-Version: 1.0
In-Reply-To: <20170126101827.22378-19-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Kb4Lj9CeBGj4T9KSVqx5PI54Tt9Br4282"
Subject: Re: [Qemu-devel] [PATCH v3 18/18] block: pass option prefix down to
 crypto layer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Kb4Lj9CeBGj4T9KSVqx5PI54Tt9Br4282
From: Max Reitz <mreitz@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <c509caaf-9045-3009-833a-bf0c56df7216@redhat.com>
Subject: Re: [PATCH v3 18/18] block: pass option prefix down to crypto layer
References: <20170126101827.22378-1-berrange@redhat.com>
 <20170126101827.22378-19-berrange@redhat.com>
In-Reply-To: <20170126101827.22378-19-berrange@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 26.01.2017 11:18, Daniel P. Berrange wrote:
> While the crypto layer uses a fixed option name "key-secret",
> the upper block layer may have a prefix on the options. e.g.
> "luks-key-secret", "aes-key-secret", in order to avoid clashes
> between crypto option names & other block option names. To
> ensure the crypto layer can report accurate error messages,
> we must tell it what option name prefix was used.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  block/crypto.c         |  4 ++--
>  block/qcow.c           |  7 ++++---
>  block/qcow2.c          | 15 +++++++++------
>  crypto/block-luks.c    |  8 ++++++--
>  crypto/block-qcow.c    |  8 ++++++--
>  crypto/block.c         |  6 ++++--
>  crypto/blockpriv.h     |  2 ++
>  include/crypto/block.h |  6 +++++-
>  8 files changed, 38 insertions(+), 18 deletions(-)

Thanks a lot!

Alas I'm afraid tests/test-crypto-block.c will need a couple of changes,
too (trivial ones, though, just a couple of NULL parameters).

Max


--Kb4Lj9CeBGj4T9KSVqx5PI54Tt9Br4282
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlibvQESHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A72EH/RsVBnjySAHhUzLpWAUYpR0ulPKNCoEd
BfKOEQl4NGwx1eXMN0N9zJbXY1HCoJCsJ8tGdAPhARtpcYjsJ0tb83B6da5fqM5y
lx/opRe7s2qLFLj1iPglNlgGsaPxz9yyA80CPctdGIet0xprCIBywKN3BdDZ6rcw
0KMVjkPxjY1ARWTNXTasa7nw7CevTfz8qvTv1//iSgY16TkhAw9N5Yv3V4Z0D+3K
8qHZu/MM7GWa7eZetmiBVlMiSX6EfuvmY8UnwKl0yzoC5ntfk0y9oPAc/EuYN04w
NaccZNLzKnsdW0RyHRM/aU3nZTDLaXlQidtxMsVHuI2Px1+4xGEeWQY=
=7BkD
-----END PGP SIGNATURE-----

--Kb4Lj9CeBGj4T9KSVqx5PI54Tt9Br4282--

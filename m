Received: from eggs.gnu.org ([2001:4830:134:3::10]:52669)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eAggX-00085M-4h
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 14:27:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eAggT-0007wQ-VH
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 14:27:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52986)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eAggT-0007w7-MK
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 14:27:13 -0400
References: <20171103153333.6416-1-berrange@redhat.com>
	<20171103153333.6416-2-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <af7e8423-bde8-b2f8-1c7d-fe32fdfb7e8e@redhat.com>
Date: Fri, 3 Nov 2017 13:27:10 -0500
MIME-Version: 1.0
In-Reply-To: <20171103153333.6416-2-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="nqx9UXhN1tH6m5Mrhm6HIeqF7RauURQ7e"
Subject: Re: [Qemu-devel] [PATCH v3 1/5] build: allow setting a custom GIT
 binary for transparent proxying
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nqx9UXhN1tH6m5Mrhm6HIeqF7RauURQ7e
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <af7e8423-bde8-b2f8-1c7d-fe32fdfb7e8e@redhat.com>
Subject: Re: [PATCH v3 1/5] build: allow setting a custom GIT binary for
 transparent proxying
References: <20171103153333.6416-1-berrange@redhat.com>
 <20171103153333.6416-2-berrange@redhat.com>
In-Reply-To: <20171103153333.6416-2-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/03/2017 10:33 AM, Daniel P. Berrange wrote:
> Some users can't run a bare 'git' command, due to need for a transparen=
t
> proxying solution such as 'tsocks'. This adds an argument to configure =
to
> let users specify such a thing:
>=20
>   ./configure --with-git=3D"tsocks git"
>=20
> The submodule script is also updated to give the user a hint about usin=
g this
> flag, if we fail to checkout modules.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  Makefile                 |  4 ++--
>  configure                |  5 +++++
>  scripts/git-submodule.sh | 29 ++++++++++++++++++++++++-----
>  3 files changed, 31 insertions(+), 7 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--nqx9UXhN1tH6m5Mrhm6HIeqF7RauURQ7e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAln8tP8ACgkQp6FrSiUn
Q2oKSgf9HakbRk1wvzkMvYCTY0XvXRsgSlfcdbFrA+j2e29/ro11YMV22eGEuwq3
UnaSC/8mvagcMzprpD7lNKu2bm2PpIrVBf6d8Yu95dhGcIC0uJsB0eaM4mT0XWC1
OpUA0l7aEYQQF944UFNSZM90xpOS2xXWPbKll38RiEFIB913s69tyeVVXRm3dxHj
VQgZp8PBoBdxlq6ZkCCgimigDnuzC2NBuHJaacra+n6w37JRRTgnlYcbZDcuatUC
Jv5J4YTg62JC4cnvgEpet9W/sVJnmsykmkfxtnoGOcSXhE5q2jaWZWAk9Zh2tnm8
IL2uVEc9Y0zQdMeWawjlMUb52eKTTg==
=/DZi
-----END PGP SIGNATURE-----

--nqx9UXhN1tH6m5Mrhm6HIeqF7RauURQ7e--

Received: from eggs.gnu.org ([209.51.188.92]:35389)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gobgs-0008Ua-B8
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 17:17:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gobgr-0001K5-CA
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 17:17:10 -0500
References: <20190129175403.18017-1-philmd@redhat.com>
	<20190129175403.18017-8-philmd@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <32615f52-8cc8-f85b-d815-e4aefb1687d4@redhat.com>
Date: Tue, 29 Jan 2019 16:16:51 -0600
MIME-Version: 1.0
In-Reply-To: <20190129175403.18017-8-philmd@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="MeyExsPQv4GoA6HZKwYlJDqY91SlPUyfX"
Subject: Re: [Qemu-devel] [PATCH v2 07/18] tests/multiboot: Improve
 portability by searching bash in the $PATH
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Brad Smith <brad@comstyle.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Fam Zheng <fam@euphon.net>, "Michael S. Tsirkin" <mst@redhat.com>, Kamil Rytarowski <kamil@netbsd.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MeyExsPQv4GoA6HZKwYlJDqY91SlPUyfX
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Brad Smith <brad@comstyle.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Fam Zheng <fam@euphon.net>,
 "Michael S. Tsirkin" <mst@redhat.com>, Kamil Rytarowski <kamil@netbsd.org>
Message-ID: <32615f52-8cc8-f85b-d815-e4aefb1687d4@redhat.com>
Subject: Re: [PATCH v2 07/18] tests/multiboot: Improve portability by
 searching bash in the $PATH
References: <20190129175403.18017-1-philmd@redhat.com>
 <20190129175403.18017-8-philmd@redhat.com>
In-Reply-To: <20190129175403.18017-8-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/29/19 11:53 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> Bash is not always installed as /bin/bash. In particular on OpenBSD,
> the package installs it in /usr/local/bin.
> Use the 'env' shebang to search bash in the $PATH.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  tests/multiboot/run_test.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/tests/multiboot/run_test.sh b/tests/multiboot/run_test.sh
> index 6c33003e71..a88e423992 100755
> --- a/tests/multiboot/run_test.sh
> +++ b/tests/multiboot/run_test.sh
> @@ -1,4 +1,4 @@
> -#!/bin/bash
> +#! /usr/bin/env bash

Again, why the space after #!? Having or omitting it makes no
difference, but the prevailing style is to omit it.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--MeyExsPQv4GoA6HZKwYlJDqY91SlPUyfX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxQ0NMACgkQp6FrSiUn
Q2rSgAf9EzeeDq5je1jxCEQAoYNbPRNDWMDg2yQvsGuNAwSXioYbPNhwLXa7utt6
SirlRB2i5olJTitHs8p8ztVs+i3Vnrw6xG6SKtkcQBaEGeaCnyC3JveLkQoHW089
cOi7Hv/N1XKUQTyCTyEPRWzmPvg65ExRyROCRJAlMBVjHqEXiVHROJrR+eSdNNeb
2+oDzLbUle/9zhz7Qe8ctHqCX4wZ6OqEgCDTxfhMJPXEnp7U6twJ4/iHAK6jH2AJ
ZnxhnD3e0SZsippQU0XKbFYbqzmBivQ1dN+pKko9onceHezdIxoFs/1T2bPxvSIY
vaTTPZFnnj54Ek18raLoGbZy1Mve7Q==
=sCZO
-----END PGP SIGNATURE-----

--MeyExsPQv4GoA6HZKwYlJDqY91SlPUyfX--

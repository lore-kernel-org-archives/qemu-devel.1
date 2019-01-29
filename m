Received: from eggs.gnu.org ([209.51.188.92]:38551)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1goXpp-00055b-SN
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 13:10:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1goXpp-0006wM-2O
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 13:10:09 -0500
References: <20190129175403.18017-1-philmd@redhat.com>
	<20190129175403.18017-8-philmd@redhat.com>
From: Kamil Rytarowski <n54@gmx.com>
Message-ID: <90782f04-779c-8eec-99bb-4293ab62a75c@gmx.com>
Date: Tue, 29 Jan 2019 19:10:26 +0100
MIME-Version: 1.0
In-Reply-To: <20190129175403.18017-8-philmd@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="KjiZQtQDy5QBnGiPCsrW8rqk6aGeYLKxZ"
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
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Fam Zheng <fam@euphon.net>, "Michael S. Tsirkin" <mst@redhat.com>, Kamil Rytarowski <kamil@netbsd.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KjiZQtQDy5QBnGiPCsrW8rqk6aGeYLKxZ
From: Kamil Rytarowski <n54@gmx.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Brad Smith <brad@comstyle.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eric Blake <eblake@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Fam Zheng <fam@euphon.net>,
 "Michael S. Tsirkin" <mst@redhat.com>, Kamil Rytarowski <kamil@netbsd.org>
Message-ID: <90782f04-779c-8eec-99bb-4293ab62a75c@gmx.com>
Subject: Re: [PATCH v2 07/18] tests/multiboot: Improve portability by
 searching bash in the $PATH
References: <20190129175403.18017-1-philmd@redhat.com>
 <20190129175403.18017-8-philmd@redhat.com>
In-Reply-To: <20190129175403.18017-8-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 29.01.2019 18:53, Philippe Mathieu-Daud=C3=A9 wrote:
> Bash is not always installed as /bin/bash. In particular on OpenBSD,
> the package installs it in /usr/local/bin.
> Use the 'env' shebang to search bash in the $PATH.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Kamil Rytarowski <n54@gmx.com>

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
> =20
>  # Copyright (c) 2013 Kevin Wolf <kwolf@redhat.com>
>  #
>=20



--KjiZQtQDy5QBnGiPCsrW8rqk6aGeYLKxZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJABAEBCAAqFiEELaxVpweEzw+lMDwuS7MI6bAudmwFAlxQlx8MHG41NEBnbXgu
Y29tAAoJEEuzCOmwLnZsDMwP/1bEIDaT/BAvFwRqo6QyreczS7KdaBa3AxiN3mLs
+L3HmkGEWGYNVtRSDOH0PgTSXnRAvsInoLrE4WcEWTGto+NetQ6FqZSmzj8Cu8Hi
OKkATrzz0vckQLcAOSwQIbrIz0eTys5Tfj3bATCHw/oqqv0apKDhZYs+FYDTpCQ/
d+k1JbLsXC+fXc0w+lRF8O4mRs2bEcxjTsjEH/z2ogIqFCLXXvGjZFMHH5IbM3kp
IKym89kOnmU3LjwhsCge/zcpL9V9LsUqDmV4BchQf9DcMXsm7GAW2RyleCjw6jeJ
4i9iR9WVRYAYItAYRTXySz8WrSCbLLaQzho09PFtNQfALaUJjy6jsWDBufGcW+CN
kTqbxSDB+VjibY+IyhA9CxiO3dtanh5Hdhnhd9aFkFfjD7ldRsW56yylSciFqlSy
PlPsGc/byYei60qKodryf6nNlorfFaqDVCBsX3sD7XoKy7kGOQREtcPB3pXG+3NV
ktT9/CtzKb982q3sBpSqjMuqMmUc7jPV4qAXV1WMIbvmkKoJnpYnguaQ1D0qfBo+
GpkQDJei1Nk6/R15und2tcsMvw9qURa66pTrariuq0xZ27aDh3xv//zTrFoI48/x
FAqr6sV5MWR8D94ddDHj/Aegs90tjW30WR9tdnOVMDtpszZAsQCzIM53jiCDIQYk
iFcp
=DkER
-----END PGP SIGNATURE-----

--KjiZQtQDy5QBnGiPCsrW8rqk6aGeYLKxZ--

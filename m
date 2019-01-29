Received: from eggs.gnu.org ([209.51.188.92]:38861)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1goXr4-00068v-OH
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 13:11:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1goXr3-0007Lm-Tp
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 13:11:26 -0500
References: <20190129175403.18017-1-philmd@redhat.com>
	<20190129175403.18017-9-philmd@redhat.com>
From: Kamil Rytarowski <n54@gmx.com>
Message-ID: <76b77d49-9f17-71ee-d29d-c1da47c795e4@gmx.com>
Date: Tue, 29 Jan 2019 19:12:10 +0100
MIME-Version: 1.0
In-Reply-To: <20190129175403.18017-9-philmd@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="4Ez6Uan6DeZ871BWYU2Q9UWin1CgT2oua"
Subject: Re: [Qemu-devel] [PATCH v2 08/18] tests/bios-tables: Improve
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
--4Ez6Uan6DeZ871BWYU2Q9UWin1CgT2oua
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
Message-ID: <76b77d49-9f17-71ee-d29d-c1da47c795e4@gmx.com>
Subject: Re: [PATCH v2 08/18] tests/bios-tables: Improve portability by
 searching bash in the $PATH
References: <20190129175403.18017-1-philmd@redhat.com>
 <20190129175403.18017-9-philmd@redhat.com>
In-Reply-To: <20190129175403.18017-9-philmd@redhat.com>
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
>  tests/data/acpi/rebuild-expected-aml.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/tests/data/acpi/rebuild-expected-aml.sh b/tests/data/acpi/=
rebuild-expected-aml.sh
> index bf9ba242ad..ff77a751c8 100755
> --- a/tests/data/acpi/rebuild-expected-aml.sh
> +++ b/tests/data/acpi/rebuild-expected-aml.sh
> @@ -1,4 +1,4 @@
> -#! /bin/bash
> +#! /usr/bin/env bash
> =20
>  #
>  # Rebuild expected AML files for acpi unit-test
>=20



--4Ez6Uan6DeZ871BWYU2Q9UWin1CgT2oua
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJABAEBCAAqFiEELaxVpweEzw+lMDwuS7MI6bAudmwFAlxQl3oMHG41NEBnbXgu
Y29tAAoJEEuzCOmwLnZsb1MP/0UZt4nmRkOl29uQA3rZGRk9zf11StvZHrjZihZw
QI9YbiqB/CWhLsq0MeTZY73mFPCbF89nVvOQqsz8F4EfdyoMQrSkh160etnmWt70
WyqzzwNf45+fqdhkQs+pk1TWWgM3r299BWguBuQ02jhnIRAXqT81SmgQnt+Qugzv
BGJonCyby7gGYeeZ42JXERbTzZqNJteUQGMIP7RQ6Z+LADZvyvpycJ+tuRc1vm+Z
Db7ysEnodc6mAJJeciofvod0YBDfGxf48ksstM+7krcGMVViimcFyUfo7OdGqPha
/RUuxA96RpCEHsRdOFZDxOPdd5nqT62dCgT8lFjK6oWQsRfhi9/f9G92fhfZOYSd
saLE+i6FC7m6DryRuspVBCMSW5hVXCbtVRolqVQ9FpU/HrjWHPoTYEmWPOj7Eotq
QySlQgb/EWE4GmyItyeH9V1cENj6SEKuQFlPGYDoFwIAgGyRza64DYN49extmu10
hE9V4gbNeYFOAVepWzggcaJePE+RNK+iM8jUVahPh7oS7/2/mfXf/d0L5NM8hVtr
9ZUmBkxsbFws6ZY4vE8VYu+Ztt/HphpQ7W//A04IsxsvnfJbYLOyJwfao7blDs+L
/2MMIhk450iIC9e5j6JEJxqzy9dBrrr717M8IU/JE7g1Pvqrs5Qy6if2zx4e7+MZ
ezC/
=OpMZ
-----END PGP SIGNATURE-----

--4Ez6Uan6DeZ871BWYU2Q9UWin1CgT2oua--

Received: from eggs.gnu.org ([209.51.188.92]:59620)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gobLJ-0002Az-NC
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 16:54:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gobLI-0007gv-UW
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 16:54:53 -0500
References: <20190129175403.18017-1-philmd@redhat.com>
	<20190129175403.18017-3-philmd@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <cdfb4f7e-0182-386a-6508-a13a56e6de16@redhat.com>
Date: Tue, 29 Jan 2019 15:54:45 -0600
MIME-Version: 1.0
In-Reply-To: <20190129175403.18017-3-philmd@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="h8ugNXWYOTTRRYEartFVXgxnHZQ3JLXaa"
Subject: Re: [Qemu-devel] [PATCH v2 02/18] configure: Disable W^X on OpenBSD
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
--h8ugNXWYOTTRRYEartFVXgxnHZQ3JLXaa
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
Message-ID: <cdfb4f7e-0182-386a-6508-a13a56e6de16@redhat.com>
Subject: Re: [PATCH v2 02/18] configure: Disable W^X on OpenBSD
References: <20190129175403.18017-1-philmd@redhat.com>
 <20190129175403.18017-3-philmd@redhat.com>
In-Reply-To: <20190129175403.18017-3-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/29/19 11:53 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> Since OpenBSD 6.0 [1], W^X is enforced by default [2].
> TCG requires WX access. Disable W^X if it is available.
> This fixes:
>=20

>  configure | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>=20
> diff --git a/configure b/configure
> index b18281c61f..799ec2013b 100755
> --- a/configure
> +++ b/configure
> @@ -5795,6 +5795,17 @@ if test "$mingw32" =3D "yes" ; then
>      done
>  fi
> =20
> +# Disable OpenBSD W^X if available
> +if test "$tcg" =3D "yes" -a "$targetos" =3D "OpenBSD"; then

test ... -a ...

is not portable (POSIX permits non-XSI systems to omit support for these
operators, but even where they are supported, there are some inherently
ambiguous inputs where you CANNOT predict whether the shell will parse
-a as a binary operator or as an argument to some other operator).
Instead, you should ALWAYS break dual tests into:

test ... && test ...

instead.  (Same for '-o' vs '|| test')

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--h8ugNXWYOTTRRYEartFVXgxnHZQ3JLXaa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxQy6UACgkQp6FrSiUn
Q2rBTwgArYOJXpk35R39+v/vZ+Lm7gmQKG5T0gcQvsAef2Gp5Cm6D+QEjeH4bM91
G61/xXdASWiZzA+cYPxROcxDtJw4gvTB0tafWDDqngSPHBrS/stMFsey5nQ9hiaA
WAH8wO6Fb14Al4VoNlQdHMaE1aPpwcjj0ZE3vimEtiD5yMk4jtfsbm/pt0XpZvJ+
yiqTeqa6DJRLgohHcOG+gVFMUfd3EUZUW6Hqlhk2xD5IjllFY/XuoHEVbEd1a/5H
Kz48J4IU7F5ia5HPxgBIdShLPlbqufMExThNbix8fwy2RZRJcIknJF718SFORoMn
h5JBq/aM32YY9ENp2/O7r3AvusGijA==
=cooO
-----END PGP SIGNATURE-----

--h8ugNXWYOTTRRYEartFVXgxnHZQ3JLXaa--

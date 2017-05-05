Received: from eggs.gnu.org ([2001:4830:134:3::10]:40216)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1d6btI-0007Mp-BT
	for qemu-devel@nongnu.org; Fri, 05 May 2017 07:59:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1d6btF-0006B3-As
	for qemu-devel@nongnu.org; Fri, 05 May 2017 07:59:20 -0400
Received: from mout.gmx.net ([212.227.15.19]:55738)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <n54@gmx.com>) id 1d6btE-000698-Vj
	for qemu-devel@nongnu.org; Fri, 05 May 2017 07:59:17 -0400
References: <20170426105027.10666-1-n54@gmx.com>
From: Kamil Rytarowski <n54@gmx.com>
Message-ID: <bb7b340d-a4a4-fc63-a704-5b32cb482695@gmx.com>
Date: Fri, 5 May 2017 13:51:12 +0200
MIME-Version: 1.0
In-Reply-To: <20170426105027.10666-1-n54@gmx.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="hWC51Aua1bFJmuAVl0SgnT1wpXAD4wft2"
Subject: Re: [Qemu-devel] [PATCH] configure: Detect native NetBSD curses(3)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hWC51Aua1bFJmuAVl0SgnT1wpXAD4wft2
From: Kamil Rytarowski <n54@gmx.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Message-ID: <bb7b340d-a4a4-fc63-a704-5b32cb482695@gmx.com>
Subject: Re: [PATCH] configure: Detect native NetBSD curses(3)
References: <20170426105027.10666-1-n54@gmx.com>
In-Reply-To: <20170426105027.10666-1-n54@gmx.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

x1 ping

On 26.04.2017 12:50, Kamil Rytarowski wrote:
> NetBSD ships with traditional BSD curses with compatibility with ncurse=
s.
> qemu works nicely with the basesystem version of curses(3) from NetBSD.=

>=20
> The only mismatch between curses(3) and ncurses is the lack of
> curses_version() in the NetBSD version. This function is used solely in=

> the configure script, therefore eliminate it from the curses(3) detecti=
on.
>=20
> With this change applied, configure detects correctly curses frontend.
>=20
> Signed-off-by: Kamil Rytarowski <n54@gmx.com>
> ---
>  configure | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/configure b/configure
> index c35acf1192..17dc7224f7 100755
> --- a/configure
> +++ b/configure
> @@ -3034,14 +3034,13 @@ if test "$curses" !=3D "no" ; then
>  #include <curses.h>
>  #include <wchar.h>
>  int main(void) {
> -  const char *s =3D curses_version();
>    wchar_t wch =3D L'w';
>    setlocale(LC_ALL, "");
>    resize_term(0, 0);
>    addwstr(L"wide chars\n");
>    addnwstr(&wch, 1);
>    add_wch(WACS_DEGREE);
> -  return s !=3D 0;
> +  return 0;
>  }
>  EOF
>    IFS=3D:
>=20



--hWC51Aua1bFJmuAVl0SgnT1wpXAD4wft2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZDGc5AAoJEEuzCOmwLnZswTsP/RGaxdzJdMUd0HorQh4NGAHR
RTJCTVlefMI/v9tJOSGog/goKrxH5k4vj/W8i23hJLGpHoNNmZ9Z1KeNGFoyCEB8
GZH5G68z9QxJxQGKs05qerDFaElGLfjzcSRvU6wmE3f4kL0OfcAHOwSkBxVzwWt5
7vIRIJMF6TT28hpewNdPHYKZwr/NiTxiJzoWbd9OzaLFrZkmWRmmyskRlrJMbfVX
hDAowAjDMtKj8rv0/gu+bV8C3btsyvKXkQKqylfC4+RrN5RhCp7S0mNuiX9Ux+B5
A2m2h3Z9VgXrEOjzPsF73C3ssyPHG91MkV41yLigZ4fI7OZUZNtCuj2t6JA7zltt
x+10XVx/dQlsfqPtMk6pkZjZf/tHtezjHiinTcM3mjOYWJBF6yzQhrJStuqg1PPH
8mR3gDt4/w0riNjlod1VL/BClVeRNms/2wkeXvOYJPIaRgOTMBd+II4sq60WEIoQ
Iv2hAiTIRAz6+GtjFq7hKJ7WGqkZxnzfDgIKbH6/YqWXEq08HZXWhEhqb7RZIM6U
8vCQiH1BUuD/TrTQwvJ+dB6BBpULqUHPY45gz3mTikE6nNqbC6W6qoIuRa1IbQik
C8hRcM0BZ4IBQpjC8gYqoEOqF7R8FYuzNIXcvRzlN/t3d+GS6U4TQyGdCGUR4p56
vefMqIlPwu+yq1aoiRdm
=CTN0
-----END PGP SIGNATURE-----

--hWC51Aua1bFJmuAVl0SgnT1wpXAD4wft2--

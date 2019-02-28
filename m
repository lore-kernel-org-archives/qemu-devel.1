Received: from eggs.gnu.org ([209.51.188.92]:56040)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gzDoa-0000dL-F1
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 00:01:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gzDoY-0005iC-Tv
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 00:01:00 -0500
Received: from ozlabs.org ([2401:3900:2:1::2]:38445)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1gzDoT-000576-Sl
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 00:00:55 -0500
Date: Thu, 28 Feb 2019 16:00:07 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190228050007.GF27799@umbus.fritz.box>
References: <20190228043503.68494-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="JcvBIhDvR6w3jUPA"
Content-Disposition: inline
In-Reply-To: <20190228043503.68494-1-aik@ozlabs.ru>
Subject: Re: [Qemu-devel] [PATCH qemu] configure: Enable werror for git
 worktrees
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com, berrange@redhat.com, pbonzini@redhat.com, philmd@redhat.com, thuth@redhat.com


--JcvBIhDvR6w3jUPA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 28, 2019 at 03:35:03PM +1100, Alexey Kardashevskiy wrote:
> The configure script checks multiple times whether it works in a git
> repository and it does this by "test -e "${source_path}/.git" in 4 cases
> but in one case where it tries to enable werror "-d" is used there which
> fails on git worktrees as .git is a file then and not a directory.
>=20
> This changes the test to "-e" as other occurrences.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

CCing a few likely candidates based on get_maintainer -f

> ---
>  configure | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/configure b/configure
> index 05d72f1..f481ff9 100755
> --- a/configure
> +++ b/configure
> @@ -1835,7 +1835,7 @@ fi
>  # Consult white-list to determine whether to enable werror
>  # by default.  Only enable by default for git builds
>  if test -z "$werror" ; then
> -    if test -d "$source_path/.git" && \
> +    if test -e "$source_path/.git" && \
>          { test "$linux" =3D "yes" || test "$mingw32" =3D "yes"; }; then
>          werror=3D"yes"
>      else

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--JcvBIhDvR6w3jUPA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlx3atUACgkQbDjKyiDZ
s5Ie6BAAlz9y731y0tnhWM/0yukxkw7jDp5Zf+9uhTko2LJE13tTGz9rslxlZRhZ
LMRsrhP51Ti2G7QUNzJ/xt9N8W+4G0rdKrtRv2HUzS2GN3h28DLLKi9S3JgPoy72
/4CU9v/WcKHvkQR8NSvjbh/AVFUlTCu2pJKiXvUHtd0vu6abOJ7zlnw4CX1qVBQN
LFqPN7FtH6kNv0OiX4LaFLxYNrfdGBExMkg0FvW6V49PCGNmhChtPCLoeXmDs2nq
aOkDOKo+GtrC7y+KaBeBHa5OAH6HSE0MpLye9sjSd3vrNEeKPle9rDa4G93c/G78
22wEEi7Frjl/laa7+JphT8XiV0DqvXd4Xxnw01B9Zl1mxy3R182kyXhLj3o61xtT
Ot6IN1t+AYkqJiqFYh8u2h7GqGk79jRsIBd+1/WN5hb0VwhYeh208hfp2VcKagSt
nzf+JLviG+F0CZxbOHQkqCSFZX8J+Qc9BZXEkdDQ3/sD/TLJTbIccBnLNRctXzAc
oCXvCOwAMjDJAHX4Jm/2f0ZtEkIG6l82tdIC9aP5M9U5GXmMoAHqibC1905wT7Ya
ztCVI4RPH3buTkufPACzKLzk0qDHH/9N152wfsg0HuAD1hTfpl4RGMky9UHTinuL
+YHZrhNF/BmNowQksdhA7Zq1LRKW19heJz7oH8WAOLMU4STJaPU=
=swiU
-----END PGP SIGNATURE-----

--JcvBIhDvR6w3jUPA--

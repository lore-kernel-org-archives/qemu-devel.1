Received: from eggs.gnu.org ([2001:4830:134:3::10]:35788)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dYBxp-0008N6-K2
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 09:58:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dYBxl-0004w8-Hh
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 09:58:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60062)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dYBxl-0004vm-7R
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 09:57:57 -0400
References: <20170720134716.13049-1-alex.bennee@linaro.org>
	<20170720134716.13049-4-alex.bennee@linaro.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9e317ac9-b417-7df2-8b56-a79442b34554@redhat.com>
Date: Thu, 20 Jul 2017 08:57:51 -0500
MIME-Version: 1.0
In-Reply-To: <20170720134716.13049-4-alex.bennee@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="mnJO7E7VrdSlC1TW5IUIM15w2qdmXIsg5"
Subject: Re: [Qemu-devel] [RFC PATCH for 2.10 3/3] docker: ignore submodules
 when checking diff
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, peter.maydell@linaro.org
Cc: famz@redhat.com, qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mnJO7E7VrdSlC1TW5IUIM15w2qdmXIsg5
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 peter.maydell@linaro.org
Cc: famz@redhat.com, qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <9e317ac9-b417-7df2-8b56-a79442b34554@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH for 2.10 3/3] docker: ignore submodules
 when checking diff
References: <20170720134716.13049-1-alex.bennee@linaro.org>
 <20170720134716.13049-4-alex.bennee@linaro.org>
In-Reply-To: <20170720134716.13049-4-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/20/2017 08:47 AM, Alex Benn=C3=A9e wrote:
> The QEMU tree often has dirty submodules in it but this will confuse
> things as git stash is not going to save their state directly. They
> are likely just dirty from build files anyway. Ignore them in the
> diff-index command.

It's annoying that our build dirties a submodule in the first place; it
would be nice to get rid of those bugs in our build process (ideally,
the build should treat submodule directories as read-only).  But that is
a bigger effort, so I'm okay with your hack in the meantime.

>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  tests/docker/Makefile.include | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

>=20
> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.incl=
ude
> index ff580edfad..2a560a5327 100644
> --- a/tests/docker/Makefile.include
> +++ b/tests/docker/Makefile.include
> @@ -20,7 +20,7 @@ IMAGES ?=3D %
>  # Make archive from git repo $1 to tar.gz $2
>  make-archive-maybe =3D $(if $(wildcard $1/*), \
>  	$(call quiet-command, \
> -		(cd $1; if git diff-index --quiet HEAD -- 2>/dev/null; then \
> +		(cd $1; if git diff-index --quiet --ignore-submodules HEAD -- 2>/dev=
/null; then \
>  			git archive -1 HEAD --format=3Dtar.gz; \
>  		else \
>  			git archive -1 $$(git stash create) --format=3Dtar.gz; \
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--mnJO7E7VrdSlC1TW5IUIM15w2qdmXIsg5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAllwtt8ACgkQp6FrSiUn
Q2qlWggApAvPSkP1rbOl9V/h3RwoDeBUjhrrnMElzqFAa9MyN0cpkwZFbVS/YFNg
oJEKzsLHk9526X9/GFc+Napw7d4E9gi9rYh0ObaTF825WzRfR3SDReu3Px0Q7bZq
P6qOAZvAHhvlUWdEDBwJ2KdW9nULPWs+OgHPze0giwSh6wqNnnOKOtHeBT9EssIK
BJx90oEoC9GaDq8X+X8Qxqse6Yzghk2f2rH2Vj4/ZaIOW+T2l4tCSZHVbcqn3Y/V
Oy2W4qXE3wCVFqiLRb9ZsgAy+EmkpgAYipm9mxdO57AYP6d/a6i65ApBg5dNPs9O
JWHlj5A2iH1eedzwfPqR31Ml3D1NRg==
=NLZP
-----END PGP SIGNATURE-----

--mnJO7E7VrdSlC1TW5IUIM15w2qdmXIsg5--

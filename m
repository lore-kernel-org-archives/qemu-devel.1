Received: from eggs.gnu.org ([2001:4830:134:3::10]:38769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ePuj1-0007fB-Na
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 13:28:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ePuj0-00087c-NA
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 13:28:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43600)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ePuj0-00086n-Dk
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 13:28:46 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 068631555A
	for <qemu-devel@nongnu.org>; Fri, 15 Dec 2017 18:28:45 +0000 (UTC)
References: <20171215150659.1811-1-marcandre.lureau@redhat.com>
	<20171215150659.1811-4-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0a657570-b763-558d-69cb-357e2cdf6c3f@redhat.com>
Date: Fri, 15 Dec 2017 12:28:41 -0600
MIME-Version: 1.0
In-Reply-To: <20171215150659.1811-4-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="lnWJsW6oOt1DjHTCSGsag1xiaQwRRjiMN"
Subject: Re: [Qemu-devel] [PATCH v2 03/13] build-sys: add a rule to print a
 variable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lnWJsW6oOt1DjHTCSGsag1xiaQwRRjiMN
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Message-ID: <0a657570-b763-558d-69cb-357e2cdf6c3f@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 03/13] build-sys: add a rule to print a
 variable
References: <20171215150659.1811-1-marcandre.lureau@redhat.com>
 <20171215150659.1811-4-marcandre.lureau@redhat.com>
In-Reply-To: <20171215150659.1811-4-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/15/2017 09:06 AM, Marc-Andr=C3=A9 Lureau wrote:
> $ make print-CFLAGS
> CFLAGS=3D-fsanitize=3Daddress -Og -g
>=20
> Trick from various sources:
> https://stackoverflow.com/questions/16467718/how-to-print-out-a-variabl=
e-in-makefile
> https://www.cmcrossroads.com/article/printing-value-makefile-variable
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
>  Makefile                    |  5 ++++-
>  docs/devel/build-system.txt | 13 +++++++++++++
>  2 files changed, 17 insertions(+), 1 deletion(-)

> +++ b/docs/devel/build-system.txt
> @@ -510,3 +510,16 @@ default-configs/$TARGET-NAME file as input.
>  This is the entrypoint used when make recurses to build a single syste=
m
>  or userspace emulator target. It is merely a symlink back to the
>  Makefile.target in the top level.
> +
> +
> +Useful make targets
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +- help
> +
> +  Print a help message for the most common build targets.

Except that this patch forgot to tweak 'make help' to mention 'make
print-VAR' ;)

> +
> +- print-VAR
> +
> +  Print the value of the variable VAR. Useful for debugging the build
> +  system.
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--lnWJsW6oOt1DjHTCSGsag1xiaQwRRjiMN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlo0FFkACgkQp6FrSiUn
Q2qpKQf9ERtMg7CT+bW3Jb/G9Uqk84SMjYYv3lKXHaXqDMaeXJX5Wti38Ci1XNOx
eHOE6sYBJkx7svqbgV+YB5ZZ0yW8KFjlc7mPelIgph4oZu15v0QwYfsFhoNaHzZN
h9NalgATnwkbLf/3VJuovlTqlC4K5IVjLlRI1xuarstZ8pK2ik6l9nYscLiOccmo
jk8z4sybtm7A9Z5r3eePKFMV4i8G1ngOMx0ThZ7rwkX7Srg8UHNmSC8hXtAJr07f
zmnoI8yzJGgUrs81mcytXq1WP+/t3l00ovIWlnd6majgdeybgCwxExeGDbWkGgvi
FaL8LaeVOwjzcBPkHfP5oGx4q5hLhg==
=8+9G
-----END PGP SIGNATURE-----

--lnWJsW6oOt1DjHTCSGsag1xiaQwRRjiMN--

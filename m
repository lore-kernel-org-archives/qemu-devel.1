Received: from eggs.gnu.org ([2001:4830:134:3::10]:44572)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dpKhW-0008NS-O3
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 16:44:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dpKhS-0004fC-3S
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 16:44:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40636)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dpKhR-0004eP-PV
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 16:43:58 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AAE7A5DA17
	for <qemu-devel@nongnu.org>; Tue,  5 Sep 2017 20:43:56 +0000 (UTC)
References: <20170904090310.22530-1-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ad2f5f05-254e-fc58-41e5-5128d830eb2f@redhat.com>
Date: Tue, 5 Sep 2017 15:43:51 -0500
MIME-Version: 1.0
In-Reply-To: <20170904090310.22530-1-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="IUMnhj6nQP42d1BLfCt68NVUkMWJSxf2a"
Subject: Re: [Qemu-devel] [PATCH] build-sys: generate tests/.gitignore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: famz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IUMnhj6nQP42d1BLfCt68NVUkMWJSxf2a
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: famz@redhat.com
Message-ID: <ad2f5f05-254e-fc58-41e5-5128d830eb2f@redhat.com>
Subject: Re: [PATCH] build-sys: generate tests/.gitignore
References: <20170904090310.22530-1-marcandre.lureau@redhat.com>
In-Reply-To: <20170904090310.22530-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/04/2017 04:03 AM, Marc-Andr=C3=A9 Lureau wrote:
> tests/.gitignore is often out of date. Let's generate it based on the
> files and directories to clean.

In fact, it got out-of-date again with the recent cbb6540.

>=20
> Note: I didn't succeed yet at generalizing this approach for the rest
> of qemu .gitignore files, but I hope it may eventually happen.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  Makefile                   |  7 +++-
>  tests/.gitignore           | 97 --------------------------------------=
--------
>  tests/Makefile.include     | 39 +++++++++++++++++--
>  tests/migration/.gitignore |  2 -
>  4 files changed, 41 insertions(+), 104 deletions(-)
>  delete mode 100644 tests/.gitignore
>  delete mode 100644 tests/migration/.gitignore
>=20

> @@ -14,6 +14,11 @@ ifneq ($(wildcard config-host.mak),)
>  all:
>  include config-host.mak
> =20
> +.PHONY: gitignore
> +ifneq ($(filter-out $(UNCHECKED_GOALS),$(MAKECMDGOALS)),$(if $(MAKECMD=
GOALS),,fail))
> +all $(MAKECMDGOALS): gitignore
> +endif

As others have mentioned, can we make this conditional on being an
in-tree build, so that a VPATH build isn't modifying non-local files
(after all, .gitignore only matters for an in-tree build)?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--IUMnhj6nQP42d1BLfCt68NVUkMWJSxf2a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmvDIcACgkQp6FrSiUn
Q2rGQQf9FMLBHA87IE7RjTL1qIbw2q2yKJkUfp4WtgwUTb4vRNl/y8Ya26GvjJUr
Xt5A4sMf72dcVJhtXb8Fo+RUQu+1TLSPAw9sQ6FPYDGqKR3WtIYAeoiveG7PgmOR
73QI9sWBRKYSPeA+yBt+K2VbtbnuqNsLlGAJ5ara3kX6RAlKHGu8QezDzy/Gbv/l
ZBDOFmFBQ9ZqnMNE38xOImiuPxiCyiawH4GLCqK+gPjCEIIF+GsRKO1kMlMeNnMt
DapM9B27E9fdSfSQp29uby9aihDhvklrAcVwjRYpWtK/56coCYhfnms9MCAdCrMc
tMPlXM911qnXQ1J2MKa8Lj6BFY9jfA==
=7Oqy
-----END PGP SIGNATURE-----

--IUMnhj6nQP42d1BLfCt68NVUkMWJSxf2a--

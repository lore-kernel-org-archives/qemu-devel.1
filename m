Received: from eggs.gnu.org ([2001:4830:134:3::10]:33206)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eNODa-0007of-IH
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 14:21:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eNODW-0007yZ-Iv
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 14:21:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41976)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eNODW-0007yJ-9d
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 14:21:50 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7A065329B
	for <qemu-devel@nongnu.org>; Fri,  8 Dec 2017 19:21:49 +0000 (UTC)
References: <20171208005825.14587-1-marcandre.lureau@redhat.com>
	<20171208005825.14587-4-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3282db1d-5d97-4125-93a6-59cfda8556ae@redhat.com>
Date: Fri, 8 Dec 2017 13:21:40 -0600
MIME-Version: 1.0
In-Reply-To: <20171208005825.14587-4-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="gh0wtu6NiOVFAa0lfd4b3IltMg9Hb5NiM"
Subject: Re: [Qemu-devel] [PATCH 03/12] build-sys: add a rule to print a
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
--gh0wtu6NiOVFAa0lfd4b3IltMg9Hb5NiM
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Message-ID: <3282db1d-5d97-4125-93a6-59cfda8556ae@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 03/12] build-sys: add a rule to print a
 variable
References: <20171208005825.14587-1-marcandre.lureau@redhat.com>
 <20171208005825.14587-4-marcandre.lureau@redhat.com>
In-Reply-To: <20171208005825.14587-4-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/07/2017 06:58 PM, Marc-Andr=C3=A9 Lureau wrote:
> $ make print-CFLAGS
> CFLAGS=3D-fsanitize=3Daddress -Og -g
>=20
> Trick from various sources:
> https://stackoverflow.com/questions/16467718/how-to-print-out-a-variabl=
e-in-makefile
> https://www.cmcrossroads.com/article/printing-value-makefile-variable
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  Makefile | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20

Slick!

Does it need to be documented anywhere that we have this useful
debugging aid in place?

Reviewed-by: Eric Blake <eblake@redhat.com>

> diff --git a/Makefile b/Makefile
> index ab0354c153..80683e8c8b 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -6,7 +6,10 @@ BUILD_DIR=3D$(CURDIR)
>  # Before including a proper config-host.mak, assume we are in the sour=
ce tree
>  SRC_PATH=3D.
> =20
> -UNCHECKED_GOALS :=3D %clean TAGS cscope ctags docker docker-% help
> +UNCHECKED_GOALS :=3D %clean TAGS cscope ctags docker docker-% help pri=
nt-%
> +
> +print-%:
> +	@echo '$*=3D$($*)'
> =20
>  # All following code might depend on configuration variables
>  ifneq ($(wildcard config-host.mak),)
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--gh0wtu6NiOVFAa0lfd4b3IltMg9Hb5NiM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAloq5kQACgkQp6FrSiUn
Q2rY6wf+O1Jyq7oTOo1K/TsgCSXZ3f0Eust+mT6DQaUS/9YLraJVoRVcP+6YgqLg
UndVErVtFWbNMemq0aclWirfHs6Xznvoms+W9GBqZukJY7MkxC5WTR5p7zbaaqAF
8iH49DFfqy9tONdKJ+zff6bfy8Zgq44O/GXn9XznYi6DUNOMJ3aws7sqJokZ8Ezl
EKXROpIBYVLbd2SKAsR6OFqFbXbD5TM0ieqis7UQm0aAHyBmMWCPq8+7yOZEGjVr
Q/IR0QdOGdDzuWix0fiZb05eAUmHg11PsR6hFxYLYaImCO7bSMdCHkydRR9MWRp9
uATKKMjwSgyJI9SfwtXqypiTS/hYmw==
=j/j+
-----END PGP SIGNATURE-----

--gh0wtu6NiOVFAa0lfd4b3IltMg9Hb5NiM--

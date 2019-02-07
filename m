Received: from eggs.gnu.org ([209.51.188.92]:44097)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1grl8n-0003vt-8O
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 09:59:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1grl8l-00027E-MY
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 09:59:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40308)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1grl8l-00024I-Cf
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 09:58:59 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0B00637EE7
	for <qemu-devel@nongnu.org>; Thu,  7 Feb 2019 14:58:58 +0000 (UTC)
References: <20190206181725.14337-1-armbru@redhat.com>
	<20190206181725.14337-8-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5426a5c4-421e-4a4b-6063-9fb38bc02ab4@redhat.com>
Date: Thu, 7 Feb 2019 08:58:53 -0600
MIME-Version: 1.0
In-Reply-To: <20190206181725.14337-8-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="udIY6mr8rXCdSud3fPbHvMMmdpzk1Rd6U"
Subject: Re: [Qemu-devel] [PATCH v3 07/17] qapi: New module target.json
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--udIY6mr8rXCdSud3fPbHvMMmdpzk1Rd6U
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com
Message-ID: <5426a5c4-421e-4a4b-6063-9fb38bc02ab4@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 07/17] qapi: New module target.json
References: <20190206181725.14337-1-armbru@redhat.com>
 <20190206181725.14337-8-armbru@redhat.com>
In-Reply-To: <20190206181725.14337-8-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2/6/19 12:17 PM, Markus Armbruster wrote:
> We can't add appropriate target-specific conditionals to misc.json,
> because that would make all of misc.json unusable in
> target-independent code.  To keep misc.json target-independent, we
> need to split off target-dependent target.json.
>=20
> This commit doesn't actually split off anything, it merely creates the
> empty module.  The next few patches will move stuff from misc.json
> there.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  Makefile.objs         | 20 +++++++++-----------
>  Makefile.target       | 10 ++++++++++
>  qapi/qapi-schema.json |  1 +
>  qapi/target.json      | 13 +++++++++++++
>  4 files changed, 33 insertions(+), 11 deletions(-)
>  create mode 100644 qapi/target.json

> +++ b/Makefile.target
> @@ -164,6 +164,16 @@ endif
> =20
>  GENERATED_FILES +=3D hmp-commands.h hmp-commands-info.h
> =20
> +# FIXME duplicates Makefile.obj's

Is this addressed later in the series, or should the commit message call
it out?

> +QAPI_TARGET_MODULES =3D target
> +obj-y +=3D $(QAPI_TARGET_MODULES:%=3Dqapi/qapi-types-%.o)
> +obj-y +=3D qapi/qapi-types.o
> +obj-y +=3D $(QAPI_TARGET_MODULES:%=3Dqapi/qapi-visit-%.o)
> +obj-y +=3D qapi/qapi-visit.o
> +obj-y +=3D $(QAPI_TARGET_MODULES:%=3Dqapi/qapi-events-%.o)
> +obj-y +=3D qapi/qapi-events.o
> +obj-y +=3D $(QAPI_TARGET_MODULES:%=3Dqapi/qapi-commands-%.o)
> +obj-y +=3D qapi/qapi-commands.o
>  obj-y +=3D qapi/qapi-introspect.o
> =20
--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--udIY6mr8rXCdSud3fPbHvMMmdpzk1Rd6U
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxcR60ACgkQp6FrSiUn
Q2qWXgf9FpcsAwN8gDS2GhOdlLyTU2R+nIRtqi5wOiEn/Oyysm533colxjP5SXbd
SoXOZNGKjBPt1lr1EsFzPfauuOZRZw8dLMlSCjFD5+C0gMLxQRNIBvLJ6Lg+elcK
YPC4Ue1xp9EUb9zVRG/UI7j2yWW8M12ZzGuXgJ9VEYd7He/cTFdobWsTm8B7R5Y9
C/aqmRD8SjQD3dyalBdsnU65oku3MROW/n15B0T4D7bttKarmCpsYYefTxab8WNF
9WZx2IVyvGtUbSd1n02nQoxDnwh40A+3hGKQjiqltpKR4gGogqq0eCAuMnnBBtLu
zZsrlldRqElyMh9oUpgNuaA5cVB5ug==
=qPHm
-----END PGP SIGNATURE-----

--udIY6mr8rXCdSud3fPbHvMMmdpzk1Rd6U--

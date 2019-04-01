Received: from eggs.gnu.org ([209.51.188.92]:38286)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hAz38-0001O6-Eq
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 11:40:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hAz37-0002rp-3M
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 11:40:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50282)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1hAz36-0002rZ-Ma
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 11:40:37 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F1F3D3086223
	for <qemu-devel@nongnu.org>; Mon,  1 Apr 2019 15:40:35 +0000 (UTC)
References: <20190401150140.29151-1-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <07112946-97c5-03d4-85b6-06676857478f@redhat.com>
Date: Mon, 1 Apr 2019 10:40:34 -0500
MIME-Version: 1.0
In-Reply-To: <20190401150140.29151-1-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="6v9av9Zm5AnF7DcqWPfCeXDbJIbaHHiSE"
Subject: Re: [Qemu-devel] [PATCH] qdev: Delete unused LostTickPolicy "merge"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6v9av9Zm5AnF7DcqWPfCeXDbJIbaHHiSE
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Message-ID: <07112946-97c5-03d4-85b6-06676857478f@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qdev: Delete unused LostTickPolicy "merge"
References: <20190401150140.29151-1-armbru@redhat.com>
In-Reply-To: <20190401150140.29151-1-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 4/1/19 10:01 AM, Markus Armbruster wrote:
> Commit 4e4fa398db6 "qdev: Introduce lost tick policy property"
> (v1.1.0) created PropertyType PROP_TYPE_LOSTTICKPOLICY with values
> "discard", "delay", "merge", and "slew".  Value "merge" has never been
> used.  Delete it.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  qapi/misc.json | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

Doesn't hurt if you try to cram it in -rc2, but also doesn't hurt if you
delay to 4.1.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--6v9av9Zm5AnF7DcqWPfCeXDbJIbaHHiSE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlyiMPIACgkQp6FrSiUn
Q2qwVgf/VtHnknmXkTgOPWE43fdHmz/gQiMUiNJDYIi5Pp34NUGUeCyhzDYKCG3i
utjfLFxfVHHmpFDP35Gezf27LBkIz0T9dwSZDUX5yoU55W+R12pXForgZ3HDNSzL
A+VxAn/UsHx2YT2U/OmK/lXLwsUa7a/jvtWJ+YupJ2QWAwTY9/mogrNCABmvV4MN
oL6D4QCYfw9pBrQwn7cCToIzf4sO99MUm4+Jd/9b6KjXRRmd054S/ZIqU3f04lte
D0R+Jm2nPDwPqeaF2mbA4wyNugUK36Lf9Nql360nIaTSSJ5rLxs8/xHHpLb6mzQp
ZWL7thy+CziT3/+iide7eqGGQaF5yQ==
=b8d3
-----END PGP SIGNATURE-----

--6v9av9Zm5AnF7DcqWPfCeXDbJIbaHHiSE--

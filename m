Received: from eggs.gnu.org ([2001:4830:134:3::10]:38026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dXsYL-00079f-Gu
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 13:14:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dXsYG-00074g-SN
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 13:14:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43986)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dXsYG-00072l-Ip
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 13:14:20 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9A15B61D19
	for <qemu-devel@nongnu.org>; Wed, 19 Jul 2017 17:14:19 +0000 (UTC)
References: <20170717134238.1966-1-quintela@redhat.com>
	<20170717134238.1966-5-quintela@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <58af8e24-6246-c961-4b09-1f9e32c4f181@redhat.com>
Date: Wed, 19 Jul 2017 12:14:12 -0500
MIME-Version: 1.0
In-Reply-To: <20170717134238.1966-5-quintela@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="WhavEfsSrouLHxlWiRe0JGnBOsScLUVd8"
Subject: Re: [Qemu-devel] [PATCH v5 04/17] migration: Add multifd capability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WhavEfsSrouLHxlWiRe0JGnBOsScLUVd8
From: Eric Blake <eblake@redhat.com>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com
Message-ID: <58af8e24-6246-c961-4b09-1f9e32c4f181@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 04/17] migration: Add multifd capability
References: <20170717134238.1966-1-quintela@redhat.com>
 <20170717134238.1966-5-quintela@redhat.com>
In-Reply-To: <20170717134238.1966-5-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/17/2017 08:42 AM, Juan Quintela wrote:
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  migration/migration.c | 9 +++++++++
>  migration/migration.h | 1 +
>  qapi-schema.json      | 4 ++--
>  3 files changed, 12 insertions(+), 2 deletions(-)
>=20

> +++ b/qapi-schema.json
> @@ -902,14 +902,14 @@
>  #
>  # @return-path: If enabled, migration will use the return path even
>  #               for precopy. (since 2.10)
> +# @x-multifd: Use more than one fd for migration (since 2.10)

Are we still aiming for 2.10, even though this is a feature and soft
freeze has already passed?  Better would be updating it to say 2.11

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--WhavEfsSrouLHxlWiRe0JGnBOsScLUVd8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAllvk2QACgkQp6FrSiUn
Q2perAgAo5dxEENODw0etj1yiZ0Pi9XKN4Car44+1yxJzUiOkNE7DhrKXMsF1EZ4
PQH2FwFoTgjHLYvMp5GejrR5cOyXPbeWXRHgU22+4eORof2Mq+1S1UvYDmcErnyF
Ibz1DwCuotB3JltexyP1n5EXhgYiIxCae2LxDJuift38vGNt8UVPcPnP01ESJ6/F
KMJ31IglxjjStJG00NpCgLaKoKz/zVUgMfAUlvMHnILT1wWA1ZOMVGVbUfE/4uea
5BP1ILxTbPaLoHciCRcMJ0PM+/GhTG1nk3FlAxV/r+Q1+qBH8oF0hujioIi5T3GI
sRwMjiE64Keo/WRlz39g18aTa0sWYw==
=uKpW
-----END PGP SIGNATURE-----

--WhavEfsSrouLHxlWiRe0JGnBOsScLUVd8--

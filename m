Received: from eggs.gnu.org ([2001:4830:134:3::10]:37210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dukzS-0003mi-2M
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 15:48:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dukzN-00074q-HU
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 15:48:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37610)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dukzN-00073J-AR
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 15:48:53 -0400
References: <20170920194144.20101-1-jsnow@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <557731f6-58f6-3fe5-884b-42896c8f1be7@redhat.com>
Date: Wed, 20 Sep 2017 14:48:46 -0500
MIME-Version: 1.0
In-Reply-To: <20170920194144.20101-1-jsnow@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="vvC1EI6mD9ixihxnRd4FRIK7lFHbRioXM"
Subject: Re: [Qemu-devel] [PATCH] ide: fix enum comparison for gcc 4.7
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, mark.cave-ayland@ilande.co.uk

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vvC1EI6mD9ixihxnRd4FRIK7lFHbRioXM
From: Eric Blake <eblake@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, mark.cave-ayland@ilande.co.uk
Message-ID: <557731f6-58f6-3fe5-884b-42896c8f1be7@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] ide: fix enum comparison for gcc 4.7
References: <20170920194144.20101-1-jsnow@redhat.com>
In-Reply-To: <20170920194144.20101-1-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/20/2017 02:41 PM, John Snow wrote:
> Apparently GCC gets bent over comparing enum values against zero.
> Replace the conditional with something less readable.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  hw/ide/core.c             | 2 +-
>  include/hw/ide/internal.h | 3 +--
>  2 files changed, 2 insertions(+), 3 deletions(-)

Unfortunate that the compiler conspires against aesthetics, but such is
life.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--vvC1EI6mD9ixihxnRd4FRIK7lFHbRioXM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnCxh4ACgkQp6FrSiUn
Q2qn2gf+OcfOgogB2VyZAP/ylpLSxEc552IX/5VD/5cFqhLrwAVE7Laftblp/pzd
LHD6md570EMsgDvfK3nPo0QG1xStHanHyaAZrSlf2dUoC67/QL5y/QJaGiJdbgSr
dkxLeMc7BHeTIMLZFWDNNqHZzgWtBuF33/LG7pGGSR0QhPWWLAnpLnepBuDJ73fx
v/KQWlD7UtXZGSrEsv/ldnLoa2aePFRMwZbP4vkcWR5YMQgcF3l+4nE1JQ6J83YB
H8O6Tgjgq7oqUAhiuHhWQbM6GW5dg7GQ+Vj8gsMJO1sqL6kyenG70wQHLvB76sUr
Lm2LOH72Bzcjc9yeYS0Z+lwY1ht4Xg==
=5nx7
-----END PGP SIGNATURE-----

--vvC1EI6mD9ixihxnRd4FRIK7lFHbRioXM--

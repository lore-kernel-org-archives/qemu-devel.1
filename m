Received: from eggs.gnu.org ([209.51.188.92]:45509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gu3t2-0001lx-Px
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 18:24:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gu3t1-0004th-QV
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 18:24:16 -0500
References: <20190213225311.17876-1-mreitz@redhat.com>
	<20190213225311.17876-2-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <41419065-2609-cec2-d518-4fb9d08dc811@redhat.com>
Date: Wed, 13 Feb 2019 17:24:10 -0600
MIME-Version: 1.0
In-Reply-To: <20190213225311.17876-2-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="NCelRHxKquXEfES4WRsRD6fWCLKLGsguR"
Subject: Re: [Qemu-devel] [PATCH v3 01/12] block: Mark commit and mirror as
 filter drivers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NCelRHxKquXEfES4WRsRD6fWCLKLGsguR
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <41419065-2609-cec2-d518-4fb9d08dc811@redhat.com>
Subject: Re: [PATCH v3 01/12] block: Mark commit and mirror as filter drivers
References: <20190213225311.17876-1-mreitz@redhat.com>
 <20190213225311.17876-2-mreitz@redhat.com>
In-Reply-To: <20190213225311.17876-2-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2/13/19 4:53 PM, Max Reitz wrote:
> The commit and mirror block nodes are filters, so they should be marked=

> as such.
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> Reviewed-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/commit.c | 2 ++
>  block/mirror.c | 2 ++
>  2 files changed, 4 insertions(+)

Reviewed-by: Eric Blake <eblake@redhat.com>

I know there are patches pending review for a backup driver (for image
fleecing and otherwise), have you checked if that series would need
similar treatment?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--NCelRHxKquXEfES4WRsRD6fWCLKLGsguR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxkpxoACgkQp6FrSiUn
Q2qY5QgAnbdj9KoHPXb+h7itxqh5EO+WoFRdkTHX99p9Ba8ezueKSr9EGSAr/2LH
T5vDezVrEOwfzGInWI6VqYBcllh/Hjpz0Dofh6DPLFV0sB0v1DU7gGu54amY0vXE
40hmxvPcQPlcx+0MxlqYQjjXe/icIP3+mr7ZZVDxWaAx1n2qE4Lk0hXWDiB5cIbq
D8PCTksHhuF4n/I2XD/zcLwZavDGFVc5sf9knn/fxqHwk1BQ/qI581Pl+Hqiwu9W
nhamDSiGwV/4Er6SfgMxiyheBJrYJuhoz6qX07BXyUQe2tjqZQnhSWNLHUbRzwZd
C/VNJSVzzO6NXOnXTzRJPuUi43YHoQ==
=RH21
-----END PGP SIGNATURE-----

--NCelRHxKquXEfES4WRsRD6fWCLKLGsguR--

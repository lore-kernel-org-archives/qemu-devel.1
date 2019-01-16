Received: from eggs.gnu.org ([209.51.188.92]:55288)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gjntt-0000hG-Ku
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 11:18:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gjnts-00089Z-UV
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 11:18:45 -0500
References: <20181229122027.42245-1-vsementsov@virtuozzo.com>
	<20181229122027.42245-9-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <f06983b4-7a3a-27d3-4609-5cad072dab65@redhat.com>
Date: Wed, 16 Jan 2019 17:18:27 +0100
MIME-Version: 1.0
In-Reply-To: <20181229122027.42245-9-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="zZatwNPf1eyCs8rj1jBuJFOqTkIU7tzEq"
Subject: Re: [Qemu-devel] [PATCH v5 08/11] block/io: refactor
 wait_serialising_requests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: fam@euphon.net, stefanha@redhat.com, jcody@redhat.com, kwolf@redhat.com, den@openvz.org, eblake@redhat.com, jsnow@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--zZatwNPf1eyCs8rj1jBuJFOqTkIU7tzEq
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: fam@euphon.net, stefanha@redhat.com, jcody@redhat.com, kwolf@redhat.com,
 den@openvz.org, eblake@redhat.com, jsnow@redhat.com
Message-ID: <f06983b4-7a3a-27d3-4609-5cad072dab65@redhat.com>
Subject: Re: [PATCH v5 08/11] block/io: refactor wait_serialising_requests
References: <20181229122027.42245-1-vsementsov@virtuozzo.com>
 <20181229122027.42245-9-vsementsov@virtuozzo.com>
In-Reply-To: <20181229122027.42245-9-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 29.12.18 13:20, Vladimir Sementsov-Ogievskiy wrote:
> Split out do_wait_serialising_requests with additional possibility to
> not actually wait but just check, that there is something to wait for.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/io.c | 24 ++++++++++++++++--------
>  1 file changed, 16 insertions(+), 8 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--zZatwNPf1eyCs8rj1jBuJFOqTkIU7tzEq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlw/WVMACgkQ9AfbAGHV
z0Dmbwf9GqhG9bBZre9dUfiDssSC1o5EqnMW2Ims3vF+ePiZ7JdvyRuPDLJlpjUT
mFetaTTqxypcT/EJcFEw84v77pEvuRUkdmQu5VBJW8BA2tzgc1an30LkRopfXz93
gbaoj0ujx8QKR+8pXTQIY1EO9foRcHBZGgfubhYkcCohWSr43aK9tPPX4kfbweuV
arHPiRgksIT35Ocq9Z877nWyekpSxbwD/GnLwuMkO83MRiVbWccMX6jFFXXgejjj
0cEJA/rvmTug9ZqVG1Wm5bt+m+dwrx/dPVbhwiG4VtGrdim5s+7dNi+VZcFj9FcH
iKqW57cAKOEgHMySGLOzJyyRgPmbJA==
=fv/y
-----END PGP SIGNATURE-----

--zZatwNPf1eyCs8rj1jBuJFOqTkIU7tzEq--

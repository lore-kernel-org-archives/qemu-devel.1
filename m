Received: from eggs.gnu.org ([2001:4830:134:3::10]:35826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1e1e9y-0007Qu-3N
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 15:56:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1e1e9w-0000pu-Sr
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 15:56:18 -0400
References: <20171009155431.14093-1-mreitz@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <69d85cfb-b94d-6af9-6b2a-7f04c9324aa2@redhat.com>
Date: Mon, 9 Oct 2017 21:56:07 +0200
MIME-Version: 1.0
In-Reply-To: <20171009155431.14093-1-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="TXtiFxxTWdMODVUBEFHRl2kR22A3vupGa"
Subject: Re: [Qemu-devel] [PATCH] qcow2: Emit errp when truncating the image
 tail
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Pavel Butsykin <pbutsykin@virtuozzo.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--TXtiFxxTWdMODVUBEFHRl2kR22A3vupGa
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Pavel Butsykin <pbutsykin@virtuozzo.com>
Message-ID: <69d85cfb-b94d-6af9-6b2a-7f04c9324aa2@redhat.com>
Subject: Re: [PATCH] qcow2: Emit errp when truncating the image tail
References: <20171009155431.14093-1-mreitz@redhat.com>
In-Reply-To: <20171009155431.14093-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-10-09 17:54, Max Reitz wrote:
> bdrv_truncate() has an errp parameter which is always set when an error=

> occurs.  Let's use that instead of a plain strerror().
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  block/qcow2.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)

Thanks for the reviews, applied to my block branch:

https://github.com/XanClic/qemu/commits/block

Max


--TXtiFxxTWdMODVUBEFHRl2kR22A3vupGa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlnb1FcSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A/RQH/RkhsSnS6luPag2dR5KMAIBp+Mcq1Cbv
xIWbXsL8drtRAhoxKpcjiEN2KU1B9NDv5Jqa73ExqfbyVYApbBdX6RLqY97fNXS+
kjruPCbNLYOVVfJjwgkekdiNRgPB0O9DO7H0F0/J7S1xlGKsxYOqiph9UhIV5FmO
PHkToQHZ5sqaNiUeAGadL4deY6wraZRJPlXEMBm6jj3YJ7tT4+oSL2ns0l+LtGk0
NLcMUKsG//GeG1sNYoB6meYRHQG0baC/ySpuV2AtkOKbNjqIyg3w2i4V3+vIdcad
/2oRdyneW/FdfTlGlJUVBvtnxNJrAmBZkGb6Olo5lYfKoOfkQdyKOQE=
=6PFY
-----END PGP SIGNATURE-----

--TXtiFxxTWdMODVUBEFHRl2kR22A3vupGa--

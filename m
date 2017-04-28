Received: from eggs.gnu.org ([2001:4830:134:3::10]:42866)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d4BbB-0006JO-Mq
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 15:30:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d4BbA-00032V-SP
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 15:30:37 -0400
References: <20170427014626.11553-1-eblake@redhat.com>
	<20170427014626.11553-7-eblake@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <df4f3b8a-63fb-28c7-61e9-60288bf50b87@redhat.com>
Date: Fri, 28 Apr 2017 21:30:28 +0200
MIME-Version: 1.0
In-Reply-To: <20170427014626.11553-7-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="TVNebA4JSOQnMisTnsrbQkLEJ0RVECdMi"
Subject: Re: [Qemu-devel] [PATCH v10 06/17] qemu-io: Don't open-code
 QEMU_IS_ALIGNED
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--TVNebA4JSOQnMisTnsrbQkLEJ0RVECdMi
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org
Message-ID: <df4f3b8a-63fb-28c7-61e9-60288bf50b87@redhat.com>
Subject: Re: [PATCH v10 06/17] qemu-io: Don't open-code QEMU_IS_ALIGNED
References: <20170427014626.11553-1-eblake@redhat.com>
 <20170427014626.11553-7-eblake@redhat.com>
In-Reply-To: <20170427014626.11553-7-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 27.04.2017 03:46, Eric Blake wrote:
> Manual comparison against 0x1ff is not as clean as using our
> alignment macros from osdep.h.
>=20
> Suggested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Signed-off-by: Eric Blake <eblake@redhat.com>
>=20
> ---
> v10: new patch
> ---
>  qemu-io-cmds.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--TVNebA4JSOQnMisTnsrbQkLEJ0RVECdMi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlkDmFQSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ApM4H/AngkqXqmHrvDdx9Uw7Xknwq1tx8VJob
dRmEQKInDQzayjo75f2qbATLlmh68MSQorl4XmIWIUHs679ZaXg8VMNEEinWj8Qt
VEsGJJu45P+KBwylHKmZ+8+rJ7dVI0trZI9nWQ1le4oW5HOllXchXnFdBQ0z81Q5
Ii+MmmcNtIY8+LQA6MLv3VGhC6mC0C19/8xRboUcr2F1KGh4yk2X36f3oj4r2pzY
1rT2DMhdFL4yh7L/bZIpAAtP/V2yFFgSRaKwUFL1yeQcH3kDKDB9axAFfy5Dk84+
gl3fYK4aX1M9lX//1TwL94j6Llw2Vi3rytgUYhbSdzMsJb280WRsVEU=
=pezY
-----END PGP SIGNATURE-----

--TVNebA4JSOQnMisTnsrbQkLEJ0RVECdMi--

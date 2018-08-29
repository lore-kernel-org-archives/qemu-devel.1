Received: from eggs.gnu.org ([2001:4830:134:3::10]:58249)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fuy5S-0006eS-O2
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 06:52:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fuy5P-0006Wp-J3
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 06:52:34 -0400
References: <cover.1535291602.git.berto@igalia.com>
	<cbbe82e012ffd2dde05fec3012ab1ebc7cd3d045.1535291602.git.berto@igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <5d728b8a-2b24-4c91-dc72-851720c65245@redhat.com>
Date: Wed, 29 Aug 2018 12:47:21 +0200
MIME-Version: 1.0
In-Reply-To: <cbbe82e012ffd2dde05fec3012ab1ebc7cd3d045.1535291602.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="O6hik2pEbiaHzcMVQBknj0DBkPXwsRm5N"
Subject: Re: [Qemu-devel] [PATCH 4/9] block: Don't look for child references
 in append_open_options()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--O6hik2pEbiaHzcMVQBknj0DBkPXwsRm5N
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <5d728b8a-2b24-4c91-dc72-851720c65245@redhat.com>
Subject: Re: [PATCH 4/9] block: Don't look for child references in
 append_open_options()
References: <cover.1535291602.git.berto@igalia.com>
 <cbbe82e012ffd2dde05fec3012ab1ebc7cd3d045.1535291602.git.berto@igalia.com>
In-Reply-To: <cbbe82e012ffd2dde05fec3012ab1ebc7cd3d045.1535291602.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-08-26 16:09, Alberto Garcia wrote:
> In the previous patch we removed child references from bs->options, so
> there's no need to look for them here anymore.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block.c | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--O6hik2pEbiaHzcMVQBknj0DBkPXwsRm5N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAluGebkACgkQ9AfbAGHV
z0DWXAf+M+ChpH0CYttaL/gtpguemLualUXfReig88IRCM5PfD9cJpQw2uGrbXg5
FyGF+PWYVTtdbZBwV+l/klQDTnsTTHV55Y1vDAgZ836lPAnAMTUls68eS5jYYlpT
NjUZtoX2AY+ieDYMQNc8d52m/qvN8aAspfpdR9EJTljRB0IPZZ3p3I0tL0zq3QFT
umXT98RxvluOKsDtEGHNWgvTTF3OL9VskK5d+EblQJkwTAR427ER3pCSbPNzDVFU
z4h1GqPAAp2GM1jN1J0/Gs82Nl6JN/OkQedHtKBAc3GQCIr72wmetZT+cH7ykuvk
GhhqTqesVf76At6hhq0RuOrsTbWimQ==
=a6Md
-----END PGP SIGNATURE-----

--O6hik2pEbiaHzcMVQBknj0DBkPXwsRm5N--

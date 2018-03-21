Received: from eggs.gnu.org ([2001:4830:134:3::10]:60161)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eyczl-0006kK-7i
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 08:37:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eyczh-00029B-VX
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 08:37:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36374 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1eyczh-00028z-QY
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 08:37:29 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8D3ED76FB9
	for <qemu-devel@nongnu.org>; Wed, 21 Mar 2018 12:37:26 +0000 (UTC)
References: <20180312183628.394722-1-eblake@redhat.com>
	<20180312183628.394722-32-eblake@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <c1197340-adb8-4caa-d101-65722797e7eb@redhat.com>
Date: Wed, 21 Mar 2018 13:37:21 +0100
MIME-Version: 1.0
In-Reply-To: <20180312183628.394722-32-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="5zDxD9wMreHGbE3D8U4BZI1sNIs16XRdL"
Subject: Re: [Qemu-devel] [PULL 31/36] monitor: enable IO thread for (qmp &
 !mux) typed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5zDxD9wMreHGbE3D8U4BZI1sNIs16XRdL
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>
Message-ID: <c1197340-adb8-4caa-d101-65722797e7eb@redhat.com>
Subject: Re: [Qemu-devel] [PULL 31/36] monitor: enable IO thread for (qmp &
 !mux) typed
References: <20180312183628.394722-1-eblake@redhat.com>
 <20180312183628.394722-32-eblake@redhat.com>
In-Reply-To: <20180312183628.394722-32-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-03-12 19:36, Eric Blake wrote:
> From: Peter Xu <peterx@redhat.com>
>=20
> Start to use dedicate IO thread for QMP monitors that are not using
> MUXed chardev.
>=20
> Reviewed-by: Fam Zheng <famz@redhat.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> Message-Id: <20180309090006.10018-21-peterx@redhat.com>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  monitor.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

It seems the iotests aren't quite ready for this change (breakage in
040, 041, 051, 060, 085, 087, 093, 095, 109, 124, 127, 132, 136, 144,
148, 152, 182, 183, 185, 186; and 030 hangs).

Max


--5zDxD9wMreHGbE3D8U4BZI1sNIs16XRdL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlqyUgESHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A0tUH/2UVdidANhpxqp7av+QBChf3i3qblG7M
L1dMNeWGScS63G8s71P960tLAXYojYGgDQSvk8dggyFPce1YJyVZ/OTR/bd/u/ah
856SyyqKFzUqagC3PzDUwmj/dSxcMC07cMp/ufqFzMhLDT5W3GKrWEvSD81Mqfhc
Uukq6JzXGFuEPKVNmmYr1vdne3kl2nNqSvRi/cO2LKJYyV64wmqWANP3NnpBZVcz
LhpHFRQC124RNsyy3SfdUvgZZAly7tvXghUCBttbE6Nzj21t0aNR6fUxF+Z9AbLY
3IjqwrSZhtsJqfh4M2twrC5R8J82R3vaAn23xLT5zOE3nZr+i1+7i78=
=9ILG
-----END PGP SIGNATURE-----

--5zDxD9wMreHGbE3D8U4BZI1sNIs16XRdL--

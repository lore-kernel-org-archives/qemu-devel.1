Received: from eggs.gnu.org ([2001:4830:134:3::10]:54279)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1g9clP-00030Q-9k
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 17:08:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1g9clH-0003Og-ER
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 17:08:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47586)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1g9clH-0003NY-3Q
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 17:08:19 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9ABA73E2CE
	for <qemu-devel@nongnu.org>; Mon,  8 Oct 2018 21:08:14 +0000 (UTC)
References: <20181008173125.19678-1-armbru@redhat.com>
	<20181008173125.19678-30-armbru@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <7bbcf317-e1a5-fc8f-b4e2-0caedbe4e00b@redhat.com>
Date: Mon, 8 Oct 2018 23:08:11 +0200
MIME-Version: 1.0
In-Reply-To: <20181008173125.19678-30-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="88GKptdQRCQvFKPZzu2iRTD5qp3umOZXb"
Subject: Re: [Qemu-devel] [PATCH 29/31] vl: Assert drive_new() does not fail
 in default_drive()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--88GKptdQRCQvFKPZzu2iRTD5qp3umOZXb
From: Max Reitz <mreitz@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>
Message-ID: <7bbcf317-e1a5-fc8f-b4e2-0caedbe4e00b@redhat.com>
Subject: Re: [PATCH 29/31] vl: Assert drive_new() does not fail in
 default_drive()
References: <20181008173125.19678-1-armbru@redhat.com>
 <20181008173125.19678-30-armbru@redhat.com>
In-Reply-To: <20181008173125.19678-30-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08.10.18 19:31, Markus Armbruster wrote:
> If creating (empty) default drives fails, it's a bug.  Therefore,
> assert() is more appropriate than exit(1).
>=20
> Cc: Kevin Wolf <kwolf@redhat.com>
> Cc: Max Reitz <mreitz@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  vl.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--88GKptdQRCQvFKPZzu2iRTD5qp3umOZXb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlu7xzwACgkQ9AfbAGHV
z0BULQf/VZpe1aXOYd1PpYtjAOGAMFqqGeqRfBWOjKBkkQbDQolaCP3ayNKnTb1H
uDL9iR9HsJ+9hj1kxN6tLV6velzJVV/IOL1h/Y52MG1hPvSxiykJJBYkDItZGtun
Q0htSTZX/U2djkoaXtDKOWT8vwCmO95WBgN2STNsknMwcPCafvsI86f0tSnuVs/r
ce8yaBGCAbr2FbcCIWG37JnA2IEuutni7LMJFNwE/mRV4o2aRDkYp/Ab+6j0cXab
KflcLm7GVoZnZn1lpjxjckmKgzzjjsLWmwOjKRTFVz2qy786CXFevZ0SagR/iw3X
EcGYUhoCWy3Q0yg8iDSi9c+W+YS3fw==
=iHjj
-----END PGP SIGNATURE-----

--88GKptdQRCQvFKPZzu2iRTD5qp3umOZXb--

Received: from eggs.gnu.org ([2001:4830:134:3::10]:41506)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cqjpk-0000AB-3H
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 13:14:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cqjpg-0006tG-Vi
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 13:14:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37848)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1cqjpg-0006t3-Mq
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 13:14:00 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 266627AEA1
	for <qemu-devel@nongnu.org>; Wed, 22 Mar 2017 17:14:00 +0000 (UTC)
References: <1490199642-5521-1-git-send-email-armbru@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <01e78c6d-b182-f8f9-828c-737cb94c4f1b@redhat.com>
Date: Wed, 22 Mar 2017 18:13:56 +0100
MIME-Version: 1.0
In-Reply-To: <1490199642-5521-1-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="etdQINP2A7QRbKSCeFCn7u3NsdmIrCAMd"
Subject: Re: [Qemu-devel] [PATCH v2 for-2.9] block: Declare blockdev-add and
 blockdev-del supported
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, pkrempa@redhat.com, eblake@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--etdQINP2A7QRbKSCeFCn7u3NsdmIrCAMd
From: Max Reitz <mreitz@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, pkrempa@redhat.com, eblake@redhat.com
Message-ID: <01e78c6d-b182-f8f9-828c-737cb94c4f1b@redhat.com>
Subject: Re: [PATCH v2 for-2.9] block: Declare blockdev-add and blockdev-del
 supported
References: <1490199642-5521-1-git-send-email-armbru@redhat.com>
In-Reply-To: <1490199642-5521-1-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 22.03.2017 17:20, Markus Armbruster wrote:
> It's been a long journey, but here we are.
>=20
> The supported blockdev-add is not compatible to its experimental
> predecessors; bump all Since: tags to 2.9.
>=20
> x-blockdev-remove-medium, x-blockdev-insert-medium and
> x-blockdev-change need a bit more work, so leave them alone for now.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
> v2:
> * Another "command is considered experimental" comment dropped [Max]
> * More Since: tags updated to 2.9, commit message improved, R-bys dropp=
ed

Do you want to do this recursively? There are things such as
BlkdebugSetStateOptions or ReplicationMode which are only used by the
corresponding BlockdevOptions*, so they too are basically only supported
as of 2.9.

I don't have a strong opinion, but I think I personally wouldn't bother
with any of these structures and just update the tag for blockdev-add
itself...

You being fine with me would be enough to convince me, so:

Reviewed-by: Max Reitz <mreitz@redhat.com>

>=20
>  blockdev.c             |  4 +--
>  qapi/block-core.json   | 69 ++++++++++++++++++------------------------=
--------
>  tests/qemu-iotests/139 |  8 +++---
>  tests/qemu-iotests/141 |  4 +--
>  tests/qemu-iotests/147 |  2 +-
>  5 files changed, 34 insertions(+), 53 deletions(-)


--etdQINP2A7QRbKSCeFCn7u3NsdmIrCAMd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAljSsNQSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AFPkH/2LQZFwujNEyK7Ah4vGiNqtEtgDbsRS6
VZVETCde7XqH1hCmMG/zRqUlzGjo5giFJjVzjlRIwzbRXE94tSgkTtN3CZzsPxQ1
o5WX5dpJ4+CQJwEsqmQTdUsCRFDcnBKyVNhMAhLryRYTBd0iVhbvR2ZzhtXaP5Yl
vIy/hnHFWILvVfOER/g2k7seqS7iLLRrJp6vup2yPC9YbEGAb8mErafhy1uEVnpN
2e9I26b7KjNuKSd3EjChzfoJMSjDtqxn68Pb25Ir5VCJgnc6LbMXKwsKG6Y9jDa6
gyZRo+vmiO0NMYPtaDiZwjosWdExjj0Bkccf0zUKYwG/GyDNzPgaRrs=
=fBz1
-----END PGP SIGNATURE-----

--etdQINP2A7QRbKSCeFCn7u3NsdmIrCAMd--

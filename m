Received: from eggs.gnu.org ([2001:4830:134:3::10]:34116)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1csXQE-0003oZ-W0
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 12:23:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1csXQA-0002xr-2e
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 12:23:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32954)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1csXQ9-0002wO-QO
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 12:23:06 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A7A77569E
	for <qemu-devel@nongnu.org>; Mon, 27 Mar 2017 16:23:04 +0000 (UTC)
References: <1490621195-2228-1-git-send-email-armbru@redhat.com>
	<1490621195-2228-4-git-send-email-armbru@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <573326fd-efb2-33a5-a9c8-9e7e3b55cd3a@redhat.com>
Date: Mon, 27 Mar 2017 18:22:55 +0200
MIME-Version: 1.0
In-Reply-To: <1490621195-2228-4-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="jwfGmWOsoH5d84c7upAKcckG2c6Wsuf5N"
Subject: Re: [Qemu-devel] [PATCH RFC v3 for-2.9 03/11] rbd: Don't limit
 length of parameter values
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: jdurgin@redhat.com, jcody@redhat.com, kwolf@redhat.com, eblake@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jwfGmWOsoH5d84c7upAKcckG2c6Wsuf5N
From: Max Reitz <mreitz@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: jdurgin@redhat.com, jcody@redhat.com, kwolf@redhat.com, eblake@redhat.com
Message-ID: <573326fd-efb2-33a5-a9c8-9e7e3b55cd3a@redhat.com>
Subject: Re: [PATCH RFC v3 for-2.9 03/11] rbd: Don't limit length of parameter
 values
References: <1490621195-2228-1-git-send-email-armbru@redhat.com>
 <1490621195-2228-4-git-send-email-armbru@redhat.com>
In-Reply-To: <1490621195-2228-4-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 27.03.2017 15:26, Markus Armbruster wrote:
> We laboriously enforce parameter values are between one and some
> arbitrary limit in length.  Only RBD_MAX_IMAGE_NAME_SIZE comes from
> librbd.h, and I'm not sure it applies.  Where the other limits come
> from is unclear.
>=20
> Drop the length checking.  The limits librbd actually imposes must be
> checked by librbd anyway.
>=20
> There's one minor complication: BDRVRBDState member name is a
> fixed-size array.  Depends on the length limit.  Make it a pointer to
> a dynamically allocated string.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
>  block/rbd.c | 91 ++++++++++-------------------------------------------=
--------
>  1 file changed, 14 insertions(+), 77 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--jwfGmWOsoH5d84c7upAKcckG2c6Wsuf5N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAljZPF8SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AgcYH/3B4B+lTuw+ZeYmC9EPivgSW4iX0Ebzj
g9yRwL1749745eluzVVIA4U0iCSRiBqQlUlMDeKtiXdM9hHsQoIkDkU77pcnvZc3
r+5T68BR+9jqf/fTT2szhgEOadEK018WU5JuxFIg1QdeyDw5+cptKD9SJteBy8vA
03iVCraHfg93ZMzgHLddqkZvg3owKAxx+yLpsL/cB1uIXOzNe1DIjjhpbybKW+fX
aI6aQ5Wgb2n40GVHFlaOiD429cTmr574QTYKD9rF2zUhvba8mreTi6d6/btbhO9O
T3MUZBY89xssCffH1Lfal95nnfvz7Y12aETYAN2uIVhb7JMHFWxSSrU=
=PQuQ
-----END PGP SIGNATURE-----

--jwfGmWOsoH5d84c7upAKcckG2c6Wsuf5N--

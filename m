Received: from eggs.gnu.org ([2001:4830:134:3::10]:50066)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cyk86-0001fh-8B
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 15:10:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cyk83-0006LE-Kg
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 15:10:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56836)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1cyk83-0006Kx-Be
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 15:10:03 -0400
References: <1491405505-31620-1-git-send-email-den@openvz.org>
	<1491405505-31620-3-git-send-email-den@openvz.org>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <072e397c-520b-3a93-c447-d5ec1501dbf0@redhat.com>
Date: Thu, 13 Apr 2017 21:09:59 +0200
MIME-Version: 1.0
In-Reply-To: <1491405505-31620-3-git-send-email-den@openvz.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="rmprWnrAib5aDo9gagHpqDhbHunvdD1iu"
Subject: Re: [Qemu-devel] [PATCH 2/2] block: assert no image modification
 under BDRV_O_INACTIVE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rmprWnrAib5aDo9gagHpqDhbHunvdD1iu
From: Max Reitz <mreitz@redhat.com>
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>
Message-ID: <072e397c-520b-3a93-c447-d5ec1501dbf0@redhat.com>
Subject: Re: [PATCH 2/2] block: assert no image modification under
 BDRV_O_INACTIVE
References: <1491405505-31620-1-git-send-email-den@openvz.org>
 <1491405505-31620-3-git-send-email-den@openvz.org>
In-Reply-To: <1491405505-31620-3-git-send-email-den@openvz.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05.04.2017 17:18, Denis V. Lunev wrote:
> As long as BDRV_O_INACTIVE is set, the image file is only opened so we
> have a file descriptor for it. We're definitely not supposed to modify
> the image, it's still owned by the migration source.
>=20
> This commit is an addition to 09e0c771 but the assert() is added to
> bdrv_truncate().
>=20
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Kevin Wolf <kwolf@redhat.com>
> CC: Max Reitz <mreitz@redhat.com>
> ---
>  block.c | 2 ++
>  1 file changed, 2 insertions(+)

Thanks to the new op blockers I'm not sure this is really necessary
anymore (that assertion should cover this, once it's reinstated, that
is...), but it won't hurt, I guess.

Max


--rmprWnrAib5aDo9gagHpqDhbHunvdD1iu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAljvzQcSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ANYUH/307Uap0u7yy/e1FOh3WcGzQbXYAe8gm
3qcqoSbeBZfoQXgEwXAM00HmFG0boczpVsKy/2QiDjjJosvFu8luMlbVttgeWMGm
NLn6EwUlySP7Aa1EVAajpYF5nVD9+wAFL3q8udqdugpAZQxCEp4SUMCh9oDq17dl
6+BO7omy4fEGVMwJcNCxsZ1IXGKwdKGApgi5IS1GVKYk2ikPD2ZSMj3T1cbrK8UK
dkxHOIFfwxd59y5PmUGB8kgyoLMdloDf6UvogEOZPkGygdPrqiDEc3Q/VwvOYw9S
Q+STSAa9MgQ43/7Z3twCWhZlGgCEtJhpQPvE1+Hw4hL+EJNT7/SlsQc=
=5gz/
-----END PGP SIGNATURE-----

--rmprWnrAib5aDo9gagHpqDhbHunvdD1iu--

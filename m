Received: from eggs.gnu.org ([2001:4830:134:3::10]:42995)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dG57S-0003WA-03
	for qemu-devel@nongnu.org; Wed, 31 May 2017 11:01:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dG57O-00031x-Bu
	for qemu-devel@nongnu.org; Wed, 31 May 2017 11:01:05 -0400
References: <20170524202842.26724-1-eblake@redhat.com>
	<20170524202842.26724-6-eblake@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <f9de200d-887d-9203-5ca5-7fd310836cc8@redhat.com>
Date: Wed, 31 May 2017 17:00:39 +0200
MIME-Version: 1.0
In-Reply-To: <20170524202842.26724-6-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="WKFlsrR3DurXqS6iPxQSVo8jp74CHdKNP"
Subject: Re: [Qemu-devel] [PATCH v2 5/5] blkdebug: Support
 .bdrv_co_get_block_status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, jsnow@redhat.com, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WKFlsrR3DurXqS6iPxQSVo8jp74CHdKNP
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, jsnow@redhat.com, Kevin Wolf <kwolf@redhat.com>
Message-ID: <f9de200d-887d-9203-5ca5-7fd310836cc8@redhat.com>
Subject: Re: [PATCH v2 5/5] blkdebug: Support .bdrv_co_get_block_status
References: <20170524202842.26724-1-eblake@redhat.com>
 <20170524202842.26724-6-eblake@redhat.com>
In-Reply-To: <20170524202842.26724-6-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-05-24 22:28, Eric Blake wrote:
> Without a passthrough status of BDRV_BLOCK_RAW, anything wrapped by
> blkdebug appears 100% allocated as data.  Better is treating it the
> same as the underlying file being wrapped.
>=20
> Update iotest 177 for the new expected output.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
>=20
> ---
> v2: tweak commit message
> ---
>  block/blkdebug.c           | 11 +++++++++++
>  tests/qemu-iotests/177.out |  5 ++++-
>  2 files changed, 15 insertions(+), 1 deletion(-)

Well, depends on the previous patch, but:

Reviewed-by: Max Reitz <mreitz@redhat.com>


--WKFlsrR3DurXqS6iPxQSVo8jp74CHdKNP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZLtqXEhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQOhE
B/0REldfxMp1IKlnbgkxhUK7WN+O+KEPD10TJew2EHoy+bray8FRN10mmljo/bBl
32r3CTNapkeE7EqQYwcUyX8+upcs0WX0sTbQx8fdeNEiH25J201o2h0R6V+pNkNI
LBXA3PFdVHNp4MOvhQ794geHwfocj8EPKZJSlDx/m9iNzh5BE3Nth4mwuq04FTkp
dpVMejf1MSzdNVdJ+L/AtkV9a8TnbgpNJ3llbyxAF4dydznugyWJO5wCQF7WIOR/
GKxZza+WhFDx49Bzv98t5szvEcOw39HHWB6ogPL+MPM7D5rxuLETwgYnjvyAoODM
GON2PFQDHpJrKeVwpoxDFvBn
=jmoD
-----END PGP SIGNATURE-----

--WKFlsrR3DurXqS6iPxQSVo8jp74CHdKNP--

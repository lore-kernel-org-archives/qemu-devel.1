Received: from eggs.gnu.org ([2001:4830:134:3::10]:35663)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d3MNH-0003vW-2c
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 08:48:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d3MNG-0003mQ-Gh
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 08:48:51 -0400
References: <20170413203401.3213-1-mreitz@redhat.com>
	<20170419154949.GF5826@noname.redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <93dfeca5-c43f-b753-4c29-ab9811b6359a@redhat.com>
Date: Wed, 26 Apr 2017 14:48:41 +0200
MIME-Version: 1.0
In-Reply-To: <20170419154949.GF5826@noname.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="kkJJ7oPrxkhijMpFonKVDUOWO6pEpuulq"
Subject: Re: [Qemu-devel] [PATCH for-2.10 0/3] qemu-img/convert: Some small
 fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kkJJ7oPrxkhijMpFonKVDUOWO6pEpuulq
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Eric Blake <eblake@redhat.com>
Message-ID: <93dfeca5-c43f-b753-4c29-ab9811b6359a@redhat.com>
Subject: Re: [PATCH for-2.10 0/3] qemu-img/convert: Some small fixes
References: <20170413203401.3213-1-mreitz@redhat.com>
 <20170419154949.GF5826@noname.redhat.com>
In-Reply-To: <20170419154949.GF5826@noname.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 19.04.2017 17:49, Kevin Wolf wrote:
> Am 13.04.2017 um 22:33 hat Max Reitz geschrieben:
>> This series fixes some small issues I found in qemu-img's convert
>> subcommand while reviewing Dan's convert/dd series.
>>
>> Nothing serious at all, so all for 2.10.
>=20
> This series conflicts with Peter Lieven's "qemu-img: simplify
> img_convert" in my block-next branch.
>=20
> Patch 1 is unnecessary now (ret is still -EINVAL at this point), the
> other two probably just need rebasing.

Hm... What should I do about qemu-stable, though? I don't think that
Peter's series will end up there, so qemu-stable should probably indeed
take v1...

Max


--kkJJ7oPrxkhijMpFonKVDUOWO6pEpuulq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlkAlyoSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AKbIH/A9m5fBwhhZkum0xbqp1q2tRh2hwdu+B
OC3z67sehgrFI2fEQoXwSVjbQDRG16BFbLcAWHebaO24rxRRsU3LGkyeUptYPPUU
GleuiJmcCORq8QTpHDRVUDQpBQFrFwqmo9qWspg4lpYzzp4hz0yqRG2N0FcWfLg/
nGEg+04HjJ1lNim+oCl+PrDlf+6HNtGJvAUfiBLv1pl7GVvFO/nAlgR3caT7NQx8
K013t9bFG4QtBRg8iKKgXLvzh9UeIW8eWZctKJ80jxazV5pK3o4QD9wwLpUe+GWE
aj7Y/QLYV+JF0NLBS1D/zK3JxhmHihdOpksgdbiO+im2QP5zsloqYo4=
=ID2m
-----END PGP SIGNATURE-----

--kkJJ7oPrxkhijMpFonKVDUOWO6pEpuulq--

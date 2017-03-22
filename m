Received: from eggs.gnu.org ([2001:4830:134:3::10]:33613)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cqjVW-0008IQ-6L
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 12:53:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cqjVV-0007yK-6e
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 12:53:10 -0400
References: <20170313214001.26339-1-mreitz@redhat.com>
	<20170313214045.26857-5-mreitz@redhat.com>
	<20170320110023.GH17887@stefanha-x1.localdomain>
	<a51da640-ce10-1a8c-2e07-195e900e1147@redhat.com>
	<20170322164413.GD16717@stefanha-x1.localdomain>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <7e892dd3-2eab-3a2e-c5ca-43aa4b36b988@redhat.com>
Date: Wed, 22 Mar 2017 17:53:00 +0100
MIME-Version: 1.0
In-Reply-To: <20170322164413.GD16717@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="HAjQJwTIT8RNhndw1VB9Wgb92n49X3tcf"
Subject: Re: [Qemu-devel] [PATCH for-2.10 07/16] block/file-posix:
 Generalize raw_regular_truncate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HAjQJwTIT8RNhndw1VB9Wgb92n49X3tcf
From: Max Reitz <mreitz@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 qemu-devel@nongnu.org
Message-ID: <7e892dd3-2eab-3a2e-c5ca-43aa4b36b988@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 07/16] block/file-posix: Generalize
 raw_regular_truncate
References: <20170313214001.26339-1-mreitz@redhat.com>
 <20170313214045.26857-5-mreitz@redhat.com>
 <20170320110023.GH17887@stefanha-x1.localdomain>
 <a51da640-ce10-1a8c-2e07-195e900e1147@redhat.com>
 <20170322164413.GD16717@stefanha-x1.localdomain>
In-Reply-To: <20170322164413.GD16717@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 22.03.2017 17:44, Stefan Hajnoczi wrote:
> On Mon, Mar 20, 2017 at 04:11:24PM +0100, Max Reitz wrote:
>> On 20.03.2017 12:00, Stefan Hajnoczi wrote:
>>> On Mon, Mar 13, 2017 at 10:40:36PM +0100, Max Reitz wrote:
>>>> +static int raw_regular_truncate(int fd, BlockDriverState *bs, int64=
_t offset,
>>>
>>> The presence of both a file descriptor and a BlockDriverState (actual=
ly
>>> it must be a BDRVRawState) arguments is unusual.  It seems bs is need=
ed
>>> for bdrv_getlength().
>>>
>>> How about using fstat(fd, &st) and then dropping bs and create?
>>
>> Well, I could do that, but bdrv_getlength() is a bit simpler and I don=
't
>> see much of an issue with specifying both an fd and a bs.
>=20
> Arguments that provide overlapping information make the function harder=

> to understand and use correctly (there are combinations of these
> arguments that are invalid or don't make sense).  Saving a few lines of=

> code in the function implementation is a poor trade-off IMO.

My brain likes to agree but for some reason my heart really prefers
block layer functions (where I know what can go wrong) over POSIX
functions (where I always have the feeling of maybe not having though of
everything).

I guess I'll have to silence my heart for a bit, then.

Max


--HAjQJwTIT8RNhndw1VB9Wgb92n49X3tcf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAljSq+wSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AXwYH/R0FRmrpqzgX6Uwoy7/FOsgZytzzFcuF
fd1hl/v8o/QpSiuWFsEep3/oKjKC9dOhWhpWCzAfNIacnj43taFc+NNylMOD+CCZ
kMLKEN4fQF3b84Z2Grw4A/hRoJ+cp4BfdMB6Xjp36qNmgvwCUd6PFYLhxz/PkbUw
saQSob7fZluUC/9/GjO5riXzhDka9Xx4Id7wTwNI8ODNsOnWtgMj1sCy62WypJnh
VbWFSO2SSmyBC80b2hdZfVK00reD+GRmw4SiAuhhnHhsxQGEHYr8oBkGpCf2d54p
fXcQHeJAgE8yCyCVw5nMULJOl06qZ/fB5JHR20WSaOY3l50xSE6I2U4=
=gRqc
-----END PGP SIGNATURE-----

--HAjQJwTIT8RNhndw1VB9Wgb92n49X3tcf--

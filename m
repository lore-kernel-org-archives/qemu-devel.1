Received: from eggs.gnu.org ([2001:4830:134:3::10]:57314)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cTqN9-00084D-P8
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 08:33:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cTqN8-0006s2-VY
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 08:33:55 -0500
References: <20170111181432.18868-1-mreitz@redhat.com>
	<20170116204921.31578-3-mreitz@redhat.com>
	<0aa10ac5-84cb-f750-ce5e-cb6132ebbc60@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <394e0884-c0ea-b084-16d4-bf7ae86f9b84@redhat.com>
Date: Wed, 18 Jan 2017 14:33:48 +0100
MIME-Version: 1.0
In-Reply-To: <0aa10ac5-84cb-f750-ce5e-cb6132ebbc60@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="l2ori9q1iPeojCV1xwmjcpKSgkj09sAdJ"
Subject: Re: [Qemu-devel] [PATCH v4 10/25] block: Add bdrv_dirname()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Alberto Garcia <berto@igalia.com>, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--l2ori9q1iPeojCV1xwmjcpKSgkj09sAdJ
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Alberto Garcia <berto@igalia.com>,
 Kevin Wolf <kwolf@redhat.com>
Message-ID: <394e0884-c0ea-b084-16d4-bf7ae86f9b84@redhat.com>
Subject: Re: [PATCH v4 10/25] block: Add bdrv_dirname()
References: <20170111181432.18868-1-mreitz@redhat.com>
 <20170116204921.31578-3-mreitz@redhat.com>
 <0aa10ac5-84cb-f750-ce5e-cb6132ebbc60@redhat.com>
In-Reply-To: <0aa10ac5-84cb-f750-ce5e-cb6132ebbc60@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 17.01.2017 00:02, Eric Blake wrote:
> On 01/16/2017 02:49 PM, Max Reitz wrote:
>> This function may be implemented by block drivers to derive a director=
y
>> name from a BDS. Concatenating this g_free()-able string with a relati=
ve
>> filename must result in a valid (not necessarily existing) filename, s=
o
>> this is a function that should generally be not implemented by format
>> drivers, because this is protocol-specific.
>>
>> If a BDS's driver does not implement this function, bdrv_dirname() wil=
l
>> fall through to the BDS's file if it exists. If it does not, the
>> exact_filename field will be used to generate a directory name.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  include/block/block.h     |  1 +
>>  include/block/block_int.h |  1 +
>>  block.c                   | 26 ++++++++++++++++++++++++++
>>  3 files changed, 28 insertions(+)
>=20
>> +++ b/include/block/block_int.h
>> @@ -130,6 +130,7 @@ struct BlockDriver {
>>      int (*bdrv_make_empty)(BlockDriverState *bs);
>> =20
>>      void (*bdrv_refresh_filename)(BlockDriverState *bs, QDict *option=
s);
>> +    char *(*bdrv_dirname)(BlockDriverState *bs, Error **errp);
>=20
> I know we've been lousy at documentation in the past, but should we
> start doing a better job of documenting the contract as we add new
> callbacks, rather than just the commit messages?

Good point, I'll add a comment.

> Based on existing practice, though, I'm okay with:
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks for reviewing!

Max


--l2ori9q1iPeojCV1xwmjcpKSgkj09sAdJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlh/brwSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ABCYH/1XNpDuxIEkn0GgK4SIFnLlumrU4kiND
R7KusDAC6gzgHkC1jMK0HNce/FbXPkoQXHCs2qTi4L+jDcSyybPo24rSVgDxqMHk
MbsIn4Wc/nmZ++WbyHi1YhH2pxEEWezg5Oxda708eFDIp2NsyST0MeRY3D6S0yJy
ZBiSTR0BAApuhXz5/2PqyhtFSuzkiIkl2HNOA0mm5LYmnPzGup40buqJWlrKJ1Eh
wwtS4kjQVB2QW5Cla5DNV4y6LHoR+/tU3TLzSj8Lc/+IxZHHkv9SQjKKwmUY5j85
GbpWrlzoYbrE7vSNht+lD69uSG0naYNBdOGlp9py/KzNYvHeVh4GqbQ=
=lcPt
-----END PGP SIGNATURE-----

--l2ori9q1iPeojCV1xwmjcpKSgkj09sAdJ--

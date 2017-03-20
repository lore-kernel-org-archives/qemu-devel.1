Received: from eggs.gnu.org ([2001:4830:134:3::10]:59295)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cpz2X-00089c-83
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 11:16:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cpz2W-00006c-7t
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 11:16:09 -0400
References: <20170313214001.26339-1-mreitz@redhat.com>
	<20170313214117.27350-5-mreitz@redhat.com>
	<20170320112900.GN17887@stefanha-x1.localdomain>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <ee54e17a-a2dc-ca8a-ebe2-ebda8a283245@redhat.com>
Date: Mon, 20 Mar 2017 16:15:59 +0100
MIME-Version: 1.0
In-Reply-To: <20170320112900.GN17887@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="8no0dhR9KRFFV9jVr84TvgVBvTDRMXPPI"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH for-2.10 14/16] block/qcow2:
 falloc/full preallocating growth
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
--8no0dhR9KRFFV9jVr84TvgVBvTDRMXPPI
From: Max Reitz <mreitz@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 qemu-devel@nongnu.org
Message-ID: <ee54e17a-a2dc-ca8a-ebe2-ebda8a283245@redhat.com>
Subject: Re: [Qemu-block] [PATCH for-2.10 14/16] block/qcow2: falloc/full
 preallocating growth
References: <20170313214001.26339-1-mreitz@redhat.com>
 <20170313214117.27350-5-mreitz@redhat.com>
 <20170320112900.GN17887@stefanha-x1.localdomain>
In-Reply-To: <20170320112900.GN17887@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 20.03.2017 12:29, Stefan Hajnoczi wrote:
> On Mon, Mar 13, 2017 at 10:41:15PM +0100, Max Reitz wrote:
>> Implement the preallocation modes falloc and full for growing qcow2
>> images.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  block/qcow2.c | 36 +++++++++++++++++++++++++++++++++++-
>>  1 file changed, 35 insertions(+), 1 deletion(-)
>>
>> diff --git a/block/qcow2.c b/block/qcow2.c
>> index 80fb815b15..b6b08d70da 100644
>> --- a/block/qcow2.c
>> +++ b/block/qcow2.c
>> @@ -2604,7 +2604,9 @@ static int qcow2_truncate(BlockDriverState *bs, =
int64_t offset,
>>      int64_t new_l1_size;
>>      int ret;
>> =20
>> -    if (prealloc !=3D PREALLOC_MODE_OFF && prealloc !=3D PREALLOC_MOD=
E_METADATA) {
>> +    if (prealloc !=3D PREALLOC_MODE_OFF && prealloc !=3D PREALLOC_MOD=
E_METADATA &&
>> +        prealloc !=3D PREALLOC_MODE_FALLOC && prealloc !=3D PREALLOC_=
MODE_FULL)
>=20
> Now all cases are covered so this if statement can be dropped.  If you
> are worried about new preallocation modes being added in the future the=
n
> the error_setg() can be moved into the switch statement's default case.=


No, because the switch comes after we have already grown the L1 table.
That wouldn't be so nice.

Max


--8no0dhR9KRFFV9jVr84TvgVBvTDRMXPPI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAljP8i8SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AHUAH/3nn2oQSNT8tSzIgyr+RJlVSCgW8a2z2
W3/6Wzta8/2SoGYxWv0k536whmOaT7Ct3ITQ9EQ8czpXlKA2C2eu8nsJDPc4/3NL
mI/nI6uUqxbxRQoDYcjhSsKCvZpDEJi19asIxcRvSBl+ogSztv7mXm5zy4WJOcWY
kXaHQR/LJywkRI8TDL5+49nbneRknu9BDk2zbpuX3VhSBh8+ziID3ck/hKPUk9KF
iV1ihetk1faLfxhZdNw8YFGrMh3WhKbfhZI+EGIj9EleZ1C6uQJMjsdWJqU630Mu
UXVN85tCN4fpLshjvztfpjtu2A0Pt8eZa9KaCXreI0Fvd+MAxLeJQrg=
=L18B
-----END PGP SIGNATURE-----

--8no0dhR9KRFFV9jVr84TvgVBvTDRMXPPI--

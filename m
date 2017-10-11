Received: from eggs.gnu.org ([2001:4830:134:3::10]:56944)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1e2FTF-0003wU-Be
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 07:46:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1e2FTE-00071Q-Kh
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 07:46:41 -0400
References: <20170913181910.29688-1-mreitz@redhat.com>
	<20170913181910.29688-9-mreitz@redhat.com>
	<20171010092727.GE4177@dhcp-200-186.str.redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <d44f52ab-5068-d81d-392e-c8e559cbbf54@redhat.com>
Date: Wed, 11 Oct 2017 13:46:22 +0200
MIME-Version: 1.0
In-Reply-To: <20171010092727.GE4177@dhcp-200-186.str.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="uqxUG4SCnAHXfNt9O4LRr6wfv13muSEN8"
Subject: Re: [Qemu-devel] [PATCH 08/18] block/mirror: Use source as a
 BdrvChild
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uqxUG4SCnAHXfNt9O4LRr6wfv13muSEN8
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Fam Zheng
 <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 John Snow <jsnow@redhat.com>
Message-ID: <d44f52ab-5068-d81d-392e-c8e559cbbf54@redhat.com>
Subject: Re: [PATCH 08/18] block/mirror: Use source as a BdrvChild
References: <20170913181910.29688-1-mreitz@redhat.com>
 <20170913181910.29688-9-mreitz@redhat.com>
 <20171010092727.GE4177@dhcp-200-186.str.redhat.com>
In-Reply-To: <20171010092727.GE4177@dhcp-200-186.str.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-10-10 11:27, Kevin Wolf wrote:
> Am 13.09.2017 um 20:19 hat Max Reitz geschrieben:
>> With this, the mirror_top_bs is no longer just a technically required
>> node in the BDS graph but actually represents the block job operation.=

>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  block/mirror.c | 18 ++++++++++--------
>>  1 file changed, 10 insertions(+), 8 deletions(-)
>>
>> diff --git a/block/mirror.c b/block/mirror.c
>> index 2ece38094d..9df4157511 100644
>> --- a/block/mirror.c
>> +++ b/block/mirror.c
>> @@ -43,8 +43,8 @@ typedef struct MirrorBlockJob {
>>      RateLimit limit;
>>      BlockBackend *target;
>>      BlockDriverState *mirror_top_bs;
>> -    BlockDriverState *source;
>>      BlockDriverState *base;
>> +    BdrvChild *source;
>=20
> Is it actually useful to store source seperately when we already have
> mirror_top_bs->backing?

I'll take a look whether it is, and if it isn't, I'll probably add that
as a separate patch (to keep this one as simple as it is).

I imagine it is not, right.

Max


--uqxUG4SCnAHXfNt9O4LRr6wfv13muSEN8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlneBI4SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AuAUH/jAggLGTquP3RquSbABnpfRtl55wuKsz
o4DWrnYbAW3WvH0piVv9rEGEtRcw6449l7dXAeOt6T45tUIPtg0n5c/BKNySytlk
w0XfvqASAWcpbHvs2gMiykrqiCA5Jri252GvemguWt09rt/DdHTHIlLS1Y/yA0r4
zeYXgnA4/iADvmxxG88mLVHTQCLlqC3M+MqNKf/9669NiY4cAdiJKIyltTbV+Oxt
1gs4FoLCQpjazEXvwEeiq42KdgNPm+x1BVlBNnKFW2QM9w0hoOfQo430rPlSIy38
67L2tmuGYwSQUbj9gvhbvl3jr0Yd9AUHxYrpxSTK8GBTpCSWNIKUcBo=
=9wjg
-----END PGP SIGNATURE-----

--uqxUG4SCnAHXfNt9O4LRr6wfv13muSEN8--

Received: from eggs.gnu.org ([2001:4830:134:3::10]:55490)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cYhJN-00060u-90
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 17:54:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cYhJM-0002Bl-Gh
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 17:54:05 -0500
References: <20170123121036.4823-1-vsementsov@virtuozzo.com>
	<20170123121036.4823-8-vsementsov@virtuozzo.com>
	<bf9c6aae-2aa6-bfe2-8856-67e8b13ad58d@redhat.com>
	<6d98fdb6-6043-8805-6df7-a2a03a7925da@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <fdb6018d-5ad7-4ca0-59e6-3890ba67dde4@redhat.com>
Date: Tue, 31 Jan 2017 23:53:54 +0100
MIME-Version: 1.0
In-Reply-To: <6d98fdb6-6043-8805-6df7-a2a03a7925da@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="OartD9q8IErNH9tE6isVl93ae3rOuuNQM"
Subject: Re: [Qemu-devel] [PATCH 07/24] qcow2: add bitmaps extension
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OartD9q8IErNH9tE6isVl93ae3rOuuNQM
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com,
 famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com
Message-ID: <fdb6018d-5ad7-4ca0-59e6-3890ba67dde4@redhat.com>
Subject: Re: [PATCH 07/24] qcow2: add bitmaps extension
References: <20170123121036.4823-1-vsementsov@virtuozzo.com>
 <20170123121036.4823-8-vsementsov@virtuozzo.com>
 <bf9c6aae-2aa6-bfe2-8856-67e8b13ad58d@redhat.com>
 <6d98fdb6-6043-8805-6df7-a2a03a7925da@virtuozzo.com>
In-Reply-To: <6d98fdb6-6043-8805-6df7-a2a03a7925da@virtuozzo.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 30.01.2017 08:21, Vladimir Sementsov-Ogievskiy wrote:
> 29.01.2017 00:29, Max Reitz wrote:
>> On 23.01.2017 13:10, Vladimir Sementsov-Ogievskiy wrote:
>>> Add bitmap extension as specified in docs/specs/qcow2.txt.
>>> For now, just mirror extension header into Qcow2 state and check
>>> constraints.
>>>
>>> For now, disable image resize if it has bitmaps. It will be fixed lat=
er.
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com=
>
>>> ---
>>>   block/qcow2.c | 119
>>> +++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>>>   block/qcow2.h |  24 ++++++++++++
>>>   2 files changed, 141 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/block/qcow2.c b/block/qcow2.c
>>> index 96fb8a8f16..a8835988c7 100644
>>> --- a/block/qcow2.c
>>> +++ b/block/qcow2.c
>> [...]
>>
>>> @@ -185,6 +265,15 @@ static int
>>> qcow2_read_extensions(BlockDriverState *bs, uint64_t start_offset,
>>>           offset +=3D ((ext.len + 7) & ~7);
>>>       }
>>>   +    if (need_update && !bdrv_is_root_node(bs) &&
>>> +        !(bdrv_get_flags(bs) & BDRV_O_INACTIVE))
>>> +    {
>>> +        ret =3D qcow2_update_header(bs);
>> Good idea, but qcow2_read_extensions() can be called pretty early in
>> qcow2_open(). Therefore, some fields in the BDRVQcow2State are not
>> necessarily set already.
>>
>> For instance, it is always called before s->snapshots_offset and
>> s->nb_snapshots are set. Thus, this will effectively always discard al=
l
>> snapshots.
>>
>> Max
>>
>=20
> So, I need to move need_update to qcow2_read_extensions parameters as
> 'bool *' and handle it later, in the end of qcow2_open. Ok?

Yes, that sounds reasonable.

Max


--OartD9q8IErNH9tE6isVl93ae3rOuuNQM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAliRFYISHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AlLcH/3/EhE6ZfRYBY18J/rmZdiH1bWKXJe+W
XnvDrDli3pixGh5CPUMPHbV/Ih9eHYwOfYRugrrBRM0XEoZTi70shM6gKjiINlkH
NXCrp8bjv3oB6dVK2aw0mVfnPjV1nTqLBwHsMabKijVZo9TPg1jlgPaDGcdXSei8
d4thoAbAz9zyh5RKlDpunz4BJ8+T5Ie9mTXtbDWDkc1TZStWEkAeywxqHRUK/M3G
KT63Co6FahX2T5asV2ckh4lf7JpJN0OOjIrXa5uS8NeXitlqXfTDzBbZoIcYNQqf
tmD5/dSk2h6OZ2ZUfxoCJkUqXTdIUff+Fzv3bVw8DVAlgl+xVs0zDDE=
=2U26
-----END PGP SIGNATURE-----

--OartD9q8IErNH9tE6isVl93ae3rOuuNQM--

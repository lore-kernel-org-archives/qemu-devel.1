Received: from eggs.gnu.org ([2001:4830:134:3::10]:54521)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cFj2K-0002Ll-F9
	for qemu-devel@nongnu.org; Sat, 10 Dec 2016 09:54:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cFj2J-0003Lr-KA
	for qemu-devel@nongnu.org; Sat, 10 Dec 2016 09:54:04 -0500
References: <1479835586-74394-1-git-send-email-vsementsov@virtuozzo.com>
	<1479835586-74394-14-git-send-email-vsementsov@virtuozzo.com>
	<919ac9f1-cc7a-8679-c9f4-1da26bc27bf4@redhat.com>
	<74e1aec8-b604-fb86-48fa-70a16ae29a0c@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <30e3fc02-f114-6a6b-62e2-fdee668722cc@redhat.com>
Date: Sat, 10 Dec 2016 15:53:51 +0100
MIME-Version: 1.0
In-Reply-To: <74e1aec8-b604-fb86-48fa-70a16ae29a0c@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="XD3DFv2Tju2R0SSprkdSe77p22obTJE9Q"
Subject: Re: [Qemu-devel] [PATCH 13/21] qcow2: add
 .bdrv_store_persistent_dirty_bitmaps()
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
--XD3DFv2Tju2R0SSprkdSe77p22obTJE9Q
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com,
 famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com
Message-ID: <30e3fc02-f114-6a6b-62e2-fdee668722cc@redhat.com>
Subject: Re: [PATCH 13/21] qcow2: add .bdrv_store_persistent_dirty_bitmaps()
References: <1479835586-74394-1-git-send-email-vsementsov@virtuozzo.com>
 <1479835586-74394-14-git-send-email-vsementsov@virtuozzo.com>
 <919ac9f1-cc7a-8679-c9f4-1da26bc27bf4@redhat.com>
 <74e1aec8-b604-fb86-48fa-70a16ae29a0c@virtuozzo.com>
In-Reply-To: <74e1aec8-b604-fb86-48fa-70a16ae29a0c@virtuozzo.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 09.12.2016 18:55, Vladimir Sementsov-Ogievskiy wrote:
> 09.12.2016 20:05, Max Reitz wrote:
>> On 22.11.2016 18:26, Vladimir Sementsov-Ogievskiy wrote:
>>> Realize block bitmap storing interface, to allow qcow2 images store
>>> persistent bitmaps.
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com=
>
>>> ---
>>>   block/qcow2-bitmap.c | 451
>>> +++++++++++++++++++++++++++++++++++++++++++++++++++
>>>   block/qcow2.c        |   1 +
>>>   block/qcow2.h        |   1 +
>>>   3 files changed, 453 insertions(+)
>>>
>>> diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
>>> index 81be1ca..a975388 100644
>>> --- a/block/qcow2-bitmap.c
>=20
> [...]
>=20
>>> +            return;
>>> +        }
>>> +    }
>>> +
>>> +    /* check constraints and names */
>>> +    for (bitmap =3D bdrv_dirty_bitmap_next(bs, NULL); bitmap !=3D NU=
LL;
>>> +            bitmap =3D bdrv_dirty_bitmap_next(bs, bitmap)) {
>> Alignment to the opening parenthesis, please.
>=20
> Hmm.. without an alignment it is not so simple to distinguish for-loop
> header from its body.

I know, and it's even worse for "if". That is why I usually put the
opening { on a new line if I have to spread an if/while/for header over
multiple lines.

The usual convention for qemu code is to align at an opening parenthesis
if there is one.

Admittedly, the reasoning I gave for changing checkpatch.pl to accept
opening { on a new line in certain cases was that:

(1) We never codified exactly what to allow for multi-line if/while/for
    conditions.
(2) It was existing practice.

(1) applies in your case also; we don't have any explicitly written-out
convention for alignment of wrapped lines. (2) is more difficult, but
there are indeed a handful of cases where lines are wrapped and not
aligned to the opening parenthesis but just indented by an additional
four spaces...

So I guess since I'm insisting on putting the opening { on a new line
for multi-line conditions, you are allowed to indent the consecutive
lines by an additional level. ;-)

(It *is* against existing convention, but I'm not in a position to argue.=
)

> [...]
>=20
>> [1] What about bitmaps that have BME_FLAG_IN_USE set but do not have a=

>> corresponding BDS bitmap?
>>
>> If such a bitmap does not have BME_FLAG_AUTO set, we didn't set the
>> flag, so we should keep it unchanged. That's what this function is
>> currently doing.
>>
>> However, if such a bitmap does have BME_FLAG_AUTO set, it was definite=
ly
>> us who set the IN_USE flag (because otherwise we would have aborted
>> loading the bitmaps, and thus also aborted bdrv_open_common()).
>> Therefore, the only explanation is that the bitmap was deleted in the
>> meantime, and that means we should also delete it in the qcow2 file.
>=20
> Right. Or, alternatively, these bitmaps may be deleted on corresponding=

> BdrvDirtyBitmap deletion.

Right, that would work, too.

Max


--XD3DFv2Tju2R0SSprkdSe77p22obTJE9Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlhMFv8SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AABEH/RqI2MWnxpH5Y1AIyioz4qqiJUUtJ4k/
3FN1p+oWCYPqwhmlDbKA2iQ9QiQL2eNVSlVrHGSycRAkdEWBTg0HfIC2viglZoFG
EOnoqxrJayDTHGLjPOcvzIOnkvf6qBCs/x7PEIHtUh8FgeR+9P+8Keu+jrprWnnn
8iGMABdR9UTtSu0n0OvVZKgavnRChJHGcxNyKa+1HTP5mN6ZwTe12fs2z9kuL7yb
I9Qn5tf4QWRlr6M/6cQp8l42toFOp2p7t80xyp5WGgOjnelGHQRnPXIgniWXupP9
qTCFbW7yU3AvzdO88D2oSnuz2jtLTIRmx8YpOMNVqqZ8Hx48K3kCnDw=
=J2KV
-----END PGP SIGNATURE-----

--XD3DFv2Tju2R0SSprkdSe77p22obTJE9Q--

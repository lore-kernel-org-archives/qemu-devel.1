Received: from eggs.gnu.org ([209.51.188.92]:35701)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hB1Ev-0002eG-HE
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 14:00:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hB1Et-0002C7-Fx
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 14:00:57 -0400
References: <1549974951-731285-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<5c72aad4-d1bc-7241-a972-32dd07ef23b0@virtuozzo.com>
	<efdc687a-239e-3f30-c2d8-e46a47029496@redhat.com>
	<7414a532-3005-5cfe-6f29-77cf95eeb4d2@virtuozzo.com>
	<7dc5a22b-88fe-883d-0dd8-1101d67891f5@redhat.com>
	<1205dd10-25a4-ab53-d7ab-162e257cbba7@virtuozzo.com>
	<dc493087-f0e8-91d1-69fc-ff63e5ec345d@redhat.com>
	<fae8b60f-a55f-2998-e136-0925ae2d737c@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <4c4be643-357e-14ac-f2c6-0097276c704e@redhat.com>
Date: Mon, 1 Apr 2019 20:00:43 +0200
MIME-Version: 1.0
In-Reply-To: <fae8b60f-a55f-2998-e136-0925ae2d737c@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="rBqF9W4f4nmfSZV5ylTOWXD1vBmDONnla"
Subject: Re: [Qemu-devel] [PATCH] Discard old bitmap directories in QCOW2
 image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, Denis Lunev <den@virtuozzo.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "kwolf@redhat.com" <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rBqF9W4f4nmfSZV5ylTOWXD1vBmDONnla
From: Max Reitz <mreitz@redhat.com>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 Denis Lunev <den@virtuozzo.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "kwolf@redhat.com" <kwolf@redhat.com>
Message-ID: <4c4be643-357e-14ac-f2c6-0097276c704e@redhat.com>
Subject: Re: [PATCH] Discard old bitmap directories in QCOW2 image
References: <1549974951-731285-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <5c72aad4-d1bc-7241-a972-32dd07ef23b0@virtuozzo.com>
 <efdc687a-239e-3f30-c2d8-e46a47029496@redhat.com>
 <7414a532-3005-5cfe-6f29-77cf95eeb4d2@virtuozzo.com>
 <7dc5a22b-88fe-883d-0dd8-1101d67891f5@redhat.com>
 <1205dd10-25a4-ab53-d7ab-162e257cbba7@virtuozzo.com>
 <dc493087-f0e8-91d1-69fc-ff63e5ec345d@redhat.com>
 <fae8b60f-a55f-2998-e136-0925ae2d737c@virtuozzo.com>
In-Reply-To: <fae8b60f-a55f-2998-e136-0925ae2d737c@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 27.02.19 16:48, Andrey Shinkevich wrote:
>=20
>=20
> On 27/02/2019 18:22, Max Reitz wrote:
>> On 27.02.19 16:15, Andrey Shinkevich wrote:
>>>
>>>
>>> On 27/02/2019 16:25, Max Reitz wrote:
>>>> On 27.02.19 14:16, Denis Lunev wrote:
>>>>> On 2/27/19 4:00 PM, Max Reitz wrote:
>>>>>> On 18.02.19 16:36, Vladimir Sementsov-Ogievskiy wrote:
>>>>>>> 12.02.2019 15:35, Andrey Shinkevich wrote:
>>>>>>>> Clean QCOW2 image from bitmap obsolete directory when a new one
>>>>>>>> is allocated and stored. It slows down the image growth a little=
 bit.
>>>>>>>> The flag QCOW2_DISCARD_ALWAYS allows a call to raw_co_pdiscard()=

>>>>>>>> that does the actual cleaning of the image on disk.
>>>>>>>> With the flag QCOW2_DISCARD_OTHER, a reference count of the clus=
ter
>>>>>>>> is updated only.
>>>>>>>>
>>>>>>>> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.co=
m>
>>>>>>> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.c=
om>
>>>>>>>
>>>>>>> side question: should not we change discard_passthrough[QCOW2_DIS=
CARD_OTHER] to
>>>>>>> true or at least flags&BDRV_O_UNMAP by default? What is the reaso=
n of not discarding
>>>>>>> things in qcow2-cluster?
>>>>>> As far as I remember the reason is that whenever you clean up some=
thing
>>>>>> its cluster is probably going to be reused rather soon.  So cleani=
ng up
>>>>>> takes longer, repopulating that cluster takes longer, and you save=
 only
>>>>>> rather little space.
>>>>>>
>>>>>> This is also why I don't know whether this patch makes much sense.=

>>>>>>
>>>>>> Max
>>>>>>
>>>>> This depands upon the amount of actually free clusters in the image=
=2E
>>>>> If there a lot of them at the moment, this one could be refilled
>>>>> any time later on.
>>>>
>>>> Well, it's a trade-off.  For small structures like the bitmap direct=
ory,
>>>> I don't see the point in forcefully unmapping them.  We don't do it =
for
>>>> the old L1 table either when that has to be resized.
>>>>
>>>> Discarding a whole bitmap (like in clear_bitmap_table()) is somethin=
g
>>>> else, though.  So I was too quick to dismiss the whole patch; parts =
of
>>>> it do make sense.
>>>>
>>>> For bitmap tables...  I don't know exactly.  I don't think a bitmap
>>>> table is ever going to be larger than the L1 table, so it should
>>>> probably be handled the same way -- which is to keep QCOW2_DISCARD_O=
THER.
>>>>
>>>> Max
>>>>
>>> Yes, Max. All what you wrote about do make the sense.
>>> The reason behind the proposition to discard the obsolete bitmap
>>> directories in the image is that it makes debugging of the iotests
>>> easier for a developer. Otherwise, lots of irrelevant symbolic
>>> information in the image forces to track which one is valid.
>>> Particularly, I locate the byte that designates the bitmap flags to s=
ee
>>> if the flag 'in-use' is not set. And I do that for every single bitma=
p
>>> directory in the image.
>>> Again, cleaning up the obsolete bitmap directories in the image serve=
s
>>> for the convenience of debugging. What do you think about it?
>>
>> I don't think convenience of debugging is a good reason to implement
>> something that is probably worse behavior when not debugging.  Of
>> course, if the changed behavior is neither worse nor better, then we
>> might as well go for it if it eases debugging.  But I think it is a bi=
t
>> worse.
>>
>> Also, if you want to debug images you have created yourself (or at lea=
st
>> are used by VMs you have control over), you can simply set
>> pass-discard-other=3Don.
>>
>> Max
>>
> Thank you for your answer. So, I will leave the QCOW2_DISCARD_ALWAYS
> in the clear_bitmap_table() only and will prepare the next version of
> the patch, shall I?

(Sorry for the late reply, I was on vacation :-/)

Sounds good to me, yes.

Max


--rBqF9W4f4nmfSZV5ylTOWXD1vBmDONnla
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlyiUcsACgkQ9AfbAGHV
z0DtiAf9FREGWUTxp6Z8YjcYUQUPg+oRP2x8nGK4Asu+iiti2jJsInAQls8JioG6
60WPQ3yfcIk3rz00bE6JK23KyqpNCNW8D2TRwz4gaL8rixxfYswkHaxdes9Z9pFN
dTID+QZyzVY9524T+o7f35TDZ0v/tbN73lpEk1XehCHG0NCqTKWlHMJDElV6boUH
/H0VcStDjhSTeud1/6D9oi53Ygro3Qe2lInd0xmj57gJj0pt3ncFiDFVB9sdBXvp
gAQ0j+jxOjOUpw8epnMS6ZjkCKnzskh97TfRx+3zFa2milKSb4wfkpZFNdEnBitR
6onCDWTuWvDHhKXQ1wqUppw6qwl5Rg==
=/EPv
-----END PGP SIGNATURE-----

--rBqF9W4f4nmfSZV5ylTOWXD1vBmDONnla--

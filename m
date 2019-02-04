Received: from eggs.gnu.org ([209.51.188.92]:44248)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gqiBz-00037Q-8G
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 12:38:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gqiBx-0004sA-AE
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 12:37:58 -0500
References: <1548942405-760115-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<1548942405-760115-3-git-send-email-andrey.shinkevich@virtuozzo.com>
	<87pnsbxsi7.fsf@dusky.pond.sub.org>
	<3ed70b8e-f778-f942-2841-905223d3af8d@redhat.com>
	<87womjwbwj.fsf@dusky.pond.sub.org>
	<c017dbfe-f619-b626-211a-d3bdafb451aa@redhat.com>
	<877eefsnyh.fsf@dusky.pond.sub.org>
	<45148ff4-ea14-31ff-c298-4c8a349ad08b@virtuozzo.com>
	<8db32102-7daa-6b5a-8752-46727cbef106@redhat.com>
	<bed5c588-b41b-bb93-92a8-e1ffc6f4fac7@virtuozzo.com>
	<175fb7e8-eec3-8031-55c9-b859ce8f6af0@virtuozzo.com>
	<eb0487a2-a9f3-22a5-3a4a-e61902269bdb@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <dacde09a-520a-27a8-3915-ca30a0b63537@redhat.com>
Date: Mon, 4 Feb 2019 11:37:48 -0600
MIME-Version: 1.0
In-Reply-To: <eb0487a2-a9f3-22a5-3a4a-e61902269bdb@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="8RBeyg6kiRF4NJLdDCroGNfId6Attv9rX"
Subject: Re: [Qemu-devel] [PATCH v11 2/3] qemu-img info lists bitmap
 directory entries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Markus Armbruster <armbru@redhat.com>
Cc: "fam@euphon.net" <fam@euphon.net>, "kwolf@redhat.com" <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "mreitz@redhat.com" <mreitz@redhat.com>, Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8RBeyg6kiRF4NJLdDCroGNfId6Attv9rX
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Markus Armbruster <armbru@redhat.com>
Cc: "fam@euphon.net" <fam@euphon.net>, "kwolf@redhat.com" <kwolf@redhat.com>,
 Denis Lunev <den@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-ID: <dacde09a-520a-27a8-3915-ca30a0b63537@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v11 2/3] qemu-img info lists bitmap directory
 entries
References: <1548942405-760115-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1548942405-760115-3-git-send-email-andrey.shinkevich@virtuozzo.com>
 <87pnsbxsi7.fsf@dusky.pond.sub.org>
 <3ed70b8e-f778-f942-2841-905223d3af8d@redhat.com>
 <87womjwbwj.fsf@dusky.pond.sub.org>
 <c017dbfe-f619-b626-211a-d3bdafb451aa@redhat.com>
 <877eefsnyh.fsf@dusky.pond.sub.org>
 <45148ff4-ea14-31ff-c298-4c8a349ad08b@virtuozzo.com>
 <8db32102-7daa-6b5a-8752-46727cbef106@redhat.com>
 <bed5c588-b41b-bb93-92a8-e1ffc6f4fac7@virtuozzo.com>
 <175fb7e8-eec3-8031-55c9-b859ce8f6af0@virtuozzo.com>
 <eb0487a2-a9f3-22a5-3a4a-e61902269bdb@redhat.com>
In-Reply-To: <eb0487a2-a9f3-22a5-3a4a-e61902269bdb@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2/4/19 11:33 AM, Eric Blake wrote:
> On 2/4/19 10:46 AM, Vladimir Sementsov-Ogievskiy wrote:
>=20
>>>
>>> Oops, hm, I now doubt, how Andrey's patches work, if bitmap_list_load=
 function
>>> fails when unknown flags are found. So, can we really show unknown-fl=
ags,
>>> or we'll fail if there any?
>>>
>>> And if we fail (I hope we fail) on unknown flags, than we don't need =
this
>>> field :).
>>>
>>
>> But we can update bitmap_list_load, to have a flag, and show bitmaps w=
ith
>> unknown flags in qemu-img info.. And we have to somehow not fail on op=
en before
>> it. I'm very sorry that I understand it all only now :(.
>>
>> So, do we really need unknown-flags field? If yes, may be, do it as a =
next step?
>> And proceed now without them?
>=20
> Good point about not even being able to open an image with unknown flag=
s
> to be able to report on it (qemu-img check might want to be able to do
> it, but if qemu-img info refuses to open the image because of unknown
> flags, that's acceptable).  I'm good with your idea of skipping
> unknown-flags for now, and adding it in a later patch if it proves
> worthwhile.

It may also be worth an addition to iotests that intentionally corrupts
an image with persistent bitmaps to set an unknown bit, just to see how
qemu reacts to such an image.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--8RBeyg6kiRF4NJLdDCroGNfId6Attv9rX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxYeG0ACgkQp6FrSiUn
Q2oN1Af8CkLoq44PJH1yb2OhOfixDT3fu2ZBf8qd/iu/VJjvWpPD/KYI1okAvWRz
s+ybrjFkxYS8mspZJ/5LdJdQNDnr7Lw2bUXMv8XCPvP2+9qwc/588aEQFdErKAXV
KH2qvRe+M/w+53Us46Xlk537ni8xFwLJMCbY0QJrfe327tykyHjZjN2raTzL+Izj
Ov6Z5JlcwBynUY/0/EkC/s1lyBBZ4SGt2yjMNHzPijVze5j1c4Xu7+P1VtKI1YvF
u7ejRhBr/RRM3duHvKgsS9MWMc3Qo2HTjAVdADfA+5NlJb0pVNntYutJVb0yCZZ1
IwYmr8X1rfzL/wyNJgUePA0oKJnjNw==
=q/rY
-----END PGP SIGNATURE-----

--8RBeyg6kiRF4NJLdDCroGNfId6Attv9rX--

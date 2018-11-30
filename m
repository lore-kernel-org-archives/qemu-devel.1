Received: from eggs.gnu.org ([2001:4830:134:3::10]:38308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gSkGr-0007n1-SY
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 09:59:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gSkGq-0002dY-OX
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 09:59:57 -0500
References: <20181129101801.6421-1-vsementsov@virtuozzo.com>
	<20181129101801.6421-3-vsementsov@virtuozzo.com>
	<2f4c1bec-b5ca-e97f-88f9-75f3d2cb210c@redhat.com>
	<e9e07da0-0cd8-9820-642a-ab4fe227afc8@virtuozzo.com>
	<abcad6d9-2d40-15b4-9bce-964f6a3141a0@redhat.com>
	<73cb2885-3a40-6d2b-24fa-c528decdbc9b@virtuozzo.com>
	<20181130141017.GF5106@localhost.localdomain>
	<97939091-38e2-565b-7aa3-cfb9ebf239cb@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <e6a8ba59-4871-35f4-88a4-43567997e3bc@redhat.com>
Date: Fri, 30 Nov 2018 15:59:41 +0100
MIME-Version: 1.0
In-Reply-To: <97939091-38e2-565b-7aa3-cfb9ebf239cb@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="w2ChbjOBgDN4owntMhnXCBn1y7YYm753h"
Subject: Re: [Qemu-devel] [PATCH v2 2/2] iotests: simple mirror test with
 kvm on 1G image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Kevin Wolf <kwolf@redhat.com>
Cc: "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "jcody@redhat.com" <jcody@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, Denis Plotnikov <dplotnikov@virtuozzo.com>, Denis Lunev <den@virtuozzo.com>, "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--w2ChbjOBgDN4owntMhnXCBn1y7YYm753h
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Kevin Wolf <kwolf@redhat.com>
Cc: "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "jcody@redhat.com" <jcody@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 Denis Plotnikov <dplotnikov@virtuozzo.com>, Denis Lunev <den@virtuozzo.com>,
 "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>
Message-ID: <e6a8ba59-4871-35f4-88a4-43567997e3bc@redhat.com>
Subject: Re: [PATCH v2 2/2] iotests: simple mirror test with kvm on 1G image
References: <20181129101801.6421-1-vsementsov@virtuozzo.com>
 <20181129101801.6421-3-vsementsov@virtuozzo.com>
 <2f4c1bec-b5ca-e97f-88f9-75f3d2cb210c@redhat.com>
 <e9e07da0-0cd8-9820-642a-ab4fe227afc8@virtuozzo.com>
 <abcad6d9-2d40-15b4-9bce-964f6a3141a0@redhat.com>
 <73cb2885-3a40-6d2b-24fa-c528decdbc9b@virtuozzo.com>
 <20181130141017.GF5106@localhost.localdomain>
 <97939091-38e2-565b-7aa3-cfb9ebf239cb@virtuozzo.com>
In-Reply-To: <97939091-38e2-565b-7aa3-cfb9ebf239cb@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 30.11.18 15:51, Vladimir Sementsov-Ogievskiy wrote:
> 30.11.2018 17:10, Kevin Wolf wrote:
>> Am 30.11.2018 um 14:48 hat Vladimir Sementsov-Ogievskiy geschrieben:
>>> 30.11.2018 16:13, Max Reitz wrote:
>>>> On 30.11.18 14:06, Vladimir Sementsov-Ogievskiy wrote:
>>>>> 30.11.2018 15:30, Max Reitz wrote:
>>>>>> On 29.11.18 11:18, Vladimir Sementsov-Ogievskiy wrote:
>>>>>>> This test is broken without previous commit fixing dead-lock in m=
irror.
>>>>>>>
>>>>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy<vsementsov@virtuozzo.=
com>
>>>>>>> ---
>>>>>>>     tests/qemu-iotests/235     | 59 +++++++++++++++++++++++++++++=
+++++++++
>>>>>>>     tests/qemu-iotests/235.out |  1 +
>>>>>>>     tests/qemu-iotests/group   |  1 +
>>>>>>>     3 files changed, 61 insertions(+)
>>>>>>>     create mode 100755 tests/qemu-iotests/235
>>>>>>>     create mode 100644 tests/qemu-iotests/235.out
>>>>>> I'll get to the first patch in a second, but first a suggestion fo=
r this
>>>>>> patch: I think it's not so good to use 2 GB of space for a test (1=
 GB
>>>>>> for the source, 1 GB for the target).  So I tried my luck and foun=
d that
>>>>>> the test works, too, if you just use preallocation=3Dmetadata for =
the
>>>>>> source (instead of actually writing data) and blockdev-mirror'ing =
the
>>>>>> data to a throttled null-co device.
>>>>>
>>>>> Hmm, so parsing metadata is enough for qcow2 to yield on write, yes=
?
>>>>
>>>> Apparently so.  If you can confirm that applying those changes to th=
e
>>>> test still make it work (i.e., fail before patch 1, pass afterwards)=
,
>>>> then I think it is just as good.
>>>
>>> Ok, I've checked that your changes works for me.
>>>
>>> hm, but we write to null, so, yield on write comes from throttling, h=
owever,
>>> without preallocation=3Dmetadata, it don't work.., do you know, why w=
e need
>>> preallocation to reproduce?
>>
>> If I should take a guess, probably because mirror only copies allocate=
d
>> clusters?
>>
>> Kevin
>>
>=20
> hm, so, what preallocation=3Dmetadata does? I thought, it preallocates =
tables, but all qcow2 clusters would be unallocated..

No, it initializes all metadata structures (i.e., L2 tables) so they
point to data clusters; which is why you cannot use it with backing
files.  It's just that the data clusters are not written.

It might make sense to use preallocated zero clusters in qcow2 v3; but
then writing to the image would cause COWs again, so there wouldn't be
too much benefit over just not preallocating.

Max


--w2ChbjOBgDN4owntMhnXCBn1y7YYm753h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlwBUF0ACgkQ9AfbAGHV
z0AYdQf/RnwYXiPC6+kGx75TSD79aBE9u075CWySKwRrdw13Z2Rdu3FTXO4PmAUq
8kuBogsfKY7kv4BUjomvQRSj/tyZOBo7pgS970SHGeM6Q5OlUgXWR3vMzhXIv9ZN
t6cJt987p42Juv9Mwe7whIjbwiy6QwK3CQ57hG9ja3eiiDxSXiskZ7LbQqqtVk0F
cdW8TLeeQiZ2gkZKhZval4eR4/zrMdrl7C3jnoN0yqfsuTadewl/kpL6mKUBnKo1
jrTspzDzlNr9bV0ARFhO3TTgayEgxeanX87kw2J5/Tbsa24qqg+SHgfBGMzg9GdL
YbgdX7MeUIJ5mbAVCQKyznIpy7Zqww==
=JWx4
-----END PGP SIGNATURE-----

--w2ChbjOBgDN4owntMhnXCBn1y7YYm753h--

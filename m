Received: from eggs.gnu.org ([2001:4830:134:3::10]:55134)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1f6yrR-0007TS-Pb
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 09:35:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1f6yrQ-0000CK-Ry
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 09:35:29 -0400
References: <20180330161040.350271-1-vsementsov@virtuozzo.com>
	<b6a499bc-b5c6-7c35-e916-d63861f0c0c5@redhat.com>
	<3d0d9016-276f-c1c6-eb7e-ef78c0744f01@redhat.com>
	<47c416af-4b8e-db9a-4b4b-9b0eb060b4ff@virtuozzo.com>
	<ec4ee8f5-7a47-2e18-1fe3-d4f3859bc8ce@virtuozzo.com>
	<90b289f4-d976-1fb7-57e2-aa02d00947d1@virtuozzo.com>
	<e8cc4fbe-4b0e-4ab8-64ff-0c12a080e09e@redhat.com>
	<44329c83-20d8-0924-ebf3-249e5777a1d5@virtuozzo.com>
	<0ad6b9fc-59fd-3c32-43d3-1a4d433d9154@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <99388cf8-8e8c-17f0-fb73-09b0f8fe1b60@redhat.com>
Date: Fri, 13 Apr 2018 15:35:10 +0200
MIME-Version: 1.0
In-Reply-To: <0ad6b9fc-59fd-3c32-43d3-1a4d433d9154@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] iotests: fix 169
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, den@openvz.org

On 2018-04-12 11:09, Vladimir Sementsov-Ogievskiy wrote:
> 12.04.2018 11:34, Vladimir Sementsov-Ogievskiy wrote:
>> 11.04.2018 19:11, Max Reitz wrote:
>>> On 2018-04-11 15:05, Vladimir Sementsov-Ogievskiy wrote:
>>>
>>> [...]
>>>
>>>> Hmm, first type? I'm now not sure about, did I really see sha256
>>>> mismatch, or something like this (should be error, but found bitmap)=
:
>>>>
>>>> --- /work/src/qemu/up-169/tests/qemu-iotests/169.out 2018-04-11
>>>> 15:35:10.055027392 +0300
>>>> +++ /work/src/qemu/up-169/tests/qemu-iotests/169.out.bad 2018-04-11
>>>> 15:58:09.300450045 +0300
>>>> @@ -1,5 +1,20 @@
>>>> -........
>>>> +F.......
>>>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>> +FAIL: test__not_persistent__migbitmap__offline
>>>> (__main__.TestDirtyBitmapMigration)
>>>> +methodcaller(name, ...) --> methodcaller object
>>>> +-------------------------------------------------------------------=
---
>>>> +Traceback (most recent call last):
>>>> +=C2=A0 File "169", line 136, in do_test_migration
>>>> +=C2=A0=C2=A0=C2=A0 self.check_bitmap(self.vm_b, sha256 if persisten=
t else False)
>>>> +=C2=A0 File "169", line 77, in check_bitmap
>>>> +=C2=A0=C2=A0=C2=A0 "Dirty bitmap 'bitmap0' not found");
>>>> +=C2=A0 File "/work/src/qemu/up-169/tests/qemu-iotests/iotests.py", =
line
>>>> 389,
>>>> in assert_qmp
>>>> +=C2=A0=C2=A0=C2=A0 result =3D self.dictpath(d, path)
>>>> +=C2=A0 File "/work/src/qemu/up-169/tests/qemu-iotests/iotests.py", =
line
>>>> 348,
>>>> in dictpath
>>>> +=C2=A0=C2=A0=C2=A0 self.fail('failed path traversal for "%s" in "%s=
"' % (path,
>>>> str(d)))
>>>> +AssertionError: failed path traversal for "error/desc" in "{u'retur=
n':
>>>> {u'sha256':
>>>> u'01d2ebedcb8f549a2547dbf8e231c410e3e747a9479e98909fc936e0035cf8b1'}=
}"
>>>>
>>>>
>>>> Max, did you really seed sha256 mismatch or only something like this=
?
>>> I'm pretty sure I did see mismatches.
>>
>> hm, may be it possible too, because of not waiting for RESUME in this
>> case, we can request sha256 in the intermediate state of bitmap loadin=
g
>=20
> no. if you see mismatch on first check after migration, then it is afte=
r
> RESUME event, so it means, migrated broken bitmap, it's a bug..
>=20
> if you see mismatch on second check - after vm_b stop/start, this means
> that it is a persistent case, so incoming migration should fail, and
> bitmap is loaded from file, but how it can mismatch? persistance bug?

Well, I'll tell you if I ever see it again.  If not... Then I guess
we're fine.

Max

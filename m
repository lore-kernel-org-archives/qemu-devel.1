Received: from eggs.gnu.org ([2001:4830:134:3::10]:37531)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1g7nHC-0006ho-By
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 15:57:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1g7nH7-0002pj-Ic
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 15:57:39 -0400
References: <20181002233314.30159-1-jsnow@redhat.com>
	<79b55f31-00a9-273f-e004-6c097a2f1542@virtuozzo.com>
	<ee24dc7f-7685-aaae-3315-60d66284bb23@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <a0d3a14f-610f-c326-004b-336f49c98f39@redhat.com>
Date: Wed, 3 Oct 2018 15:57:11 -0400
MIME-Version: 1.0
In-Reply-To: <ee24dc7f-7685-aaae-3315-60d66284bb23@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] bitmap: Update count after a merge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>
Cc: "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Fam Zheng <famz@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>



On 10/03/2018 10:49 AM, Eric Blake wrote:
> On 10/3/18 9:32 AM, Vladimir Sementsov-Ogievskiy wrote:
>> 03.10.2018 02:33, John Snow wrote:
>>> From: Eric Blake <eblake@redhat.com>
>>>
>>> We need an accurate count of the number of bits set in a bitmap
>>> after a merge. In particular, since the merge operation short-circuit=
s
>>> a merge from an empty source, if you have bitmaps A, B, and C where
>>> B started empty, then merge C into B, and B into A, an inaccurate
>>> count meant that A did not get the contents of C.
>>>
>>> In the worst case, we may falsely regard the bitmap as empty when
>>> it has had new writes merged into it.
>>>
>>> Fixes: be58721db
>>> CC: qemu-stable@nongnu.org
>>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>> Signed-off-by: John Snow <jsnow@redhat.com>
>>
>> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>
>> Hm, I rememberd:
>> commit 3260cdfffbf00f33923f5f9f6bef45932d7ac28b
>> Author: Liang Li <liliangleo@didichuxing.com>
>> Date:=C2=A0=C2=A0 Wed Feb 7 11:35:49 2018 -0500
>>
>> =C2=A0 =C2=A0=C2=A0=C2=A0 hbitmap: fix missing restore count when fini=
sh deserialization
>>
>> =C2=A0 =C2=A0=C2=A0=C2=A0 The .count of HBitmap is forgot to set in fu=
nction
>> =C2=A0 =C2=A0=C2=A0=C2=A0 hbitmap_deserialize_finish, let's set it to =
the right value.
>>
>>
>> =C2=A0 =C2=A0- I always forget to update this field.. We definitely sh=
ould add some
>> generic check on it somewhere, at least in tests.
>=20
> My suggestion (in another thread) was to enhance
> x-debug-block-dirty-bitmap-sha256 to include 'count' alongside the
> checksum, to make it easier to write such tests.
>=20

I suppose this is in preference to query-block? It would make it easier.

--js

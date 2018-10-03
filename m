Received: from eggs.gnu.org ([2001:4830:134:3::10]:42991)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g7iTD-0004QR-7B
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 10:49:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g7iTC-00089W-Du
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 10:49:47 -0400
References: <20181002233314.30159-1-jsnow@redhat.com>
	<79b55f31-00a9-273f-e004-6c097a2f1542@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ee24dc7f-7685-aaae-3315-60d66284bb23@redhat.com>
Date: Wed, 3 Oct 2018 09:49:27 -0500
MIME-Version: 1.0
In-Reply-To: <79b55f31-00a9-273f-e004-6c097a2f1542@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
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
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, John Snow <jsnow@redhat.com>, "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>
Cc: "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Fam Zheng <famz@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On 10/3/18 9:32 AM, Vladimir Sementsov-Ogievskiy wrote:
> 03.10.2018 02:33, John Snow wrote:
>> From: Eric Blake <eblake@redhat.com>
>>
>> We need an accurate count of the number of bits set in a bitmap
>> after a merge. In particular, since the merge operation short-circuits
>> a merge from an empty source, if you have bitmaps A, B, and C where
>> B started empty, then merge C into B, and B into A, an inaccurate
>> count meant that A did not get the contents of C.
>>
>> In the worst case, we may falsely regard the bitmap as empty when
>> it has had new writes merged into it.
>>
>> Fixes: be58721db
>> CC: qemu-stable@nongnu.org
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>=20
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>=20
> Hm, I rememberd:
> commit 3260cdfffbf00f33923f5f9f6bef45932d7ac28b
> Author: Liang Li <liliangleo@didichuxing.com>
> Date:=C2=A0=C2=A0 Wed Feb 7 11:35:49 2018 -0500
>=20
>   =C2=A0=C2=A0=C2=A0 hbitmap: fix missing restore count when finish des=
erialization
>=20
>   =C2=A0=C2=A0=C2=A0 The .count of HBitmap is forgot to set in function
>   =C2=A0=C2=A0=C2=A0 hbitmap_deserialize_finish, let's set it to the ri=
ght value.
>=20
>=20
>   =C2=A0- I always forget to update this field.. We definitely should a=
dd some
> generic check on it somewhere, at least in tests.

My suggestion (in another thread) was to enhance=20
x-debug-block-dirty-bitmap-sha256 to include 'count' alongside the=20
checksum, to make it easier to write such tests.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org

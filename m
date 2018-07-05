Received: from eggs.gnu.org ([2001:4830:134:3::10]:37458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fb9Qv-0003Y2-7U
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 14:56:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fb9Qu-0001AG-D7
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 14:56:49 -0400
References: <20180703105305.45398-1-vsementsov@virtuozzo.com>
	<20180703105305.45398-2-vsementsov@virtuozzo.com>
	<d7e510dc-c6f6-3d5b-b716-0df88759440c@redhat.com>
	<41a9ce0d-fae5-1f6b-8492-0e64feda4d68@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <0030357d-8b40-0bd9-0b95-6eac8202f6bd@redhat.com>
Date: Thu, 5 Jul 2018 14:56:41 -0400
MIME-Version: 1.0
In-Reply-To: <41a9ce0d-fae5-1f6b-8492-0e64feda4d68@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/2] drity-bitmap: refactor merge: separte
 can_merge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, den@openvz.org, famz@redhat.com, armbru@redhat.com, mreitz@redhat.com



On 07/05/2018 02:55 PM, Eric Blake wrote:
> On 07/05/2018 01:51 PM, John Snow wrote:
>=20
>>
>>> -=C2=A0=C2=A0=C2=A0 assert(!bdrv_dirty_bitmap_readonly(dest));
>>> -
>>> -=C2=A0=C2=A0=C2=A0 if (!hbitmap_merge(dest->bitmap, src->bitmap)) {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(errp, "Bitmaps=
 are incompatible and can't be
>>> merged");
>>> +=C2=A0=C2=A0=C2=A0 if (bdrv_can_merge_dirty_bitmap(dest, src, errp))=
 {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool ret =3D hbitmap_merg=
e(dest->bitmap, src->bitmap);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 assert(ret);
>>
>> Might as well just assert(hbitmap_merge(...));
>=20
> Except that side effects inside assert() are bad programming practice,
> even if in qemu assert()s are guaranteed to always be enabled by osdep.=
h.
>=20

Oh, good point. NEVERMIND!

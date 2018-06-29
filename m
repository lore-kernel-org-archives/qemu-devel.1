Received: from eggs.gnu.org ([2001:4830:134:3::10]:49336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fYxZM-00084g-BH
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 13:52:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fYxZL-0006t0-5p
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 13:52:28 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
References: <20180629151524.138542-1-vsementsov@virtuozzo.com>
	<cafebdd0-01bb-c025-5519-0984e0b40d55@redhat.com>
	<3e512e87-c9ba-e2b3-8f2f-8c4991fec522@virtuozzo.com>
Message-ID: <e1e75f01-dd82-a7c9-91af-0d188ee70711@virtuozzo.com>
Date: Fri, 29 Jun 2018 20:52:13 +0300
MIME-Version: 1.0
In-Reply-To: <3e512e87-c9ba-e2b3-8f2f-8c4991fec522@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v2 0/3] image fleecing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, kwolf@redhat.com, mreitz@redhat.com, famz@redhat.com, den@openvz.org

29.06.2018 20:36, Vladimir Sementsov-Ogievskiy wrote:
> 29.06.2018 19:38, John Snow wrote:
>>
>> On 06/29/2018 11:15 AM, Vladimir Sementsov-Ogievskiy wrote:
>>> Image fleecing, or external (or pull) backup scheme is near to=20
>>> complete.
>>> Here is forgotten test, written by Fam in far 2014, with two my=20
>>> necessary
>>> patches, previously sent separately, so the series are called "v2"
>>>
>>> v2:
>>> =C2=A0 01: add transaction support
>>> =C2=A0 02: rebase on master, drop "'fleecing-filter':=20
>>> 'BlockdevCreateNotSupported'"
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 add empty .bdrv_close
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 add default .bdrv_child_perm
>>> =C2=A0 03: comparing to [PATCH v20 15/15] qemu-iotests: Image fleecing=
=20
>>> test case 08:
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 add -f iotests.imgfmt to qemu_io
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fix target_img to be always qcow2
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 add -r to qemu_io for nbd
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 add fleecing-filter layer
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wrap long lines
>>>
>>> Fam Zheng (1):
>>> =C2=A0=C2=A0 qemu-iotests: Image fleecing test case 222
>>>
>>> Vladimir Sementsov-Ogievskiy (2):
>>> =C2=A0=C2=A0 blockdev-backup: enable non-root nodes for backup source
>>> =C2=A0=C2=A0 block/fleecing-filter: new filter driver for fleecing
>>>
>>> =C2=A0 qapi/block-core.json=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
=C2=A0 6 ++-
>>> =C2=A0 block/fleecing-filter.c=C2=A0=C2=A0=C2=A0 |=C2=A0 80 +++++++++++=
+++++++++++++++++++++
>>> =C2=A0 blockdev.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 4 +-
>>> =C2=A0 block/Makefile.objs=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0 1 +
>>> =C2=A0 tests/qemu-iotests/222=C2=A0=C2=A0=C2=A0=C2=A0 | 112=20
>>> +++++++++++++++++++++++++++++++++++++++++++++
>>> =C2=A0 tests/qemu-iotests/222.out |=C2=A0=C2=A0 5 ++
>>> =C2=A0 tests/qemu-iotests/group=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
>>> =C2=A0 7 files changed, 205 insertions(+), 4 deletions(-)
>>> =C2=A0 create mode 100644 block/fleecing-filter.c
>>> =C2=A0 create mode 100755 tests/qemu-iotests/222
>>> =C2=A0 create mode 100644 tests/qemu-iotests/222.out
>>>
>> Have you been able to reproduce a race that proves the filter is
>> necessary, or can you explain how it might happen?
>
> No. But same logic is in block/replication, and I remember, that I=20
> discussed it on list, and the case I've described in 02 is not my idea.

found: http://lists.nongnu.org/archive/html/qemu-devel/2017-08/msg01807.htm=
l

>
>>
>> I think I mentioned it once as a possibility but I hadn't convinced=20
>> myself.
>
>


--=20
Best regards,
Vladimir

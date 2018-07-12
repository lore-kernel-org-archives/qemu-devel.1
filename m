Received: from eggs.gnu.org ([2001:4830:134:3::10]:58577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fdi9j-0005uV-PQ
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 16:25:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fdi9i-0005qz-Rw
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 16:25:39 -0400
References: <20180626135035.133432-1-vsementsov@virtuozzo.com>
	<DB6PR0801MB2056B99A8BFC3613E368B2A5C1590@DB6PR0801MB2056.eurprd08.prod.outlook.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <70365880-eb2c-e313-ea11-e16bc302a939@redhat.com>
Date: Thu, 12 Jul 2018 16:25:32 -0400
MIME-Version: 1.0
In-Reply-To: <DB6PR0801MB2056B99A8BFC3613E368B2A5C1590@DB6PR0801MB2056.eurprd08.prod.outlook.com>
Content-Type: text/plain; charset=koi8-r
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/6] fix persistent bitmaps migration logic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "dgilbert@redhat.com" <dgilbert@redhat.com>, "quintela@redhat.com" <quintela@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "famz@redhat.com" <famz@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, "kwolf@redhat.com" <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>, Eric Blake <eblake@redhat.com>



On 07/12/2018 03:00 PM, Vladimir Sementsov-Ogievskiy wrote:
> Hi, what about this?
> I'll be on vacation next two weeks.
> Best regards, Vladimir.

By the end of today.

If there are fixes necessary I will take over the series if necessary so
you can enjoy your vacation, if that's OK with you?

--js

> -----------------------------------------------------------------------=
-
> *=EF=D4:* Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> *=EF=D4=D0=D2=C1=D7=CC=C5=CE=CF:* 26 =C9=C0=CE=D1 2018 =C7. 16:50:29
> *=EB=CF=CD=D5:* qemu-devel@nongnu.org; qemu-block@nongnu.org
> *=EB=CF=D0=C9=D1:* dgilbert@redhat.com; quintela@redhat.com; stefanha@r=
edhat.com;
> jsnow@redhat.com; famz@redhat.com; mreitz@redhat.com; kwolf@redhat.com;
> Vladimir Sementsov-Ogievskiy; Denis Lunev
> *=F4=C5=CD=C1:* [PATCH 0/6] fix persistent bitmaps migration logic
> =9A
> Hi all.
>=20
> To continue talk about correct loading of persistent bitmaps here is
> a patch (04), with some surrounding.
>=20
> Patch 04 contains new (and I hope, more clean) logic of bitmaps
> loading/inactivation/invalidation/migration, with the whole description=
.
> Let me not duplicate it here, you can safely start reading from 04
> commit message and internal big comment.
>=20
> Vladimir Sementsov-Ogievskiy (6):
> =9A iotests: 169: drop deprecated 'autoload' parameter
> =9A block/qcow2: improve error message in qcow2_inactivate
> =9A bloc/qcow2: drop dirty_bitmaps_loaded state variable
> =9A dirty-bitmaps: clean-up bitmaps loading and migration logic
> =9A iotests: improve 169
> =9A iotests: 169: add cases for source vm resuming
>=20
> =9Ablock/qcow2.h=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A |=9A=
 1 -
> =9Ainclude/block/dirty-bitmap.h=9A=9A |=9A 2 +-
> =9Ablock.c=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=
=9A=9A | 11 ++++--
> =9Ablock/dirty-bitmap.c=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A | 36 +++++++-----=
------
> =9Ablock/qcow2-bitmap.c=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A | 16 ++++++++
> =9Ablock/qcow2.c=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A=9A | 8=
6
> ++++++++++++++++++++++++++++++++----------
> =9Amigration/block-dirty-bitmap.c | 10 ++++-
> =9Atests/qemu-iotests/169=9A=9A=9A=9A=9A=9A=9A=9A | 70 ++++++++++++++++=
+++++++++++++++++-
> =9Atests/qemu-iotests/169.out=9A=9A=9A=9A |=9A 4 +-
> =9A9 files changed, 182 insertions(+), 54 deletions(-)
>=20
> --=20
> 2.11.1
>=20

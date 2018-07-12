Received: from eggs.gnu.org ([2001:4830:134:3::10]:37433)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fdgp9-0001Zo-If
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 15:00:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fdgp6-0007oo-Et
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 15:00:19 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Thu, 12 Jul 2018 19:00:09 +0000
Message-ID: <DB6PR0801MB2056B99A8BFC3613E368B2A5C1590@DB6PR0801MB2056.eurprd08.prod.outlook.com>
References: <20180626135035.133432-1-vsementsov@virtuozzo.com>
In-Reply-To: <20180626135035.133432-1-vsementsov@virtuozzo.com>
Content-Language: ru-RU
MIME-Version: 1.0
Content-Type: text/plain; charset="koi8-r"
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
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "dgilbert@redhat.com" <dgilbert@redhat.com>, "quintela@redhat.com" <quintela@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>, "famz@redhat.com" <famz@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, "kwolf@redhat.com" <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>, Eric Blake <eblake@redhat.com>

Hi, what about this?
I'll be on vacation next two weeks.
Best regards, Vladimir.
________________________________
=EF=D4: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
=EF=D4=D0=D2=C1=D7=CC=C5=CE=CF: 26 =C9=C0=CE=D1 2018 =C7. 16:50:29
=EB=CF=CD=D5: qemu-devel@nongnu.org; qemu-block@nongnu.org
=EB=CF=D0=C9=D1: dgilbert@redhat.com; quintela@redhat.com; stefanha@redhat.=
com; jsnow@redhat.com; famz@redhat.com; mreitz@redhat.com; kwolf@redhat.com=
; Vladimir Sementsov-Ogievskiy; Denis Lunev
=F4=C5=CD=C1: [PATCH 0/6] fix persistent bitmaps migration logic

Hi all.

To continue talk about correct loading of persistent bitmaps here is
a patch (04), with some surrounding.

Patch 04 contains new (and I hope, more clean) logic of bitmaps
loading/inactivation/invalidation/migration, with the whole description.
Let me not duplicate it here, you can safely start reading from 04
commit message and internal big comment.

Vladimir Sementsov-Ogievskiy (6):
  iotests: 169: drop deprecated 'autoload' parameter
  block/qcow2: improve error message in qcow2_inactivate
  bloc/qcow2: drop dirty_bitmaps_loaded state variable
  dirty-bitmaps: clean-up bitmaps loading and migration logic
  iotests: improve 169
  iotests: 169: add cases for source vm resuming

 block/qcow2.h                  |  1 -
 include/block/dirty-bitmap.h   |  2 +-
 block.c                        | 11 ++++--
 block/dirty-bitmap.c           | 36 +++++++-----------
 block/qcow2-bitmap.c           | 16 ++++++++
 block/qcow2.c                  | 86 ++++++++++++++++++++++++++++++++------=
----
 migration/block-dirty-bitmap.c | 10 ++++-
 tests/qemu-iotests/169         | 70 +++++++++++++++++++++++++++++++++-
 tests/qemu-iotests/169.out     |  4 +-
 9 files changed, 182 insertions(+), 54 deletions(-)

--
2.11.1

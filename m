Received: from eggs.gnu.org ([2001:4830:134:3::10]:51165)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eJa6B-0006lh-3M
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 02:14:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eJa67-0000Uk-RN
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 02:14:31 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:45642 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1eJa67-0000Ts-FS
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 02:14:27 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue, 28 Nov 2017 10:14:05 +0300
Message-Id: <20171128071409.21887-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH for 2.11 0/4] fix bitmaps migration through
 shared storage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: crosa@redhat.com, ehabkost@redhat.com, mreitz@redhat.com, kwolf@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

Hi all.

This fix may be considered as a material for 2.11, or may be postponed
to 2.12, on your choice.

The core patch is 02.

Vladimir Sementsov-Ogievskiy (4):
  qcow2-bitmap: add qcow2_reopen_bitmaps_rw_hint()
  qcow2: handle reopening bitmaps on bdrv_invalidate_cache
  scripts/qemu.py: tiny enhancement for event_wiat
  iotests: add dirty bitmap migration test

 block/qcow2.h                 |  2 ++
 block/qcow2-bitmap.c          | 15 +++++++-
 block/qcow2.c                 |  8 ++++-
 scripts/qemu.py               | 10 ++++--
 tests/qemu-iotests/169        | 82 +++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/169.out    |  5 +++
 tests/qemu-iotests/group      |  1 +
 tests/qemu-iotests/iotests.py |  7 +++-
 8 files changed, 124 insertions(+), 6 deletions(-)
 create mode 100755 tests/qemu-iotests/169
 create mode 100644 tests/qemu-iotests/169.out

-- 
2.11.1

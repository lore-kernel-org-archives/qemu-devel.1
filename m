Received: from eggs.gnu.org ([2001:4830:134:3::10]:47888)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fTqRo-0004At-7x
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 11:15:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fTqRl-0000g4-2n
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 11:15:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56294 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fTqRk-0000fa-Ob
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 11:15:28 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Fri, 15 Jun 2018 16:15:08 +0100
Message-Id: <20180615151518.83637-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/10] migration queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, quintela@redhat.com, peterx@redhat.com, groug@kaod.org, vsementsov@virtuozzo.com, xiaoguangrong@tencent.com, bala24@linux.vnet.ibm.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

The following changes since commit 2702c2d3eb74e3908c0c5dbf3a71c8987595a8=
6e:

  Merge remote-tracking branch 'remotes/stsquad/tags/pull-travis-updates-=
140618-1' into staging (2018-06-15 12:49:36 +0100)

are available in the Git repository at:

  git://github.com/dagrh/qemu.git tags/pull-migration-20180615a

for you to fetch changes up to 650af8907bd567db914b7ce3a7e9df4c323f4619:

  migration: calculate expected_downtime with ram_bytes_remaining() (2018=
-06-15 14:40:56 +0100)

----------------------------------------------------------------
Migration pull 2018-06-15

----------------------------------------------------------------
Balamuruhan S (1):
      migration: calculate expected_downtime with ram_bytes_remaining()

Dr. David Alan Gilbert (5):
      migration: Fixes for non-migratable RAMBlocks
      migration: Poison ramblock loops in migration
      migration/postcopy: Add max-postcopy-bandwidth parameter
      migration: Wake rate limiting for urgent requests
      migration/postcopy: Wake rate limit sleep on postcopy request

Greg Kurz (1):
      typedefs: add QJSON

Vladimir Sementsov-Ogievskiy (1):
      migration/block-dirty-bitmap: fix dirty_bitmap_load

Xiao Guangrong (2):
      migration: fix counting xbzrle cache_miss_rate
      migration: introduce migration_update_rates

 hmp.c                          |  7 ++++
 include/exec/ramlist.h         |  4 ++-
 include/migration/vmstate.h    |  2 --
 include/qemu/typedefs.h        |  1 +
 migration/block-dirty-bitmap.c |  3 ++
 migration/migration.c          | 73 ++++++++++++++++++++++++++++++++++++=
++----
 migration/migration.h          | 11 +++++++
 migration/qjson.h              |  2 --
 migration/ram.c                | 53 ++++++++++++++++++++----------
 migration/rdma.c               |  2 +-
 migration/trace-events         |  2 ++
 qapi/migration.json            | 19 +++++++++--
 12 files changed, 146 insertions(+), 33 deletions(-)

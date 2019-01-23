Received: from eggs.gnu.org ([209.51.188.92]:40871)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gmKvL-0006tN-Ta
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 10:58:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gmKvK-0005RA-Qp
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 10:58:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57895)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gmKvK-0005Pn-GK
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 10:58:42 -0500
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Wed, 23 Jan 2019 15:58:21 +0000
Message-Id: <20190123155830.8459-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/9] migration queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, xiaoguangrong@tencent.com, marcandre.lureau@redhat.com, shirley17fei@gmail.com, lifei1214@126.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

The following changes since commit 9f33051abce238ab43a23125e237aac8b0931b=
88:

  Merge remote-tracking branch 'remotes/kraxel/tags/ipxe-20190122-pull-re=
quest' into staging (2019-01-22 19:24:10 +0000)

are available in the Git repository at:

  git://github.com/dagrh/qemu.git tags/pull-migration-20190123a

for you to fetch changes up to aecbfe9c64a6005f57b2132eb29db2ba7c0993fe:

  migration: introduce pages-per-second (2019-01-23 15:51:47 +0000)

----------------------------------------------------------------
Migration pull 2019-01-23

New pages-per-second stat, a new test, and a bunch
of fixes and tidy ups.

----------------------------------------------------------------
Dr. David Alan Gilbert (1):
      migration/rdma: unregister fd handler

Fei Li (5):
      Fix segmentation fault when qemu_signal_init fails
      migration: fix the multifd code when receiving less channels
      migration: multifd_save_cleanup() can't fail, simplify
      migration: add more error handling for postcopy_ram_enable_notify
      migration: unify error handling for process_incoming_migration_co

Marc-Andr=C3=A9 Lureau (2):
      tests: add /vmstate/simple/array
      vmstate: constify SaveVMHandlers

Xiao Guangrong (1):
      migration: introduce pages-per-second

 hmp.c                        |  2 ++
 include/migration/register.h |  2 +-
 migration/channel.c          | 11 +++++-----
 migration/migration.c        | 51 +++++++++++++++++++++++++++-----------=
------
 migration/migration.h        | 12 +++++++++--
 migration/postcopy-ram.c     |  1 +
 migration/ram.c              | 34 ++++++++++++++++++++---------
 migration/ram.h              |  4 ++--
 migration/rdma.c             |  1 +
 migration/savevm.c           |  5 +++--
 qapi/migration.json          |  5 ++++-
 tests/test-vmstate.c         | 50 ++++++++++++++++++++++++++++++++++++++=
+++++
 util/main-loop.c             |  8 +++----
 13 files changed, 139 insertions(+), 47 deletions(-)

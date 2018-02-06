Received: from eggs.gnu.org ([2001:4830:134:3::10]:43220)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ej5Vd-0002Gw-TW
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 10:50:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ej5VX-0003aB-Tk
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 10:50:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43879)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ej5VX-0003Zb-N4
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 10:50:07 -0500
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Tue,  6 Feb 2018 15:49:22 +0000
Message-Id: <20180206154936.13565-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 00/14] migration queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, quintela@redhat.com
Cc: peterx@redhat.com, lvivier@redhat.com, groug@kaod.org, ross.lagerwall@citrix.com, wei.w.wang@intel.com, danielhb@linux.vnet.ibm.com

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

The following changes since commit 2b3805f370521deacab974b9c9ca07d2319a8890:

  Merge remote-tracking branch 'remotes/stefanberger/tags/pull-tpm-2018-02-03-1' into staging (2018-02-05 09:31:37 +0000)

are available in the Git repository at:

  git://github.com/dagrh/qemu.git tags/pull-migration-20180206a

for you to fetch changes up to 875fcd013ab68c64802998b22f54f0184479d21b:

  migration: incoming postcopy advise sanity checks (2018-02-06 14:53:02 +0000)

----------------------------------------------------------------
Migration pull 2018-02-06

This is based off Juan's last pull with a few extras, but
also removing:
   Add migration xbzrle test
   Add migration precopy test

As well as my normal test boxes, I also gave it a test
on a 32 bit ARM box and it seems happy (a Calxeda highbank)
and a big-endian power box.

Dave

----------------------------------------------------------------
Daniel Henrique Barboza (1):
      migration/savevm.c: set MAX_VM_CMD_PACKAGED_SIZE to 1ul << 32

Dr. David Alan Gilbert (3):
      migration: Allow migrate_fd_connect to take an Error *
      migration: Route errors down through migration_channel_connect
      migration: Recover block devices if failure in device state

Greg Kurz (1):
      migration: incoming postcopy advise sanity checks

Juan Quintela (7):
      migration: Drop current address parameter from save_zero_page()
      tests: Remove deprecated migration tests commands
      tests: Consolidate accelerators declaration
      tests: Use consistent names for migration
      tests: Add deprecated commands migration test
      tests: Create migrate-start-postcopy command
      tests: Adjust sleeps for migration test

Ross Lagerwall (1):
      migration: Don't leak IO channels

Wei Wang (1):
      migration: use s->threshold_size inside migration_update_counters

 migration/channel.c    |  32 +++++------
 migration/channel.h    |   3 +-
 migration/exec.c       |   2 +-
 migration/fd.c         |   2 +-
 migration/migration.c  |  15 ++++--
 migration/migration.h  |   2 +-
 migration/ram.c        |  11 ++--
 migration/rdma.c       |   2 +-
 migration/savevm.c     |  25 +++++++--
 migration/socket.c     |   4 +-
 migration/tls.c        |   3 +-
 migration/trace-events |   2 +-
 tests/migration-test.c | 144 ++++++++++++++++++++++++++++++-------------------
 13 files changed, 151 insertions(+), 96 deletions(-)

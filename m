Received: from eggs.gnu.org ([2001:4830:134:3::10]:36920)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cFOvu-0000vo-7A
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 12:26:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cFOvt-0001KH-Gq
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 12:26:06 -0500
From: John Snow <jsnow@redhat.com>
Date: Fri,  9 Dec 2016 12:25:46 -0500
Message-Id: <20161209172547.31550-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v3 0/1] migration: disallow migrate_add_blocker
 during migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, mst@redhat.com, jcody@redhat.com, quintela@redhat.com, armbru@redhat.com, groug@kaod.org, aneesh.kumar@linux.vnet.ibm.com, ashijeetacharya@gmail.com, pbonzini@redhat.com, amit.shah@redhat.com, marcandre.lureau@redhat.com, dgilbert@redhat.com, John Snow <jsnow@redhat.com>

As discussed on-list, this may be a necessary building block for
a run-time flag that prevents us from getting into any situations
where we configure a non-migratable QEMU.

I'd like extra attention to be paid to the virtio-gpu, vhost, and
ivshmem changes as I am not perfectly confident in those.

Sorry for the wide CC distributions.

V3: Rebased from a version I sent about a year ago.
    Changed the migration function names a bit,
    Changed new calls to migrate_add_blocker.

John Snow (1):
  migration: disallow migrate_add_blocker during migration

 block/qcow.c                  |  6 +++++-
 block/vdi.c                   |  6 +++++-
 block/vhdx.c                  | 24 ++++++++++++++----------
 block/vmdk.c                  |  7 ++++++-
 block/vpc.c                   | 10 +++++++---
 block/vvfat.c                 | 20 ++++++++++++--------
 hw/9pfs/9p.c                  | 16 ++++++++++++----
 hw/display/virtio-gpu.c       | 29 ++++++++++++++++-------------
 hw/misc/ivshmem.c             | 11 +++++++----
 hw/scsi/vhost-scsi.c          | 25 +++++++++++++++++++------
 hw/virtio/vhost.c             |  8 +++++++-
 include/migration/migration.h |  6 +++++-
 migration/migration.c         | 35 +++++++++++++++++++++++++++++++++--
 stubs/migr-blocker.c          |  3 ++-
 target-i386/kvm.c             | 16 +++++++++++++---
 15 files changed, 163 insertions(+), 59 deletions(-)

-- 
2.9.3

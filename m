Received: from eggs.gnu.org ([2001:4830:134:3::10]:44557)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d1XBF-0001ca-V8
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 07:56:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d1XBC-000707-3K
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 07:56:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53606)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d1XBB-0006yx-Q0
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 07:56:50 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B947FB0407
	for <qemu-devel@nongnu.org>; Fri, 21 Apr 2017 11:56:48 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Fri, 21 Apr 2017 13:55:41 +0200
Message-Id: <20170421115646.15544-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/65] Migration pull request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com

Hi

This pull includes:

- fixes from (peter xu)
- page-size parameter for info migrate (chao)
- Fix for virtio-rng migration with postcopy (laurent)
- RAMState series cleanup (me)

Please apply.


The following changes since commit fa54abb8c298f892639ffc4bc2f61448ac3be4=
a1:

  Drop QEMU_GNUC_PREREQ() checks for gcc older than 4.1 (2017-04-20 18:33=
:33 +0100)

are available in the git repository at:

  git://github.com/juanquintela/qemu.git tags/migration/20170421

for you to fetch changes up to 2c02468c9b1750aaa5fbeee49cdb55f101608c6a:

  hmp: info migrate_parameters format tunes (2017-04-21 12:25:41 +0200)

----------------------------------------------------------------
migration/next for 20170421

----------------------------------------------------------------
Chao Fan (1):
      ram: Add page-size to output in 'info migrate'

Juan Quintela (58):
      ram: Update all functions comments
      ram: Rename flush_page_queue() to migration_page_queue_free()
      ram: Rename block_name to rbname
      ram: Create RAMState
      ram: Add dirty_rate_high_cnt to RAMState
      ram: Move bitmap_sync_count into RAMState
      ram: Move start time into RAMState
      ram: Move bytes_xfer_prev into RAMState
      ram: Change byte_xfer_{prev,now} type to uint64_t
      ram: Move num_dirty_pages_period into RAMState
      ram: Change num_dirty_pages_period type to uint64_t
      ram: Move xbzrle_cache_miss_prev into RAMState
      ram: Move iterations_prev into RAMState
      ram: Move dup_pages into RAMState
      ram: Remove unused dup_mig_bytes_transferred()
      ram: Remove unused pages_skipped variable
      ram: Move norm_pages to RAMState
      ram: Remove norm_mig_bytes_transferred
      ram: Move iterations into RAMState
      ram: Move xbzrle_bytes into RAMState
      ram: Move xbzrle_pages into RAMState
      ram: Move xbzrle_cache_miss into RAMState
      ram: Move xbzrle_cache_miss_rate into RAMState
      ram: Move xbzrle_overflows into RAMState
      ram: Move migration_dirty_pages to RAMState
      ram: Everything was init to zero, so use memset
      ram: Move migration_bitmap_mutex into RAMState
      ram: Move migration_bitmap_rcu into RAMState
      ram: Move bytes_transferred into RAMState
      ram: Use the RAMState bytes_transferred parameter
      ram: Remove ram_save_remaining
      ram: Move last_req_rb to RAMState
      ram: Move src_page_req* to RAMState
      ram: Create ram_dirty_sync_count()
      ram: Remove dirty_bytes_rate
      ram: Move dirty_pages_rate to RAMState
      ram: Move postcopy_requests into RAMState
      ram: Add QEMUFile to RAMState
      ram: Move QEMUFile into RAMState
      ram: Remove compression_switch and inline its logic
      migration: Remove MigrationState from migration_in_postcopy
      ram: We don't need MigrationState parameter anymore
      ram: Rename qemu_target_page_bits() to qemu_target_page_size()
      ram: Pass RAMBlock to bitmap_sync
      ram: ram_discard_range() don't use the mis parameter
      ram: reorganize last_sent_block
      ram: Use page number instead of an address for the bitmap operation=
s
      ram: Remember last_page instead of last_offset
      ram: Change offset field in PageSearchStatus to page
      ram: Use ramblock and page offset instead of absolute offset
      ram: rename last_ram_offset() last_ram_pages()
      ram: Use RAMBitmap type for coherence
      migration: Remove MigrationState parameter from migration_is_idle()
      qdev: qdev_hotplug is really a bool
      qdev: Export qdev_hot_removed
      qdev: Move qdev_unplug() to qdev-monitor.c
      migration: Disable hotplug/unplug during migration
      ram: Remove migration_bitmap_extend()

Laurent Vivier (2):
      migration: don't close a file descriptor while it can be in use
      virtio-rng: stop virtqueue while the CPU is stopped

Peter Xu (4):
      migration: set current_active_state once
      migration: rename max_size to threshold_size
      hmp: info migrate_capability format tunes
      hmp: info migrate_parameters format tunes

 exec.c                         |   11 +-
 hmp.c                          |   29 +-
 hw/core/qdev.c                 |   40 +-
 hw/virtio/trace-events         |    3 +
 hw/virtio/virtio-rng.c         |   29 +-
 include/exec/ram_addr.h        |    8 +-
 include/hw/qdev-core.h         |    3 +-
 include/hw/virtio/virtio-rng.h |    2 +
 include/migration/migration.h  |   41 +-
 include/migration/vmstate.h    |    3 +-
 include/sysemu/sysemu.h        |    2 +-
 migration/migration.c          |   82 +--
 migration/postcopy-ram.c       |   14 +-
 migration/ram.c                | 1210 +++++++++++++++++++++-------------=
------
 migration/savevm.c             |   19 +-
 migration/trace-events         |    4 +-
 qapi-schema.json               |    5 +-
 qdev-monitor.c                 |   45 ++
 18 files changed, 805 insertions(+), 745 deletions(-)

Received: from eggs.gnu.org ([2001:4830:134:3::10]:52008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ele1a-0002lI-Pg
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 12:05:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ele1Z-0005C5-49
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 12:05:46 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 13 Feb 2018 18:04:34 +0100
Message-Id: <20180213170529.10858-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/55] Block layer patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

The following changes since commit fb68096da3d35e64c88cd610c1fa42766c58e9=
2a:

  Revert "tests: use memfd in vhost-user-test" (2018-02-13 09:51:52 +0000=
)

are available in the git repository at:

  git://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to 0a4dc980e6c935e9be745ce3ee1a4c71629ecd00:

  Merge remote-tracking branch 'mreitz/tags/pull-block-2018-02-13' into q=
ueue-block (2018-02-13 17:01:13 +0100)

----------------------------------------------------------------
Block layer patches

----------------------------------------------------------------
Alberto Garcia (40):
      qcow2: Use g_try_realloc() in qcow2_expand_zero_clusters()
      qcow2: Fix documentation of get_cluster_table()
      qcow2: Add table size field to Qcow2Cache
      qcow2: Remove BDS parameter from qcow2_cache_get_table_addr()
      qcow2: Remove BDS parameter from qcow2_cache_get_table_idx()
      qcow2: Remove BDS parameter from qcow2_cache_table_release()
      qcow2: Remove BDS parameter from qcow2_cache_entry_mark_dirty()
      qcow2: Remove BDS parameter from qcow2_cache_put()
      qcow2: Remove BDS parameter from qcow2_cache_destroy()
      qcow2: Remove BDS parameter from qcow2_cache_clean_unused()
      qcow2: Remove BDS parameter from qcow2_cache_discard()
      qcow2: Remove BDS parameter from qcow2_cache_is_table_offset()
      qcow2: Add offset_to_l1_index()
      qcow2: Add l2_slice_size field to BDRVQcow2State
      qcow2: Add offset_to_l2_slice_index()
      qcow2: Update l2_load() to support L2 slices
      qcow2: Prepare l2_allocate() for adding L2 slice support
      qcow2: Update l2_allocate() to support L2 slices
      qcow2: Refactor get_cluster_table()
      qcow2: Update get_cluster_table() to support L2 slices
      qcow2: Update qcow2_get_cluster_offset() to support L2 slices
      qcow2: Update qcow2_alloc_cluster_link_l2() to support L2 slices
      qcow2: Update handle_copied() to support L2 slices
      qcow2: Update handle_alloc() to support L2 slices
      qcow2: Update discard_single_l2() to support L2 slices
      qcow2: Update zero_single_l2() to support L2 slices
      qcow2: Prepare qcow2_update_snapshot_refcount() for adding L2 slice=
 support
      qcow2: Update qcow2_update_snapshot_refcount() to support L2 slices
      qcow2: Read refcount before L2 table in expand_zero_clusters_in_l1(=
)
      qcow2: Prepare expand_zero_clusters_in_l1() for adding L2 slice sup=
port
      qcow2: Update expand_zero_clusters_in_l1() to support L2 slices
      qcow2: Update qcow2_truncate() to support L2 slices
      qcow2: Rename l2_table in qcow2_alloc_compressed_cluster_offset()
      qcow2: Rename l2_table in count_contiguous_clusters()
      qcow2: Rename l2_table in count_contiguous_clusters_unallocated()
      qcow2: Rename l2_table in count_cow_clusters()
      qcow2: Allow configuring the L2 slice size
      iotests: Test valid values of l2-cache-entry-size
      iotests: Test downgrading an image using a small L2 slice size
      iotests: Add l2-cache-entry-size to iotest 137

Daniel P. Berrang=C3=A9 (1):
      qemu-io: fix EOF Ctrl-D handling in qemu-io readline code

Fam Zheng (4):
      iotests: Fix CID for VMDK afl image
      qemu-img.texi: Clean up parameter list
      qemu-img: Document --force-share / -U
      docs: Document share-rw property more thoroughly

Kevin Wolf (1):
      Merge remote-tracking branch 'mreitz/tags/pull-block-2018-02-13' in=
to queue-block

Max Reitz (8):
      iotests: Use virtio-blk in 155
      gluster: Move glfs_close() to create's clean-up
      gluster: Pull truncation from qemu_gluster_create
      gluster: Query current size in do_truncate()
      gluster: Add preallocated truncation
      sheepdog: Make sd_prealloc() take a BDS
      sheepdog: Pass old and new size to sd_prealloc()
      sheepdog: Allow fully preallocated truncation

Paolo Bonzini (1):
      block: early check for blockers on drive-mirror

Vladimir Sementsov-Ogievskiy (1):
      block: maintain persistent disabled bitmaps

 qapi/block-core.json                           |  12 +-
 block/qcow2.h                                  |  33 +-
 include/block/dirty-bitmap.h                   |   1 -
 block/dirty-bitmap.c                           |  18 -
 block/gluster.c                                | 116 +++---
 block/qcow2-bitmap.c                           |  12 +-
 block/qcow2-cache.c                            |  80 ++--
 block/qcow2-cluster.c                          | 519 +++++++++++++------=
------
 block/qcow2-refcount.c                         | 206 +++++-----
 block/qcow2.c                                  |  63 ++-
 block/sheepdog.c                               |  56 ++-
 blockdev.c                                     |  15 +-
 qemu-io.c                                      |  27 +-
 docs/qemu-block-drivers.texi                   |  10 +
 qemu-doc.texi                                  |   7 +
 qemu-img.texi                                  |  74 ++--
 tests/qemu-iotests/059.out                     |   2 +-
 tests/qemu-iotests/061                         |  16 +
 tests/qemu-iotests/061.out                     |  61 +++
 tests/qemu-iotests/103                         |  17 +
 tests/qemu-iotests/103.out                     |   3 +
 tests/qemu-iotests/137                         |   5 +
 tests/qemu-iotests/137.out                     |   2 +
 tests/qemu-iotests/155                         |  14 +-
 tests/qemu-iotests/165                         |   2 +-
 tests/qemu-iotests/176                         |   2 +-
 tests/qemu-iotests/sample_images/afl9.vmdk.bz2 | Bin 178 -> 618 bytes
 27 files changed, 816 insertions(+), 557 deletions(-)

Received: from eggs.gnu.org ([209.51.188.92]:39970)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1gigRj-0002tx-0h
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 09:09:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1gigRi-0002zW-Co
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 09:09:03 -0500
Received: from m50-110.126.com ([123.125.50.110]:42740)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lifei1214@126.com>) id 1gigRh-0002vK-O8
	for qemu-devel@nongnu.org; Sun, 13 Jan 2019 09:09:02 -0500
From: Fei Li <lifei1214@126.com>
Date: Sun, 13 Jan 2019 22:08:44 +0800
Message-Id: <20190113140849.38339-1-lifei1214@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH for-4.0 0/5] fix some segmentation faults and
 migration issues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, shirley17fei@gmail.com
Cc: Fei Li <lifei1214@126.com>

All these five patches have gotten the Reviewed-by: the first patch
is to fix one segmentation fault and the other four are to fix some
migration issues.

To be more detail, they are extracted from previous
"[PATCH for-4.0 v9 16/16] qemu_thread_create: propagate errors to
callers to handle.", but actually these five patches are derivative
and not relevant to the mentioned qemu_thread_create patch series.
Thus send them separately to make them be merged earlier.

Fei Li (5):
  Fix segmentation fault when qemu_signal_init fails
  migration: fix the multifd code when receiving less channels
  migration: multifd_save_cleanup() can't fail, simplify
  migration: add more error handling for postcopy_ram_enable_notify
  migration: unify error handling for process_incoming_migration_co

 migration/channel.c      | 11 ++++++-----
 migration/migration.c    | 40 +++++++++++++++++++++-------------------
 migration/migration.h    |  2 +-
 migration/postcopy-ram.c |  1 +
 migration/ram.c          | 28 ++++++++++++++++++----------
 migration/ram.h          |  4 ++--
 migration/savevm.c       |  1 +
 util/main-loop.c         |  8 ++++----
 8 files changed, 54 insertions(+), 41 deletions(-)

-- 
2.17.2 (Apple Git-113)

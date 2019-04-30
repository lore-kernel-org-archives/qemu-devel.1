Received: from eggs.gnu.org ([209.51.188.92]:54432)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hLJj7-0005Wx-5Q
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 23:46:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hLJj3-00033V-L8
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 23:46:39 -0400
Received: from mga11.intel.com ([192.55.52.93]:47399)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1hLJj3-00030g-CZ
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 23:46:37 -0400
From: Wei Yang <richardw.yang@linux.intel.com>
Date: Tue, 30 Apr 2019 11:44:09 +0800
Message-Id: <20190430034412.12935-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 0/3] Cleanup migration/ram.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, quintela@redhat.com, dgilbert@redhat.com, Wei Yang <richardw.yang@linux.intel.com>

The *start* of migration_bitmap_sync_range is always 0, we can remove this
parameter.

Since RAMBlock->offset is always *word* aligned, we can remove the check on
offset and simplify the logic a little.

Wei Yang (3):
  migration/ram.c: start of migration_bitmap_sync_range is always 0
  migration/ram.c: start of cpu_physical_memory_sync_dirty_bitmap is
    always 0
  ram: RAMBlock->offset is always aligned to a word

 include/exec/ram_addr.h | 24 ++++++++++++------------
 migration/ram.c         |  8 ++++----
 2 files changed, 16 insertions(+), 16 deletions(-)

-- 
2.19.1

Received: from eggs.gnu.org ([2001:4830:134:3::10]:60131)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dsVhJ-0006F1-Vx
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 11:05:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dsVhG-00027F-Ns
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 11:04:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39668)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dsVhG-00026T-Hb
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 11:04:54 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Thu, 14 Sep 2017 16:04:40 +0100
Message-Id: <20170914150447.19352-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 0/7] hmp queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, lvivier@redhat.com, cohuck@redhat.com, vadim.galitsyn@profitbricks.com
Cc: imammedo@redhat.com, thuth@redhat.com, peterx@redhat.com, groug@kaod.org

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

The following changes since commit 9d81b2d2000f41be55a0624a26873f993fb6e928:

  sparc: Fix typedef clash (2017-09-14 15:00:41 +0100)

are available in the git repository at:

  git://github.com/dagrh/qemu.git tags/pull-hmp-20170914

for you to fetch changes up to d0f63c1e291a0c27cafc0e6faec5a84130b012e0:

  hmp: introduce 'info memory_size_summary' command (2017-09-14 15:52:10 +0100)

----------------------------------------------------------------
HMP pull 2017-09-14

----------------------------------------------------------------
Cornelia Huck (1):
      dump: do not dump non-existent guest memory

Laurent Vivier (3):
      hmp: fix "dump-quest-memory" segfault (ppc)
      hmp: fix "dump-quest-memory" segfault (arm)
      tests/hmp: test "none" machine with memory

Vadim Galitsyn (3):
      hmp: extend "info numa" with hotplugged memory information
      qmp: introduce query-memory-size-summary command
      hmp: introduce 'info memory_size_summary' command

 dump.c                                             |  6 ++++
 hmp-commands-info.hx                               | 16 +++++++++++
 hmp.c                                              | 18 ++++++++++++
 hmp.h                                              |  1 +
 hw/mem/pc-dimm.c                                   |  5 ++++
 include/hw/mem/pc-dimm.h                           |  1 +
 include/qemu/typedefs.h                            |  1 +
 include/sysemu/numa.h                              |  7 ++++-
 monitor.c                                          |  9 ++++--
 numa.c                                             | 18 ++++++++----
 qapi-schema.json                                   | 32 ++++++++++++++++++++++
 qmp.c                                              | 13 +++++++++
 stubs/Makefile.objs                                |  2 +-
 stubs/{qmp_pc_dimm_device_list.c => qmp_pc_dimm.c} |  5 ++++
 target/arm/arch_dump.c                             | 11 ++++++--
 target/ppc/arch_dump.c                             | 11 ++++++--
 tests/test-hmp.c                                   |  4 +++
 17 files changed, 146 insertions(+), 14 deletions(-)
 rename stubs/{qmp_pc_dimm_device_list.c => qmp_pc_dimm.c} (68%)

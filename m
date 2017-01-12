Received: from eggs.gnu.org ([2001:4830:134:3::10]:41989)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cRjec-0000Oz-Bw
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 12:59:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cRjeX-0000eK-NK
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 12:59:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59114)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cRjeX-0000dG-HN
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 12:59:09 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 12 Jan 2017 15:53:50 -0200
Message-Id: <20170112175356.21701-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 0/6] x86 and machine queue, 2017-01-17
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>

The following changes since commit 204febd17f9ebb9e94b1980b42c7f2c2307851c1:

  libqtest: handle zero length memwrite/memread (2017-01-12 10:45:59 +0000)

are available in the git repository at:

  git://github.com/ehabkost/qemu.git tags/x86-and-machine-pull-request

for you to fetch changes up to 8ed877b78498c89aa7ce5c76aa20841ff5072796:

  qmp: Report QOM type name on query-cpu-definitions (2017-01-12 15:51:36 -0200)

----------------------------------------------------------------
x86 and machine queue, 2017-01-17

Includes i386, CPU, NUMA, and memory backends changes.

i386:
 target/i386: Fix bad patch application to translate.c

CPU:
 qmp: Report QOM type name on query-cpu-definitions

NUMA:
 numa: make -numa parser dynamically allocate CPUs masks

Memory backends:
 qom: remove unused header
 monitor: reuse user_creatable_add_opts() instead of user_creatable_add()
 monitor: fix qmp/hmp query-memdev not reporting IDs of memory backends

----------------------------------------------------------------

Doug Evans (1):
  target/i386: Fix bad patch application to translate.c

Eduardo Habkost (1):
  qmp: Report QOM type name on query-cpu-definitions

Igor Mammedov (4):
  qom: remove unused header
  monitor: reuse user_creatable_add_opts() instead of
    user_creatable_add()
  monitor: fix qmp/hmp query-memdev not reporting IDs of memory backends
  numa: make -numa parser dynamically allocate CPUs masks

 docs/qmp-commands.txt           |  1 +
 qapi-schema.json                |  8 ++++-
 include/qom/object_interfaces.h | 17 ---------
 include/sysemu/hostmem.h        |  1 +
 include/sysemu/numa.h           |  2 +-
 include/sysemu/sysemu.h         |  7 ----
 backends/hostmem.c              | 26 ++++++++++++++
 hmp.c                           | 10 ++----
 numa.c                          | 24 +++++++++----
 qom/object_interfaces.c         | 78 ++++++++++++-----------------------------
 target/arm/helper.c             |  1 +
 target/i386/cpu.c               |  1 +
 target/i386/translate.c         | 10 +++---
 target/ppc/translate_init.c     |  1 +
 target/s390x/cpu_models.c       |  1 +
 vl.c                            |  5 ---
 16 files changed, 87 insertions(+), 106 deletions(-)

-- 
2.11.0.259.g40922b1

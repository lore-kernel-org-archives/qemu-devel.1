Received: from eggs.gnu.org ([209.51.188.92]:35255)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1h1UP4-0004sF-Us
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 06:08:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1h1UP2-000238-U7
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 06:08:02 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Wed,  6 Mar 2019 12:07:01 +0100
Message-Id: <20190306110711.309-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 00/10] Trivial branch patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Riku Voipio <riku.voipio@iki.fi>, Zhang Chen <zhangckid@gmail.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Richard Henderson <rth@twiddle.net>, Thomas Huth <thuth@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, John Snow <jsnow@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Laurent Vivier <laurent@vivier.eu>, Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Tony Krowiak <akrowiak@linux.ibm.com>, Max Reitz <mreitz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-trivial@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, qemu-s390x@nongnu.org, Corey Minyard <minyard@acm.org>, Pierre Morel <pmorel@linux.ibm.com>

The following changes since commit a3e3b0a7bd5de211a62cdf2d6c12b96d3c403560:

  Merge remote-tracking branch 'remotes/armbru/tags/pull-qapi-2019-03-05' into staging (2019-03-05 19:23:45 +0000)

are available in the Git repository at:

  git://github.com/vivier/qemu.git tags/trivial-branch-pull-request

for you to fetch changes up to 0e081fde8a3d80383adf2e802fc0c03af44c5436:

  thunk: fix of malloc to g_new (2019-03-06 11:27:32 +0100)

----------------------------------------------------------------
trivial patches pull request (20190206)

- acpi: remove unused functions/variables
- tests: remove useless architecture checks
- some typo fixes and documentation update
- flash_cfi02: fix memory leak

----------------------------------------------------------------

Aarushi Mehta (1):
  thunk: fix of malloc to g_new

Greg Kurz (1):
  bswap: Fix accessors syntax in comment

Igor Mammedov (1):
  hostmem-file: simplify ifdef-s in file_backend_memory_alloc()

Like Xu (1):
  doc: fix typos for documents in tree

Markus Armbruster (1):
  build: Correct explanation of unnest-vars example

Stephen Checkoway (1):
  block/pflash_cfi02: Fix memory leak and potential use-after-free

Thomas Huth (1):
  tests: Remove (mostly) useless architecture checks

Wei Yang (3):
  hw/i386/pc.c: remove unused function pc_acpi_init()
  hw/acpi: remove unused function acpi_table_add_builtin()
  hw/acpi: remove unnecessary variable acpi_table_builtin

 backends/hostmem-file.c        |  9 ++++-----
 docs/COLO-FT.txt               |  2 +-
 docs/amd-memory-encryption.txt |  2 +-
 docs/can.txt                   |  2 +-
 docs/colo-proxy.txt            |  6 +++---
 docs/cpu-hotplug.rst           |  2 +-
 docs/qcow2-cache.txt           |  2 +-
 docs/qemu-block-drivers.texi   |  2 +-
 docs/qemu-cpu-models.texi      |  8 ++++----
 docs/rdma.txt                  |  4 ++--
 docs/replay.txt                |  2 +-
 docs/vfio-ap.txt               |  2 +-
 hw/acpi/core.c                 | 10 +---------
 hw/block/pflash_cfi02.c        | 15 +++++++++++----
 hw/i386/pc.c                   | 27 ---------------------------
 include/hw/acpi/acpi.h         |  1 -
 include/hw/i386/pc.h           |  1 -
 include/qemu/bswap.h           |  8 ++++----
 rules.mak                      |  2 +-
 tests/fdc-test.c               |  7 -------
 tests/ide-test.c               |  7 -------
 tests/ipmi-bt-test.c           |  7 -------
 tests/ipmi-kcs-test.c          |  7 -------
 thunk.c                        |  2 +-
 24 files changed, 39 insertions(+), 98 deletions(-)

-- 
2.20.1

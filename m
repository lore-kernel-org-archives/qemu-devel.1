Received: from eggs.gnu.org ([2001:4830:134:3::10]:50586)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gG4Jm-0004rD-BX
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 11:46:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gG46X-00051L-Fn
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 11:32:57 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Fri, 26 Oct 2018 17:31:05 +0200
Message-Id: <20181026153125.24738-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 00/20] Trivial patches patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>, Jason Wang <jasowang@redhat.com>, qemu-arm@nongnu.org, Michael Walle <michael@walle.cc>, Laurent Vivier <lvivier@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Cleber Rosa <crosa@redhat.com>, Igor Mammedov <imammedo@redhat.com>, xen-devel@lists.xenproject.org, Aleksandar Markovic <amarkovic@wavecomp.com>, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>, Fam Zheng <famz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Anthony Perard <anthony.perard@citrix.com>, Aurelien Jarno <aurelien@aurel32.net>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>, Gerd Hoffmann <kraxel@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-trivial@nongnu.org, Riku Voipio <riku.voipio@iki.fi>, Eduardo Habkost <ehabkost@redhat.com>

The following changes since commit 808ebd66e467f77c0d1f8c6346235f81e9c99cf2:

  Merge remote-tracking branch 'remotes/riscv/tags/riscv-for-master-3.1-sf0' into staging (2018-10-25 17:41:03 +0100)

are available in the Git repository at:

  git://github.com/vivier/qemu.git tags/trivial-patches-pull-request

for you to fetch changes up to 4b03da6e87c34793137a231b558231fd406c05e8:

  ppc: move at24c to its own CONFIG_ symbol (2018-10-26 17:17:32 +0200)

----------------------------------------------------------------
QEMU trivial patches collected between June and October 2018
(Thank you to Thomas Huth)

----------------------------------------------------------------

Cleber Rosa (6):
  tests/tcg/README: fix location for lm32 tests
  qemu-iotests: fix filename containing checks
  docs/devel/testing.rst: add missing newlines after code block
  scripts/decodetree.py: remove unused imports
  scripts/qemu.py: remove trailing quotes on docstring
  qemu-iotests: make 218 executable

Emilio G. Cota (1):
  linux-user: fix comment s/atomic_write/atomic_set/

Li Qiang (2):
  memory.h: fix typos in comments
  cpu.h: fix a typo in comment

Paolo Bonzini (1):
  ppc: move at24c to its own CONFIG_ symbol

Philippe Mathieu-Daudé (6):
  qobject: Catch another straggler for use of qdict_put_str()
  xen: Use the PCI_DEVICE macro
  tests/bios-tables-test: Remove an useless cast
  hw/pci-host: Remove useless parenthesis around DIV_ROUND_UP macro
  hw/intc/gicv3: Remove useless parenthesis around DIV_ROUND_UP macro
  milkymist-minimac2: Use qemu_log_mask(GUEST_ERROR) instead of
    error_report

Stefan Weil (2):
  tests: Fix typos in comments and help message (found by codespell)
  configure: Support pkg-config for zlib

Thomas Huth (1):
  configs/alpha: Remove unused CONFIG_PARALLEL_ISA switch

yuchenlin (1):
  vga_int: remove unused function protype

 configure                             | 40 +++++++++++++++------------
 default-configs/alpha-softmmu.mak     |  1 -
 default-configs/ppc-softmmu.mak       |  1 +
 docs/devel/testing.rst                |  2 ++
 hw/display/vga_int.h                  |  1 -
 hw/net/milkymist-minimac2.c           | 14 ++++++----
 hw/nvram/Makefile.objs                |  2 +-
 hw/pci-host/piix.c                    |  2 +-
 hw/pci-host/q35.c                     |  2 +-
 hw/xen/xen_pt_config_init.c           |  8 +++---
 include/exec/memory.h                 |  6 ++--
 include/hw/intc/arm_gicv3_common.h    |  2 +-
 include/qom/cpu.h                     |  2 +-
 linux-user/qemu.h                     |  2 +-
 qobject/block-qdict.c                 |  2 +-
 scripts/decodetree.py                 |  2 --
 scripts/qemu.py                       |  2 +-
 tests/bios-tables-test.c              |  4 +--
 tests/docker/Makefile.include         |  2 +-
 tests/docker/docker.py                |  4 +--
 tests/guest-debug/test-gdbstub.py     |  2 +-
 tests/qemu-iotests/218                |  0
 tests/qemu-iotests/common.qemu        |  2 +-
 tests/qemu-iotests/common.rc          |  4 +--
 tests/tcg/Makefile.include            |  2 +-
 tests/tcg/Makefile.probe              |  2 +-
 tests/tcg/README                      |  2 +-
 tests/tcg/mips/mips64-dsp/subq_s_pw.c |  2 +-
 28 files changed, 63 insertions(+), 54 deletions(-)
 mode change 100644 => 100755 tests/qemu-iotests/218

-- 
2.17.2

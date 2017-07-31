Received: from eggs.gnu.org ([2001:4830:134:3::10]:50906)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dc7pd-00046t-VT
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 06:21:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dc7pb-000695-0I
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 06:21:49 -0400
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Mon, 31 Jul 2017 13:21:19 +0300
Message-Id: <cover.1501496349.git.mjt@msgid.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/25 for-2.10] Trivial patches for 2017-07-31
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-trivial@nongnu.org

Here's a collection of trivial stuff merged to date.
A few minor cleanups, older tests trivial fixes, changing
crash to clean exit for unicore32 and tricore, and many
small documentation fixes mostly by Philippe Mathieu-Daud=C3=A9.

Please consider applying.

Thanks,

/mjt

The following changes since commit 0c26c080ee592ea47597d3ab8fd712d7d2c4ba=
0f:

  Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-2.10-2017073=
1' into staging (2017-07-31 09:59:26 +0100)

are available in the git repository at:

  git://git.corpit.ru/qemu.git tags/trivial-patches-fetch

for you to fetch changes up to 25e11d8774630600ef4c5e9906419a77163a28a1:

  docs: fix broken paths to docs/specs/ivshmem-spec.txt (2017-07-31 13:13=
:01 +0300)

----------------------------------------------------------------
trivial patches for 2017-07-31

----------------------------------------------------------------
Cleber Rosa (1):
      docs: fix broken paths to docs/interop dir

Eduardo Otubo (2):
      fix qemu-system-unicore32 crashing when calling without -kernel
      qemu-system-tricore: segfault when entering "x 0" on the monitor

Marc-Andr=C3=A9 Lureau (3):
      tests: check-qom-proplist: fix leak
      tests: test-netfilter && pxe-test require slirp
      build-sys: there is no qemu-ga.c

Philippe Mathieu-Daud=C3=A9 (18):
      tests: add missing dependency to build QTEST_QEMU_BINARY
      loader: check get_image_size() return value
      ivshmem: fix incorrect error handling in ivshmem_recv_msg()
      qcow2: fix null pointer dereference
      ui/vnc: fix leak of SocketAddress **
      net/eth: fix incorrect check of iov_to_buf() return value
      m68k/translate: fix incorrect copy/paste
      linux-user/sh4: fix incorrect memory write
      syscall: fix dereference of undefined pointer
      syscall: fix use of uninitialized values
      syscall: check inotify() and eventfd() return value
      thunk: assert nb_fields is valid
      docs: fix broken paths to docs/interop/qcow2.txt
      docs: fix broken paths to docs/devel/qapi-code-gen.txt
      docs: fix broken paths to docs/devel/atomics.txt
      docs: fix broken paths to docs/devel/tracing.txt
      docs: fix broken paths to docs/config/ich9-ehci-uhci.cfg
      docs: fix broken paths to docs/specs/ivshmem-spec.txt

Thomas Huth (1):
      MAINTAINERS: Improve the NetBSD regex pattern

 MAINTAINERS                         |  2 +-
 Makefile                            |  2 +-
 audio/trace-events                  |  2 +-
 block/qcow2-refcount.c              |  4 ++--
 block/trace-events                  |  2 +-
 chardev/trace-events                |  2 +-
 crypto/trace-events                 |  2 +-
 docs/devel/lockcnt.txt              |  2 +-
 docs/devel/writing-qmp-commands.txt |  4 ++--
 docs/qcow2-cache.txt                |  2 +-
 docs/specs/pci-ids.txt              |  2 +-
 docs/usb2.txt                       |  2 +-
 hw/9pfs/trace-events                |  2 +-
 hw/acpi/trace-events                |  2 +-
 hw/alpha/trace-events               |  2 +-
 hw/arm/trace-events                 |  2 +-
 hw/audio/trace-events               |  2 +-
 hw/block/dataplane/trace-events     |  2 +-
 hw/block/trace-events               |  2 +-
 hw/char/trace-events                |  2 +-
 hw/core/loader.c                    |  4 ++--
 hw/display/trace-events             |  2 +-
 hw/dma/trace-events                 |  2 +-
 hw/i386/trace-events                |  2 +-
 hw/input/trace-events               |  2 +-
 hw/intc/trace-events                |  2 +-
 hw/isa/trace-events                 |  2 +-
 hw/mem/trace-events                 |  2 +-
 hw/misc/ivshmem.c                   |  5 ++++-
 hw/misc/trace-events                |  2 +-
 hw/net/trace-events                 |  2 +-
 hw/nvram/trace-events               |  2 +-
 hw/pci/trace-events                 |  2 +-
 hw/ppc/trace-events                 |  2 +-
 hw/s390x/trace-events               |  2 +-
 hw/scsi/trace-events                |  2 +-
 hw/sd/trace-events                  |  2 +-
 hw/sparc/trace-events               |  2 +-
 hw/timer/trace-events               |  2 +-
 hw/unicore32/puv3.c                 |  5 ++++-
 hw/usb/trace-events                 |  2 +-
 hw/vfio/trace-events                |  2 +-
 hw/virtio/trace-events              |  2 +-
 hw/xen/trace-events                 |  2 +-
 include/qapi/visitor.h              |  2 +-
 include/qemu/atomic.h               |  4 ++--
 io/trace-events                     |  2 +-
 linux-user/elfload.c                |  2 +-
 linux-user/syscall.c                | 18 ++++++++++++++----
 linux-user/trace-events             |  2 +-
 migration/trace-events              |  2 +-
 net/eth.c                           |  4 ++--
 net/trace-events                    |  2 +-
 qapi-schema.json                    |  4 ++--
 qapi/introspect.json                |  2 +-
 qapi/qapi-util.c                    |  2 +-
 qom/trace-events                    |  2 +-
 scripts/qapi2texi.py                |  2 +-
 scripts/simpletrace.py              |  2 +-
 target/arm/trace-events             |  2 +-
 target/i386/trace-events            |  2 +-
 target/m68k/translate.c             |  2 +-
 target/mips/trace-events            |  2 +-
 target/ppc/trace-events             |  2 +-
 target/s390x/trace-events           |  2 +-
 target/sparc/trace-events           |  2 +-
 target/tricore/cpu.c                | 10 ++++++++++
 tcg/README                          |  2 +-
 tests/Makefile.include              | 10 +++++-----
 tests/check-qom-proplist.c          |  2 ++
 thunk.c                             |  3 ++-
 ui/trace-events                     |  2 +-
 ui/vnc.c                            | 36 ++++++++++++++++++-------------=
-----
 util/trace-events                   |  2 +-
 74 files changed, 131 insertions(+), 102 deletions(-)

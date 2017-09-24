Received: from eggs.gnu.org ([2001:4830:134:3::10]:43236)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dwEMd-0008PV-OD
	for qemu-devel@nongnu.org; Sun, 24 Sep 2017 17:23:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dwEMZ-00048t-Rt
	for qemu-devel@nongnu.org; Sun, 24 Sep 2017 17:22:59 -0400
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Mon, 25 Sep 2017 00:22:18 +0300
Message-Id: <cover.1506288070.git.mjt@msgid.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/31] Trivial patches for 2017-09-25
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

This is a collection of trivial stuff collected for quite some time.
It includes various stuff, and just one series from
Philippe Mathieu-Daud=C3=A9 (MAINTAINERS update), - other his series are
in the works.

Thanks,

/mjt

The following changes since commit 460b6c8e581aa06b86f59eebd9e52edfe7adf4=
17:

  Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into s=
taging (2017-09-23 12:55:40 +0100)

are available in the git repository at:

  git://git.corpit.ru/qemu.git tags/trivial-patches-fetch

for you to fetch changes up to 97fb016a2aae686098f01d1c2dc194ed0f8e1c36:

  hw/isa/pc87312: Mark the device with user_creatable =3D false (2017-09-=
25 00:09:11 +0300)

----------------------------------------------------------------
trivial patches for 2017-09-25

----------------------------------------------------------------
Alistair Francis (1):
      target/xtensa: Use the pre-defined MEMTXATTRS_UNSPECIFIED macro

Eduardo Otubo (2):
      filter-mirror: segfault when specifying non existent device
      dma/i82374: avoid double creation of i82374 device

Eric Blake (2):
      osdep: Fix ROUND_UP(64-bit, 32-bit)
      nbd-client: Use correct macro parenthesization

KONRAD Frederic (1):
      aux-to-i2c-bridge: don't allow user to create one

Kamil Rytarowski (2):
      Replace round_page() with TARGET_PAGE_ALIGN()
      Drop gld linker usage on SunOS

Liang Yan (2):
      hw/display/xenfb.c: Add trace_xenfb_key_event
      chardev/baum: fix baum that releases brlapi twice

Michael Tokarev (1):
      remove trailing whitespace from qemu-options.hx

Peter Maydell (1):
      util/qemu-thread-posix.c: Replace OS ifdefs with CONFIG_HAVE_SEM_TI=
MEDWAIT

Philippe Mathieu-Daud=C3=A9 (14):
      MAINTAINERS: add missing ARM entries
      MAINTAINERS: add missing STM32 entry
      MAINTAINERS: add missing entry for vhost
      MAINTAINERS: add missing VMWare entry
      MAINTAINERS: add missing Guest Agent entries
      MAINTAINERS: add missing qcow2 entry
      MAINTAINERS: add missing PCI entries
      MAINTAINERS: add missing SSI entries
      MAINTAINERS: add missing entries for throttling infra
      MAINTAINERS: add missing AIO entry
      MAINTAINERS: add missing entry for Generic Loader
      MAINTAINERS: add missing Cryptography entry
      MAINTAINERS: update docs/devel/ entries
      MAINTAINERS: update docs/interop/ entries

Stefan Weil (1):
      configure: Remove unused code (found by shellcheck)

Thomas Huth (4):
      trivial: Add missing "-m" parameter in docs/memory-hotplug.txt
      hw/display/virtio-gpu: Put the virtio-gpu-device into the display c=
ategory
      tests/boot-sector: Increase timeout to 600 seconds
      hw/isa/pc87312: Mark the device with user_creatable =3D false

 MAINTAINERS                 | 42 ++++++++++++++++++++++++++++++++-------=
---
 block/nbd-client.c          |  4 ++--
 chardev/baum.c              |  1 +
 configure                   | 17 +++++++++++++++--
 docs/memory-hotplug.txt     |  2 +-
 hw/display/trace-events     |  1 +
 hw/display/virtio-gpu.c     |  1 +
 hw/display/xenfb.c          |  1 +
 hw/dma/i82374.c             |  5 +++++
 hw/isa/pc87312.c            |  2 ++
 hw/misc/auxbus.c            | 11 +++++++++++
 hw/ppc/mac_newworld.c       | 11 +++--------
 hw/ppc/mac_oldworld.c       | 11 +++--------
 include/qemu/osdep.h        |  6 +++---
 include/qemu/thread-posix.h |  2 +-
 net/filter-mirror.c         | 14 +++++++++++---
 qemu-options.hx             |  4 ++--
 target/xtensa/op_helper.c   |  4 ++--
 tests/boot-sector.c         |  4 ++--
 util/qemu-thread-posix.c    | 10 +++++-----
 20 files changed, 104 insertions(+), 49 deletions(-)

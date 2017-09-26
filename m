Received: from eggs.gnu.org ([2001:4830:134:3::10]:37146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dwj8w-00064y-O7
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 02:14:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dwj8s-0003Zt-NL
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 02:14:54 -0400
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Tue, 26 Sep 2017 09:14:44 +0300
Message-Id: <cover.1506406399.git.mjt@msgid.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/29] Trivial patches for 2017-09-26
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

This is a resend of yesterday's pull request, with two patches
removed:
  filter-mirror: segfault when specifying non existent device
    (causes testsuite to fail)
  dma/i82374: avoid double creation of i82374 device
    (better version is in the work)

and with one patch with additional R-b line:
  remove trailing whitespace from qemu-options.hx

Not resending any patches, just the cover letter.

Please consider applying.

Thanks,

/mjt

The following changes since commit 1e3ee834083227f552179f6e43902cba5a866e=
6b:

  Merge remote-tracking branch 'remotes/thibault/tags/samuel-thibault' in=
to staging (2017-09-25 20:31:24 +0100)

are available in the git repository at:

  git://git.corpit.ru/qemu.git tags/trivial-patches-fetch

for you to fetch changes up to 35deebb2327227d8c5f4816476befb06f6329de6:

  hw/isa/pc87312: Mark the device with user_creatable =3D false (2017-09-=
26 09:11:23 +0300)

----------------------------------------------------------------
trivial patches for 2017-09-26

----------------------------------------------------------------
Alistair Francis (1):
      target/xtensa: Use the pre-defined MEMTXATTRS_UNSPECIFIED macro

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
 hw/isa/pc87312.c            |  2 ++
 hw/misc/auxbus.c            | 11 +++++++++++
 hw/ppc/mac_newworld.c       | 11 +++--------
 hw/ppc/mac_oldworld.c       | 11 +++--------
 include/qemu/osdep.h        |  6 +++---
 include/qemu/thread-posix.h |  2 +-
 qemu-options.hx             |  4 ++--
 target/xtensa/op_helper.c   |  4 ++--
 tests/boot-sector.c         |  4 ++--
 util/qemu-thread-posix.c    | 10 +++++-----
 18 files changed, 88 insertions(+), 46 deletions(-)

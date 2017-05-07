Received: from eggs.gnu.org ([2001:4830:134:3::10]:54094)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1d7GJj-0005jP-5F
	for qemu-devel@nongnu.org; Sun, 07 May 2017 03:09:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1d7GJg-0000Ho-6W
	for qemu-devel@nongnu.org; Sun, 07 May 2017 03:09:19 -0400
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Sun,  7 May 2017 10:02:03 +0300
Message-Id: <cover.1494140527.git.mjt@msgid.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/23] Trivial patches for 2017-05-07
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

The following changes since commit 12a95f320a36ef66f724a49bb05e4fb553ac5d=
be:

  Merge remote-tracking branch 'kwolf/tags/for-upstream' into staging (20=
17-05-04 13:44:32 +0100)

are available in the git repository at:

  git://git.corpit.ru/qemu.git tags/trivial-patches-fetch

for you to fetch changes up to 311875781e549af91a3216d34c6ef40420bab435:

  tests: Remove redundant assignment (2017-05-07 09:57:51 +0300)

----------------------------------------------------------------
trivial patches for 2017-05-07

----------------------------------------------------------------
Andreas Grapentin (1):
      use _Static_assert in QEMU_BUILD_BUG_ON

Chris Webb (1):
      virtfs: allow a device id to be specified in the -virtfs option

Craig Jellick (1):
      Add 'none' as type for drive's if option

Eric Blake (2):
      tests: Ignore more test executables
      tests: Ignore another built executable (test-hmp)

Fam Zheng (3):
      block: Make 'replication_state' an enum
      virtio-blk: Remove useless condition around g_free()
      tests: Remove redundant assignment

Ishani Chugh (1):
      Remove reduntant qemu: from error functions

KONRAD Frederic (1):
      ppc_booke: drop useless assignment

Kamil Rytarowski (2):
      scripts/qemu-binfmt-conf.sh: Fix shell portability issue
      scripts: Switch to more portable Perl shebang

Marc-Andr=C3=A9 Lureau (1):
      doc: fix function spelling

Paolo Bonzini (3):
      jazz_led: fix bad snprintf
      MAINTAINERS: Update paths for main loop
      MAINTAINERS: Update paths for AioContext implementation

Philippe Mathieu-Daud=C3=A9 (3):
      usb-ccid: make ccid_write_data_block() cope with null buffers
      device_tree: fix compiler warnings (clang 5)
      qga: fix compiler warnings (clang 5)

Saurav Sachidanand (1):
      util: Use g_malloc/g_free in envlist.c

Thomas Huth (2):
      qemu-doc: Fix broken URLs of amnhltm.zip and dosidle210.zip
      hw/core/generic-loader: Fix crash when running without CPU

sochin.jiang fix wrong parameter comments in channel-file.h (1):
      channel-file: fix wrong parameter comments

 MAINTAINERS                     |  8 +++----
 block/replication.c             | 44 +++++++++++++++++++----------------=
---
 bsd-user/main.c                 | 14 ++++--------
 configure                       | 18 ++++++++++++++++
 device_tree.c                   |  1 +
 hw/block/virtio-blk.c           |  4 +---
 hw/core/generic-loader.c        |  9 ++++----
 hw/display/jazz_led.c           |  4 ++--
 hw/microblaze/boot.c            |  2 +-
 hw/nios2/boot.c                 |  2 +-
 hw/ppc/pnv.c                    |  2 +-
 hw/ppc/ppc_booke.c              |  1 -
 hw/s390x/sclp.c                 |  4 ++--
 hw/tricore/tricore_testboard.c  |  2 +-
 hw/usb/dev-smartcard-reader.c   |  5 ++++-
 include/io/channel-file.h       |  2 +-
 include/io/channel.h            |  2 +-
 include/qemu/compiler.h         |  4 +++-
 linux-user/main.c               |  9 +++-----
 numa.c                          |  4 ++--
 qemu-doc.texi                   | 10 ++++-----
 qemu-options.hx                 |  4 ++--
 qga/commands-posix.c            |  8 ++++---
 scripts/checkpatch.pl           |  3 ++-
 scripts/clean-header-guards.pl  |  3 ++-
 scripts/cleanup-trace-events.pl |  2 +-
 scripts/disas-objdump.pl        |  4 +++-
 scripts/get_maintainer.pl       |  3 ++-
 scripts/qemu-binfmt-conf.sh     |  4 ++--
 scripts/shaderinclude.pl        |  2 +-
 scripts/switch-timer-api        |  2 +-
 scripts/texi2pod.pl             |  4 +++-
 tests/.gitignore                |  4 ++++
 tests/postcopy-test.c           |  2 +-
 util/envlist.c                  | 47 +++++++++++++++++------------------=
------
 vl.c                            |  5 +++--
 36 files changed, 133 insertions(+), 115 deletions(-)

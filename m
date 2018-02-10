Received: from eggs.gnu.org ([2001:4830:134:3::10]:43945)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1ekQ0F-0002e9-Uk
	for qemu-devel@nongnu.org; Sat, 10 Feb 2018 02:55:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1ekQ0C-0000eF-04
	for qemu-devel@nongnu.org; Sat, 10 Feb 2018 02:55:19 -0500
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Sat, 10 Feb 2018 10:54:55 +0300
Message-Id: <cover.1518249254.git.mjt@msgid.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/17] Trivial patches for 2018-02-10
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

Here's a next pull request for the trivial-patches tree.
After a very long delay.

Hopefully I still remember how to apply patches :)

The following changes since commit c7b02d7d032d6022060e4b393827c963c93ce6=
3f:

  Merge remote-tracking branch 'remotes/stsquad/tags/pull-travis-speedup-=
090218-1' into staging (2018-02-09 16:12:34 +0000)

are available in the git repository at:

  git://git.corpit.ru/qemu.git tags/trivial-patches-fetch

for you to fetch changes up to d40d74a645feea0ad01482da2358804f6574dce0:

  tests/qapi: use ARRAY_SIZE macro (2018-02-10 10:45:14 +0300)

----------------------------------------------------------------
trivial patches for 2018-02-10

----------------------------------------------------------------
Alexey Kardashevskiy (2):
      machine: Polish -machine xxx,help
      configure: Allow capstone=3Dgit only if git update is not disabled

Andreas Gustafsson (1):
      oslib-posix: check for posix_memalign in configure script

Cole Robinson (1):
      scripts/make-release: Don't archive .git files

Daniel P. Berrang=C3=A9 (1):
      mailmap: set preferred spelling for Daniel Berrang=C3=A9

Eric Blake (2):
      Drop unneeded system header includes
      maint: Mention web site maintenance in README

Laurent Vivier (1):
      build: fix typo in error message

Michael Tokarev (2):
      qapi-schema.json: spelling (independant comparation)
      scripts/argparse.py: spelling (independant)

Philippe Mathieu-Daud=C3=A9 (5):
      qga: use ARRAY_SIZE macro
      async: use ARRAY_SIZE macro
      tests/hbitmap: use ARRAY_SIZE macro
      tests/qapi: use QEMU_IS_ALIGNED macro
      tests/qapi: use ARRAY_SIZE macro

Thomas Huth (2):
      qemu-options.hx: Remove confusing spaces in parameter listings
      MAINTAINERS: Add qemu-binfmt-conf.sh script

 .mailmap                            |  4 ++++
 MAINTAINERS                         |  1 +
 README                              |  4 ++++
 configure                           | 21 +++++++++++++++-
 hw/core/machine.c                   |  2 +-
 qapi-schema.json                    |  4 ++--
 qemu-options.hx                     | 48 ++++++++++++++++++-------------=
------
 qga/commands-posix.c                |  2 +-
 scripts/argparse.py                 |  2 +-
 scripts/git-submodule.sh            |  2 +-
 scripts/make-release                |  5 ++--
 target/i386/hax-windows.h           |  2 --
 target/i386/hvf/x86_mmu.c           |  1 -
 tests/test-hbitmap.c                |  6 ++---
 tests/test-qobject-output-visitor.c |  2 +-
 tests/test-string-output-visitor.c  |  2 +-
 util/aio-posix.c                    |  2 +-
 util/oslib-posix.c                  |  2 +-
 18 files changed, 68 insertions(+), 44 deletions(-)

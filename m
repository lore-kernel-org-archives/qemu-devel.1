Received: from eggs.gnu.org ([2001:4830:134:3::10]:49352)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1e4C57-0000q2-I7
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 16:33:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1e4C54-0001wz-2e
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 16:33:49 -0400
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Mon, 16 Oct 2017 23:33:27 +0300
Message-Id: <cover.1508185933.git.mjt@msgid.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/14] Trivial patches for 2017-10-16
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

Here's a set of trivial changes accumulated so far.
Not including large series by Philippe Mathieu-Daud=C3=A9.

The following changes since commit c5bbcaa4b7c0f8a322bebe9ec563560178a68b=
55:

  Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into stagi=
ng (2017-10-16 17:29:16 +0100)

are available in the git repository at:

  git://git.corpit.ru/qemu.git tags/trivial-patches-fetch

for you to fetch changes up to 6b4f250bfc529bdf73a10ca6873a460175e666cc:

  Add myself as maintainer for TPM code (2017-10-16 23:17:44 +0300)

----------------------------------------------------------------
trivial patches for 2017-10-16

----------------------------------------------------------------
Anthony PERARD (1):
      ui/gtk: Fix deprecation of vte_terminal_copy_clipboard

Carlo Marcelo Arenas Bel=C3=B3n (2):
      linux-user: remove duplicate break in syscall
      gitignore: ignore check-qlit test

Eduardo Otubo (1):
      filter-mirror: segfault when specifying non existent device

Emilio G. Cota (1):
      futex: add missing header guards

Fam Zheng (3):
      MAINTAINERS: Clean up SCSI device section
      MAINTAINERS: Fix Sun4v file
      MAINTAINERS: Track default-configs/pci.mak

Marco A L Barbosa (1):
      linux-user: Add some random ioctls

Markus Armbruster (1):
      os-posix: Drop misleading comment

Michael Tokarev (1):
      qemu-doc.texi: remove trailing whitespace

Peter Maydell (1):
      include/hw/or-irq.h: Drop unused in_irqs field

Stefan Berger (1):
      Add myself as maintainer for TPM code

Stefan Weil (1):
      io: Add missing GCC_FMT_ATTR (fix -Werror=3Dsuggest-attribute=3Dfor=
mat)

 MAINTAINERS               | 13 +++++--------
 include/hw/or-irq.h       |  1 -
 include/qemu/futex.h      |  5 +++++
 io/channel-websock.c      |  7 ++++---
 linux-user/ioctls.h       |  5 +++++
 linux-user/syscall.c      |  2 +-
 linux-user/syscall_defs.h |  7 +++++++
 net/filter-mirror.c       |  6 ++++++
 os-posix.c                |  1 -
 qemu-doc.texi             |  2 +-
 tests/.gitignore          |  1 +
 ui/gtk.c                  |  5 +++++
 12 files changed, 40 insertions(+), 15 deletions(-)

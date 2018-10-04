Received: from eggs.gnu.org ([2001:4830:134:3::10]:46193)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1g86LF-0005XO-MA
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 12:19:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1g86LA-0002UI-2R
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 12:19:07 -0400
From: Cleber Rosa <crosa@redhat.com>
Date: Thu,  4 Oct 2018 12:18:42 -0400
Message-Id: <20181004161852.11673-1-crosa@redhat.com>
Subject: [Qemu-devel] [PATCH 00/10] Trivial fixes and clean ups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>, Cleber Rosa <crosa@redhat.com>, qemu-trivial@nongnu.org, Max Reitz <mreitz@redhat.com>

Just a collection of trivial fixes and clean ups that have been lying
around here for some time.

Cleber Rosa (10):
  qemu-img.c: comment typo fix
  tests/tcg/README: fix location for lm32 tests
  qemu-iotests: make 218 executable
  qemu-iotests: fix filename containing checks
  docs/devel/testing.rst: add missing newlines after code block
  thunk.c: clean up commented out definition
  scripts/decodetree.py: remove unused imports
  scripts/decodetree.py: fix reference to attributes
  scripts/qemu.py: use a more consistent docstring style
  scripts/qemu.py: remove trailing quotes on docstring

 docs/devel/testing.rst       |  2 ++
 dtc                          |  2 +-
 qemu-img.c                   |  2 +-
 scripts/decodetree.py        |  4 +--
 scripts/qemu.py              | 67 ++++++++++++++++++++++--------------
 tests/qemu-iotests/218       |  0
 tests/qemu-iotests/common.rc |  4 +--
 tests/tcg/README             |  2 +-
 thunk.c                      |  2 --
 9 files changed, 50 insertions(+), 35 deletions(-)
 mode change 100644 => 100755 tests/qemu-iotests/218

-- 
2.17.1

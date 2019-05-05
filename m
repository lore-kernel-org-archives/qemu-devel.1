Received: from eggs.gnu.org ([209.51.188.92]:35782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hNPQp-00048h-Dv
	for qemu-devel@nongnu.org; Sun, 05 May 2019 18:16:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hNPQj-00080n-6S
	for qemu-devel@nongnu.org; Sun, 05 May 2019 18:16:23 -0400
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Mon,  6 May 2019 00:15:31 +0200
Message-Id: <20190505221544.31568-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 00/13] hw/block/pflash_cfi02: Clean-up and fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Stephen Checkoway <stephen.checkoway@oberlin.edu>
Cc: Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>, Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

Hi,

While reviewing Stephen Checkoway's v4 "Implement missing AMD
pflash functionality" [*] I found it hard (for me) to digest,
so I took step by step notes. This series is the result of
those notes.
Regarding Stephen's series, this series only contains the
generic code movement and trivial cleanup. The other patches
are rather dense and I need more time to study the specs.

Stephen: If you take out the patch #2 ("Use the GLib API"),
you can rebase your series on top of this.
I'd appreciate if you can adapt your tests to use the GLib
functions, else I plan to do it later.

Regards,

Phil.

[*] https://lists.gnu.org/archive/html/qemu-devel/2019-04/msg04595.html

Philippe Mathieu-Daud=C3=A9 (10):
  tests/pflash-cfi02: Use the GLib API
  tests/pflash-cfi02: Use IEC binary prefixes for size constants
  hw/block/pflash_cfi02: Fix debug format string
  hw/block/pflash_cfi02: Add an enum to define the write cycles
  hw/block/pflash_cfi02: Add helpers to manipulate the status bits
  hw/block/pflash_cfi02: Simplify a statement using fall through
  hw/block/pflash_cfi02: Use the ldst API in pflash_write()
  hw/block/pflash_cfi02: Use the ldst API in pflash_read()
  hw/block/pflash_cfi02: Extract the pflash_data_read() function
  hw/block/pflash_cfi02: Unify the MemoryRegionOps

Stephen Checkoway (3):
  tests/pflash-cfi02: Add test for supported CFI commands
  hw/block/pflash_cfi02: Fix command address comparison
  hw/block/pflash_cfi02: Use the chip erase time specified in the CFI
    table

 hw/block/pflash_cfi02.c   | 234 +++++++++++++++++---------------------
 tests/Makefile.include    |   2 +
 tests/pflash-cfi02-test.c | 232 +++++++++++++++++++++++++++++++++++++
 3 files changed, 339 insertions(+), 129 deletions(-)
 create mode 100644 tests/pflash-cfi02-test.c

--=20
2.20.1

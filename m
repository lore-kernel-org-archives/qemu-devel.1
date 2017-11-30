Received: from eggs.gnu.org ([2001:4830:134:3::10]:48971)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eKKat-0005AD-Jb
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 03:53:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eKKas-0006fm-J5
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 03:53:19 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Thu, 30 Nov 2017 09:53:01 +0100
Message-Id: <1512031988-32490-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.12 0/7] Test more machines and TCG CPUs
 automatically
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>, Edgar Iglesias <edgar.iglesias@gmail.com>, Anthony Green <green@moxielogic.com>

During the 2.11 development cycle, a bunch of ARM boards were broken
completely, and nobody noticed it for a couple of weeks. Also a lot
of TCG CPUs do not get any test coverage at all yet (especially since
the old tests in the tests/tcg/ are still pretty much dead today).
So we really should improve our testing in this area.

This patch series now tries to improve the test coverage at least a
little bit: The second patch adds the possibility to the boot-serial
test to also load home-brew mini-kernels and firmware blobs, and the
following patches then add some tests for various boards / CPUs with
some few lines of self-made assembly.

Thomas Huth (7):
  tests/boot-serial-test: Make sure that we check the timeout regularly
  tests/boot-serial-test: Add code to allow to specify our own kernel or
    bios
  tests/boot-serial-test: Add support for the mcf5208evb board
  tests/boot-serial-test: Add tests for microblaze boards
  hw/moxie/moxiesim: Add support for loading a BIOS on moxiesim
  tests/boot-serial-test: Add a test for the moxiesim machine
  tests/boot-serial-test: Add support for the raspi2 machine

 hw/moxie/moxiesim.c      |  12 +++++-
 tests/Makefile.include   |   7 ++++
 tests/boot-serial-test.c | 106 ++++++++++++++++++++++++++++++++++++++++-------
 3 files changed, 109 insertions(+), 16 deletions(-)

-- 
1.8.3.1

Received: from eggs.gnu.org ([2001:4830:134:3::10]:42959)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1cibX1-0001oC-Lc
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 01:45:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1cibWy-0003Dy-Ke
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 01:45:07 -0500
From: Michael Tokarev <mjt@tls.msk.ru>
Date: Tue, 28 Feb 2017 09:44:43 +0300
Message-Id: <cover.1488264243.git.mjt@msgid.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/14] Trivial patches for 2017-02-28
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

This is yet another trivial patches pull request.
Please consider applying/pulling.

The following changes since commit 8f2d7c341184a95d05476ea3c45dbae2b9ddbe=
51:

  Merge remote-tracking branch 'remotes/berrange/tags/pull-qcrypto-2017-0=
2-27-1' into staging (2017-02-27 15:33:21 +0000)

are available in the git repository at:

  git://git.corpit.ru/qemu.git tags/trivial-patches-fetch

for you to fetch changes up to f5507e0448bd34473af72509297617a783049024:

  syscall: fixed mincore(2) not failing with ENOMEM (2017-02-28 09:03:39 =
+0300)

----------------------------------------------------------------
trivial patches for 2017-02-28

----------------------------------------------------------------
Fam Zheng (1):
      cadence_gem: Remove unused parameter debug message

Franklin \"Snaipe\" Mathieu (1):
      syscall: fixed mincore(2) not failing with ENOMEM

Igor Pavlikevich (1):
      hw/acpi/tco.c: fix tco timer stop

John Snow (1):
      ide: remove undefined behavior in ide-test

Marc-Andr=C3=A9 Lureau (1):
      Update copyright year

Peter Maydell (3):
      softfloat: Use correct type in float64_to_uint64_round_to_zero()
      CODING_STYLE: Mention preferred comment form
      lm32: milkymist-tmu2: fix a third integer overflow

Philippe Mathieu-Daud=C3=A9 (1):
      register: fix incorrect read mask

Stefan Weil (1):
      target/s390x: Fix typo

Thomas Huth (3):
      hw/core/or-irq: Mark the device with cannot_instantiate_with_device=
_add_yet
      hw/core/register: Mark the device with cannot_instantiate_with_devi=
ce_add_yet
      tests/prom-env: Enable the test for the sun4u machine, too

Vincenzo Maffione (1):
      qemu-options.hx: add missing id=3Dchr0 chardev argument in vhost-us=
er example

 CODING_STYLE                |  7 +++++++
 fpu/softfloat.c             |  2 +-
 hw/acpi/tco.c               |  1 +
 hw/core/or-irq.c            |  3 +++
 hw/core/register.c          | 30 ++++++++++++++++++++++++------
 hw/display/milkymist-tmu2.c |  2 +-
 hw/net/cadence_gem.c        |  2 +-
 include/qemu-common.h       |  2 +-
 linux-user/syscall.c        | 11 ++++++++---
 qemu-options.hx             |  2 +-
 target/s390x/cpu_models.c   |  2 +-
 tests/Makefile.include      |  3 +--
 tests/ide-test.c            |  1 +
 tests/prom-env-test.c       |  2 +-
 14 files changed, 52 insertions(+), 18 deletions(-)

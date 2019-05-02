Received: from eggs.gnu.org ([209.51.188.92]:43204)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hMEKr-00046l-U3
	for qemu-devel@nongnu.org; Thu, 02 May 2019 12:13:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hMEKr-0002In-0T
	for qemu-devel@nongnu.org; Thu, 02 May 2019 12:13:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50494)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1hMEKq-0002I6-RH
	for qemu-devel@nongnu.org; Thu, 02 May 2019 12:13:24 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Thu,  2 May 2019 18:13:02 +0200
Message-Id: <20190502161310.15624-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/8] qtest and misc patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Helge Deller <deller@gmx.de>, Eduardo Otubo <otubo@redhat.com>

 Hi Peter,

the following changes since commit 8482ff2eb3bb95020eb2f370a9b3ea26511e41=
df:

  Merge remote-tracking branch 'remotes/jnsnow/tags/bitmaps-pull-request'=
 into staging (2019-05-02 12:04:51 +0100)

are available in the Git repository at:

  https://gitlab.com/huth/qemu.git tags/pull-request-2019-05-02

for you to fetch changes up to aff39be0ed9753c9c323f64a14f5533dd5c43525:

  hw/pci-host: Use object_initialize_child for correct reference counting=
 (2019-05-02 16:56:33 +0200)

----------------------------------------------------------------
- Move qtest accel code to accel/qtest.c, get rid of AccelClass->availabl=
e
- Test TCG interpreter in gitlab-ci
- Small improvements to the configure script
- Use object_initialize_child in hw/pci-host
----------------------------------------------------------------

Eduardo Habkost (3):
      qtest: Move accel code to accel/qtest.c
      qtest: Don't compile qtest accel on non-POSIX systems
      accel: Remove unused AccelClass::available field

Helge Deller (1):
      configure: Relax check for libseccomp

Thomas Huth (4):
      gitlab-ci.yml: Test the TCG interpreter in a CI pipeline
      configure: Add -Wno-typedef-redefinition to CFLAGS (for Clang)
      configure: Remove old *-config-devices.mak.d files when running con=
figure
      hw/pci-host: Use object_initialize_child for correct reference coun=
ting

 .gitlab-ci.yml            | 15 +++++++++++++
 MAINTAINERS               |  1 +
 accel/Makefile.objs       |  1 +
 accel/accel.c             |  5 -----
 accel/qtest.c             | 54 +++++++++++++++++++++++++++++++++++++++++=
++++++
 configure                 | 33 +++++++----------------------
 hw/pci-host/designware.c  |  4 ++--
 hw/pci-host/gpex.c        |  5 +++--
 hw/pci-host/q35.c         |  4 ++--
 hw/pci-host/xilinx-pcie.c |  4 ++--
 include/sysemu/accel.h    |  1 -
 include/sysemu/qtest.h    |  9 --------
 qtest.c                   | 34 -----------------------------
 13 files changed, 88 insertions(+), 82 deletions(-)
 create mode 100644 accel/qtest.c

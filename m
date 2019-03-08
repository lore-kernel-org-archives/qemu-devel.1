Received: from eggs.gnu.org ([209.51.188.92]:36810)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1h2Bem-0005YJ-7l
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 04:19:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1h2Bej-0008Oa-HG
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 04:19:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48112)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1h2Bej-0008MV-7l
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 04:19:05 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Fri,  8 Mar 2019 10:18:36 +0100
Message-Id: <1552036723-1949-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/7] qtests, clean-ups and macOS CI testing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

 Hi Peter,

the following changes since commit 6cb4f6db4f4367faa33da85b15f75bbbd2bed2=
a6:

  Merge remote-tracking branch 'remotes/cleber/tags/python-next-pull-requ=
est' into staging (2019-03-07 16:16:02 +0000)

are available in the git repository at:

  https://gitlab.com/huth/qemu.git tags/pull-request-2019-03-08

for you to fetch changes up to 4966c5bd8a6ab17214f54f8016426f95303f9760:

  cirrus.yml: Add macOS continuous integration task (2019-03-08 09:54:29 =
+0100)

----------------------------------------------------------------
- qtest fixes
- Some generic clean-ups by Philippe
- macOS CI testing via cirrus-ci.com
----------------------------------------------------------------

Marc-Andr=C3=A9 Lureau (1):
      vhost-user-test: fix leaks

Philippe Mathieu-Daud=C3=A9 (4):
      tests: Move qdict-test-data.txt to tests/data/qobject/
      hw: Remove unused 'hw/devices.h' include
      hw/devices: Remove unused TC6393XB_RAM definition
      tests/bios-tables: Improve portability by searching bash in the $PA=
TH

Thomas Huth (2):
      tests: Do not use "\n" in g_test_message() strings
      cirrus.yml: Add macOS continuous integration task

 .cirrus.yml                                         | 15 +++++++++++++--
 MAINTAINERS                                         |  2 +-
 configure                                           |  2 +-
 hw/alpha/typhoon.c                                  |  1 -
 hw/arm/allwinner-a10.c                              |  1 -
 hw/arm/collie.c                                     |  1 -
 hw/arm/cubieboard.c                                 |  1 -
 hw/arm/highbank.c                                   |  1 -
 hw/arm/mps2-tz.c                                    |  1 -
 hw/arm/musicpal.c                                   |  1 -
 hw/arm/nrf51_soc.c                                  |  1 -
 hw/arm/spitz.c                                      |  1 -
 hw/arm/virt.c                                       |  1 -
 hw/arm/z2.c                                         |  1 -
 hw/display/sm501.c                                  |  1 -
 hw/hppa/dino.c                                      |  1 -
 hw/intc/allwinner-a10-pic.c                         |  1 -
 hw/lm32/lm32_boards.c                               |  1 -
 hw/lm32/milkymist.c                                 |  1 -
 hw/microblaze/petalogix_ml605_mmu.c                 |  1 -
 hw/microblaze/petalogix_s3adsp1800_mmu.c            |  1 -
 hw/net/dp8393x.c                                    |  1 -
 hw/ppc/virtex_ml507.c                               |  1 -
 hw/sh4/r2d.c                                        |  1 -
 hw/tricore/tricore_testboard.c                      |  1 -
 hw/usb/tusb6010.c                                   |  1 -
 include/hw/devices.h                                |  1 -
 tests/check-qdict.c                                 |  2 +-
 tests/data/acpi/rebuild-expected-aml.sh             |  2 +-
 qdict-test-data.txt =3D> tests/data/qobject/qdict.txt |  0
 tests/ivshmem-test.c                                |  4 ++--
 tests/m48t59-test.c                                 |  4 ++--
 tests/migration-test.c                              |  4 ++--
 tests/rtc-test.c                                    |  4 ++--
 tests/rtl8139-test.c                                |  6 +++---
 tests/test-aio-multithread.c                        |  8 ++++----
 tests/test-coroutine.c                              | 10 ++++------
 tests/vhost-user-test.c                             | 13 ++++++++-----
 38 files changed, 44 insertions(+), 56 deletions(-)
 rename qdict-test-data.txt =3D> tests/data/qobject/qdict.txt (100%)

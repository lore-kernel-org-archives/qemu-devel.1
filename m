Received: from eggs.gnu.org ([2001:4830:134:3::10]:55030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e45CM-0003F5-Jm
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 09:12:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e45CJ-00012t-DO
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 09:12:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54684)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1e45CJ-00012F-8G
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 09:12:47 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Mon, 16 Oct 2017 15:12:39 +0200
Message-Id: <1508159564-30317-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/5] m68k, qtest and config patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Dmitry Fleytman <dmitry@daynix.com>

The following changes since commit f90ea7ba7c5ae7010ee0ce062207ae42530f57=
d6:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-201=
71012' into staging (2017-10-12 17:06:50 +0100)

are available in the git repository at:

  https://github.com/huth/qemu.git tags/pull-request-2017-10-16

for you to fetch changes up to 03bf6b5c08c792f5c2b55d6038e9a6acbf43d9c3:

  default-configs: Enable CONFIG_VMXNET3_PCI only on x86 (2017-10-16 13:2=
9:49 +0200)

----------------------------------------------------------------
Some m68k, qtest and config improvements

----------------------------------------------------------------
Alistair Francis (1):
      hw/m68k: Replace fprintf(stderr, "*\n" with error_report()

Marc-Andr=C3=A9 Lureau (2):
      M68K: use g_new() family of functions
      tests: use g_new() family of functions

Thomas Huth (2):
      tests/prom-env: Bump the timeout, and test pseries only in slow mod=
e
      default-configs: Enable CONFIG_VMXNET3_PCI only on x86

 default-configs/i386-softmmu.mak   |  1 +
 default-configs/pci.mak            |  1 -
 default-configs/x86_64-softmmu.mak |  1 +
 hw/m68k/an5206.c                   |  4 ++--
 hw/m68k/mcf5206.c                  |  7 ++++---
 hw/m68k/mcf5208.c                  |  9 +++++----
 tests/ahci-test.c                  |  4 ++--
 tests/fw_cfg-test.c                |  4 ++--
 tests/libqos/ahci.c                |  2 +-
 tests/libqos/libqos.c              |  2 +-
 tests/libqos/malloc.c              |  6 +++---
 tests/libqtest.c                   |  2 +-
 tests/pc-cpu-test.c                |  2 +-
 tests/prom-env-test.c              | 14 ++++++++------
 14 files changed, 32 insertions(+), 27 deletions(-)

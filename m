Received: from eggs.gnu.org ([2001:4830:134:3::10]:45296)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dXV72-0004Jw-C8
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 12:12:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dXV6z-0001sf-75
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 12:12:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49286)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1dXV6z-0001rs-1P
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 12:12:37 -0400
From: John Snow <jsnow@redhat.com>
Date: Tue, 18 Jul 2017 12:12:26 -0400
Message-Id: <20170718161230.21917-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 0/4] Ide patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, jsnow@redhat.com

The following changes since commit 368e708b4c95501574ab11632c7a0b8bb3ddc7=
e8:

  Merge remote-tracking branch 'remotes/ehabkost/tags/x86-and-machine-pul=
l-request' into staging (2017-07-18 15:24:11 +0100)

are available in the git repository at:

  https://github.com/jnsnow/qemu.git tags/ide-pull-request

for you to fetch changes up to ff0ca962345ecdb87c331888a806cde49936fd9f:

  tests/ahci-test: Be mean with RAM (2017-07-18 11:47:57 -0400)

----------------------------------------------------------------

----------------------------------------------------------------

Dr. David Alan Gilbert (1):
  tests/ahci-test: Be mean with RAM

John Snow (3):
  ahci: add ahci_get_num_ports
  ahci: Isolate public AHCI interface
  ahci: split public and private interface

 hw/i386/pc_q35.c       |   4 +-
 hw/ide/ahci.c          |  10 +-
 hw/ide/ahci_internal.h | 359 +++++++++++++++++++++++++++++++++++++++++++=
++++++
 hw/ide/ich.c           |   2 +-
 hw/mips/boston.c       |   4 +-
 include/hw/ide/ahci.h  | 320 +------------------------------------------
 tests/ahci-test.c      |   8 +-
 7 files changed, 380 insertions(+), 327 deletions(-)
 create mode 100644 hw/ide/ahci_internal.h

--=20
2.9.4

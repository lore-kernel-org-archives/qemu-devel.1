Received: from eggs.gnu.org ([209.51.188.92]:51246)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gzKnI-0001KI-Te
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 07:28:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gzKnH-0007PU-K3
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 07:28:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49336)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gzKnH-0007LB-Bv
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 07:28:07 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Thu, 28 Feb 2019 13:27:42 +0100
Message-Id: <1551356875-30676-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/13] MAINTAINERS, test and m68k
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org

 Hi Peter,

the following changes since commit adf2e451f357e993f173ba9b4176dbf3e65fee=
7e:

  Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into sta=
ging (2019-02-26 19:04:47 +0000)

are available in the git repository at:

  https://gitlab.com/huth/qemu.git tags/pull-request-2019-02-28

for you to fetch changes up to 9f04e1d9547224a935778c1935c605d607299070:

  hw/m68k/mcf5208: Support loading of bios images (2019-02-28 12:18:18 +0=
100)

----------------------------------------------------------------
- Updates to MAINTAINERS file
- Re-enable the guest-agent test
- Add the possibility to load a bios image on the mcf5208evb machine
----------------------------------------------------------------

Philippe Mathieu-Daud=C3=A9 (10):
      MAINTAINERS: Add missing entries for the sun4u machines
      MAINTAINERS: Add missing entries for the PC machines
      MAINTAINERS: Add missing entries for the QObject section
      MAINTAINERS: Add missing test entries to the Cryptography section
      MAINTAINERS: Add an entry for the Dino machine
      MAINTAINERS: Add maintainer to the POSIX subsystem
      MAINTAINERS: Orphanize the 'GDB stub' subsystem
      MAINTAINERS: Add maintainers to the Linux subsystem
      MAINTAINERS: Add maintainer to the TCG/i386 subsystem
      tests/test-qga: Reenable guest-agent qtest

Thomas Huth (3):
      MAINTAINERS: Add some missing entries for the sun4m machine
      MAINTAINERS: Clean up the RISC-V TCG backend section
      hw/m68k/mcf5208: Support loading of bios images

 MAINTAINERS            | 53 ++++++++++++++++++++++++++++++++++++++------=
------
 hw/m68k/mcf5208.c      | 30 +++++++++++++++++++++++++++-
 tests/Makefile.include |  2 +-
 3 files changed, 71 insertions(+), 14 deletions(-)

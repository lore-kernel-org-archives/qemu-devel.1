Received: from eggs.gnu.org ([2001:4830:134:3::10]:58036)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dOWlo-0006Sy-Vn
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 18:09:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dOWlo-0007Ge-6z
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 18:09:40 -0400
From: John Snow <jsnow@redhat.com>
Date: Fri, 23 Jun 2017 18:09:23 -0400
Message-Id: <20170623220926.11479-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 0/3] AHCI: re-privatize ahci headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: f4bug@amsat.org, qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>

As reported by Philippe Mathieu-Daud=C3=A9, including AHCI headers can
quickly pull in more dependencies than is sane. To remedy this,
split the AHCI headers into public and private areas as best as we
can and move the private information back into hw/ide/.

The only code movement is performed in patch 2.
Patch 3 looks terrible, but all it is doing are two different moves,
renaming one include directive. If you have suggestions for doing
this diffstat differently, please advise.

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
 6 files changed, 376 insertions(+), 323 deletions(-)
 create mode 100644 hw/ide/ahci_internal.h

--=20
2.9.4

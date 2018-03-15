Received: from eggs.gnu.org ([2001:4830:134:3::10]:38676)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ewNdg-0007Te-8D
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 03:49:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ewNdf-0004d3-6A
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 03:49:28 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Thu, 15 Mar 2018 08:49:02 +0100
Message-Id: <1521100145-15304-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH 0/3] Add new CD-ROM related qtests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Victor Kaplansky <victork@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-block@nongnu.org, qemu-s390x@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

With one of my clean-up patches (see commit 1454509726719e0933c800), I
recently accidentially broke the "-cdrom" parameter (more precisely
"-drive if=scsi") on a couple of boards, since there was no error
detected during the "make check" regression testing. This is clearly an
indication that we are lacking tests in this area.
So this small patch series now introduces some tests for CD-ROM drives:
The first two patches introduce the possibility to check that booting
from CD-ROM drives still works fine for x86 and s390x, and the third
patch adds a test that certain machines can at least still be started
with the "-cdrom" parameter (i.e. that test would have catched the
mistake that I did with my SCSI cleanup patch).

Thomas Huth (3):
  tests/boot-sector: Add magic bytes to s390x boot code header
  tests/cdboot: Test booting from CD-ROM ISO image file
  tests/cdrom-test: Test that -cdrom parameter is working

 tests/Makefile.include |  10 ++-
 tests/boot-sector.c    |   9 ++-
 tests/cdrom-test.c     | 216 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 231 insertions(+), 4 deletions(-)
 create mode 100644 tests/cdrom-test.c

-- 
1.8.3.1

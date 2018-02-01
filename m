Received: from eggs.gnu.org ([2001:4830:134:3::10]:39727)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ehBnw-0008RF-Gw
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 05:09:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ehBnt-0001mX-Co
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 05:09:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43868)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ehBnt-0001lA-7g
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 05:09:13 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Thu,  1 Feb 2018 11:09:07 +0100
Message-Id: <1517479750-16770-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH 0/3] Add more tests to the boot-serial tester
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

First patch adds new tests for the SPARC machines, second patch
enables the Mac machines, too, and the third patch adds a test
for the brand-new hppa softmmu machine.

Thomas Huth (3):
  tests/boot-serial: Enable the boot-serial test on SPARC machines, too
  tests/boot-serial: Add tests for PowerPC Mac machines
  tests/boot-serial: Add a test for the new hppa-softmmu target

 tests/Makefile.include   | 4 ++++
 tests/boot-serial-test.c | 8 ++++++++
 2 files changed, 12 insertions(+)

-- 
1.8.3.1

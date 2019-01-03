Received: from eggs.gnu.org ([208.118.235.92]:39575)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gf0t0-0003H0-Rg
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 06:10:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gf0sx-0001xY-Pe
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 06:10:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37010)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gf0sx-0001vG-4t
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 06:09:59 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Thu,  3 Jan 2019 12:09:49 +0100
Message-Id: <1546513792-17773-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH 0/3] Kill global_qtest in endianess,
 boot-order and pnv-xscom
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

It's very cumbersome to run multiple instances of QEMU in tests where this is
required (e.g. in migration tests) when the test state is tracked in a
global variable, so  we should get rid of global_qtest in the long run.
This series removes the dependency on this unwanted global_qtest variable
in the endianess-test, boot-order-test and pnv-xscom-test.

Thomas Huth (3):
  tests/endianesss: Make test independent of global_qtest
  tests/boot-order: Make test independent of global_qtest
  tests/pnv-xscom: Make test independent of global_qtest

 tests/boot-order-test.c |  59 +++++----
 tests/endianness-test.c | 329 ++++++++++++++++++++++++------------------------
 tests/pnv-xscom-test.c  |  29 ++---
 3 files changed, 210 insertions(+), 207 deletions(-)

-- 
1.8.3.1
